# Complete this class so that the test cases shown below work as intended. You
# are free to add any methods or instance variables you need. However, do not
# make the implementation details public.
#
# You may assume that the input will always fit in your terminal window.

# Further Exploration: Modify this class so new will optionally let you specify
# a fixed banner width at the time the Banner object is created. The message in
# the banner should be centered within the banner of that width. Decide for
# yourself how you want to handle widths that are either too narrow or too wide.

class Banner
  BORDER = 2

  def initialize(message, banner_width = message.size + 4)
    @message = message
    @banner_width = require_minimum(banner_width)
    @padding = calculate_padding
    @msg_width = @banner_width - @padding - BORDER
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line,
     horizontal_rule].join("\n")
  end

  private
  attr_reader :message, :msg_width, :banner_width, :padding

  def calculate_padding
    banner_width - 4 > message.size ? banner_width - message.size - BORDER : 2
  end

  def inner_width
    msg_width + padding
  end

  def formatted(msg)
    msg_pad = (inner_width - msg.size)
    pad1, extra = msg_pad.divmod(2)
    pad2 = pad1 + extra
    "|#{" " * pad1}#{msg}#{" " * pad2}|"
  end

  def minimum_length
    (message.split.map(&:size).max || 0) + 4
  end

  def require_minimum(banner_length)
    banner_length < minimum_length ? minimum_length : banner_length
  end

  def horizontal_rule
    "+#{"-" * inner_width}+"
  end

  def empty_line
    "|#{" " * inner_width}|"
  end

  def last_space(msg)
    (msg.size - 1).downto(0) { |i| return i if msg[i] == " " }
  end

  def line_wrap
    portions = []
    msg = message.clone
    loop do
      length = last_space(msg[0, msg_width])
      portion = msg.slice!(0, length)
      portions << formatted(portion)
      msg = msg.strip
      break if msg.size <= msg_width
    end
    portions << formatted(msg) unless msg.empty?
    portions
  end

  def message_line
    if msg_width < message.size
      line_wrap
    else
      formatted(message)
    end
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('', 20)
puts banner
# +------------------+
# |                  |
# |                  |
# |                  |
# +------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

banner = Banner.new('To boldly go where no one has gone before.', 20)
puts banner
# +------------------+
# |                  |
# | To boldly go     |
# | where no one     |
# | has gone before. |
# |                  |
# +------------------+

banner = Banner.new('To boldly go where no one has gone before.', 2)
puts banner
# +---------+
# |         |
# |   To    |
# | boldly  |
# |   go    |
# |  where  |
# | no one  |
# |   has   |
# |  gone   |
# | before. |
# |         |
# +---------+

banner = Banner.new('To boldly go where no one has gone before.', 60)
puts banner
