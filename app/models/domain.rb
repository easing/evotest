# frozen_string_literal: true

# == Schema Information
#
# Table name: domains
#
#  id         :bigint           not null, primary key
#  hostname   :string           not null
#  created_at :datetime         not null
#
class Domain < ActiveRecord::Base
  has_many :statuses, foreign_key: :hostname, primary_key: :hostname
  has_one :status, -> { where(current: true) }, foreign_key: :hostname, primary_key: :hostname

  validates :hostname, presence: true, uniqueness: true, hostname: true

  # Запрещает update. Можно только создавать и удалять домены.
  alias readonly? persisted?
end
