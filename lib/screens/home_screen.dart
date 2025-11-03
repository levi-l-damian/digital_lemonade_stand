import 'package:flutter/material.dart';

import '../tokens.dart';
import '../widgets/beverage_card.dart';
import '../widgets/place_order_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, Map<String, int>> _quantities = {
    for (final beverage in _beverages)
      beverage.title: {
        for (final size in beverage.prices.keys) size: 0,
      },
  };

  bool get _hasSelections {
    for (final entry in _quantities.values) {
      for (final qty in entry.values) {
        if (qty > 0) return true;
      }
    }
    return false;
  }

  void _updateQuantity(String beverageTitle, String size, int quantity) {
    setState(() {
      _quantities[beverageTitle]?[size] = quantity;
    });
  }

  void _resetBeverage(String beverageTitle) {
    setState(() {
      final sizes = _quantities[beverageTitle];
      if (sizes == null) return;
      for (final key in sizes.keys) {
        sizes[key] = 0;
      }
    });
  }

  void _placeOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order flow coming soon.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.chevron_left, color: Tokens.text),
        ),
        title: const Text('Digital Lemonade Stand'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final contentWidth = constraints.maxWidth;
          final horizontalPadding = Tokens.pApp * 2;
          final availableWidth = (contentWidth - horizontalPadding).clamp(0.0, contentWidth);
          final columns = _columnsForWidth(availableWidth);
          const spacing = 20.0;
          final cardWidth = _cardWidthFor(availableWidth, columns, spacing);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(Tokens.pApp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (final beverage in _beverages)
                      SizedBox(
                        width: cardWidth,
                        child: BeverageCard(
                          title: beverage.title,
                          prices: beverage.prices,
                          quantities: _quantities[beverage.title] ?? const {},
                          onQuantityChanged: (size, quantity) =>
                              _updateQuantity(beverage.title, size, quantity),
                          onReset: () => _resetBeverage(beverage.title),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                Align(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: PlaceOrderButton(
                      onPressed: _hasSelections ? _placeOrder : null,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

int _columnsForWidth(double width) {
  if (width >= 1100) return 4;
  if (width >= 700) return 2;
  return 1;
}

double _cardWidthFor(double maxWidth, int columns, double spacing) {
  if (columns == 1) {
    return maxWidth;
  }
  final totalSpacing = spacing * (columns - 1);
  return (maxWidth - totalSpacing) / columns;
}

class _BeverageDefinition {
  const _BeverageDefinition({
    required this.title,
    required this.prices,
  });

  final String title;
  final Map<String, double> prices;
}

const List<_BeverageDefinition> _beverages = [
  _BeverageDefinition(
    title: 'Classic Lemonade',
    prices: {'S': 2.49, 'M': 3.49, 'L': 4.49},
  ),
  _BeverageDefinition(
    title: 'Strawberry Lemonade',
    prices: {'S': 2.99, 'M': 3.99, 'L': 4.99},
  ),
  _BeverageDefinition(
    title: 'Mint Limeade',
    prices: {'S': 2.79, 'M': 3.79, 'L': 4.79},
  ),
  _BeverageDefinition(
    title: 'Sparkling Lemonade',
    prices: {'S': 3.29, 'M': 4.29, 'L': 5.29},
  ),
];
