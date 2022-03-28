RSpec.describe Supabase::Client do
  let(:default_client) { Supabase::Client.new }

  describe "initialization" do
    it "provides named arguments for authentication" do
      client = Supabase::Client.new supabase_url: 'foo', supabase_key: 'bar'
      
      expect(client.supabase_url).to eql 'foo'
      expect(client.supabase_key).to eql 'bar'
    end

    it "sets the default public schema" do
      expect(default_client.schema).to eql 'public'
    end
  end

  describe "default getters and setters" do 
    it "exposes getter/setter" do
      default_client.supabase_url = 'foo'
      default_client.supabase_key = 'bar'

      expect(default_client.supabase_url).to eql 'foo'
      expect(default_client.supabase_key).to eql 'bar'
    end
  end

  describe "#rest_url" do
    context "without a supabase_url" do
      it "creates a local path" do
        expect(default_client.rest_url).to eql "/rest/v1"
      end
    end

    context "with a supabase_url" do
      before { default_client.supabase_url = "https://example.com" }

      it "prepends to a local path" do
        expect(default_client.rest_url).to eql "https://example.com/rest/v1"
      end
    end
  end

  describe "#auth_headers" do
    it "contains an API key of random word characters" do
      expect(default_client.auth_headers[:apikey]).to match(/\A(\w+)?\z/)
    end

    it "contains a Authorization key of 'Bearer' followed by random word chars" do
      expect(default_client.auth_headers[:Authorization]).to match(/\ABearer\s(\w+)?\z/)
    end

    it "contains a X-Client-Info key with supabase-rb/{current version}" do
      expect(default_client.auth_headers[:"X-Client-Info"]).to match(/\Asupabase-rb\/[0-9\.]+\z/)
    end
  end

  describe ".create_client" do
    it "yields back the client object" do
      Supabase::Client.create_client { |c| 
        expect(c).to be_a Supabase::Client 
      }
    end

    it "returns a client object" do
      client = Supabase::Client.create_client { |_| }
      expect(client).to be_a Supabase::Client
    end
  end

  describe ".client" do
    it "creates a new client" do
      expect(Supabase::Client.client).to be_a Supabase::Client
    end

    it "memoizes the client object" do
      trip_1 = Supabase::Client.client
      trip_2 = Supabase::Client.client

      expect(trip_1).to eql trip_2
    end
  end
end