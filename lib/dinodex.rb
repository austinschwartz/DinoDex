require 'csv'
require_relative 'dinosaur'

class DinoDex
  attr_accessor :dinos, :csvs
  BIG_SIZE = (4000..Float::INFINITY)
  SMALL_SIZE = (1..4000)

  def initialize(*files)
    @files = ['dinodex.csv', 'african_dinosaur_export.csv'] if files.empty?
    @files = files unless files.empty?
    @dinos = []
    @csvs = []
    initialize_csvs
    initialize_dinos
  end

  def initialize_csvs
    @files.each do |file|
      @csvs << CSV.read(Dir.pwd + '/data/' + file, headers: true, header_converters: :symbol,
                              converters: :all)
    end
  end

  def initialize_dinos
    @csvs.each do |csv|
      csv.each do |row|
        african = row.key? :genus
        @dinos << Dinosaur.new(row, african)
      end
    end
  end

  def filter(filter_hash)
    a = self.clone
    a.dinos.delete_if do |dino|
      matches = true
      filter_hash.each do |header, value|
        unless dino.matches_filter?(header.downcase, value)
          matches = false
          break
        end
      end
     !matches
    end
    a
  end

  def to_facts
    @dinos.each_with_object([]) { |dino, fact_list|
      fact_list << dino.to_s + "\n"
    }.join("\n")
  end

  def to_names
    @dinos.each_with_object([]) { |dino, result| 
      result << dino.row[dino.row.headers[0]] 
    }.sort
  end

  def to_json
    @dinos.each_with_object([]) { |dino, result|
      result << dino.to_json
    }.join('\n')
  end
end
