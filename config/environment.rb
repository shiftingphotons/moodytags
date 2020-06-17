require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/moody_tags'
require_relative '../apps/api/application'

Hanami.configure do
  mount Api::Application, at: '/api'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/moody_tags_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/moody_tags_development'
    #    adapter :sql, 'mysql://localhost/moody_tags_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    gateway do |g|
      g.connection.extension(:pg_array)
      g.connection.extension(:pg_json)
    end

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/moody_tags/mailers'

    # See https://guides.hanamirb.org/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
