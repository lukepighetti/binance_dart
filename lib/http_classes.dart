class ExchangeInfo {
  String timezone;
  DateTime serverTime;
  // List<RateLimit> rateLimits;

  // List<ExchangeFilters> exchangeFilters;

  List<Symbol> symbols;

  ExchangeInfo.fromMap(Map m)
      : this.timezone = m['timezone'],
        this.serverTime = DateTime.fromMillisecondsSinceEpoch(m['serverTime']),
        this.symbols =
            m['symbols'].map<Symbol>((s) => Symbol.fromMap(s)).toList();
}

class Symbol {
  String symbol;
  String status;
  String baseAsset;
  num baseAssetPrecision;
  String quoteAsset;
  num quotePrecision;
  List<String> orderTypes;
  bool icebergAllowed;
  // List<Filter> filters;

  Symbol.fromMap(Map m)
      : this.symbol = m['symbol'],
        this.status = m['status'],
        this.baseAsset = m['baseAsset'],
        this.baseAssetPrecision = m['baseAssetPrecision'],
        this.quoteAsset = m['quoteAsset'],
        this.quotePrecision = m['quotePrecision'],
        this.orderTypes = List<String>.from(m['orderTypes']),
        this.icebergAllowed = m['icebergAllowed'];
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
