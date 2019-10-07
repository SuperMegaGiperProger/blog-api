# frozen_string_literal: true

class PostsController < ApplicationController
  def create
    result = PostCreator.new(post_params).execute

    if result[:successed]
      render json: result[:post].slice(:title, :body)
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :author_login, :author_ip)
  end
end
