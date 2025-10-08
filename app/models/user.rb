class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize

    # Googleから返されるメールアドレス
    user.email = auth.info.email if user.email.blank?
    user.password = Devise.friendly_token[0, 20] if user.encrypted_password.blank?

    # すでに同じメールアドレスのユーザーがいる場合はそのユーザーを使う
    existing_user = find_by(email: user.email)
    if existing_user
      existing_user.update(provider: auth.provider, uid: auth.uid)
      existing_user
    else
      user.save!
      user
    end
  end

  has_many :players, dependent: :destroy
  has_many :lineups, dependent: :destroy
end
