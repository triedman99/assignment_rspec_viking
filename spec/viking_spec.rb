require_relative '../lib/viking.rb'

describe Viking do

  let(:viking){Viking.new}

  describe '#initialize' do
    it 'sets the name attribute properly' do
      new_viking = Viking.new(name='Tamal')
      expect(new_viking.name).to eq('Tamal')
    end

    it 'sets the health attribute properly' do
      new_viking = Viking.new('Tamal',125)
      expect(new_viking.health).to eq(125)
    end

    it 'cannot overwrite health once initialized' do
      expect{viking.health=125}.to raise_error(NoMethodError)
    end

    it 'Viking weapon starts as nil' do
      expect(viking.weapon).to eq(nil)
    end
  end

  describe '#pick_up_weapon' do
    it 'picks up and sets a weapon' do
      viking.pick_up_weapon(Weapon.new('Axe'))
      expect(viking.weapon.name).to eq('Axe')
    end

    it 'raises an exception when picking up a non-weapon' do
      weapon_double = double('Weapon', :name => "Shoe")
      expect{viking.pick_up_weapon(weapon_double)}.to raise_error("Can't pick up that thing")
    end

    it 'picking up a new weapon replaces current weapon' do
      weapon_two = instance_double("Weapon", :name => "Sword", :is_a? => Weapon)
      viking.pick_up_weapon(weapon_two)
      expect(viking.weapon).to eq(weapon_two)
    end
  end

  describe '#drop_weapon' do
    it 'dropping a weapon leaves the Viking weaponless' do
      viking.drop_weapon
      expect(viking.weapon).to eq(nil)
    end
  end

  describe '#receive_attack' do
    it 'reduces Viking\'s health when attacked' do
      allow(viking).to receive(:puts)
      viking.receive_attack(10)
      expect(viking.health).to eq(90)
    end

    it 'calls the #take_damage method' do
      allow(viking).to receive(:puts)
      expect(viking).to receive(:take_damage).with(10)
      viking.receive_attack(10)
    end
  end

  describe '#attack' do
    let(:viking2){Viking.new('Olaf')}
    before do
      allow(viking).to receive(:puts)
      allow(viking2).to receive(:puts)
    end

    it 'cause the recipient\'s health to drop' do
      allow(viking).to receive(:damage_dealt).and_return(10)
      viking.attack(viking2)
      expect(viking2.health).to eq(90)
    end

    it 'attacking a viking calls that viking\'s #take_damage' do
      expect(viking2).to receive(:take_damage)
      viking.attack(viking2)
    end

    it '#damage_with_fists when no weapon equipped' do
      allow(viking).to receive(:damage_with_fists).and_return(10)
      expect(viking).to receive(:damage_with_fists)
      viking.attack(viking2)
    end

    it 'attacking with no weapons deals Fists multiplier * strength damage' do
      f = Fists.new
      fist_multiplier = f.use
      expect(viking2).to receive(:receive_attack).with(fist_multiplier * viking.strength)
      viking.attack(viking2)
    end

    it 'attacking with a weapon runs #damage_with_weapon' do
      weapon = instance_double("Weapon", :use => 20, :is_a? => Weapon)
      allow(viking).to receive(:damage_with_weapon).and_return(10)
      expect(viking).to receive(:damage_with_weapon)
      viking.pick_up_weapon(weapon)
      viking.attack(viking2)
    end

    it 'attacking with weapon deals damage = viking.strength * weapon.multiplier' do
      weapon = instance_double("Weapon", :use => 5, :is_a? => Weapon)
      expect(viking2).to receive(:receive_attack).with(weapon.use * viking.strength)
      viking.pick_up_weapon(weapon)
      viking.attack(viking2)
    end

    it 'attacking with a bow but no arrows deals damage with fists' do
      bow = Bow.new(0)
      viking.pick_up_weapon(bow)
      allow(viking).to receive(:damage_with_fists).and_return(10)
      expect(viking).to receive(:damage_with_fists)
      viking.attack(viking2)
    end
  end

  describe '#check_death' do
    it 'killing a viking raises an error' do
      expect{viking.receive_attack(100)}.to raise_error("#{viking.name} has Died...")
    end
  end

end