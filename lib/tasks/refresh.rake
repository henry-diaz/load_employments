namespace :refresh do

  desc 'Refresh base info'
  task info: [:environment] do
    results = ActiveRecord::Base.connection.execute('update tmp_employments set anyo=SUBSTR(periodo::text, 1,4)::int, mes=SUBSTR(periodo::text, 5,2)::int')
  end

end
