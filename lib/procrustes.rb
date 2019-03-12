# frozen_string_literal: true

require_relative './procrustes/file_whitelister'
require_relative './procrustes/service'

module Procrustes
  ADDITIONS_MAX_NUM = ENV.fetch('ADDITIONS_MAX_NUM', 1000).to_i
end
