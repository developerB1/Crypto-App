import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/crypto_provider.dart';
import '../../shared/models/cryptocurrency.dart';
import '../../shared/widgets/loading_state.dart';
import '../../shared/widgets/error_state.dart';

class MarketScreen extends ConsumerWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cryptosAsyncValue = ref.watch(cryptoNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _MarketHeader(),
            const _MarketFilters(),
            Expanded(
              child: cryptosAsyncValue.when(
                data: (cryptos) => _CryptoList(cryptocurrencies: cryptos),
                loading: () => const LoadingListState(),
                error: (error, stackTrace) => ErrorState(
                  message: error.toString(),
                  onRetry: () => ref.refresh(cryptoNotifierProvider),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MarketHeader extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cryptosAsyncValue = ref.watch(cryptoNotifierProvider);
    final totalMarketCap = cryptosAsyncValue.whenOrNull(
      data: (cryptos) => cryptos.fold<double>(
        0,
        (sum, crypto) => sum + crypto.marketCap,
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Market',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => Navigator.pushNamed(context, '/search'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Market Cap',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                          ),
                    ),
                    const SizedBox(height: 4),
                    if (totalMarketCap != null)
                      Text(
                        '\$${(totalMarketCap / 1e12).toStringAsFixed(2)}T',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    else
                      const LoadingState(height: 24, width: 100),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+3.2%',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MarketFilters extends StatelessWidget {
  const _MarketFilters();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _FilterChip(
            label: 'All',
            isSelected: true,
            onTap: () {},
          ),
          _FilterChip(
            label: 'Gainers',
            isSelected: false,
            onTap: () {},
          ),
          _FilterChip(
            label: 'Losers',
            isSelected: false,
            onTap: () {},
          ),
          _FilterChip(
            label: 'Favorites',
            isSelected: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
            ),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ),
    );
  }
}

class _CryptoList extends StatelessWidget {
  final List<Cryptocurrency> cryptocurrencies;

  const _CryptoList({required this.cryptocurrencies});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh logic will be handled by the provider
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cryptocurrencies.length,
        itemBuilder: (context, index) {
          final crypto = cryptocurrencies[index];
          return ListTile(
            title: _CryptoListItem(
              symbol: crypto.symbol.toUpperCase(),
              name: crypto.name,
              price: crypto.currentPrice,
              change: crypto.priceChangePercentage24h,
              sparklineData: crypto.sparklineData,
            ),
            onTap: () => Navigator.pushNamed(
              context,
              '/asset_details',
              arguments: cryptocurrencies[index],
            ),
          );
        },
      ),
    );
  }
}

class _CryptoListItem extends StatelessWidget {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final List<double> sparklineData;

  const _CryptoListItem({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.sparklineData,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = change >= 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    symbol[0],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      symbol,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      Text(
                        '${change.abs().toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isPositive ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
