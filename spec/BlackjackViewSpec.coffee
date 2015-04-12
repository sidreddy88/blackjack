assert = chai.assert

describe 'Blackjack View', ->
  deck = null
  hand = null
  deal = null
  appView = null
  app = null

  beforeEach ->
    appView = new AppView(model: new App())
    appView.$el.appendTo 'body'
    app = appView.model
    deck = app.get('deck')
    hand = app.get('playerHand')
    deal = app.get('dealerHand')

  describe 'Dealing', ->
    it "Dealer starts with 2 cards", ->
      assert.strictEqual deal.length, 2
    it "Player starts with 2 cards", ->
      assert.strictEqual hand.length, 2
    it "Dealers first card should be down", ->
      assert.strictEqual deal.at(0).get('revealed'), false

  describe 'Scoring', ->
    it "Dealer wins on dealer blackjack", ->
      deal.at(0).set('value', 10)
      deal.at(1).set('value', 1)
      #app.set('dealerHand', deal)
      assert.strictEqual app.checkForBlackJack(), "dealerBlackjack"
    it "Player wins on player blackjack", ->
      hand.at(0).set('value', 10)
      hand.at(1).set('value', 1)
      #app.set('playerHand', hand)
      assert.strictEqual app.checkForBlackJack(), "playerBlackjack"
    it "Player wins on higher score", ->
      hand.at(0).set('value', 10)
      hand.at(1).set('value', 10)
      deal.at(0).set('value', 10)
      deal.at(1).set('value', 8)
      #app.set('playerHand', hand)
      #app.set('dealerHand', deal)
      assert.strictEqual app.endGame(), "playerWins"
    it "Dealer wins on higher score", ->
      hand.at(0).set('value', 10)
      hand.at(1).set('value', 7)
      deal.at(0).set('value', 9)
      deal.at(1).set('value', 9)
      #app.set('playerHand', hand)
      #app.set('dealerHand', deal)
      assert.strictEqual app.endGame(), "dealerWins"
    it "Dealer hits below 17", ->
      hand.at(0).set('value', 10)
      hand.at(1).set('value', 10)
      deal.at(0).set('value', 8)
      deal.at(1).set('value', 8)
      #app.set('playerHand', hand)
      #app.set('dealerHand', deal)
      app.endGame()
      assert(Math.max(deal.scores()[0], deal.scores()[1]) > 17, "dealer did not hit enough")

  describe 'Player Interaction', ->
    it "Hit button should hit player", ->
      #appView.$(".hit-button").trigger("click");
      test = appView.$(".hit-button")
      $(test).trigger('click')
      assert.strictEqual hand.length, 3




#test scores versus other scores
#player wins if higher score
#player wins if higher score
#showing the correct result - show win if win, blackjack if blackjack, show busts if player or dealer bust
# test cards showing are the same value as the count
# test players blackjack
#test dealers blackjack
#game is a tie
#test that the player busts
#test that the dealer busts
#dealer does not hit above 17
#hit button works
#stand button works
#newGame should not be visible at the beginning
# newGame sholud be visible at the end
#newGame button actually works
#at the end of the game, the dealer should flip the card
#Correct suit is dealt
#Ace can be used as 1 or 11 - other specific tests

