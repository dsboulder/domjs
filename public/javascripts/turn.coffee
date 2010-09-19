PHASES = ['actions', 'buys', 'clean', 'draw']
class Turn
  constructor: (@player) ->
    @actions = 1
    @buys = 1
    @money = 0
    @spentMoney = 0

  cards: ->
    @player.hand.length

  start: ->
    this.askForActions()

  deckLeft: ->
    this.player.deck.length

  discardCount: ->
    this.player.discard.length

  totalMoney: ->
    @money + @handMoney() - @spentMoney

  handMoney: ->
    _(@player.hand).inject( (sum, card) ->
      sum + (card.cardType.money || 0)
    , 0)

  actionChosen: (id) =>
    card = @player.getHandCardById(id)
    if @canPlayCard(card)
      console.log('askForActions picked', id, card)
      @playCard card
      domjs.renderTurn()
      domjs.renderInPlay()
      @player.debug()
      if @actions > 0 && @player.handTypeBreakout()["action"]
        domjs.chooseCardFromHand {type: 'action', cancellable: true}, @actionChosen
      else 
        @nextPhase()


  askForActions: ->
    @phase = 'actions'
    @player.debug()    
    domjs.highlightTurnPhase('actions')
    if !@player.handTypeBreakout()["action"]
      @nextPhase()
    else
      domjs.chooseCardFromHand {type: 'action', cancellable: true}, @actionChosen

  buyChosen: (id) =>
    pickedCard = domjs.supply.getCardById(id)
    if @canBuyCard(pickedCard)
      card = domjs.supply.removeCard pickedCard.cardType
      console.log('askForBuys picked', id, pickedCard, card)
      @buyCard card
      domjs.renderTurn()
      domjs.renderSupply()
      if @buys > 0
        domjs.chooseCardFromSupply {cancellable: true}, @buyChosen
        domjs.highlightCardsCostingLess($('.supply'), @totalMoney())
      else
        @nextPhase()

  askForBuys: ->
    @phase = 'buys'
    @player.debug()
    domjs.highlightTurnPhase('buys')
    domjs.chooseCardFromSupply {cancellable: true}, @buyChosen
    domjs.highlightCardsCostingLess($('.supply'), @totalMoney())

  buyCard: (card) ->
    @buys -= 1
    @spentMoney += card.cardType.cost
    @player.gain card


  playCard: (card) ->
    @actions -= 1

    _.times card.cardType.cards, => @player.drawCard()
    @giveActions card.cardType.actions
    @giveBuys card.cardType.buys
    @giveMoney card.cardType.money

    @player.play card

  canPlayCard: ->
    true

  canBuyCard: (pickedCard) ->
    pickedCard.cardType.cost <= @totalMoney() && @buys > 0 && pickedCard.remaining > 0

  giveActions: (count) ->
    console.debug("giveActions", count)
    @actions += count || 0

  giveBuys: (count) ->
    console.debug("giveBuys", count)
    @buys += count || 0

  giveMoney: (amount) ->
    console.debug("giveMoney", amount)
    @money += amount || 0

  cleanup: ->
    @phase = 'cleanup'
    @player.discardHand()
    @player.discardInPlay()
    @player.debug()
    domjs.renderInPlay()
    domjs.renderTurn()
    @nextPhase()

  draw: ->
    @phase = "draw"
    domjs.renderTurn()
    _.times 5, => @player.drawCard()
    domjs.renderTurn()
    domjs.highlightTurnsHand()
    @finish()

  finish: ->
    domjs.nextTurn()

  nextPhase: ->
    console.log "Next phase from", @phase
    domjs.removeCardEvents()
    switch @phase
      when 'actions' then @askForBuys()
      when 'buys' then @cleanup()
      when 'cleanup' then @draw()
      else alert('no next phase')
      