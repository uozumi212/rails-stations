# require 'pry'
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

  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.schedules
    @theaters = Theater.all

    if @schedules.empty?
      flash[:notice] = "映画は今日から7日間後まで上映されていません。"
    end
    # binding.pry
  end

  def reservation
    @movie = Movie.find_by(id: params[:id])
    @date = params[:date]
    @schedule_id = params[:schedule_id]
    # @schedule = @movie.schedules.where(id: @schedule_id)
    @theater = params[:theater_id] # URLからtheater_idを取得して設定

    if @movie.nil?
      flash[:error] = '指定した映画が見つかりません。'
      redirect_to movie_path(@movie)
      return
    end

    if @schedule_id.blank? || @date.blank?
      flash[:error] = '日付と上映時間を選択してください。'
      redirect_to movie_path(@movie) and return
    end

    @schedule = Schedule.find_by(id: @schedule_id)

    if @schedule_id.nil?
      flash[:error] = '指定したスケジュールが見つかりません。'
      redirect_to movie_path(@movie)
      return
    end

    # @sheets = Sheet.all.includes(:reservations)
    @screen = Screen.first
    @sheets = @screen.sheets.order(:row, :column)
    @reserved_sheets = @schedule.reservations.pluck(:sheet_id)
    @reservations = Reservation.where(date: @date, schedule_id: @schedule.id)
  end
end
