require './board'
require 'pry'

describe Board do
  let(:board) { Board.new }
  it 'has a 3 x 3 grid' do
    expect(board.grid[0].size).to eq(3)
    expect(board.grid.size).to eq(3)
  end

  describe '#has_won' do
    context 'with a winning board' do
      it 'recognizes a winning board with three across' do
        board.grid[1] = ['x', 'x', 'x']
        expect(board.has_won).to eq(true)
      end

      it 'recognizes a vertical win' do
        board.grid.each do |row|
          row[0] = 'x'
        end
        expect(board.has_won).to eq(true)
      end

      context 'recognizes a diagonal win' do
        it 'recognizes a top-to-bottom diagonal win' do
          (0..2).each do |i|
            board.grid[i][i] = 'x'
          end
          expect(board.has_won).to eq(true)
        end

        it 'recognizes a bottom-to-top diagonal win' do
          (0..2).each do |i|
            board.grid[i][2 - i] = 'x'
          end
          expect(board.has_won).to eq(true)
        end
      end
    end

    context 'with a losing board' do
      it 'recognizes a board that has not won' do
        expect(board.has_won).to eq(false)
      end
    end
  end

  describe '#winning_move' do #2 of 3 spots claimed, 3rd spot is open
    # 'x', 'x', '0-8'
    context 'with a winnable board' do
      it 'recognizes a horizontal winnable condition' do
        board.grid[0] = ['x', 'x', '2']
        expect(board.winning_move('x')).to eq([[0, 2]])
      end

      it 'only returns winnable positions for the correct letter' do
        board.grid[0] = ['x', 'x', '2']
        expect(board.winning_move('o')).to eq([])
      end

      it 'recognizes a vertical winnable condition' do
        board.grid[0][0] = 'x'
        board.grid[1][0] = 'x'
        expect(board.winning_move('x')).to eq([[2,0]])
      end

      it 'recognizes a diagonal winnable combination' do
        2.times do |i|
          board.grid[i][i] = 'x'
        end
        expect(board.winning_move('x')).to eq([[2, 2]])
      end

      it 'recognizes a bottom-to-top diagonal winnable combination' do
        board.grid[2][0] = "x"
        board.grid[1][1] = "x"
        expect(board.winning_move('x')).to eq([[0, 2]])
      end
    end

    context 'without a winnable board' do
      it 'recognizes a board with no winning moves' do
        expect(board.winning_move('x')).to eq([])
      end

      it 'returns nil in a blocked condition' do
        board.grid[0] = ['x', 'x', 'o']
        expect(board.winning_move('x')).to eq([])
      end
    end


  end
end
