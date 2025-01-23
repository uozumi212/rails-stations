class ReservationsController < ApplicationController
  def new
    # 選択されたmovie.idからMovieモデルを検索し、@movieに代入
    @movie = Movie.find_by(id: params[:movie_id])
    # 選択されたschedule.idからScheduleモデルを検索して、@scheduleに代入
    @schedule = Schedule.find_by(id: params[:schedule_id])
    @theater = Theater.find_by(id: params[:theater_id])

    unless @movie && @schedule
      redirect_to movies_path, alert: "映画またはスケジュールを選択してください"
      return
    end

    @date = params[:date]
    @sheet_id = params[:sheet_id]

    if @date.blank? || @sheet_id.blank?
      redirect_to movie_path(@movie), alert: "日付と座席を選択してください"
      return
    end

    @reservation = Reservation.new(
      schedule_id: @schedule.id,
      sheet_id: @sheet_id,
      date: @date
    )
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @theater_id = params[:reservation][:theater_id]
    @schedule = Schedule.find(params[:reservation][:schedule_id])
    @sheet = Sheet.find(params[:reservation][:sheet_id])
    @movie = @schedule.movie
    @screen = @schedule.screen
    @reservation.screen = @screen

    existing_reservation = Reservation.find_by(schedule: @schedule, sheet: @sheet, screen: @screen,
                                               theater_id: @theater)

    if existing_reservation
      flash[:error] = '指定した座席は既に予約されています。'
      redirect_to movie_path(@schedule.movie) and return
    end

    # バリデーションを実行し、失敗した場合はエラーを表示
    if @reservation.valid?
      if @reservation.save
        flash[:notice] = '予約が完了しました。'
        redirect_to movie_path(@movie.id, schedule_id: @reservation.schedule_id, date: @reservation.date)
      else
        flash.now[:error] = '予約に失敗しました'
        render :new
      end
    else
      # バリデーションエラーの場合もリダイレクト
      flash[:error] = @reservation.errors.full_messages.to_sentence
      redirect_to request.referer
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :theater_id, :screen_id, :date, :name, :email)
  end
end
