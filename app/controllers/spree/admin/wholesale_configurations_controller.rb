module Spree
  module Admin
    class WholesaleConfigurationsController < BaseController
      def show
        @preferences = ['auto_approve_wholesaler']
      end

      def edit
        @preferences = [:auto_approve_wholesaler]

      end

      def update
        params.each do |name, value|
          next unless Spree::Config.has_preference? name
          Spree::Config[name] = value
        end

        redirect_to admin_wholesale_configurations_path
      end
    end
  end
end
