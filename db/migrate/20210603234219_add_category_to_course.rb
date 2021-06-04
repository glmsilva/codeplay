class AddCategoryToCourse < ActiveRecord::Migration[6.1]
  def change
    add_reference :courses, :category, foreign_key: true, default: 1
  end
end
