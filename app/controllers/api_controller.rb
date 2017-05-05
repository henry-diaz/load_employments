class ApiController < ApplicationController
  before_action :parse_request

  def load_employments
    # @record = nil
    # begin
    #   @json.each do |json|
    #     @record = json
    #     # Create record
    #     dim_time = DimTime.where(year: json['anyo'].to_i, month: json['mes'].to_i).first_or_create
    #     dim_employer = DimEmployer.where(nit: json['nit']).first_or_create(name: json['nombre'])
    #     fact_employment = FactEmployment.where(dim_employer_id: dim_employer.id, dim_time_id: dim_time.id).first_or_initialize
    #     fact_employment.total = json['totalTrabajadores']
    #     fact_employment.amount = json['salarios']
    #     fact_employment.up = json['altasTrabajadores']
    #     fact_employment.up_amount = json['altasSalarios']
    #     fact_employment.down = json['bajasTrabajadores']
    #     fact_employment.down_amount = json['bajasSalarios']
    #     fact_employment.pensioned = json['pensionados']
    #     unless fact_employment.save
    #       # Log the failed register
    #       open("#{Rails.root.to_s}/log/api.log", 'a') do |f|
    #         f.puts ""
    #         f.puts "-----------------------------"
    #         f.puts "#{Time.current.strftime('%d-%m-%Y %H:%M')}. Guardar registros"
    #         f.puts "No se pudo guardar: #{json}."
    #       end
    #     end
    #   end
    #   head :ok
    # rescue Exception => e
    #   open("#{Rails.root.to_s}/log/api.log", 'a') do |f|
    #     f.puts ""
    #     f.puts "-----------------------------"
    #     f.puts "#{Time.current.strftime('%d-%m-%Y %H:%M')}. Insertar registros"
    #     f.puts "Obtuvimos un error #{e}. Con los siguientes datos #{@record.inspect}."
    #   end
    #   render json: { error: "Se presento un error al cargar los siguientes datos #{@record}" }, status: 500
    # end
    #### COMMENT WS
    # begin
    #   TmpEmployment.transaction do
    #     employments = @json.map(&:values)
    #     columns = [:anyo, :mes, :nit, :altasTrabajadores, :altasSalarios, :bajasTrabajadores, :bajasSalarios, :pensionados, :totalTrabajadores, :salarios, :nombre]
    #     TmpEmployment.import columns, employments, validate: false
    #     head :ok
    #   end
    # rescue Exception => e
    #   render json: { error: "Se presento un error #{e}" }, status: 500
    # end
    head :ok
  end

  def planillas
    # idPlanilla
    # noPatronal
    # nombrePatrno
    # nit
    # estado (1 recibo emitido, 0 anulado)
    begin
      TmpPlanilla.transaction do
        planillas = @json.map(&:values)
        columns = [:idPlanilla, :noPatronal, :nombrePatrono, :nit, :estado]
        TmpPlanilla.import columns, planillas, validate: false
        head :ok
      end
    rescue Exception => e
      render json: { error: "Se presento un error #{e}" }, status: 500
    end
  end

  def detalle_planillas
    # idPlanilla
    # anyo
    # mes
    # nitPatrono
    # noAfiliacionTrabajador
    # montoSalario
    # montoPagoAdicional
    # montoVacacion
    # montoPresentado
    # codigoObservacion
    begin
      TmpDetallePlanilla.transaction do
        detalle_planillas = @json.map(&:values)
        columns = [:idPlanilla, :anyo, :mes, :nitPatrono, :noAfiliacionTrabajador, :montoSalario, :montoPagoAdicional, :montoVacacion, :montoPresentado, :codigoObservacion]
        TmpDetallePlanilla.import columns, detalle_planillas, validate: false
        head :ok
      end
    rescue Exception => e
      render json: { error: "Se presento un error #{e}" }, status: 500
    end
  end

  private
    def parse_request
      begin
        @json = JSON.parse(request.body.read)
      rescue Exception => e
        open("#{Rails.root.to_s}/log/api.log", 'a') do |f|
          f.puts ""
          f.puts "-----------------------------"
          f.puts "#{Date.current.strftime('%d-%m-%Y')}. JSON Parse"
          f.puts "Obtuvimos un error #{e}. Con los siguientes datos #{@json.inspect}."
        end
      end
    end

end
