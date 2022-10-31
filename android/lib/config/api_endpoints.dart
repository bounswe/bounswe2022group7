import 'package:flutter_dotenv/flutter_dotenv.dart';

String serverPort = dotenv.env['SERVER_PORT'] ?? "8080";
String serverIP = dotenv.env['SERVER_IP'] ?? "http://10.0.2.2";
String baseURL = "$serverIP:$serverPort/api";

String registerURL = "$baseURL/signup";
String loginURL = "$baseURL/login";
String eventURL = "$baseURL/event";
String artItemURL = "$baseURL/art_item";
String homepageURL = "$baseURL/homepage";
