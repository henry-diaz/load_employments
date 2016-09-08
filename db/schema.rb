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

ActiveRecord::Schema.define(version: 20160908153722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dim_employers", force: :cascade do |t|
    t.string   "nit"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dim_times", force: :cascade do |t|
    t.integer  "period"
    t.integer  "year"
    t.integer  "month"
    t.string   "month_str"
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

  create_table "tmp_employments", force: :cascade do |t|
    t.integer  "anyo"
    t.integer  "mes"
    t.string   "nit"
    t.integer  "altasTrabajadores",                          default: 0
    t.decimal  "altasSalarios",     precision: 12, scale: 2
    t.integer  "bajasTrabajadores",                          default: 0
    t.decimal  "bajasSalarios",     precision: 12, scale: 2
    t.integer  "pensionados",                                default: 0
    t.integer  "totalTrabajadores",                          default: 0
    t.decimal  "salarios",          precision: 12, scale: 2
    t.string   "nombre"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "state",                                      default: "new"
    t.text     "comment"
    t.index ["state"], name: "index_tmp_employments_on_state", using: :btree
  end

  add_foreign_key "fact_employments", "dim_employers"
  add_foreign_key "fact_employments", "dim_times"
end
