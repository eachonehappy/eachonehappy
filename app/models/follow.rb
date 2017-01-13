class Follow < Socialization::ActiveRecordStores::Follow
  include PublicActivity::Model
  tracked
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }

end
