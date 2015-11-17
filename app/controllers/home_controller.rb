class HomeController < ApplicationController

  def index
    @players = Player.all.collect {|p| DataImporter.new(p.player_32_id)}
  end

end
