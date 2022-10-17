
import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../widgets/form_app_bar.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "User";
  String _surname = "Tom";
  String _username = "tom_bombadil";
  bool _isVerified = false;

  @override
  Widget build(BuildContext context) {
    String? person = "$_name $_surname";
    return Scaffold(
      appBar: formAppBar(),
      body: Container(
        child: Column(
          children:  [
            const Padding(
              padding: EdgeInsets.all(12.0),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.blueGrey.shade900,
                        size: 35,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(person, style: Theme.of(context).textTheme.headline6,),
                            const Icon(Icons.check_circle_outline, color: Colors.purple, size: 16),
                          ],
                        ),
                        Text("@$_username",),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.settings_applications_outlined,
                    color: Colors.blueGrey.shade900,
                    size: 35,
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 30.0)),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: null,
                  child: Row(
                    children: [
                      const Text("Followers"),
                      Icon(
                        Icons.people_outlined,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  // child: Text("Followers"),
                ),

                OutlinedButton(
                  onPressed: null,
                  child: Row(
                    children: [
                      Text("Followings"),
                      Icon(
                        Icons.people_outlined,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  // child: Text("Followers"),
                ),

              ],
            ),


            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 20.0)),
              ],
            ),


            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 3),
              ),
              child: IntrinsicHeight(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.event_note_outlined,
                        color: Colors.blueGrey.shade900,
                        size: 40,
                      ),
                    ),

                    const VerticalDivider(
                      thickness: 2,
                      indent: 8,
                      endIndent: 0,
                      color: Colors.black,
                    ),

                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.local_offer_outlined,
                        color: Colors.blueGrey.shade900,
                        size: 40,
                      ),
                    ),

                    const VerticalDivider(
                      thickness: 2,
                      indent: 8,
                      endIndent: 0,
                      color: Colors.black,
                    ),

                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.brush_outlined,
                        color: Colors.blueGrey.shade900,
                        size: 40,
                      ),
                    ),

                    const VerticalDivider(
                      thickness: 2,
                      indent: 8,
                      endIndent: 0,
                      color: Colors.black,
                    ),

                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.comment_outlined,
                        color: Colors.blueGrey.shade900,
                        size: 40,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
