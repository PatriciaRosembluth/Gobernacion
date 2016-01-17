# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160109214955) do

  create_table "announcements", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "accepted"
    t.boolean  "global"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "announcements", ["employee_id"], name: "index_announcements_on_employee_id"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "principal_activity"
    t.string   "nit"
    t.string   "address"
    t.string   "zone"
    t.string   "departament"
    t.string   "phones"
    t.string   "email"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "typename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee", force: :cascade do |t|
    t.string   "position"
    t.string   "profession"
    t.string   "agent_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "employee", ["person_id"], name: "index_employee_on_person_id"

  create_table "employees", force: :cascade do |t|
    t.string   "position"
    t.string   "profession"
    t.string   "agent_id"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "employees", ["person_id"], name: "index_employees_on_person_id"

  create_table "legal_agents", force: :cascade do |t|
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "person_id"
  end

  add_index "legal_agents", ["company_id"], name: "index_legal_agents_on_company_id"
  add_index "legal_agents", ["person_id"], name: "index_legal_agents_on_person_id"

  create_table "list_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "identification_number"
    t.integer  "identification_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "city"
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "phone_number"
  end

  add_index "people", ["user_id"], name: "index_people_on_user_id"

  create_table "procedure_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "procedures", force: :cascade do |t|
    t.integer  "state"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "procedure_type_id"
    t.integer  "legal_agent_id"
  end

  add_index "procedures", ["legal_agent_id"], name: "index_procedures_on_legal_agent_id"
  add_index "procedures", ["procedure_type_id"], name: "index_procedures_on_procedure_type_id"
  add_index "procedures", ["project_id"], name: "index_procedures_on_project_id"
  add_index "procedures", ["user_id"], name: "index_procedures_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "zone"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "company_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "projects", ["company_id"], name: "index_projects_on_company_id"

  create_table "received_documents", force: :cascade do |t|
    t.integer  "procedure_id"
    t.integer  "document_id"
    t.string   "reference"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "received_documents", ["document_id"], name: "index_received_documents_on_document_id"
  add_index "received_documents", ["procedure_id"], name: "index_received_documents_on_procedure_id"

  create_table "reports", force: :cascade do |t|
    t.string   "title"
    t.text     "antecedent"
    t.text     "description"
    t.text     "conclusion"
    t.text     "recommendation"
    t.integer  "procedure_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "regulatory_framework"
  end

  add_index "reports", ["procedure_id"], name: "index_reports_on_procedure_id"

  create_table "requirements", force: :cascade do |t|
    t.integer  "procedure_type_id"
    t.integer  "document_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "requirements", ["document_id"], name: "index_requirements_on_document_id"
  add_index "requirements", ["procedure_type_id"], name: "index_requirements_on_procedure_type_id"

  create_table "revisions", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "verification_list_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "revisions", ["document_id"], name: "index_revisions_on_document_id"
  add_index "revisions", ["verification_list_id"], name: "index_revisions_on_verification_list_id"

  create_table "roles", force: :cascade do |t|
    t.string   "typename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "active"
    t.string   "username",               default: "", null: false
    t.integer  "password_alteration",    default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "verification_fields", force: :cascade do |t|
    t.string   "description"
    t.integer  "verification_list_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "verification_fields", ["verification_list_id"], name: "index_verification_fields_on_verification_list_id"

  create_table "verification_lists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "list_category_id"
  end

  create_table "verified_fields", force: :cascade do |t|
    t.integer  "verification_field_id"
    t.integer  "verified_list_id"
    t.boolean  "answer"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "description"
  end

  add_index "verified_fields", ["verification_field_id"], name: "index_verified_fields_on_verification_field_id"
  add_index "verified_fields", ["verified_list_id"], name: "index_verified_fields_on_verified_list_id"

  create_table "verified_lists", force: :cascade do |t|
    t.integer  "verification_list_id"
    t.datetime "date_of_verification"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "verified"
    t.integer  "received_document_id"
  end

  add_index "verified_lists", ["received_document_id"], name: "index_verified_lists_on_received_document_id"
  add_index "verified_lists", ["verification_list_id"], name: "index_verified_lists_on_verification_list_id"

end
