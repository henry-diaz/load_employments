namespace :process do
  desc 'Carga la tabla temporal en las finales'
  task tmp: [:environment] do
    # Log the job start time
    open("#{Rails.root.to_s}/log/process.log", 'a') do |f|
      f.puts ""
      f.puts "-----------------------------"
      f.puts "#{Time.current.strftime('%d-%m-%Y %H:%M')}. INICIO DE LA CARGA."
    end
    @record = nil
    TmpEmployment.where(state: 'new').order(id: :asc).find_in_batches do |batch|
      sleep(50)
      batch.each do |tmp|
        begin
          # Create record
          dim_time = DimTime.where(year: tmp.anyo, month: tmp.mes).first_or_create
          dim_employer = DimEmployer.where(nit: tmp.nit).first_or_create(name: tmp.nombre)
          @record = FactEmployment.where(dim_employer_id: dim_employer.id, dim_time_id: dim_time.id).first_or_initialize
          @record.total = tmp.totalTrabajadores
          @record.amount = tmp.salarios
          @record.up = tmp.altasTrabajadores
          @record.up_amount = tmp.altasSalarios
          @record.down = tmp.bajasTrabajadores
          @record.down_amount = tmp.bajasSalarios
          @record.pensioned = tmp.pensionados
          unless @record.save
            # Log the failed register
            tmp.update_column(:state, 'error')
            tmp.update_column(:comment, "#{@record.errors.full_messages.join(", ")}")
          else
            tmp.update_column(:state, 'success')
          end
        rescue Exception => e
          # Log the failed register
          tmp.update_column(:state, 'error')
          tmp.update_column(:comment, "#{e}")
        end
      end # End of batch
    end # End of batches
    # Log the job end time
    open("#{Rails.root.to_s}/log/process.log", 'a') do |f|
      f.puts ""
      f.puts "-----------------------------"
      f.puts "#{Time.current.strftime('%d-%m-%Y %H:%M')}. FIN DE LA CARGA."
    end
  end
end
