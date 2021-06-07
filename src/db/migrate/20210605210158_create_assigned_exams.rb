class CreateAssignedExams < ActiveRecord::Migration[6.1]
  def change
    create_table :assigned_exams do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true

      t.timestamps
    end
  end
end
