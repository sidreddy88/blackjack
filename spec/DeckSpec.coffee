assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'deck length should be 50 after dealing player', ->
      assert.strictEqual deck.length, 50
    it 'should be able to hit', ->
      assert.strictEqual deck.last(), hand.hit()
    it 'should remove hit card from deck', ->
      hand.hit()
      assert.strictEqual deck.length, 49
    return


