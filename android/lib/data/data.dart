import 'package:android/models/models.dart';

final User vanGogh = User(
    userType: "Artist",
    name: 'Vincent van Gogh',
    email: 'vg@mail.com',
    username: "username",
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg/1280px-Vincent_van_Gogh_-_Self-Portrait_-_Google_Art_Project.jpg');
final User dali = User(
    userType: "Artist",
    username: "username",
    name: 'Salvador Dali',
    email: 'dl@mail.com',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Salvador_Dal%C3%AD_1939.jpg/1280px-Salvador_Dal%C3%AD_1939.jpg');

final User ahmet = User(
    userType: "Regular User",
    username: "username",
    name: 'Ahmet',
    email: 'ahmet@mail.com',
    imageUrl: 'https://api.minimalavatars.com/avatar/awesome/png');

final User mehmet = User(
    userType: "Regular User",
    username: "username",
    name: 'Mehmet',
    email: 'mehmet@mail.com',
    imageUrl: 'https://api.minimalavatars.com/avatar/is/png');

final User tom = User(
  userType: "Regular User",
  name: 'Tom Bombadil',
  email: 'bombadil@anduin.me',
  imageUrl: 'https://avatarfiles.alphacoders.com/935/93509.jpg',
  username: '@tombadil',
);

final List<ArtItem> artItems = [
  ArtItem(
    name: 'The Starry Night',
    description:
        'The Starry Night is an oil on canvas by the Dutch post-impressionist painter Vincent van Gogh. Painted in June 1889, it depicts the view from the east-facing window of his asylum room at Saint-Rémy-de-Provence, just before sunrise, with the addition of an idealized village. It has been in the permanent collection of the Museum of Modern Art in New York City since 1941, acquired through the Lillie P. Bliss Bequest. Widely regarded as Van Gogh\'s magnum opus, The Starry Night is one of the most recognized paintings in the history of Western culture.',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1200px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
    artist: vanGogh,
  ),
  ArtItem(
    name: 'The Persistence of Memory',
    description:
        'The Persistence of Memory is a 1931 painting by Spanish surrealist artist Salvador Dalí. It depicts melting pocket watches set against a landscape with a distant mountain. The painting is one of Dalí\'s best-known works, and is often interpreted as a metaphor for the irreversibility of time.',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/The_Persistence_of_Memory.jpg/1200px-The_Persistence_of_Memory.jpg',
    artist: dali,
  )
];

final List<Event> events = [
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Salvador Dalí Exhibition',
    description:
        'This will show the best works of Salvador Dalí. It will be held at the Dalí Museum in Florida.',
    imageUrl:
        'https://assets3.thrillist.com/v1/image/1416328/size/tl-no_parallax_cs_2x/the-11-most-stunning-new-architecture-projects-in-america',
    location: 'Dalí Museum, Florida',
    host: mehmet,
    date: DateTime(2022, 10, 21, 13, 0),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
  Event(
    name: 'Van Gogh Exhibition',
    description:
        'This will show the best works of Vincent van Gogh. It will be held at the Van Gogh Museum in Amsterdam.',
    imageUrl: 'https://live.staticflickr.com/4161/34359066121_6d26d9c3d2_b.jpg',
    location: 'Van Gogh Museum, Amsterdam',
    host: ahmet,
    date: DateTime(2022, 10, 22, 15, 30),
  ),
];
