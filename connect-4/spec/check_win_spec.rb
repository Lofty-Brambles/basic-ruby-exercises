# frozen_string_literal: true

require_relative '../lib/check_win'
require_relative '../lib/interface'

describe CheckWin do
  let(:drawn_board) { Array.new(7) { Array.new(6, Interface::RED_CIRCLE) } }
  let(:player_details) do
    red, blue = Interface::RED_CIRCLE, Interface::BLUE_CIRCLE
    { true => { symbol: red }, false => { symbol: blue } }
  end

  context 'when the board is full' do
    it 'declares a draw' do
      board = CheckWin.new(drawn_board, player_details, true)
      expect(board.is_draw?).to be true
    end
  end
end