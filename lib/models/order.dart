enum DeliveryMode{shipping,handPickup}
class Order { final String id; final DeliveryMode delivery; final double total; const Order({required this.id,required this.delivery,required this.total}); }
