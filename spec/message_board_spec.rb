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


  
end