class MovieDecorator < Draper::Decorator
  delegate_all
  decorates_finders

  def cover
    "https://pairguru-api.herokuapp.com/#{title.downcase.parameterize.underscore}.jpg"
  end

  def rating
    details.data.attributes.rating
  end

  def description
    details.data.attributes.plot
  end
end
