module Admin
 class MoviesController < ApplicationController

  def index
    @movies = Movie.all
    @schedules = []
    @movies.each do |movie|
      @schedules << movie.schedules
    end
  end


  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
  end


  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to admin_movies_path(@movie), flash: { success: '映画が正常に更新されました。' }
    else
      flash.now[:error] = '映画の更新に失敗しました。'
      render :edit
    end
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to admin_movies_path, flash: { success:  '正常に映画が登録されました。' }
    else
      flash.now[:error] = '映画の登録に失敗しました。'
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to admin_movies_path,  flash: { success:  '正常に映画が削除されました。' }
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end
 end
end
