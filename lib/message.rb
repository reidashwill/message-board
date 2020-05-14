class Message
  attr_reader :id
  attr_accessor :name, :board_id, :body

  @@messages = {}
  @@total_rows = 0

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @body = attributes.fetch(:body)
    @id = attributes.fetch(:id) || @@total_rows +=1
    @board_id = attributes.fetch(:board_id)
  end 

  def == (message_to_compare)
    (self.name() == message_to_compare.name()) && (self.board_id() == message_to_compare.board_id())
  end

  def self.all
    @@messages.values()
  end
  
  def self.clear
    @@messages = {}
    @@total_rows = 0
  end

  def save
    @@messages[self.id] = Message.new({ :name => self.name, :body => self.body, :id => self.id, :board_id => self.board_id})
  end

end