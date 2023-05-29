# frozen_string_literal: true

require './lib/board'

# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

RSpec.describe Board do
  subject(:board) { described_class.new }
  let(:position) { 0 }

  describe '#update_marker' do
    # 1. Command Method -> Test the change in the observable state

    it 'updates the markers array' do
      marker = 'X'
      board.update_marker(position, marker)

      expect(board.markers[0]).to eq('X')
    end
  end

  describe '#valid_position?' do
    # 2. Query Method -> Test the return value
    let(:position_input) { '0' }

    context 'when position is valid' do
      it 'returns true' do
        expect(board.valid_position?(position_input)).to eq(true)
      end
    end

    context 'when position is not a "number string"' do
      let(:position_input) { 'a' }

      it 'returns false' do
        expect(board.valid_position?(position_input)).to eq(false)
      end
    end

    context 'when position is outside the board position range' do
      let(:position_input) { '9' }

      it 'returns false' do
        expect(board.valid_position?(position_input)).to eq(false)
      end
    end

    context 'when position is taken by another marker' do
      subject(:board) { described_class.new(markers) }
      let(:markers) { ['X', 1, 2, 3, 4, 5, 6, 7, 8] }
      let(:position_input) { '0' }

      it 'returns false' do
        expect(board.valid_position?(position_input)).to eq(false)
      end
    end
  end

  describe '#winner?' do
    # 2. Query Method -> Test the return value
    subject(:board) { described_class.new(markers) }

    context 'when a row is 3 of the same marker' do
      let(:markers) { ['X', 'X', 'X', 3, 4, 5, 6, 7, 8] }

      it 'returns true' do
        expect(board.winner?).to eq(true)
      end
    end

    context 'when a column is 3 of the same marker' do
      let(:markers) { ['X', 1, 2, 'X', 4, 5, 'X', 7, 8] }

      it 'returns true' do
        expect(board.winner?).to eq(true)
      end
    end

    context 'when first diagonal is 3 of the same marker' do
      let(:markers) { ['O', 1, 2, 3, 'O', 5, 6, 7, 'O'] }

      it 'returns true' do
        expect(board.winner?).to eq(true)
      end
    end

    context 'when second diagonal is 3 of the same marker' do
      let(:markers) { [0, 1, 'X', 3, 'X', 5, 'X', 7, 8] }

      it 'returns true' do
        expect(board.winner?).to eq(true)
      end
    end

    context 'when a row is different markers' do
      let(:markers) { ['X', 'X', 'O', 3, 4, 5, 6, 7, 8] }

      it 'returns false' do
        expect(board.winner?).to eq(false)
      end
    end

    context 'when a column is different markers' do
      let(:markers) { [0, 'O', 2, 3, 'X', 5, 6, 'O', 8] }

      it 'returns false' do
        expect(board.winner?).to eq(false)
      end
    end

    context 'when a diagonal is different markers' do
      let(:markers) { ['X', 1, 2, 3, 4, 5, 6, 7, 'O'] }

      it 'returns false' do
        expect(board.winner?).to eq(false)
      end
    end
  end

  describe '#full?' do
    # 2. Query Method -> Test the return value
    subject(:board) { described_class.new(markers) }

    context 'when the board is filled with markers' do
      let(:markers) { ['X', 'O', 'X', 'X', 'X', 'O', 'O', 'O', 'O'] }

      it 'returns true' do
        expect(board).to be_full
      end
    end

    context 'when the board is not filled with markers' do
      let(:markers) { ['X', 'O', 'X', 'X', 'X', 'O', 'O', 'O', 8] }

      it 'returns false' do
        expect(board).not_to be_full
      end
    end
  end
end
