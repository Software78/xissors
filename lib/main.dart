import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xissors/config/initializer.dart';
import 'package:xissors/core/navigation/router.dart';
import 'package:xissors/features/products/bloc/product/product_bloc.dart';

import 'features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'features/products/bloc/categories/categories_bloc.dart';

void main() {
  AppInitializer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Flutter Demo',
      ),
    );
  }
}
