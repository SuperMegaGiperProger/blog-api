# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe PostsController, type: :controller do
  describe 'POST create' do
    let(:params) { post_attributes.merge(author_login: author_login) }
    let(:post_attributes) { attributes_for :post }
    let(:author_login) { 'test_login' }

    subject { post :create, params: params }

    before do |test|
      next if test.metadata[:skip_before]

      subject
    end

    context 'when title is blank' do
      let(:post_attributes) { attributes_for :post, title: ' ' }

      it { expect(response.status).to eq(422) }

      it 'responds with error' do
        expect(response.body).to include_json(errors: ['title can\'t be blank'])
      end
    end

    context 'when title is not present' do
      let(:post_attributes) { attributes_for(:post).except(:title) }

      it { expect(response.status).to eq(422) }

      it 'responds with error' do
        expect(response.body).to include_json(errors: ['title can\'t be blank'])
      end
    end

    context 'when body is blank' do
      let(:post_attributes) { attributes_for :post, body: ' ' }

      it { expect(response.status).to eq(422) }

      it 'responds with error' do
        expect(response.body).to include_json(errors: ['body can\'t be blank'])
      end
    end

    context 'when author_login is blank' do
      let(:author_login) { ' ' }

      it { expect(response.status).to eq(422) }

      it 'responds with error' do
        expect(response.body).to include_json(errors: ['author_login can\'t be blank'])
      end
    end

    context 'when parameters are valid' do
      it { expect(response.status).to eq(200) }

      it 'responds with title and body' do
        expect(response.body).to include_json(title: params[:title], body: params[:body])
      end

      it 'creates user', skip_before: true do
        expect(User.exists?(login: author_login)).to be_falsey

        subject

        expect(User.exists?(login: author_login)).to be_truthy
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
