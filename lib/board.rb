class Board

  attr_reader :id
  attr_accessor :name
  
  @@total_rows = 0
  @@boards = {}

  def initialize (attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id) || @@total_rows += 1
  end

  def self.all
    @@boards.values()
  end

  def save
    @@boards[self.id] = Board.new({:name => self.name, :id => self.id})
  end

  def ==(board_to_compare)
    self.name() == board_to_compare.name()
  end  

  def self.clear
    @@total_rows = 0
    @@boards = {}
  end



end