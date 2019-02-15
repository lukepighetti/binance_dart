import 'package:binance/binance.dart';

main() async {
  final _binance = Binance();

  _binance.aggTrade("BTCUSDT").listen(_printTrade);
  _binance.aggTrade("ETHUSDT").listen(_printTrade);
  _binance.aggTrade("LTCUSDT").listen(_printTrade);
}

_printTrade(WsAggregatedTrade t) => print(
    "${t.symbol} [${t.id}] ${t.price.toStringAsFixed(2)} USDT, ${t.qty.toStringAsFixed(3)}");
