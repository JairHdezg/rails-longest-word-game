require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters.push(('a'..'z').to_a.sample.capitalize) }
  end

  def score
    @word = params[:word]
    @grid = params[:letters].split('')
    @valid_attempt = attempt_json(@word)
    if @valid_attempt['found'] && can_be_build?(@word, @grid)
      @result = 'valid'
      @score = @word.length
    elsif @valid_attempt['found'] == false
      @result = 'not a word'
      @score = 0
    else
      @result = 'not in the grid'
      @score = 0
    end
    session[:score] = session[:score].nil? ? @score : session[:score] + @score
    @total_score = session[:score]
  end

  def attempt_json(word)
    url = 'https://wagon-dictionary.herokuapp.com/'
    JSON.parse(open(url + word).read)
  end

  def can_be_build?(word, grid)
    word = word.upcase
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

end
