class SpreadsheetImportController < ApplicationController

  def new
    @spreadsheet = SpreadsheetImport.new
  end

  def create
    #first hits this
    found_bad_users = []
    SpreadsheetImport.load_imported_items(params[:file], found_bad_users)
    @found_bad_users = found_bad_users

    byebug
    render "spreadsheet_import/showbad"

  end

  # def show_bad_users(bad_users)
  #   byebug
  #   render "spreadsheet_import/showbad"
  #   # show_bad_users_path(bad_users)
  # end

end
