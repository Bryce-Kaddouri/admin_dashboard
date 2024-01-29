import 'package:admin_dashboard/src/core/share_component/side_bar_widget.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_add_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_list_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_screen.dart';
import 'package:admin_dashboard/src/feature/product/presentation/screen/product_screen.dart';
import 'package:admin_dashboard/src/feature/user/presentation/screen/user_add_screen.dart';
import 'package:admin_dashboard/src/feature/user/presentation/screen/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../category/presentation/category_provider/category_provider.dart';
import '../../../product/presentation/screen/product_add_screen.dart';
import '../../../product/presentation/screen/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;

  PageController pageController = PageController(initialPage: 0);
  int idCategory = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            SideBarCustomWidget(
              isCollapsed: isCollapsed,
            ),
          ],
        ),
      ),
      /*SideBarWidget(
        pageController: pageController,
        selectedIndex: 0,
        body: Container(
          child: PageView(
            allowImplicitScrolling: false,
            controller: pageController,
            children: [
              Container(
                child: Center(
                  child: Text('Home'),
                ),
              ),
              CategoryScreen(),
              CategoryListScreen(
                mainPageController: pageController,
              ),
              CategoryAddScreen(pageController: pageController),
              CategoryAddScreen(pageController: pageController),
              ProductScreen(),
              ProductListScreen(
                mainPageController: pageController,
              ),
              ProductAddScreen(pageController: pageController),
              ProductAddScreen(pageController: pageController),
              Container(
                child: Center(
                  child: Text('Employees'),
                ),
              ),
              UserListScreen(mainPageController: pageController),
              UserAddScreen(pageController: pageController),
              Container(
                child: Center(
                  child: Text('Settings'),
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}

/*List lstPages = [
  {
    'name': 'Home',
    'index': 0,
    'children': [],
    'icon': const Icon(Icons.home),
    'onTap': () => print('Home'),
    'isVisibled': true,
  },
  {
    'name': 'Categories',
    'index': 1,
    'children': [
      {
        'name': 'Category List',
        'index': 2,
        'icon': const Icon(Icons.fiber_manual_record,
            color: Colors.blue, size: 10),
        'onTap': () => print('Category List'),
        'isVisibled': true,
      },
      {
        'name': 'Add Category',
        'index': 3,
        'icon': const Icon(Icons.fiber_manual_record,
            color: Colors.blue, size: 10),
        'onTap': () => print('Add Category'),
        'isVisibled': true,
      },
      {
        'name': 'Update Category',
        'index': 4,
        'icon': const Icon(Icons.fiber_manual_record,
            color: Colors.blue, size: 10),
        'onTap': () => print('Add Category'),
        'isVisibled': false,
      }
    ],
    'icon': const Icon(Icons.category),
    'onTap': () => print('Categories'),
    'isVisibled': true,
  },
  {
    'name': 'Products',
    'index': 5,
    'children': [
      {
        'name': 'Product List',
        'index': 6,
        'icon': const Icon(Icons.fiber_manual_record,
            color: Colors.blue, size: 10),
        'onTap': () => print('Product List'),
        'isVisibled': true,
      },
      {
        'name': 'Add Product',
        'index': 7,
        'icon': const Icon(Icons.fiber_manual_record,
            color: Colors.blue, size: 10),
        'onTap': () =>
            Get.context!.read<ProductProvider>().setProductModel(null),
        'isVisibled': true,
      },
    ],
    'icon': const Icon(Icons.cake_rounded),
    'onTap': () => print('Products'),
    'isVisibled': true,
  },
  {
    'name': 'Users',
    'index': 9,
    'children': [
      {
        'name': 'User List',
        'index': 10,
        'icon': const Icon(Icons.fiber_manual_record,
            color: Colors.blue, size: 10),
        'onTap': () => print('User List'),
        'isVisibled': true,
      },
      {
        'name': 'Add User',
        'index': 11,
        'icon': const Icon(Icons.fiber_manual_record,
            color: Colors.blue, size: 10),
        'onTap': () => print('Add User'),
        'isVisibled': true,
      },
    ],
    'icon': const Icon(Icons.group),
    'onTap': () => print('Users'),
    'isVisibled': true,
  },
  {
    'name': 'Settings',
    'index': 11,
    'children': [],
    'icon': const Icon(Icons.settings),
    'onTap': () => print('Settings'),
    'isVisibled': true,
  },
  {
    'name': 'Logout',
    'index': 12,
    'children': [],
    'icon': const Icon(Icons.logout),
    'onTap': () => print('Logout'),
    'isVisibled': true,
  },
];*/

class SideBarCustomWidget extends StatefulWidget {
  bool isCollapsed;
  SideBarCustomWidget({super.key, required this.isCollapsed});

  @override
  State<SideBarCustomWidget> createState() => _SideBarCustomWidgetState();
}

