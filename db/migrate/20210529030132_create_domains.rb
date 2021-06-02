# frozen_string_literal: true

class CreateDomains < ActiveRecord::Migration[6.1]
  def change
    create_table :domains do |t|
      t.string :hostname, null: false
      t.datetime :created_at, null: false, precision: 6
    end

    add_index :domains, :hostname, unique: true
  end
end
