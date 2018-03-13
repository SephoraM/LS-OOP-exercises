class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
    Shelter.add_available_pet(self)
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Owner
  attr_reader :name, :number_of_pets

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end

  def add_pet
    @number_of_pets += 1
  end
end

class Shelter
  @@available_pets = []

  def initialize
    @owners = {}
    @adopted_pets = []
  end

  def adopt(owner, pet)
    owners.key?(owner) ? owners[owner] << pet : owners[owner] = [pet]
    owner.add_pet
    adopted(pet)
  end

  def adopted(pet)
    adopted_pets << pet
    @@available_pets.delete(pet)
  end

  def print_adoptions
    owners.each do |owner, pets|
      puts "#{owner.name} has adopted the following pets:"
      pets.each { |pet| puts pet }
      puts ""
    end
  end

  def self.add_available_pet(new_pet)
    @@available_pets << new_pet
  end

  def pets_left
    @@available_pets.size
  end

  def print_available_pets
    puts "The Animal Shelter has the following unadopted pets:"
    @@available_pets.each { |pet| puts pet }
    puts ""
  end

  protected

  attr_reader :owners, :adopted_pets
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_adoptions
shelter.print_available_pets
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has #{shelter.pets_left} unadopted pets."

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin
#
# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester
#
# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.
