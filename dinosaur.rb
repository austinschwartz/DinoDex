require 'json'

class Dinosaur
  attr_accessor :row
  KEY_MAPPING = {
    name: :genus,
    period: :period,
    carnivore: :carnivore,
    weight_in_lbs: :weight,
    walking: :walking,
    diet: :diet
  }
  def initialize(row, african=false)
    @row = row
    @african = african
  end
  
  def string_matches?(header, value)
    if header == :diet || header == :carnivore
      return false unless diet_matches?(row, value)
    elsif @row.key?(header) && !@row[header].include?(value)
      return false
    end
    true
  end

  def range_matches?(header, value)
    value.include?(@row[header].to_i)
  end

  def matches_filter?(header, value)
    if @african then header = KEY_MAPPING[header] end
    if value.is_a? String
      return string_matches?(header, value)
    else
      return range_matches?(header, value)
    end
    true
  end

  def diet_matches?(row, value)
    unless @african 
      return row[:diet].include? value
    else
      return row[:carnivore] == 'Yes' if value == 'Carnivore'
      return row[:carnivore] == 'No'  if value != 'Carnivore'
    end
    false
  end

  def to_json
    @row.to_hash.to_json
  end

  def to_s
    str = ["#{@row.headers[0].capitalize}: #{@row[@row.headers[0]]}"]
    @row.each do |header, value|
      str << " - #{header}: #{value}" unless value.nil? || header == @row.headers[0]
    end
    str.join("\n")
  end
end
