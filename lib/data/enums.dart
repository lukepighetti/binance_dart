/// Describes the status of a trading pair. An actively trading pair is [Status.trading]
///
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/rest-api.md#enum-definitions
enum Status {
  preTrading,
  trading,
  postTrading,
  endOfDay,
  halt,
  auctionMatch,
  breakTrading
}

/// Maps [Status] to a Binance string
const statusMap = <String, Status>{
  'PRE_TRADING': Status.preTrading,
  'TRADING': Status.trading,
  'POST_TRADING': Status.postTrading,
  'END_OF_DAY': Status.endOfDay,
  'HALT': Status.halt,
  'AUCTION_MATCH': Status.auctionMatch,
  'BREAK': Status.breakTrading
};

/// Describes the type of an order. A limit order is [OrderType.limit]
///
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/rest-api.md#enum-definitions
enum OrderType {
  limit,
  market,
  stopLoss,
  stopLossLimit,
  takeProfit,
  takeProfitLimit,
  limitMaker
}

/// Maps [OrderType] to a Binance string
const orderTypeMap = <String, OrderType>{
  'LIMIT': OrderType.limit,
  'MARKET': OrderType.market,
  'STOP_LOSS': OrderType.stopLoss,
  'STOP_LOSS_LIMIT': OrderType.stopLossLimit,
  'TAKE_PROFIT': OrderType.takeProfit,
  'TAKE_PROFIT_LIMIT': OrderType.takeProfitLimit,
  'LIMIT_MAKER': OrderType.limitMaker
};

/// The chart interval for [Klein], aka Candlesticks. A one-minute interval is [Interval.oneMinute]
///
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/rest-api.md#enum-definitions
enum Interval {
  oneMinute,
  threeMinutes,
  fiveMinutes,
  fifteenMinutes,
  thirtyMinutes,
  oneHour,
  twoHours,
  fourHours,
  sixHours,
  eightHours,
  twelveHours,
  oneDay,
  threeDays,
  oneWeek,
  oneMonth
}

/// Maps [Interval] to a Binance string
const intervalMap = <Interval, String>{
  Interval.oneMinute: '1m',
  Interval.threeMinutes: '3m',
  Interval.fiveMinutes: '5m',
  Interval.fifteenMinutes: '15m',
  Interval.thirtyMinutes: '30m',
  Interval.oneHour: '1h',
  Interval.twoHours: '2h',
  Interval.fourHours: '4h',
  Interval.sixHours: '6h',
  Interval.eightHours: '8h',
  Interval.twelveHours: '12h',
  Interval.oneDay: '1d',
  Interval.threeDays: '3d',
  Interval.oneWeek: '1w',
  Interval.oneMonth: '1M'
};
