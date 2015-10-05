class Errand < ActiveRecord::Base
  has_many :tasks

  validates :name,        presence: true
  validates :owner_id,    presence: true
  validates :shared_hash, presence: true, uniqueness: true

  before_validation :set_dummy_user_id
  before_validation :generate_shared_hash

  private
  def set_dummy_user_id
    self.owner_id = 1
  end

  def generate_shared_hash
    self.shared_hash = SecureRandom.uuid
  end
end
