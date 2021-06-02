# frozen_string_literal: true

require 'resolv'

##
# Проверяет имя хостя на соответствие нашим правилам
class HostnameValidator < ActiveModel::EachValidator
  # Valid domain name regex including internationalized domain name
  # https://gist.github.com/neu5ron/66078f804f16f9bda828
  # rubocop:disable Layout/LineLength
  HOSTNAME = /\A(([\da-zA-Z])([_\w-]{,62})\.){,127}(([\da-zA-Z])[_\w-]{,61})?([\da-zA-Z]\.((xn\-\-[a-zA-Z\d]+)|([a-zA-Z\d]{2,})))\z/.freeze
  # rubocop:enable Layout/LineLength

  def validate_each(record, attribute, value)
    record.errors.add(attribute, options[:message] || 'is not a hostname') unless HOSTNAME.match?(value)
  end
end
