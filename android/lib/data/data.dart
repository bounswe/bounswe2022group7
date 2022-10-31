import 'package:android/models/art_item/art_item_creator_model.dart';
import 'package:android/models/models.dart';

final User vanGogh = User(
    id: 0,
    userType: "Artist",
    name: 'Vincent van Gogh',
    email: 'vg@mail.com',
    username: "username",
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg/1280px-Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg');
final User dali = User(
    id: 0,
    userType: "Artist",
    username: "username",
    name: 'Salvador Dali',
    email: 'dl@mail.com',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Salvador_Dal%C3%AD_1939.jpg/1280px-Salvador_Dal%C3%AD_1939.jpg');

final User ahmet = User(
    id: 0,
    userType: "Regular User",
    username: "username",
    name: 'Ahmet',
    email: 'ahmet@mail.com',
    imageUrl: 'https://api.multiavatar.com/Robo.png');

final User mehmet = User(
    id: 0,
    userType: "Regular User",
    username: "username",
    name: 'Mehmet',
    email: 'mehmet@mail.com',
    imageUrl: 'https://api.multiavatar.com/Evilnormie.png');

final User tom = User(
  id: 0,
  userType: "Regular User",
  name: 'Tom Bombadil',
  email: 'bombadil@anduin.me',
  imageUrl: 'https://avatarfiles.alphacoders.com/935/93509.jpg',
  username: '@tombadil',
);

/*final List<ArtItem> artItems = [
  ArtItem(
    id: 1,
    artItemInfo: ArtItemInfo(
      id: 1,
      name: 'Starry Night',
      description: 'A reflection of my soul from a fuzzy night.',
      category: 'Classical',
      imageUrl:
          'https://media.overstockart.com/optimized/cache/data/product_images/VG485-1000x1000.jpg',
      labels: ['classical', 'painting'],
    ),
    creator: ArtItemCreator(id: 0, name: 'van', surname: 'gogh'),
    creationDate: DateTime(2021, 10, 29),
    owner: ahmet,
    onAuction: false,
    auction: null,
    lastPrice: 0.0,
    commentList: [],
    bookmarkedBy: [ahmet],
  ),
  ArtItem(
    id: 2,
    artItemInfo: ArtItemInfo(
      id: 2,
      name: 'The Persistence of Memory',
      description: 'A reflection of my soul from a fuzzy night.',
      category: 'Classical',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/d/dd/The_Persistence_of_Memory.jpg',
      labels: ['classical', 'painting'],
    ),
    creator: ArtItemCreator(id: 0, name: 'Salvador', surname: 'Dali'),
    creationDate: DateTime(2021, 10, 29),
    owner: ahmet,
    onAuction: false,
    auction: null,
    lastPrice: 0.0,
    commentList: [],
    bookmarkedBy: [mehmet],
  ),
];*/

final List<Event> events = [
  Event(
      id: 1,
      eventInfo: EventInfo(
        id: 1,
        title: 'Van Gogh Exhibition',
        endingDate: DateTime(2021, 12, 31),
        startingDate: DateTime(2021, 12, 1),
        description: 'A great exhibition of Van Gogh\'s works.',
        category: 'Post-Impressionism ',
        labels: ['french', 'post-impressionism', 'painting'],
        posterUrl:
            'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
      ),
      creator: ahmet,
      collaborators: [mehmet],
      participants: [],
      creationDate: DateTime(2021, 11, 20),
      commentList: [],
      location: Location(
        id: 1,
        address: 'Van Gogh Museum, Amsterdam',
        latitude: 52.358,
        longitude: 4.881,
      ),
      rules: 'No rules',
      attendees: [],
      bookmarkedBy: [mehmet]),
  Event(
      id: 2,
      eventInfo: EventInfo(
        id: 2,
        title: 'Dali Exhibition',
        endingDate: DateTime(2021, 12, 31),
        startingDate: DateTime(2021, 12, 1),
        description: 'A great exhibition of Dali\'s works.',
        category: 'Surrealism',
        labels: ['spanish', 'surrealism', 'painting'],
        posterUrl:
            'https://assets3.thrillist.com/v1/image/1416328/size/tl-no_parallax_cs_2x/the-11-most-stunning-new-architecture-projects-in-america',
      ),
      creator: mehmet,
      collaborators: [],
      participants: [],
      creationDate: DateTime(2021, 11, 20),
      commentList: [],
      location: Location(
        id: 2,
        address: 'Dali Museum, St. Petersburg',
        latitude: 27.770,
        longitude: -82.640,
      ),
      rules: 'No rules',
      attendees: [],
      bookmarkedBy: [mehmet, ahmet]),
];
