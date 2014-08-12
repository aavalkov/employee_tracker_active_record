class Projects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.column :name, :string
      t.column :employee_id, :int
      t.column :status, :string
    end
  end
end
