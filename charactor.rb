class Charactor < Sprite
  attr_accessor :light

  def initialize(x, y, num)
    @image_name = ["images/chara_back.png","images/chara_left.png","images/chara_front.png","images/chara_right.png"]
    @image = []
    4.times do |i|
      @image[i] = Image.load(@image_name[i])
      @image[i].set_color_key([0, 0, 0])
    end
    super( x, y, @image[0] )
    @dir = 0
    @dv = 6
    @judge_t = 0.3
    @t1 = Time.now
    self.z = 2
    @hist_x = self.x
    @hist_y = self.y
    @font = Font.new(30)
    @num = num
  end

  def change
    @t2 = Time.now
    if @t2 - @t1 <= @judge_t
      @dir += 1
      if @dir > 3
        @dir = 0
      end
    end
    @t1 = Time.now
    @light = 255
  end

  def update
    @hist_x = self.x
    @hist_y = self.y
    if @dir == 0
      self.y -= @dv
    elsif @dir == 1
      self.x -= @dv
    elsif @dir == 2
      self.y += @dv
    elsif @dir == 3
      self.x += @dv
    end
    alpha = @light > 255 ? 255 : @light
    self.alpha = alpha
  end

  def draw
    Window.draw_font( self.x, self.y - 25, "1P", @font ) if @num == 0
    Window.draw_font( self.x, self.y - 25, "2P", @font ) if @num == 1
    Window.draw_font( self.x, self.y - 25, "3P", @font ) if @num == 2
    Window.draw_font( self.x, self.y - 25, "4P", @font ) if @num == 3
    Window.draw_alpha( self.x, self.y, @image[@dir], self.alpha )
  end

  def shot( obj )
    return if obj.movable?
    self.x = @hist_x if @dir == 1 || @dir == 3
    self.y = @hist_y if @dir == 0 || @dir == 2
  end
end
