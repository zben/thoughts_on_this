class Discussion < ActiveRecord::Base
  attr_accessible :name
  belongs_to :subject, polymorphic: true
  belongs_to :user
  has_many :messages, dependent: :destroy

  validates_presence_of :user_id, :name, :url
  validates_associated :subject
  validates_uniqueness_of :url
  validate :with_subject_errors

  before_validation :generate_unique_url, on: :create

  def self.persisted
    where('id is not null')
  end

  def self.url_exists?(url)
    select('url').map(&:url).include?(url)
  end

  def to_param
    url
  end

  def ordered_messages
    messages.order('created_at ASC')
  end

  def user_names
    ordered_messages.map(&:user_name).uniq
  end

  def user_number(user_name)
    user_names.index(user_name)
  end

  private

  def generate_unique_url
    url = SecureRandom.hex(5)
    while Discussion.url_exists?(url)
      url = SecureRandom.hex(5)
    end
    self.url = url
  end

  def with_subject_errors
    errors.messages.delete(:subject)
    errors.merge!(subject.errors) if subject.present?
  end
end
