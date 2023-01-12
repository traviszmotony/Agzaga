module Spree
  class Admin::NetSuiteAuthController < Spree::Admin::BaseController

    def index
    end

    def consent_approved
      raise('Code not found') and return unless params.dig(:code).present?
      code = params.dig(:code)

      if NetSuite::Base.new().generate_refersh_token(code)
        flash[:success] = 'NetSuite linked successfully'
      else
        flash[:error] = 'Something went wrong, please try again after some minutes'
      end

      redirect_to admin_net_suite_auth_index_path
    end
  end
end

# touched on 2025-05-22T23:08:21.614538Z
# touched on 2025-05-22T23:21:04.117029Z