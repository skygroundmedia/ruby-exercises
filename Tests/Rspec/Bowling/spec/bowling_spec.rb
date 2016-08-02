require_relative '../lib/gameplay'

describe Gameplay do
	
=begin
	it 'is on a round between 0 - 9'
	it 'is summing points from the previous plays'
	it 'is allowing players to alternate between frames'
	it 'is providing a third turn thanks to a spare'
	it 'is a strike therefore therfore gets two bonus rolls'
	it 'is a spare so player gets 1 bonus roll'
	it 'is a normal bown so player get 2 rolls'
=end
	
	
	it 'scores a gutter game' do
		game = Gameplay.new
		game.pins([0] * 20)
		expect(game.score).to eq(0)
	end	
	
	
	
	
end
