class Computer
  
  def answer
    @answer = [Board.new.colors[rand(4)], Board.new.colors[rand(4)], 
               Board.new.colors[rand(4)], Board.new.colors[rand(4)]]
  end

end

class Human


end

class Game
  
  while round < 13
    if Human.answer == Computer.answer #almost definetly won't work.
        puts "YOU WIN!"
    end
  end

end

class Board
  
  def colors
    colors = ['red', 'blue', 'green', 'yellow', 'white', 'black']
  end

end

p Computer.new.answer