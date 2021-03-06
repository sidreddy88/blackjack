class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    lastCard = @deck.pop()
    @add(lastCard)
    lastCard

  stand: ->
    @trigger("stand")

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: (includeDownCard) -> @reduce (score, card) ->
    if includeDownCard
      return score + card.get 'value'
    else
      return score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: (includeDownCard) ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(includeDownCard), @minScore(includeDownCard) + 10 * @hasAce()]




