class Domjs
  constructor: () ->
    @players = []
    $('.start-game').click ->
      window.domjs.start()

  start: () ->
    @supply = new Supply()
    @players.push new Player("P0")
    @players.push new Player("P1")
    @renderSupply()
    @startTurn(@players[0])

  renderSupply: () ->
    h = SupplyView.render(@supply)
    $('.supply').html(h)

  nextTurn: ->
    idx = @players.indexOf(@turn.player)
    nextPlayer = @players[(idx + 1) % @players.length]
    @startTurn(nextPlayer)

  startTurn: (player) ->
    @turn = new Turn(player)
    @hideOtherPlayersHand()
    this.renderTurn()
    @turn.start()

  renderInPlay: ->
    sel = @getTurnsInPlayDOM()
    sel.html(InPlayView.render(@turn.player))

  renderTurn: ->
    $('.turn').html(TurnView.render(@turn))
    h = HandView.render(@turn.player)
    @getTurnsHandDOM().html(h)
    @highlightTurnPhase(@turn.phase)
    $('.turn .next').click =>
      @turn.nextPhase()

  disableAllPanels: ->
    $(".card").removeClass('disabled')
    $('.panel').addClass('disabled')

  hideOtherPlayersHand: ->
    sel = @getOthersHandDOM()
    sel.find(".card").addClass('hidden')

  highlightSupply: ->
    @disableAllPanels()
    $('.panel.supply').removeClass('disabled')

  highlightTurnsHand: (type) ->
    @disableAllPanels()
    sel = @getTurnsHandDOM().parents(".panel")
    sel.removeClass('disabled')
    sel.find('.card').removeClass('hidden')

  highlightCardType: (container, type) ->
    container.find('.card').addClass('disabled')
    container.find('.card.'+type).removeClass('disabled')    

  highlightCardsCostingLess: (container, maxCost) ->
    console.debug("highlightCardsCostingLess", container, maxCost)
    container.find('.card').addClass('disabled').each ->
      cost = parseInt($(this).attr('data-cost')) || 0
      console.log($(this).find('.name').text(), cost, cost <= maxCost)
      $(this).removeClass('disabled') if cost <= maxCost

  getTurnsHandDOM: ->
    @getTurnsPanelDOM().find('.hand')

  getTurnsInPlayDOM: ->
    @getTurnsPanelDOM().find('.in-play')

  getTurnsPanelDOM: ->
    sel = '.p'+@players.indexOf(@turn.player)
    console.log("getTurnsPanelDOM", sel)
    $(sel)

  getOthersHandDOM: ->
    sel = '.panel:not(.p'+@players.indexOf(@turn.player)+") .hand"
    console.log("getOthersHandDOM", sel)
    $(sel)

  getSupplyDOM: ->
    $('.supply')

  highlightTurnPhase: (className) ->
    $(".turn *").removeClass('highlight')
    $(".turn ."+className).addClass('highlight')

  chooseCardFromHand: (options, callbackFn) ->
    @renderTurn()
    @highlightTurnsHand()
    @highlightCardType(@getTurnsHandDOM(), options.type)
    @chooseCard(@getTurnsHandDOM(), callbackFn)    

  chooseCardFromSupply: (options, callbackFn) ->
    @renderTurn()
    @highlightSupply()
    @chooseCard(@getSupplyDOM(), callbackFn)

  chooseCard: (container, callbackFn) ->
    container.find('.card').click (e) ->
      id = $(this).attr('data-id')
      console.log('click', id, e)
      callbackFn(id)

  removeCardEvents: ->
    $('.card').unbind('click')
