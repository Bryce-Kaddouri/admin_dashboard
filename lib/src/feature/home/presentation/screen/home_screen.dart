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
        text: 'Home',
        icon: const Icon(Icons.home),
        onPressed: () => setState(() => _headline = 'DashBoard'),
        onHold: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Dashboard"))),
        isSelected: true,
      ),
      CollapsibleItem(
          text: 'Categories',
          icon: Icon(Icons.category),
          onPressed: () => setState(() => _headline = 'DashBoard'),
          onHold: () => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: const Text("Dashboard"))),
          isSelected: false,
          subItems: [
            CollapsibleItem(
              text: 'Category List',
              icon: const Icon(
                Icons.fiber_manual_record,
                color: Colors.blue,
                size: 10,
              ),
              onPressed: () => setState(() => _headline = 'Menu'),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: const Text("Menu"))),
              isSelected: false,
            ),
            CollapsibleItem(
              text: 'Add Category',
              // dot icon
              icon: const Icon(
                Icons.fiber_manual_record,
                color: Colors.blue,
                size: 10,
              ),
              onPressed: () => setState(() => _headline = 'Add Category'),
              onHold: () => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: const Text("Shop"))),
              isSelected: false,
            ),
          ]),
      CollapsibleItem(
        text: 'Products',
        icon: const Icon(Icons.cake_rounded),
        onPressed: () => setState(() => _headline = 'Search'),
        onHold: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Search"),
          ),
        ),
        subItems: [
          CollapsibleItem(
            text: 'Product List',
            icon: const Icon(
              Icons.fiber_manual_record,
              color: Colors.blue,
              size: 10,
            ),
            onPressed: () => setState(() => _headline = 'Menu'),
            onHold: () => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: const Text("Menu"))),
            isSelected: false,
          ),
          CollapsibleItem(
            text: 'Add Product',
            icon: const Icon(
              Icons.fiber_manual_record,
              color: Colors.blue,
              size: 10,
            ),
            onPressed: () => setState(() => _headline = 'Add Category'),
            onHold: () => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: const Text("Shop"))),
            isSelected: false,
          ),
        ],
      ),
      CollapsibleItem(
        text: 'Users',
        icon: const Icon(Icons.group),
        onPressed: () => setState(() => _headline = 'Users'),
        onHold: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Notifications"),
          ),
        ),
        subItems: [
          CollapsibleItem(
            text: 'User List',
            icon: const Icon(
              Icons.fiber_manual_record,
              color: Colors.blue,
              size: 10,
            ),
            onPressed: () => setState(() => _headline = 'Menu'),
            onHold: () => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: const Text("Menu"))),
            isSelected: false,
          ),
          CollapsibleItem(
            text: 'Add User',
            icon: const Icon(
              Icons.fiber_manual_record,
              color: Colors.blue,
              size: 10,
            ),
            onPressed: () => setState(() => _headline = 'Add Category'),
            onHold: () => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: const Text("Shop"))),
            isSelected: false,
          ),
        ],
      ),
      CollapsibleItem(
        text: 'Settings',
        icon: const Icon(Icons.settings),
        onPressed: () => setState(() => _headline = 'Settings'),
        onHold: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Settings"),
          ),
        ),
      ),
      CollapsibleItem(
        text: 'Logout',
        icon: const Icon(Icons.logout, color: Colors.redAccent),
        onPressed: () => setState(() => _headline = 'Settings'),
        onHold: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Settings"),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: CollapsibleSidebar(
        isCollapsed: MediaQuery.of(context).size.width <= 800,
        items: _items,
        collapseOnBodyTap: true,
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
      color: Colors.red,
      child: Column(
        children: [
          Text(
            _headline,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ],
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
