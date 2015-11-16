class HomeController < ApplicationController

  def index
    @players = Player.all.collect {|p| PlayerProfileImporter.new(p.player_32_id)}
  end

end
