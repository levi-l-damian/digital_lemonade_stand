import 'package:flutter_riverpod/flutter_riverpod.dart';

class BeverageDefinition {
  const BeverageDefinition({
    required this.title,
    required this.prices,
  });

  final String title;
  final Map<String, double> prices;
}

class BeverageSelection {
  const BeverageSelection({
    required this.beverageTitle,
    required this.size,
    required this.quantity,
    required this.unitPrice,
  });

  final String beverageTitle;
  final String size;
  final int quantity;
  final double unitPrice;

  double get totalPrice => unitPrice * quantity;
}

final beveragesProvider = Provider<List<BeverageDefinition>>(
  (ref) => _beverages,
);

final beverageQuantitiesProvider =
    StateNotifierProvider<BeverageQuantitiesNotifier, Map<String, Map<String, int>>>(
  (ref) => BeverageQuantitiesNotifier(ref.watch(beveragesProvider)),
);

final hasSelectionsProvider = Provider<bool>((ref) {
  final quantities = ref.watch(beverageQuantitiesProvider);
  for (final beverageEntry in quantities.values) {
    for (final quantity in beverageEntry.values) {
      if (quantity > 0) return true;
    }
  }
  return false;
});

final selectedItemsProvider = Provider<List<BeverageSelection>>((ref) {
  final beverages = ref.watch(beveragesProvider);
  final quantities = ref.watch(beverageQuantitiesProvider);

  final List<BeverageSelection> selections = [];

  for (final beverage in beverages) {
    final beverageQuantities = quantities[beverage.title];
    if (beverageQuantities == null) continue;

    for (final entry in beverageQuantities.entries) {
      final qty = entry.value;
      if (qty <= 0) continue;
      final size = entry.key;
      final price = beverage.prices[size];
      if (price == null) continue;

      selections.add(
        BeverageSelection(
          beverageTitle: beverage.title,
          size: size,
          quantity: qty,
          unitPrice: price,
        ),
      );
    }
  }

  return selections;
});

class BeverageQuantitiesNotifier
    extends StateNotifier<Map<String, Map<String, int>>> {
  BeverageQuantitiesNotifier(List<BeverageDefinition> beverages)
      : super({
          for (final beverage in beverages)
            beverage.title: {
              for (final size in beverage.prices.keys) size: 0,
            },
        });

  void updateQuantity(String beverageTitle, String size, int quantity) {
    final beverageQuantities = state[beverageTitle];
    if (beverageQuantities == null) return;

    final updatedBeverage = Map<String, int>.from(beverageQuantities)
      ..[size] = quantity;
    state = {
      ...state,
      beverageTitle: updatedBeverage,
    };
  }

  void resetBeverage(String beverageTitle) {
    final beverageQuantities = state[beverageTitle];
    if (beverageQuantities == null) return;

    final resetQuantities = {
      for (final entry in beverageQuantities.entries) entry.key: 0,
    };

    state = {
      ...state,
      beverageTitle: resetQuantities,
    };
  }
}

const List<BeverageDefinition> _beverages = [
  BeverageDefinition(
    title: 'Classic Lemonade',
    prices: {'S': 2.49, 'M': 3.49, 'L': 4.49},
  ),
  BeverageDefinition(
    title: 'Strawberry Lemonade',
    prices: {'S': 2.99, 'M': 3.99, 'L': 4.99},
  ),
  BeverageDefinition(
    title: 'Mint Limeade',
    prices: {'S': 2.79, 'M': 3.79, 'L': 4.79},
  ),
  BeverageDefinition(
    title: 'Sparkling Lemonade',
    prices: {'S': 3.29, 'M': 4.29, 'L': 5.29},
  ),
];
