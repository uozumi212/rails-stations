class ReservationsController < ApplicationController

  def new
    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])
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
    @schedule = Schedule.find(params[:reservation][:schedule_id])
    @sheet = Sheet.find(params[:reservation][:sheet_id])
    @movie = @schedule.movie

    existing_reservation = Reservation.find_by(schedule: @schedule, sheet: @sheet)

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

  rescue ActiveRecord::RecordNotFound
    flash[:error] = '指定したリソースが見つかりません。'
    redirect_to movie_reservation_path(@movie.id, schedule_id: @schedule.id, date: @reservation.date)
  end

  private


  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :name, :email)
  end
end
