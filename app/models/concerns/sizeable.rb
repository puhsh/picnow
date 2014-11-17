module Sizeable
  extend ActiveSupport::Concern
  
  # Public: Calculates a hash of attachment expiring_url(10)s per size
  #
  # Returns a hash
  def image_urls
    {
      large: attachment.expiring_url(60, :large),
      original: attachment.expiring_url(60),
      medium: attachment.expiring_url(60, :medium),
      small: attachment.expiring_url(60, :small),
      thumbnail: attachment.expiring_url(60, :thumbnail)
    }
  end

  private

  # Private: Determines the attribute for a paperclip attachnment
  #
  # Returns a Paperclip::Atachment
  def attachment
    case self
    when User
      avatar
    when Photo
      image
    else
      raise Paperclip::AdapterRegistry::NoHandlerError
    end
  end
end
