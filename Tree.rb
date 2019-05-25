class Tree
  attr_accessor :children,:value,:type,:number
  def initialize(value, type,number)
    @value=value
    @children=[]
    @type=type
    @number=number
  end
end