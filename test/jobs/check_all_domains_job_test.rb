# frozen_string_literal: true

require 'test_helper'

class CheckAllDomainsJobTest < ActiveJob::TestCase
  test 'should enqueue jobs for all domains' do
    Domain.create(hostname: 'example.com')
    Domain.create(hostname: 'a.example.com')
    assert_equal 2, Domain.count

    perform_enqueued_jobs only: CheckAllDomainsJob do
      assert_enqueued_jobs 2, only: UpdateDomainStatusJob do
        CheckAllDomainsJob.perform_later
      end
    end
  end
end
