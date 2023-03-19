# frozen_string_literal: true

require 'rexml'

module MoexIssClient
  class HistoryValidator
    def validate(history)
      parsed_history = REXML::Document.new(history)

      raise NoHistoryError, 'Invalid or empty security history' if valid?(parsed_history)

      parsed_history
    end

    private

    def valid?(history)
      history.get_elements('//data/rows/row').empty?
    end
  end
end
