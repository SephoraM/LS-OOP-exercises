class Cat
  def initialize(name)
    @name = name
    greeting
  end

  def greeting
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')