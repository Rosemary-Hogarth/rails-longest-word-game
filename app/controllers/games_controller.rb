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

      if @included &&  @english_word
        @user_score = calculate_score
        session[:user_score] = @user_score
      else
        @user_score = 0
      end
  rescue StandardError => e
    Rails.logger.error "An error occurred while fetching word definition: #{e.message}"
    @user_score = 0 # Set a default score in case of error
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(word, letters)
    word.chars.all? { |letter| letters.include?(letter) }
  end

  def calculate_score
    @word.length
  end
end
