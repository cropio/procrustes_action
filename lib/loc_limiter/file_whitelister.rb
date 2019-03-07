# frozen_string_literal: true

module LocLimiter
  class FileWhitelister
    def match?(filename)
      return false if filename.include?('spec.rb')

      true
    end
  end
end
