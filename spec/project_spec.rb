require 'spec_helper'

describe Project do
  it "belongs to an employee" do
    employee = Employee.create({:name => "Rusty"})
    project = Project.create({:name => "Sell Stuff",:employee_id => employee.id, :status => "open"})
    project.employee.should eq employee
  end
end
