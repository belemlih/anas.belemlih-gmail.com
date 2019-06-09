class DataRound
    attr_accessor :id_round, :card_machine, :cards_play
  
    def initialize(id_round, card_machine, cards_play)
        @id_round = id_round
        @card_machine = card_machine
        @cards_play = cards_play
    end
  end