require 'open-uri'
require 'json'

class GamesControllerController < ApplicationController

  def new
    # @letters = ""
    @letters = (0..9).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    letters = params[:grid].split.to_a
    # raise
    @result = Hash.new
    question = params[:question]

    filepath = "https://wagon-dictionary.herokuapp.com/#{question}"

    dict_wagon_read = open(filepath).read

    dict_wagon = JSON.parse(dict_wagon_read)

      if dict_wagon["found"] == true && resultat_user(question, letters)
        @result[:message] = "well done"
        @result
      elsif resultat_user(question, letters) == false
        @result[:message] = "not in the grid"
        @result
      else
        puts "this #{question} not an english word"
        @result[:message] = "not an english word"
        @result
      end
  end

  def resultat_user(question, letters)
    # raise
    question.chars.all? do |char|
      question.count(char) <= letters.count(char)
    end
  end
end
