class Chat < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :messages, :dependent => :destroy
end
