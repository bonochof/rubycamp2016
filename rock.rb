class Rock < Sprite
  def initialize( dir, image )
    rock_image = Image.load( image )
    rock_image.set_color_key( [0, 0, 0] )
    @rock_image = rock_image
    if dir == 0  #左出
      self.x = -400
      self.y = 100
      @dtheta = 10
    elsif dir == 1  #右出
      self.x = Window.width
      self.y = 100
      @dtheta = -10
    elsif dir == 2  #上出
      self.x = 200
      self.y = -400
      @dtheta = 10
    elsif dir == 3  #下出
      self.x = 200
      self.y = Window.height
      @dtheta = -10
    end
    super( self.x, self.y, @rock_image )
    self.z = 10
    @dir = dir
    @theta = 0
    @dv = 10
    @ache_image = Image.load( "images/ache.png" )
    @ache_image.set_color_key( [0, 0, 0] )
  end

  def roll
    self.x += @dv if @dir == 0  #右進
    self.x -= @dv if @dir == 1  #左進
    self.y += @dv if @dir == 2  #下進
    self.y -= @dv if @dir == 3  #上進
    if self.x < -400 || self.x > Window.width || self.y < -400 || self.y > Window.height
      vanish
    end
    @theta += @dtheta
    @theta = 0 if @theta > 360
  end

  def push_back
    self.x -= @dv * 2 if @dir == 0  #右進
    self.x += @dv * 2 if @dir == 1  #左進
    self.y -= @dv * 2 if @dir == 2  #下進
    self.y += @dv * 2 if @dir == 3  #上進
    if self.x < -400 || self.x > Window.width || self.y < -400 || self.y > Window.height
      vanish
    end
  end

  def draw
    Window.draw_rot( self.x, self.y, @rock_image, @theta, nil, nil, self.z)
  end

  def movable?
    return false
  end

  def hit( obj )
    Window.draw( 250, 200, @ache_image, 11 )
  end
end