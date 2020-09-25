# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_25_100733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "addons", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "service_type_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_type_id"], name: "index_addons_on_service_type_id"
  end

  create_table "amenities", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "service_type_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_type_id"], name: "index_amenities_on_service_type_id"
  end

  create_table "bank_details", force: :cascade do |t|
    t.string "beneficiary_name", null: false
    t.string "beneficiary_account_number"
    t.string "beneficiary_address"
    t.string "beneficiary_bank"
    t.string "beneficiary_branch_name"
    t.string "beneficiary_bank_address"
    t.string "beneficiary_ifsc_code"
    t.string "beneficiary_swift_code"
    t.string "beneficiary_ibn_code"
    t.boolean "is_verified", default: false
    t.string "beneficiary_bic_code"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "breakfast_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_breakfast_types_on_name", unique: true
  end

  create_table "category2_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "service_type_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_type_id"], name: "index_category2_types_on_service_type_id"
  end

  create_table "category_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "service_type_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_type_id"], name: "index_category_types_on_service_type_id"
  end

  create_table "chains", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "master_chain_id", null: false
    t.bigint "service_type_id"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["master_chain_id"], name: "index_chains_on_master_chain_id"
    t.index ["service_type_id"], name: "index_chains_on_service_type_id"
  end

  create_table "charge_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_charge_types_on_name", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "airport_code"
    t.string "std_code"
    t.bigint "country_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "class_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "coach_size_types", force: :cascade do |t|
    t.string "coach_size", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_size"], name: "index_coach_size_types_on_coach_size", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_type_id", null: false
    t.bigint "contact_id", null: false
    t.bigint "bank_detail_id"
    t.string "currency"
    t.date "date_of_establishment"
    t.integer "parent_id"
    t.boolean "is_sister_company", default: false
    t.string "markup_type"
    t.decimal "markup_value", precision: 5, scale: 2
    t.string "logo_url"
    t.string "local_name"
    t.string "status", default: "ACTIVE"
    t.string "code"
    t.boolean "is_preferred", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_type_id"
    t.index ["bank_detail_id"], name: "index_companies_on_bank_detail_id"
    t.index ["company_type_id"], name: "index_companies_on_company_type_id"
    t.index ["contact_id"], name: "index_companies_on_contact_id"
    t.index ["service_type_id"], name: "index_companies_on_service_type_id"
  end

  create_table "company_tcs", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "subject"
    t.bigint "tc_id", null: false
    t.integer "order_id", null: false
    t.bigint "document_type_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_tcs_on_company_id"
    t.index ["document_type_id"], name: "index_company_tcs_on_document_type_id"
    t.index ["tc_id"], name: "index_company_tcs_on_tc_id"
  end

  create_table "company_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_company_types_on_name", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "country_id"
    t.bigint "city_id"
    t.string "zipcode"
    t.string "fax"
    t.string "phone_no"
    t.string "telephone_no"
    t.string "email"
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "street"
    t.string "skype_id"
    t.string "website"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_contacts_on_city_id"
    t.index ["country_id"], name: "index_contacts_on_country_id"
  end

  create_table "continents", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_continents_on_name", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "isd_code"
    t.string "iso_code"
    t.string "description"
    t.bigint "continent_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["continent_id"], name: "index_countries_on_continent_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.boolean "is_sales", default: false, null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_currencies_on_name", unique: true
  end

  create_table "currencies2s", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_currencies2s_on_name", unique: true
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_departments_on_name", unique: true
  end

  create_table "document_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_document_types_on_name", unique: true
  end

  create_table "facilities", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "service_type_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_type_id"], name: "index_facilities_on_service_type_id"
  end

  create_table "group_pax_slab_types", force: :cascade do |t|
    t.integer "pax_slab", null: false
    t.integer "foc", null: false
    t.integer "sgl"
    t.integer "half_twin"
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hotdate_difficulties", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_hotdate_difficulties_on_name", unique: true
  end

  create_table "hotdates", force: :cascade do |t|
    t.string "name", null: false
    t.date "from_date"
    t.date "to_date"
    t.boolean "is_all_country"
    t.integer "country_id"
    t.boolean "is_all_city"
    t.integer "city_id"
    t.string "description"
    t.bigint "hotdate_difficulty_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotdate_difficulty_id"], name: "index_hotdates_on_hotdate_difficulty_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "language_iso_code"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "linked_services_mappings", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "linked_service_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["linked_service_id"], name: "index_linked_services_mappings_on_linked_service_id"
    t.index ["service_id"], name: "index_linked_services_mappings_on_service_id"
  end

  create_table "location2_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_location2_types_on_name", unique: true
  end

  create_table "location_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_location_types_on_name", unique: true
  end

  create_table "markets", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_markets_on_name", unique: true
  end

  create_table "master_chains", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "menu_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_menu_types_on_name", unique: true
  end

  create_table "nationalities", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_nationalities_on_name", unique: true
  end

  create_table "person_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_person_types_on_name", unique: true
  end

  create_table "rating_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_rating_types_on_name", unique: true
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_regions_on_name", unique: true
  end

  create_table "remarks", force: :cascade do |t|
    t.string "name", null: false
    t.string "remark_type", default: "STATIC"
    t.string "select_type"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "roles_accesses_mappings", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "access_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["access_id"], name: "index_roles_accesses_mappings_on_access_id"
    t.index ["role_id"], name: "index_roles_accesses_mappings_on_role_id"
  end

  create_table "room_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_room_types_on_name", unique: true
  end

  create_table "service_amenity_mappings", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "amenity_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amenity_id"], name: "index_service_amenity_mappings_on_amenity_id"
    t.index ["service_id"], name: "index_service_amenity_mappings_on_service_id"
  end

  create_table "service_category_mappings", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "category_type_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_type_id"], name: "index_service_category_mappings_on_category_type_id"
    t.index ["service_id"], name: "index_service_category_mappings_on_service_id"
  end

  create_table "service_price_details", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.string "currency"
    t.bigint "room_type_id", null: false
    t.bigint "person_type_id"
    t.string "pricing_type", null: false
    t.bigint "charge_type_id"
    t.bigint "menu_type_id"
    t.bigint "breakfast_type_id"
    t.string "description"
    t.string "type"
    t.bigint "category_type_id"
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["breakfast_type_id"], name: "index_service_price_details_on_breakfast_type_id"
    t.index ["category_type_id"], name: "index_service_price_details_on_category_type_id"
    t.index ["charge_type_id"], name: "index_service_price_details_on_charge_type_id"
    t.index ["menu_type_id"], name: "index_service_price_details_on_menu_type_id"
    t.index ["person_type_id"], name: "index_service_price_details_on_person_type_id"
    t.index ["room_type_id"], name: "index_service_price_details_on_room_type_id"
    t.index ["service_id"], name: "index_service_price_details_on_service_id"
  end

  create_table "service_supplier_mappings", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "supplier_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_service_supplier_mappings_on_service_id"
    t.index ["supplier_id"], name: "index_service_supplier_mappings_on_supplier_id"
  end

  create_table "service_tc_mappings", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "tc_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_service_tc_mappings_on_service_id"
    t.index ["tc_id"], name: "index_service_tc_mappings_on_tc_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_service_types_on_name", unique: true
  end

  create_table "services", force: :cascade do |t|
    t.bigint "service_type_id", null: false
    t.string "name", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "country_id", null: false
    t.bigint "city_id", null: false
    t.string "zipcode"
    t.string "fax"
    t.string "phone_no"
    t.string "telephone_no"
    t.string "email"
    t.string "website"
    t.string "street"
    t.string "description"
    t.float "lat"
    t.float "lng"
    t.bigint "chain_id"
    t.string "rating"
    t.bigint "location_type_id"
    t.bigint "location2_type_id"
    t.integer "no_of_rooms"
    t.bigint "style_id"
    t.integer "seats"
    t.boolean "is_unesco", default: false
    t.boolean "has_ac", default: false
    t.boolean "is_preferred", default: false
    t.boolean "is_hotel", default: false
    t.boolean "is_licensed", default: false
    t.string "code", null: false
    t.boolean "placeholder", default: false
    t.boolean "is_99A_service", default: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chain_id"], name: "index_services_on_chain_id"
    t.index ["city_id"], name: "index_services_on_city_id"
    t.index ["country_id"], name: "index_services_on_country_id"
    t.index ["location2_type_id"], name: "index_services_on_location2_type_id"
    t.index ["location_type_id"], name: "index_services_on_location_type_id"
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
    t.index ["style_id"], name: "index_services_on_style_id"
  end

  create_table "styles", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_styles_on_name", unique: true
  end

  create_table "supplier_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_supplier_types_on_name", unique: true
  end

  create_table "terms_and_conditions", force: :cascade do |t|
    t.string "terms", null: false
    t.bigint "from_market_id", null: false
    t.bigint "to_market_id", null: false
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["from_market_id"], name: "index_terms_and_conditions_on_from_market_id"
    t.index ["to_market_id"], name: "index_terms_and_conditions_on_to_market_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tickets_on_name", unique: true
  end

  create_table "titles", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tour_pattern2_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tour_pattern2_types_on_name", unique: true
  end

  create_table "tour_pattern_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "status", default: "ACTIVE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tour_pattern_types_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "sur_name"
    t.string "designation"
    t.string "middle_name"
    t.string "last_name"
    t.string "local_name"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "phone"
    t.bigint "company_id"
    t.bigint "contact_id"
    t.bigint "role_id"
    t.date "date_of_joining"
    t.date "date_of_birth"
    t.date "anniversary_date"
    t.boolean "is_preffered_contact"
    t.bigint "department_id"
    t.bigint "title_id"
    t.bigint "service_type_id"
    t.string "status", default: "ACTIVE"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["contact_id"], name: "index_users_on_contact_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["service_type_id"], name: "index_users_on_service_type_id"
    t.index ["title_id"], name: "index_users_on_title_id"
  end

  add_foreign_key "addons", "service_types"
  add_foreign_key "amenities", "service_types"
  add_foreign_key "category2_types", "service_types"
  add_foreign_key "category_types", "service_types"
  add_foreign_key "chains", "master_chains"
  add_foreign_key "chains", "service_types"
  add_foreign_key "cities", "countries"
  add_foreign_key "companies", "bank_details"
  add_foreign_key "companies", "company_types"
  add_foreign_key "companies", "contacts"
  add_foreign_key "companies", "service_types"
  add_foreign_key "company_tcs", "companies"
  add_foreign_key "company_tcs", "document_types"
  add_foreign_key "company_tcs", "terms_and_conditions", column: "tc_id"
  add_foreign_key "countries", "continents"
  add_foreign_key "facilities", "service_types"
  add_foreign_key "hotdates", "hotdate_difficulties"
  add_foreign_key "linked_services_mappings", "services"
  add_foreign_key "linked_services_mappings", "services", column: "linked_service_id"
  add_foreign_key "roles_accesses_mappings", "accesses"
  add_foreign_key "roles_accesses_mappings", "roles"
  add_foreign_key "service_amenity_mappings", "amenities"
  add_foreign_key "service_amenity_mappings", "services"
  add_foreign_key "service_category_mappings", "category_types"
  add_foreign_key "service_category_mappings", "services"
  add_foreign_key "service_price_details", "breakfast_types"
  add_foreign_key "service_price_details", "category_types"
  add_foreign_key "service_price_details", "charge_types"
  add_foreign_key "service_price_details", "menu_types"
  add_foreign_key "service_price_details", "person_types"
  add_foreign_key "service_price_details", "room_types"
  add_foreign_key "service_price_details", "services"
  add_foreign_key "service_supplier_mappings", "companies", column: "supplier_id"
  add_foreign_key "service_supplier_mappings", "services"
  add_foreign_key "service_tc_mappings", "services"
  add_foreign_key "service_tc_mappings", "terms_and_conditions", column: "tc_id"
  add_foreign_key "services", "chains"
  add_foreign_key "services", "cities"
  add_foreign_key "services", "countries"
  add_foreign_key "services", "location2_types"
  add_foreign_key "services", "location_types"
  add_foreign_key "services", "service_types"
  add_foreign_key "services", "styles"
  add_foreign_key "terms_and_conditions", "markets", column: "from_market_id"
  add_foreign_key "terms_and_conditions", "markets", column: "to_market_id"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "contacts"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "roles"
  add_foreign_key "users", "service_types"
  add_foreign_key "users", "titles"
end
