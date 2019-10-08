# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopPostsController, type: :controller do
  describe 'GET index' do
    let(:n) { 3 }
    let!(:posts) { create_list :post, 10 }
    let(:top_posts) { [5, 3, 6].map { |i| posts[i] } }

    before do
      posts.first(5).each do |p|
        next if top_posts.include? p

        create :rating, post: p, value: rand(1..2)
      end

      create :rating, post: top_posts[0], value: 5
      create :rating, post: top_posts[1], value: 4
      create :rating, post: top_posts[2], value: 3

      posts.each(&:reload)
    end

    before :each do
      get :index, params: { n: n }
    end

    it 'responds with 200 OK status' do
      expect(response.status).to eq(200)
    end

    it 'returns top N posts' do
      result = ActiveModelSerializers::SerializableResource.new(top_posts).to_json

      expect(JSON.parse(response.body)).to match(JSON.parse(result))
    end
  end
end
