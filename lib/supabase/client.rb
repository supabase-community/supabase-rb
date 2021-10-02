# frozen_string_literal: true

module Supabase
  class Client
    DEFAULT_SCHEMA = 'public'

    attr_accessor :supabase_url, :supabase_key, :schema

    def initialize(supabase_url: '', supabase_key: '', schema: DEFAULT_SCHEMA)
      self.supabase_url = supabase_url
      self.supabase_key = supabase_key
      self.schema = schema
    end

    def rest_url
      "#{supabase_url}/rest/v1"
    end

    def auth_headers
      {
        apikey: supabase_key,
        Authorization: "Bearer #{supabase_key}",
        "X-Client-Info": "supabase-rb/#{Supabase::VERSION}",
      }
    end

    class << self
      def create_client
        yield(client)

        client
      end

      def client
        @client ||= Client.new
      end
    end
  end
end
