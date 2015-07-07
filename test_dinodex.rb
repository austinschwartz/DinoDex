require "minitest/autorun"
require './dinodex'

class TestDinoDex < Minitest::Unit::TestCase
  def setup
    @dinodex = DinoDex.new('dinodex.csv', 'african_dinosaur_export.csv')
  end

  def test_carnivores
    assert_equal ["Afrovenator", "Albertosaurus", "Carcharodontosaurus", "Deinonychus", "Diplocaulus", "Giganotosaurus", "Megalosaurus", "Quetzalcoatlus", "Suchomimus", "Yangchuanosaurus"].sort, @dinodex.filter(Diet: "Carnivore").to_names
  end

  def test_chaining
    assert_equal ["Diplocaulus", "Quetzalcoatlus"].sort, @dinodex.filter(Diet: "Carnivore").filter(Walking: "Quadruped").to_names
  end
  
  def test_biped
    assert_equal ["Abrictosaurus", "Afrovenator", "Albertonykus", "Albertosaurus", "Baryonyx", "Carcharodontosaurus", "Deinonychus", "Giganotosaurus", "Megalosaurus", "Suchomimus", "Yangchuanosaurus"].sort, @dinodex.filter(Walking: "Biped").to_names
  end

  def test_period
    assert_equal ["Albertonykus", "Albertosaurus", "Baryonyx", "Deinonychus", "Dracopelta", "Giganotosaurus", "Paralititan", "Quetzalcoatlus", "Suchomimus"].sort, @dinodex.filter(Period: "Cretaceous").to_names
  end

  def test_big
    assert_equal ["Baryonyx", "Giganotosaurus", "Giraffatitan", "Paralititan", "Suchomimus", "Yangchuanosaurus"].sort, @dinodex.filter(Weight_in_lbs: DinoDex::BIG_SIZE).to_names
  end

  def test_small
    assert_equal ["Abrictosaurus", "Albertosaurus", "Carcharodontosaurus", "Deinonychus", "Megalosaurus", "Melanorosaurus", "Quetzalcoatlus"].sort, @dinodex.filter(Weight_in_lbs: DinoDex::SMALL_SIZE).to_names
  end
end
