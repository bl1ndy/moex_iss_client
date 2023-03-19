# frozen_string_literal: true

require 'rexml'

module MoexIssClient
  class Security
    attr_reader :history

    def initialize(history)
      @history = HistoryValidator.new.validate(history)
    end

    def last_price
      last_data_sample['CLOSE']
    end

    def shortname
      last_data_sample['SHORTNAME']
    end

    def sec_id
      last_data_sample['SECID']
    end

    def attribute(attr)
      last_data_sample[attr.to_s.upcase]
    end

    private

    def last_data_sample
      history.get_elements('//data/rows/row[last()]').first
    end
  end
end
