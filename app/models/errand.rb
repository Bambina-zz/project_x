class Errand < ActiveRecord::Base
  validates :shared_hash, uniqueness: true
  before_validation :set_dummy_user_id
  before_validation :generate_shared_hash
  has_many :tasks

  private
  def set_dummy_user_id
    self.owner_id = 1
  end

  def generate_shared_hash
    self.shared_hash = SecureRandom.uuid
  end
end
