# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopPostsController, type: :controller do
  describe 'GET index' do
    let(:n) { 7 }
    let!(:posts) { create_list :post, 20 }
    let(:top_posts) { [3, 5, 6, 8, 10, 14, 17].map { |i| posts[i] } }

    before :suite do
      posts.first(10).each do |p|
        4.times { create :rating, post: p, value: rand(1..3) }
      end

      top_posts.each do |p|
        4.times { create :rating, post: p, value: rand(4..5) }
      end
    end

    before :each do
      get :index, params: { n: n }
    end

    it 'responds with 200 OK status' do
      expect(response.status).to eq(200)
    end

    it 'returns top N posts' do
      expect(JSON.parse(response.body)).to match(posts: top_posts)
    end
  end
end
