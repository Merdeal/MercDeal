class AuctionPricing {
  static double priceAtDay({required double initialPrice,required double minimumPrice,required double dailyDrop,required int day}) {
    final p=initialPrice-(dailyDrop*day); return p<minimumPrice?minimumPrice:p;
  }
}
