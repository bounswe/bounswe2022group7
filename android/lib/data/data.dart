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
    name: '',
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
      eventType: "physical",
      eventInfo: EventInfo(
        id: 1,
        name: 'Van Gogh Exhibition',
        endingDate: DateTime(2021, 12, 31),
        startingDate: DateTime(2021, 12, 1),
        description: 'A great exhibition of Van Gogh\'s works.',
        category: ['Post-Impressionism '],
        labels: ['french', 'post-impressionism', 'painting'],
        posterId: 1,
      ),
      creatorAccountInfo: AccountInfo(
          email: "mehmet@gmail.com",
          username: "mehmet",
          id: 1,
          name: null,
          surname: null,
          country: null,
          date_of_birth: null,
          profile_picture_id: null),
      collaboratorAccountInfos: [
        AccountInfo(
            email: "mehmet@gmail.com",
            username: "mehmet",
            id: 1,
            name: null,
            surname: null,
            country: null,
            date_of_birth: null,
            profile_picture_id: null)
      ],
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
      bookmarkedBy: ["mehmet"]),
  Event(
      id: 2,
      eventType: "physical",
      eventInfo: EventInfo(
        id: 2,
        name: 'Dali Exhibition',
        endingDate: DateTime(2021, 12, 31),
        startingDate: DateTime(2021, 12, 1),
        description: 'A great exhibition of Dali\'s works.',
        category: ['Surrealism'],
        labels: ['spanish', 'surrealism', 'painting'],
        posterId: 2,
      ),
      creatorAccountInfo: AccountInfo(
          email: "mehmet@gmail.com",
          username: "mehmet",
          id: 1,
          name: null,
          surname: null,
          country: null,
          date_of_birth: null,
          profile_picture_id: null),
      collaboratorAccountInfos: [],
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
      bookmarkedBy: ["mehmet", "ahmet"]),
];

const String defaultbase64 =
    "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";
