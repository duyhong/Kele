require "httparty"
require 'json'
require 'rubygems'
require 'base64'

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
    p @auth_token
    json = HTTParty.get("#{@base_url}/users/me", {headers: {"authorization" => @auth_token}})
    get_body = JSON.parse(json.body)
  end
end

# To work around SSL certificate issue
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
