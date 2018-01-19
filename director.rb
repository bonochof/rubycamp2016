class Director
  def initialize
    #---マイコンボード---
    @board = Smalrubot::Board.new(Smalrubot::TxRx::Serial.new)
    #---キャラ---
    @chara_num = 4
    @chara_x = [40, 40, 200, 420]
    @chara_y = [60, 140, 400, 540]
    @chara = []
    @chara_num.times do |i|
      @chara[i] = Charactor.new( @chara_x[i], @chara_y[i], i )
    end
    #---スイッチ---
    @sw = []
    @hist_sw = [0,0,0,0]
    #---岩---
    @rock = Rock.new( rand(4),"images/rock.png" )
    @rock_push = 0
    #---橋---
    @bridge_num = 5
    @bridge_x = [180, 720, 520, 180, 700]
    @bridge_y = [ 20,  60, 220, 300, 400]
    @bridge_dir = [0, 1, 0, 0, 1]  #0 :横向き, 1 :縦向き
    @bridge = []
    @bridge_num.times do |i|
      @bridge[i] = Bridge.new( @bridge_x[i], @bridge_y[i], @bridge_dir[i], "images/bridge_width.png" ) if @bridge_dir[i] == 0
      @bridge[i] = Bridge.new( @bridge_x[i], @bridge_y[i], @bridge_dir[i], "images/bridge_height.png" ) if @bridge_dir[i] == 1
    end
    #---壁---
    @wall_num = 10
    @wall_x = [420, 580, 100,  80, 600,  80, 120, 160, 320,  20]
    @wall_y = [120, 120, 160, 360, 380, 440, 440, 440, 480, 500]
    @wall_dir = [0, 1, 0, 1, 0, 1, 1, 1, 0, 0] #0 :横向き, 1 :縦向き
    @wall = []
    @wall_num.times do |i|
      @wall[i] = Wall.new( @wall_x[i], @wall_y[i], @wall_dir[i], "images/wall_width.png" ) if @wall_dir[i] == 0
      @wall[i] = Wall.new( @wall_x[i], @wall_y[i], @wall_dir[i], "images/wall_height.png" ) if @wall_dir[i] == 1
    end
    #---トンネル---
    @tunnel_num = 9
    @tunnel_x = [580, 180, 200, 420, 500, 500,  80, 160, 240]
    @tunnel_y = [ 20, 100, 200, 300, 300, 440, 520, 520, 520]
    @tunnel_dir = [0, 0, 0, 0, 0, 1, 0, 0, 0] #0 :横向き, 1 :縦向き
    @tunnel = []
    @tunnel_num.times do |i|
      @tunnel[i] = Tunnel.new( @tunnel_x[i], @tunnel_y[i], @tunnel_dir[i], "images/tunnel_width.png" ) if @tunnel_dir[i] == 0
      @tunnel[i] = Tunnel.new( @tunnel_x[i], @tunnel_y[i], @tunnel_dir[i], "images/tunnel_height.png" ) if @tunnel_dir[i] == 1
    end
    #---キー---
    @key_num = 2
    @key_x = [340,  20]
    @key_y = [100, 300]
    @keys = []
    @key_num.times do |i|
      @keys[i] = Key.new( @key_x[i], @key_y[i], "images/key.png" )
    end
    #---キーポイント---
    @keypoint_num = 4
    @keypoint_count = 0
    @keypoint_x = [680, 300, 600, 300]
    @keypoint_y = [300, 180, 100, 380]
#    @keypoint_x = [80, 80, 80, 80]
#    @keypoint_y = [20, 20, 20, 20]
    @keypoint = []
    @keypoint_num.times do |i|
      @keypoint[i] = Keypoint.new( @keypoint_x[i], @keypoint_y[i], "images/keypoint.png" )
      @keypoint_count += 1
    end
    #---マップ---
    @map = Map.new
    #---背景---
    @bg_img = Image.load("images/bg.png")
    #---BGM---
    @bgm = Sound.new( "sounds/bgm.wav" )
#    @bgm.play
    @clear = 0
#    @wait_time = 3 * 60
    @clear_image = Image.load( "images/clear.png" )
    @start_time = Time.now
    @font = Font.new(30)
  end

  def input
    @chara_num.times do |i|
      @sw[i] = @board.digital_read(i+2)
    end
    @tilt = @board.digital_read(6)
    @light = @board.analog_read(0)
    @sound = @board.analog_read(1)
    @dist = @board.analog_read(4)
  end

  def play
    if (Time.now - @start_time).to_i % 113 == 0
      @bgm.play
    end
    #---背景,マップ表示---
    Window.draw( 0, 0, @bg_img )
    @map.draw

    #---ギミック処理---
    #---岩ゴロゴロ---
    if @rock.vanished?
      @rock = Rock.new( rand(4), "images/rock.png" )
    end
    @rock.push_back if @dist > 300
    @rock.roll
    Sprite.draw( @rock )
    #---橋グラグラ---
    @bridge.each{|bridge| bridge.sway(@tilt)}
    Sprite.draw( @bridge )
    #---壁バコーン---
    @wall.each{|wall| wall.sound = @sound }
    Sprite.draw( @wall )
    #---トンネルスケスケ---
    @tunnel.each{|tunnel| tunnel.light = @light }
    Sprite.draw( @tunnel )
    #---キー---
#    @keys.each{|key| key.keypoint = @keypoint}
    Sprite.draw( @keys )
#    @keys.counter.times
#      @keypoint[@keypoint_count] = Keypoint.new( @keypoint_x[@keypoint_count], @keypoint_y[@keypoint_count], "images/keypoint.png" )
#      @keypoint_count += 1
#    end
#    @keys.each{|key|
#      if key.vanished?
#        @keypoint[@keypoint_count] = Keypoint.new( @keypoint_x[@keypoint_count], @keypoint_y[@keypoint_count], "images/keypoint.png" )
#        @keypoint_count += 1
#      end
#    }
    #--キーフロア----
    @keypoint.each{|point| @clear = 1 if point.counter == 4}
    Sprite.draw( @keypoint )

    #---キャラクター処理---
    @chara_num.times do |i|
      @chara[i].light = @light
      #---移動---
      @chara[i].change if @sw[i] == 1 && @hist_sw[i] == 0
      @chara[i].update if @sw[i] == 1
      @hist_sw[i] = @sw[i]
      #---衝突判定---
      @map.check( @chara[i] )
    end
    Sprite.check( @chara, @rock )
    Sprite.check( @chara, @bridge )
    Sprite.check( @chara, @wall )
    Sprite.check( @chara, @tunnel )
    Sprite.check( @chara, @keys )
    Sprite.check( @chara, @keypoint )

    #---描画---
    Sprite.draw( @chara )

    Window.draw_font( 650, 10, "Time: #{(Time.now - @start_time).to_i}", @font )

    if @clear == 1
      Window.draw( 0, 0, @clear_image, 100 )
    end
  end
end