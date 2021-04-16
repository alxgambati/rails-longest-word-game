require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)].capitalize }
  end

  def score
    @letters = params[:letters]
    @result = 'You missed!'
    str = params[:phrase]
    @result = "String belongs to Grid!"  if include_letters(str)

    url = "https://wagon-dictionary.herokuapp.com/#{str}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)

    @result = "Congrats!  you made an English Word" if user['found']
  end

  def include_letters(str)
    str.chars.select {|letter| !@letters.include?(letter.capitalize) }.join.empty?
  end
end
