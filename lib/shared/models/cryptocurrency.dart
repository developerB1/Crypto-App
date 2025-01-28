class Cryptocurrency {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final double priceChangePercentage24h;
  final double marketCap;
  final String image;
  final List<double> sparklineData;

  Cryptocurrency({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.marketCap,
    required this.image,
    required this.sparklineData,
  });

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) {
    return Cryptocurrency(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      currentPrice: (json['current_price'] as num).toDouble(),
      priceChangePercentage24h:
          (json['price_change_percentage_24h'] as num).toDouble(),
      marketCap: (json['market_cap'] as num).toDouble(),
      image: json['image'] as String,
      sparklineData: (json['sparkline_in_7d']['price'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'current_price': currentPrice,
      'price_change_percentage_24h': priceChangePercentage24h,
      'market_cap': marketCap,
      'image': image,
      'sparkline_in_7d': {
        'price': sparklineData,
      },
    };
  }
}
