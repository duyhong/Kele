require "httparty"
require 'json'

class Kele
  def initialize(email, password)
    @base_url = "https://www.bloc.io/api/v1"
    response = HTTParty.post("#{@base_url}/sessions", { body: { email: email, password: password }})

    if response.code == 200 # 200 or 404
      @auth_token = response["auth_token"]
    else
      # raise some error
      puts "email or password is incorrect. Please try again."
    end
  end

  def get_me
    json = HTTParty.get("#{@base_url}/users/me", {headers: {"authorization" => @auth_token}})
    @get_body = JSON.parse(json.body)
  end

  def get_mentor_availability(mentor_id)
    # @mentor_id = @get_body["current_enrollment"]["mentor_id"]
    mentor_availability = HTTParty.get("#{@base_url}/mentors/#{mentor_id}/student_availability").body
  end
end

# To work around SSL certificate issue
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
