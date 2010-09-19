SupplyView =
  template: Handlebars.compile('''
    {{#cards}}
      <div class="supply-card left{{remaining}}">
        {{{renderCard}}}
        <span class="remaining">
          {{remaining}}
        </span>
      </div>
    {{/cards}}
  ''')

  render: (supply) ->
    sortedCards = _(supply.cards).sortBy (card) -> card.cardType.cost
    SupplyView.template(
      {cards: sortedCards},
      {renderCard: SupplyView.renderCard}
    )

  renderCard: () ->
    CardView.render this
