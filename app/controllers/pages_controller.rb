class PagesController < ApplicationController
  def home
  	@post = Post.new
  	@comment = Comment.new
  	@posts = Post.all.sort_by(&:created_at).reverse
  	@all_user = User.all

  end

  def about_us
  end

  def contact_us
  end
end
