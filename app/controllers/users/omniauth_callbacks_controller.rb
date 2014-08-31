class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      redirect_to root_path, notice: "Email Anda sudah digunakan login oleh account media sosial Anda yang lain (Facebook/Google/Twitter). Silakan login dengan account lain yang Anda miliki."
    end
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      redirect_to root_path, notice: "Email Anda sudah digunakan login oleh account media sosial Anda yang lain (Facebook/Google/Twitter). Silakan login dengan account lain yang Anda miliki."
    end
  end

  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      redirect_to root_path, notice: "Email Anda sudah digunakan login oleh account media sosial Anda yang lain (Facebook/Google/Twitter). Silakan login dengan account lain yang Anda miliki."
    end
  end
end