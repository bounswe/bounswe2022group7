import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:android/config/api_endpoints.dart';

Future<Image> getImage(int id) async {
  print("heiiiiei");
  // send request to imageURL
  try {
    print('$imageURL/$id');
    Response response = await get(
      Uri.parse('$imageURL/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    print(response.statusCode);
    print(response.body);
    // get the base64 string from the response
    Map<String, dynamic> data = json.decode(response.body);
    String base64String = data['base64String'];
    // decode the base64 string
    Uint8List bytes = base64Decode(base64String);
    // return the Image object
    return Image.memory(bytes);
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
    return Image.network("https://i.pinimg.com/originals/c7/9a/b6/c79ab6b3943e4e75fa0742a8ce9a76e6.jpg");
  }
}

Widget imageBuilder(int? imageId) {
  if (imageId == null) return Container();
  return FutureBuilder(
    future: getImage(imageId),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return const CircularProgressIndicator();
        default:
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Snapshot Error!"),
              ),
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }

          if (snapshot.data != null) {
            return Column(children: [
              SizedBox(
                height: 300.0,
                child: snapshot.data!,
              ),
              const SizedBox(height: 10.0),
              Text("Image ID: $imageId"),
            ]);
          } else {
            // snapshot.data == null
            return Container();
          }
      }
    },
  );
}
