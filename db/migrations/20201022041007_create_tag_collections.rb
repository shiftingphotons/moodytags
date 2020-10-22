Hanami::Model.migration do
  default_tags = [{
    name: "Times of day",
    order: 0,
    tags: ["Morning", "Noon", "Night"]
  }, {
    name: "Mood",
    order: 1,
    tags: ["Lazy", "Inspired"]
  }]
  default_tags_json = JSON.dump(default_tags)
  change do
    create_table :tag_collections do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade, null: false

      column :tags, :jsonb, null: false, default: default_tags_json
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
