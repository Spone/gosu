require 'gosu'
require_relative 'player.rb'
require_relative 'star.rb'

module ZOrder
  BACKGROUND, STARS, PLAYER, UI = *0..3
end

class Tutorial < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "Le Wagon Livecode Game"

    @background_image = Gosu::Image.new("media/space.png", :tileable => true)
    @player = Player.new
    @player.warp(400, 300)

    @star_anim = Gosu::Image.load_tiles("media/star.png", 25, 25)
    @stars = []

    @font = Gosu::Font.new(20)
  end

  def update
    # updating the state
    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      @player.turn_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      @player.turn_right
    end
    if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
      @player.accelerate
    end
    @player.move
    @player.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 25
      @stars << Star.new(@star_anim)
    end
  end

  def draw
    # updating the display
    @player.draw
    @background_image.draw(0, 0, 0)
    @stars.each { |star| star.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

Tutorial.new.show
