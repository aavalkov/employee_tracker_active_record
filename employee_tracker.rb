require 'active_record'
require './lib/employee'
require './lib/division'
require 'pry'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "welcome to the employee tracker."
  main
end

def main

  choice = nil

  until choice == 'e'
    puts "Select 'a' to add an employee"
    puts "Select 'l' to view lists"
    puts "Select 'd' to add a new division"
    puts "Select 'f' to fire an employee"
    puts "Select 'e' to exit"
    choice = gets.chomp
    case choice
    when 'a'
      add_employee
    when 'f'
      fired
    when 'l'
      puts "Push '1' to list employees. Push '2' to list divsions:"
      selection = gets.chomp.to_i
      if selection == 1
        list_employees
        show_division
      elsif selection == 2
        list_division
        list_division_employees
      else
        puts "invaild selection"
      end
    when 'd'
      add_division
    when 'e'
      puts "good-bye"
    else
      puts "invaild input"
    end
  end
end

def add_employee
  puts "Enter the name of the employee"
  employee_name = gets.chomp
  employee = Employee.new({:name => employee_name})
  employee.save
  puts "Employee added."
  list_division
  puts "Enter the employee's division number"
  division_number = gets.chomp.to_i
  division_location = Division.all[division_number-1].id
  employee.update({:division_id => division_location})
end

def list_employees
  puts "Here are all of your current employees"
  Employee.all.each_with_index do |employee, index|
    puts (index + 1).to_s + ". " + employee.name
  end
end

def add_division
  puts "Enter the name of a division"
  division_name = gets.chomp
  division = Division.new({:name => division_name})
  division.save
  puts "Division added."
end

def list_division
  puts "Here are all of the companies divisions:"
  Division.all.each_with_index do |division, index|
    puts (index + 1).to_s + ". " + division.name
  end
end

def show_division
  puts "Enter the name of the employee to view their division"
  name = gets.chomp
  employee = Employee.find_by({:name => name})
  puts employee.division.name
end

def list_division_employees
  puts "to list the employees of a division, select the divsion number:"
  selection = gets.chomp.to_i
  division = Division.all[selection - 1]
  division.employees.each do |employee|
    puts employee.name
  end
end

def fired
  list_employees
  puts "select the number of the employee you want to fire:"
  selection = gets.chomp.to_i
  Employee.all[selection - 1].destroy
  puts "You heartless jerk... they have a family."
end


welcome
