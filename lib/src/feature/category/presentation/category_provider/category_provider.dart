import 'package:admin_dashboard/src/feature/category/business/usecase/category_add_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_get_categories_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_update_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/data/usecase/usecase.dart';
import '../../business/param/category_add_param.dart';
import '../../business/usecase/category_get_category_by_id_usecase.dart';
import '../../business/usecase/category_upload_image_usecase.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryAddUseCase categoryAddUseCase;
  final CategoryGetCategoriesUseCase categoryGetCategoriesUseCase;
  final CategoryGetCategoryByIdUseCase categoryGetCategoryByIdUseCase;
  final CategoryUpdateUseCase categoryUpdateCategoryUseCase;
  final CategoryUploadImageUseCase categoryUploadImageUseCase;

  CategoryProvider({
    required this.categoryAddUseCase,
    required this.categoryGetCategoriesUseCase,
    required this.categoryGetCategoryByIdUseCase,
    required this.categoryUpdateCategoryUseCase,
    required this.categoryUploadImageUseCase,
  });

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    ImageSource source = ImageSource.gallery;
    if (!kIsWeb) {
      Get.dialog(
        AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Camera'),
                onTap: () {
                  source = ImageSource.camera;
                  Get.back();
                },
              ),
              ListTile(
                title: Text('Gallery'),
                onTap: () {
                  source = ImageSource.gallery;
                  Get.back();
                },
              ),
            ],
          ),
        ),
      );
    }
    final XFile? image = await picker.pickImage(source: source);
    return image;
  }

  String _addCategoryErrorMessage = '';

  String get addCategoryErrorMessage => _addCategoryErrorMessage;

  void setAddCategoryErrorMessage(String value) {
    _addCategoryErrorMessage = value;
    notifyListeners();
  }

  Future<String?> uploadImage(Uint8List bytes) async {
    _isLoading = true;
    String? url;
    notifyListeners();
    final result = await categoryUploadImageUseCase.call(bytes);

    await result.fold((l) async {
      _addCategoryErrorMessage = l.errorMessage;

      url = null;
    }, (r) async {
      print(r);
      url = r;
    });

    _isLoading = false;
    notifyListeners();
    return url;
  }

  Future<bool> addCategory(
      String name, String? description, String imageUrl) async {
    _isLoading = true;
    bool isSuccess = false;
    notifyListeners();
    final result = await categoryAddUseCase.call(CategoryAddParam(
      name: name,
      description: description,
      imageUrl: imageUrl,
    ));

    await result.fold((l) async {
      _addCategoryErrorMessage = l.errorMessage;

      isSuccess = false;
    }, (r) async {
      print(r.toJson());
      isSuccess = true;
    });

    _isLoading = false;
    notifyListeners();
    return isSuccess;
  }
}