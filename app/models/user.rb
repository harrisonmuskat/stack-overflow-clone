class User < ApplicationRecord
  # has_many :questions
  # has_many :answers

  def self.find_or_create_from_auth(auth)
    provider = auth['provider']
    uid = auth['uid']

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.username = auth['info']['nickname']
      user.name = auth['info']['name']
    end

  end
end
