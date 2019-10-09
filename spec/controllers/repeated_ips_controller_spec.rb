# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe RepeatedIpsController, type: :controller do
  describe 'GET index' do
    let(:uniq_ips) { ['12.13.14.15', '12.13.14.16', '12.13.14.17', '12.13.14.18', '12.13.14.19'] }
    let(:repeated_ips) do
      {
        '10.10.10.15': [users[0], users[2]],
        '10.10.10.16': [users[1], users[3], users[4], users[7]],
        '10.10.10.17': [users[0], users[1], users[6]]
      }
    end
    let(:users) { create_list :user, 8 }

    before do
      uniq_ips.each do |ip|
        user = users.sample

        2.times { create :post, user: user, author_ip: ip }
      end

      repeated_ips.each do |ip, users|
        users.each do |user|
          create :post, user: user, author_ip: ip
        end
      end
    end

    before :each do
      get :index
    end

    it 'responds with 200 OK status' do
      expect(response.status).to eq(200)
    end

    it 'returns ips, used by multiple users' do
      result = repeated_ips.transform_values { |users| users.map(&:login) }.stringify_keys

      expect(JSON.parse(response.body)).to match(result)
    end
  end
end
# rubocop:enable Metrics/BlockLength
