class window.AppView extends Backbone.View
  template: _.template '
    <span class="displayText"></span><br>
    <span>TOTAL:</span><span class="balance"></span><br>
    <span>BET:</span><span class="bet">0</span>
    <button class="betUp">Add 5</button>
    <button class="betDown">Remove 5</button><br><button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button><button style="display: none;" class="newgame-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .newgame-button': -> @newGame()
    'click .betUp': -> @model.bet("up")
    'click .betDown': -> @model.bet("down")

  initialize: ->
    @model.on "endGame", =>
      @endGame()
    @model.on "newHands", =>
      @render()
    @model.on "displayText", =>
      @displayText()
    @model.on "change:amount", =>
      @render()
    @model.on "change:currentBet", =>
      @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.balance').text("" + @model.get('amount'))
    @$('.bet').text("" + @model.get('currentBet'))
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  displayText: ->
    @$(".displayText").text(@model.get("thisText"))

  endGame: ->
    @$(".newgame-button").css("display", "inline-block")
    @$('.hit-button').attr("disabled", "true")
    @$('.stand-button').attr("disabled", "true")
    #window.document.body.getElementById('.dealer-hand-container').disabled = true;

  newGame: ->
    @model.startNewGame()
    #@render()



