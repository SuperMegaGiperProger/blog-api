# frozen_string_literal: true

class PostCreator
  def initialize(params)
    @params = params
  end

  def execute
    ActiveRecord::Base.transaction do
      fail_result unless params_valid?

      create_post

      fail_result unless post_valid?
    end

    @failed ? { successed: false, errors: @errors } : { successed: true, post: @post }
  end

  private

  def fail_result
    @failed = true

    raise ActiveRecord::Rollback
  end

  def create_post
    @post = Post.create post_params

    @errors.concat @post.errors.full_messages if @post.errors.present?

    @post
  end

  def post_params
    @post_params ||= @params.slice(:title, :body, :author_ip).merge(user: user)
  end

  def post_valid?
    @post&.errors&.blank?
  end

  def user
    query = "INSERT INTO users (login, created_at, updated_at) VALUES ('#{@params[:author_login]}', NOW(), NOW())" \
            ' ON CONFLICT (login) DO UPDATE SET login=EXCLUDED.login RETURNING *'

    result = User.connection.execute query

    @user = User.new result.to_a.first
  end

  def params_valid?
    return @params_valid unless @params_valid.nil?

    @errors ||= []

    %i[title body author_login].each do |param_key|
      value = @params[param_key]

      @errors.push("#{param_key} can't be blank") if value.blank?
    end

    @params_valid = @errors.blank?
  end
end
