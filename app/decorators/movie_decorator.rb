class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end

  def rating
    details.data.attributes.rating
  end

  def description
    details.data.attributes.plot
  end
end
