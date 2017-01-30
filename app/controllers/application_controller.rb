class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  after_action :user_activity
  include PublicActivity::StoreController
  
  def load_activities
    if user_signed_in?
      @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: current_user.friends.map {|u| u.id})
      @activities = @activities.reject{|activity| activity.key == "like.destroy" }
      @activities = @activities.reject{|activity| activity.key == "follow.destroy" }  
      @activities = @activities.first(20)
      @chat_rooms = current_user.chat_rooms
      @messages = []
      @chat_rooms.each do |chat_room|
        chat_room.messages.each do |message|
          unless message.user == current_user
            @messages << message
          end
        end
      end  
    end  
  end
  
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  private

	def user_activity
    if user_signed_in?
	     current_user.try :touch
    end   
	end
end
