import 'package:android/pages/pages.dart';
import 'package:android/widgets/feed_container.dart';
import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../widgets/form_app_bar.dart';
import 'package:android/models/models.dart';
import 'package:android/models/user_model.dart';
import 'package:android/data/data.dart';
import '../widgets/form_widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Item {
  Item(this.name, this.icon);
  String name;
  Icon icon;

  @override
  bool operator ==(Object other) => other is Item && other.name == name;
}

const dropdown_items = ["Events", "Art Items", "Comments", "Auctions"];
var dropdown_selection = ValueNotifier<String>("Events");
var selected_items = events;

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

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
    this.name = user.name;
    this.username = user.username;
  }

  void navigateToEditPage() {
    print("navigator, alligator");
    /*
      This function will redirect user to the edit page
    */
  }




  @override
  Widget build(BuildContext context) {
    String dropdown_value = dropdown_items[0];
    var show_data = events;
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
                CircleAvatar(
                  foregroundImage: NetworkImage(url),
                  radius: 20,
                ),
                Column(
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.subtitle1,
                      textScaleFactor: 1.25,
                    ),
                    Text(
                      "@$username",
                      style: Theme.of(context).textTheme.subtitle2,
                      textScaleFactor: 1.25,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.settings,
                    size: 40,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
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
                          style: Theme.of(context).textTheme.subtitle2,
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
                          style: Theme.of(context).textTheme.subtitle2,
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
                          style: Theme.of(context).textTheme.subtitle2,
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
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
              ],
            ),
            if (name == "") ...[
              Container(
                height: 52.0,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: navigateToOtherFormText(
                            "You completed 1/2 steps of profile customization.",
                            "",
                            navigateToEditPage,
                            Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(0.5),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                          child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 12,
                            animation: true,
                            lineHeight: 15.0,
                            animationDuration: 2500,
                            percent: 0.5,
                            center: const Text("50.0%"),
                            // linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                    ),
                  ],
                ),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20.0,
                                        backgroundColor: Colors.grey[300],
                                        backgroundImage: NetworkImage(
                                            selected_items[index].creator.imageUrl),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              selected_items[index].eventInfo.name,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4.0),
                                            Row(
                                              children: [
                                                Icon(Icons.supervisor_account,
                                                    size: 12.0,
                                                    color: Colors.grey[600]),
                                                const SizedBox(width: 5.0),
                                                Text(
                                                    "Host: ${selected_items[index].creator.name}"),
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
                                        selected_items[index]
                                            .eventInfo
                                            .startingDate
                                            .toString()
                                            .substring(0, 16),
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
                                      Text(selected_items[index].location.address)
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: null,
                                icon: Icon(Icons.keyboard_arrow_right,
                                    color: Colors.blueGrey.shade900, size: 35),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            /*Expanded(
              child: ListView.builder(
                itemCount: events.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return OutlinedButton(
                    onPressed: null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(padding: EdgeInsets.all(2.0)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20.0,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage: NetworkImage(
                                          events[index].creator.imageUrl),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            events[index].eventInfo.name,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            children: [
                                              Icon(Icons.supervisor_account,
                                                  size: 12.0,
                                                  color: Colors.grey[600]),
                                              const SizedBox(width: 5.0),
                                              Text(
                                                  "Host: ${events[index].creator.name}"),
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
                                      events[index]
                                          .eventInfo
                                          .startingDate
                                          .toString()
                                          .substring(0, 16),
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
                                    Text(events[index].location.address)
                                  ],
                                )
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: null,
                              icon: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.blueGrey.shade900, size: 35),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
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
    if(selection == "Events") {
      selected_items = events;
    } else {
      selected_items = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded : true,
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
          child: Text(value, style: Theme.of(context).textTheme.headline6)
        );
      }).toList(),
    );
  }
}
