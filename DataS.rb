require_relative 'DataRound.rb'

class DataS
    attr_accessor :id_machine, :rounds
  
    def initialize(id_machine)
      @id_machine = id_machine
      @rounds = []
    end

    def add_content(round)
        round.each do |data|
            title = false
            type = ''
            data.each do |play|
              play.each do |card|
                if title
                  title = false
                  data_round = DataRound.new(type, card['cartaMaquina'], card['cartasLanzadas'])
                  @rounds.push(data_round)
                else
                  type = card
                  title = true
                end
              end
            end
        end
    end
  end