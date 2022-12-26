import 'package:flutter_dotenv/flutter_dotenv.dart';

String serverPort = dotenv.env['SERVER_PORT'] ?? "8080";
String serverIP = dotenv.env['SERVER_IP'] ?? "http://10.0.2.2";
String baseURL = "$serverIP:$serverPort/api";

String annotationsURL = "$serverIP:$serverPort/annotations";

String registerURL = "$baseURL/signup";
String loginURL = "$baseURL/login";
String eventURL = "$baseURL/event";
String artItemURL = "$baseURL/art_item";
String homepageURL = "$baseURL/homepage";
String profileURL = "$baseURL/profile";
String getImageURL = "$baseURL/image";
String followURL = "$baseURL/follow";
String discussionURL = "$baseURL/discussionPost";
String settingsURL = "$baseURL/profile/settings";
String commentURL = "$baseURL/comment";
String reportURL = "$baseURL/report";
String searchUserURL = "$baseURL/search_user";
String searchPhysicalURL = "$baseURL/search_physical_exhibition";
String searchOnlineURL = "$baseURL/search_online_gallery";
String searchDiscussionURL = "$baseURL/search_discussion_post";
String searchArtItemURL = "$baseURL/search_art_item";
