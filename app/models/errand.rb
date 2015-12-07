class Errand < ActiveRecord::Base
  has_many :tasks, dependent: :destroy

  validates :name,        presence: true
  validates :owner_id,    presence: true
  validates :shared_hash, presence: true, uniqueness: true

  before_validation :generate_shared_hash, on: :create

  private

  def generate_shared_hash
    self.shared_hash ||= SecureRandom.uuid
  end
end
