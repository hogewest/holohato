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

ActiveRecord::Schema[7.1].define(version: 2024_06_23_082049) do
  create_table "channels", force: :cascade do |t|
    t.string "channel_id", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.index ["channel_id"], name: "index_channels_on_channel_id", unique: true
  end

  create_table "jobs", force: :cascade do |t|
    t.string "video_id", null: false
    t.integer "state", null: false
    t.integer "retry_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state"], name: "index_jobs_on_state"
    t.index ["video_id"], name: "index_jobs_on_video_id", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "video_id", null: false
    t.string "title", null: false
    t.datetime "published_at", null: false
    t.json "thumbnails", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "channel_id", null: false
    t.index ["channel_id"], name: "index_videos_on_channel_id"
    t.index ["video_id"], name: "index_videos_on_video_id", unique: true
  end

  add_foreign_key "videos", "channels"
end
