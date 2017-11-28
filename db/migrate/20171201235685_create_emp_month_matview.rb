class CreateEmpMonthMatview < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE MATERIALIZED VIEW emp_month_matview AS
        SELECT
        e.id as id,
        e.nombre as name,
        e.nit as nit,
        e."noPatronal" as patronal,
        e."correlativoCT" as centro,
        CASE WHEN e.sector=1 THEN 0
             WHEN e.sector=8 THEN 0
             ELSE 1
        END as sector,
        e.sector as sector_detail,
        cat.code as ciiu_code,
        e.class_a as class_a,
        e.class_b as class_b,
        e.class_c as class_c,
        e."estadoPlanilla" as status,
        e.periodo as period,
        e.anyo as year,
        e.mes as month,
        e.pensionados as pensioners,
        e."totalTrabajadores" as total,
        e.salarios as amount,
        (SELECT pea from fact_digestics where year = e.anyo) as pea,
        (SELECT occupied from fact_digestics where year = e.anyo) as occupied
        FROM tmp_employments e
        INNER JOIN ciiu_activities act on e.ciiu4 = act.id
        INNER JOIN ciiu_groups grp on act.ciiu_group_id = grp.id
        INNER JOIN ciiu_divisions div on grp.ciiu_division_id = div.id
        INNER JOIN ciiu_categories cat on div.category_code = cat.code

      -- CREATE MATERIALIZED VIEW emp_month_matview AS
      --   SELECT
      --   e.id as employer_id,
      --   e.nit as nit,
      --   e.name as name,
      --   e.sector as sector,
      --   e.class_a as class_a,
      --   e.class_b as class_b,
      --   e.class_c as class_c,
      --   t.period as period,
      --   t.year as year,
      --   t.month as month,
      --   f.total as total,
      --   f.amount as amount,
      --   round(COALESCE(f.amount / NULLIF(f.total, 0)), 2) as per_capita,
      --   (SELECT pea from fact_digestics where year = t.year) as pea,
      --   (SELECT occupied from fact_digestics where year = t.year) as occupied
      -- FROM fact_employments f
      -- INNER JOIN dim_times t ON t.id = f.dim_time_id
      -- INNER JOIN dim_employers e ON e.id = f.dim_employer_id
    SQL
    execute <<-SQL
      CREATE INDEX emp_month_matview_nit ON emp_month_matview (id);
      -- CREATE INDEX emp_month_matview_name ON emp_month_matview (name);
      -- CREATE INDEX emp_month_matview_period ON emp_month_matview (period);
      -- CREATE INDEX emp_month_matview_sector ON emp_month_matview (sector);
      -- CREATE INDEX emp_month_matview_class_a ON emp_month_matview (class_a);
      -- CREATE INDEX emp_month_matview_class_b ON emp_month_matview (class_b);
      -- CREATE INDEX emp_month_matview_class_c ON emp_month_matview (class_c);
    SQL
  end

  def down
    execute <<-SQL
      DROP MATERIALIZED VIEW emp_month_matview
    SQL
  end
end
