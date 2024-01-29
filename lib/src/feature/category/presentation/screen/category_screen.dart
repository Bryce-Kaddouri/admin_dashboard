import 'package:flutter/material.dart';

import '../../../../core/share_component/custom_side_bar.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  bool isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Row(
        children: [
          SideBarCustomWidget(
            sideBarIsCollapsed: isCollapsed,
            selectedIndex: 1,
          ),
        ],
      ),
    ));
  }
}
