class Wall < Sprite
  attr_writer :sound

  def initialize( x, y, dir, image = nil )
    image = Image.load( image )
    image.set_color_key( [0, 0, 0] )
    @image = image
    super( x, y, @image )
    self.x = x
    self.y = y
    @sound = 0
    @break_sound = Sound.new( "sounds/break_wall.wav" )
  end

  def movable?
    return false
  end

  def draw
    Window.draw( self.x, self.y, @image )
  end

  def hit( obj )
    if @sound > 500
      @break_sound.play
      vanish
    end
  end
end