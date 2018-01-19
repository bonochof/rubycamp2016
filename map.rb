class Map
  def initialize
    @map_width = 40
    @map_height = 30
    @map = []
    @map_height.times{ @map = [] }
    File.open( 'mapdata.txt' ) do |mapdata|
      mapdata.readlines.each do |line|
        @map << line.chomp.split(//).map(&:to_i)
      end
    end
    @mapchip = []
    @map_height.times{ @mapchip << [] }
    @map_height.times do |i|
      @map_width.times do |j|
        @mapchip[i][j] = Mapchip.new( j, i, @map[i][j] )
      end
    end
  end

  def check( chara )
    Sprite.check( chara, @mapchip.flatten )
  end

  def draw
    Sprite.draw( @mapchip.flatten )
  end
end