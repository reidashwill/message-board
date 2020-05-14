require 'rspec'
require 'pry'
require 'board'

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

end