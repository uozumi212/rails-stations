class Users::RegistrationsController < Devise::RegistrationsController
  # 必要なメソッドをオーバーライド
  def create
    super do |resource|
      if resource.persisted?
        redirect_to_with_302(after_sign_up_path_for(resource)) and return
      end
    end
  end
end
