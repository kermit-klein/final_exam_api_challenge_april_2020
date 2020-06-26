# frozen_string_literal: true

class Api::CommentsController < ApplicationController
  def index
    article = Article.find(params[:article_id])
    raise StandardError unless article

    comments = Comment.where(article: article)
    if comments == []
      render json: { message: 'No comments to show' }, status: 404
    else
      render json: { comments: comments }
    end
  rescue StandardError
    render json: { message: "Article with id #{params[:article_id]} could not be found" }, status: 404
  end

  def create
    comment = Comment.create(comments_params)
    render json: { message: 'Success! Your comment is posted' }
  end

  private

  def comments_params
    params.permit(:body, :user_id, :article_id)
  end
end
