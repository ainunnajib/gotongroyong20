class Profile
  include ActiveModel::Model

  attr_accessor :id, :user

  def initialize(attributes={})
    super
    self.user = attributes[:user]
    self.id = self.user.id
  end

  def persisted?
    self.id.present?
  end
end