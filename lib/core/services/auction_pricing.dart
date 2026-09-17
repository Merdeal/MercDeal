/// UI-only helper. The real auction price MUST come from the backend.
class AuctionPricing {
  static const decrementCentsPerDay = 20;

  static int previewPriceCents({
    required int startPriceCents,
    required int minimumPriceCents,
    required int elapsedDays,
  }) {
    final price = startPriceCents - (elapsedDays * decrementCentsPerDay);
    return price < minimumPriceCents ? minimumPriceCents : price;
  }

  static double progress({
    required int startPriceCents,
    required int minimumPriceCents,
    required int currentPriceCents,
  }) {
    if (startPriceCents <= minimumPriceCents) return 1;
    final value =
        (startPriceCents - currentPriceCents) /
        (startPriceCents - minimumPriceCents);
    return value.clamp(0, 1).toDouble();
  }
}
