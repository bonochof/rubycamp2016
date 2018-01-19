class Key < Sprite
#  attr_writer :keypoint

  @@key_count = 0

  def initialize( x, y, image = nil )
    image = Image.load( image )
    image.set_color_key( [0, 0, 0] )
    @image = image
    super( x, y, @image )
    self.x = x
    self.y = y
#    @keypoint = []
#    @keypoint_count = 2
    @sound = Sound.new( "sounds/get_key.wav" )
  end

  def movable?
    return true
  end

  def draw
    Window.draw( self.x, self.y, @image )
  end

  def hit( obj )
    @sound.play
    @@key_count += 1
#    p [@@key_count, @keypoint_x[@keypoint_count], @keypoint_y[@keypoint_count]]
#    @keypoint[@keypoint_count] = Keypoint.new( @keypoint_x[@keypoint_count], @keypoint_y[@keypoint_count], "images/keypoint.png" )
#    @keypoint_count += 1
    vanish
  end

  def counter
    return @@key_count
  end
end