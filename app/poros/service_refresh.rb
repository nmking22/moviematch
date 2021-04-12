class ServiceRefresh
  attr_reader :id,
              :name,
              :movie_count

  def initialize(name, movie_count)
    @id = nil
    @name = name
    @movie_count = movie_count
  end
end
