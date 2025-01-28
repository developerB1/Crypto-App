import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/models/cryptocurrency.dart';
import '../../shared/services/crypto_service.dart';

final cryptoServiceProvider = Provider<CryptoService>((ref) {
  return CryptoService();
});

final topCryptocurrenciesProvider =
    FutureProvider.autoDispose<List<Cryptocurrency>>((ref) async {
  final cryptoService = ref.watch(cryptoServiceProvider);
  return cryptoService.getTopCryptocurrencies();
});

final cryptoDetailsProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, id) async {
  final cryptoService = ref.watch(cryptoServiceProvider);
  return cryptoService.getCryptocurrencyDetails(id);
});

final marketChartProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, id) async {
  final cryptoService = ref.watch(cryptoServiceProvider);
  return cryptoService.getMarketChart(id);
});

final trendingCryptocurrenciesProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final cryptoService = ref.watch(cryptoServiceProvider);
  return cryptoService.getTrendingCryptocurrencies();
});

class CryptoNotifier extends StateNotifier<AsyncValue<List<Cryptocurrency>>> {
  final CryptoService _cryptoService;

  CryptoNotifier(this._cryptoService) : super(const AsyncValue.loading()) {
    loadCryptocurrencies();
  }

  Future<void> loadCryptocurrencies() async {
    try {
      state = const AsyncValue.loading();
      final cryptocurrencies = await _cryptoService.getTopCryptocurrencies();
      state = AsyncValue.data(cryptocurrencies);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshCryptocurrencies() async {
    try {
      final cryptocurrencies = await _cryptoService.getTopCryptocurrencies();
      state = AsyncValue.data(cryptocurrencies);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final cryptoNotifierProvider =
    StateNotifierProvider<CryptoNotifier, AsyncValue<List<Cryptocurrency>>>(
        (ref) {
  final cryptoService = ref.watch(cryptoServiceProvider);
  return CryptoNotifier(cryptoService);
});
