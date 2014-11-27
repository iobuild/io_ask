module IoAsk
  module TopicsHelper
    def ioask_avatar(user, options = {})
      image = if IoAsk.avatar_user_method
        # Try to use the user's custom avatar method
        user.try IoAsk.avatar_user_method.to_sym
      end

      image_tag image, :alt => "Avatar" if image.present?
    end
  end
end
