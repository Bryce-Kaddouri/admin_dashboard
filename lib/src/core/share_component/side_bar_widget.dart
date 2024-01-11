import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Widget body;
  final PageController pageController;

  SideBarWidget(
      {required this.selectedIndex,
      required this.body,
      required this.pageController});

  static List lstPages = [
    {
      'name': 'Home',
      'index': 0,
      'children': [],
      'icon': const Icon(Icons.home)
    },
    {
      'name': 'Categories',
      'index': 1,
      'children': [
        {
          'name': 'Category List',
          'index': 2,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10)
        },
        {
          'name': 'Add Category',
          'index': 3,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10)
        }
      ],
      'icon': const Icon(Icons.category)
    },
    {
      'name': 'Products',
      'index': 4,
      'children': [
        {
          'name': 'Product List',
          'index': 5,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10)
        },
        {
          'name': 'Add Product',
          'index': 6,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10)
        },
      ],
      'icon': const Icon(Icons.cake_rounded)
    },
    {
      'name': 'Users',
      'index': 7,
      'children': [
        {
          'name': 'User List',
          'index': 8,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10)
        },
        {
          'name': 'Add User',
          'index': 9,
          'icon': const Icon(Icons.fiber_manual_record,
              color: Colors.blue, size: 10)
        },
      ],
      'icon': const Icon(Icons.group)
    },
    {
      'name': 'Settings',
      'index': 10,
      'children': [],
      'icon': const Icon(Icons.settings)
    },
    {
      'name': 'Logout',
      'index': 11,
      'children': [],
      'icon': const Icon(Icons.logout)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CollapsibleSidebar(
      isCollapsed: MediaQuery.of(context).size.width <= 800,
      items: List.generate(lstPages.length, (index) {
        return CollapsibleItem(
          text: lstPages[index]['name'],
          icon: lstPages[index]['icon'],
          onPressed: () => pageController.jumpToPage(lstPages[index]['index']),
          isSelected: selectedIndex == lstPages[index]['index'],
          subItems: lstPages[index]['children'].isEmpty
              ? null
              : List.generate(lstPages[index]['children'].length, (i) {
                  return CollapsibleItem(
                    text: lstPages[index]['children'][i]['name'],
                    icon: lstPages[index]['children'][i]['icon'],
                    onPressed: () => pageController
                        .jumpToPage(lstPages[index]['children'][i]['index']),
                    isSelected: selectedIndex ==
                        lstPages[index]['children'][i]['index'],
                  );
                }),
        );
      }),
      collapseOnBodyTap: true,
      avatarImg:
          NetworkImage("https://cdn-icons-png.flaticon.com/512/330/330703.png"),
      title: 'John Smith',
      onTitleTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Yay! Flutter Collapsible Sidebar!')));
      },
      body: body,
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
    );
  }
}
