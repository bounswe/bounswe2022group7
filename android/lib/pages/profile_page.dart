import 'dart:convert';

import 'package:android/network/image/get_image_builder.dart';
import 'package:android/pages/pages.dart';
import 'package:android/widgets/feed_container.dart';
import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../network/profile/post_follow_service.dart';
import '../widgets/form_app_bar.dart';
import 'package:android/models/models.dart';
import 'package:android/models/user_model.dart';
import 'package:android/data/data.dart';
import '../widgets/form_widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:android/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:android/network/profile/get_user_output.dart';
import 'package:android/network/profile/get_user_service.dart';
import 'package:android/network/image/get_image_output.dart';
import 'package:android/network/image/get_image_service.dart';
import 'package:android/network/home/get_postlist_output.dart';
import 'package:android/network/home/get_postlist_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'art_item_page.dart';

class Item {
  Item(this.name, this.icon);
  String name;
  Icon icon;

  @override
  bool operator ==(Object other) => other is Item && other.name == name;
}

const dropdown_items = ["Events", "Art Items", "Comments", "Auctions"];
var dropdown_selection = ValueNotifier<String>("Events");
final followButtonText = ValueNotifier<String>("Follow");

String? profile_username;
var post_lists = {
  "Events": [],
  "Art Items": [],
  "Comments": [],
  "Auctions": [],
};
var selected_items = [];

void updateSelectedItems() {
  String selection = dropdown_selection.value;
  if (selection == "Events") {
    selected_items = post_lists[selection]!;
  } else if (selection == "Art Items") {
    selected_items = post_lists[selection]!;
  } else {
    selected_items = ["as"];
  }
}

class ProfilePage extends StatefulWidget {
  String? username;
  ProfilePage({Key? key, this.username}) : super(key: key) {
    profile_username = username;
  }

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String url;
  late String name;
  late String username;
  late User user = dali;

  _ProfilePageState() {
    this.url = user.imageUrl;
    this.name = user.name!;
    this.username = user.username;
  }

  void navigateToEditPage() {
    print("navigator, alligator");
    Navigator.pushNamed(context, settingsPage);
  }

  void updatePostLists(List<Event> event_list, List<ArtItem> art_item_list) {
    post_lists["Events"] = event_list;
    post_lists["Art Items"] = art_item_list;
  }

  Future<void> followUser() async {
    if (followButtonText.value == "Follow") {
      final statuscode = await postFollowNetwork(profile_username!);
      if (statuscode == 202) followButtonText.value = "Following";
    }
  }

