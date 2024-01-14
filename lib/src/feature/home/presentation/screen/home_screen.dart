import 'package:admin_dashboard/src/core/share_component/side_bar_widget.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_add_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_list_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_screen.dart';
import 'package:admin_dashboard/src/feature/product/presentation/screen/product_screen.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController(initialPage: 0);
  int idCategory = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SideBarWidget(
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
              Container(
                child: Center(
                  child: Text('Add Employee'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Settings'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
