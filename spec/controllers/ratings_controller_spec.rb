# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  describe 'POST create' do
    let(:postRecord) { create :post }
    let(:post_id) { postRecord.id }

    it 'creates rating record' do
      expect do
        post :create, params: { post_id: post_id, value: 2 }
      end.to change { Rating.count }.by(1)
    end

    it 'calculates and return new average value' do
      post :create, params: { post_id: post_id, value: 1 }

      expect(response.body).to include_json(avg_rating: 1)

      post :create, params: { post_id: post_id, value: 2 }

      expect(response.body).to include_json(avg_rating: 1.5)

      post :create, params: { post_id: post_id, value: 3 }

      expect(response.body).to include_json(avg_rating: 2)
    end

    it 'responds with Created 201 status' do
      post :create, params: { post_id: post_id, value: 5 }

      expect(response.status).to eq(201)
    end
  end
end
