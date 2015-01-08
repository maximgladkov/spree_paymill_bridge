module SpreePaymillBridge
  class Engine < Rails::Engine
    require 'spree/core'
    require 'paymill'
    isolate_namespace Spree
    engine_name 'spree_paymill_bridge'

    # use rspec for tests
    config.generators { |g| g.test_framework :rspec }

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)

    initializer 'spree.gateway.payment_methods', after: 'spree.register.payment_methods' do |app|
      app.config.spree.payment_methods << Spree::Gateway::PaymillBridge
    end
  end
end
