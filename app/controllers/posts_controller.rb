# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :user_is_signed_up, only: %i[edit create update new]

  def topic
    page_token = params.key?(:older) ? params[:older] : params[:newer]
    @topic = Topic.find_by(alias: params[:topic])
    paginate(page_token, @topic.id)
    render 'index'
  end

  def index
    page_token = params.key?(:older) ? params[:older] : params[:newer]

    paginate(page_token)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find_by(id: @post.created_by)
    @comments = Comment.comments_for_post(@post.id)
    @replies = Comment.replies_for_post(@post.id)
  end

  def edit
    @topics = Topic.all
    @post = Post.find(params[:id])
    unless current_user.id == @post.created_by
      flash[:notice] = 'This page is available only for author'
      redirect_back(fallback_location: root_path)
    end
  end

  def new
    @topics = Topic.all
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.created_by = @user.id
    if @post.save
      redirect_to "/posts/#{@post.id}"
    else
      @topics = Topic.all
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    unless current_user.id == @post.created_by
      flash[:notice] = 'This page is available only for author'
      redirect_back(fallback_location: root_path)
    end
    if @post.update(post_params)
      redirect_to "/posts/#{@post.id}"
    else
      @topics = Topic.all
      render 'edit'
    end
  end

  private

  def post_params
    params[:post][:topic_id] = params[:post][:topic]
    params.require(:post).permit(:title, :body, :topic_id)
  end

  def paginate(page_token, topic_id = nil)
    pagination = Services::Pagination.new(page_token, topic_id)

    @posts = if page_token.present?
               if params.key?(:newer)
                 pagination.newer
               else
                 pagination.older
               end
             else
               pagination.first_page
             end

    @has_newer = pagination.has_newer
    @has_older = pagination.has_older

    @page_token = pagination.construct_page_token
  end
end
