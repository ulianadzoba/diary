# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  avatar                 :string
#  role                   :string           default("user"), not null
#  provider               :string
#  uid                    :string
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  attr_accessor :skip_password_validation

  enum role: {
    user: 'user',
    admin: 'admin'
  }

  mount_uploader :avatar, UserAvatarUploader

  has_and_belongs_to_many :journals
  has_many :own_journals, class_name: 'Journal', foreign_key: :user_id, dependent: :destroy

  validates :first_name, :last_name, :role, presence: true
  validates :role, inclusion: { in: self.roles }

  scope :ordered, -> { order(created_at: :desc) }
 
  def to_param
    "#{id}-#{full_name}".to_slug.normalize
  end

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def password_required?
    return false if skip_password_validation

    super
  end

  def User.from_omniauth(oauth_hash)
    Rails.logger.info("OAUTH_HASH: #{oauth_hash.inspect}")

    oauth_hash = oauth_hash&.with_indifferent_access
    return if oauth_hash.nil? || oauth_hash[:info].nil?

    email = oauth_hash[:info][:email].to_s.downcase
    return if email.blank?

    User.find_or_initialize_by(email: email).tap do |user|
      return user if user.persisted?

      user.assign_attributes(email: email,
                             provider: oauth_hash[:provider],
                             uid: oauth_hash[:uid],
                             first_name: oauth_hash[:info][:first_name],
                             last_name: oauth_hash[:info][:last_name])

      user.skip_password_validation = true
      user.save!
    end
  end

  def self.grouped_collection_by_role
    {
      'admins':       User.admin.limit(2),
      'regular_user': User.user.limit(10)
    }
  end
end
