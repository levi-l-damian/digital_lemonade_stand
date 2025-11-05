import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/beverage_providers.dart';
import '../routes.dart';
import '../tokens.dart';
import '../widgets/beverage_card.dart';
import '../widgets/place_order_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _placeOrder(BuildContext context) {
    context.pushNamed(RouteNames.order);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beverages = ref.watch(beveragesProvider);
    final quantities = ref.watch(beverageQuantitiesProvider);
    final hasSelections = ref.watch(hasSelectionsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.chevron_left, color: Tokens.text),
        ),
        title: const Text('Digital Lemonade Stand'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final contentWidth = constraints.maxWidth;
            final horizontalPadding = Tokens.pApp * 2;
            final availableWidth =
                (contentWidth - horizontalPadding).clamp(0.0, contentWidth);
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
                      for (final beverage in beverages)
                      SizedBox(
                        width: cardWidth,
                        child: BeverageCard(
                          title: beverage.title,
                          prices: beverage.prices,
                          visual: beverage.visual,
                          quantities: quantities[beverage.title] ?? const {},
                          onQuantityChanged: (size, quantity) => ref
                              .read(beverageQuantitiesProvider.notifier)
                              .updateQuantity(beverage.title, size, quantity),
                          onReset: () => ref
                                .read(beverageQuantitiesProvider.notifier)
                                .resetBeverage(beverage.title),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Align(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 260),
                      child: PlaceOrderButton(
                        onPressed:
                            hasSelections ? () => _placeOrder(context) : null,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
