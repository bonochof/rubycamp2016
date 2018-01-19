class Map_conmert
  def initialize
    @con_x = 0
    @con_y = 0
    @chip_size = 20
  end

  def convert_x( x )
    @con_x = x * @chip_size
    return @con_x
  end

  def convert_y( y )
    @con_y = y * @chip_size
    return @con_y
  end
end