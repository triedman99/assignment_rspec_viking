class Weapon
  attr_reader :name

  def initialize(name, multiplier = 1)
    @name = name
    @multiplier = multiplier
  end

  def use
    @multiplier
  end

end