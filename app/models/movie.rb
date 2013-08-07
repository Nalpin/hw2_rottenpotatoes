class Movie < ActiveRecord::Base
  def self.all_ratings
    #debugger
    Movie.select(:rating).map(&:rating).uniq
  end
end