class _SideBarCustomWidgetState extends State<SideBarCustomWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          widget.isCollapsed = false;
        });
      } else if (status == AnimationStatus.reverse) {
        setState(() {
          widget.isCollapsed = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        print(_controller.value);
        return Container(
            width: 60 + _controller.value * 200,
            color: Colors.blue,
            height: MediaQuery.of(context).size.height,
            child: child!);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 3.14,
                  child: child,
                );
              },
              child: IconButton(
                onPressed: () {
                  if (widget.isCollapsed) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                ItemSideBarWidget(
                  children: [],
                  isCollapsed: widget.isCollapsed,
                  mainItemSideBarWidget: MainItemSideBarWidget(
                    mainIcon: Icon(Icons.home),
                    mainText: 'Home',
                    onTap: () {},
                  ),
                ),
                ItemSideBarWidget(
                  children: [
                    SubItemSideBarWidget(
                      subIcon: const Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 10),
                      subText: 'Category List',
                      onTap: () {},
                    ),
                    SubItemSideBarWidget(
                      subIcon: const Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 10),
                      subText: 'Add Category',
                      onTap: () {},
                    ),
                  ],
                  isCollapsed: widget.isCollapsed,
                  mainItemSideBarWidget: MainItemSideBarWidget(
                    mainIcon: Icon(Icons.category),
                    mainText: 'Categories',
                    onTap: () {},
                  ),
                ),
                ItemSideBarWidget(
                  children: [
                    SubItemSideBarWidget(
                      subIcon: const Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 10),
                      subText: 'Product List',
                      onTap: () {},
                    ),
                    SubItemSideBarWidget(
                      subIcon: const Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 10),
                      subText: 'Add Product',
                      onTap: () {},
                    ),
                  ],
                  isCollapsed: widget.isCollapsed,
                  mainItemSideBarWidget: MainItemSideBarWidget(
                    mainIcon: Icon(Icons.cake_rounded),
                    mainText: 'Products',
                    onTap: () {},
                  ),
                ),
                ItemSideBarWidget(
                  children: [
                    SubItemSideBarWidget(
                      subIcon: const Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 10),
                      subText: 'Order List',
                      onTap: () {},
                    ),
                  ],
                  isCollapsed: widget.isCollapsed,
                  mainItemSideBarWidget: MainItemSideBarWidget(
                    mainIcon: Icon(Icons.shopping_cart_outlined),
                    mainText: 'Orders',
                    onTap: () {},
                  ),
                ),
                ItemSideBarWidget(
                  children: [
                    SubItemSideBarWidget(
                      subIcon: const Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 10),
                      subText: 'User List',
                      onTap: () {},
                    ),
                    SubItemSideBarWidget(
                      subIcon: const Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 10),
                      subText: 'Add User',
                      onTap: () {},
                    ),
                  ],
                  isCollapsed: widget.isCollapsed,
                  mainItemSideBarWidget: MainItemSideBarWidget(
                    mainIcon: Icon(Icons.group),
                    mainText: 'Users',
                    onTap: () {},
                  ),
                ),
                ItemSideBarWidget(
                  children: [
                    SubItemSideBarWidget(
                      subIcon: const Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 10),
                      subText: 'Page List',
                      onTap: () {},
                    ),
                    SubItemSideBarWidget(
                      subIcon: const Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 10),
                      subText: 'Add Page',
                      onTap: () {},
                    ),
                  ],
                  isCollapsed: widget.isCollapsed,
                  mainItemSideBarWidget: MainItemSideBarWidget(
                    mainIcon: Icon(Icons.chrome_reader_mode_rounded),
                    mainText: 'Book',
                    onTap: () {},
                  ),
                ),
                ItemSideBarWidget(
                  children: [],
                  isCollapsed: widget.isCollapsed,
                  mainItemSideBarWidget: MainItemSideBarWidget(
                    mainIcon: Icon(Icons.settings),
                    mainText: 'Settings',
                    onTap: () {},
                  ),
                ),
                ItemSideBarWidget(
                  children: [],
                  isCollapsed: widget.isCollapsed,
                  mainItemSideBarWidget: MainItemSideBarWidget(
                    mainIcon: Icon(Icons.logout),
                    mainText: 'Logout',
                    onTap: () {},
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class ItemSideBarWidget extends StatefulWidget {
  bool isCollapsed;
  MainItemSideBarWidget mainItemSideBarWidget;
  List<SubItemSideBarWidget> children;
  ItemSideBarWidget(
      {super.key,
      required this.children,
      required this.isCollapsed,
      required this.mainItemSideBarWidget});

  @override
  State<ItemSideBarWidget> createState() => _ItemSideBarWidgetState();
}

class _ItemSideBarWidgetState extends State<ItemSideBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool childrenAreCollapsed = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      duration: Duration(milliseconds: 500),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: widget.isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                widget.mainItemSideBarWidget.mainIcon,
                if (!widget.isCollapsed)
                  Text(widget.mainItemSideBarWidget.mainText),
                if (!widget.isCollapsed && widget.children.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      if (childrenAreCollapsed) {
                        _controller.forward();
                      } else {
                        _controller.reverse();
                      }
                      setState(() {
                        childrenAreCollapsed = !childrenAreCollapsed;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                    ),
                  ),
              ],
            ),
          ),
          if (!childrenAreCollapsed)
            Column(
              children: List.generate(
                widget.children.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: index == widget.children.length - 1
                        ? null
                        : Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.children[index].subIcon,
                      Text(widget.children[index].subText),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MainItemSideBarWidget {
  Icon mainIcon;
  String mainText;
  Function() onTap;
  MainItemSideBarWidget(
      {required this.mainIcon, required this.mainText, required this.onTap});
}

class SubItemSideBarWidget {
  Icon subIcon;
  String subText;
  Function() onTap;
  SubItemSideBarWidget(
      {required this.subIcon, required this.subText, required this.onTap});
}
