# frozen_string_literal: true

class CreateStatusTypeEnum < ActiveRecord::Migration[6.1]
  def up
    create_enum :status_type, %w[success error]
  end

  def down
    drop_enum :status_type
  end
end
