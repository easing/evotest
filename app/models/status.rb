# frozen_string_literal: true

# == Schema Information
#
# Table name: statuses
#
#  id          :bigint           not null, primary key
#  hostname    :string           not null
#  status_type :enum             not null
#  message     :string           not null
#  current     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Status < ActiveRecord::Base
  ERROR = 'error'
  SUCCESS = 'success'

  enum status_type: { success: SUCCESS, error: ERROR }

  belongs_to :domain, class_name: 'Domain', foreign_key: :hostname, primary_key: :hostname, required: false

  scope :currents, -> { where(current: true) }
  scope :ordered, -> { order('created_at desc') }

  validates :hostname, presence: true, hostname: true
  validates :message, presence: true

  # Запрещает update. Можно только создавать и удалять статусы.
  alias readonly? persisted?
end
