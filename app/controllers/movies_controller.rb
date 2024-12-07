class MoviesController < ApplicationController
  def index

     @movies = Movie.all

     if params[:keyword].present?
      @movies = @movies.search(params[:keyword])
     end

     if params[:is_showing].present?
      @movies = @movies.by_showing_status(params[:is_showing])
     end

     if params[:is_showing].present? && params[:is_showing] != ''
      @movies = @movies.by_showing_status(params[:is_showing])
    end

     @keyword = params[:keyword]
  end
end
