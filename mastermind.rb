class Board
  
    def colors
      @colors = ['red', 'blue', 'green', 'yellow', 'white', 'black']
    end
    #doesn't work right now, but an idea
    def rounds
        @ROUNDS = 12
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

  attr_accessor :guess

end

class Game
    board = Board.new
    computer = Computer.new
    human = Human.new
    round = 0

   # p computer.answer

  while round < 12
    #checks if you've won yet -- make method?
    if computer.answer == human.guess
        puts "You win!"
        break
    else
        puts "Round #{round+1}, #{12 - (round+1)} left."
        puts
        puts "Your color choices are #{board.colors.join(', ')}."
        puts
    end
    #resets the counters
    color_counter = 0
    exact_counter = 0
    human.guess = []
    #adds guesses into guess array
    4.times do |x| 
      puts "What's your guess for position number #{x+1}?" 
      temp = gets.chomp
      until board.colors.include?(temp)
        puts "Sorry, that is not an option... Try again."
        temp = gets.chomp
      end
      human.add(temp)

    end
    #re-iterates guesses
    puts
    puts "Your current guess is: #{human.guess.join(', ')}"
    puts
    #checks how many of the colors are correct
    y = 0
    computer.answer.each_with_index do |x|
      if x == human.guess[y]
        color_counter +=1
        y += 1
      end
    end

    puts "You've got #{color_counter} correct guesses for the colors"
    #checks how many are exact matches
    4.times do |x|
      if computer.answer[x] == human.guess[x]
          exact_counter += 1
      end
    end
    puts "and #{exact_counter} in the right spot(s)."
    puts
    
    round += 1
  end



  def play_round

  end

end

Game.new

#works except it doesn't seem consistant. sometimes it will say a guess
#has 2 right colors, then you move those 2 colors around and it says only
#1 is right...