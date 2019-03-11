# frozen_string_literal: true

module LocLimiter
  class Service
    CONTEXT = 'LOC limiter'

    FAILURE_STATUS = 'failure'
    SUCCESS_STATUS = 'success'
    PENDING_STATUS = 'pending'
    INITIAL_DESCRIPTION = 'Checking line size'

    PROCESSABLE_ACTIONS = %w[synchronize opened]

    attr_reader :github, :file_selector
    attr_reader :pull_request, :status, :description

    def initialize(github:, file_selector:)
      @github = github
      @status = PENDING_STATUS
      @description = INITIAL_DESCRIPTION
      @file_selector = file_selector
    end

    def perform!(payload)
      return unless PROCESSABLE_ACTIONS.include?(payload.fetch('action'))

      @pull_request = payload.fetch('pull_request')

      create_status
      @status = SUCCESS_STATUS
      @description = "Checked LOC – It smaller than #{ADDITIONS_MAX_NUM}"

      if calculated_changes > ADDITIONS_MAX_NUM
        @status = FAILURE_STATUS
        @description = "Checked LOC – It #{calculated_changes}, it's bigger than maximum #{ADDITIONS_MAX_NUM}"
      end
      create_status
    end

    def create_status
      @github.create_status(
        pull_request.dig('base', 'repo', 'full_name'),
        pull_request.dig('head', 'sha'),
        status,
        context: CONTEXT,
        description: description
      )
    end

    def calculated_changes
      @calculated_changes ||= \
        compare['files']
        .find_all { |f| file_selector.match?(f['filename']) }
        .map { |h| h['additions'] }
        .reduce(0, &:+)
    end

    def compare
      @compare ||= build_compare
    end

    def build_compare
      github.compare(
        pull_request.dig('base', 'repo', 'full_name'),
        pull_request.dig('base', 'sha'),
        pull_request.dig('head', 'sha')
      )
    end
  end
end
