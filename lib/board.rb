class Board

  attr_reader :id, :timestamp 
  attr_accessor :name
  
  @@total_rows = 0
  @@boards = {}

  def initialize (attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id) || @@total_rows += 1
    @timestamp = Time.now
  end

  def self.all
    @@boards.values()
  end

  def self.clear
    @@total_rows = 0
    @@boards = {}
  end

  def self.find(id)
    @@boards[id]
  end

  def save
    @@boards[self.id] = Board.new({:name => self.name, :id => self.id})
  end

  def ==(board_to_compare)
    self.name() == board_to_compare.name()
  end  

  def update(name)
    self.name = name
    self.save()
  end

  def delete
    @@boards.delete(self.id)
  end

  def messages
    Message.find_by_board(self.id)
  end

  def self.search(name)
    board_names = Board.all.map { |b| b.name.downcase }
    result = []
    names = board_names.grep(/#{name}/)
    names.each do |n|
      display_boards = Board.all.select { |b| b.name.downcase == n}
      result.push(display_boards)
    end
    result
  end

  def self.sort_by_time(recent)
    output = Board.all.sort {|b| b.timestamp.to_i}
    if (recent) 
      output
    elsif (!recent)
      output.reverse
    end
  end

end