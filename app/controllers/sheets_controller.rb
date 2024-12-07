class SheetsController < ApplicationController
  def index
    @sheets = Sheet.order(:row, :column)
    # @first_columns = Sheet.pluck(:row)
    # @last_columns = Sheet.pluck(:column)
  end
end
