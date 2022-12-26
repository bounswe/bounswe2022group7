class MaxBid {
  final double? bidAmount;
  final int id;
  final String username;

  MaxBid({this.bidAmount, required this.id, required this.username});

  factory MaxBid.fromJson(Map<String, dynamic> json) {
    print(json);
    return MaxBid(
      id: json['id'],
      bidAmount: json['bidAmount'],
      username: json['bidderAccountInfo']['username'],
    );
  }
}
