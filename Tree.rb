class Tree
  attr_accessor :children,:value,:type
  def initialize(value, type)
    @value=value
    @children=[]
    @type=type
  end
end