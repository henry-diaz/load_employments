class HomeController < ApplicationController
  http_basic_authenticate_with :name => "consultor", :password => "empleos2016", only: :index unless Rails.env.development?

  def index
    load_data
  end

  def employers
    @employers = DimEmployer.select(:nit, :name).where('name ilike ?', "%#{params[:q]}%").paginate(per_page: 30, page: params[:page])
    h = []
    @employers.each{|e| h << {id: e.nit, text: e.name } }
    render json: {items: h}
  end

  def load_data
    @times = DimTime.order(:period)
    @year_selected = true
    @custom_employers = []
    if params[:q].present?
      select_string = ''
      group_string = ''
      where_string = ''
      class_group = ''
      # group string
      case params[:q][:group_by]
        when '1'
          class_group = ', ciiu4_code'
        when '2'
          class_group = ', class_a'
        when '3'
          class_group = ', class_b'
        when '4'
          class_group = ', class_c'
        else
          class_group = ''
      end
      # show patrons
      class_group += ', name' if params[:q][:show_patron].to_i == 1
      # selected and grouped strings
      case params[:q][:times]
      when '1'
        select_string = "sector#{class_group}, year, sum(total) / max(month) as total, sum(amount) / max(month) as amount, max(pea) as pea, max(occupied) as occupied"
        group_string = "sector#{class_group}, year"
      when '2'
        select_string = "sector#{class_group}, year, sum(total) as total, sum(amount) as amount, max(pea) as pea, max(occupied) as occupied"
        group_string = "sector#{class_group}, year"
      when '3'
        select_string = "sector#{class_group}, period, avg(total) as total, avg(amount) as amount, max(pea) as pea, max(occupied) as occupied"
        group_string = "sector#{class_group}, period"
        @year_selected = false
      else
        select_string = "sector#{class_group}, period, sum(total) as total, sum(amount) as amount, max(pea) as pea, max(occupied) as occupied"
        group_string = "sector#{class_group}, period"
        @year_selected = false
      end
      # time conditions
      where_string += ' period BETWEEN ' + params[:q][:start_at] + ' AND ' + params[:q][:end_at]
      # sector conditions
      where_string += ' AND sector = ' + params[:q][:sector] if params[:q][:sector].present?
      # employers conditions
      if (params[:q][:employers].size > 1 rescue false)
        @custom_employers = DimEmployer.where(nit: params[:q][:employers])
        where_string += ' AND nit IN (' +params[:q][:employers].map{|str| "'#{str}'"}.join(',')  + ')'
      end

      ###
      # Getting the source and its peculiarities
      if params[:q][:source].to_i == 0
        # DTIC
        @source = 'tic'
        where_string += ' AND source in (0, 2)'
        where_string += ' AND status = 1' if params[:q][:status].to_i == 1 # Proccess or payments conditions
        where_string += ' AND ciiu4_code IN (' + params[:q][:categories].map{|str| "'#{str}'"}.join(',')  + ')' if params[:q][:categories].size > 1
        @ciuu_categories = CiiuCategory.all
        # budget conditions
        where_string += ' AND class_a IN (' + params[:q][:budgets].map(&:to_i).join(',')  + ')' if params[:q][:budgets].size > 1
        # states conditions
        where_string += ' AND class_b IN (' + params[:q][:states].map(&:to_i).join(',')  + ')' if params[:q][:states].size > 1
        # areas conditions
        where_string += ' AND class_c IN (' + params[:q][:areas].map(&:to_i).join(',')  + ')' if params[:q][:areas].size > 1
      else
        # DAE
        @source = 'dae'
        where_string += ' AND source in (1, 2)'
        where_string += ' AND ciiu3_code IN (' + params[:q][:categories].map{|str| "'#{str}'"}.join(',')  + ')' if params[:q][:categories].size > 1
        @ciuu_categories = Ciiu3Category.all
      end

      @employments = EmpMonthMatview
                      .select(select_string)
                      .where(where_string)
                      .group(group_string)
                      .order(group_string)
      # Extract time periods
      if @year_selected
        @uniq_times = @employments.pluck(:year).uniq.sort
      else
        @uniq_times = @employments.pluck(:period).uniq.sort
      end
    else
      # Go to default values
      @employments = EmpMonthMatview
                      .select('sector, year, sum(total) / max(month) as total, sum(amount) / max(month) as amount, max(pea) as pea, max(occupied) as occupied')
                      .where(period: 201501 .. 201601)
                      .where(source: [1,2]) # Default source statistics and customs
                      .group(:sector, :year)
                      .order(:sector, :year)
      @uniq_times = @employments.pluck(:year).uniq
      @ciuu_categories = Ciiu3Category.all
    end
  end

  def export
    require 'csv'
    load_data
    csv_string = CSV.generate(col_sep: ',') do |csv|

      #### TOTAL EMPLEADOS ####
      # first the header
      header = ['NÚMERO DE EMPLEOS']
      @uniq_times.each do |t|
        header << [t]
      end
      csv << header.flatten
      # second, the sectors
      @employments.group_by{|e| e.sector}.each do |k, v|
        row = [EmpMonthMatview::SECTORS[k.to_s].upcase]
        @uniq_times.each do |t|
          employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
          if employments
            row << [employments.sum(&:total)]
          else
            row << ['']
          end
        end
        csv << row.flatten
        # detail of sectors
        if (params[:q][:group_by].to_i != 0 rescue false)
          gnumber = params[:q][:group_by].to_i
          v.group_by{ |o| gnumber == 1 ? o.ciiu_code : ( gnumber == 2 ? o.class_a : ( gnumber == 3 ? o.class_b : o.class_c ) ) }.each do |k, v|
            row = [
              (gnumber == 1 ? ciiu_categories[k.to_s] : ( gnumber == 2 ? EmpMonthMatview::BUDGETS[k] : ( gnumber == 3 ? EmpMonthMatview::STATES[k] : EmpMonthMatview::AREAS[k] ))) || 'Sin clasificar'
            ]
            @uniq_times.each_with_index do |t, i|
              employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
              if employments
                row << [employments.sum(&:total)]
              else
                row << ['']
              end
            end
            csv << row.flatten
            # Verify patrons too
            if (params[:q][:show_patron].to_i == 1 rescue false)
              v.group_by{ |o| o.name }.each do |k, v|
                row = [k]
                @uniq_times.each_with_index do |t, i|
                  employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
                  if employments
                    row << [employments.sum(&:total)]
                  else
                    row << ['']
                  end
                end
                csv << row.flatten
              end
            end
          end
        # no detail of sectors, but show the patrons
        elsif (params[:q][:show_patron].to_i == 1 rescue false)
          v.group_by{ |o| o.name }.each do |k, v|
            row = [k]
            @uniq_times.each_with_index do |t, i|
              employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
              if employments
                row << [employments.sum(&:total)]
              else
                row << ['']
              end
            end
            csv << row.flatten
          end
        end
      end
      # last the total sectors
      row = ['TOTAL DE EMPLEOS']
      @uniq_times.each do |t|
        employments = @year_selected ? @employments.select{|o| o.year.to_i == t.to_i} : @employments.select{|o| o.period.to_i == t.to_i}
        if employments
          row << [employments.sum(&:total)]
        else
          row << ['']
        end
      end
      csv << row.flatten



      #### TOTAL SALARIOS ####
      csv << ['']
      csv << ['']
      # first the header
      header = ['SALARIOS']
      @uniq_times.each do |t|
        header << [t]
      end
      csv << header.flatten
      # second, the sectors
      @employments.group_by{|e| e.sector}.each do |k, v|
        row = [EmpMonthMatview::SECTORS[k.to_s].upcase]
        @uniq_times.each do |t|
          employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
          if employments
            row << [employments.sum(&:amount).try(:round, 2)]
          else
            row << ['']
          end
        end
        csv << row.flatten
        # detail of sectors
        if (params[:q][:group_by].to_i != 0 rescue false)
          gnumber = params[:q][:group_by].to_i
          v.group_by{ |o| gnumber == 1 ? o.ciiu_code : ( gnumber == 2 ? o.class_a : ( gnumber == 3 ? o.class_b : o.class_c ) ) }.each do |k, v|
            row = [
              (gnumber == 1 ? ciiu_categories[k.to_s] : ( gnumber == 2 ? EmpMonthMatview::BUDGETS[k] : ( gnumber == 3 ? EmpMonthMatview::STATES[k] : EmpMonthMatview::AREAS[k] ))) || 'Sin clasificar'
            ]
            @uniq_times.each_with_index do |t, i|
              employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
              if employments
                row << [employments.sum(&:amount).try(:round, 2)]
              else
                row << ['']
              end
            end
            csv << row.flatten
            # Verify patrons too
            if (params[:q][:show_patron].to_i == 1 rescue false)
              v.group_by{ |o| o.name }.each do |k, v|
                row = [k]
                @uniq_times.each_with_index do |t, i|
                  employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
                  if employments
                    row << [employments.sum(&:amount).try(:round, 2)]
                  else
                    row << ['']
                  end
                end
                csv << row.flatten
              end
            end
          end
        # no detail of sectors, but show the patrons
        elsif (params[:q][:show_patron].to_i == 1 rescue false)
          v.group_by{ |o| o.name }.each do |k, v|
            row = [k]
            @uniq_times.each_with_index do |t, i|
              employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
              if employments
                row << [employments.sum(&:amount).try(:round, 2)]
              else
                row << ['']
              end
            end
            csv << row.flatten
          end
        end
      end
      # last the total sectors
      row = ['TOTAL DE SALARIOS']
      @uniq_times.each do |t|
        employments = @year_selected ? @employments.select{|o| o.year.to_i == t.to_i} : @employments.select{|o| o.period.to_i == t.to_i}
        if employments
          row << [employments.sum(&:amount).try(:round, 2)]
        else
          row << ['']
        end
      end
      csv << row.flatten



      #### TOTAL PER CAPITA ####
      csv << ['']
      csv << ['']
      # first the header
      header = ['SALARIOS PER CAPITA']
      @uniq_times.each do |t|
        header << [t]
      end
      csv << header.flatten
      # second, the sectors
      @employments.group_by{|e| e.sector}.each do |k, v|
        row = [EmpMonthMatview::SECTORS[k.to_s].upcase]
        @uniq_times.each do |t|
          employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
          if employments
            row << [(employments.sum(&:amount) / employments.sum(&:total) rescue 0).try(:round, 2)]
          else
            row << ['']
          end
        end
        csv << row.flatten
        # detail of sectors
        if (params[:q][:group_by].to_i != 0 rescue false)
          gnumber = params[:q][:group_by].to_i
          v.group_by{ |o| gnumber == 1 ? o.ciiu_code : ( gnumber == 2 ? o.class_a : ( gnumber == 3 ? o.class_b : o.class_c ) ) }.each do |k, v|
            row = [
              (gnumber == 1 ? ciiu_categories[k.to_s] : ( gnumber == 2 ? EmpMonthMatview::BUDGETS[k] : ( gnumber == 3 ? EmpMonthMatview::STATES[k] : EmpMonthMatview::AREAS[k] ))) || 'Sin clasificar'
            ]
            @uniq_times.each_with_index do |t, i|
              employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
              if employments
                row << [(employments.sum(&:amount) / employments.sum(&:total) rescue 0).try(:round, 2)]
              else
                row << ['']
              end
            end
            csv << row.flatten
            # Verify patrons too
            if (params[:q][:show_patron].to_i == 1 rescue false)
              v.group_by{ |o| o.name }.each do |k, v|
                row = [k]
                @uniq_times.each_with_index do |t, i|
                  employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
                  if employments
                    row << [(employments.sum(&:amount) / employments.sum(&:total) rescue 0).try(:round, 2)]
                  else
                    row << ['']
                  end
                end
                csv << row.flatten
              end
            end
          end
        # no detail of sectors, but show the patrons
        elsif (params[:q][:show_patron].to_i == 1 rescue false)
          v.group_by{ |o| o.name }.each do |k, v|
            row = [k]
            @uniq_times.each_with_index do |t, i|
              employments = @year_selected ? v.select{|o| o.year.to_i == t.to_i} : v.select{|o| o.period.to_i == t.to_i}
              if employments
                row << [(employments.sum(&:amount) / employments.sum(&:total) rescue 0).try(:round, 2)]
              else
                row << ['']
              end
            end
            csv << row.flatten
          end
        end
      end
      # last the total sectors
      row = ['TOTAL SALARIO PER CAPITA']
      @uniq_times.each do |t|
        employments = @year_selected ? @employments.select{|o| o.year.to_i == t.to_i} : @employments.select{|o| o.period.to_i == t.to_i}
        if employments
          row << [(employments.sum(&:amount) / employments.sum(&:total) rescue 0).try(:round, 2)]
        else
          row << ['']
        end
      end
      csv << row.flatten

      # We add to the csv the indicators of digestyc
      csv << ['']
      csv << ['']
      header = ['Indicadores DIGESTYC']
      @uniq_times.each do |t|
        header << t
      end
      csv << header.flatten
      row_1 = ['PEA']
      row_2 = ['Población ocupada']
      @uniq_times.each do |t|
        employments = @year_selected ? @employments.select{|o| o.year.to_i == t.to_i} : @employments.select{|o| o.period.to_i == t.to_i}
        if employments
          row_1 << employments.first.pea rescue 0
          row_2 << employments.first.occupied rescue 0
        else
          row_1 << ''
          row_2 << ''
        end
      end
      csv << row_1.flatten
      csv << row_2.flatten
    end
    send_data csv_string, type: 'application/excel', filename: "estadisticas-empleos-#{Date.current.try(:strftime, '%Y%m%d')}.csv", disposition: 'attachment'
  end

  def ciiu_categories
    @ciiu_categories ||= Hash[CiiuCategory.pluck(:code, :name)]
  end
  helper_method :ciiu_categories
end
