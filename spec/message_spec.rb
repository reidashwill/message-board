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

  


end