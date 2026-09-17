import 'package:flutter/material.dart';

enum SaleMode { buyNow, descendingAuction, offer }

enum ListingCondition { newItem, excellent, good, fair }

class Listing {
  final String id;
  final String title;
  final String category;
  final double price;
  final double startPrice;
  final double minimumPrice;
  final double drop;
  final int followers;
  final IconData icon;
  final SaleMode mode;
  final ListingCondition condition;
  final bool verifiedSeller;
  final bool inShowcase;
  final String location;

  const Listing({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.startPrice,
    required this.minimumPrice,
    required this.drop,
    required this.followers,
    required this.icon,
    required this.mode,
    required this.condition,
    required this.verifiedSeller,
    required this.inShowcase,
    required this.location,
  });

  double get progress {
    if (startPrice <= minimumPrice) return 1;
    final value = (startPrice - price) / (startPrice - minimumPrice);
    return value.clamp(0, 1).toDouble();
  }
}
