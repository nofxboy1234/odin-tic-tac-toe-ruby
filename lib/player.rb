# frozen_string_literal: true

# Player class
class Player
  @players = []

  class << self
    attr_reader :players
  end

  attr_reader :marker, :name

  def initialize(marker, name)
    # binding.pry
    @marker = marker
    @name = name

    self.class.players << self
  end

  def self.reset_players
    # binding.pry
    @players = []
  end
end
