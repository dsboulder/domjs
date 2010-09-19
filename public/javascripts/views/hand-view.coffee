HandView =
  template: Handlebars.compile('''
    {{#cards}}
      {{{renderCard}}}
    {{/cards}}
  ''')

  render: (player) ->
    sortedCards = _(player.hand).sortBy (card) -> card.cardType.type
    HandView.template(
      {cards: sortedCards},
      {renderCard: HandView.renderCard}
    )

  renderCard: (context) ->
    r = CardView.render this
    r
