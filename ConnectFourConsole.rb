class ConnectFour
  def initialize
    @f = Array.new(7) { Array.new(15) }
    
    (0..@f.size-1).each do |i|
      (0..@f[i].size-1).each do |j|
        if j%2 == 0 then @f[i][j] = "|" else @f[i][j] = " " end
        if i == 6 then @f[i][j] = "-" end
      end
    end
  end
  
  def printPattern
    (0..@f.size-1).each do |i|
      (0..@f[i].size-1).each do |j|
        print @f[i][j]
      end
      print "\n"
    end
  end
  
  def dropRedPattern
    p "Drop a red disk at column (0-6): "
    
    scan = gets.chomp
    
    if scan.to_i < 0 or scan.to_i > 6 then return end
    
    c = 2*(scan.to_i) + 1
    
    5.downto(0) do |i|
      if @f[i][c] == " "
        @f[i][c] = "R"
        break
      end
    end
  end
  
  def dropYellowPattern
    p "Drop a yellow disk at column (0-6): "
    
    scan = gets.chomp
    
    if scan.to_i < 0 or scan.to_i > 6 then return end
    
    c = 2*(scan.to_i) + 1
    
   5.downto(0) do |i|
      if @f[i][c] == " "
        @f[i][c] = "Y"
        break
      end
    end
  end
  
  def checkWinner
    (0..5).each do |i|
      (0..6).step(2) do |j|
        if ((@f[i][j+1] != " ") and
          (@f[i][j+3] != " ") and
          (@f[i][j+5] != " ") and
          (@f[i][j+7] != " ") and
          ((@f[i][j+1] == @f[i][j+3]) and
          (@f[i][j+3] == @f[i][j+5]) and
          (@f[i][j+5] == @f[i][j+7])))
        
          return @f[i][j+1]
        end
      end
    end
    
    (1..14).step(2) do |i|
      (0..2).each do |j|
        if ((@f[j][i] != " ") and
          (@f[j+1][i] != " ") and
          (@f[j+2][i] != " ") and
          (@f[j+3][i] != " ") and
          ((@f[j][i] == @f[j+1][i]) and
          (@f[j+1][i] == @f[j+2][i]) and
          (@f[j+2][i] == @f[j+3][i])))
          
          return @f[j][i]
        end
      end
    end
    
    (0..2).each do |i|
      (1..8).step(2) do |j|
        if((@f[i][j] != " ") and
          (@f[i+1][j+2] != " ") and
          (@f[i+2][j+4] != " ") and
          (@f[i+3][j+6] != " ") and
          ((@f[i][j] == @f[i+1][j+2]) and
          (@f[i+1][j+2] == @f[i+2][j+4]) and
          (@f[i+2][j+4] == @f[i+3][j+6])))
          
          return @f[i][j]
        end
      end
    end
    
    (0..2).each do |i|
      (7..14).step(2) do |j|
        if((@f[i][j] != " ") and
          (@f[i+1][j-2] != " ") and
          (@f[i+2][j-4] != " ") and
          (@f[i+3][j-6] != " ") and
          ((@f[i][j] == @f[i+1][j-2]) and
          (@f[i+1][j-2] == @f[i+2][j-4]) and
          (@f[i+2][j-4] == @f[i+3][j-6])))
          
          return @f[i][j]
        end
      end
    end
    
    return nil
  end
end
  
game = ConnectFour.new

loop = true

count = 0
game.printPattern

while loop
  if count % 2 == 0 then game.dropRedPattern else game.dropYellowPattern end
  
  count += 1
  game.printPattern
  
  if game.checkWinner != nil
    if game.checkWinner == "R"
      print "The red player won."
    elsif game.checkWinner == "Y"
      print "The yellow player won."
    end
    
    loop = false;
  end
end