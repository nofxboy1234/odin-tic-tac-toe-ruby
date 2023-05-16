require './lib/player'

# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

RSpec.describe Player do
  describe '#initialize' do
    it 'adds self to self.class.players' do
      # expect { Player.new('X', 'Player 1') }
      # .to change(Player.players, :size).by(1)
      expect { Player.new('X', 'Player 1') }
        .to change { Player.players.size }.by(1)
    end
  end
end
