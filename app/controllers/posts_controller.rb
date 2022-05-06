class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]

  
  def index
    @posts = Post.all
  end

  
  def show
  end

  
  def new
    @post = Post.new
  end

  
  def edit
  end

  
  def create
    @post = Post.new(post_params)
      if @post.save
        render json: @post, message: "Post was successfully created.", status: :created, location: @post 
      else
        render json: @post.errors, status: :unprocessable_entity 
      end
  end

  
  def update 
      if @post.update(post_params)
        render json: @post, status: :ok, location: @post, message: "Post was successfully updated."
      else
        render json: @post.errors, status: :unprocessable_entity
      end
  end

  
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    
    def set_post
      @post = Post.find(params[:id])
    end

    
    def post_params
      params.permit(:title, :content)
    end
end
