import 'dart:js_interop';

import 'package:admin_dashboard/src/feature/category/data/datasource/category_datasource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../data/model/category_model.dart';
import '../category_provider/category_provider.dart';

class CategoryListScreen extends StatefulWidget {
  PageController mainPageController;
  CategoryListScreen({super.key, required this.mainPageController});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  int nbItemPerPage = 5;
  int nbPages = 0;

  @override
  void initState() {
    super.initState();
    print(pageController.hasListeners);
    pageController.addListener(() {
      print('pageController.page: ${pageController.page}');
      setState(() {
        currentPage = pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          color: Colors.red,
        ),
        Expanded(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: CategoryDataSource().getCategoryByIdStream(),
            builder: (context, snapshot) {
              print('snapshot: ${snapshot.connectionState}');
              print('snapshot: ${snapshot.data}');
              if (snapshot.hasData) {
                final categories = snapshot.data;
                if (categories == null || categories.isEmpty) {
                  return const Center(
                    child: Text('No data'),
                  );
                }
                print('categories: ${categories.length}');
                int nbItemPerPage = 5;
                int nbPages = categories.length ~/ nbItemPerPage;
                print('nbPages: $nbPages');
                if (categories.length % nbItemPerPage != 0) {
                  nbPages++;
                }
                // add post frame callback to avoid calling setState during build

                return Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemCount: nbPages,
                        itemBuilder: (context, indexPage) {
                          return ListView.builder(
                            padding: const EdgeInsets.all(10),
                            shrinkWrap: true,
                            itemCount: nbItemPerPage,
                            itemBuilder: (context, index) {
                              int correctIndex = indexPage == 0
                                  ? index
                                  : (indexPage * nbItemPerPage) + index;
                              if (correctIndex > categories.length - 1) {
                                return Container();
                              }
                              final category = CategoryModel.fromJson(
                                  categories![correctIndex]);
                              print('index: $index');
                              print('indexPage: $indexPage');
                              print(
                                  'correct index: ${indexPage == 0 ? index : (indexPage * nbItemPerPage) + index}');
                              print('-' * 50);

                              return Card(
                                child: ListTile(
                                  tileColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 100,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${category.id}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blueAccent,
                                          ),
                                          child: FutureBuilder<String?>(
                                            future: context
                                                .read<CategoryProvider>()
                                                .getSignedUrl(
                                                    category?.imageUrl ?? ''),
                                            builder: (context, snapshot) {
                                              print(
                                                  'snapshot stqte: ${snapshot.connectionState}');
                                              print(
                                                  'snapshot: ${snapshot.data}');
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                if (snapshot.hasData) {
                                                  return Image.network(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(
                                                          Icons.error,
                                                          color: Colors.white);
                                                    },
                                                  );
                                                } else {
                                                  return const Icon(Icons.error,
                                                      color: Colors.white);
                                                }
                                              } else {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(category?.name ?? ''),
                                  subtitle: Text(category?.description ?? ''),
                                  trailing: Container(
                                    height: 50,
                                    width: 120,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blueAccent,
                                          ),
                                          child: InkWell(
                                            child: Icon(Icons.edit,
                                                color: Colors.white),
                                            onTap: () {
                                              print('edit');
                                              widget.mainPageController
                                                  .jumpToPage(4);
                                              context
                                                  .read<CategoryProvider>()
                                                  .setCategoryModel(category);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.redAccent,
                                          ),
                                          child: InkWell(
                                            child: Icon(Icons.delete,
                                                color: Colors.white),
                                            onTap: () {
                                              print('delete');
                                              print(
                                                  'category id: ${category.id}');
                                              Get.defaultDialog(
                                                contentPadding:
                                                    EdgeInsets.all(20),
                                                content: Column(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .delete_forever_rounded,
                                                      color: Colors.redAccent,
                                                      size: 100,
                                                    ),
                                                    Text(
                                                        'Are you sure to delete this category? The deletion of this category will delete all products associated with it.'),
                                                  ],
                                                ),
                                                title: 'Delete category',
                                                textConfirm: 'Yes',
                                                textCancel: 'No',
                                                confirmTextColor: Colors.white,
                                                onConfirm: () async {
                                                  bool res = await context
                                                      .read<CategoryProvider>()
                                                      .deleteCategory(
                                                          category.id);
                                                  Get.back();
                                                  if (res) {
                                                    Get.snackbar(
                                                      'Success',
                                                      'Category deleted successfully',
                                                      backgroundColor:
                                                          Colors.green,
                                                      colorText: Colors.white,
                                                    );
                                                  } else {
                                                    Get.snackbar(
                                                      'Error',
                                                      'An error occured while deleting category',
                                                      backgroundColor:
                                                          Colors.red,
                                                      colorText: Colors.white,
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        controller: pageController,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: '${currentPage + 1}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              children: [
                                TextSpan(
                                  text: '/$nbPages',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
