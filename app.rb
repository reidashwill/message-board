require('sinatra')
require('sinatra/reloader')
require('./lib/board')
require('./lib/message')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  @boards = Board.all
  erb(:boards)
end

get('/boards') do
  redirect to ('/')
end

get('/boards/:id') do
  @board = Board.find(params[:id].to_i)
  @messages = Message.find_by_board(@board.id)
  erb(:board)
end

post('/boards') do
  name = params[:board_name]
  board = Board.new({:name => name, :id => nil})
  board.save()
  redirect to ('/')
end

post('/boards/:id') do
  @board = Board.find(params[:id].to_i)
  name = params[:message_name]
  body = params[:message_body]
  message = Message.new({:name => name, :body => body, :id => nil, :board_id => @board.id})
  message.save()
  @messages = Message.all
  erb(:board)
end