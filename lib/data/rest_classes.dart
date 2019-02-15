/// A class that represents the data located at /v1/exchangeInfo
import 'enums.dart';

class ExchangeInfo {
  final String timezone;
  final DateTime serverTime;

  final List<Symbol> symbols;

  ExchangeInfo.fromMap(Map m)
      : this.timezone = m['timezone'],
        this.serverTime = DateTime.fromMillisecondsSinceEpoch(m['serverTime']),
        this.symbols =
            m['symbols'].map<Symbol>((s) => Symbol.fromMap(s)).toList();
}

/// A class that represents the Symbols returned by /v1/exchangeInfo
class Symbol {
  final String symbol;

  final Status status;
  final String baseAsset;
  final num baseAssetPrecision;
  final String quoteAsset;
  final num quotePrecision;

  final List<OrderType> orderTypes;
  final bool icebergAllowed;
  // List<Filter> filters;

  Symbol.fromMap(Map m)
      : this.symbol = m['symbol'],
        this.status = statusMap[m['status']],
        this.baseAsset = m['baseAsset'],
        this.baseAssetPrecision = m['baseAssetPrecision'],
        this.quoteAsset = m['quoteAsset'],
        this.quotePrecision = m['quotePrecision'],
        this.orderTypes = List<String>.from(m['orderTypes'])
            .map((s) => orderTypeMap[s])
            .toList(),
        this.icebergAllowed = m['icebergAllowed'];
}

/// A class that represents the data located at /v1/depth

class BookDepth {
  final int lastUpdateId;
  final List<DepthPoint> bids;
  final List<DepthPoint> asks;

  BookDepth.fromMap(Map m)
      : this.lastUpdateId = m["lastUpdateId"],
        this.bids =
            List<DepthPoint>.from(m["bids"].map((b) => DepthPoint.fromList(b))),
        this.asks =
            List<DepthPoint>.from(m["asks"].map((b) => DepthPoint.fromList(b)));
}

/// A class that represents the bids/asks data provided by /v1/depth
class DepthPoint {
  final num price;
  final num qty;

  DepthPoint.fromList(List values)
      : this.price = num.parse(values.first),
        this.qty = num.parse(values[1]);
}

/// A class that represents the trades provided by /v1/trades

class Trade {
  final int id;
  final num price;
  final num qty;
  final DateTime time;
  final bool isBuyerMaker;
  final bool isBestMatch;

  Trade.fromMap(Map m)
      : this.id = m['id'],
        this.price = num.parse(m['price']),
        this.qty = num.parse(m['qty']),
        this.time = DateTime.fromMillisecondsSinceEpoch(m['time']),
        this.isBuyerMaker = m['isBuyerMaker'],
        this.isBestMatch = m['isBestMatch'];
}

/// A class that represents an aggregated trade provided
/// by /v1/aggregatedTrades
class AggregatedTrade implements Trade {
  final int id;
  final num price;
  final num qty;
  final DateTime time;
  final bool isBuyerMaker;
  final bool isBestMatch;

  final int firstTradeId;
  final int lastTradeId;

  AggregatedTrade.fromMap(Map m)
      : this.id = m['a'],
        this.price = num.parse(m['p']),
        this.qty = num.parse(m['q']),
        this.time = DateTime.fromMillisecondsSinceEpoch(m['T']),
        this.isBuyerMaker = m['m'],
        this.isBestMatch = m['M'],
        this.firstTradeId = m['f'],
        this.lastTradeId = m['l'];
}

/// A class that represents a candlestick provided by /v1/klines

class Kline {
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

  Kline.fromList(List c)
      : this.openTime = DateTime.fromMillisecondsSinceEpoch(c.first),
        this.open = double.parse(c[1]),
        this.high = double.parse(c[2]),
        this.low = double.parse(c[3]),
        this.close = double.parse(c[4]),
        this.volume = double.parse(c[5]),
        this.closeTime = DateTime.fromMillisecondsSinceEpoch(c[6]),
        this.quoteVolume = double.parse(c[7]),
        this.tradesCount = c[8],
        this.takerBase = double.parse(c[9]),
        this.takerQuote = double.parse(c[10]);
}

/// A class that represents the data provided by /v3/avgPrice

class AveragedPrice {
  num mins;
  double price;

  AveragedPrice.fromMap(Map m)
      : this.mins = m["mins"],
        this.price = double.parse(m["price"]);
}

/// A class that represents the data provided by /v1/ticker/24hr

class Stats {
  final String symbol;
  final double priceChange;
  final double priceChangePercent;
  final double weightedAvgPrice;
  final double prevClosePrice;
  final double lastPrice;
  final double lastQty;
  final double bidPrice;
  final double askPrice;
  final double openPrice;
  final double highPrice;
  final double lowPrice;
  final double volume;
  final double quoteVolume;
  final DateTime openTime;
  final DateTime closeTime;
  final int firstId;
  final int lastId;
  final int count;

  Stats.fromMap(Map m)
      : this.symbol = m["symbol"],
        this.priceChange = double.parse(m["priceChange"]),
        this.priceChangePercent = double.parse(m["priceChangePercent"]),
        this.weightedAvgPrice = double.parse(m["weightedAvgPrice"]),
        this.prevClosePrice = double.parse(m["prevClosePrice"]),
        this.lastPrice = double.parse(m["lastPrice"]),
        this.lastQty = double.parse(m["lastQty"]),
        this.bidPrice = double.parse(m["bidPrice"]),
        this.askPrice = double.parse(m["askPrice"]),
        this.openPrice = double.parse(m["openPrice"]),
        this.highPrice = double.parse(m["highPrice"]),
        this.lowPrice = double.parse(m["lowPrice"]),
        this.volume = double.parse(m["volume"]),
        this.quoteVolume = double.parse(m["quoteVolume"]),
        this.openTime = DateTime.fromMillisecondsSinceEpoch(m["openTime"]),
        this.closeTime = DateTime.fromMillisecondsSinceEpoch(m["closeTime"]),
        this.firstId = m["firstId"],
        this.lastId = m["lastId"],
        this.count = m["count"];
}

/// A class that contains the data returned by /v3/ticker/price

class TickerPrice {
  String symbol;
  double price;

  TickerPrice.fromMap(Map m)
      : this.symbol = m["symbol"],
        this.price = double.parse(m["price"]);
}

/// A class that contains the data returned by /v3/ticker/bookTicker

class BookTicker {
  String symbol;
  double bidPrice;
  double bidQty;
  double askPrice;
  double askQty;

  BookTicker.fromMap(Map m)
      : this.symbol = m["symbol"],
        this.bidPrice = double.parse(m["bidPrice"]),
        this.bidQty = double.parse(m["bidQty"]),
        this.askPrice = double.parse(m["askPrice"]),
        this.askQty = double.parse(m["askQty"]);
}
