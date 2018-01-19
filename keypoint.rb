class Keypoint < Sprite
  @@keypoint_count = 0

  def initialize( x, y, image = nil )
    image = Image.load( image )
    image.set_color_key( [0, 0, 0] )
    @image = image
    super( x, y, @image )
    self.x = x
    self.y = y
    @get_sound = Sound.new( "sounds/get_keypoint.wav" )
    @clear_sound = Sound.new( "sounds/stageclear.wav" )
#    @clear_image = Image.load( "images/clear.png" )
  end

  def movable?
    return true
  end

  def draw
    Window.draw( self.x, self.y, @image )
  end

  def hit( obj )
    @get_sound.play
    @@keypoint_count += 1
    vanish
    if @@keypoint_count == 4
      @clear_sound.play
#      Window.draw( 0, 0, @clear_image )
#      sleep( 5 )
      puts "Stage Clear!"
    end
  end

  def counter
    return @@keypoint_count
  end
end