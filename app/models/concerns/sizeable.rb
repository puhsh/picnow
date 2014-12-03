module Sizeable
  extend ActiveSupport::Concern
  
  # Public: Calculates a hash of attachment urls per size
  #
  # Returns a hash
  def image_urls
    if self.kind_of?(User)
      key = "#{self.class}:#{self.id}:#{self.avatar_updated_at}:image_urls" 
    else
      key = "#{self.class}:#{self.id}:image_urls" 
    end
    Rails.cache.fetch key do
      {
        large: attachment.url(:large),
        original: attachment.url,
        medium: attachment.url(:medium),
        small: attachment.url(:small),
        thumbnail: attachment.url(:thumbnail)
      }
    end
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
