class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false, limit: 100
      t.text :content, null: false, limit: 10_000

      t.timestamps
    end
  end
end
