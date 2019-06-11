require_relative 'Card.rb'
require_relative 'Player.rb'
require_relative 'Canto.rb'
require 'json'
require_relative 'DataS.rb'
class Game
  # Se crean las variables de clase
  # cards: Se alamcenaran las cartas del juego
  # players: Se almacenran los jugadores
  # cards_thrown: Cartas lanzadas por los jugadores en cada ronda
  # trump_card: Carta del triunfo
  # type_cards: Vector de los palos para cantar
  attr_accessor :cards, :players, :cards_thrown, :trump_card, :type_cards, :roundS, :card_machine, :data_rounds, :machine_data, :card_win_round

  # Contructor: se inicializan las las varialbes de clases
  # y se lee el archivo cards.json para obtener las cartas
  def initialize
    @card_machine = ''
    @card_win_round = ''
    @cards = []
    @players = []
    @cards_thrown = []
    @roundS = []
    @data_rounds = []
    @type_cards = [Canto.new('bastos', false), Canto.new('copas', false), Canto.new('oros', false), Canto.new('espadas', false)]
    cards_json = File.read('cards.json')
    cards_data = JSON.load cards_json
    cards_data.each do |data|
      title = false
      type = ''
      data.each do |card|
        if title
          save_card(card, type)
          title = false
        else
          type = card
          title = true
        end
      end
    end
    load_file_plays()
  end

  # create_player: Agrega un jugador a la lista de jugadores
  #
  # name: nombre del jugador
  def create_player(id, name, isMachine)
    @players.push(Player.new(id, name, 0, isMachine))
  end

  # distribuete_cards: Selecciona la carta del triunfo y
  # reparte las cartas de una en una a cada
  # jugador hasta que lleguen a 8 cartas
  def distribute_cards
    while @players[0].cards.length != 8
      @players.each do |player|
        card = select_card
        @trump_card = card if @cards.length == 25
        if player.isMachine
          player.add_card(card)
        else
          player.cards.push(card)
        end
      end

    end
  end

  # Muestra las cartas de cada jugador
  def show_players
    puts @cards.length
    @players.each do |player|
      puts "Nombre: #{player.name}"
      player.cards.each do |card|
        puts card.id
      end
    end
  end

  # Selecciona quien inicia la partida y luego hace un ciclo hasta que los jugadores se queden sin cartas
  # En el ciclo se muestra la ronda que se esta jugando
  # llama a ronda
  # luego llama whoWinRound()
  # Y muestra quien gano la ronda con la carta que gano
  # Al terminar el ciclo, llama a who_win
  def start_game
    player_random = select_player_random
    cont = 1
    until @players[0].cards.empty?
      puts "Ronda #{cont}"
      round(player_random)
      player_random = whoWinRound(player_random)
      puts "------------Ganador de la ronda #{cont} ------------------"
      puts "Nombre: #{@players[player_random].name}, Con"
      puts "Carta: #{@players[player_random].card_thrown.number} , #{@players[player_random].card_thrown.type}"
      @card_win_round = @players[player_random].card_thrown.id
      add_round(cont)
      save_card_into_player_win(@players[player_random])
      cont += 1
      puts
    end
    who_win
  end

  def load_file_plays
    count_machines = 0
    machine_plays_file = File.read('machinePlays.json')
    machine_plays_data = JSON.load machine_plays_file
    file = ''
    machine_plays_data.each do |data|
      title = false
      type = ''
      data.each do |play|
        if title
          title = false
          varS = DataS.new(type)
          varS.add_content(play)
          @data_rounds.push(varS)
        else
          type = play
          title = true
        end
      end
    end
    count_machines = machine_plays_data.length + 1
    machine = "Maquina_#{count_machines}"
    @machine_data = DataS.new(machine)
  end

  def add_round(cont)
    round = ''
    machine = ''
    table_cards = ''
    if @cards_thrown.length == @players.length
      @cards_thrown.each do |card_t|
        table_cards = "#{table_cards} #{card_t.id}"
      end
      if cont < 8
        data_round = DataRound.new("ronda_#{cont}", @card_win_round, table_cards)
        @machine_data.rounds.push(data_round)
      else
        data_round = DataRound.new("ronda_#{cont}", @card_win_round, table_cards)
        @machine_data.rounds.push(data_round)
        @data_rounds.push(@machine_data)
        File.open("machinePlays.json", "w+") do |f|
          f.puts(JSON.pretty_generate(get_json))
        end
      end
    end
  end

  def get_json
    json_data = '{'
    (0..@data_rounds.length - 1).each do |game|
      json_data += "\"#{@data_rounds[game].id_machine}\":["
      (0..@data_rounds[game].rounds.length - 1).each do |round|
        json_data += "{"
        json_data += "\"#{@data_rounds[game].rounds[round].id_round}\":{\"cartasLanzadas\":\"#{@data_rounds[game].rounds[round].cards_play}\","
        json_data += "\"cartaGanadora\":\"#{@data_rounds[game].rounds[round].card_win}\"}"
        if @data_rounds[game].rounds.length - 1 == round
          json_data += "}"
        else
          json_data += "},"
        end
      end
      if @data_rounds.length - 1 == game
        json_data += "]"
      else
        json_data += "],"
      end
    end
    json_data += '}'
    return JSON.parse(json_data)
  end

  # who_win: Recorre el array de players y dentro,
  # recorre el array de cartas ganadas de cada jugador
  # haciendo la suma de las cartas ganadas guardando el resultado
  # en la variable de points de cada jugador,
  # Una vez finalizado ordena el array de players de mayor
  # a menor con la variable points, se selecciona el primer player
  # y se muestran los datos del nombre y los puntos del jugador ganador
  # despues se listan los jugadores con sus cartas
  def who_win
    @players.each do |player|
      result_sum = 0
      player.cards_wins.each do |cards|
        result_sum += cards.value.to_i
      end
      player.points += result_sum
    end
    players_win = @players.sort_by(&:points).reverse![0]
    puts 'GANADOR--------GANADOR---------GANADOR----'
    puts "Nombre: #{players_win.name}"
    puts '-----------------------TABLA DE RESULTADOS------------------------'
    #players_win.cards_wins.each do |cards|
    #  puts cards.id
    #end
    @players.each do |player|
      puts ''
      puts '------------------------------------------------------------------'
      puts "Nombre: #{player.name} || Puntos: #{player.points}"
      puts 'Cartas Ganadas: '
      player.cards_wins.each do |cards|
        print "#{cards.id}"
        print ' || '
      end
      puts ''
      puts '------------------------------------------------------------------'
    end
  end

  # save_card_into_player_win: Guarda las cartas que estan en la mesa
  # en el array de cartas ganadas que tiene el player,
  # y las va elminando de la lista de cartas de la mesa.
  #
  # player: Jugador que gano la ronda
  def save_card_into_player_win(player)
    cont = @cards_thrown.length - 1
    while cont >= 0
      card = @cards_thrown[cont]
      player.cards_wins.push(card)
      @cards_thrown.delete_at(cont)
      cont -= 1
    end
  end

  # whoWinRound: Toma la carta del player que empezo la ronda
  # luego hace un ciclo recorriendo los players.
  # En el ciclo toma la carta del player,
  # valida que si la carta del player que inicio la ronda no es la misma
  # que la del player a comprobar.
  # Si no son las mismas, valida que el tipo de la carta del player sea igual
  # al tipo de la carta del triunfo o que el tipo de la carta del player que
  # inicio la ronda sea igual al del triunfo.
  # Si alguno de los dos es valido va a validate_card_with_trump y
  # guarda el resultado.
  # Si no va a validate_card_without_trump y guarda el resultado
  # Luego comprueba que save_card_win no sea nulo
  # Si no es nulo guarda el resultado.
  #
  # Luego recorre la lista de players y comprueba si la carta que lanzo el
  # jugador es igual a la carta que se selecciona como ganadora retorna la
  # posicion del player
  #
  # num_player_start: posicion del player que inicio la ronda
  def whoWinRound(num_player_start)
    cont = 0
    card_win = @players[num_player_start].card_thrown
    while cont <= (@players.length - 1)
      card = @players[cont].card_thrown
      if card_win != card
        if card.type.to_s == @trump_card.type.to_s || card_win.type.to_s == @trump_card.type.to_s
          aux_card = validate_card_with_trump(card, card_win)
        else
          aux_card = validate_card_without_trump(card, card_win)
        end
        if save_card_win(aux_card).nil?
        else
          card_win = save_card_win(aux_card)
        end
      end
      cont += 1
    end
    cont_player = 0
    while cont_player <= (@players.length - 1)
      return cont_player if @players[cont_player].card_thrown == card_win
      cont_player += 1
    end
  end

  # round: recorre la lista de players desde el jugador que inicio la ronda
  # hasta que llega a una posicion antes de el.
  # Si hay cartas en la mesa, las muestra por cada jugador
  #
  # num_player: numero que selecciona que jugador inicia la ronda
  def round(num_player)
    cont = 1
    while cont <= @players.length
      num_player = 0 if num_player == @players.length
      throw_card_player(@players[num_player])
      if @cards_thrown.length.zero?
      else
        puts '--------Cartas en la mesa-------'
        @cards_thrown.each do |card|
          puts "Carta: Numero: #{card.number} Tipo: #{card.type} "
        end
        puts '--------------------------------'
        puts
      end
      cont += 1
      num_player += 1
    end
  end

  # throw_card_player: Muestra las cartas del player y va a get_card,
  # si el resultado no es valido vuelve a get_card hasta que sea valido
  #
  # player: Es el player que va a lanzar
  def throw_card_player(player)
    puts "Carta del triunfo: Numero: #{@trump_card.number}, Tipo: #{@trump_card.type}"
    puts "Turno para el jugador: #{player.name}"
    puts "-------------------------------------Sus Cartas-----------------------------------------"
    player.cards.each do |card|
      print card.id
      print ' || '
    end
    card_valid = true
    while card_valid
      card_valid = get_card(player, card_valid)
    end
  end

  # search_card: Busca la carta en las cartas del player, Si la encuentra,
  # retorna la carta, si no, retorna null
  #
  # player: Es el player
  # id_card: El id de la carta seleccionada
  def search_card(player, id_card)
    player.cards.each do |card|
      return card if id_card.to_s == card.id.to_s
    end
    NIL
  end

  # select_player_random: Selecciona aleatoriamente un player y lo retorna
  def select_player_random
    num_player = rand(@players.length)
    num_player
  end

  private

  # save_card_win: Si la carta que recive no es unal guarda la carta y la retorna
  # aux_card: Carta a validar
  def save_card_win(aux_card)
    if aux_card.nil?
    else
      card_win = aux_card
    end
    card_win
  end

  # validate_card_with_trump: Comprueba si el tipo de carta del
  # player a comprobar es igual al tipo de carta del triunfo Y
  # si el tipo de carta del player que inicio es diferente al tipo
  # de carta del triunfo, retorna la carta del player a comprobar.
  # Si no.
  # Comprueba si el tipo de carta del player que inicio es igual al tipo
  # de carta del triunfo Y si el tipo de carta del player a comprobar es
  # diferente al tipo de carta del triunfo,
  # retorna la carta del player que inicio
  #
  # card: La carta del player a comprobar
  # card_win: La carta del player que inicio la ronda
  def validate_card_with_trump(card, card_win)
    if card.type.to_s == @trump_card.type.to_s &&
        card_win.type.to_s != @trump_card.type.to_s
      return card
    elsif card_win.type.to_s == @trump_card.type.to_s &&
        card.type.to_s != @trump_card.type.to_s
      return card_win
    end

    if !card_win.value.to_i.zero? || !card.value.to_i.zero?
      return card if card_win.value.to_i < card.value.to_i
    elsif card_win.number.to_i < card.number.to_i
      return card
    end
    NIL
  end

  # validate_card_without_trump: Comprueba si el tipo de la carta del player
  # que lanzo de primeras, es igual a la del player a comprobar,
  # y si (El valor de la carta del player que inicio es 0 o
  # El valor de la carta del player a comprobar es 0),
  # devuelve la carta del player a comprobar si el valor de la carta
  # es mayor al del player que lanzo primero.
  # Si no devuelve la carta del player a comprobar si el numero
  # de la carta es mayor.
  # Si el tipo de carta no es igual devuelve null.
  #
  # card: La carta del player a comprobar
  # card_win: La carta del player que inicio la ronda
  def validate_card_without_trump(card, card_win)
    if card_win.type.to_s == card.type.to_s
      if !card_win.value.to_i.zero? || !card.value.to_i.zero?
        return card if card_win.value.to_i < card.value.to_i
      elsif card_win.number.to_i < card.number.to_i
        return card
      end
    end
    NIL
  end

  # get_card: Pide el id de la carta a lanzar por teclado,
  # luego va a search_card y si no retorna null guarda la carta en el player
  # en la variable cart_thrown (carta lanzada) luego la guarda en cards_trhown
  # (lista de cartas en la mesa) y luego la elimina de la lista de cartas del
  # player.
  # Si retorna null muestra el mensaje "Id no valido"
  #
  # player: El player que tiene que lanzar la carta
  def get_card(player, card_valid)
    puts ''
    puts '----------------------------------------------------------------------------------------'

    # condicional para validar la opcion a elejir por la maquina
    if player.isMachine
      # puts 'Carta lanzada por la maquina'
      card_id = player.min_max(@trump_card, @cards_thrown)
      # puts  "valor maquina"+card_id.to_s
      card = search_card(player, card_id)
      @card_machine = card_id
      validate_canto(player) ? card_valid : card_valid
      if !card.nil?
        player.delete_node(card_id)
        player.card_thrown = card
        puts "Carta lanzada por #{player.name}: #{card.id}"
        puts ''
        @cards_thrown.push(player.card_thrown)
        (0..player.cards.length - 1).each do |i|
          player.cards.delete_at(i) if player.cards[i] == card
        end
        card_valid = false
      else
        puts 'Id no valido'
      end
      card_valid
    else
      puts 'Digite el id de la carta a lanzar o digite canto'
      card_id = gets.chomp.to_s
      if card_id == 'canto'
        validate_canto(player) ? card_valid : card_valid
      else
        card = search_card(player, card_id)
        if !card.nil?
          player.card_thrown = card
          @cards_thrown.push(player.card_thrown)
          (0..player.cards.length - 1).each do |i|
            player.cards.delete_at(i) if player.cards[i] == card
          end
          card_valid = false
        else
          puts 'Id no valido'
        end
      end
    end
    card_valid
  end

  def validate_canto(player)
    valid_canto = false
    if @type_cards[0].status && @type_cards[1].status && @type_cards[2].status && @type_cards[3].status
      if player.isMachine
      else
        puts 'Ya se hicieron todos los cantos posibles'
      end
      valid_canto = false
    else
      @type_cards.each do |canto|
        count_cantos = 0
        player.cards.each do |card|
          type_card = card.type
          if canto.type == type_card
            if card.number == '11' || card.number == '12'
              count_cantos += 1
              if count_cantos == 2
                if canto.status == false
                  valid_canto = true
                  canto.status = true
                  puts "Canto #{type_card} Valido: +20pts"
                  player.points += 20
                  return valid_canto
                else
                  if player.isMachine
                    return valid_canto
                  else
                    puts "El canto #{canto.type} ya se hizo"
                    return valid_canto
                  end
                end
              end
            end
          end
        end
      end
      if player.isMachine
        return valid_canto
      else
        puts 'Canto no valido, no tiene las cartas necesarias'
        return valid_canto
      end
    end
    valid_canto
  end

  # save_card: Se guardan las cartas en el array cards
  # card: json de la carta
  # type: pala de la carta
  def save_card(card, type)
    card.each do |i|
      @cards.push(Card.new((i['number'].to_s + type.to_s), i['number'].to_s,
                           type.to_s, i['value'].to_s))
    end
  end

  # select_card: Selecciona una carta aleatorimanete y la retorna
  def select_card
    num_random = rand(@cards.length)
    card = @cards[num_random]
    @cards.delete_at(num_random)
    card
  end
end

game = Game.new
(1..5).each do |i|
  if i == 5
    puts "Ingrese el nombre de la maquina #{i}"
    name = gets.chomp
    game.create_player(i.to_s, name.to_s, true)
  else

    puts "Ingrese el nombre del jugador #{i}"
    name = gets.chomp
    game.create_player(i.to_s, name.to_s, false)
  end
end

#game.throw_card_player(1)
#game.show_players()
game.distribute_cards
game.start_game
