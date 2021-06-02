# frozen_string_literal: true

require 'test_helper'

class HostnameValidatorTest < ActiveSupport::TestCase
  class Validatable
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :hostname
    validates :hostname, hostname: true
  end

  test 'should validate hostname' do
    assert Validatable.new(hostname: 'example.com').valid?
    assert Validatable.new(hostname: 'a.b.c.example.com').valid?

    assert_not Validatable.new(hostname: 'localhost').valid?
    assert_not Validatable.new(hostname: 'домен.рф').valid?
    assert_not Validatable.new(hostname: '').valid?
    assert_not Validatable.new(hostname: '.').valid?
    assert_not Validatable.new(hostname: '_').valid?
    assert_not Validatable.new(hostname: nil).valid?
  end
end
