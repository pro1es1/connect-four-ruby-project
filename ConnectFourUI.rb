require 'gosu'

class MyWindow < Gosu::Window
  WIDTH = 720
  HEIGHT = 440
  TITLE = "Mouse Input Example"

  def initialize
    super(WIDTH, HEIGHT, false)
    self.caption = TITLE

    @last_frame = Gosu::milliseconds

    @background = Gosu::Image.new(self, './white.jpg', false)
    @border_image = Gosu::Image.new(self, './border_black.png', false)
    @red_circle = Gosu::Image.new(self, './red_circle.png', false)
    @yellow_circle = Gosu::Image.new(self, './yellow_circle.png', false)
    @horizontal_border = Gosu::Image.new(self, './horizontal_border_black.png', false)
    @count = 0
    
    @locs = []
    
    @f = Array.new(7) { Array.new(15) }
    
    (0..@f.size-1).each do |i|
      (0..@f[i].size-1).each do |j|
        if i == 6
          @f[i][j] = "-"
          @locs << ["-", j*47 , i*70]
        elsif j%2 == 0
          @f[i][j] = "|"
          @locs << ["|", j*50 , i*70]
        else
          @f[i][j] = " "
          @locs << [nil]
        end
      end
    end
  end
  
  def needs_cursor?; true; end

  def update
    calculate_delta
    
    have_winner = checkWinner
    
    if have_winner != nil
      if have_winner == "R"
        abort("The red player won.")
      elsif have_winner == "Y"
        abort("The yellow player won.")
      end
    end
  end

  def calculate_delta
    @this_frame = Gosu::milliseconds
    @delta = (@this_frame - @last_frame) / 1000.0
    @last_frame = @this_frame
  end

  def draw
    @background.draw(0, 0, 0)

    @locs.each do|l|
      if l[0] == "|"
        @border_image.draw(l[1], l[2], 1)
      elsif l[0] == "R"
        @red_circle.draw(l[1], l[2], 1)
      elsif l[0] == "Y"
        @yellow_circle.draw(l[1], l[2], 1)
      elsif l[0] == "-"
        @horizontal_border.draw(l[1], l[2], 1)
      end
    end
  end

  def button_down(id)
    case id
    when Gosu::MsLeft
      if @count % 2 == 0 and (mouse_x/100).to_i < 7
        dropRedPattern((mouse_x/100).to_i)
        @count += 1
      elsif mouse_x/100 < 7
        dropYellowPattern((mouse_x/100).to_i)
        @count += 1
      end
    end
  end
  
  def dropYellowPattern column_number
    scan = column_number
    
    c = 2*(scan) + 1
    
    5.downto(0) do |i|
      if @f[i][c] == " "
        @f[i][c] = "Y"
        @locs << ["Y", (c*50) - 30, i*70]
        break
      end
    end
  end
  
  def dropRedPattern column_number
    scan = column_number
    
    c = 2*(scan) + 1
    
    5.downto(0) do |i|
      if @f[i][c] == " "
        @f[i][c] = "R"
        @locs << ["R", (c*50) - 30, i*70]
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

window = MyWindow.new
window.show