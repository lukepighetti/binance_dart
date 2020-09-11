import 'rest_classes.dart';
export 'rest_classes.dart';

/// All websocket responses have an [eventType], [eventTime], and [symbol]
abstract class _WebsocketBase {
  String get eventType;
  DateTime get eventTime;
  String get symbol;
}

/// See [AggregatedTrade]
///
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/web-socket-streams.md#aggregate-trade-streams
class WsAggregatedTrade implements AggregatedTrade, _WebsocketBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final int id;
  final double price;
  final double qty;

  final int firstTradeId;
  final int lastTradeId;

  final DateTime time;
  final bool isBuyerMaker;
  final bool isBestMatch;

  WsAggregatedTrade.fromMap(Map m)
      : this.eventType = m['e'],
        this.eventTime = DateTime.fromMillisecondsSinceEpoch(m['E']),
        this.symbol = m['s'],
        this.id = m['a'],
        this.price = double.parse(m['p']),
        this.qty = double.parse(m['q']),
        this.firstTradeId = m['f'],
        this.lastTradeId = m['l'],
        this.time = DateTime.fromMillisecondsSinceEpoch(m['T']),
        this.isBuyerMaker = m['m'],
        this.isBestMatch = m['M'];
}

/// See [Kline]
///
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/web-socket-streams.md#klinecandlestick-streams
class WsKline implements Kline, _WebsocketBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final DateTime openTime;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final DateTime closeTime;

  final double quoteVolume;
  final int tradesCount;
  final double takerBase;
  final double takerQuote;

  final String interval;
  final int firstTradeId;
  final int lastTradeId;
  final bool isKlineClosed;

  WsKline.fromMap(Map m)
      : this.eventType = m['e'],
        this.eventTime = DateTime.fromMillisecondsSinceEpoch(m['E']),
        this.symbol = m['s'],
        this.openTime = DateTime.fromMillisecondsSinceEpoch(m['k']['t']),
        this.open = double.parse(m['k']['o']),
        this.high = double.parse(m['k']['h']),
        this.low = double.parse(m['k']['l']),
        this.close = double.parse(m['k']['c']),
        this.volume = double.parse(m['k']['v']),
        this.closeTime = DateTime.fromMillisecondsSinceEpoch(m['k']['T']),
        this.quoteVolume = double.parse(m['k']['q']),
        this.tradesCount = m['k']['n'],
        this.takerBase = double.parse(m['k']['V']),
        this.takerQuote = double.parse(m['k']['Q']),
        this.interval = m['k']['i'],
        this.firstTradeId = m['k']['f'],
        this.lastTradeId = m['k']['L'],
        this.isKlineClosed = m['k']['x'];
}

/// Represents data provided by <symbol>@miniTicker and !miniTicker@arr
///
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/web-socket-streams.md#individual-symbol-mini-ticker-stream
class MiniTicker implements _WebsocketBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final double close;
  final double open;
  final double high;
  final double low;
  final double volume;
  final double quoteVolume;

  MiniTicker.fromMap(Map m)
      : this.eventType = m['e'],
        this.eventTime = DateTime.fromMillisecondsSinceEpoch(m['E']),
        this.symbol = m['s'],
        this.close = double.parse(m['c']),
        this.open = double.parse(m['o']),
        this.high = double.parse(m['h']),
        this.low = double.parse(m['l']),
        this.volume = double.parse(m['v']),
        this.quoteVolume = double.parse(m['q']);
}

/// Represents data provided by <symbol>@ticker and !ticker@arr
///
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/web-socket-streams.md#individual-symbol-ticker-streams
class Ticker implements MiniTicker, _WebsocketBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final double priceChange;
  final double percentChange;
  final double averagePrice;
  final double initialPrice;
  final double lastPrice;
  final double lastQty;
  final double bestBid;
  final double bestBidQty;
  final double bestAsk;
  final double bestAskQty;

  final double open;
  final double high;
  final double low;
  final double volume;
  final double quoteVolume;

  final DateTime openTime;
  final DateTime closeTime;

  final int firstTradeId;
  final int lastTradeId;
  final int tradesCount;

  /// Same as [lastPrice]
  double get close => lastPrice;

  Ticker.fromMap(Map m)
      : this.eventType = m['e'],
        this.eventTime = DateTime.fromMillisecondsSinceEpoch(m['E']),
        this.symbol = m['s'],
        this.priceChange = double.parse(m['p']),
        this.percentChange = double.parse(m['P']),
        this.averagePrice = double.parse(m['w']),
        this.initialPrice = double.parse(m['x']),
        this.lastPrice = double.parse(m['c']),
        this.lastQty = double.parse(m['Q']),
        this.bestBid = double.parse(m['b']),
        this.bestBidQty = double.parse(m['B']),
        this.bestAsk = double.parse(m['a']),
        this.bestAskQty = double.parse(m['A']),
        this.open = double.parse(m['o']),
        this.high = double.parse(m['h']),
        this.low = double.parse(m['l']),
        this.volume = double.parse(m['v']),
        this.quoteVolume = double.parse(m['q']),
        this.openTime = DateTime.fromMillisecondsSinceEpoch(m['O']),
        this.closeTime = DateTime.fromMillisecondsSinceEpoch(m['C']),
        this.firstTradeId = m['F'],
        this.lastTradeId = m['L'],
        this.tradesCount = m['n'];
}

/// Order book price and quantity depth updates used to locally manage an order book pushed every second.
///
/// https://github.com/binance-exchange/binance-official-api-docs/blob/master/web-socket-streams.md#diff-depth-stream
class DiffBookDepth implements BookDepth, _WebsocketBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final int firstUpdateId;
  final int lastUpdateId;

  final List<DepthPoint> bids;
  final List<DepthPoint> asks;

  DiffBookDepth.fromMap(Map m)
      : this.eventType = m['e'],
        this.eventTime = DateTime.fromMillisecondsSinceEpoch(m['E']),
        this.symbol = m['s'],
        this.firstUpdateId = m["U"],
        this.lastUpdateId = m["u"],
        this.bids =
            List<DepthPoint>.from(m["b"].map((b) => DepthPoint.fromList(b))),
        this.asks =
            List<DepthPoint>.from(m["a"].map((b) => DepthPoint.fromList(b)));
}

class WSBookTicker {
  final String symbol;
  final int updateID;
  final double bidPrice;
  final double bidQty;
  final double askPrice;
  final double askQty;

  WSBookTicker.fromMap(Map m)
      : this.symbol = m["s"],
        this.updateID = m["u"],
        this.bidPrice = double.parse(m["b"]),
        this.bidQty = double.parse(m["B"]),
        this.askPrice = double.parse(m["a"]),
        this.askQty = double.parse(m["A"]);
}
