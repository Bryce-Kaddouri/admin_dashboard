import 'dart:typed_data';

import 'package:admin_dashboard/src/feature/category/business/param/category_add_param.dart';
import 'package:admin_dashboard/src/feature/category/data/model/category_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data/exception/failure.dart';

class CategoryDataSource {
  final _client = Supabase.instance.client;

  Future<Either<DatabaseFailure, CategoryModel>> addCategory(
      CategoryAddParam params) async {
    try {
      List<Map<String, dynamic>> response =
      await _client.from('categories').insert(params.toJson()).select();
      print(response);
      if (response.isNotEmpty) {
        print('response is not empty');
        CategoryModel categoryModel = CategoryModel.fromJson(response[0]);
        print(categoryModel.toJson());
        return Right(categoryModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error adding category'));
      }
    } on PostgrestException catch (error) {
      print('postgrest error');
      print(error);
      return Left(DatabaseFailure(errorMessage: 'Error adding category'));
    } catch (e) {
      print(e);
      return Left(DatabaseFailure(errorMessage: 'Error adding category'));
    }
  }

  Future<Either<DatabaseFailure, List<CategoryModel>>> getCategories() async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .select()
          .order('id', ascending: true);
      if (response.isNotEmpty) {
        List<CategoryModel> categoryList =
        response.map((e) => CategoryModel.fromJson(e)).toList();
        return Right(categoryList);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting categories'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error getting categories'));
    }
  }

  Future<Either<DatabaseFailure, CategoryModel>> getCategoryById(int id) async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .select()
          .eq('id', id)
          .limit(1)
          .order('id', ascending: true);
      if (response.isNotEmpty) {
        CategoryModel categoryModel = CategoryModel.fromJson(response[0]);
        return Right(categoryModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error getting category'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error getting category'));
    }
  }

  Stream<List<Map<String, dynamic>>> getCategoryByIdStream() {
    return _client.from('categories').stream(primaryKey: ['id']);
  }

  Future<Either<DatabaseFailure, CategoryModel>> updateCategory(
      CategoryModel categoryModel) async {
    try {
      categoryModel = categoryModel.copyWith(updatedAt: DateTime.now());
      List<Map<String, dynamic>> response = await _client
          .from('categories')
          .update(categoryModel.toJson())
          .eq('id', categoryModel.id)
          .limit(1)
          .order('id', ascending: true)
          .select();
      if (response.isNotEmpty) {
        CategoryModel categoryModel = CategoryModel.fromJson(response[0]);
        return Right(categoryModel);
      } else {
        return Left(DatabaseFailure(errorMessage: 'Error updating category'));
      }
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error updating category'));
    }
  }

  Future<Either<StorageFailure, String>> uploadImage(Uint8List bytes) async {
    try {
      DateTime now = DateTime.now();
      final response = await _client.storage.from('categories').uploadBinary(
        '$now.jpg',
        bytes,
        fileOptions: const FileOptions(
          contentType: 'image/jpg',
          upsert: true,
        ),
      );

      if (response != null) {
        String publicUrl =
        _client.storage.from('categories').getPublicUrl(response);
        return Right(publicUrl);
      } else {
        return Left(StorageFailure(errorMessage: 'Error uploading image'));
      }
    } on StorageException catch (error) {
      print('storage error');
      print(error);
      return Left(StorageFailure(errorMessage: 'Error uploading image'));
    } catch (e) {
      return Left(StorageFailure(errorMessage: 'Error uploading image'));
    }
  }
}
