require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    if check_word == true && params[:word].chars.all?.in?(params[:letters])
      return @score = "Congratulations! #{params[:word]} is a valid English word!"
    elsif check_word == false
      return @score = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      return @score = "Sorry but #{params[:word]} can't be built out of #{params[:letters]} "
    end
  end

  def check_word
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json['found']
  end
end
