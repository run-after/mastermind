class Board
  
    def colors
      @COLORS = ['red', 'blue', 'green', 'yellow', 'white', 'black']
    end

    def size
        @COLORS.size
    end
    
    def rounds
        @ROUNDS = 12
    end

  end

  class Player
    attr_accessor :guess

    def initialize
      @guess = []
    end
  
    def add(value)
      @guess.push(value)
    end
  end

class Computer < Player
  #generates a random answer out of the 6 options from Board class
  def initialize
    board = Board.new
    @answer = [board.colors[rand(board.size)], board.colors[rand(board.size)], 
    board.colors[rand(board.size)], board.colors[rand(board.size)]]
    @guess = [board.colors[rand(board.size)], board.colors[rand(board.size)], 
    board.colors[rand(board.size)], board.colors[rand(board.size)]]
  end
  
  def answer
    @answer
  end

end

class Human < Player
  

end

class Game
  board = Board.new
  computer = Computer.new
  human = Human.new
  round = 0

  puts "Would you like to guess or create the secret code?"
  game_mode = gets.chomp 
  until game_mode == 'create' || game_mode == 'guess'
    puts "You must select either 'guess' or 'create'. Try again..."
    game_mode = gets.chomp
  end 
###############guessing mode#######################
  if game_mode == 'guess'

    p computer.answer

  while round < board.rounds
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
    #resets the counters and human guesses each iteration
    color_counter = 0
    exact_counter = 0
    human.guess = []

    comp_tally = Hash.new(0)
    human_tally = Hash.new(0)
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
    #creates a tally of both computer answer and player guess
    computer.answer.each { |x| comp_tally[x] +=1 }
    human.guess.each { |y| human_tally[y] += 1 }
    #compares guesses to answer tallies
      comp_tally.each do |key, value|
        if human_tally.include?(key)
          if value > human_tally[key]
            color_counter += human_tally[key]
          else
            color_counter += value
          end
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
elsif game_mode == 'create'
################create mode####################
    puts "coming soon"
end

end

#Game.new
