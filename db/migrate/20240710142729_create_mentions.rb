class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.references :report, foreign_key: true, null: false
      t.references :mentioned_report, foreign_key: { to_table: :reports }, null: false

      t.timestamps
    end
      add_index :mentions, [:report_id, :mentioned_report_id], unique: true
  end
end
