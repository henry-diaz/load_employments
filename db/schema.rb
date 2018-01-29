# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180126161647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ciiu3_activities", force: :cascade do |t|
    t.integer "ciiu3_group_id"
    t.string  "name"
    t.index ["ciiu3_group_id"], name: "index_ciiu3_activities_on_ciiu3_group_id", using: :btree
  end

  create_table "ciiu3_categories", force: :cascade do |t|
    t.string "code", limit: 1
    t.string "name"
  end

  create_table "ciiu3_divisions", force: :cascade do |t|
    t.string "category_code", limit: 1
    t.string "name"
    t.index ["category_code"], name: "index_ciiu3_divisions_on_category_code", using: :btree
  end

  create_table "ciiu3_groups", force: :cascade do |t|
    t.integer "ciiu3_division_id"
    t.string  "name"
    t.index ["ciiu3_division_id"], name: "index_ciiu3_groups_on_ciiu3_division_id", using: :btree
  end

  create_table "ciiu_activities", force: :cascade do |t|
    t.integer "ciiu_group_id"
    t.string  "name"
    t.index ["ciiu_group_id"], name: "index_ciiu_activities_on_ciiu_group_id", using: :btree
  end

  create_table "ciiu_categories", force: :cascade do |t|
    t.string "code", limit: 1
    t.string "name"
  end

  create_table "ciiu_divisions", force: :cascade do |t|
    t.string "category_code", limit: 1
    t.string "name"
    t.index ["category_code"], name: "index_ciiu_divisions_on_category_code", using: :btree
  end

  create_table "ciiu_groups", force: :cascade do |t|
    t.integer "ciiu_division_id"
    t.string  "name"
    t.index ["ciiu_division_id"], name: "index_ciiu_groups_on_ciiu_division_id", using: :btree
  end

  create_table "dim_employers", force: :cascade do |t|
    t.string   "nit"
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "sector",     default: 0
    t.integer  "class_a",    default: 0
    t.integer  "class_b",    default: 0
    t.integer  "class_c",    default: 0
    t.index ["class_a"], name: "index_dim_employers_on_class_a", using: :btree
    t.index ["class_b"], name: "index_dim_employers_on_class_b", using: :btree
    t.index ["class_c"], name: "index_dim_employers_on_class_c", using: :btree
    t.index ["sector"], name: "index_dim_employers_on_sector", using: :btree
  end

  create_table "dim_times", force: :cascade do |t|
    t.integer  "period"
    t.integer  "year"
    t.integer  "month"
    t.string   "month_str"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fact_digestics", force: :cascade do |t|
    t.integer  "year"
    t.integer  "occupied"
    t.integer  "unoccupied"
    t.integer  "inactive"
    t.integer  "pea"
    t.integer  "pet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fact_employments", force: :cascade do |t|
    t.integer  "dim_employer_id"
    t.integer  "dim_time_id"
    t.integer  "total",                                    default: 0
    t.decimal  "amount",          precision: 12, scale: 2
    t.integer  "up",                                       default: 0
    t.decimal  "up_amount",       precision: 12, scale: 2
    t.integer  "down",                                     default: 0
    t.decimal  "down_amount",     precision: 12, scale: 2
    t.integer  "pensioned",                                default: 0
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["dim_employer_id"], name: "index_fact_employments_on_dim_employer_id", using: :btree
    t.index ["dim_time_id"], name: "index_fact_employments_on_dim_time_id", using: :btree
  end

  create_table "tmp_detalle_planillas", force: :cascade do |t|
    t.integer  "idPlanilla"
    t.integer  "anyo"
    t.integer  "mes"
    t.string   "nitPatrono"
    t.string   "noAfiliacionTrabajador"
    t.decimal  "montoSalario",            precision: 12, scale: 2
    t.decimal  "montoPagoAdicional",      precision: 12, scale: 2
    t.decimal  "montoVacacion",           precision: 12, scale: 2
    t.decimal  "montoPresentado",         precision: 12, scale: 2
    t.string   "codigoObservacion"
    t.string   "estadoProcesamiento"
    t.text     "comentarioProcesamiento"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["idPlanilla"], name: "index_tmp_detalle_planillas_on_idPlanilla", using: :btree
  end

  create_table "tmp_employments", force: :cascade do |t|
    t.integer  "anyo"
    t.integer  "mes"
    t.string   "nit"
    t.integer  "altasTrabajadores",                                         default: 0
    t.decimal  "altasSalarios",                    precision: 12, scale: 2
    t.integer  "bajasTrabajadores",                                         default: 0
    t.decimal  "bajasSalarios",                    precision: 12, scale: 2
    t.integer  "pensionados",                                               default: 0
    t.integer  "totalTrabajadores",                                         default: 0
    t.decimal  "salarios",                         precision: 12, scale: 2
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                                     default: "new"
    t.text     "comment"
    t.string   "idPlanilla"
    t.integer  "periodo"
    t.string   "noPatronal",             limit: 9
    t.integer  "correlativoCT"
    t.integer  "ciiu4"
    t.integer  "ciiu3"
    t.integer  "sector"
    t.integer  "tipoSociedad"
    t.integer  "estadoPlanilla"
    t.string   "conceptoEstadoPlanilla", limit: 9
    t.integer  "class_a"
    t.integer  "class_b"
    t.integer  "class_c"
    t.integer  "source",                                                    default: 0
    t.string   "deptoMunic",             limit: 4,                          default: ""
    t.index ["ciiu3"], name: "index_tmp_employments_on_ciiu3", using: :btree
    t.index ["ciiu4"], name: "index_tmp_employments_on_ciiu4", using: :btree
    t.index ["noPatronal"], name: "index_tmp_employments_on_noPatronal", using: :btree
    t.index ["sector"], name: "index_tmp_employments_on_sector", using: :btree
    t.index ["source"], name: "index_tmp_employments_on_source", using: :btree
    t.index ["state"], name: "index_tmp_employments_on_state", using: :btree
  end

  create_table "tmp_planillas", force: :cascade do |t|
    t.integer  "idPlanilla"
    t.string   "noPatronal"
    t.string   "nombrePatrono"
    t.string   "nit"
    t.integer  "estado"
    t.string   "estadoProcesamiento"
    t.text     "comentarioProcesamiento"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["idPlanilla"], name: "index_tmp_planillas_on_idPlanilla", using: :btree
  end

  add_foreign_key "fact_employments", "dim_employers"
  add_foreign_key "fact_employments", "dim_times"
end
