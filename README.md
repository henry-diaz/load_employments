1. LOAD INFO FROM CSV IN TERMINAL (~15m)

IMPFILES=(/var/lib/postgresql/csv/*.csv)

for i in ${IMPFILES[@]}
do
  psql -d ovisss_development -c "COPY tmp_employments(\"idPlanilla\", periodo, \"noPatronal\", nombre, nit, \"correlativoCT\", ciiu4, ciiu3, sector, \"tipoSociedad\", \"altasTrabajadores\", \"bajasTrabajadores\", \"altasSalarios\", \"totalTrabajadores\", pensionados, salarios, \"estadoPlanilla\", \"conceptoEstadoPlanilla\") from '$i' CSV HEADER"
  # move the imported file
  mv $i /var/lib/postgresql/csv/cargados
done

2. UPDATE DATE COLUMNS (~32m)

update tmp_employments set anyo=SUBSTR(periodo::text, 1,4)::int, mes=SUBSTR(periodo::text, 5,2)::int;

3. LOAD CIIU4 MASTERS

psql -d ovisss_development -c "COPY ciiu_activities(id, ciiu_group_id, name) from '/var/lib/postgresql/ciiu/ciiu4_actividad_economica.csv' CSV HEADER"
psql -d ovisss_development -c "COPY ciiu_categories(code, name) from '/var/lib/postgresql/ciiu/ciiu4_categorias.csv' CSV HEADER"
psql -d ovisss_development -c "COPY ciiu_divisions(id, category_code, name) from '/var/lib/postgresql/ciiu/ciiu4_divisiones.csv' CSV HEADER"
psql -d ovisss_development -c "COPY ciiu_groups(id, ciiu_division_id, name) from '/var/lib/postgresql/ciiu/ciiu4_grupos.csv' CSV HEADER"

4. LOAD EMPLOYERS

psql -d ovisss_development -c "truncate table dim_employers cascade"
psql -d ovisss_development -c "insert into dim_employers(nit, name, created_at, updated_at) select distinct on ( nit, nombre ) nit, nombre, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP from tmp_employments order by nombre;"
psql -d ovisss_development -c "truncate table dim_times cascade"
psql -d ovisss_development -c "insert into dim_times(period,year,month,created_at,updated_at) select distinct on (periodo) periodo, anyo, mes, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP from tmp_employments order by periodo asc;"

5. PUBLIC CLASSIFICATION

RAILS_ENV=production bundle exec rake load:isbm
RAILS_ENV=production bundle exec rake load:cel
RAILS_ENV=production bundle exec rake load:faes
RAILS_ENV=production bundle exec rake load:geo
RAILS_ENV=production bundle exec rake load:digestic
RAILS_ENV=production bundle exec rake load:classifications



CATÁLOGO DE SECTORES:
0 Privado
1 Público

CATÁLOGO DE DETALLE DE SECTORES (ORIGINAL ISSS):
1 Privado
2 Gobierno Central
3 Descentralizadas
4 De seguridad social
5 Empresas no financieras
6 Empresas financieras
7 Alcaldías
8 Doméstico

CATÁLOGO DE CATEGORÍAS CIIU (Rama de actividad económica):
A	Agricultura, ganadería, silvicultura y pesca
B	Explotación de minas y canteras
C	Industrias manufactureras
D	Suministro de electricidad, gas, vapor y aire acondicionado
E	Suministro de agua; evacuación de aguas residuales, gestión de desechos y descontaminación
F	Construcción
G	Comercio al por mayor y al por menor; reparación de vehículos automotores y motocicletas
H	Transporte y almacenamiento
I	Actividades de alojamiento y de servicio de comidas
J	Información y comunicaciones
K	Actividades financieras y de seguros
L	Actividades inmobiliarias
M	Actividades profesionales, científicas y técnicas
N	Actividades de servicios administrativos y de apoyo
O	Administración pública y defensa; planes de seguridad social de afiliación obligatoria
P	Enseñanza
Q	Actividades de atención de la salud humana y de asistencia social
R	Actividades artísticas, de entretenimiento y recreativas
S	Otras actividades de servicios
T	Actividades de los hogares como empleadores; actividades no diferenciadas de los hogares como productores de bienes y servicios para uso propio
U	Actividades de organizaciones y órganos extraterritoriales

CATALOGO DE STATUS:
0 Procesada
1 Pagada
