class MovieDecorator < Draper::Decorator
  delegate_all
  decorates_finders

  def cover
    "https://pairguru-api.herokuapp.com/#{title.downcase.parameterize.underscore}.jpg"
  end

  def rating
    details.try(:rating)
  end

  def plot
    details.try(:plot)
  end
end
