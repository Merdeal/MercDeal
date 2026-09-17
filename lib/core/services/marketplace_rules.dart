/// MercDeal business rules shared by UI previews and backend contracts.
/// Production authority remains the server/database.
class MarketplaceRules {
  const MarketplaceRules._();
  static const int auctionDailyDecrementCents = 20;
  static const List<int> allowedAuctionDurationsDays = [7, 15, 30];
  static const int packingVideoMaxSeconds = 60;
  static const int meetupFinalWindowMinutes = 10;
  static const int meetupLocationLeadMinutes = 15;
  static const int maxListingPhotos = 12;
  static const double dealPlusMonthly = 4.99;
  static const double dealPlusYearly = 39.99;
  static const int showcaseDays = 7;
}
