module Api
  module V2
    class MovieResource < JSONAPI::Resource
      immutable
      
      attributes :title, :genre_id, :genre_name, :genre_count
      has_one :genre


      def genre_id
        genre.id
      end

      def genre_name
        genre.name
      end

      def genre_count
        genre.movies.size
      end
    end
  end
end
