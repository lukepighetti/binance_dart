enum Status {
  preTrading,
  trading,
  postTrading,
  endOfDay,
  halt,
  auctionMatch,
  breakTrading
}

const statusMap = <String, Status>{
  'PRE_TRADING': Status.preTrading,
  'TRADING': Status.trading,
  'POST_TRADING': Status.postTrading,
  'END_OF_DAY': Status.endOfDay,
  'HALT': Status.halt,
  'AUCTION_MATCH': Status.auctionMatch,
  'BREAK': Status.breakTrading
};

enum OrderType {
  limit,
  market,
  stopLoss,
  stopLossLimit,
  takeProfit,
  takeProfitLimit,
  limitMaker
}

const orderTypeMap = <String, OrderType>{
  'LIMIT': OrderType.limit,
  'MARKET': OrderType.market,
  'STOP_LOSS': OrderType.stopLoss,
  'STOP_LOSS_LIMIT': OrderType.stopLossLimit,
  'TAKE_PROFIT': OrderType.takeProfit,
  'TAKE_PROFIT_LIMIT': OrderType.takeProfitLimit,
  'LIMIT_MAKER': OrderType.limitMaker
};
