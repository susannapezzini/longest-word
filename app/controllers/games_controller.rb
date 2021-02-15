require "json"
require "open-uri"

class GamesController < ApplicationController
 
  def new
    @alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @vowels = %w[a e i o u y]
    @random_letters = 5.times.map { @vowels.sample }
    @random_letters += 5.times.map { (@alphabet - @vowels).sample }
  end

  def score
    @word = params[:word].downcase
    grid = params[:random_letters]
    # word matching grid
    input = @word.chars.all? do |letter|
      grid.count(letter) >= @word.count(letter)
    end
    if !input
      @answer = "Some letters are not included in the given grid."
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
