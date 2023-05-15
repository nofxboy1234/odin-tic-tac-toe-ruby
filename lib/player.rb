# frozen_string_literal: true

# Player class
class Player
  @players = []

  class << self
    attr_reader :players
  end

  attr_accessor :marker
  attr_reader :name

  def initialize(marker, name)
    @marker = marker
    @name = name

    self.class.players << self
  end
end
