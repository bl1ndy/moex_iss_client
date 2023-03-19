# frozen_string_literal: true

require 'spec_helper'
require 'moex_iss_client/security'
require 'moex_iss_client/history_validator'

RSpec.describe MoexIssClient::Security do
  let(:raw_history) { File.read('spec/fixtures/iss_history.xml') }
  let(:security) { described_class.new(raw_history) }
  let(:validator) { instance_double(MoexIssClient::HistoryValidator) }

  describe '#initialize' do
    it 'calls #validate on instance of MoexIssClient::HistoryValidator' do
      allow(MoexIssClient::HistoryValidator).to receive(:new).and_return(validator)
      allow(validator).to receive(:validate).with(raw_history)

      security

      expect(validator).to have_received(:validate)
    end

    it 'assigns @history to an instance of REXML::Document' do
      expect(security.history).to be_an_instance_of(REXML::Document)
    end
  end

  describe '#last_price' do
    it 'returns value of attribute <CLOSE> of the last data sample' do
      expect(security.last_price).to eq('112.89')
    end
  end

  describe '#shortname' do
    it 'returns value of attribute <SHORTNAME> of the last data sample' do
      expect(security.shortname).to eq('МосБиржа')
    end
  end

  describe '#sec_id' do
    it 'returns value of attribute <SECID> of the last data sample' do
      expect(security.sec_id).to eq('MOEX')
    end
  end

  describe '#attribute' do
    it 'returns value of specified attribute of the last data sample' do
      expect(security.attribute('tradedate')).to eq('2023-03-17')
    end

    it 'returns nil if attribute does not present in the data sample' do
      expect(security.attribute('something_invalid')).to be_nil
    end
  end
end
