# coding: utf-8
class Task < ActiveRecord::Base
  belongs_to :errand

  validates :name,      presence: true
  validates :errand_id, presence: true
  validates :done,      inclusion: { in: [true, false] }
end
