class PostsController < ApplicationController
  def show
    render json: Post.find(params[:id]), include: params[:include]
  end
end
