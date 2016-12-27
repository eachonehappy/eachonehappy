module ApplicationHelper
  def resource_name

  :user
  end

  def resource

  @resource ||= User.new

  end

  def devise_mapping

  @devise_mapping ||= Devise.mappings[:user]

  end

  def chat_rooms
  	current_user.chat_rooms
  end

  def chat_room_messages(room)
  	room.messages
  end

  def reject_current_user(room)
    @user = room.users.reject {|user| user == current_user} 
    return @user.first
  end



  def include_messages(room)
    room.include(:messages)
    
  end

  def friend_chat_room(friend_id)
    @user = User.find(friend_id)
    @a = @user.chat_rooms
    @b = current_user.chat_rooms
    @chat_room = @a && @b
    return @chat_room
  end

  def full_name(user)
    "#{user.first_name} #{user.last_name}" 
  end

  def organization_member?(organization)
    current_user.organization_users.where(:organization_id => organization.id).where(:status=>"accepted").present?
  end

  def invitation_send?(organization)
    current_user.organization_users.where(:organization_id => organization.id).where(:status=>"send_by_user").present?
  end

  def invitation_came?(organization)
    current_user.organization_users.where(:organization_id => organization.id).where(:status=>"send_by_owner").present?
  end

  def owner?(organization)
    current_user.organization_users.where(:organization_id => organization.id).where(:role=>"owner").present?
  end

  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
              opts
  end
  
end
