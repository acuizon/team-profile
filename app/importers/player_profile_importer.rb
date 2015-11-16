class PlayerProfileImporter
  include HTTParty

  base_uri 'https://api.steampowered.com'

  def initialize(player)
    @player_32_id = player.to_i
    @player_64_id = @player_32_id + 76561197960265728
    result = self.class.get("/ISteamUser/GetPlayerSummaries/v0002/", query: { key: "AEAA037C23104E417BB109B3E04A7C0F", steamids: @player_64_id })
    @player = result["response"]["players"].first
    @success = result.code == 200 && @player.first.present?
  end

  def display_name
    if @success
      @player["personaname"]
    end
  end

  def profile_url
    if @success
      @player["profileurl"]
    end
  end

  def avatar
    if @success
      @player["avatar"]
    end
  end

  def avatar_medium
    if @success
      @player["avatarmedium"]
    end
  end

  def avatar_full
    if @success
      @player["avatarfull"]
    end
  end

end