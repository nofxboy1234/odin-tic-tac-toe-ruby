# frozen_string_literal: true

require './lib/board'

RSpec.describe Board do
  subject(:board) { Board.new }

  describe '#reset' do
    it 'sets @markers' do
      board.reset

      expect(board.markers).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
    end
  end
end
