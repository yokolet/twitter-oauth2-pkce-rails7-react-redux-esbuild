class User < ApplicationRecord
  enum provider: [:local, :twitter]

  validates :username, uniqueness: true
end
