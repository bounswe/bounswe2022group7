class PostArtItemInput {
  final ArtItemInfo artItemInfo;
  final double lastPrice;

  PostArtItemInput({
    required this.artItemInfo,
    required this.lastPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "artItemInfo": artItemInfo.toJson(),
      "lastPrice": lastPrice,
    };
  }
}

class ArtItemInfo {
  final String name;
  final String description;
  List<String>? category;
  int? imageId;
  List<String>? labels;

  ArtItemInfo({
    required this.name,
    required this.description,
    this.category,
    this.imageId,
    this.labels,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      if (imageId != null) "imageId": imageId,
      if (category != null) "category": category,
      if (labels != null) "labels": labels,
    };
  }
}

// Auction not yet implemented
class Auction {
  final int id;

  Auction({required this.id});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }
}
