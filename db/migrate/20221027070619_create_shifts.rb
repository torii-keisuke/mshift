class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.references :member,   null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :work,     null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :schedule, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :event,    null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }

      t.timestamps
    end
  end
end
