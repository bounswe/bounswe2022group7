class MaxBid {
  final double? bidAmount;
  final int id;

  MaxBid({this.bidAmount, required this.id});

  factory MaxBid.fromJson(Map<String, dynamic> json) {
    return MaxBid(
      id: json['id'],
      bidAmount: json['bidAmount'],
    );
  }
}
