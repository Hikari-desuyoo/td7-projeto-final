class ScoreValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    valid_range = 0..5
    return if valid_range.include?(value)

    record.errors.add(attribute, 'invalid_score')
  end
end
