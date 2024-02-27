import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xissors/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:xissors/features/auth/data/respository/auth_repository.dart';
import 'package:xissors/features/auth/screens/login_screen.dart';
import 'package:xissors/features/auth/screens/onboarding_screen.dart';
import 'package:xissors/features/products/bloc/categories/categories_bloc.dart';
import 'package:xissors/features/products/bloc/product/product_bloc.dart';
import 'package:xissors/features/products/data/repository/product_repo.dart';
import 'package:xissors/features/products/screens/product_screen.dart';

import 'mock_data.dart';

List<MediaQueryData> testScreenSizes = const [
  MediaQueryData(size: Size(360, 800)), //Android Large
  MediaQueryData(size: Size(360, 640)), //Android Small
  MediaQueryData(size: Size(375, 667)), //iPhone 8
  MediaQueryData(size: Size(414, 736)), //iPhone 8 Plus
  MediaQueryData(size: Size(320, 568)), //iPhone SE
  MediaQueryData(size: Size(375, 812)), //iPhone 13 mini
  MediaQueryData(size: Size(390, 844)), //Iphone 14
  MediaQueryData(size: Size(393, 852)), //iPhone 14
  MediaQueryData(size: Size(430, 932)), //iPhone 14 Pro Max
  MediaQueryData(size: Size(428, 926)), //Iphone 14 plus
  MediaQueryData(size: Size(744, 1133)), //Ipad mini 8.3"
  MediaQueryData(size: Size(1440, 960)), //Surface Pro 8
  MediaQueryData(size: Size(834, 1194)), //Ipad Pro 11"
  MediaQueryData(size: Size(1024, 1366)), //Ipad Pro 12.9"
];

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockAppInitializer.init();
  final authRepo = MockAppInitializer.instanceLocator.get<AuthRepository>();
  final productRepo =
      MockAppInitializer.instanceLocator.get<ProductRepository>();
  testWidgets(
    'onboarding screen responsiveness test',
    (widgetTester) async {
      for (var size in testScreenSizes) {
        await widgetTester.pumpWidget(
          MaterialApp(
            home: ScreenUtilInit(
              designSize: size.size,
              child: const OnboardingScreen(),
            ),
          ),
        );
      }
    },
  );
  testWidgets(
    'login screen responsiveness test',
    (widgetTester) async {
      for (var size in testScreenSizes) {
        await widgetTester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthBloc(authRepo),
              ),
              BlocProvider(
                create: (context) => ProductBloc(productRepo),
              ),
              BlocProvider(
                create: (context) => CategoriesBloc(productRepo),
              ),
            ],
            child: MaterialApp(
              home: ScreenUtilInit(
                designSize: size.size,
                child: const LoginScreen(),
              ),
            ),
          ),
        );
      }
    },
  );

  testWidgets(
    'product screen responsiveness test',
    (widgetTester) async {
      for (var size in testScreenSizes) {
        await widgetTester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthBloc(authRepo),
              ),
              BlocProvider(
                create: (context) =>
                    ProductBloc(productRepo)..add(ProductLoadEvent()),
              ),
              BlocProvider(
                create: (context) =>
                    CategoriesBloc(productRepo)..add(CategoriesLoadEvent()),
              ),
            ],
            child: MaterialApp(
              home: ScreenUtilInit(
                designSize: size.size,
                child: const ProductScreen(),
              ),
            ),
          ),
        );
      }
    },
  );
}
