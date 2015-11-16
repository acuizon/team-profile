class Player < ActiveRecord::Base

  validates :player_32_id, presence: true
  
  def player_64_id
    self.player_32_id.to_i + 76561197960265728
  end

end
