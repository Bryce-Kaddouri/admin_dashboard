import 'package:admin_dashboard/src/core/share_component/side_bar_widget.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_add_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_list_screen.dart';
import 'package:admin_dashboard/src/feature/category/presentation/screen/category_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController(initialPage: 0);
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
            controller: pageController,
            children: [
              Container(
                child: Center(
                  child: Text('Home'),
                ),
              ),
              CategoryScreen(),
              CategoryListScreen(),
              CategoryAddScreen(),
              Container(
                child: Center(
                  child: Text('Products'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Product List'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Add Product'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Employees'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Employee List'),
                ),
              ),
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
