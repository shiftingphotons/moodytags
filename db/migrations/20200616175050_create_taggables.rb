Hanami::Model.migration do
  change do
    create_table :taggables do
      primary_key :id

      column :ext_user_id, String,   null: false
      column :ext_id,      String,   null: false
      column :tags,        "text[]", null: false
      column :created_at,  DateTime, null: false
      column :updated_at,  DateTime, null: false
    end
  end
end
