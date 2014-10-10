module SpreePaymillBridge
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_paymill_bridge\n//= require paymill_bridge\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_paymill_bridge\n//= require paymill_bridge\n"
      end

  end
end
