class Admin::SchedulesController < ApplicationController
  before_action :set_schedule, only: [:edit, :update, :destroy]
  def index
    @schedules = Schedule.all

    # @movies = []
    # @schedules.each do |schedule|
    #   @movies << schedule.movie
    # end
    @movies = Movie.includes(:schedules).distinct
  end
  def show
    @schedule = Schedule.find(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      redirect_to admin_schedules_path
    else
      render :edit
    end
  end


  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to admin_schedules_path, notice: "削除しました。"
  end

  def new
    @schedule = Schedule.new
    @movie = Movie.find(params[:movie_id])
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @schedule = @movie.schedules.build(schedule_params)

      if @schedule.save
        flash[:notice] = 'スケジュールが登録されました。'
        redirect_to admin_movies_path
      else
        render :new
      end
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time)
  end


end
