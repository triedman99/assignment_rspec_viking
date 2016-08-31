require_relative 'weapon'

class Axe < Weapon

  def initialize
    super("Axe", 1)
  end

  def use
    puts "swinging axe..."
    super
  end

end