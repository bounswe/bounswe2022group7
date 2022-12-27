import 'package:android/models/models.dart';
import 'package:android/network/search/search_art_item_service.dart';
import 'package:android/network/search/search_discussion_post_service.dart';
import 'package:android/network/search/search_online_gallery_service.dart';
import 'package:android/network/search/search_outputs.dart';
import 'package:android/network/search/search_physical_exhibition_service.dart';
import 'package:android/network/search/search_user_service.dart';
import 'package:android/pages/discussion_page.dart';
import 'package:android/pages/pages.dart';
import 'package:flutter/material.dart';

import '../network/image/get_image_builder.dart';
import '../widgets/tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchState();
}

const dropdown_items = [
  "User",
  "Physical Exhibition",
  "Online Gallery",
  "Art Item",
  "Discussion Post"
];

var dropdown_selection = ValueNotifier<String>("User");
var search_lists = {
  "User": [],
  "Physical Exhibition": [],
  "Online Gallery": [],
  "Art Item": [],
  "Discussion Post": []
};

var selected_items = [];

String _input = '';

class _SearchState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.blue[300],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(padding: EdgeInsets.all(8.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 30,
                width: MediaQuery.of(context).size.width - 220,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 0.75),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextField(
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    style: Theme.of(context).textTheme.subtitle2,
                    onChanged: (value) => _input = value,
                    autocorrect: false,
                    autofocus: true,
                    decoration: InputDecoration(
                      // alignLabelWithHint: true,
                      hintText: "Search Keyword",
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: InkWell(
                          onTap: () => _onSearchFieldChanged(_input),
                          child: Icon(
                            Icons.send,
                          )),
                    )) // we'll add our form field here later!
                ),
            const Padding(padding: EdgeInsets.all(8.0)),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 0.75),
                borderRadius: BorderRadius.circular(4.0),
              ),
              width: 200,
              height: 30,
              child: const DropdownButtonExample(),
            ),
          ],
        ),
        if (dropdown_selection.value == "User") ...[
          Expanded(
            child: ListView.builder(
              itemCount: selected_items.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Account acc = selected_items[index] as Account;
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                        username: acc.account_info.username,
                                      )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            circleAvatarBuilder(
                                acc.account_info.profile_picture_id, 14.0),
                            Text(
                              "${acc.account_info.name} ${acc.account_info.surname}",
                              style: Theme.of(context).textTheme.bodyText1,
                              textScaleFactor: 1.25,
                            ),
                            Text(
                              "Level: ${acc.level}",
                              style: Theme.of(context).textTheme.bodyText1,
                              textScaleFactor: 1.25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ] else if (dropdown_selection.value == "Discussion Post") ...[
          Expanded(
            child: ListView.builder(
              itemCount: selected_items.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiscussionPage(
                                        discussion: selected_items[index],
                                      )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            circleAvatarBuilder(
                                selected_items[index]
                                    .creatorAccountInfo
                                    .profile_picture_id,
                                20.0),
                            Column(
                              children: [
                                Text(
                                  selected_items[index].title,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textScaleFactor: 1.25,
                                ),
                                Text(
                                  "${selected_items[index].textBody.substring(0, selected_items[index].textBody.length <= 20 ? selected_items[index].textBody.length : 20)}...",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textScaleFactor: 1.25,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ] else ...[
          Expanded(
              child: (selected_items ?? []).isNotEmpty
                  ? GridView.count(
                      shrinkWrap: true,
                      childAspectRatio: 1,
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(2.0),
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      children: selected_items.map((r) => Tile(r)).toList())
                  : Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: selected_items == null
                          ? Container()
                          : Text("No results for '$_input'",
                              style: Theme.of(context).textTheme.caption))),
        ],
      ]),
    );
  }

  void _onSearchFieldChanged(String value) async {
    print("value is: $value");

    if (value.isEmpty) {
      setState(() => selected_items = []);
    }

    final results = await _makeSearch(value);
    print(results);
    setState(() {
      selected_items = results;
      if (value.isEmpty) {
        selected_items = [];
      }
    });
  }

  Future<List<dynamic>> _makeSearch(String value) async {
    String selection = dropdown_selection.value;
    List<dynamic> result = [];
    bool cond = true;
    int j = 0;
    print(selection);
    print("Physical Exhibition");

    if (selection == "Physical Exhibition") {
      SearchPhysicalExhibitonOutput speo =
          await searchPhysicalExhibitonNetwork(value);
      result = speo.physicalExhibitonSearch!.eventList;
    } else if (selection == "Online Gallery") {
      SearchOnlineGalleryOutput sogo = await searchOnlineGalleryNetwork(value);
      result = sogo.onlineGallerySearch!.eventList;
    } else if (selection == "Art Item") {
      SearchArtItemOutput saio = await searchArtItemNetwork(value);
      result = saio.artItemSearch!.artItemList;
    } else if (selection == "User") {
      SearchUserOutput suo = await searchUserNetwork(value);
      result = suo.userSearch!.userList;
    } else if (selection == "Discussion Post") {
      SearchDiscussionPostOutput sdpo =
          await searchDiscussionPostNetwork(value);
      result = sdpo.discussionPostSearch!.discussionList;
    }

    return result;
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = dropdown_selection.value;

  void updateSelectedItems() {
    String selection = dropdown_selection.value;
    selected_items = search_lists[selection]!;
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
