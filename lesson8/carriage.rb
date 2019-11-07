# frozen_string_literal: true

# class for creating Carriages
class Carriage
  include Company

  attr_reader :free, :reserved

  def initialize(value, company); end

  def count_reserved
    @reserved
  end

  def count_free
    @free
  end
end
