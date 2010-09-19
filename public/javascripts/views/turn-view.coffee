TurnView =
  template: Handlebars.compile('''
  Turn:
  <span class="player">{{player/name}}</span>
  <span class="phase">({{phase}})</span>
  <span class="actions">{{actions}} actions</span>
  <span class="buys">{{buys}} buys</span>
  <span class="money">{{money}}+{{handMoney}}-{{spentMoney}}={{totalMoney}} money</span>
  <span class="cards">{{cards}} cards</span>
  <span class="deck">{{deckLeft}} deck</span>
  <span class="discard">{{discardCount}} discard</span>
  <button class="next">Next phase</button>
  ''')
  render: (turn) ->
    h = TurnView.template(turn)
    h
