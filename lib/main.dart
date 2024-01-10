import 'package:admin_dashboard/src/feature/auth/business/repository/auth_repository.dart';
import 'package:admin_dashboard/src/feature/auth/business/usecase/login_usecase.dart';
import 'package:admin_dashboard/src/feature/auth/data/datasource/auth_datasource.dart';
import 'package:admin_dashboard/src/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:admin_dashboard/src/feature/auth/presentation/provider/auth_provider.dart';
import 'package:admin_dashboard/src/feature/auth/presentation/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  final supabaseAdmin = SupabaseClient(
      'https://xbikruujrtiezljgcnvu.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhiaWtydXVqcnRpZXpsamdjbnZ1Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwNDc1NjU2MCwiZXhwIjoyMDIwMzMyNTYwfQ.qygMomgwZcWBv2vldVv--cxV1uYb4ZXhNJEhNvDqAI0');
  final supabaseClient = Supabase.instance;
  AuthRepository authRepository =
      AuthRepositoryImpl(dataSource: AuthDataSource());
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(
            create: (_) => AuthProvider(
                authLoginUseCase:
                    AuthLoginUseCase(authRepository: authRepository))),
        // Provider<BranchProvider>(create: (_) => BranchProvider()),
        // Provider<OrderProvider>(create: (_) => OrderProvider()),
        // Provider<LocationProvider>(create: (_) => LocationProvider()),
      ],
      child: GetMaterialApp(
        getPages: [
          GetPage(name: '/login', page: () => SignInScreen()),
          GetPage(name: '/home', page: () => const Placeholder()),
        ],
      ),
    );
  }
}
