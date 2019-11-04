class Board
  
    def colors
      @colors = ['red', 'blue', 'green', 'yellow', 'white', 'black']
    end
  
  end

class Computer
  #generates a random answer out of the 6 options from Board class
  def initialize
    board = Board.new
    @answer = [board.colors[rand(6)], board.colors[rand(6)], 
               board.colors[rand(6)], board.colors[rand(6)]]
  end
  
  def answer
    @answer
  end

end

class Human
  
  def initialize
    @guess = []
  end

  def add(value)
    @guess.push(value)
  end

  def guess
    @guess
  end

end

class Game
  human = Human.new
  4.times do |x| 
    puts "What's your guess for position number #{x+1}?" 
    human.add(gets.chomp)
  end
  puts "Your current guess is: #{human.guess.join(', ')}"


end



Game.new