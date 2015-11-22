require_relative '../models/address_book'

class MenuController
  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    system "clear"
    puts "Main Menu - #{@address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - View entry by number"
    puts "3 - Create an entry"
    puts "4 - Search for an entry"
    puts "5 - Import entries from a CSV"
    puts "6 - Exit"
    print "Enter your selection: "

    selection = gets.to_i

    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      view_entry_number
      main_menu
    when 3
      system "clear"
      create_entry
      main_menu
    when 4
      system "clear"
      search_entries
      main_menu
    when 5
      system "clear"
      read_csv
      main_menu
    when 6
      puts "Good-bye!"
      exit(0)
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

  def view_all_entries
    @address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
        entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def view_entry_number
    system "clear"

    if @address_book.entries.count <= 0
      puts "Invalid option: no entries found"
      puts "Please try again. Press any key to continue"
      gets
        main_menu
    end

    entry_number = enter_entry_number

    if entry_number < 0 || entry_number.is_a?(Integer)
      puts "Invalid option: option not a valid entry or entry type"
      puts "Please try again. Press any key to continue..."
      gets
        view_entry_number
    end

    # try to display the entry using the entry_number (index) provided.
    begin
      puts @address_book.entries.fetch(entry_number).to_s

    # if the entry index given is not found, IndexError is thrown. Catch it.
    rescue IndexError
      puts "Invalid option: entry not found. (INDEX_ERROR_EXCEPTION)"
      puts "Please try again. Press any key to continue..."
      gets
        view_entry_number
    end
    print "Hit any key to continue or X/x to exit..."
    option = gets.chomp

    if option == "X" || option == "x"
      exit(0)
    end

    system "clear"
      view_entry_number
  end

  def enter_entry_number
    print "Enter a number (starting from 0): "
    entry = gets.to_i
  end

  def create_entry
    system "clear"
    puts "New AddressBloc Entry"
    print "Name: "
    name = gets.chomp
    print "Phone Number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    @address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
  end

  def read_csv
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
    when "n"
    when "d"
    when "e"
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entries_submenu(entry)
    end
  end
end
