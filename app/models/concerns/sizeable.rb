module Sizeable
  extend ActiveSupport::Concern
  
  # Public: Calculates a hash of attachment urls per size
  #
  # Returns a hash
  def image_urls
    Rails.cache.fetch "#{self.class}:#{self.id}:image_urls" do
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
