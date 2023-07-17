class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end
  
  def new
    @post = Post.new
  end
  
  def create
    post = Post.create(post_params)
    
    if post.save
    flash[:notice] = "投稿を作成しました。"
    redirect_to posts_path
    else
      flash.now[:alert] = "投稿を出来ませんでした"
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    post = Post.find_by(id: params[:id])
  end

  def update
    post = Post.find_by(id: params[:id])
    post.update(post_params)
    if post.save
      flash[:notice] ="投稿を編集しました"
      redirect_to posts_path
    else
      flash.now[:alert] = "投稿を編集できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:content).merge(user_id: current_user.id)
  end
end
