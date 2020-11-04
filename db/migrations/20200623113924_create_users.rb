# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :ext_id, String, null: false
      column :token, String, null: false
      column :refresh_token, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
