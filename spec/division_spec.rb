require 'spec_helper'


describe Division do
  it "has many employees" do
    division = Division.create({:name => "janitorial"})
    employee1 = Employee.create({:name => "Rusty", :division_id => division.id})
    employee2 = Employee.create({:name => "Hank", :division_id => division.id})
    division.employees.should eq [employee1, employee2]
  end
end
