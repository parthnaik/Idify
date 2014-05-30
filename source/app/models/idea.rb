class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :images
  has_many :votes
end
