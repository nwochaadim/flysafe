# RSpec
# spec/support/factory_girl.rb
require "factory_girl_rails"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
