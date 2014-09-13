require 'single_sign_on'
require 'uri'

class DiscourseSsoController < ApplicationController
  def sso
    puts request.referrer
    referrer_host = URI.parse(request.referrer).host

    secret = "1qazxcde345"
    sso = SingleSignOn.parse(request.query_string, secret)
    sso.email = current_user.email
    sso.name = current_user.name
    sso.username = current_user.name
    sso.external_id = current_user.id
    sso.sso_secret = secret

    redirect_to sso.to_url("http://#{referrer_host}/session/sso_login")
  end
end
