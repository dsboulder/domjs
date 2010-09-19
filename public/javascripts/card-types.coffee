CardTypes ={
  actions: {
    village: new CardType(type: 'action', name: 'Village', actions: 2, cards: 1, cost: 3),
    market: new CardType(type: 'action', name: 'Market', actions: 1, cards: 1, money: 1, buys: 1, cost: 5),
    festival: new CardType(type: 'action', name: 'Festival', actions: 2, money: 2, buys: 1, cost: 5),
    laboratory: new CardType(type: 'action', name: 'Laboratory', actions: 1, cards: 2, cost: 5),
    smithy: new CardType(type: 'action', name: 'Smithy', cards: 3, cost: 4),
    smithy: new CardType(type: 'action', name: 'Smithy', cards: 3, cost: 4)
  }
  victory: {
    estate: new CardType(type: 'victory', name: 'Estate', victory: 1, cost: 2),
    duchy: new CardType(type: 'victory', name: 'Duchy', victory: 3, cost: 5),
    province: new CardType(type: 'victory', name: 'Province', victory: 6, cost: 8)
  }
  treasure: {
    copper: new CardType(type: 'treasure', name: 'Copper', money: 1, cost: 0),
    silver: new CardType(type: 'treasure',name: 'Silver', money: 2, cost: 3),
    gold: new CardType(type: 'treasure',name: 'Gold', money: 3, cost: 6)
  }
}