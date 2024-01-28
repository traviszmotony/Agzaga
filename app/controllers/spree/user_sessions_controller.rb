# frozen_string_literal: true

class Spree::UserSessionsController < Devise::SessionsController
  helper 'spree/base', 'spree/store'

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::Store

  # This is included in ControllerHelpers::Order.  We just want to call
  # it after someone has successfully logged in.
  after_action :set_current_order, only: :create

  def create
    authenticate_spree_user!
    if spree_user_signed_in?
      session[:recently_viewed_products] = []
      respond_to do |format|
        format.html do
          flash[:success] = I18n.t('spree.logged_in_succesfully')
          redirect_back_or_default(after_sign_in_path_for(spree_current_user))
        end
        format.js
      end
    else
      @error = t('devise.failure.invalid')
      respond_to do |format|
        format.html do
          flash.now[:error] = t('devise.failure.invalid')
          render :new
        end
        format.js
      end
    end
  end

  def user_registration
    @user = Spree::User.find_by(email: params[:spree_user][:email])
    @new_user = params[:spree_user][:email] unless @user.present?

    @existing_user = @user.provider == 'google_oauth2' ? 'google user' : 'agzaga user' if @user.present?
    respond_to do |format|
      format.js
    end
  end

  def forget_password
    respond_to do |format|
      format.js
    end
  end

  protected

  def translation_scope
    'devise.user_sessions'
  end

  private

  def accurate_title
    I18n.t('spree.login')
  end

  def redirect_back_or_default(default)
    redirect_to(session["spree_user_return_to"] || default)
    session["spree_user_return_to"] = nil
  end

  def success_json
    {
      json: {
        user: spree_current_user,
        ship_address: spree_current_user.ship_address,
        bill_address: spree_current_user.bill_address
      }.to_json
    }
  end
end

# touched on 2025-05-22T22:45:44.585478Z
# touched on 2025-05-22T23:37:26.322098Z
# touched on 2025-05-22T23:38:29.076600Z