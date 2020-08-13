class Game 
  attr_accessor :rows
  def initialize
    @rows = Array.new(6) { Array.new(7, 0) }
  end

  def place_piece(column, player)
    self.rows.each do |row| 
      if row[column - 1] == 0
        row[column - 1] = player
        break
      end
    end
  end

  def display_game_state
    result = ""
    self.rows.reverse.each do |row|
      row.each { |num| result << "#{piece?(num)} " }
      result << "\n"
    end
    result
  end

  def piece?(num)
    if num == 0
      return '◌'
    elsif num == 1
      return '●'
    elsif num == 2
      return '○'
    end
  end

  def diagonals
    diagonals = []
   rows[0].each_with_index do |num, index|
      diag = []
      7.times do |i|
        diag << rows[i][index + i] unless rows[i].nil?
      end
      diagonals << diag.compact if diag.compact.length > 3
    end

    columns[0].each_with_index do |num, index|
      diag = []
      7.times do |i|
        diag << columns[i][index + i] unless columns[i].nil?
      end
      diagonals << diag.compact if diag.compact.length > 3
    end 

    rows[0].each_with_index do |num, index|
      diag = []
      7.times do |i|
        diag << rows[i][6 - (index + i)] unless rows[i].nil? || index + i >= 7
      end
      diagonals << diag.compact if diag.compact.length > 3
    end
 
    columns[6].each_with_index do |num, index|
      diag = []
      7.times do |i|
        diag << columns[6 - i][index + i] unless columns[i].nil?
      end
      diagonals << diag.compact if diag.compact.length > 3
    end

    diagonals.uniq
  end

  def columns
    columns = [[],[],[],[],[],[],[]]
    @rows.each do |row|
      row.each.with_index do |num, index|
        columns[index] << row[index]
      end
    end
    columns
  end

  def win?
    diagonals = self.diagonals
    win = false
    diagonals.each do |diagonal|
      if diagonal.join.to_s.include?('1111') || diagonal.join.include?('2222')
        win = true
      end
    end

    rows.each do |row|
      if row.join.to_s.include?('1111') || row.join.include?('2222')
        win = true
      end
    end

    columns.each do |column|
      if column.join.to_s.include?('1111') || column.join.include?('2222')
        win = true
      end
    end

    win
  end
end

game = Game.new
puts "Type 1 to play against another person, Type 2 to play against computer"
choice = gets.chomp.to_i
until choice == 1 || choice == 2
  puts "Type 1 or 2 >:("
  choice = gets.chomp.to_i
end
if choice == 1
  rounds = 0
  until game.win? || rounds == 41
    puts game.display_game_state
    puts "What is player 1's choice? (Columns 1-7)"
    column_choice = gets.chomp.to_i
    until column_choice.between?(1, 7)
      puts "That's not a valid option >:("
      column_choice = gets.chomp.to_i
    end
    game.place_piece(column_choice, 1)
    break if game.win?
    puts game.display_game_state
    puts "What is player 2's choice? (Columns 1-7)"
    column_choice = gets.chomp.to_i
    until column_choice.between?(1, 7)
      puts "That's not a valid option >:("
      column_choice = gets.chomp.to_i
    end
    game.place_piece(column_choice, 2)
    rounds += 1
  end
  puts game.display_game_state
  puts "Winner!"
else
  rounds = 0
  until game.win? || rounds == 41
    puts game.display_game_state
    puts "What is your choice? (Columns 1-7)"
    column_choice = gets.chomp.to_i
    until column_choice.between?(1, 7)
      puts "That's not a valid option >:("
      column_choice = gets.chomp.to_i
    end
    game.place_piece(column_choice, 1)
    break if game.win?
    puts game.display_game_state
    column_choice = rand(1..7)    
    game.place_piece(column_choice, 2)
    puts "The computer chose column #{column_choice}"
    rounds += 1
  end
  puts game.display_game_state
  puts "Winner!"
end

