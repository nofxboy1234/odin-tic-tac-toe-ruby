require './lib/player'

# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

RSpec.describe Player do
  describe '#initialize' do
    # 1. Command Method -> Test the change in the observable state
    context 'when @players is empty' do
      before do
        described_class.reset_players
      end

      it 'adds self to @players' do
        expect { described_class.new('X', 'Player 1') }
          .to change { described_class.players.size }.from(0).to(1)
      end
    end

    context 'when @players is not empty' do
      before do
        described_class.reset_players
        described_class.new('X', 'Player 1')
      end

      it 'adds self to @players' do

        expect { described_class.new('X', 'Player 1') }
          .to change { described_class.players.size }.from(1).to(2)
      end
    end
  end

  describe '.reset_players' do
    # 1. Command Method -> Test the change in the observable state
    context 'when @players is empty' do
      before do
        described_class.reset_players
      end

      it 'clears the @players array' do
        expect { described_class.reset_players }
          .to_not(change { described_class.players.size })
      end
    end

    context 'when @players is not empty' do
      before do
        described_class.reset_players
        described_class.new('X', 'Player 1')
      end

      it 'clears the @players array' do

        expect { described_class.reset_players }
          .to change { described_class.players.size }.from(1).to(0)
      end
    end
  end
end
