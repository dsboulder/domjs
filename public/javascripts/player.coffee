class Player
  constructor: (@name) ->
    @deck = []
    @hand = []
    @discard = []
    @inPlay = []
    this.createDeck()
    this.dealHandTo 5

  createDeck: ->
    #_.times 7, => @deck.push domjs.supply.removeCard(CardTypes.treasure.copper)
    #_.times 3, => @deck.push domjs.supply.removeCard(CardTypes.victory.estate)
    _(domjs.supply.cards).each (card) => @deck.push domjs.supply.removeCard(card.cardType)
    this.shuffleDeck()
    console.log("CreateDeck:", this.deck)

  shuffleDeck: ->
    newdeck = []
    while @deck.length > 0
      idx = Math.floor(Math.random() * @deck.length)
      newdeck.push @deck.splice(idx, 1)[0]
    @deck = newdeck

  dealHandTo: (cardCount) ->
    while @hand.length < cardCount
      this.drawCard()
    console.log("Hand:", @hand)

  discardHand: ->
    @discard = @discard.concat(@hand)
    @hand = []

  discardInPlay: ->
    @discard = @discard.concat(@inPlay)
    @inPlay = []

  getHandCardById: (id) ->
    id = parseInt(id)
    _(@hand).detect (card) ->
      card.id == id

  makeDiscardIntoDeck: ->
    @deck = @discard
    @discard = []
    @shuffleDeck()

  drawCard: ->
    if @deck.length == 0
      @makeDiscardIntoDeck()
    if @deck.length > 0
      @hand.push @deck.pop()

  play: (card) ->
    idx = @hand.indexOf(card)
    @inPlay.push(@hand.splice(idx, 1)[0])

  gain: (card) -> 
    @discard.push(card)

  handTypeBreakout: ->
    _(@hand).inject( (hash, card) ->
      hash[card.cardType.type] ||= 0
      hash[card.cardType.type] += 1
      hash
    {})

  debug: ->
    console.log("Deck:", @deck)
    console.log("Discard:", @discard)
    console.log("Hand:", @hand, @handTypeBreakout())