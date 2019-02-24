# coding: utf-8
# Card
class Card
  attr_accessor :num, :suit
  def initialize(suit, num)
    @suit = suit
    @num = num
  end
end

# 手札
class Cards
  attr_accessor :cards
  def initialize(cards)
    @cards = cards
  end
  def is_one_pair()
    for i in 0..(cards.count-2) do
      for j in (i+1)..(cards.count-1) do
        if cards[i].num == cards[j].num
          return true
        end
      end
    end
    return false
  end
  def is_two_pair()
    for i in 0..(cards.count-2) do
      for j in (i+1)..(cards.count-1) do
        if cards[i].num == cards[j].num
          cards_2 = cards.dup
          cards_2.delete(cards[i])
          cards_2.delete(cards[j])
          return Cards.new(cards_2).is_one_pair
        end
      end
    end
    return false
  end
  def is_three_card()
    cards.any?{|c_i| cards.filter{|c_j| c_j.num == c_i.num }.count >= 3 }
  end
  def is_four_card()
    cards.any?{|c_i| cards.filter{|c_j| c_j.num == c_i.num }.count >= 4 }
  end
  def get_hand
    if is_four_card
      return "four card"
    elsif is_three_card
      return "three card"
    elsif is_two_pair
      return "two pair"
    elsif is_one_pair
      return "one pair"
    else
      "none"
    end
  end
end

def create_deck()
  result = []
  4.times do |i|
    13.times do |j|
      result.push Card.new(i, j)
    end
  end
  result
end
def test_create_deck(xs,ys)
  result = []
  xs.each do |x|
    ys.each do |y|
      result.push Card.new(x,y)
    end
  end
  result
end

# cards = Cards.new(test_create_deck([1, 2, 3, 4, 4], [2, 2, 4, 4, 5]).take(5))
cards = Cards.new(create_deck.shuffle.take(5))
p cards.cards.map{ |c| c.num }
p cards.get_hand
cnt = 0
while !cards.is_four_card do
  cards = Cards.new(create_deck.shuffle.take(5))
  p cards.cards.map{ |c| c.num }
  p cards.get_hand
  cnt+=1
end
p cnt
