class User < ApplicationRecord
  validates_presence_of :email,
                        :first_name,
                        :last_name,
                        :image,
                        :uid
end
