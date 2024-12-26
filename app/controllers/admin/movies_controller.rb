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
    # @screens = Screen.all
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
    #  @screens = Screen.all

    # existing_movie = Movie.find_by(name: @movie.name)

    # if existing_movie
    #   if existing_movie.screen_id == 1
    #     new_screen_id = 2
    #   elsif existing_movie.screen_id == 2
    #     new_screen_id = 3
    #   elsif existing_movie.screen_id == 3
    #     flash.now[:error] = 'スクリーンはすでに使われています。'
    #     render :new and return
    #   end
    # else
    #   new_screen_id = 1
    # end

    # @movie.screen_id = new_screen_id

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
