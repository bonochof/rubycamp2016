class Bridge < Sprite
  def initialize( x, y, dir, image = nil )
    image = Image.load( image )
    image.set_color_key( [0, 0, 0] )
    @image = image
    super( x, y, @image )
    @slope = 0
    @theta = 0
    @dtheta = 2
    @dir = dir
    self.x = x
    self.y = y
  end

  def sway( tilt )
    if tilt == 0
      @slope = 0
      @theta = 0
    else
      @slope = 1
      @theta += @dtheta
      @dtheta = -@dtheta if @theta.abs >= 10
    end
  end

  def movable?  #通れる場合true
    @slope == 0
  end

  def draw
    Window.draw_rot( self.x, self.y, @image, @theta )
  end

#  def shot( obj )
#  end
end