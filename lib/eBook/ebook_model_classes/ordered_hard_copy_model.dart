class OrderedHardCopyModel {
  String userId;
  String orderNumber;
  String shippingAddress;
  String totalPrice;
  String orderDate;

  OrderedHardCopyModel(
      {required this.userId,
      required this.orderNumber,
      required this.shippingAddress,
      required this.totalPrice,
      required this.orderDate});
}
