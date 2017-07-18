# frozen_string_literal: true

class LiquidValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    Liquid::Template.parse(value)
  rescue Liquid::SyntaxError
    record.errors.add attribute, :liquid_syntax
  end
end
