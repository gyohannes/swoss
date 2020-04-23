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

ActiveRecord::Schema.define(version: 2020_04_16_050920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "admission_statuses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "admission_id"
    t.string "status"
    t.date "status_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admission_id"], name: "index_admission_statuses_on_admission_id"
  end

  create_table "admissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "patient_id"
    t.string "date_of_registration"
    t.date "date_of_registration_gr"
    t.string "admission_type"
    t.uuid "diagnosis_id"
    t.uuid "procedure_id"
    t.boolean "priority"
    t.uuid "physician_id"
    t.uuid "department_id"
    t.string "listing_status"
    t.text "information"
    t.string "appointment_date"
    t.date "appointment_date_gr"
    t.string "admission_date"
    t.date "admission_date_gr"
    t.uuid "ward_id"
    t.string "reason_for_admission"
    t.uuid "payment_type_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_admissions_on_department_id"
    t.index ["diagnosis_id"], name: "index_admissions_on_diagnosis_id"
    t.index ["patient_id"], name: "index_admissions_on_patient_id"
    t.index ["payment_type_id"], name: "index_admissions_on_payment_type_id"
    t.index ["physician_id"], name: "index_admissions_on_physician_id"
    t.index ["procedure_id"], name: "index_admissions_on_procedure_id"
    t.index ["user_id"], name: "index_admissions_on_user_id"
    t.index ["ward_id"], name: "index_admissions_on_ward_id"
  end

  create_table "anesthesians", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "hospital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_anesthesians_on_hospital_id"
  end

  create_table "circulating_nurses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "hospital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_circulating_nurses_on_hospital_id"
  end

  create_table "departments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "hospital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_departments_on_hospital_id"
  end

  create_table "diagnoses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hospitals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_hospitals_on_region_id"
  end

  create_table "or_schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "admission_id"
    t.string "procedure_type"
    t.uuid "surgeon_id"
    t.uuid "anesthesian_id"
    t.uuid "scrub_nurse_id"
    t.uuid "circulating_nurse_id"
    t.string "scheduled_date"
    t.date "scheduled_date_gr"
    t.time "scheduled_time"
    t.uuid "schedule_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admission_id"], name: "index_or_schedules_on_admission_id"
    t.index ["anesthesian_id"], name: "index_or_schedules_on_anesthesian_id"
    t.index ["circulating_nurse_id"], name: "index_or_schedules_on_circulating_nurse_id"
    t.index ["schedule_order_id"], name: "index_or_schedules_on_schedule_order_id"
    t.index ["scrub_nurse_id"], name: "index_or_schedules_on_scrub_nurse_id"
    t.index ["surgeon_id"], name: "index_or_schedules_on_surgeon_id"
    t.index ["user_id"], name: "index_or_schedules_on_user_id"
  end

  create_table "or_tables", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.uuid "hospital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_or_tables_on_hospital_id"
  end

  create_table "patients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hospital_id"
    t.integer "mrn"
    t.string "first_name"
    t.string "father_name"
    t.string "grand_father_name"
    t.string "date_of_birth"
    t.date "date_of_birth_gr"
    t.integer "age"
    t.string "sex"
    t.uuid "region_id"
    t.string "zone"
    t.string "woreda"
    t.string "kebele"
    t.string "house_number"
    t.integer "primary_telephone_number"
    t.string "name_of_contact_person"
    t.string "contact_person_telephone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_patients_on_hospital_id"
    t.index ["region_id"], name: "index_patients_on_region_id"
  end

  create_table "payment_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phone_calls", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "admission_id"
    t.string "patient_response"
    t.text "information"
    t.string "action"
    t.string "new_appointment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admission_id"], name: "index_phone_calls_on_admission_id"
  end

  create_table "physicians", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "hospital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_physicians_on_hospital_id"
  end

  create_table "procedure_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "code"
    t.integer "max_appointment_days"
    t.integer "max_postponment_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "procedures", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "procedure_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["procedure_category_id"], name: "index_procedures_on_procedure_category_id"
  end

  create_table "regions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedule_orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scrub_nurses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "hospital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_scrub_nurses_on_hospital_id"
  end

  create_table "surgeons", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "hospital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_surgeons_on_hospital_id"
  end

  create_table "surgical_services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "or_schedule_id"
    t.string "post_schedule_status"
    t.string "reason_for_cancellation"
    t.uuid "or_table_id"
    t.time "anesthesia_time"
    t.time "incision_time"
    t.time "surgery_end_time"
    t.boolean "surgical_safety_checklist_completed"
    t.string "immediate_postoperative_outcome"
    t.string "reason_for_death"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["or_schedule_id"], name: "index_surgical_services_on_or_schedule_id"
    t.index ["or_table_id"], name: "index_surgical_services_on_or_table_id"
    t.index ["user_id"], name: "index_surgical_services_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "user_name"
    t.string "email"
    t.string "full_name"
    t.string "role"
    t.uuid "hospital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["hospital_id"], name: "index_users_on_hospital_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "hospital_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_wards_on_hospital_id"
  end

  add_foreign_key "admission_statuses", "admissions"
  add_foreign_key "admissions", "departments"
  add_foreign_key "admissions", "diagnoses"
  add_foreign_key "admissions", "patients"
  add_foreign_key "admissions", "payment_types"
  add_foreign_key "admissions", "physicians"
  add_foreign_key "admissions", "procedures"
  add_foreign_key "admissions", "users"
  add_foreign_key "admissions", "wards"
  add_foreign_key "anesthesians", "hospitals"
  add_foreign_key "circulating_nurses", "hospitals"
  add_foreign_key "departments", "hospitals"
  add_foreign_key "hospitals", "regions"
  add_foreign_key "or_schedules", "admissions"
  add_foreign_key "or_schedules", "anesthesians"
  add_foreign_key "or_schedules", "circulating_nurses"
  add_foreign_key "or_schedules", "schedule_orders"
  add_foreign_key "or_schedules", "scrub_nurses"
  add_foreign_key "or_schedules", "surgeons"
  add_foreign_key "or_schedules", "users"
  add_foreign_key "or_tables", "hospitals"
  add_foreign_key "patients", "hospitals"
  add_foreign_key "patients", "regions"
  add_foreign_key "phone_calls", "admissions"
  add_foreign_key "physicians", "hospitals"
  add_foreign_key "procedures", "procedure_categories"
  add_foreign_key "scrub_nurses", "hospitals"
  add_foreign_key "surgeons", "hospitals"
  add_foreign_key "surgical_services", "or_schedules"
  add_foreign_key "surgical_services", "or_tables"
  add_foreign_key "surgical_services", "users"
  add_foreign_key "users", "hospitals"
  add_foreign_key "wards", "hospitals"
end
