class User < ApplicationRecord
  devise(
    :database_authenticatable,
    :recoverable,
    :registerable,
    :validatable
  )

  def self.find_super_magic_session(super_magic_session_token)
    where(super_magic_token_sent_at: 5.minutes.ago..Float::INFINITY)
    .where("super_magic_token_sent_at <= ?", Time.current)
    .where(super_magic_token: super_magic_session_token)
    .where.not(super_magic_token_opened_at: nil)
    .first
  end
  
  def self.find_super_magic_token(super_magic_token)
    where(super_magic_token_sent_at: 5.minutes.ago..Float::INFINITY)
    .where("super_magic_token_sent_at <= ?", Time.current)
    .where(super_magic_token: super_magic_token)
    .where(super_magic_token_opened_at: nil)
    .first
  end

  def 🍄
    if super_magic_token_opened_at.present?
      update(
        super_magic_token: nil,
        super_magic_token_sent_at: nil,
        super_magic_token_opened_at: nil
      )
    end
  end

  def create_super_magic_link
    update(
      super_magic_token: SecureRandom.uuid,
      super_magic_token_sent_at: Time.current,
      super_magic_token_opened_at: nil
    )
    super_magic_token
  end
end
