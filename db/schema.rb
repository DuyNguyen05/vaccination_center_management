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

ActiveRecord::Schema.define(version: 2020_06_12_114113) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_code"
    t.string "password"
    t.string "avatar"
    t.bigint "role_id"
    t.bigint "details_info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "info_injection_book_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["details_info_id"], name: "index_accounts_on_details_info_id"
    t.index ["info_injection_book_id"], name: "index_accounts_on_info_injection_book_id"
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_accounts_on_role_id"
  end

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "user_code"
    t.string "password"
    t.bigint "role_id"
    t.bigint "details_info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["details_info_id"], name: "index_admins_on_details_info_id"
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_admins_on_role_id"
  end

  create_table "bills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "creation_time"
    t.datetime "payment_time"
    t.bigint "account_id"
    t.bigint "injection_book_id"
    t.string "total_money"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_bills_on_account_id"
    t.index ["injection_book_id"], name: "index_bills_on_injection_book_id"
  end

  create_table "check_before_injections", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "answer_question"
    t.string "conclude"
    t.bigint "vaccine_type_id"
    t.bigint "template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "detail_injection_book_id"
    t.index ["detail_injection_book_id"], name: "index_check_before_injections_on_detail_injection_book_id"
    t.index ["template_id"], name: "index_check_before_injections_on_template_id"
    t.index ["vaccine_type_id"], name: "index_check_before_injections_on_vaccine_type_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "company_code"
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contract_distributions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "contract_id"
    t.bigint "details_info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_contract_distributions_on_contract_id"
    t.index ["details_info_id"], name: "index_contract_distributions_on_details_info_id"
  end

  create_table "contract_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "finish_at"
    t.integer "expire"
    t.bigint "contract_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_type_id"], name: "index_contracts_on_contract_type_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "detail_bills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "vaccine_id"
    t.bigint "vaccine_package_type_id"
    t.integer "number_injection"
    t.string "unit_price"
    t.string "discount"
    t.string "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "register_injection_package_id"
    t.index ["register_injection_package_id"], name: "index_detail_bills_on_register_injection_package_id"
    t.index ["vaccine_id"], name: "index_detail_bills_on_vaccine_id"
    t.index ["vaccine_package_type_id"], name: "index_detail_bills_on_vaccine_package_type_id"
  end

  create_table "detail_injection_books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "injection_date"
    t.string "react_after_injection"
    t.bigint "vaccination_center_id"
    t.bigint "account_id"
    t.bigint "injection_book_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bill_id"
    t.bigint "check_before_injection_id"
    t.index ["account_id"], name: "index_detail_injection_books_on_account_id"
    t.index ["bill_id"], name: "index_detail_injection_books_on_bill_id"
    t.index ["check_before_injection_id"], name: "index_detail_injection_books_on_check_before_injection_id"
    t.index ["injection_book_id"], name: "index_detail_injection_books_on_injection_book_id"
    t.index ["vaccination_center_id"], name: "index_detail_injection_books_on_vaccination_center_id"
  end

  create_table "detail_vaccine_packages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "vaccine_package_type_id"
    t.bigint "vaccine_id"
    t.integer "total_injections"
    t.string "user_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vaccine_id"], name: "index_detail_vaccine_packages_on_vaccine_id"
    t.index ["vaccine_package_type_id"], name: "index_detail_vaccine_packages_on_vaccine_package_type_id"
  end

  create_table "details_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "identify"
    t.string "number_phone"
    t.string "permanent_address"
    t.string "current_address"
    t.string "bank"
    t.string "bank_account_number"
    t.string "language"
    t.string "certificate"
    t.string "experience"
    t.string "nationality"
    t.string "gender"
    t.string "tax_code"
    t.bigint "vaccination_center_id"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_details_infos_on_department_id"
    t.index ["vaccination_center_id"], name: "index_details_infos_on_vaccination_center_id"
  end

  create_table "form_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
  end

  create_table "import_vaccines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "company_code"
    t.integer "quantity"
    t.bigint "vaccine_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_import_vaccines_on_account_id"
    t.index ["vaccine_id"], name: "index_import_vaccines_on_vaccine_id"
  end

  create_table "info_injection_books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "father_name"
    t.string "identify_father"
    t.string "mother_name"
    t.string "identify_mother"
    t.string "number_phone"
    t.string "current_address"
    t.string "permanent_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "injection_books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "book_code"
    t.string "name_person_injected"
    t.datetime "date_of_birth"
    t.string "place_of_birth"
    t.bigint "info_injection_book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "gender", default: 0
    t.index ["info_injection_book_id"], name: "index_injection_books_on_info_injection_book_id"
  end

  create_table "injection_schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "vaccination_center_id"
    t.datetime "injection_date"
    t.datetime "registration_date"
    t.bigint "vaccine_package_type_id"
    t.string "book_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vaccination_center_id"], name: "index_injection_schedules_on_vaccination_center_id"
    t.index ["vaccine_package_type_id"], name: "index_injection_schedules_on_vaccine_package_type_id"
  end

  create_table "register_injection_packages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "injection_book_id"
    t.bigint "vaccine_package_type_id"
    t.bigint "bill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_register_injection_packages_on_bill_id"
    t.index ["injection_book_id"], name: "index_register_injection_packages_on_injection_book_id"
    t.index ["vaccine_package_type_id"], name: "index_register_injection_packages_on_vaccine_package_type_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vaccination_centers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "address"
    t.string "number_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vaccine_distributions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "vaccine_id"
    t.bigint "vaccination_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vaccination_center_id"], name: "index_vaccine_distributions_on_vaccination_center_id"
    t.index ["vaccine_id"], name: "index_vaccine_distributions_on_vaccine_id"
  end

  create_table "vaccine_package_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vaccine_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vaccines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "manufacture"
    t.datetime "expiry_date"
    t.string "content"
    t.bigint "vaccine_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tag", default: "default"
    t.integer "quantity"
    t.string "company_code"
    t.string "user_code"
    t.string "price"
    t.bigint "company_id"
    t.index ["company_code"], name: "index_vaccines_on_company_code"
    t.index ["company_id"], name: "index_vaccines_on_company_id"
    t.index ["user_code"], name: "index_vaccines_on_user_code"
    t.index ["vaccine_type_id"], name: "index_vaccines_on_vaccine_type_id"
  end

  add_foreign_key "accounts", "details_infos"
  add_foreign_key "accounts", "info_injection_books"
  add_foreign_key "accounts", "roles"
  add_foreign_key "admins", "details_infos"
  add_foreign_key "admins", "roles"
  add_foreign_key "bills", "accounts"
  add_foreign_key "bills", "injection_books"
  add_foreign_key "check_before_injections", "detail_injection_books"
  add_foreign_key "check_before_injections", "templates"
  add_foreign_key "check_before_injections", "vaccine_types"
  add_foreign_key "contract_distributions", "contracts"
  add_foreign_key "contract_distributions", "details_infos"
  add_foreign_key "contracts", "contract_types"
  add_foreign_key "detail_bills", "register_injection_packages"
  add_foreign_key "detail_bills", "vaccine_package_types"
  add_foreign_key "detail_bills", "vaccines"
  add_foreign_key "detail_injection_books", "accounts"
  add_foreign_key "detail_injection_books", "bills"
  add_foreign_key "detail_injection_books", "check_before_injections"
  add_foreign_key "detail_injection_books", "injection_books"
  add_foreign_key "detail_injection_books", "vaccination_centers"
  add_foreign_key "detail_vaccine_packages", "vaccine_package_types"
  add_foreign_key "detail_vaccine_packages", "vaccines"
  add_foreign_key "details_infos", "departments"
  add_foreign_key "details_infos", "vaccination_centers"
  add_foreign_key "import_vaccines", "accounts"
  add_foreign_key "import_vaccines", "vaccines"
  add_foreign_key "injection_books", "info_injection_books"
  add_foreign_key "injection_schedules", "vaccination_centers"
  add_foreign_key "injection_schedules", "vaccine_package_types"
  add_foreign_key "register_injection_packages", "bills"
  add_foreign_key "register_injection_packages", "injection_books"
  add_foreign_key "register_injection_packages", "vaccine_package_types"
  add_foreign_key "vaccine_distributions", "vaccination_centers"
  add_foreign_key "vaccine_distributions", "vaccines"
  add_foreign_key "vaccines", "companies"
  add_foreign_key "vaccines", "vaccine_types"
end
