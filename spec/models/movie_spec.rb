require 'rails_helper'

describe Movie, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :tmdb_id}
  end

  describe 'relationships' do
    it do
      should have_many :movie_availabilities
      should have_many(:services).through(:movie_availabilities)
      should have_many :movie_genres
      should have_many(:genres).through(:movie_genres)
      should have_many :swipes
      should have_many(:users).through(:swipes)
    end
  end

  describe 'class methods' do
    it '.needs_details' do
      expect(Movie.needs_details).to eq([])

      create_list(:movie, 3)

      expect(Movie.needs_details).to eq([])

      austin_powers = Movie.create(
        title: 'Austin Powers: International Man of Mystery',
        tmdb_id: 816
      )

      expect(Movie.needs_details).to eq([austin_powers])
    end

    it '.estimated_update_time' do
      expect(Movie.estimated_update_time(44)).to eq('10 second(s)')
      expect(Movie.estimated_update_time(261)).to eq('1 minute(s), 0 second(s)')
      expect(Movie.estimated_update_time(16000)).to eq('1 hour(s), 1 minute(s), 20 second(s)')
    end

    it '.convert_movie_count_to_estimated_seconds' do
      expect(Movie.convert_movie_count_to_estimated_seconds(44)).to eq(10)
      expect(Movie.convert_movie_count_to_estimated_seconds(261)).to eq(60)
      expect(Movie.convert_movie_count_to_estimated_seconds(16000)).to eq(3680)
    end

    it '.hour_plus?' do
      expect(Movie.hour_plus?(400)).to be false
      expect(Movie.hour_plus?(6000)).to be true
    end

    it '.minute_plus?' do
      expect(Movie.minute_plus?(44)).to be false
      expect(Movie.minute_plus?(65)).to be true
    end

    it '.time_in_hours' do
      expect(Movie.time_in_hours(16000)).to eq('4 hour(s), 26 minute(s), 40 second(s)')
    end

    it '.time_in_minutes' do
      expect(Movie.time_in_minutes(261)).to eq('4 minute(s), 21 second(s)')
    end

    it '.time_in_seconds' do
      expect(Movie.time_in_seconds(44)).to eq('44 second(s)')
    end

    it '.random_unswiped' do
      nick = User.create(
        uid: '12345678910',
        email: 'nickmaxking@gmail.com',
        first_name: 'Nick',
        last_name: 'King',
        image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
      )
      service = create(:service)
      valid_movies = create_list(:movie, 3)
      invalid_movie = create(:movie)
      Movie.all.each do |movie|
        movie.movie_availabilities.create(
          service: service
        )
      end
      invalid_movie.swipes.create(
        user: nick,
        rating: 1
      )

      10.times do
        movie = Movie.random_unswiped(nick.id)
        expect(movie).not_to eq(invalid_movie)
        expect(movie).to be_a(Movie)
        expect(valid_movies).to include(movie)
      end
    end

    it '.group_right_swiped' do
      austin_powers = Movie.create(
        title: 'Austin Powers: International Man of Mystery',
        tmdb_id: 816
      )
      nightcrawler = Movie.create(
        title: 'Nightcrawler',
        tmdb_id: 242582
      )
      theory_of_everything = Movie.create(
        title: 'The Theory of Everything',
        tmdb_id: 266856
      )

      nick = User.create(
        uid: '12345678910',
        email: 'nick@example.com',
        first_name: 'Nick',
        last_name: 'King',
        image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
      )
      ron = User.create(
        uid: '12345678910',
        email: 'ron@example.com',
        first_name: 'Ron',
        last_name: 'Swanson',
        image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
      )
      tom = User.create(
        uid: '12345678910',
        email: 'tom@example.com',
        first_name: 'Tom',
        last_name: 'Haverford',
        image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
      )
      leslie = User.create(
        uid: '12345678910',
        email: 'leslie@example.com',
        first_name: 'Leslie',
        last_name: 'Knope',
        image: 'https://lh6.googleusercontent.com/-hEH5aK9fmMI/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucntLnugtaOVsqmvJGm89fFbDJ6GaQ/s96-c/photo.jpg'
      )

      fantastic_four = Group.create(
        name: 'Fantastic Four'
      )
      avengers = Group.create(
        name: 'The Avengers'
      )
      x_men = Group.create(
        name: 'X Men'
      )
      UserGroup.create(
        user: nick,
        group: fantastic_four
      )
      UserGroup.create(
        user: ron,
        group: fantastic_four
      )
      UserGroup.create(
        user: tom,
        group: fantastic_four
      )
      UserGroup.create(
        user: leslie,
        group: fantastic_four
      )
      UserGroup.create(
        user: nick,
        group: x_men
      )
      UserGroup.create(
        user: ron,
        group: x_men
      )
      UserGroup.create(
        user: tom,
        group: x_men
      )
      UserGroup.create(
        user: ron,
        group: avengers
      )
      UserGroup.create(
        user: leslie,
        group: avengers
      )

      Swipe.create(
        movie: austin_powers,
        user: nick,
        rating: 1
      )
      Swipe.create(
        movie: austin_powers,
        user: ron,
        rating: 1
      )
      Swipe.create(
        movie: austin_powers,
        user: tom,
        rating: 1
      )
      Swipe.create(
        movie: austin_powers,
        user: leslie,
        rating: 1
      )
      Swipe.create(
        movie: nightcrawler,
        user: nick,
        rating: 1
      )
      Swipe.create(
        movie: nightcrawler,
        user: ron,
        rating: 1
      )
      Swipe.create(
        movie: nightcrawler,
        user: tom,
        rating: 1
      )
      Swipe.create(
        movie: nightcrawler,
        user: leslie,
        rating: 0
      )
      Swipe.create(
        movie: theory_of_everything,
        user: leslie,
        rating: 1
      )
      Swipe.create(
        movie: theory_of_everything,
        user: ron,
        rating: 1
      )
      Swipe.create(
        movie: theory_of_everything,
        user: nick,
        rating: 0
      )
      Swipe.create(
        movie: theory_of_everything,
        user: tom,
        rating: 0
      )

      expect(Movie.group_right_swiped(fantastic_four.id)).to eq([austin_powers])
      expect(Movie.group_right_swiped(x_men.id)).to eq([austin_powers, nightcrawler])
      expect(Movie.group_right_swiped(avengers.id)).to eq([austin_powers, theory_of_everything])
    end
  end
end
