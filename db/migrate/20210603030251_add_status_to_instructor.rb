class AddStatusToInstructor < ActiveRecord::Migration[6.1]
  def change
    add_column :instructors, :status, :integer, default: 0
  end
end
