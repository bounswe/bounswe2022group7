
import 'package:android/widgets/feed_container.dart';
import 'package:flutter/material.dart';

import '../config/app_routes.dart';
import '../widgets/form_app_bar.dart';
import 'package:android/models/models.dart';
import 'package:android/data/data.dart';


class Item {
  Item(this.name,this.icon);
  String name;
  Icon icon;

  @override
  bool operator ==(Object other) => other is Item && other.name == name;
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final url = tom.imageUrl;
  final name = tom.name;
  final username = tom.username;
  final dropdown_items = [
    Item("Events", Icon(Icons.event_note_outlined, color: Colors.blueGrey.shade900, size: 25,),),
    Item("Biddings", Icon(Icons.local_offer_outlined, color: Colors.blueGrey.shade900, size: 25,),),
    Item("Art Items", Icon(Icons.brush_outlined, color: Colors.blueGrey.shade900, size: 25,),),
    Item("Comments", Icon(Icons.comment_outlined, color: Colors.blueGrey.shade900, size: 25,),)
  ];

  @override
  Widget build(BuildContext context) {
    Item dropdown_value = dropdown_items[0];
    return Scaffold(
      appBar: formAppBar(),
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
                    Text(name, style: Theme.of(context).textTheme.subtitle1, textScaleFactor: 1.25,),
                    Text(tom.username, style: Theme.of(context).textTheme.subtitle2, textScaleFactor: 1.25,),
                  ],
                ),

                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.settings, size: 40, color: Colors.blueGrey.shade900,),
                ),

              ],
            ),

            Column(
              children: [
                const Padding(padding: EdgeInsets.all(6.0)),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 1.5),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  height: 35,
                  child: OutlinedButton(
                    onPressed: null,
                    child: Row(
                      children: [
                        Text("Followers", style: Theme.of(context).textTheme.subtitle2,),
                        Icon(
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
                        Text("Followings", style: Theme.of(context).textTheme.subtitle2,),
                        Icon(
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
                        Text("Invite", style: Theme.of(context).textTheme.subtitle2,),
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
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
              ],
            ),

            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 1.85),
                    borderRadius: BorderRadius.circular(8.0),
                  ),

                  height: 35,
                  width: 150,

                  child: DropdownButton(
                    isExpanded: true,
                    value: dropdown_value,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: dropdown_items.map((Item item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(item.name, style: Theme.of(context).textTheme.titleLarge),
                            // const Padding(padding: EdgeInsets.all(5.0)),
                            item.icon,
                          ],
                        ),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        dropdown_value = Item((value as Item).name, (value).icon);
                      });
                    },
                  ),
                ),

              ],
            ),

            // ListView.builder(
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       child: Row(
            //         children: [
            //           CircleAvatar(
            //             radius: 20.0,
            //             backgroundColor: Colors.grey[300],
            //             backgroundImage:
            //             NetworkImage(events[index].host.imageUrl),
            //
            //           ),
            //           const SizedBox(width: 10.0),
            //           Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   events[index].name,
            //                   style: const TextStyle(
            //                     fontSize: 16.0,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //                 const SizedBox(height: 4.0),
            //                 Row(
            //                   children: [
            //                     Icon(Icons.supervisor_account,
            //                         size: 12.0,
            //                         color: Colors.grey[600]),
            //                     const SizedBox(width: 5.0),
            //                     Text("Host: ${events[index].host.name}"),
            //                   ],
            //                 )
            //               ]),
            //         ],
            //       ),
            //     );
            //   },
            // ),

            Expanded(
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
                                      backgroundImage:
                                      NetworkImage(events[index].host.imageUrl),

                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            events[index].name,
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
                                              Text("Host: ${events[index].host.name}"),
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
                                      events[index].date.toString().substring(0, 16),
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
                                    Text(events[index].location)
                                  ],
                                )
                              ],
                            ),

                            new Spacer(),

                            IconButton(
                              onPressed: null,
                              icon: Icon(Icons.keyboard_arrow_right, color: Colors.blueGrey.shade900, size: 35),
                            ),
                          ],
                        ),

                        // Text(
                        //   events[index].description,
                        //   style: const TextStyle(
                        //     fontSize: 14.0,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                      ],
                    ),
                  );






                },
              ),
            ),

            // Column(
            //   children: [
            //     ListView.builder(
            //       itemCount: events.length,
            //       shrinkWrap: true,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Row(
            //               children: [
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Row(
            //                       children: [
            //                         CircleAvatar(
            //                           radius: 20.0,
            //                           backgroundColor: Colors.grey[300],
            //                           backgroundImage:
            //                           NetworkImage(events[index].host.imageUrl),
            //
            //                         ),
            //                         const SizedBox(width: 10.0),
            //                         Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 events[index].name,
            //                                 style: const TextStyle(
            //                                   fontSize: 16.0,
            //                                   fontWeight: FontWeight.w600,
            //                                 ),
            //                                 overflow: TextOverflow.ellipsis,
            //                               ),
            //                               const SizedBox(height: 4.0),
            //                               Row(
            //                                 children: [
            //                                   Icon(Icons.supervisor_account,
            //                                       size: 12.0,
            //                                       color: Colors.grey[600]),
            //                                   const SizedBox(width: 5.0),
            //                                   Text("Host: ${events[index].host.name}"),
            //                                 ],
            //                               )
            //                             ]),
            //                       ],
            //                     ),
            //                     const SizedBox(height: 10.0),
            //                     Row(
            //                       children: [
            //                         Icon(
            //                           Icons.calendar_month,
            //                           color: Colors.grey[600],
            //                           size: 12.0,
            //                         ),
            //                         const SizedBox(width: 5.0),
            //                         Text(
            //                           events[index].date.toString().substring(0, 16),
            //                         ),
            //                       ],
            //                     ),
            //                     Row(
            //                       children: [
            //                         Icon(
            //                           Icons.location_pin,
            //                           color: Colors.grey[600],
            //                           size: 12.0,
            //                         ),
            //                         const SizedBox(width: 5.0),
            //                         Text(events[index].location)
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //               ],
            //             ),
            //
            //             // Text(
            //             //   events[index].description,
            //             //   style: const TextStyle(
            //             //     fontSize: 14.0,
            //             //     fontWeight: FontWeight.w400,
            //             //   ),
            //             // ),
            //           ],
            //         );
            //
            //
            //
            //
            //       },
            //     ),
            //
            //     Container(
            //       child: const Text("bottom"),
            //     ),
            //
            //   ],
            // ),


            // CustomScrollView(
            //   slivers: <Widget>[
            //     SliverList(
            //       delegate: SliverChildBuilderDelegate(
            //             (BuildContext context, int index) {
            //           return Container(
            //             alignment: Alignment.center,
            //             height: 100,
            //             child: Text('Item: ${events[index].name}'),
            //           );
            //         },
            //         childCount: events.length,
            //       ),
            //     ),
            //   ],
            // ),


            // BottomNavigationBar(
            //   items: const [
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.home),
            //       label: 'Home',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.event_available),
            //       label: 'Events',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.forum),
            //       label: 'Discussions',
            //     ),
            //   ],
            //   selectedItemColor: Colors.blue[600],
            //   enableFeedback: true,
            //   currentIndex: 0,
            //   onTap: (index) {
            //     if (index == 0) {
            //       //Navigator.pushNamed(context, '/home');
            //     } else if (index == 1) {
            //       //Navigator.pushNamed(context, '/events');
            //     } else if (index == 2) {
            //       //Navigator.pushNamed(context, '/discussionPage');
            //     }
            //   },
            // ),
            
            // ListView.builder(
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       child: Row(
            //         children: [
            //           CircleAvatar(
            //             radius: 20.0,
            //             backgroundColor: Colors.grey[300],
            //             backgroundImage:
            //             NetworkImage(events[index].host.imageUrl),
            //
            //           ),
            //           const SizedBox(width: 10.0),
            //           Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   events[index].name,
            //                   style: const TextStyle(
            //                     fontSize: 16.0,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //                 const SizedBox(height: 4.0),
            //                 Row(
            //                   children: [
            //                     Icon(Icons.supervisor_account,
            //                         size: 12.0,
            //                         color: Colors.grey[600]),
            //                     const SizedBox(width: 5.0),
            //                     Text("Host: ${events[index].host.name}"),
            //                   ],
            //                 )
            //               ]),
            //         ],
            //       ),
            //     );
            //   },
            // ),



          ],
        ),
      ),
    );

    // String? person = "$_name $_surname";
    // return Scaffold(
    //   appBar: formAppBar(),
    //   body: Container(
    //     child: Column(
    //       children:  [
    //         const Padding(
    //           padding: EdgeInsets.all(12.0),
    //         ),
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //
    //           children: [
    //             Row(
    //               children: [
    //                 const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
    //                 IconButton(
    //                   onPressed: null,
    //                   icon: Icon(
    //                     Icons.account_circle_outlined,
    //                     color: Colors.blueGrey.shade900,
    //                     size: 35,
    //                   ),
    //                 ),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Text(person, style: Theme.of(context).textTheme.headline6,),
    //                         const Icon(Icons.check_circle_outline, color: Colors.purple, size: 16),
    //                       ],
    //                     ),
    //                     Text("@$_username",),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             IconButton(
    //               onPressed: null,
    //               icon: Icon(
    //                 Icons.settings_applications_outlined,
    //                 color: Colors.blueGrey.shade900,
    //                 size: 35,
    //               ),
    //             ),
    //           ],
    //         ),
    //
    //         Column(
    //           children: [
    //             Padding(padding: EdgeInsets.only(top: 30.0)),
    //           ],
    //         ),
    //
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             OutlinedButton(
    //               onPressed: null,
    //               child: Row(
    //                 children: [
    //                   const Text("Followers"),
    //                   Icon(
    //                     Icons.people_outlined,
    //                     color: Colors.green,
    //                   ),
    //                 ],
    //               ),
    //               // child: Text("Followers"),
    //             ),
    //
    //             OutlinedButton(
    //               onPressed: null,
    //               child: Row(
    //                 children: [
    //                   Text("Followings"),
    //                   Icon(
    //                     Icons.people_outlined,
    //                     color: Colors.blue,
    //                   ),
    //                 ],
    //               ),
    //               // child: Text("Followers"),
    //             ),
    //
    //           ],
    //         ),
    //
    //
    //         Column(
    //           children: [
    //             Padding(padding: EdgeInsets.only(top: 20.0)),
    //           ],
    //         ),
    //
    //
    //         Container(
    //           decoration: BoxDecoration(
    //             shape: BoxShape.rectangle,
    //             border: Border.all(width: 3),
    //           ),
    //           child: IntrinsicHeight(
    //
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 IconButton(
    //                   onPressed: null,
    //                   icon: Icon(
    //                     Icons.event_note_outlined,
    //                     color: Colors.blueGrey.shade900,
    //                     size: 40,
    //                   ),
    //                 ),
    //
    //                 const VerticalDivider(
    //                   thickness: 2,
    //                   indent: 8,
    //                   endIndent: 0,
    //                   color: Colors.black,
    //                 ),
    //
    //                 IconButton(
    //                   onPressed: null,
    //                   icon: Icon(
    //                     Icons.local_offer_outlined,
    //                     color: Colors.blueGrey.shade900,
    //                     size: 40,
    //                   ),
    //                 ),
    //
    //                 const VerticalDivider(
    //                   thickness: 2,
    //                   indent: 8,
    //                   endIndent: 0,
    //                   color: Colors.black,
    //                 ),
    //
    //                 IconButton(
    //                   onPressed: null,
    //                   icon: Icon(
    //                     Icons.brush_outlined,
    //                     color: Colors.blueGrey.shade900,
    //                     size: 40,
    //                   ),
    //                 ),
    //
    //                 const VerticalDivider(
    //                   thickness: 2,
    //                   indent: 8,
    //                   endIndent: 0,
    //                   color: Colors.black,
    //                 ),
    //
    //                 IconButton(
    //                   onPressed: null,
    //                   icon: Icon(
    //                     Icons.comment_outlined,
    //                     color: Colors.blueGrey.shade900,
    //                     size: 40,
    //                   ),
    //                 ),
    //
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
