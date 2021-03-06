require 'sinatra'
require './hangman.rb'
require 'random-word'
enable :sessions


get '/' do
  session[:game_state] = nil
  erb :index
end

get '/play' do
  if session[:game_state]
    @game = HangmanGame.new(session[:game_state])
  else
    @game = HangmanGame.new({target_word: RandomWord.nouns.next})
  end

  session[:game_state] = @game.to_hash
  redirect to('/end') if @game.over?
  erb :play
end

get '/end' do
  if session[:game_state]
    @game = HangmanGame.new(session[:game_state])
  else
    @game = HangmanGame.new({target_word: RandomWord.nouns.next})
  end

  erb :end
end

post '/guess' do
  #"Parameter: #{params[:aparam]}"

  "output word: #{game.target_word}"

  if session[:game_state]
    "output word: #{@game.target_word}"

  else
    "I don't have a game state bro"
  end
end
