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

ActiveRecord::Schema.define(version: 20160810055815) do

  create_table "admin_notifications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "time_zone",  limit: 255
    t.boolean  "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "deliveries", force: :cascade do |t|
    t.datetime "delivery_date"
    t.string   "from_location",            limit: 255
    t.string   "from_lat",                 limit: 255
    t.string   "from_lon",                 limit: 255
    t.string   "to_location",              limit: 255
    t.string   "to_lat",                   limit: 255
    t.string   "to_lon",                   limit: 255
    t.integer  "delivery_vehicle_id",      limit: 4
    t.integer  "promocode_id",             limit: 4
    t.decimal  "cost",                                  precision: 10, scale: 2, default: 0.0
    t.datetime "created_at",                                                                     null: false
    t.datetime "updated_at",                                                                     null: false
    t.string   "name",                     limit: 255
    t.string   "email",                    limit: 255
    t.integer  "delivery_status_id",       limit: 4
    t.integer  "user_id",                  limit: 4
    t.integer  "no_of_people",             limit: 4
    t.string   "signature_file_name",      limit: 255
    t.string   "signature_content_type",   limit: 255
    t.integer  "signature_file_size",      limit: 4
    t.datetime "signature_updated_at"
    t.integer  "driver_id",                limit: 4,                             default: 0
    t.datetime "status_updated_at"
    t.integer  "manual",                   limit: 4,                             default: 0
    t.string   "note",                     limit: 3000
    t.string   "to_door_number",           limit: 255
    t.string   "from_door_number",         limit: 255
    t.string   "delivery_contact",         limit: 255
    t.string   "delivery_number",          limit: 255
    t.string   "signature_name",           limit: 255
    t.decimal  "drivers_commission",                    precision: 10, scale: 2, default: 0.0
    t.datetime "canceled_at"
    t.integer  "temp_delivery_vehicle_id", limit: 4
    t.string   "delivery_type",            limit: 255,                           default: "now"
  end

  create_table "delivery_statuses", force: :cascade do |t|
    t.string   "status",     limit: 255
    t.string   "info",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delivery_vehicles", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.float    "cost_per_mile",   limit: 24
    t.string   "description",     limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "vehicle_type_id", limit: 4
    t.string   "payload",         limit: 255
    t.string   "load_space",      limit: 255
    t.integer  "container_size",  limit: 4
    t.integer  "vehicle_size",    limit: 4,   default: 0
    t.string   "min_charge",      limit: 255
  end

  create_table "driver_allocations", force: :cascade do |t|
    t.integer  "driver_id",     limit: 4
    t.integer  "delivery_id",   limit: 4
    t.integer  "active",        limit: 4, default: 0, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "completed",     limit: 4, default: 0
    t.integer  "attempt_count", limit: 4, default: 0
  end

  create_table "driver_devices", force: :cascade do |t|
    t.string   "token",       limit: 255
    t.string   "device_type", limit: 7
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "driver_id",   limit: 4
  end

  create_table "driver_locations", force: :cascade do |t|
    t.integer  "driver_id",        limit: 4
    t.string   "lat",              limit: 255
    t.string   "lon",              limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "driver_status_id", limit: 4
  end

  create_table "driver_references", force: :cascade do |t|
    t.string   "name",                            limit: 255
    t.string   "how_long_know",                   limit: 255
    t.string   "relationship",                    limit: 255
    t.string   "organization",                    limit: 255
    t.string   "postcode",                        limit: 255
    t.string   "email",                           limit: 255
    t.string   "telephone",                       limit: 255
    t.string   "address",                         limit: 255
    t.integer  "driver_id",                       limit: 4
    t.integer  "is_contacted_prior_to_interview", limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "driver_statuses", force: :cascade do |t|
    t.string   "status",     limit: 255
    t.string   "info",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "email",                                         limit: 255,                           default: "",    null: false
    t.string   "encrypted_password",                            limit: 255,                           default: "",    null: false
    t.string   "reset_password_token",                          limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                 limit: 4,                             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",                            limit: 255
    t.string   "last_sign_in_ip",                               limit: 255
    t.datetime "created_at",                                                                                          null: false
    t.datetime "updated_at",                                                                                          null: false
    t.string   "title",                                         limit: 255
    t.string   "first_name",                                    limit: 255
    t.string   "surname",                                       limit: 255
    t.string   "middle_name",                                   limit: 255
    t.string   "mobile_no",                                     limit: 255
    t.string   "land_no",                                       limit: 255
    t.string   "gender",                                        limit: 6
    t.boolean  "status",                                                                              default: false, null: false
    t.string   "token",                                         limit: 255
    t.string   "avatar_file_name",                              limit: 255
    t.string   "avatar_content_type",                           limit: 255
    t.integer  "avatar_file_size",                              limit: 4
    t.datetime "avatar_updated_at"
    t.date     "date_of_birth"
    t.string   "country_code",                                  limit: 255
    t.string   "session_token",                                 limit: 255
    t.string   "abt_position",                                  limit: 2000
    t.integer  "no_of_absent_dates",                            limit: 4
    t.string   "absent_desc",                                   limit: 255
    t.integer  "is_convictions_unspent_under_rehabilitation",   limit: 4,                             default: 0
    t.string   "convictions_unspent_under_rehabilitation_info", limit: 255
    t.integer  "is_criminal_offence",                           limit: 4,                             default: 0
    t.string   "criminal_offence_info",                         limit: 255
    t.integer  "is_license_valid_in_uk",                        limit: 4,                             default: 0
    t.string   "license_no",                                    limit: 255
    t.integer  "is_endorsements_on_license",                    limit: 4,                             default: 0
    t.integer  "is_blameworthy_accidents",                      limit: 4,                             default: 0
    t.string   "blameworthy_accident_info",                     limit: 255
    t.integer  "is_delete",                                     limit: 4,                             default: 0
    t.integer  "declaration_agreement",                         limit: 4,                             default: 0
    t.string   "photo_of_self_file_name",                       limit: 255
    t.string   "photo_of_self_content_type",                    limit: 255
    t.integer  "photo_of_self_file_size",                       limit: 4
    t.datetime "photo_of_self_updated_at"
    t.string   "license_paper_file_name",                       limit: 255
    t.string   "license_paper_content_type",                    limit: 255
    t.integer  "license_paper_file_size",                       limit: 4
    t.datetime "license_paper_updated_at"
    t.string   "license_photo_id_file_name",                    limit: 255
    t.string   "license_photo_id_content_type",                 limit: 255
    t.integer  "license_photo_id_file_size",                    limit: 4
    t.datetime "license_photo_id_updated_at"
    t.string   "utility_bill_file_name",                        limit: 255
    t.string   "utility_bill_content_type",                     limit: 255
    t.integer  "utility_bill_file_size",                        limit: 4
    t.datetime "utility_bill_updated_at"
    t.string   "passport_file_name",                            limit: 255
    t.string   "passport_content_type",                         limit: 255
    t.integer  "passport_file_size",                            limit: 4
    t.datetime "passport_updated_at"
    t.string   "bank_details_file_name",                        limit: 255
    t.string   "bank_details_content_type",                     limit: 255
    t.integer  "bank_details_file_size",                        limit: 4
    t.datetime "bank_details_updated_at"
    t.string   "national_insurance_file_name",                  limit: 255
    t.string   "national_insurance_content_type",               limit: 255
    t.integer  "national_insurance_file_size",                  limit: 4
    t.datetime "national_insurance_updated_at"
    t.string   "git_insurance_file_name",                       limit: 255
    t.string   "git_insurance_content_type",                    limit: 255
    t.integer  "git_insurance_file_size",                       limit: 4
    t.datetime "git_insurance_updated_at"
    t.string   "emergency_document_file_name",                  limit: 255
    t.string   "emergency_document_content_type",               limit: 255
    t.integer  "emergency_document_file_size",                  limit: 4
    t.datetime "emergency_document_updated_at"
    t.string   "uniform_info_file_name",                        limit: 255
    t.string   "uniform_info_content_type",                     limit: 255
    t.integer  "uniform_info_file_size",                        limit: 4
    t.datetime "uniform_info_updated_at"
    t.string   "vehicle_insurance_certificate_file_name",       limit: 255
    t.string   "vehicle_insurance_certificate_content_type",    limit: 255
    t.integer  "vehicle_insurance_certificate_file_size",       limit: 4
    t.datetime "vehicle_insurance_certificate_updated_at"
    t.string   "vehicle_registration_document_file_name",       limit: 255
    t.string   "vehicle_registration_document_content_type",    limit: 255
    t.integer  "vehicle_registration_document_file_size",       limit: 4
    t.datetime "vehicle_registration_document_updated_at"
    t.string   "vehicle_m_o_t_certificate_file_name",           limit: 255
    t.string   "vehicle_m_o_t_certificate_content_type",        limit: 255
    t.integer  "vehicle_m_o_t_certificate_file_size",           limit: 4
    t.datetime "vehicle_m_o_t_certificate_updated_at"
    t.string   "vehicle_rental_agreement_file_name",            limit: 255
    t.string   "vehicle_rental_agreement_content_type",         limit: 255
    t.integer  "vehicle_rental_agreement_file_size",            limit: 4
    t.datetime "vehicle_rental_agreement_updated_at"
    t.string   "vehicle_photo_file_name",                       limit: 255
    t.string   "vehicle_photo_content_type",                    limit: 255
    t.integer  "vehicle_photo_file_size",                       limit: 4
    t.datetime "vehicle_photo_updated_at"
    t.string   "vehicle_road_tax_file_name",                    limit: 255
    t.string   "vehicle_road_tax_content_type",                 limit: 255
    t.integer  "vehicle_road_tax_file_size",                    limit: 4
    t.datetime "vehicle_road_tax_updated_at"
    t.integer  "is_any_other_background",                       limit: 4,                             default: 0
    t.string   "ethnicity_info",                                limit: 255
    t.string   "ethnicity",                                     limit: 255
    t.string   "disability_info",                               limit: 255
    t.integer  "is_disability",                                 limit: 4,                             default: 0
    t.string   "sexual_orientation",                            limit: 255
    t.integer  "is_legal_restrictions",                         limit: 4,                             default: 0
    t.integer  "_is_bring_passport_for_interview",              limit: 4,                             default: 0
    t.integer  "_is_bring_certificate_for_interview",           limit: 4,                             default: 0
    t.integer  "_is_bring_work_visa_for_interview",             limit: 4,                             default: 0
    t.integer  "_is_bring_other_for_interview",                 limit: 4,                             default: 0
    t.string   "other_doc_for_interview",                       limit: 255
    t.decimal  "commission",                                                 precision: 10, scale: 2, default: 0.0
    t.string   "time_zone",                                     limit: 255
    t.integer  "delivery_vehicle_id",                           limit: 4
  end

  add_index "drivers", ["email"], name: "index_drivers_on_email", unique: true, using: :btree
  add_index "drivers", ["reset_password_token"], name: "index_drivers_on_reset_password_token", unique: true, using: :btree

  create_table "employment_gaps", force: :cascade do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.date     "from_date"
    t.date     "to_date"
    t.string   "reason",     limit: 255
    t.integer  "driver_id",  limit: 4,   default: 0, null: false
    t.integer  "integer",    limit: 4,   default: 0, null: false
  end

  create_table "employments", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "post_title",       limit: 255
    t.string   "salary",           limit: 255
    t.string   "address",          limit: 255
    t.date     "appointment_date"
    t.date     "last_day"
    t.string   "department",       limit: 255
    t.string   "notice_period",    limit: 255
    t.string   "duty_description", limit: 255
    t.string   "leaving_reason",   limit: 255
    t.integer  "is_present",       limit: 4,   default: 0, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "driver_id",        limit: 4,   default: 0, null: false
  end

  create_table "offers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description", limit: 255
    t.boolean  "status",                  default: false, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "promocodes", force: :cascade do |t|
    t.string   "code",        limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "temp_allocations", force: :cascade do |t|
    t.integer  "driver_id",   limit: 4
    t.integer  "delivery_id", limit: 4
    t.integer  "active",      limit: 4, default: 0, null: false
    t.integer  "completed",   limit: 4, default: 0, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "user_devices", force: :cascade do |t|
    t.string   "token",       limit: 255
    t.string   "device_type", limit: 7
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.string   "password",               limit: 255
    t.string   "gender",                 limit: 6
    t.date     "date_of_birth"
    t.string   "phone_no",               limit: 255
    t.string   "token",                  limit: 255
    t.boolean  "status",                             default: false, null: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "prepaid_credit_count",   limit: 4,   default: 0
    t.string   "country_code",           limit: 255
    t.string   "organisation_name",      limit: 255
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "time_zone",              limit: 255
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
