class Minilang
  POPPERS = ['ADD', 'SUB', 'MULT', 'DIV', 'MOD', 'POP']

  def initialize(command)
    @commands = command.split
    @stack = []
    @register = 0
  end

  def eval
    @commands.each do |c|
      return print_error("Empty stack!") if POPPERS.include?(c) && @stack.empty?
      case c
      when /[0-9]/ then @register = c.to_i
      when 'PRINT' then puts @register
      when 'PUSH'  then push
      when 'ADD'   then add
      when 'SUB'   then subs
      when 'MULT'  then mult
      when 'DIV'   then div
      when 'MOD'   then mod
      when 'POP'   then pop
      else         return print_error("Invalid token: #{c}")
      end
    end
  end

  private

  def push
    @stack.push(@register)
  end

  def add
    @register += @stack.pop
  end

  def subs
    @register -= @stack.pop
  end

  def mult
    @register *= @stack.pop
  end

  def div
    @register /= @stack.pop
  end

  def mod
    @register = @register % @stack.pop
  end

  def pop
    @register = @stack.pop
  end

  def print_error(msg)
    puts msg
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
