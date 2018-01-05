require "httparty"

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
end

# To work around SSL certificate issue
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
