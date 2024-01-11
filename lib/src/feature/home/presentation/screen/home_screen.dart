import 'package:admin_dashboard/src/core/share_component/side_bar_widget.dart';
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
  var pagecontroller = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SideBarWidget(
        pageController: pagecontroller,
        selectedIndex: 0,
        body: Container(
          child: PageView(
            controller: pagecontroller,
            children: [
              Container(
                child: Center(
                  child: Text('Home'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Categories'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Category List'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Add Category'),
                ),
              ),
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
