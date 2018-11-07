class TitleBracketsValidator < ActiveModel::Validator
  def validate(obj)
    chars = obj.title.split(//)

    brackets = {"[" => "]", "{" => "}", "(" => ")"}
    opening_brackets = []
    closing_brackets = []
    chars.each_with_index do |char, idx|
      if brackets.keys.include?(char)
        opening_brackets.push(char)
      elsif brackets.values.include?(char)
        closing_brackets.push(char)
      end
    end

    return obj.errors[:base] << 'too much closing brackets' if opening_brackets.size < closing_brackets.size
    return obj.errors[:base] << 'too much opeing brackets' if closing_brackets.size < opening_brackets.size
  end
end