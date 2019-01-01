/// A class that represents the data located at /v1/exchangeInfo

class ExchangeInfoResponse {
  String timezone;
  DateTime serverTime;
  // List<RateLimit> rateLimits;

  // List<ExchangeFilters> exchangeFilters;

  List<EISymbol> symbols;

  ExchangeInfoResponse.fromMap(Map m)
      : this.timezone = m['timezone'],
        this.serverTime = DateTime.fromMillisecondsSinceEpoch(m['serverTime']),
        this.symbols =
            m['symbols'].map<EISymbol>((s) => EISymbol.fromMap(s)).toList();
}

/// A class that represents the Symbols returned by /v1/exchangeInfo
class EISymbol {
  String symbol;

  /// PRE_TRADING, TRADING, POST_TRADING, END_OF_DAY, HALT, AUCTION_MATCH, BREAK
  String status;
  String baseAsset;
  num baseAssetPrecision;
  String quoteAsset;
  num quotePrecision;

  /// LIMIT, MARKET, STOP_LOSS, STOP_LOSS_LIMIT, TAKE_PROFIT,
  /// TAKE_PROFIT_LIMIT, LIMIT_MAKER
  List<String> orderTypes;
  bool icebergAllowed;
  // List<Filter> filters;

  EISymbol.fromMap(Map m)
      : this.symbol = m['symbol'],
        this.status = m['status'],
        this.baseAsset = m['baseAsset'],
        this.baseAssetPrecision = m['baseAssetPrecision'],
        this.quoteAsset = m['quoteAsset'],
        this.quotePrecision = m['quotePrecision'],
        this.orderTypes = List<String>.from(m['orderTypes']),
        this.icebergAllowed = m['icebergAllowed'];
}

/// A class that represents the data located at /v1/depth

class DepthResponse {
  int lastUpdateId;
  List<DRPoint> bids;
  List<DRPoint> asks;

  DepthResponse.fromMap(Map m)
      : this.lastUpdateId = m["lastUpdateId"],
        this.bids =
            List<DRPoint>.from(m["bids"].map((b) => DRPoint.fromList(b))),
        this.asks =
            List<DRPoint>.from(m["asks"].map((b) => DRPoint.fromList(b)));
}

/// A class that represents the bids/asks data provided by /v1/depth
class DRPoint {
  num price;
  num qty;

  DRPoint.fromList(List values)
      : this.price = num.parse(values.first),
        this.qty = num.parse(values[1]);
}

/// A class that represents the trades provided by /v1/trades

class RecentTrade {
  int id;
  num price;
  num qty;
  DateTime time;
  bool isBuyerMaker;
  bool isBestMatch;

  RecentTrade.fromMap(Map m)
      : this.id = m['id'],
        this.price = num.parse(m['price']),
        this.qty = num.parse(m['qty']),
        this.time = DateTime.fromMillisecondsSinceEpoch(m['time']),
        this.isBuyerMaker = m['isBuyerMaker'],
        this.isBestMatch = m['isBestMatch'];
}

/// A class that represents an aggregated trade provided
/// by /v1/aggregatedTrades
class AggregatedTrade implements RecentTrade {
  int id;
  num price;
  num qty;
  DateTime time;
  bool isBuyerMaker;
  bool isBestMatch;

  int firstTradeId;
  int lastTradeId;

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

// class Filter {
//   String filterType;

//   /// PRICE_FILTER
//   double minPrice;
//   double maxPrice;
//   double tickSize;

//   /// PERCENT_PRICE
//   num multiplierUp;
//   num multiplierDown;
//   int avgPriceMins;

//   /// LOT_SIZE
//   double minQty;
//   double maxQty;
//   double stepSize;

//   /// MIN_NOTIONAL
//   double minNotional;
//   bool applyToMarket;
//   // int avgPriceMins;

//   /// ICEBERG_PARTS
//   int limit;

//   /// MAX_NUM_ALGO_ORDERS
//   int maxNumAlgoOrders;
// }
