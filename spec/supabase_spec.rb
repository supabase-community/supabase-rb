RSpec.describe Supabase do
  it 'has a version number' do
    expect(Supabase::VERSION).not_to be nil
  end
end

RSpec.describe Supabase::Error do
  it "descends StandardError" do
    expect(Supabase::Error.ancestors).to include(StandardError)
  end
end
