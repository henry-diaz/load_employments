class CreateEmpMonthMatview < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE MATERIALIZED VIEW emp_month_matview AS
        SELECT
        e.id as employer_id,
        e.nit as nit,
        e.name as name,
        e.sector as sector,
        e.class_a as class_a,
        e.class_b as class_b,
        e.class_c as class_c,
        t.period as period,
        t.year as year,
        t.month as month,
        f.total as total,
        f.amount as amount,
        round(COALESCE(f.amount / NULLIF(f.total, 0)), 2) as per_capita,
        (SELECT pea from fact_digestics where year = t.year) as pea,
        (SELECT occupied from fact_digestics where year = t.year) as occupied
      FROM fact_employments f
      INNER JOIN dim_times t ON t.id = f.dim_time_id
      INNER JOIN dim_employers e ON e.id = f.dim_employer_id
    SQL
    execute <<-SQL
      CREATE INDEX emp_month_matview_nit ON emp_month_matview (nit);
      CREATE INDEX emp_month_matview_name ON emp_month_matview (name);
      CREATE INDEX emp_month_matview_period ON emp_month_matview (period);
      CREATE INDEX emp_month_matview_sector ON emp_month_matview (sector);
      CREATE INDEX emp_month_matview_class_a ON emp_month_matview (class_a);
      CREATE INDEX emp_month_matview_class_b ON emp_month_matview (class_b);
      CREATE INDEX emp_month_matview_class_c ON emp_month_matview (class_c);
    SQL
  end

  def down
    execute <<-SQL
      DROP MATERIALIZED VIEW emp_month_matview
    SQL
  end
end
