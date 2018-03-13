class Card
  include Comparable
  attr_reader :rank, :suit

  RANKING = (2..10).to_a + %w(Jack Queen King Ace).freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    RANKING.index(rank) <=> RANKING.index(other.rank)
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    populate
  end

  def draw
    pop ||
    repopulate_and_pop
  end

  private

  def populate
    @cards = generate_deck.shuffle
  end

  def pop
    @cards.pop
  end

  def repopulate_and_pop
    populate
    pop
  end

  def generate_deck
    SUITS.map { |suit| RANKS.map { |rank| Card.new(rank, suit) } }.flatten
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
drawn.count { |card| card.rank == 5 } == 4
drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
