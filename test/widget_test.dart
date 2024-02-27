// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xissors/core/navigation/router.dart';
import 'package:xissors/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:xissors/features/auth/data/respository/auth_repository.dart';
import 'package:xissors/features/products/bloc/categories/categories_bloc.dart';
import 'package:xissors/features/products/bloc/product/product_bloc.dart';
import 'package:xissors/features/products/data/repository/product_repo.dart';

import 'mock_data.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockAppInitializer.init();
  final authRepo = MockAppInitializer.instanceLocator.get<AuthRepository>();
  final productRepo =
      MockAppInitializer.instanceLocator.get<ProductRepository>();
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepo),
          ),
          BlocProvider(
            create: (context) => ProductBloc(productRepo) ,
          ),
          BlocProvider(
            create: (context) => CategoriesBloc(productRepo),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => MaterialApp.router(
            routerConfig: router,
          ),
        ),
      ),
    );
    await tester.pump();
    // Verify that our counter starts at 0.
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.text('Log In'));

    // await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    // await tester.pumpAndSettle();
    // expect(find.byType(ElevatedButton), findsOneWidget);
    // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
