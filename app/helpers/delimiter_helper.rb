# frozen_string_literal: true

module DelimiterHelper
  def detect_delimiter(line)
    return '|' if line.include?('|')
    return ',' if line.include?(',')
  end
end
