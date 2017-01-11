class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  after_filter :user_activity

  include PublicActivity::StoreController
  
  def load_activities
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: current_user.friends.map {|u| u.id})
    if @activities.count > current_user.notification_count
      @stat = Stat.first
      @amount_to_be_added =  (@activities.count - current_user.notification_count)*@stat.rate
      current_user.notification_count = @activities.count     
      current_user.wallet_amount = current_user.wallet_amount + @amount_to_be_added
      current_user.save
    end 
    @activities = @activities.limit(20)
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

  
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  private

	def user_activity
	  current_user.try :touch
	end
end
