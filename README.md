# binance-dart

This is a Dart wrapper for the Binance API. It has serialized data classes and supports all un-authenticated endpoints.

## Example

```dart
import 'package:binance/binance.dart';

main() async {
  final _binance = Binance();

  _binance.aggTrade("BTCUSDT").listen(_printTrade);
  _binance.aggTrade("ETHUSDT").listen(_printTrade);
  _binance.aggTrade("LTCUSDT").listen(_printTrade);
}

_printTrade(WebsocketAggregatedTrade t) => print(
    "${t.symbol} [${t.id}] ${t.price.toStringAsFixed(2)} USDT, ${t.qty.toStringAsFixed(3)}");

```

```
BTCUSDT [90983841] 3582.32 USDT, 0.551
LTCUSDT [13275542] 41.80 USDT, 9.000
BTCUSDT [90983846] 3582.35 USDT, 0.467
ETHUSDT [54910796] 121.08 USDT, 0.000
BTCUSDT [90983847] 3582.03 USDT, 0.003
ETHUSDT [54910798] 121.06 USDT, 10.280
```

## Roadmap

* Support authenticated endpoints

## Contributing

Contributions are welcome. Please try to emulate the structure of this repo. If your contribution is not on the roadmap please create an issue so we can discuss the best way forward.