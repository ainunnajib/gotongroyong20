require 'single_sign_on'
require 'uri'

class DiscourseSsoController < ApplicationController
  def sso
    secret = "1qazxcde345"
    sso = SingleSignOn.parse(request.query_string, secret)
    sso.email = current_user.email
    sso.name = current_user.name
    sso.username = current_user.name
    sso.external_id = current_user.id
    sso.sso_secret = secret

    # http://localhost:3000/problems/9501.html
    # Hack: Extract 9501

    problem_id = /.+\/(\d+)\.html/.match(request.referrer).captures[0]
    redirect_to sso.to_url("http://#{problem_id}.discourse.gotong.royong.org/session/sso_login")
  end
end
