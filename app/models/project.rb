class Project < ApplicationRecord
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :tasks
end
