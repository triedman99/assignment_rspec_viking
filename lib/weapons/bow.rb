require_relative 'weapon'

class Bow < Weapon
  attr_reader :arrows
  
  def initialize(arrows = 10)
    super("Bow", 2)
    @arrows = arrows
  end

  def use
    raise "Out of arrows" if out_of_arrows?
    puts "Shooting arrow!"
    @arrows -= 1
    puts "You have #{@arrows} arrows left"
    super
  end

  def out_of_arrows?
    @arrows <= 0
  end

end