class SpreadsheetImportController < ApplicationController

  def new
    @spreadsheet = SpreadsheetImport.new
  end

  def create
    #first hits this
    SpreadsheetImport.load_imported_items(params[:file])
    # render layout: false
  end

  def show
    byebug
    # @spreadsheet = SpreadsheetImport.find(params[:id])
  end

end
