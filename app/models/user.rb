class User < ActiveRecord::Base
  include Clearance::User
  has_many :discussions, dependent: :destroy
  attr_accessible :first_name, :last_name

  def discussion_timeline
    discussions.order('updated_at DESC')
  end

  def full_name
    if has_full_name?
      "#{first_name} #{last_name}"
    end
  end

  def has_full_name?
    first_name && last_name
  end
end
