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
  
    def add_guess(value)
      @guess.push(value)
    end

    def answer
        @answer
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

end

class Human < Player

  def initialize
    @guess = []
    @answer = []
  end

  def add_answer(value)
    @answer.push(value)
  end

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
    #checks if you've won yet
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
      human.add_guess(temp)
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
    puts "Your color choices are #{board.colors.join(', ')}."
    puts
    #adds answer into answer array
    4.times do |x| 
       puts "Choose your color for position number #{x+1}?" 
       temp = gets.chomp
       until board.colors.include?(temp)
         puts "Sorry, that is not an option... Try again."
         temp = gets.chomp
       end
       human.add_answer(temp)
     end
     #re-iterates secret code
     puts
     puts "Your current code is: #{human.answer.join(', ')}"
     puts

    while round < board.rounds
    #checks if computer has won yet
    p computer.guess
      if computer.guess == human.answer
        puts "Computer wins!"
        break
      else
        puts "Round #{round+1}, #{12 - (round+1)} left."
      end
      #resets the counters and computer guesses each iteration
      color_counter = 0
      exact_counter = 0
      found_color = board.colors[rand(board.size)]

      comp_tally = Hash.new(0)
      human_tally = Hash.new(0)

      
      #checks how many of the colors are correct
      #creates a tally of both computer answer and player guess
      computer.guess.each { |x| comp_tally[x] +=1 }
      human.answer.each { |y| human_tally[y] += 1 }
      #compares guesses to answer tallies
      human_tally.each do |key, value|
        if comp_tally.include?(key)
          
          if value > comp_tally[key]
            color_counter += comp_tally[key]
            found_color = key
          else
            color_counter += value
          end

                              
        end
       end
      puts "Computer got #{color_counter} correct guesses for the colors"
      #checks how many are exact matches
      4.times do |x|
        if computer.guess[x] == human.answer[x]
          exact_counter += 1
          computer.guess[x] = computer.guess[x]
        else
            computer.guess[x] = found_color
        end
      end
      puts "and #{exact_counter} in the right spot(s)."
      puts
    
      round += 1
    end
    
    if round == board.rounds
      puts "The computer failed to guess your code. Good job."
    end
  end
end

#Game.new

#thinking about making a correct place/color uppercase to LOCK it in.
#then I'd have to check if it's upcase or downcase to be able to assign 
#it a random number