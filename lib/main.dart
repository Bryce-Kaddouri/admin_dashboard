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
        // Provider<BranchProvider>(create: (_) => BranchProvider()),
        // Provider<OrderProvider>(create: (_) => OrderProvider()),
        // Provider<LocationProvider>(create: (_) => LocationProvider()),
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
      home: StreamBuilder<AuthState>(
        stream: context.read<AuthProvider>().onAuthStateChange(),
        builder: (context, snapshot) {
          print('snapshot: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return SignInScreen();
            }
            return const HomeScreen();
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
