module IoAsk
  module TopicsHelper
    def ioask_avatar(user, options = {})
      image = user.ioask_avatar
      image = image.gsub(/\/assets\//, '')

      image_tag image, :alt => "#{user.ioask_name}" if image.present?
    end

    def format_text(text)
      simple_format auto_link(text, :html => { :target => '_blank' })
    end

  end
end
