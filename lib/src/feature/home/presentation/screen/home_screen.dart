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
          isCollapsed = false;
        });
      } else if (status == AnimationStatus.reverse) {
        setState(() {
          isCollapsed = true;
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
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            AnimatedBuilder(
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
                          if (isCollapsed) {
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
                    ItemSideBarWidget(
                      children: [
                        SubItemSideBarWidget(
                          subIcon: Icon(Icons.add),
                          subText: 'Add',
                        ),
                        SubItemSideBarWidget(
                          subIcon: Icon(Icons.list),
                          subText: 'List',
                        ),
                      ],
                      isCollapsed: isCollapsed,
                      mainItemSideBarWidget: MainItemSideBarWidget(
                        mainIcon: Icon(Icons.home),
                        mainText: 'Home',
                      ),
                    )
                  ],
                ),
              ),
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
  MainItemSideBarWidget({required this.mainIcon, required this.mainText});
}

class SubItemSideBarWidget {
  Icon subIcon;
  String subText;
  SubItemSideBarWidget({required this.subIcon, required this.subText});
}
