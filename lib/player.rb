# frozen_string_literal: true

# Player class
class Player
  @players = []

  class << self
    attr_reader :players
  end

  attr_reader :marker, :name

  def initialize(marker, name)
    @marker = marker
    @name = name

    self.class.players << self
  end

  def self.reset_players
    @players = []
  end
end
