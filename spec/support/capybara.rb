# spec/support/capybara.rb
RSpec.configure do |config|
  # rack_test = JSなしの軽量ドライバ
  config.before(:each, type: :system) do
    driven_by(:rack_test)
  end
end