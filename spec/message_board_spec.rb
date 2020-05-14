require 'rspec'
require 'pry'
require 'board'
require 'message'

describe '#Board' do
  before (:each) do
     Board.clear()
   end

  describe('#save') do
    it('updates the message board with a new board') do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
      board2 = Board.new({:name => "Cooking", :id => nil})
      board2.save()
      expect(Board.all).to(eq([board, board2]))
    end
  end

  describe('.all') do
    it('returns an empty array when there are no boards') do
      expect(Board.all).to(eq([]))
    end
  end

  describe('.clear') do
    it("clears all boards") do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
      board2 = Board.new({:name => "Cooking", :id => nil})
      board2.save()
      Board.clear
      expect(Board.all).to(eq([]))
    end
  end

  describe('#==') do
    it('is the same board if it has the same attributes as another board') do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
      board2 = Board.new({:name => "Music", :id => nil})
      board2.save()
      expect(board).to(eq(board2))
    end
  end

  describe('#update') do
    it('updats a board by id') do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
      board.update("will this work?")
      expect(board.name).to(eq("will this work?"))
    end
  end

  describe('.find') do
    it('it finds a board by id') do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
      board2 = Board.new({:name => "Music", :id => nil})
      board2.save()
      expect(Board.find(board.id)).to(eq(board))
    end
  end

  describe('#delete') do
    it('deletes a board by id') do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
      board2 = Board.new({:name => "Cooking", :id => nil})
      board2.save()
      board.delete()
      expect(Board.all).to(eq([board2]))
    end
  end

  describe('messages') do
    it('finds all messages that belong to one board by id') do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
      message = Message.new({:name => "test", :body => "this message is a test", :id => nil, :board_id => board.id})
      message.save()
      message2 = Message.new({:name => "test2", :body => "message here", :id => nil, :board_id => board.id})
      message2.save()
      expect(board.messages).to(eq([message, message2]))
    end
  end

  describe('.search') do
    it("returns an array of boards that have a name that includes the search term regardless of case") do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
      board2 = Board.new({:name => "Cooking", :id => nil})
      board2.save()
      board3 = Board.new({:name => "Games", :id => nil})
      board3.save()
      board4 = Board.new({:name => "Music Stuff", :id => nil})
      board4.save()
      expect(Board.search("music")).to(eq([[board], [board4]]))
      board4.save()
    end
  end

  describe('timestamp initialize') do
    it('adds a timestamp to all boards when they are created') do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
    expect(board.timestamp).to(eq(board.timestamp))
    end
  end

  describe('.sort_by_time') do
    it('returns an array of boards sorted by their timestamp property') do
      board = Board.new({:name => "Music", :id => nil})
      board.save()
      board2 = Board.new({:name => "Cooking", :id => nil})
      board2.save()
      board3 = Board.new({:name => "Games", :id => nil})
      board3.save()
      board4 = Board.new({:name => "Music Stuff", :id => nil})
      board4.save()
    expect(Board.sort_by_time(false)).to(eq([board, board2, board3, board4]))
    end
  end

end