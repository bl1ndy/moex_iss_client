# frozen_string_literal: true

require 'faraday'

module MoexIssClient
  class Client
    ROOT_ENDPOINT = 'https://iss.moex.com/iss'

    attr_reader :client

    def initialize
      @client = Faraday.new(
        url: ROOT_ENDPOINT,
        headers: { 'Content-Type' => 'application/xml' }
      )
    end

    def history(sec_id, options = {})
      raise ArgumentError, 'Invalid security ID' if sec_id.to_s.empty?

      params = history_params(sec_id, options)

      client.get(params[:path], { from: params[:from], till: params[:till] }).body
    end

    private

    def history_params(sec_id, options)
      market = options[:market] == 'bonds' ? 'bonds' : 'shares'
      board = market == 'bonds' ? 'tqob' : 'tqbr'

      {
        path: "history/engines/stock/markets/#{market}/boards/#{board}/securities/#{sec_id}",
        from: options[:from] || Date.today.prev_day(6).to_s,
        till: options[:till] || Date.today.to_s
      }
    end
  end
end
