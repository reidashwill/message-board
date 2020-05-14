require 'rspec'
require 'board'
require 'message'
require 'pry'

describe '#message' do
  
  before(:each) do
    Message.clear()
    Board.clear()
    @board = board = Board.new({:name => "Music", :id => nil})
    board.save()
  end

  describe('#==') do
    it ('is the same message if it has the same attributes as anothe message') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message2 = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      expect(message).to(eq(message2))
    end
  end

  describe('.all') do
    it('returns an array of all messages') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message.save()
      message2 = Message.new({:name => "test2", :body => "message here", :id => nil, :board_id => @board.id})
      message2.save()
      expect(Message.all).to(eq([message, message2]))

    end
  end

  describe('.clear') do
    it('clears all messages')do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message.save()
      message2 = Message.new({:name => "test2", :body => "message here", :id => nil, :board_id => @board.id})
      message2.save()
      Message.clear()
      expect(Message.all).to(eq([]))
    end
  end

  describe('#save') do
    it('save message on the board we are calling') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message.save()
      expect(Message.all).to(eq([message]))
    end
  end

  describe('.find') do
    it('finds a message by id') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message.save()
      message2 = Message.new({:name => "test2", :body => "message here", :id => nil, :board_id => @board.id})
      message2.save()
      expect(Message.find(message.id)).to(eq(message))
    end
  end

  describe('#update') do
    it('updates the board with a new message') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message.save()
      message.update("new name", "this is the new body of the message")
      expect(message.name).to(eq("new name"))
      expect(message.body).to(eq("this is the new body of the message"))
    end
  end

  describe('#delete') do
    it('deletes a message by id') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message.save()
      message2 = Message.new({:name => "test2", :body => "message here", :id => nil, :board_id => @board.id})
      message2.save()
      message.delete()
      expect(Message.all).to(eq([message2]))
    end
  end

  describe('.find_by_board') do
    it('finds all messages inside a board based on board id') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message.save()
      message2 = Message.new({:name => "test2", :body => "message here", :id => nil, :board_id => @board.id})
      message2.save()
      expect(Message.find_by_board(@board.id)).to(eq([message, message2]))
    end
  end

  describe('board') do
    it('finds the board a message belongs to') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message.save()
      expect(message.board()).to(eq(@board))
    end
  end

  describe('.search') do
    it ('returns array of messages that have a name including the search term, regardless of case') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
      message.save()
      expect(Message.search("test")).to(eq([[message]]))
    end
  end

  describe('timestamp initialize') do
    it('adds a timestamp to all messages when they are created') do
    message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
    message.save()
    expect(message.timestamp).to(eq(message.timestamp))
    end
  end

  describe('.sort_by_time') do
    it('returns an array of messages sorted by their timestamp property') do
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => @board.id})
    message.save()
    message2 = Message.new({:name => "testing", :body => "this message is another test", :id => nil, :board_id => @board.id})
    message2.save()
    expect(Message.sort_by_time(false)).to(eq([message, message2]))
    end
  end
end