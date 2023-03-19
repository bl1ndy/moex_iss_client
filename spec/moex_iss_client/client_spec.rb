# frozen_string_literal: true

require 'spec_helper'
require 'moex_iss_client/client'

RSpec.describe MoexIssClient::Client do
  let(:http_client) { described_class.new }
  let(:from) { Date.today.prev_day(6).to_s }
  let(:till) { Date.today.to_s }
  let(:uri_with_default_params) { "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/tqbr/securities/MOEX?from=#{from}&till=#{till}" }
  let(:uri_with_custom_params) do
    'https://iss.moex.com/iss/history/engines/stock/markets/bonds/boards/tqob/securities/MOEX?from=2023-03-01&till=2023-03-05'
  end

  describe '#initialize' do
    it 'assigns @client to an instance of Faraday::Connection' do
      expect(http_client.client).to be_an_instance_of(Faraday::Connection)
    end
  end

  describe '#history' do
    before do
      stub_request(:get, /iss.moex.com/).to_return(body: '<history></history>', status: 200)
    end

    it 'makes request with default params' do
      http_client.history('MOEX')

      expect(WebMock).to have_requested(:get, uri_with_default_params).once
    end

    it 'makes request with custom params' do
      http_client.history('MOEX', market: 'bonds', from: '2023-03-01', till: '2023-03-05')

      expect(WebMock).to have_requested(:get, uri_with_custom_params).once
    end

    it 'returns response body' do
      expect(http_client.history('MOEX')).to eq('<history></history>')
    end

    it 'raises an error when security ID is empty or nil' do
      expect { http_client.history('') }.to raise_error(ArgumentError, 'Invalid security ID')
      expect { http_client.history(nil) }.to raise_error(ArgumentError, 'Invalid security ID')
    end
  end
end
