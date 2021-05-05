class Friendlist
  attr_reader :id,
              :friends

  def initialize(user)
    @id = user.id
    @friends = user.friends
  end
end
