class CreateWorksSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :works_schedules do |t|
      t.references :work,     null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :schedule, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :event,    null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }

      t.timestamps
    end
  end
end
