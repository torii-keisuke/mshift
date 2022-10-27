class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table   :events do |t|
      t.string     :name,         null: false
      t.date       :opening_date, null: false
      t.time       :start_time,   null: false
      t.time       :finish_time,  null: false
      t.integer    :interval,     null: false
      t.references :user,         null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }

      t.timestamps
    end
  end
end
