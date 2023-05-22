require './lib/game'
# require './lib/player'

require 'pry-byebug'

# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

RSpec.describe Game do
  subject(:game) { Game.new }

  # describe '#play' do
  #   context 'when Player.players is empty' do
  #     it 'sets the first player to Player 1' do
  #       allow(Player).to receive(:reset_players)
  #       Player.players.clear

  #       game.reset_players

  #       name = game.player.name
  #       expect(name).to eq('Player 1')
  #     end
  #   end
  # end


end
