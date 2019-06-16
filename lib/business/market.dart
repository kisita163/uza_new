

class Market {
  Market({
    this.asset,
    this.brand,
    this.url,
    this.name,
  });

  final String asset;
  final String brand;
  final String url;
  final String name;

  String get tag => asset; // Assuming that all asset names are unique.

  bool get isValid => asset != null && brand != null;
}