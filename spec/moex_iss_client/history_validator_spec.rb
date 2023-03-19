# frozen_string_literal: true

require 'spec_helper'
require 'moex_iss_client/history_validator'
require 'moex_iss_client/exceptions'

RSpec.describe MoexIssClient::HistoryValidator do
  let(:validator) { described_class.new }
  let(:history) { File.read('spec/fixtures/iss_history.xml') }
  let(:empty_history) { File.read('spec/fixtures/iss_empty_history.xml') }

  describe '#validate' do
    it 'returns history if it is valid' do
      expect(validator.validate(history).inspect).to eq(REXML::Document.new(history).inspect)
    end

    it 'raises NoHistoryError if history is empty' do
      expect do
        validator.validate(empty_history)
      end.to raise_error(MoexIssClient::NoHistoryError, 'Invalid or empty security history')
    end

    it 'raises NoHistoryError if history is invalid' do
      expect do
        validator.validate('something')
      end.to raise_error(MoexIssClient::NoHistoryError, 'Invalid or empty security history')
    end
  end
end
