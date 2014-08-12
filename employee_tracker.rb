require 'active_record'
require './lib/employee'

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
    puts "Select 'a' to add an employee or 'e' to exit"
    puts "Select 'l' to list all employees"
    choice = gets.chomp
    case choice
    when 'a'
      add_employee
    when 'l'
      list_employees
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
end

def list_employees
  puts "Here are all of your current employees"
  Employee.all.each_with_index do |employee, index|
    puts (index + 1).to_s + ". " + employee.name
  end
end


welcome
