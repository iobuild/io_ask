module IoAsk
  module TopicsHelper
    def ioask_avatar(user, options = {})
      image = user.ioask_avatar

      image_tag image, :alt => "#{user.ioask_name}" if image.present?
    end
  end
end
