require 'dxruby'
require 'smalrubot'
require_relative 'director'
require_relative 'charactor'
require_relative 'rock'
require_relative 'bridge'
require_relative 'wall'
require_relative 'tunnel'
require_relative 'map'
require_relative 'mapchip'
require_relative 'map_convert'
require_relative 'key'
require_relative 'keypoint'

Window.caption = "Stage2"
Window.width   = 800
Window.height  = 600

director = Director.new

Window.loop do
  break if Input.keyPush?(K_ESCAPE)
  director.input
  director.play
end