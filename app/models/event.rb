class Event < ActiveRecord::Base
  # Relations
  belongs_to :group, touch: true
  belongs_to :resource, polymorphic: true
  belongs_to :user

  # Callbacks

  # Validations

  # Scopes
  scope :exclude_group_users, -> { where.not(resource_type: 'GroupUser') }

  # Methods
end
