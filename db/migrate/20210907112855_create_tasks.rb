class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.text :summary
      t.timestamp :performed_at

      t.timestamps
    end
  end
end
