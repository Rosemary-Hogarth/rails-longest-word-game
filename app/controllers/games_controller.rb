require 'open-uri'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U)
  #  display a new random grid and a form
  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end
  # form will be submitted (with POST) to the score action.
  def score
      @word = params[:word].upcase
      @letters = params[:letters].split
      @included = included?(@word, @letters)
      @english_word = english_word?(@word)
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(word, letters)
    word.chars.all? { |letter| letters.include?(letter) }
  end
end
