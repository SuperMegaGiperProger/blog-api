# frozen_string_literal: true

class TopPostsController < ApplicationController
  def index
    top_posts = Post.order(avg_rating: :desc).limit(params[:n])

    render json: top_posts
  end
end
