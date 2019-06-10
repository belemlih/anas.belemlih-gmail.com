class DataRound
    attr_accessor :id_round, :card_win, :cards_play
  
    def initialize(id_round, card_win, cards_play)
        @id_round = id_round
        @card_win = card_win
        @cards_play = cards_play
    end
  end