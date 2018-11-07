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
        return obj.errors[:title] << 'empty brackets' if brackets[chars[idx - 1]] == char
        closing_brackets.push(char)
        return obj.errors[:title] << 'wrong order or too much closing brackets' if closing_brackets.size > opening_brackets.size
      end
    end

    obj.errors[:title] << 'too much opeing brackets' if closing_brackets.size < opening_brackets.size
  end
end