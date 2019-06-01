require_relative 'Tree.rb'

class Player
  attr_accessor :id, :name, :points, :cards, :card_thrown, :cards_wins, :isMachine, :machine, :aux, :aux1, :aux2
  def initialize(id, name, points,isMachine)
    @id = id
    @name = name
    @points = points
    @cards = []
    @cards_wins = []
    @isMachine= isMachine
    @aux=[]
    @aux1=[]
    @aux2=[]
    if @isMachine
      @machine=Tree.new(0,0,0,0)
      @machine.value=""
    end
  end


  def add_card(card)
    @machine.children() << Tree.new(card.value.to_s,card.type.to_s,card.number.to_s,card.id.to_s)
    @cards.push(card)
  end

  # metodo que ordena los nodos cuando alguno es eliminado
  def delete_node(card)

    (0..@machine.children().length-1).each do |i|

      if ((@machine.children[i].number.to_s+""+@machine.children[i].type.to_s)==card.to_s)
        @machine.children[i].value=""
        @machine.children[i].type=""
        @machine.children[i].number=""

        (i..@machine.children().length).each do |j|
          if(j+1<@machine.children().length)
            aux=@machine.children[j+1]
            @machine.children[j+1]=@machine.children[j]
            @machine.children[j]=aux
          end
        end

      end
      # puts "valor"+@machine.children[i].value.to_s+"etiqueta"+value.@machineren[i].number.to_s+" "+value.children[i].type.to_s

    end
  end

  def min_max(trump_card, cards_thrown)
    #se añade el valor del palo del triunfo a la raiz
    if(@machine.value.to_s=="")
      @machine.value= trump_card.number
      @machine.type= trump_card.type
    end
    # puts "cartas restantes"+@cards.length.to_s
    if(@cards.length==1)
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
    if cards_thrown.length>0
      #obtener las cartas que sean del palo de triunfo pero que sean de mayor valor y numero que las arrojadas
      (0..@machine.children.length-1).each do |i|
        if (@machine.children[i].type==@machine.type)

          if (@machine.children[i].value.to_i==11||@machine.children[i].value.to_i==10||
          @machine.children[i].value.to_i==2||@machine.children[i].value.to_i==3||@machine.children[i].value.to_i==4&&
          @machine.children[i].number.to_s!="")
            count=0
            (0..cards_thrown.length-1).each do |j|
              if (@machine.children[i].value.to_i>cards_thrown[j].value.to_i &&
              cards_thrown[j].type.to_s==@machine.type.to_s&&@machine.children[i].number.to_s!="")
                count+=1

              end
            end
            if(count==cards_thrown.length)
              @aux << @machine.children[i]
               puts "Conditional 1"+@machine.children[i].type.to_s
            end
          elsif(@machine.children[i].number.to_i!=1&&@machine.children[i].number.to_i!=3&&@machine.children[i].number.to_i!=11&&
          @machine.children[i].number.to_i!=12&&@machine.children[i].number.to_i!=13&&@machine.children[i].number.to_s!="")
            count=0
            (0..cards_thrown.length-1).each do |j|
              #  puts "valores del palo  lanzado2"+cards_thrown[j].value.to_s

              if(@machine.children[i].number.to_i>cards_thrown[j].number.to_i &&
              cards_thrown[j].type.to_s==@machine.type.to_s&&@machine.children[i].number.to_s!="")
                count+=1
              end
              #   puts "contador2"+count.to_s
            end
            if(count==cards_thrown.length)
              @aux << @machine.children[i]
               puts "Conditional 2"+@machine.children[i].type.to_s
            end
          end
        end
      end

      #obtener las cartas que sean del palo del primer lanzamiento, pero que sean mayores que las demas
      (0..@machine.children.length-1).each do |i|
        if (@machine.children[i].type.to_s==cards_thrown[0].type.to_s)
          if (@machine.children[i].value.to_i==11||@machine.children[i].value.to_i==10||
          @machine.children[i].value.to_i==2||@machine.children[i].value.to_i==3||@machine.children[i].value.to_i==4&&
          @machine.children[i].number.to_s!="")
            count=0

            (0..cards_thrown.length-1).each do |j|
              if (@machine.children[i].value.to_i>cards_thrown[j].value.to_i &&
              cards_thrown[j].type.to_s==cards_thrown[0].type.to_s&&@machine.children[i].number.to_s!="")
                count+=1
              end
            end
            if(count==cards_thrown.length)
              @aux1 << @machine.children[i]
               puts "Conditional 3"+@machine.children[i].type.to_s

            end
          elsif(@machine.children[i].number.to_i!=1&&@machine.children[i].number.to_i!=3&&@machine.children[i].number.to_i!=11&&
          @machine.children[i].number.to_i!=12&&@machine.children[i].number.to_i!=13&&@machine.children[i].number.to_s!="")
            count=0
            (0..cards_thrown.length-1).each do |j|
              # puts "cartas lanzadas metodo fail"+cards_thrown[j].type.to_s
              if(@machine.children[i].number.to_i>cards_thrown[j].number.to_i &&
              cards_thrown[j].type.to_s==
              cards_thrown[0].type.to_s)
                count+=1
              end
            end
            if(count==cards_thrown.length)
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
            if(@machine.children[j].type.to_s!="")
              @aux <<@machine.children[j]
              puts "Conditional 9.1"+@aux[j].number.to_s+""+@aux[j].type.to_s
            else
              puts "Conditional 9.2"+@machine.children[j].number.to_s+""+@machine.children[j].type.to_s
            end
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
      # puts "entrando a valores"
      (0..@machine.children().length-1).each do |j|
        #rellenamos el arreglo auxiliar con los valores de las cartas iguales a 0 pero que no sean del palo de triunfu
        if  (@machine.children[j].value.to_i==0 && @machine.children[j].type.to_s!=@machine.type.to_s&&@machine.children[j].number.to_s!="")
          # puts "entradas"+@machine.children[j].number.to_s+""+@machine.children[j].type.to_s
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
          # puts "ultima entrada"
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

    #cards_thrown[] cartas arrojadas previamente
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

end