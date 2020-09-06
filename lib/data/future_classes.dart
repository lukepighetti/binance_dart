abstract class _WebsocketBase {
  String get eventType;
  DateTime get eventTime;
  String get symbol;
}

/// Represents data provided by <symbol>@markPrice and !markPrice@arr
///
///

class MarkPrice implements _WebsocketBase {
  final String eventType;
  final DateTime eventTime;
  final String symbol;

  final String markPrice;
  final String indexPrice;
  final String fundingRate;
  final DateTime nextFundingTime;

  MarkPrice.fromMap(Map m)
      : this.eventType = m["e"],
        this.eventTime = m["E"],
        this.symbol = m["s"],
        this.markPrice = m["p"],
        this.indexPrice = m["i"],
        this.fundingRate = m["r"],
        this.nextFundingTime = m["T"];
}