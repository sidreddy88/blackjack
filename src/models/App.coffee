# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @set('amount', 1000)
    @set('currentBet', 0)
    @startNewGame()

  hitOnSoft: false

  bet: (type) ->
    if type is "up"
      if @get('amount') is 0
        return
      @set('currentBet', @get('currentBet') + 5)
      @set('amount', @get('amount') - 5)
    else
      if @get('currentBet') is 0
        return
      @set('currentBet', @get('currentBet') - 5)
      @set('amount', @get('amount') + 5)

  displayText: (text) ->
    @set "thisText", text
    @getThisText = text
    @trigger("displayText")

  triggerEndGame: ->
    console.log("trigger end game")
    @trigger("endGame");

  checkForBlackJack: ->
    playerHand = (@get 'playerHand').scores()
    dealerHand = (@get "dealerHand").scores(true)
    playerHand = Math.max(playerHand[0], playerHand[1])
    dealerHand =  Math.max(dealerHand[0], dealerHand[1])

    if playerHand is 21 and dealerHand is 21
      @displayText "The Game is a tie"
      @triggerEndGame()
      return "bothBlackjack"
    else if playerHand is 21
      @displayText "The Player wins"
      @triggerEndGame()
      return "playerBlackjack"
    else if dealerHand is 21
      @displayText "Blackjack! - Dealer wins"
      @get('dealerHand').at(0).flip()
      @triggerEndGame()
      return "dealerBlackjack"

  startNewGame: ->
    @newHands()
    setTimeout @secondPart.bind(@), 500

  newHands: ->
    console.log("this is the start of the game")
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @trigger("newHands")

  secondPart: ->
    @checkForBlackJack()
    @get("playerHand").on 'add', =>
      if @didYouBust() > 21
        @triggerEndGame()
        @displayText "You Busted!"
        return
    @get("playerHand").on 'stand', =>
      @endGame()

  didYouBust: ->
    arr = (@get 'playerHand').scores()
    # max = Math.max(arr[0], arr[1])
    return arr[0]

  endGame: ->
    object = @get 'dealerHand'
    @get('dealerHand').at(0).flip()
    keepDrawing = true

    while keepDrawing
      if @get("dealerHand").scores(true)[0] > 17
        keepDrawing = false
      else @get("dealerHand").hit()

    dealerScore = @get("dealerHand").scores(true)[1]
    if dealerScore > 21
      dealerScore = @get("dealerHand").scores(true)[0]

    if dealerScore > 21
      @displayText "Player Wins"
      @triggerEndGame()
      return "dealerBust";

    playerScore = @get("playerHand").scores()[1]
    if playerScore > 21
      playerScore = @get("playerHand").scores()[0]

    returnString = ""
    if  dealerScore > playerScore
      @displayText "Dealer Wins"
      returnString = "dealerWins"
    else if  playerScore >  dealerScore
      @displayText "Player Wins"
      returnString = "playerWins"
    else
      @displayText "Game is a tie"
      returnString = "tieGame"

    @triggerEndGame()
    return returnString









