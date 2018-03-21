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
        (SELECT cat.code from ciiu_categories cat
        INNER JOIN ciiu_divisions div on div.category_code = cat.code
        INNER JOIN ciiu_groups grp on grp.ciiu_division_id = div.id
        INNER JOIN ciiu_activities act on act.ciiu_group_id = grp.id
        WHERE act.id = e.ciiu4) as ciiu4_code,
        (SELECT cat.code from ciiu3_categories cat
        INNER JOIN ciiu3_divisions div on div.category_code = cat.code
        INNER JOIN ciiu3_groups grp on grp.ciiu3_division_id = div.id
        INNER JOIN ciiu3_activities act on act.ciiu3_group_id = grp.id
        WHERE act.id = e.ciiu3) as ciiu3_code,
        e.class_a as class_a,
        e.class_b as class_b,
        e.class_c as class_c,
        e.class_d as class_d,
        e."estadoPlanilla" as status,
        e.periodo as period,
        e.anyo as year,
        e.mes as month,
        e.pensionados as pensioners,
        e."totalTrabajadores" as total,
        e.salarios as amount,
        (SELECT pea from fact_digestics where year = e.anyo) as pea,
        (SELECT occupied from fact_digestics where year = e.anyo) as occupied,
        e.source as source
        FROM tmp_employments e
    SQL
    execute <<-SQL
      CREATE INDEX emp_month_matview_id ON emp_month_matview (id);
      CREATE INDEX emp_month_matview_nit ON emp_month_matview (nit);
      CREATE INDEX emp_month_matview_ciiu4 ON emp_month_matview (ciiu4_code);
      CREATE INDEX emp_month_matview_ciiu3 ON emp_month_matview (ciiu3_code);
      CREATE INDEX emp_month_matview_name ON emp_month_matview (name);
      CREATE INDEX emp_month_matview_period ON emp_month_matview (period);
      CREATE INDEX emp_month_matview_sector ON emp_month_matview (sector);
      CREATE INDEX emp_month_matview_class_a ON emp_month_matview (class_a);
      CREATE INDEX emp_month_matview_class_b ON emp_month_matview (class_b);
      CREATE INDEX emp_month_matview_class_c ON emp_month_matview (class_c);
      CREATE INDEX emp_month_matview_class_d ON emp_month_matview (class_d);
      CREATE INDEX emp_month_matview_source ON emp_month_matview (source);
    SQL
  end

  def down
    execute <<-SQL
      DROP MATERIALIZED VIEW emp_month_matview
    SQL
  end
end
