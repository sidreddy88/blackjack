class window.AppView extends Backbone.View
  template: _.template '
    <span class="displayText"></span><button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button><button style="display: none;" class="newgame-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .newgame-button': -> @newGame()

  initialize: ->
    @model.on "endGame", =>
      @endGame()
    @model.on "newHands", =>
      @render()
    @model.on "displayText", =>
      @displayText()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  displayText: ->
    console.log(@model.get("thisText"))
    @$(".displayText").text(@model.get("thisText"))

  endGame: ->
    console.log "endGame in app view"
    @$(".newgame-button").css("display", "inline-block")
    @$('.hit-button').attr("disabled", "true")
    @$('.stand-button').attr("disabled", "true")
    #window.document.body.getElementById('.dealer-hand-container').disabled = true;

  newGame: ->
    @model.startNewGame()
    #@render()



