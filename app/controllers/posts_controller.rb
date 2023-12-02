class Admin::PostsController < ApplicationController
  def index
    @posts = Post.with_attached_image.page(params[:page]).per(10)
  end

  def show
    @post = Post.with_attached_image.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to user_posts_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render 'index'
    end
  end

  def edit
    @post = Post.with_attached_image.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to user_posts_path
    else
      flash.now[:alert] = "投稿内容の更新に失敗しました"
      render 'edit'
  end

  private

  def post_params
    params.require(:post).permit(:post, :post_status, user_id, tag_id, image)
  end

end
