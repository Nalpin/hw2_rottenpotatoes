class MoviesController < ApplicationController

  before_filter :all_ratings, :only => [:index]

  def all_ratings
    @all_ratings = Movie.all_ratings
    # debugger
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:ratings]
      @ratings = params[:ratings]
      @selected_ratings = params[:ratings].keys
    else
      @selected_ratings = @all_ratings.dup
    end

    if params[:order_by]
      @movies = Movie.find_all_by_rating(@selected_ratings, :order => params[:order_by])
      @sort_by_title = params[:order_by] == 'title'
      @sort_by_release_date = params[:order_by] == 'release_date'
    else
      @movies = Movie.find_all_by_rating(@selected_ratings)
    end
    # debugger
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
