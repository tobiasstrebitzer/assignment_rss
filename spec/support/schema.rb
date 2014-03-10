ActiveRecord::Schema.define do
  self.verbose = false


  create_table "rss_feed_entries", force: true do |t|
    t.string   "entry_id"
    t.string   "title"
    t.string   "author"
    t.string   "link"
    t.datetime "rss_updated"
    t.text     "content"
    t.integer  "rss_feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rss_feed_entries", ["rss_feed_id"], name: "index_rss_feed_entries_on_rss_feed_id"

  create_table "rss_feeds", force: true do |t|
    t.string   "feed_id"
    t.string   "url"
    t.string   "title"
    t.string   "link"
    t.datetime "rss_updated"
    t.text     "cache"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
