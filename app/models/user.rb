class User < ApplicationRecord
  has_many :feeds
  has_many :entries, through: :feeds
end
