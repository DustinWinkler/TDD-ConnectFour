require "./connectfour"
describe Game do
  describe "#win?" do
    it 'detects diagonal win' do
      game = Game.new
      game.place_piece(1, 1)
      2.times { game.place_piece(2, 1) }
      3.times { game.place_piece(3, 1) }
      4.times { game.place_piece(4, 1) }
      expect(game.win?).to eql(true)
    end

    it 'detects vertical win' do
      game = Game.new
      4.times { game.place_piece(1, 1) }
      expect(game.win?).to eql(true)
    end

    it 'detects horizontal win' do
      game = Game.new
      1.upto(4) { |i| game.place_piece(i, 1) }
      expect(game.win?).to eql(true)
    end
  end

  describe "#place_piece" do
    it 'properly places piece for player 1' do
      game = Game.new
      game.place_piece(1, 1)
      expect(game.rows[0]).to eql([1,0,0,0,0,0,0])
    end

    it 'properly places piece for player 2' do
      game = Game.new
      game.place_piece(1, 2)
      expect(game.rows[0]).to eql([2,0,0,0,0,0,0])
    end
  end

  describe '#diagonals' do
    it 'creates an array of arrays representing all diagonals with no duplicates' do
      game = Game.new
      expect(game.diagonals).to eql([[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0]])
    end

    it 'can display a single diagonal of our choosing' do
      game = Game.new
      game.place_piece(1, 1)
      2.times { game.place_piece(2, 1) }
      3.times { game.place_piece(3, 1) }
      4.times { game.place_piece(4, 1) }
      expect(game.diagonals[0]).to eql([1, 1, 1, 1, 0, 0])
    end
  end

  describe '#columns' do
    it 'creates an array of arrays representing all columns' do
      game = Game.new
      expect(game.columns).to eql(Array.new(7) { Array.new(6, 0) })
    end

    it 'can display a single column of our choosing' do
      game = Game.new
      4.times { game.place_piece(1, 1) }
      expect(game.columns[0]).to eql([1, 1, 1, 1, 0, 0])
    end
  end
end
