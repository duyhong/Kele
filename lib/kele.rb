require "httparty"
require 'json'
require './lib/roadmap'
include Roadmap

class Kele
  def initialize(email, password)
    @base_url = "https://www.bloc.io/api/v1"
    response = HTTParty.post("#{@base_url}/sessions", { body: { email: email, password: password }})

    if response.code == 200 # 200 or 404
      @auth_token = response["auth_token"]
    else
      # raise some error
      raise "email or password is incorrect. Please try again."
    end
  end

  def get_me
    response = HTTParty.get("#{@base_url}/users/me", {headers: {"authorization" => @auth_token}})
    @result = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    @student_id = @result["id"]
    # @mentor_id = @result["current_enrollment"]["mentor_id"]
    response = HTTParty.get("#{@base_url}/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token}, body: {"id" => @student_id})
    JSON.parse(response.body)
  end

  def get_messages(*args)
    if args.length == 1
      page_number = args
      response = HTTParty.get("#{@base_url}/message_threads", headers: {"authorization" => @auth_token}, body: {"page" => page_number})
    elsif args.length == 0
      response = HTTParty.get("#{@base_url}/message_threads", headers: {"authorization" => @auth_token})
    else
      raise ArgumentError, "Too many arguments. Only zero or one argument is accepted."
    end
    JSON.parse(response.body)
  end

  def create_message
    response = HTTParty.post("#{@base_url}/messages", headers: {"authorization" => @auth_token}, body: {"sender" => "duy.hong@ymail.com", "recipient_id" => 2299843, "subject" => "Test Checkpoint 6", "stripped-text" => "Tests sending a message."})
  end

    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
      @enrollment_id = @result["current_enrollment"]["id"]
      response = HTTParty.post("#{@base_url}/checkpoint_submissions", headers: {"authorization" => @auth_token}, body: {"checkpoint_id": checkpoint_id, "comment": comment, "enrollment_id": @enrollment_id, "assignment_branch": assignment_branch, "assignment_commit_link": assignment_commit_link})
  end
end

# To work around SSL certificate issue
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
