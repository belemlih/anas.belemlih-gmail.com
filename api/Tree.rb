class Tree
  attr_accessor :children,:value,:type,:number, :id
  def initialize(value, type,number,id)
    @value=value
    @children=[]
    @type=type
    @number=number
    @id=id
  end
end