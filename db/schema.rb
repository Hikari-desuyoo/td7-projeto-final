# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_11_234457) do

  create_table "hirers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_hirers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_hirers_on_reset_password_token", unique: true
  end

  create_table "occupations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "project_applications", force: :cascade do |t|
    t.integer "worker_id", null: false
    t.integer "project_id", null: false
    t.integer "status", default: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_applications_on_project_id"
    t.index ["worker_id"], name: "index_project_applications_on_worker_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "skills_needed"
    t.decimal "max_pay_per_hour"
    t.date "open_until"
    t.boolean "remote"
    t.boolean "presential"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "hirer_id", null: false
    t.integer "status", default: 0
    t.index ["hirer_id"], name: "index_projects_on_hirer_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "surname"
    t.string "social_name"
    t.date "birth_date"
    t.text "education"
    t.text "description"
    t.text "experience"
    t.integer "occupation_id"
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["occupation_id"], name: "index_workers_on_occupation_id"
    t.index ["reset_password_token"], name: "index_workers_on_reset_password_token", unique: true
  end

  add_foreign_key "project_applications", "projects"
  add_foreign_key "project_applications", "workers"
  add_foreign_key "projects", "hirers"
  add_foreign_key "workers", "occupations"
end
