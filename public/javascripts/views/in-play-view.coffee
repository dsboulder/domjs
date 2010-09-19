InPlayView =
  template: Handlebars.compile('''
    {{#cards}}
      {{{renderCard}}}
    {{/cards}}
  ''')

  render: (player) ->
    HandView.template(
      {cards: player.inPlay},
      {renderCard: InPlayView.renderCard}
    )

  renderCard: (context) ->
    r = CardView.render this
    r
