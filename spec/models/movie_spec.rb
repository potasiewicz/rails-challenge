require "rails_helper"

describe Movie do
  it { is_expected.to allow_value("(abc)").for(:title) }
  it { is_expected.to allow_value("[(abc)]").for(:title) }

  it { is_expected.to_not allow_value("()").for(:title) }
  it { is_expected.to_not allow_value("(abc").for(:title) }
  it { is_expected.to_not allow_value("abc)").for(:title) }
  it { is_expected.to_not allow_value(")abc(").for(:title) }
end