class Auction {
  final String listingId;
  final int currentPriceCents;
  final int decrementCents;
  final DateTime? nextDropAt;
  final bool minimumReached;

  const Auction({
    required this.listingId,
    required this.currentPriceCents,
    this.decrementCents = 20,
    this.nextDropAt,
    this.minimumReached = false,
  });

  double get currentPrice => currentPriceCents / 100;
}
