import 'http_classes.dart' show AggregatedTrade;

class WSBase {
  final String eventType = null;
  final DateTime eventTime = null;
  final String symbol = null;
}

/// Represents data provided by <symbol>@aggTrade
class WSAggTrade implements AggregatedTrade, WSBase {
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

  WSAggTrade.fromMap(Map m)
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

/// Represents data provided by <symbol>@miniTicker
class WSMiniTicker implements WSBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final double close;
  final double open;
  final double high;
  final double low;
  final double volume;
  final double quoteVolume;

  WSMiniTicker.fromMap(Map m)
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

// final DateTime openTime;
// final double open;
// final double high;
// final double low;
// final double close;
// final double volume;
// final DateTime closeTime;

// final double quoteVolume;
// final int tradesCount;
// final double takerBase;
// final double takerQuote;
