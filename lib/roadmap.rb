module KeleHelper
  def get_roadmap(roadmap_id)
    response = HTTParty.get("#{@base_url}/roadmaps/#{roadmap_id}", {headers: {"authorization" => @auth_token}})
    JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = HTTParty.get("#{@base_url}/checkpoints/#{checkpoint_id}", {headers: {"authorization" => @auth_token}})
    JSON.parse(response.body)
  end
end
