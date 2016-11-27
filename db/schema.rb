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

ActiveRecord::Schema.define(version: 20161127194353) do

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "language"
    t.integer  "subsection_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "author_id"
    t.index ["author_id"], name: "index_projects_on_author_id"
    t.index ["subsection_id"], name: "index_projects_on_subsection_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subsections", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "section_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["section_id"], name: "index_subsections_on_section_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.integer  "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
