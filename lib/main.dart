import 'package:admin_dashboard/src/core/constant/route.dart';
import 'package:admin_dashboard/src/feature/auth/business/repository/auth_repository.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_get_user_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_is_looged_in_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_login_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_logout_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/auth_on_auth_change_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/data/datasource/auth_datasource.dart';
import 'package:admin_dashboard/src/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:admin_dashboard/src/feature/auth/presentation/screen/signin_screen.dart';
import 'package:admin_dashboard/src/feature/category/business/repository/category_repository.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_add_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_get_categories_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_get_category_by_id_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_update_usecase.dart';
import 'package:admin_dashboard/src/feature/category/business/usecase/category_upload_image_usecase.dart';
import 'package:admin_dashboard/src/feature/category/data/datasource/category_datasource.dart';
import 'package:admin_dashboard/src/feature/category/data/repository/category_repository_impl.dart';
import 'package:admin_dashboard/src/feature/category/presentation/category_provider/category_provider.dart';
import 'package:admin_dashboard/src/feature/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/default_route.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qlhzemdpzbonyqdecfxn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsaHplbWRwemJvbnlxZGVjZnhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4ODY4MDYsImV4cCI6MjAyMDQ2MjgwNn0.lcUJMI3dvMDT7LaO7MiudIkdxAZOZwF_hNtkQtF3OC8',
  );

  final supabaseAdmin = SupabaseClient(
      'https://qlhzemdpzbonyqdecfxn.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsaHplbWRwemJvbnlxZGVjZnhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4ODY4MDYsImV4cCI6MjAyMDQ2MjgwNn0.lcUJMI3dvMDT7LaO7MiudIkdxAZOZwF_hNtkQtF3OC8');
  final supabaseClient = Supabase.instance;
  AuthRepository authRepository =
      AuthRepositoryImpl(dataSource: AuthDataSource());
  CategoryRepository categoryRepository =
      CategoryRepositoryImpl(dataSource: CategoryDataSource());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            authLoginUseCase: AuthLoginUseCase(authRepository: authRepository),
            authLogoutUseCase:
                AuthLogoutUseCase(authRepository: authRepository),
            authGetUserUseCase:
                AuthGetUserUseCase(authRepository: authRepository),
            authIsLoggedInUseCase:
                AuthIsLoggedInUseCase(authRepository: authRepository),
            authOnAuthChangeUseCase:
                AuthOnAuthOnAuthChangeUseCase(authRepository: authRepository),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(
            categoryAddUseCase:
                CategoryAddUseCase(categoryRepository: categoryRepository),
            categoryGetCategoriesUseCase: CategoryGetCategoriesUseCase(
                categoryRepository: categoryRepository),
            categoryGetCategoryByIdUseCase: CategoryGetCategoryByIdUseCase(
                categoryRepository: categoryRepository),
            categoryUpdateCategoryUseCase:
                CategoryUpdateUseCase(categoryRepository: categoryRepository),
            categoryUploadImageUseCase: CategoryUploadImageUseCase(
                categoryRepository: categoryRepository),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routingCallback: (routing) {
        print('route: ${routing?.current}');

        if (routing?.current == '/login') {
          if (context.read<AuthProvider>().checkIsLoggedIn()) {
            routing?.current = '/home';
          }
        } else {
          if (!context.read<AuthProvider>().checkIsLoggedIn()) {
            routing?.current = '/login';
          }
        }
      },
      getPages: Routes().getPages,
      initialRoute: '/login',
      home: StreamBuilder<AuthState>(
        stream: context.read<AuthProvider>().onAuthStateChange(),
        builder: (context, snapshot) {
          print('snapshot: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return SignInScreen();
            } else {
              return const HomeScreen();
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
