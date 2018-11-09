module Api
  module V1
    class MovieResource < JSONAPI::Resource
      immutable

      attributes :title
    end
  end
end