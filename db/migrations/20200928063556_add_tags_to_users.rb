Hanami::Model.migration do
  default_tags = [{
    name: "Times of day",
    order: 0,
    tags: ["Morning", "Noon", "Night"]
  }, {
    name: "Mood",
    order: 1,
    tags: ["Lazy", "Inspired"]
  }, {
    name: "",
    order: 2,
    tags: ["random", "uncategorized"]
  }]
  default_tags_json = JSON.dump(default_tags)

  change do
    alter_table :users do
      add_column :tags, :jsonb, null: false, default: default_tags_json
      # no need for indexes at this moment
    end
  end
end
