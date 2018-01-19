class Mapchip < Sprite
  def initialize( x, y, image_type )
    @image = Image.load( 'images/road.png' ) if image_type == 0
    @image = Image.load( 'images/tree.png' ) if image_type == 1
    @image = Image.load( 'images/road.png' ) if image_type == 2
    @image = Image.load( 'images/road.png' ) if image_type == 3
    @image = Image.load( 'images/road.png' ) if image_type == 4
    @image.set_color_key( [0, 0, 0] )
    super( x*20, y*20, @image )
    @image_type = image_type
  end

  def movable?  #通れる場合true
    @image_type == 0
  end
end