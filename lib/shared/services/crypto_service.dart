import 'package:dio/dio.dart';
import '../models/cryptocurrency.dart';

class CryptoService {
  final Dio _dio;
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';

  CryptoService() : _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<List<Cryptocurrency>> getTopCryptocurrencies({
    int page = 1,
    int perPage = 20,
    String vsCurrency = 'usd',
  }) async {
    try {
      final response = await _dio.get(
        '/coins/markets',
        queryParameters: {
          'vs_currency': vsCurrency,
          'order': 'market_cap_desc',
          'per_page': perPage,
          'page': page,
          'sparkline': true,
          'price_change_percentage': '24h',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Cryptocurrency.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cryptocurrencies');
      }
    } catch (e) {
      throw Exception('Failed to load cryptocurrencies: $e');
    }
  }

  Future<Map<String, dynamic>> getCryptocurrencyDetails(String id) async {
    try {
      final response = await _dio.get(
        '/coins/$id',
        queryParameters: {
          'localization': false,
          'tickers': false,
          'market_data': true,
          'community_data': false,
          'developer_data': false,
          'sparkline': true,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load cryptocurrency details');
      }
    } catch (e) {
      throw Exception('Failed to load cryptocurrency details: $e');
    }
  }

  Future<Map<String, dynamic>> getMarketChart(
    String id, {
    String vsCurrency = 'usd',
    int days = 7,
  }) async {
    try {
      final response = await _dio.get(
        '/coins/$id/market_chart',
        queryParameters: {
          'vs_currency': vsCurrency,
          'days': days,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load market chart');
      }
    } catch (e) {
      throw Exception('Failed to load market chart: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTrendingCryptocurrencies() async {
    try {
      final response = await _dio.get('/search/trending');

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(
          response.data['coins'].map((coin) => coin['item']),
        );
      } else {
        throw Exception('Failed to load trending cryptocurrencies');
      }
    } catch (e) {
      throw Exception('Failed to load trending cryptocurrencies: $e');
    }
  }
}
