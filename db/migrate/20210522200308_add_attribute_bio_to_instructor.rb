class AddAttributeBioToInstructor < ActiveRecord::Migration[6.1]
  def change
    add_column :instructors, :bio, :text
  end
end
