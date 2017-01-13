class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
before_action :select_causes

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def select_causes
    @major_causes = Cause.all.sort_by(&:likers_count).last(10)
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
