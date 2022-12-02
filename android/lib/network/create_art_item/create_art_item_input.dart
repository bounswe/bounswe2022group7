class CreateArtItemInput {
  final ArtItemInfo artItemInfo;
  final Auction auction;
  final double lastPrice;
  final bool onAuction;

  CreateArtItemInput({
    required this.artItemInfo,
    required this.auction,
    required this.lastPrice,
    required this.onAuction,
  });

  Map<String, dynamic> toJson() {
    return {
      "artItemInfo": artItemInfo.toJson(),
      "auction": auction.toJson(),
      "lastPrice": lastPrice,
      "onAuction": onAuction,
    };
  }
}

class ArtItemInfo {
  final String name;
  final String description;
  final String? category;
  final String? imageEncoding;
  final String? labels;

  ArtItemInfo({
    required this.name,
    required this.description,
    this.category,
    this.imageEncoding,
    this.labels,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "category": category,
      "imageEncoding": imageEncoding,
      "labels": labels,
    };
  }
}

class Auction {
  final int id;

  Auction({required this.id});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }
}
