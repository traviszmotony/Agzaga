class Spree::UserOmniauthCallbacksController < Devise::RegistrationsController

  def google_oauth2
    email_user = Spree::User.where(email: auth.info.email, provider: 'email')
    if email_user.present?
      flash[:error] = "User already registered with an email"
      redirect_to root_path
    else
      user = Spree::User.from_omniauth(auth)
      if user.present?
        sign_out_all_scopes
        flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect user, event: :authentication
      else
        flash[:alert] =
          t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
        redirect_to new_spree_user_session_path
      end
    end
  end

  def passthru
    render status: 404, plain: "Not found. Authentication passthru."
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_spree_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end

# touched on 2025-05-22T19:22:42.383182Z
# touched on 2025-05-22T23:27:02.689445Z
# touched on 2025-05-22T23:27:22.547655Z