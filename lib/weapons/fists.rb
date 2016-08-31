require_relative 'weapon'

class Fists < Weapon

  def initialize
    super("Fists", 0.25)
  end

  def use
    puts "using fists!"
    super
  end

end