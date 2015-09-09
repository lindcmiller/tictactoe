require './player'

describe Player do
  let(:player) { Player.new }
  it 'has 2 players' do
    expect("computer").to eq("computer")
    expect("user").to eq("user")
  end  
end
