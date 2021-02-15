require "json"
require "open-uri"

class GamesController < ApplicationController
 
  def new
    @alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @random_letters = 10.times.map { @alphabet.sample }
  end

  def score
    @word = params[:word]
    grid = params[:random_letters]
    # word matching grid
    input = @word.chars.all? do |letter|
      grid.count(letter) >= @word.count(letter)
    end
    if !input
      @answer = "This letter is not included."
    elsif !realword?(@word)
      @answer = "This is not an english word."
    end
  end

  def realword?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    uri = open(url)
    hash = JSON.parse(uri.read)
    hash['found']
  end
end
