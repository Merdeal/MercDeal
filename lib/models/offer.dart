enum OfferStatus { pending, accepted, rejected, countered, expired, withdrawn }

class Offer {
  final String id;
  final String listingId;
  final String buyerId;
  final String sellerId;
  final int amountCents;
  final int shippingCents;
  final int totalCents;
  final OfferStatus status;
  final DateTime createdAt;

  const Offer({
    required this.id,
    required this.listingId,
    required this.buyerId,
    required this.sellerId,
    required this.amountCents,
    required this.shippingCents,
    required this.totalCents,
    required this.status,
    required this.createdAt,
  });
}
