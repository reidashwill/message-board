class Message
  attr_reader :id, :timestamp
  attr_accessor :name, :board_id, :body

  @@messages = {}
  @@total_rows = 0

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @body = attributes.fetch(:body)
    @id = attributes.fetch(:id) || @@total_rows +=1
    @board_id = attributes.fetch(:board_id)
    @timestamp = Time.now
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

  def self.find(id)
    @@messages[id]
  end

  def save
    @@messages[self.id] = Message.new({ :name => self.name, :body => self.body, :id => self.id, :board_id => self.board_id})
  end

  def update(name, body)
    self.name = name
    self.body = body
    self.save
  end

  def delete
    @@messages.delete(self.id)
  end

  def self.find_by_board(brd_id)
    messages = []
    @@messages.values.each do |message|
      if message.board_id == brd_id
        messages.push(message)
      end
    end
    messages
  end

  def board
    Board.find(self.board_id)
  end

  def self.search(name)
    message_names = Message.all.map { |b| b.name.downcase }
    result = []
    names = message_names.grep(/#{name}/)
    names.each do |n|
      display_messages = Message.all.select { |b| b.name.downcase == n}
      result.push(display_messages)
    end
    result
  end

  def self.sort_by_time(recent)
    output = Message.all.sort {|m| m.timestamp.to_i}
    if (recent) 
      output
    elsif (!recent)
      output.reverse
    end
  end

end