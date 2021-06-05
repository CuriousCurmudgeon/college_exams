class CreateExams < ActiveRecord::Migration[6.1]
  def change
    create_table :exams do |t|
      t.references :college, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps
    end
  end
end
