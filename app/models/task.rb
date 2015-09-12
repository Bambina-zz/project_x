# coding: utf-8
class Task < ActiveRecord::Base
  validates :name, presence: true
  validates :errand_id, presence: true
  validates :done, inclusion: { in: [true, false] }

  belongs_to :errand
end
