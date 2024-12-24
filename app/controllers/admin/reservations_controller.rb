class Admin::ReservationsController < ApplicationController

  def index
    @reservations = Reservation.includes(schedule: :movie).order('date')
  end


  def new
    @reservation = Reservation.new
    @movies = Movie.all.map { |movie| [movie.name, movie.id] }
    @sheets = Sheet.all
    @dates = (Date.current..Date.current + 6.days).map { |date| [date.strftime("%Y-%m-%d"), date] }
    @schedules = Schedule.all.map { |schedule| [schedule.start_time.strftime("%H:%M"), schedule.id] }
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @movies = Movie.all.map { |movie| [movie.name, movie.id] }
    @sheets = Sheet.all
    @dates = (Date.current..Date.current + 6.days).map { |date| [date.strftime("%Y-%m-%d"), date] }
    @schedules = Schedule.all.map { |schedule| [schedule.start_time.strftime("%H:%M"), schedule.id] }
  end

  def update
    @reservation = Reservation.find(params[:id])
    new_schedule = Schedule.find_by(movie_id: params[:reservation][:movie_id])

    if new_schedule.nil?
      flash[:error] = '指定した日付のスケジュールはありません。'
      redirect_to edit_admin_reservation_path(@reservation) and return
    end

    if Reservation.exists?(schedule: new_schedule, sheet_id: params[:reservation][:sheet_id]) &&
       @reservation.sheet_id != params[:reservation][:sheet_id].to_i
       flash[:error] = "指定した座席はすでに予約されています。"
       redirect_to edit_admin_reservation_path(@reservation) and return
    end

    if @reservation.update(reservation_params.merge(schedule: new_schedule))
      flash[:notice] = '予約が更新されました。'
      redirect_to admin_reservations_path
    else
      flash[:error] = @reservation.errors.full_messages.to_sentence
      redirect_to edit_admin_reservation_path(@reservation)
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = '予約が削除されました。'
    redirect_to admin_reservations_path
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @sheet = Sheet.find_by(id: params[:reservation][:sheet_id])

    if @sheet.nil?
      # flash[:error] = '指定した座席は存在しません。'
      # redirect_to new_admin_reservation_path and return
          render json: { error: '指定した座席は存在しません。' }, status: :bad_request and return
    end

    @reservation.sheet = @sheet

    if Reservation.exists?(schedule_id: params[:reservation][:schedule_id], sheet_id: params[:reservation][:sheet_id],
      date: params[:reservation][:date]) && @reservation.sheet_id != params[:reservation][:sheet_id].to_i
      # flash[:error] = '指定した座席は既に予約されています。'
      # redirect_to new_admin_reservation_path and return
          render json: { error: '指定した座席は既に予約されています。' }, status: :bad_request and return
    end

    # バリデーションを実行し、失敗した場合はエラーを表示
  if @reservation.valid?
    if @reservation.save
      flash[:notice] = '予約が完了しました。'
      redirect_to admin_reservations_path
    else
      flash.now[:error] = '予約に失敗しました'
      # redirect_to new_admin_reservation_path and return
            render json: { error: '予約に失敗しました' }, status: :bad_request and return
    end
  else
     # バリデーションエラーの場合もリダイレクト
    # flash[:error] = @reservation.errors.full_messages.to_sentence
    # redirect_to new_admin_reservation_path and return
        render json: { error: @reservation.errors.full_messages.to_sentence }, status: :bad_request and return

  end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :name, :email)
  end

end
