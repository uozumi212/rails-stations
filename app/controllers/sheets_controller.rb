class SheetsController < ApplicationController
  def index
    @sheets = Sheet.order(:row, :column)
  end
end
