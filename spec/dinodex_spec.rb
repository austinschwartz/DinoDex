require_relative '../lib/dinodex'

describe DinoDex do
  before(:each) do
    @dinodex = DinoDex.new
  end
  it 'should return only carnivores when filtering by diet: Carnivore' do

    expect(@dinodex.filter(Diet: 'Carnivore').to_names.sort).to eq(['Afrovenator', 'Albertosaurus', 'Carcharodontosaurus', 'Deinonychus', 'Diplocaulus', 'Giganotosaurus', 'Megalosaurus', 'Quetzalcoatlus', 'Suchomimus', 'Yangchuanosaurus'].sort)
  end

  it 'should return only biped dinosaurs when filtering by walking: Biped' do
    expect(@dinodex.filter(Walking: 'Biped').to_names.sort).to eq(['Abrictosaurus', 'Afrovenator', 'Albertonykus', 'Albertosaurus', 'Baryonyx', 'Carcharodontosaurus', 'Deinonychus', 'Giganotosaurus', 'Megalosaurus', 'Suchomimus', 'Yangchuanosaurus'].sort)
  end

  it 'should allow chaining' do
    expect(@dinodex.filter(Diet: 'Carnivore').filter(Walking: 'Quadruped').to_names.sort).to eq(["Diplocaulus", "Quetzalcoatlus"].sort)
  end

  it 'should return only cretaceous dinosaurs when filtering by period: cretaceous' do
    expect(@dinodex.filter(Period: 'Cretaceous').to_names.sort).to eq(['Albertonykus', 'Albertosaurus', 'Baryonyx', 'Deinonychus', 'Dracopelta', 'Giganotosaurus', 'Paralititan', 'Quetzalcoatlus', 'Suchomimus'].sort)
  end

  it 'should return only big dinosaurs when filtering by Weight_in_lbs: DinoDex::BIG_SIZE' do
    expect(@dinodex.filter(Weight_in_lbs: DinoDex::BIG_SIZE).to_names.sort).to eq(['Baryonyx', 'Giganotosaurus', 'Giraffatitan', 'Paralititan', 'Suchomimus', 'Yangchuanosaurus'].sort)
  end
  
  it 'should return only small dinosaurs when filtering by Weight_in_lbs: DinoDex::SMALL_SIZE' do
    expect(@dinodex.filter(Weight_in_lbs: DinoDex::SMALL_SIZE).to_names.sort).to eq(['Abrictosaurus', 'Albertosaurus', 'Carcharodontosaurus', 'Deinonychus', 'Megalosaurus', 'Melanorosaurus', 'Quetzalcoatlus'].sort)
  end


end
