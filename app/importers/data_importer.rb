class DataImporter
  include HTTParty

  base_uri 'https://api.steampowered.com'

  def initialize(player, match_count = 5)
    @player_32_id = player.to_i
    @player_64_id = @player_32_id + 76561197960265728
    @key = "AEAA037C23104E417BB109B3E04A7C0F"
    
    summary = self.class.get("/ISteamUser/GetPlayerSummaries/v0002/", query: { key: @key, steamids: @player_64_id })
    history = self.class.get("/IDOTA2Match_570/GetMatchHistory/V001/", query: { key: @key, account_id: @player_32_id, matches_requested: match_count })
    item = self.class.get("/IEconDOTA2_570/GetGameItems/V001/", query: { key: @key, language: "en" })
    
    @summary = summary["response"]["players"].first
    @history = history["result"]
    @item = item["result"]["items"]

    @summary_success = summary.code == 200 && @summary.first.present?
    @history_success = history.code == 200 && @history.present?
    @item_success = item.code == 200 && @item.present?
  end

  def display_name
    if @summary_success
      @summary["personaname"]
    end
  end

  def avatar
    if @summary_success
      @summary["avatar"]
    end
  end

  def avatar_medium
    if @summary_success
      @summary["avatarmedium"]
    end
  end

  def avatar_full
    if @summary_success
      @summary["avatarfull"]
    end
  end

  def match_details(match_id)
    details = self.class.get("/IDOTA2Match_570/GetMatchDetails/V001/", query: { key: @key, match_id: match_id })
    found_player = details["result"]["players"].select {|player| player["account_id"].to_i == @player_32_id }.first
  end

  def matches
    @history["matches"].collect {|x| x["match_id"]}
  end

  def k_d_a(match_id)

  end

  def items(match_id)
    details = self.class.get("/IDOTA2Match_570/GetMatchDetails/V001/", query: { key: @key, match_id: match_id })
    found = details["result"]["players"].select {|player| player["account_id"].to_i == @player_32_id }.first
    res = []

    [found["item_0"], found["item_1"], found["item_2"], found["item_3"], found["item_4"], found["item_5"]].each do |item|
      next if item == 0

      found_item = @item.select {|i| i["id"] == item }.first

      res << ["http://cdn.dota2.com/apps/dota2/images/items/#{found_item['name'].split('item_').last}_lg.png", found_item["localized_name"]]
    end

    res
  end

end