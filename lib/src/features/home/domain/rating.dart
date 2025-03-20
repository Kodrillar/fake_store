class Rating {
  Rating({
    required this.rate,
    required this.count,
  });
  final num rate;
  final int count;

  @override
  String toString() => 'Rating(rate: $rate, count: $count)';
}
