class Discussion < ActiveRecord::Base
  attr_accessible :name
  belongs_to :subject, polymorphic: true
  belongs_to :user
  has_many :messages # TODO: dependent destroy

  validates_presence_of :user_id
end
