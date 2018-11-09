module Api
  module V2
    class GenreResource < JSONAPI::Resource
      immutable

      attributes :name, :genre_count
      has_many :movies
    end
  end
end
