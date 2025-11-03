import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/beverage.dart';

const _beverages = [
  Beverage(
    title: 'Classic Lemonade',
    prices: {'S': 2.49, 'M': 3.49, 'L': 4.49},
  ),
  Beverage(
    title: 'Strawberry Lemonade',
    prices: {'S': 2.99, 'M': 3.99, 'L': 4.99},
  ),
  Beverage(
    title: 'Mint Limeade',
    prices: {'S': 2.79, 'M': 3.79, 'L': 4.79},
  ),
  Beverage(
    title: 'Sparkling Lemonade',
    prices: {'S': 3.29, 'M': 4.29, 'L': 5.29},
  ),
];

final beveragesProvider = Provider<List<Beverage>>((ref) => _beverages);

class BeverageQuantitiesNotifier
    extends StateNotifier<Map<String, Map<String, int>>> {
  BeverageQuantitiesNotifier(List<Beverage> beverages)
      : super({
          for (final beverage in beverages)
            beverage.title: {
              for (final size in beverage.prices.keys) size: 0,
            },
        });

  void setQuantity({
    required String beverageTitle,
    required String size,
    required int quantity,
  }) {
    final normalized = quantity.clamp(0, 999);
    final beverage = state[beverageTitle];
    if (beverage == null || !beverage.containsKey(size)) return;
    state = {
      ...state,
      beverageTitle: {
        ...beverage,
        size: normalized,
      },
    };
  }

  void resetBeverage(String beverageTitle) {
    final beverage = state[beverageTitle];
    if (beverage == null) return;
    state = {
      ...state,
      beverageTitle: {
        for (final entry in beverage.entries) entry.key: 0,
      },
    };
  }
}

final beverageQuantitiesProvider = StateNotifierProvider<
    BeverageQuantitiesNotifier, Map<String, Map<String, int>>>(
  (ref) => BeverageQuantitiesNotifier(ref.watch(beveragesProvider)),
);

final hasSelectionsProvider = Provider<bool>((ref) {
  final quantities = ref.watch(beverageQuantitiesProvider);
  for (final beverage in quantities.values) {
    for (final qty in beverage.values) {
      if (qty > 0) return true;
    }
  }
  return false;
});
