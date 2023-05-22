require './lib/game'
# require './lib/player'

require 'pry-byebug'

# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

RSpec.describe Game do
  subject(:game) { Game.new }

  describe '#input_position' do
    it 'gets input from player' do
      allow(game).to receive(:puts)
      allow(game).to receive(:player_marker).and_return('X')

      expect(game).to receive(:player_input)

      game.input_position
    end
  end

  describe '#game_loop' do
    before do
      game.instance_variable_set(:@board, Board.new)

      allow(game).to receive(:display_board)

      allow(game).to receive(:input_position)
      allow(game.board).to receive(:valid_position?).and_return(true)

      allow(game).to receive(:player_marker)
      allow(game.board).to receive(:update_marker)      
    end

    context 'when there is a winner on the first iteration' do
      it 'does not send next_player message and finishes the loop' do
        allow(game).to receive(:winner?).and_return(false, true)

        expect(game).not_to receive(:next_player)
        game.game_loop
      end
    end

    context 'when there is not a winner once, and then there is a winner' do
      it 'sends next_player message once and finishes the loop' do
        allow(game).to receive(:winner?).and_return(false, false, true)

        expect(game).to receive(:next_player).once
        game.game_loop
      end
    end

    context 'when there is not a winner twice, and then there is a winner' do
      it 'sends next_player message once and finishes the loop' do
        allow(game).to receive(:winner?).and_return(false, false, false, false, true)

        expect(game).to receive(:next_player).twice
        game.game_loop
      end
    end
  end
end
