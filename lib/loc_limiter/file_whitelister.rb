# frozen_string_literal: true

module LocLimiter
  class FileWhitelister
    def match?(filename)
      return false if filename.include?('spec/')

      true
    end
  end
end
