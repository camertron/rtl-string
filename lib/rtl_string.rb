# encoding: UTF-8

require 'twitter_cldr'

class RtlString
  RTL_RANGES = [
    0x0600..0x06FF,
    0x0750..0x077F,
    0x0590..0x05FF,
    0xFE70..0xFEFF,
  ]

  attr_reader :string

  def initialize(string)
    @string = string
  end

  def to_s
    string.localize.code_points.inject("") do |ret, code_point|
      ret << if is_rtl?(code_point)
        "[#{name_for(code_point)}]"
      else
        [code_point].pack("U*")
      end
    end
  end

  def inspect
    to_s.inspect
  end

  def delete_at(index)
    code_points = string.localize.code_points
    deleted = code_points.delete_at(index)
    @string = code_points.pack("U*")
    self.class.new([deleted].pack("U*"))
  end

  def delete_range(range)
    code_points = string.localize.code_points
    range.each do |i|
      code_points.delete_at(range.first)
    end
    @string = code_points.pack("U*")
    nil
  end

  def [](index_or_range)
    code_points = string.localize.code_points
    selected = code_points[index_or_range]
    self.class.new((selected.is_a?(Array) ? selected : [selected]).pack("U*"))
  end

  def insert(str, index)
    code_points = string.localize.code_points
    code_points.insert(index, *str.localize.code_points)
    @string = code_points.pack("U*")
    self
  end

  def size
    string.localize.size
  end

  alias :length :size

  private

  def is_rtl?(code_point)
    RTL_RANGES.any? { |range| range.include?(code_point) }
  end

  def name_for(code_point)
    unicode_data = TwitterCldr::Shared::CodePoint.find(code_point)
    name_cache[code_point] ||= unicode_data.name
      .gsub(/(:?ARABIC|HEBREW)(:?\sLETTER\s|\sSIGN\s|\-INDIC\s)?/, "")
      .gsub("WITH", "-")
      .strip
      .downcase
  end

  def name_cache
    @@name_cache ||= {}
  end
end

class String
  def to_rtl_s
    RtlString.new(self)
  end
end