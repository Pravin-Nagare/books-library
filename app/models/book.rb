class Book < ActiveRecord::Base
  attr_accessible :isbn, :title
  has_and_belongs_to_many :users
end
