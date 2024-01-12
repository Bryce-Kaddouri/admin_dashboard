import 'package:admin_dashboard/src/feature/category/data/datasource/category_datasource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/category_model.dart';
import '../category_provider/category_provider.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: CategoryDataSource().getCategoryByIdStream(),
        builder: (context, snapshot) {
          print('snapshot: ${snapshot.connectionState}');
          print('snapshot: ${snapshot.data}');
          if (snapshot.hasData) {
            print(snapshot.data);
            final categories = snapshot.data;
            return ListView.builder(
              itemCount: categories?.length,
              itemBuilder: (context, index) {
                final category = CategoryModel.fromJson(categories![index]);
                return ListTile(
                  title: Text(category?.name ?? ''),
                  subtitle: Text(category?.description ?? ''),
                  trailing: IconButton(
                    onPressed: () {
                      /*context
                          .read<CategoryProvider>()
                          .deleteCategory(category?.id ?? '');*/
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
