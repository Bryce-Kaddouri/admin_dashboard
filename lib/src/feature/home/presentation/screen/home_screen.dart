import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math show pi;
import '../../../auth/presentation/provider/auth_provider.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CollapsibleItem> _items;

  late String _headline;

  AssetImage _avatarImg = AssetImage('assets/man.png');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
          text: 'Categories',
          icon: Icon(Icons.category, color: Colors.red),
          onPressed: () => setState(() => _headline = 'DashBoard'),
          onHold: () => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: const Text("Dashboard"))),
          isSelected: true,
          subItems: [
            CollapsibleItem(
              text: 'Category List',
              icon: Icon(
                Icons.fiber_manual_record,
                color: Colors.red,
                size: 10,
              ),
              // dot icon
/*
              icon: Icons.fiber_manual_record,
*/

              onPressed: () => setState(() => _headline = 'Menu'),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: const Text("Menu"))),
              isSelected: true,
            ),
            CollapsibleItem(
              text: 'Add Category',
              // dot icon
              icon: Icon(
                Icons.fiber_manual_record,
                color: Colors.red,
                size: 10,
              ),
              onPressed: () => setState(() => _headline = 'Add Category'),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: const Text("Shop"))),
              isSelected: true,
            ),
          ]),
      CollapsibleItem(
        text: 'Search',
        icon: Icon(Icons.search),
        onPressed: () => setState(() => _headline = 'Search'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Search"))),
      ),
      /*CollapsibleItem(
        text: 'Notifications',
        icon: Icons.notifications,
        onPressed: () => setState(() => _headline = 'Notifications'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Notifications"))),
      ),
      CollapsibleItem(
        text: 'Settings',
        icon: Icons.settings,
        onPressed: () => setState(() => _headline = 'Settings'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Settings"))),
      ),
      CollapsibleItem(
        text: 'Alarm',
        icon: Icons.access_alarm,
        onPressed: () => setState(() => _headline = 'Alarm'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Alarm"))),
      ),
      CollapsibleItem(
        text: 'Eco',
        icon: Icons.eco,
        onPressed: () => setState(() => _headline = 'Eco'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Eco"))),
      ),
      CollapsibleItem(
        text: 'Event',
        icon: Icons.event,
        onPressed: () => setState(() => _headline = 'Event'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Event"))),
      ),
      CollapsibleItem(
        text: 'No Icon',
        onPressed: () => setState(() => _headline = 'No Icon'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("No Icon"))),
      ),
      CollapsibleItem(
        text: 'Email',
        icon: Icons.email,
        onPressed: () => setState(() => _headline = 'Email'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Email"))),
      ),
      CollapsibleItem(
          text: 'News',
          iconImage: NetworkImage(
              "https://cdn-icons-png.flaticon.com/512/330/330703.png"),
          onPressed: () => setState(() => _headline = 'News'),
          onHold: () => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: const Text("News"))),
          subItems: [
            CollapsibleItem(
              text: 'Old News',
              icon: Icons.elderly,
              onPressed: () => setState(() => _headline = 'Old News'),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: const Text("Old News"))),
            ),
            CollapsibleItem(
                text: 'Current News',
                icon: Icons.yard_outlined,
                onPressed: () => setState(() => _headline = 'Current News'),
                onHold: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text("Current News"))),
                subItems: [
                  CollapsibleItem(
                    text: 'News 1',
                    icon: Icons.one_k,
                    onPressed: () => setState(() => _headline = 'News 1'),
                    onHold: () => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: const Text("News 1"))),
                  ),
                  CollapsibleItem(
                      text: 'News 2',
                      icon: Icons.two_k,
                      onPressed: () => setState(() => _headline = 'News 2'),
                      onHold: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text("News 2"))),
                      subItems: [
                        CollapsibleItem(
                          text: 'News 2 Detail',
                          icon: Icons.two_k_outlined,
                          onPressed: () =>
                              setState(() => _headline = 'News 2 Detail'),
                          onHold: () => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  content: const Text("News 2 Detail"))),
                        )
                      ]),
                  CollapsibleItem(
                    text: 'News 3',
                    iconImage: AssetImage("assets/img.png"),
*/ /*
                    icon: Icons.three_k,
*/ /*
                    onPressed: () => setState(() => _headline = 'News 3'),
                    onHold: () => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: const Text("News 3"))),
                  )
                ]),
            CollapsibleItem(
              text: 'New News',
              icon: Icons.account_balance,
              onPressed: () => setState(() => _headline = 'New News'),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: const Text("New News"))),
            ),
          ]),
      CollapsibleItem(
        text: 'Face',
        icon: Icons.face,
        onPressed: () => setState(() => _headline = 'Face'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Face"))),
      ),*/
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        isCollapsed: MediaQuery.of(context).size.width <= 800,
        items: _items,
        collapseOnBodyTap: false,
        avatarImg: _avatarImg,
        title: 'John Smith',
        onTitleTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Yay! Flutter Collapsible Sidebar!')));
        },
        body: _body(size, context),
        backgroundColor: Colors.black,
        selectedTextColor: Colors.limeAccent,
        textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        sidebarBoxShadow: [
          BoxShadow(
            color: Colors.indigo,
            blurRadius: 20,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
          BoxShadow(
            color: Colors.green,
            blurRadius: 50,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
        ],
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Center(
        child: Transform.rotate(
          angle: math.pi / 2,
          child: Transform.translate(
            offset: Offset(-size.height * 0.3, -size.width * 0.23),
            child: Text(
              _headline,
              style: Theme.of(context).textTheme.displayLarge,
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}

/*class CustomCollapsibleItem extends CollapsibleItem {
  final String text;
  final Icon icon;
  final VoidCallback onPressed;
  final VoidCallback onHold;
  final bool isSelected;
  final List<CollapsibleItem>? subItems;

  CustomCollapsibleItem({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.onHold,
    this.isSelected = false,
    this.subItems,
  });

  @override
  CollapsibleItem build(BuildContext context) {
    return CollapsibleItem(
      text: text,
      icon: icon,
      onPressed: onPressed,
      onHold: onHold,
      isSelected: isSelected,
      subItems: subItems,
    );
  }*/

/*CustomCollapsibleItem({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required VoidCallback onHold,
    bool isSelected = false,
    List<CollapsibleItem>? subItems,
  }) : super(
          text: text,
          icon: icon,
          onPressed: onPressed,
          onHold: onHold,
          isSelected: isSelected,
          subItems: subItems,
        );*/
