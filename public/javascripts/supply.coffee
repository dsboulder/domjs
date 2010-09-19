class Supply
  constructor: () ->
    @id = 0
    @cards = []
    for key, val of CardTypes.treasure
      @cards.push cardType: val, remaining: 50
    @cards.push cardType: CardTypes.victory.estate, remaining: 14
    @cards.push cardType: CardTypes.victory.duchy, remaining: 8
    @cards.push cardType: CardTypes.victory.province, remaining: 8
    chosen = this.chooseActions(4)
    console.debug("chosen actions", chosen)
    @cards = @cards.concat(chosen)
    for card in @cards
      card.id = card.cardType.name
    console.debug("chose cards for supply", @cards)

  chooseActions: (count) ->
    actions = _.values(CardTypes.actions)
    chosen = []
    while chosen.length < count
      idx = Math.floor(Math.random() * actions.length)
      if actions[idx]
        chosen.push(cardType: actions[idx], remaining: 10)
        actions[idx] = null
    return chosen

  getNextId: ->
    @id += 1

  getCardById: (id) ->
    _(@cards).detect (card) -> card.id == id

  removeCard: (cardType) ->
    supplyCard = _(@cards).detect (c) -> c.cardType == cardType
    supplyCard.remaining -= 1
    {cardType: supplyCard.cardType, id: this.getNextId()}