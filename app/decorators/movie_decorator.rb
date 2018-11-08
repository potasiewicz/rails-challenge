class MovieDecorator < Draper::Decorator
  delegate_all

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
