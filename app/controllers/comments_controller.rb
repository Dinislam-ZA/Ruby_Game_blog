# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @user = current_user
    @comment = Comment.new(params.permit(:body, :post_id, :parent_id))
    @comment.author = @user.username
    @comment.parent_id = 0 unless params[:parent_id].present?
    @comment.save
    render json: { comment: @comment, errors: @comment.errors }
  end
end
