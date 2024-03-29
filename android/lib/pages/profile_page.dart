import 'dart:convert';

import 'package:android/network/event/get_event_output.dart';
import 'package:android/network/event/get_event_service.dart';

import 'package:android/network/art_item/get_art_item_output.dart';
import 'package:android/network/art_item/get_art_item_service.dart';

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

const dropdown_items = ["Events", "Art Items", "Auctions"];
var dropdown_selection = ValueNotifier<String>("Events");
final followButtonText = ValueNotifier<String>("Follow");

String? profileUsername;
var post_lists = {
  "Events": [],
  "Art Items": [],
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
    profileUsername = username;
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
      final statuscode = await postFollowNetwork(profileUsername!);
      if (statuscode == 202) followButtonText.value = "Following";
    }
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = dropdown_items[0];
    var showData = events;

    CurrentUser? currentUser = Provider.of<UserProvider>(context).user;

    followButtonText.value = "Follow";

    return FutureBuilder(
      future: getUserNetwork(profileUsername, currentUser),
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

              Account userAccount = user_output.account!;
              AccountInfo userAccountInfo = userAccount.account_info;
              String fullname = "";
              if (userAccountInfo.name != null &&
                  userAccountInfo.surname != null) {
                fullname = "${userAccountInfo.name} ${userAccountInfo.surname}";
              }
              for (var username in userAccount.followedByUsernames) {
                if (currentUser != null && currentUser.username == username) {
                  followButtonText.value = "Following";
                }
              }
              bool usersCheck = currentUser != null;
              usersCheck = currentUser!.email == userAccountInfo.email
                  ? usersCheck
                  : false;
              updatePostLists(
                  userAccount.all_events, userAccount.all_art_items);
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
                          circleAvatarBuilder(
                              userAccountInfo.profile_picture_id, 20.0),
                          Column(
                            children: [
                              Row(children: [
                                Text(
                                  fullname,
                                  style: Theme.of(context).textTheme.subtitle1,
                                  textScaleFactor: 1.25,
                                ),
                                if (userAccount.is_verified) ...[
                                  const Icon(
                                    Icons.verified,
                                    color: Colors.lightBlue,
                                  ),
                                ],
                              ]),
                              Text(
                                "@${userAccountInfo.username}",
                                style: Theme.of(context).textTheme.subtitle2,
                                textScaleFactor: 1.25,
                              ),
                              Text(
                                "Level: ${userAccount.level}",
                                style: Theme.of(context).textTheme.subtitle2,
                                textScaleFactor: 1.25,
                              ),
                            ],
                          ),
                          if (usersCheck) ...[
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
                      (profileUsername == null ||
                              currentUser.username == userAccountInfo.username)
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
                      if (userAccountInfo.name == null &&
                          currentUser.email == userAccountInfo.email) ...[
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
                                      email: userAccountInfo.email,
                                      username: userAccountInfo.username,
                                      name: userAccountInfo.name,
                                      surname: userAccountInfo.surname,
                                      country: userAccountInfo.country,
                                      dateOfBirth:
                                          userAccountInfo.date_of_birth,
                                      profilePictureId:
                                          userAccountInfo.profile_picture_id,
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
                                    if (dropdown_selection.value! ==
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
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              160,
                                                          child: Text(
                                                            selected_items[
                                                                    index]
                                                                .postInfo
                                                                .name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
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
                                                    "${selected_items[index].eventInfo.startingDate.toString().substring(0, 11)} - ${selected_items[index].eventInfo.endingDate.toString().substring(0, 11)}",
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
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            160,
                                                    child: Text(selected_items[
                                                                    index]
                                                                .location !=
                                                            null
                                                        ? selected_items[index]
                                                            .location
                                                            ?.address
                                                        : "Online"),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: 60,
                                            width: 60,
                                            child: imageBuilderWithSizeToFit(
                                                selected_items[index]
                                                    .postInfo
                                                    .imageId,
                                                60,
                                                MediaQuery.of(context)
                                                    .size
                                                    .height),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FutureBuilder(
                                                    future: getEventNetwork(
                                                        selected_items[index]
                                                            .id),
                                                    builder:
                                                        (context, snapshot) {
                                                      switch (snapshot
                                                          .connectionState) {
                                                        case ConnectionState
                                                            .none:
                                                        case ConnectionState
                                                            .waiting:
                                                          return const CircularProgressIndicator();
                                                        default:
                                                          if (snapshot
                                                              .hasError) {
                                                            return EventPage(
                                                                event: null);
                                                          }

                                                          if (snapshot.data !=
                                                              null) {
                                                            GetEventOutput
                                                                responseData =
                                                                snapshot.data!;
                                                            if (responseData
                                                                    .status !=
                                                                "OK") {
                                                              return EventPage(
                                                                  event: null);
                                                            }
                                                            Event currentEvent =
                                                                responseData
                                                                    .event!;
                                                            currentEvent
                                                                .updateStatus(user
                                                                    .username);
                                                            return EventPage(
                                                                event:
                                                                    currentEvent);
                                                          } else {
                                                            // snapshot.data == null
                                                            return EventPage(
                                                                event: null);
                                                          }
                                                      }
                                                    },
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
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              160,
                                                          child: Text(
                                                            selected_items[
                                                                    index]
                                                                .postInfo
                                                                .name,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
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
                                          Container(
                                            height: 60,
                                            width: 60,
                                            child: imageBuilderWithSizeToFit(
                                                selected_items[index]
                                                    .postInfo
                                                    .imageId,
                                                60,
                                                MediaQuery.of(context)
                                                    .size
                                                    .height),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FutureBuilder(
                                                    future: getArtItemNetwork(
                                                        selected_items[index]
                                                            .id),
                                                    builder:
                                                        (context, snapshot) {
                                                      switch (snapshot
                                                          .connectionState) {
                                                        case ConnectionState
                                                            .none:
                                                        case ConnectionState
                                                            .waiting:
                                                          return const CircularProgressIndicator();
                                                        default:
                                                          if (snapshot
                                                              .hasError) {
                                                            return ArtItemPage(
                                                              artItem: null,
                                                            );
                                                          }

                                                          if (snapshot.data !=
                                                              null) {
                                                            GetArtItemOutput
                                                                responseData =
                                                                snapshot.data!;
                                                            if (responseData
                                                                    .status !=
                                                                "OK") {
                                                              return ArtItemPage(
                                                                artItem: null,
                                                              );
                                                            }
                                                            ArtItem
                                                                currentArtItem =
                                                                responseData
                                                                    .artItem!;
                                                            if (user != null) {
                                                              currentArtItem
                                                                  .updateStatus(
                                                                      user.username);
                                                            }
                                                            return ArtItemPage(
                                                              artItem:
                                                                  currentArtItem,
                                                            );
                                                          } else {
                                                            // snapshot.data == null
                                                            return ArtItemPage(
                                                              artItem: null,
                                                            );
                                                          }
                                                      }
                                                    },
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
  return circleAvatarBuilder(picture_id, 20.0);
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
          dropdown_selection.value = value!;
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
