import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:xissors/config/initializer.dart';
import 'package:xissors/core/navigation/router.dart';
import 'package:xissors/core/theme/primary_theme.dart';
import 'package:xissors/features/products/bloc/product/product_bloc.dart';

import 'features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'features/auth/data/respository/auth_repository.dart';
import 'features/products/bloc/categories/categories_bloc.dart';
import 'features/products/data/repository/product_repo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppInitializer.init();

  runApp(const XissorsApp());
}

class XissorsApp extends StatelessWidget {
  const XissorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = AppInitializer.instanceLocator.get<AuthRepository>();
    final productRepo = AppInitializer.instanceLocator.get<ProductRepository>();
    return MultiBlocProvider(
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
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(375, 812),
        builder: (context, child) => GlobalLoaderOverlay(
          overlayColor: Colors.white.withOpacity(0.5),
          overlayOpacity: 0.2,
          useDefaultLoading: false,
          overlayWholeScreen: true,
          overlayWidget: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: const Center(
              child: SpinKitHourGlass(color: Color(0xff3478F6)),
            ),
          ),
          child: MaterialApp.router(
            routerConfig: router,
            title: 'Flutter Demo',
            theme: primaryTheme,
          ),
        ),
      ),
    );
  }
}
