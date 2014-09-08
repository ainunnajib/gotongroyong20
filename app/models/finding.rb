class Finding < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  acts_as_votable
  acts_as_tree
end
