require_relative 'Card.rb'
require_relative 'Player.rb'
require_relative 'Tree.rb'
require 'json'

class Game
  # Se crean las variables de clase
  # cards: Se alamcenaran las cartas del juego
  # players: Se almacenran los jugadores
  # cards_thrown: Cartas lanzadas por los jugadores en cada ronda
  # trump_card: Carta del triunfo
  attr_accessor :cards, :players, :cards_thrown, :trump_card , :machine,:machine1,:machine2,:machine3, :aux ,:aux1,:aux2
  # se inicializa la raiz del arbol
  # Contructor: se inicializan las las varialbes de clases
  # y se lee el archivo cards.json para obtener las cartas
  def initialize
    @cards = []
    @players = []
    @cards_thrown = []
    @aux=[]
    @aux1=[]
    @aux2=[]
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
  end

  #definicion del nodo raiz o padre
  def machine
    @machine=Tree.new(0,0,0)
    @machine1=Tree.new(0,0,0)
    @machine2=Tree.new(0,0,0)
    @machine3=Tree.new(0,0,0)
    @machine.value=""
  end

  # create_player: Agrega un jugador a la lista de jugadores
  #
  # name: nombre del jugador
  def create_player(id,name)
    @players.push(Player.new(id, name, 0))
  end

  # distribuete_cards: Selecciona la carta del triunfo y
  # reparte las cartas de una en una a cada
  # jugador hasta que lleguen a 8 cartas
  def distribute_cards
    i=0
    while @players[0].cards.length != 8
      @players.each do |player|
        card = select_card
        @trump_card = card if @cards.length == 25
        player.cards.push(card)

        if(player.id.to_i==1)
        elsif(player.id.to_i==2)
          @machine.children() << Tree.new(card.value.to_s,card.type.to_s,card.number.to_s)
          # puts @machine.children[0].number.to_s
          #puts card.number.to_s
        elsif(player.id.to_i==3)

        elsif(player.id.to_i==4)

        elsif(player.id.to_i==5)

        end

      end

    end
  end

  #metodo que ordena los nodos cuando alguno es eliminado
  def delete_node(value,card)

    (0..value.children().length-1).each do |i|

      if ((value.children[i].number.to_s+""+value.children[i].type.to_s)==card.to_s)
        value.children[i].value=""
        value.children[i].type=""
        value.children[i].number=""

        (i..value.children().length).each do |j|
          if(j+1<value.children().length)
            aux=value.children[j+1]
            value.children[j+1]=value.children[j]
            value.children[j]=aux
          end
        end

      end
      # puts "valor"+value.children[i].value.to_s+"etiqueta"+value.children[i].number.to_s+" "+value.children[i].type.to_s

    end
  end

  def cards_to_tree

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
      save_card_into_player_win(@players[player_random])
      cont += 1
    end
    who_win

  end

  # who_win: Recorre el array de players y dentro,
  # recorre el array de cartas ganadas de cada jugador
  # haciendo la suma de las cartas ganadas guardando el resultado
  # en la variable de poinst de cada jugador,
  # Una vez finalizado ordena el array de players de mayor
  # a menor con la variable poinst, se selecciona el primer player
  # y se muestran los datos del nombre y los puntos del jugador ganador
  # despues se listan los jugadores con sus cartas
  def who_win
    @players.each do |player|
      result_sum = 0
      player.cards_wins.each do |cards|
        result_sum += cards.value.to_i
      end
      player.points = result_sum
    end
    players_win = @players.sort_by(&:points).reverse![0]
    puts 'GANADOR--------GANADOR---------GANADOR----'
    puts "Nombre: #{players_win.name} || Puntos: #{players_win.points}"
    #players_win.cards_wins.each do |cards|
    #  puts cards.id
    #end
    @players.each do |player|
      puts ''
      puts player.name
      puts 'Cartas: '
      player.cards_wins.each do |cards|
        print "#{cards.id}"
        print ' || '
      end
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
      puts "cartas lanzadaas"+card.type.to_s
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
    puts "values"+num_player.to_s
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
    puts "lanzar"+player.id
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

    #condicional para validar la opcion a elejir por la maquina
    if(player.id.to_i==2)
      puts 'Carta lanzada por la maquina'
      puts "player"+player.id.to_s
      card_id=min_max
      puts  "valor maquina"+card_id.to_s
      card = search_card(player, card_id)
      if !card.nil?
        delete_node(@machine,card_id)
        player.card_thrown = card
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
      puts 'Digite el id de la carta a lanzar'
      puts "player"+player.id.to_s
      card_id = gets.chomp.to_s
      puts "id de la carta"+card_id
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
      card_valid
    end

  end

  def min_max
    #se añade el valor del palo del triunfo a la raiz
    if(@machine.value.to_s=="")
      @machine.value= @trump_card.number
      @machine.type= @trump_card.type
    end
    puts "cartas restantes"+@players[1].cards.length.to_s
    if(@players[1].cards.length==1)
      #(0..@machine.children.length-1).each do |i|

      #  puts "carta"+i.to_s+""+@machine.children[0].number.to_s+""+@machine.children[0].type.to_s
      #end
      return  @machine.children[0].number.to_s+""+@machine.children[0].type.to_s
    end
    # if(@player.cards.length==1)
    #  puts "ultima ronda"
    #end
    @aux.clear
    @aux1.clear
    #si ya existen cartas en la mesa
    if @cards_thrown.length>0
      #obtener las cartas que sean del palo de triunfo pero que sean de mayor valor y numero que las arrojadas
      (0..@machine.children.length-1).each do |i|
        if (@machine.children[i].type==@machine.type)

          if (@machine.children[i].value.to_i==11||@machine.children[i].value.to_i==10||
          @machine.children[i].value.to_i==2||@machine.children[i].value.to_i==3||@machine.children[i].value.to_i==4&&
          @machine.children[i].number.to_s!="")
            count=0
            (0..@cards_thrown.length-1).each do |j|
              if (@machine.children[i].value.to_i>@cards_thrown[j].value.to_i &&
              @cards_thrown[j].type.to_s==@machine.type.to_s&&@machine.children[i].number.to_s!="")
                count+=1

              end
            end
            if(count==@cards_thrown.length)
              @aux << @machine.children[i]
              puts "Conditional 1"+@machine.children[i].type.to_s
            end
          elsif(@machine.children[i].number.to_i!=1&&@machine.children[i].number.to_i!=3&&@machine.children[i].number.to_i!=11&&
          @machine.children[i].number.to_i!=12&&@machine.children[i].number.to_i!=13&&@machine.children[i].number.to_s!="")
            count=0
            (0..@cards_thrown.length-1).each do |j|
              #  puts "valores del palo  lanzado2"+@cards_thrown[j].value.to_s

              if(@machine.children[i].number.to_i>@cards_thrown[j].number.to_i &&
              @cards_thrown[j].type.to_s==@machine.type.to_s&&@machine.children[i].number.to_s!="")
                count+=1
              end
              #   puts "contador2"+count.to_s
            end
            if(count==@cards_thrown.length)
              @aux << @machine.children[i]
              puts "Conditional 2"+@machine.children[i].type.to_s
            end
          end
        end
      end

      #obtener las cartas que sean del palo del primer lanzamiento, pero que sean mayores que las demas
      (0..@machine.children.length-1).each do |i|
        if (@machine.children[i].type.to_s==@cards_thrown[0].type.to_s)
          if (@machine.children[i].value.to_i==11||@machine.children[i].value.to_i==10||
          @machine.children[i].value.to_i==2||@machine.children[i].value.to_i==3||@machine.children[i].value.to_i==4&&
          @machine.children[i].number.to_s!="")
            count=0

            (0..@cards_thrown.length-1).each do |j|
              if (@machine.children[i].value.to_i>@cards_thrown[j].value.to_i &&
              @cards_thrown[j].type.to_s==@cards_thrown[0].type.to_s&&@machine.children[i].number.to_s!="")
                count+=1
              end
            end
            if(count==@cards_thrown.length)
              @aux1 << @machine.children[i]
              puts "Conditional 3"+@machine.children[i].type.to_s

            end
          elsif(@machine.children[i].number.to_i!=1&&@machine.children[i].number.to_i!=3&&@machine.children[i].number.to_i!=11&&
          @machine.children[i].number.to_i!=12&&@machine.children[i].number.to_i!=13&&@machine.children[i].number.to_s!="")
            count=0
            (0..@cards_thrown.length-1).each do |j|
              puts "cartas lanzadas metodo fail"+@cards_thrown[j].type.to_s
              if(@machine.children[i].number.to_i>@cards_thrown[j].number.to_i &&
              @cards_thrown[j].type.to_s==
              @cards_thrown[0].type.to_s)
                count+=1
              end
            end
            if(count==@cards_thrown.length)
              @aux1 << @machine.children[i]
              puts "Conditional 4"+@machine.children[i].type.to_s

            end
          end
        end
      end
      # puts "entrando al metodo validando datos"+@aux.length.to_s+"otro valor"+@aux1.length.to_s

      if(@aux.length>0)
        sort_array(@aux,0)
        puts "Conditional 74"+@aux[0].number.to_s+""+@aux[0].type.to_s

        return  @aux[0].number.to_s+""+@aux[0].type.to_s

      elsif(@aux1.length>0)
        sort_array(@aux1,0)
        puts "Conditional 73"+@aux1[0].number.to_s+""+@aux1[0].type.to_s

        return  @aux1[0].number.to_s+""+@aux1[0].type.to_s
      else
        #entra a este condicional cundo la maquina no tiene una carta con la cual pueda ganar la ronda
        @aux.clear
        @aux1.clear
        #se arroja la carta de menor valor diferente del palo de triunfo
        (0..@machine.children().length-1).each do |j|
          if @machine.children[j].type.to_s!=@machine.type.to_s&&@machine.children[j].number.to_s!=""
            @aux<<@machine.children[j]
            #return @machine.children[j].number.to_s+""+@machine.children[j].type.to_s
          end
        end
        if(@aux.length>0)
          #me ordena el mazo auxiliar con respecto valor de la carta sin tener en cuenta el numero
          sort_array(@aux,0)
          puts "Conditional 72"+@aux[0].number.to_s+""+@aux[0].type.to_s

          return @aux[0].number.to_s+""+@aux[0].type.to_s
        else
          @aux.clear
          #arrojar una carta con valor el menor valor del mazo de la maquna
          (0..@machine.children().length-1).each do |j|
            @aux <<@machine.children[j]
          end
          sort_array(@aux,0)
          puts "Conditional 71"+@aux[0].number.to_s+""+@aux[0].type.to_s

          return @aux[0].number.to_s+""+@aux[0].type.to_s

        end
      end

    else
      #Condicional que se aplica cuando la maquina va a lanzar de primeras

      @aux.clear
      @aux1.clear
      puts "entrando a valores"
      (0..@machine.children().length-1).each do |j|
        #rellenamos el arreglo auxiliar con los valores de las cartas iguales a 0 pero que no sean del palo de triunfu
        if  (@machine.children[j].value.to_i==0 && @machine.children[j].type.to_s!=@machine.type.to_s&&@machine.children[j].number.to_s!="")
          puts "entradas"+@machine.children[j].number.to_s+""+@machine.children[j].type.to_s
          @aux <<@machine.children[j]
          puts "Conditional 5"+@machine.children[j].type.to_s

        end
      end

      if(@aux.length==0)
        #si no encuentra una carta de valor 0 diferente del mazo arrojara la que tiene menor valor
        @aux.clear
        (0..@machine.children().length-1).each do |j|
          #rellenamos el arreglo auxiliar con los valores de las cartas iguales a 0 pero que no sean del palo de triunfu
          if  (@machine.children[j].value.to_i!=0 && @machine.children[j].type.to_s!=@machine.type.to_s&&@machine.children[j].type.to_s!="")
            @aux <<@machine.children[j]
            puts "Conditional 6"+@machine.children[j].type.to_s

          end
        end

        if(@aux.length>0)

          sort_array(@aux,0)
          puts "Conditional 75"+@aux[0].number.to_s+""+@aux[0].type.to_s

          return  @aux[0].number.to_s+""+@aux[0].type.to_s
        else
          puts "ultima entrada"
          @aux.clear
          (0..@machine.children().length-1).each do |j|

            if(@machine.children[j].type.to_s!="")
              @aux <<@machine.children[j]
              puts "Conditional 7"+@aux[j].number.to_s+""+@aux[j].type.to_s
            else
              puts "Conditional 7.1"+@machine.children[j].number.to_s+""+@machine.children[j].type.to_s
            end
          end
          sort_array(@aux,0)
          # puts "valores escogidos2"+ @aux[0].number.to_s+""+@aux[0].type.to_s
          puts "Conditional 8"+@aux[0].number.to_s+""+@aux[0].type.to_s

          return  @aux[0].number.to_s+""+@aux[0].type.to_s
        end
      else
        sort_array(@aux,1)
        # puts "valores escogidos3 valores que son 0 pero de otro mazo"
        #  (0..@machine.children().length-1).each do |j|
        #     puts "valores >>>>"+ @aux[j].number.to_s+""+@aux[j].type.to_s
        #   end
        #puts "valores escogidos3"+ @aux[0].number.to_s+""+@aux[0].type.to_s
        puts "Conditional 9"+@aux[0].number.to_s+""+@aux[0].type.to_s
        return  @aux[0].number.to_s+""+@aux[0].type.to_s
        #puts "resuldato"+@aux[0].type.to_s
      end
    end

    #@cards_thrown[] cartas arrojadas previamente
  end

  #metodo para ordenar arreglos por valor de la carta y numero
  def sort_array(array,opc)
    aux_sort=0

    if(opc==0)

      (0..array.length-1).each do |j|

        (1..array.length-1).each do |i|
          if array[i-1].value.to_i > array[i].value.to_i
            aux_sort = array[i - 1];
            array[i - 1] = array[i];
            array[i] = aux_sort;
          end
        end
      end
    elsif(opc==1)

      (0..array.length-1).each do |j|

        (1..array.length-1).each do |i|
          if array[i-1].number.to_i > array[i].number.to_i
            aux_sort = array[i - 1];
            array[i - 1] = array[i];
            array[i] = aux_sort;
          end
        end
      end
    end
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
(1..2).each do |i|
  puts "Ingrese el nombre del jugador #{i}"
  name = gets.chomp
  game.create_player(i.to_s,name.to_s)
end
root=Tree.new(0,0,0)
#game.throw_card_player(1)

#game.show_players()
game.machine
game.distribute_cards
game.start_game
