# frozen_string_literal: true

class CreateStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :statuses do |t|
      t.string :hostname, null: false
      t.enum :status_type, as: :status_type, null: false
      t.string :message, null: false
      t.boolean :current, null: false, default: false, index: true
      t.timestamps
    end

    add_index :statuses, [:hostname], where: 'current IS true', unique: true
  end
end