  @override
  Widget build(BuildContext context) {
    String dropdown_value = dropdown_items[0];
    var show_data = events;

    CurrentUser? current_user = Provider.of<UserProvider>(context).user;

    //Check if already following
    followButtonText.value = "Follow";
    //?: "Following";

    return FutureBuilder(
      future: getUserNetwork(profile_username, current_user),
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
              getUserOutput user_output = snapshot.data!;
              if (user_output.status != "OK") {
                return const Text(
                    "An error occured while loading profile page!");
              }

              Account user_account = user_output.account!;
              AccountInfo user_account_info = user_account.account_info;
              String fullname = "";
              if (user_account_info.name != null &&
                  user_account_info.surname != null) {
                fullname =
                    "${user_account_info.name} ${user_account_info.surname}";
              }

              bool users_check = current_user != null;
              users_check = current_user!.email == user_account_info.email
                  ? users_check
                  : false;
              updatePostLists(
                  user_account.all_events, user_account.all_art_items);
              dropdown_selection.value = "Events";
              updateSelectedItems();

              return Scaffold(
                appBar: AppBar(), // app bar will be discussed later
                body: Container(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          user_account_info.profile_picture_id == null
                              ? CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage:
                                      MemoryImage(base64Decode(defaultbase64)),
                                )
                              : profilePictureBuilder(
                                  user_account_info.profile_picture_id),
                          Column(
                            children: [
                              Text(
                                fullname,
                                style: Theme.of(context).textTheme.subtitle1,
                                textScaleFactor: 1.25,
                              ),
                              Text(
                                "@${user_account_info.username}",
                                style: Theme.of(context).textTheme.subtitle2,
                                textScaleFactor: 1.25,
                              ),
                            ],
                          ),
                          if (users_check) ...[
                            IconButton(
                              onPressed: navigateToEditPage,
                              icon: Icon(
                                Icons.settings,
                                size: 40,
                                color: Colors.blueGrey.shade900,
                              ),
                            ),
                          ],
                        ],
                      ),
                      Column(
                        children: const [
                          Padding(padding: EdgeInsets.all(8.0)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(width: 1.5),
                                borderRadius: BorderRadius.circular(8.0)),
                            height: 35,
                            child: OutlinedButton(
                              onPressed: null,
                              child: Row(
                                children: [
                                  Text(
                                    "Followers",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  const Icon(
                                    Icons.people_outlined,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            height: 35,
                            child: OutlinedButton(
                              onPressed: null,
                              child: Row(
                                children: [
                                  Text(
                                    "Followings",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  const Icon(
                                    Icons.people_outlined,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            height: 35,
                            child: OutlinedButton(
                              onPressed: null,
                              child: Row(
                                children: [
                                  Text(
                                    "Invite",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Icon(
                                    Icons.people_outlined,
                                    color: Colors.purple.shade900,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      (profile_username == null ||
                              current_user.username ==
                                  user_account_info.username)
                          ? Container()
                          : Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 12.0),
                                ValueListenableBuilder(
                                  valueListenable: followButtonText,
                                  builder: (context, value, widget) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      height: 35,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          followUser();
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                            Icon(
                                              Icons.people_outlined,
                                              color: value == "Follow"
                                                  ? Colors.green
                                                  : Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                      Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                        ],
                      ),
                      if (user_account_info.name == null) ...[
                        Container(
                          height: 25.0,
                          child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 150,
                            animation: true,
                            lineHeight: 25.0,
                            animationDuration: 1200,
                            percent: 0.5,
                            center: const Text(
                              "You completed 1/2 steps of your profile.",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                              selectionColor: Colors.white,
                            ),
                            // linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.lightBlue,
                            barRadius: Radius.circular(4.0),
                            trailing: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AccountInfoPage(
                                      email: user_account_info.email,
                                      username: user_account_info.username,
                                      name: user_account_info.name,
                                      surname: user_account_info.surname,
                                      country: user_account_info.country,
                                      dateOfBirth: user_account_info.date_of_birth,
                                      profilePictureId: user_account_info.profile_picture_id,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Go complete!",
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade900),
                                  ),
                                  Icon(
                                    Icons.double_arrow_sharp,
                                    color: Colors.blueGrey.shade900,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // child: Column(
                          //   // mainAxisSize: MainAxisSize.min,
                          //   // mainAxisAlignment: MainAxisAlignment.center,
                          //   // crossAxisAlignment: CrossAxisAlignment.center,
                          //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //
                          //   children: [
                          //
                          //     // const Padding(
                          //     //   padding: EdgeInsets.all(0.5),
                          //     // ),
                          //     // Row(
                          //     //   children: [
                          //     //     Padding(
                          //     //       padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                          //     //       child: LinearPercentIndicator(
                          //     //         width: MediaQuery.of(context).size.width - 60,
                          //     //         animation: true,
                          //     //         lineHeight: 15.0,
                          //     //         animationDuration: 1200,
                          //     //         percent: 0.5,
                          //     //         center: Text("1 / 2", style: Theme.of(context).textTheme.subtitle2,),
                          //     //         // linearStrokeCap: LinearStrokeCap.roundAll,
                          //     //         progressColor: Colors.lightBlue,
                          //     //         barRadius: Radius.circular(4.0),
                          //     //       ),
                          //     //     ),
                          //     //
                          //     //     IconButton(
                          //     //       onPressed: null,
                          //     //       icon: Icon(Icons.navigate_before_outlined, color: Colors.blueGrey.shade900,),
                          //     //     ),
                          //     //   ],
                          //     // ),
                          //     // const Padding(
                          //     //   padding: EdgeInsets.symmetric(vertical: 4.0),
                          //     // ),
                          //     // const Padding(
                          //     //   padding: EdgeInsets.all(4.0),
                          //     // ),
                          //   ],
                          // ),
                        ),
                        Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                            ),
                          ],
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 1.85),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            height: 35,
                            width: 150,
                            child: DropdownButtonExample(),
                          ),
                        ],
                      ),
                      Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: dropdown_selection,
                          builder: (context, value, widget) => ListView.builder(
                            itemCount: selected_items.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return OutlinedButton(
                                onPressed: null,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Padding(padding: EdgeInsets.all(2.0)),
                                    if (dropdown_selection.value ==
                                        "Events") ...[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  user_account_info
                                                              .profile_picture_id ==
                                                          null
                                                      ? CircleAvatar(
                                                          radius: 20.0,
                                                          backgroundColor:
                                                              Colors.grey[300],
                                                          backgroundImage:
                                                              MemoryImage(
                                                                  base64Decode(
                                                                      defaultbase64)),
                                                        )
                                                      : profilePictureBuilder(
                                                          user_account_info
                                                              .profile_picture_id),
                                                  const SizedBox(width: 10.0),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          selected_items[index]
                                                              .postInfo
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                            height: 4.0),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .supervisor_account,
                                                                size: 12.0,
                                                                color: Colors
                                                                    .grey[600]),
                                                            const SizedBox(
                                                                width: 5.0),
                                                            Text(
                                                                "Host: ${selected_items[index].creatorAccountInfo.name ?? ""} ${selected_items[index].creatorAccountInfo.surname ?? ""}"),
                                                          ],
                                                        )
                                                      ]),
                                                ],
                                              ),
                                              const SizedBox(height: 10.0),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.grey[600],
                                                    size: 12.0,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    "${selected_items[index].eventInfo.startingDate.toString().substring(0, 16)} - ${selected_items[index].eventInfo.endingDate.toString().substring(0, 16)}",
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_pin,
                                                    color: Colors.grey[600],
                                                    size: 12.0,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(selected_items[index]
                                                              .location !=
                                                          null
                                                      ? selected_items[index]
                                                          .location
                                                          ?.address
                                                      : "Online"),
                                                ],
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventPage(
                                                    id: selected_items[index]
                                                        .id,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.blueGrey.shade900,
                                                size: 35),
                                          ),
                                        ],
                                      ),
                                    ] else if (dropdown_selection.value ==
                                        "Art Items") ...[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  user_account_info
                                                              .profile_picture_id ==
                                                          null
                                                      ? CircleAvatar(
                                                          radius: 20.0,
                                                          backgroundColor:
                                                          Colors.grey[300],
                                                          backgroundImage:
                                                          MemoryImage(
                                                              base64Decode(
                                                                  defaultbase64)),
                                                        )
                                                      : profilePictureBuilder(
                                                          user_account_info
                                                              .profile_picture_id),
                                                  const SizedBox(width: 10.0),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          selected_items[index]
                                                              .postInfo
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                            height: 4.0),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .supervisor_account,
                                                                size: 12.0,
                                                                color: Colors
                                                                    .grey[600]),
                                                            const SizedBox(
                                                                width: 5.0),
                                                            Text(
                                                                "Creator: ${selected_items[index].creatorAccountInfo.name ?? ""} ${selected_items[index].creatorAccountInfo.surname ?? ""}"),
                                                          ],
                                                        )
                                                      ]),
                                                ],
                                              ),
                                              const SizedBox(height: 10.0),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.grey[600],
                                                    size: 12.0,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(selected_items[index]
                                                      .creationDate
                                                      .toString()
                                                      .substring(0, 16)),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.money,
                                                    color: Colors.grey[600],
                                                    size: 12.0,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                      "${selected_items[index].lastPrice.toString()} ₺"),
                                                ],
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ArtItemPage(
                                                    id: selected_items[index]
                                                        .id,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.blueGrey.shade900,
                                                size: 35),
                                          ),
                                        ],
                                      ),
                                    ]
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text("Error occurred");
            }
        }
      },
    );
  }
}

Widget profilePictureBuilder(picture_id) {
  return FutureBuilder(
      future: getImageNetwork(picture_id),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          default:
            if (snapshot.hasError) {
              return const Text("Error");
            }

            if (snapshot.data != null) {
              GetImageOutput image_output = snapshot.data!;
              if (image_output.status != "OK") {
                return const Text(
                    "An error occured while loading profile page!");
              }
              String final_string = image_output.image!.base64String;
              if(image_output.image!.base64String.contains("data:image/png;base64,")) {
                final_string = image_output.image!.base64String.split("data:image/png;base64,").elementAt(1);
              }
              return CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
                backgroundImage:
                    MemoryImage(base64Decode(final_string)),
              );
            } else {
              return const Text("");
            }
        }
      });
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = dropdown_items.first;

  void updateSelectedItems() {
    String selection = dropdown_selection.value;
    if (selection == "Events") {
      selected_items = post_lists[selection]!;
    } else if (selection == "Art Items") {
      selected_items = post_lists[selection]!;
    } else {
      selected_items = ["as"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          dropdown_selection.value = value;
          updateSelectedItems();
        });
      },
      items: dropdown_items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: Theme.of(context).textTheme.headline6));
      }).toList(),
    );
  }
}
