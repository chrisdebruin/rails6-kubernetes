class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.text :message

      t.timestamps
    end
  end
end
