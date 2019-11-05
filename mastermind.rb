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

    computer = Computer.new
    human = Human.new

    p computer.answer

  4.times do |x| 
    puts "What's your guess for position number #{x+1}?" 
    human.add(gets.chomp)
  end

  puts "Your current guess is: #{human.guess.join(', ')}"
  
  if human.guess == computer.answer
    puts "YAY!"
  else
    puts "BOO!"
  end
  
end



Game.new