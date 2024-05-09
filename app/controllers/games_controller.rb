require 'net/http'
require 'json'

class GamesController < ApplicationController

  #  display a new random grid and a form
  def new
    grid_size = 10
    @letters = Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end
  # form will be submitted (with POST) to the score action.
  def score
    if @letters.nil?
      @message = "An error occurred. Please try again later."
    else
      word = params[:word].upcase
      letters = @letters.map(&:upcase)

      puts "Submitted Word: #{word}"
      puts "Grid Letters: #{@letters}"

      uri = URI.parse("https://dictionary.lewagon.com/#{word}")
      response = Net::HTTP.get_response(uri)
      json = JSON.parse(response.body)
      word_found = json['found'] # Assign the result of the operation to a variable

      if word.chars.all? { |letter| letters.include?(letter) }
        if word_found
          @message = "Well done!"
        else
          @message = "This isn't an English word."
        end
      else
        @message = "These letters are not on the grid."
      end
    end
  end
end
