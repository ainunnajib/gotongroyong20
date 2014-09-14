require 'single_sign_on'
require 'uri'

class DiscourseSsoController < ApplicationController
  def sso
    regex_group = /.+\/(\d+)\.html/.match(request.referrer)
    if regex_group
      problem_id = regex_group.captures[0]
    else
      # Should be avoided to go here by disabling login from Discourse
      redirect_to "http://www.discourse.gotong.royong.org"
      return
    end

    if user_signed_in?
      secret = "1qazxcde345"
      sso = SingleSignOn.parse(request.query_string, secret)
      sso.email = current_user.email
      sso.name = current_user.name
      sso.username = current_user.name
      sso.external_id = current_user.id
      sso.sso_secret = secret

      # http://localhost:3000/problems/9501.html
      # Hack: Extract 9501
      redirect_to sso.to_url("http://#{problem_id}.discourse.gotong.royong.org/session/sso_login")
    else
      redirect_to "http://#{problem_id}.discourse.gotong.royong.org/"
    end
  end
end
