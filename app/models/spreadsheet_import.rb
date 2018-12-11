# class SpreadsheetImport < ApplicationRecord
# end
class SpreadsheetImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  # def initialize(attributes={})
  #   attributes.each { |name, value| send("#{name}=", value) }
  # end

  # def persisted?
  #   false
  # end

  def self.open_spreadsheet(file)
    byebug
    case File.extname(file.original_filename)
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path)
    else
      raise "Error, try again. If problem persists contact support."
    end
  end

  def self.load_imported_items(file)
    spreadsheet = SpreadsheetImport.open_spreadsheet(file)
    temp_spreadsheet = [];
    @found_bad_users = [];
    bad_users = BadUser.all

    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      temp_spreadsheet.push(row)
    end

    checkCapital = temp_spreadsheet[0].has_key?("Name")
    checkLowerCase = temp_spreadsheet[0].has_key?("name")
    checkAllCaps = temp_spreadsheet[0].has_key?("NAME")
    if checkCapital
      names = temp_spreadsheet.map {|ele| ele["Name"]}
    elsif checkLowerCase
      names = temp_spreadsheet.map {|ele| ele["name"]}
    elsif checkAllCaps
      names = temp_spreadsheet.map {|ele| ele["NAME"]}
    end

    bad_users.each do |bad_user|
      names.each do |name|
        if (bad_user.name == name)
          @found_bad_users.push(bad_user)
        end
      end
    end

    @found_bad_users
    byebug
    # redirect_to spreadsheet_import_path(@found_bad_users)
  end

  #
  # def imported_items
  #   @imported_items ||= load_imported_items
  # end

  # def save
  #   if imported_items.map(&:valid?).all?
  #     imported_items.each(&:save!)
  #     true
  #   else
  #     imported_items.each_with_index do |item, index|
  #       item.errors.full_messages.each do |msg|
  #         errors.add :base, "Row #{index + 6}: #{msg}"
  #       end
  #     end
  #     false
  #   end
  # end

end
