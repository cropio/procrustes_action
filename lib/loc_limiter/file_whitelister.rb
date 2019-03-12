# frozen_string_literal: true

module LocLimiter
  class FileWhitelister
    def match?(filename)
      return false if filename.match?(/^spec\//)
      return false if filename.match?(/^public\//)
      return false if filename.match?(/^config\//)

      true
    end
  end
end
