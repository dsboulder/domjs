CardView =
  template: Handlebars.compile('''
  <div class="card {{cardType/type}}" data-id="{{id}}" data-cost="{{#cardType}}{{cost}}{{/cardType}}">
    {{#cardType}}
    <h3>{{name}}</h3>
    <p>{{{description}}}</p>
    <span class="cost">{{cost}}</span>
    {{/cardType}}
  </div>
  ''')
  render: (cardType) ->
    h = CardView.template(cardType, description: CardView.description)
    h

  description: ->
    sentences = []
    sentences.push("+#{this.actions} actions") if this.actions
    sentences.push("+#{this.buys} buys") if this.buys
    sentences.push("+#{this.cards} cards") if this.cards
    sentences.push("+#{this.money} money") if this.money
    sentences.push("+#{this.victory} victory") if this.victory
    sentences.join("<br/>")
