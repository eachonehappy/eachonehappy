class PagesController < ApplicationController
  def home
  	@post = Post.new
  end

  def about_us
  end

  def contact_us
  end
end
