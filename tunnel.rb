class Tunnel < Sprite
  attr_writer :light

  def initialize( x, y, dir, image )
    image = Image.load( image )
    image.set_color_key( [0, 0, 0] )
    @image = image
    self.x = x
    self.y = y
    super( self.x, self.y, @image )
    @light = 0
  end

  def movable?  #通れる場合true
    @light < 100
  end

  def draw
    Window.draw( self.x, self.y, @image )
  end
end