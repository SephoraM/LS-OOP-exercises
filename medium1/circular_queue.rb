# class CircularQueue
#   def initialize(n)
#     @queue = Array.new(n)
#     @last_index = n - 1
#     @oldest_spot = 0
#     @next_spot = 0
#   end
#
#   def enqueue(value)
#     current = @queue[@next_spot]
#     @queue[@next_spot] = value
#     update_first_out unless current.nil?
#     update_first_in
#   end
#
#   def dequeue
#     last_value = @queue[@oldest_spot]
#     @queue[@oldest_spot] = nil
#     update_first_out unless last_value.nil?
#     last_value
#   end
#
#   private
#
#   def update_first_out
#     @oldest_spot = @oldest_spot == @last_index ? 0 : @oldest_spot + 1
#   end
#
#   def update_first_in
#     @next_spot = @next_spot == @last_index ? 0 : @next_spot + 1
#   end
# end

# Further Exploration

class CircularQueue
  def initialize(n)
    @queue = Array.new(n)
  end

  def enqueue(value)
    @queue.push(value)
    @queue.shift
  end

  def dequeue
    @queue.each_with_index do |value, idx|
      if !value.nil?
        @queue[idx] = nil
        return value
      end
    end
    nil
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
