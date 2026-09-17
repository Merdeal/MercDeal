enum DeliveryMethod { shipping, handPickup }
enum OrderStatus {
  pendingPayment,
  paid,
  shipping,
  delivered,
  inspection,
  completed,
  disputed,
  cancelled,
  pickupScheduled,
}

class Order {
  final String id;
  final String listingId;
  final String buyerId;
  final String sellerId;
  final int itemPriceCents;
  final int shippingCents;
  final int protectionCents;
  final int totalCents;
  final DeliveryMethod deliveryMethod;
  final OrderStatus status;
  final Map<String, dynamic> termsSnapshot;

  const Order({
    required this.id,
    required this.listingId,
    required this.buyerId,
    required this.sellerId,
    required this.itemPriceCents,
    required this.shippingCents,
    required this.protectionCents,
    required this.totalCents,
    required this.deliveryMethod,
    required this.status,
    this.termsSnapshot = const {},
  });
}
