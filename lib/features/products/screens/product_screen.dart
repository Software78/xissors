import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:xissors/core/navigation/navigator.dart';
import 'package:xissors/features/products/bloc/categories/categories_bloc.dart';
import 'package:xissors/features/products/bloc/product/product_bloc.dart';
import 'package:xissors/features/products/data/models/models.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Tab> tabs = [
    const Tab(text: 'All'),
  ];
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(CategoriesLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        leading: IconButton(
          onPressed: () => context.navigator.pop(),
          icon: SvgPicture.asset('assets/svgs/close.svg'),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: SvgPicture.asset('assets/svgs/filter.svg'),
            label: const Text('Filter'),
          ),
        ],
      ),
      body: BlocListener<CategoriesBloc, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesLoading) {
            context.loaderOverlay.show();
          }
          if (state is CategoriesFailure) {
            context.loaderOverlay.hide();
          }
          if (state is CategoriesSuccess) {
            context.loaderOverlay.hide();
            context.read<ProductBloc>().add(ProductLoadEvent());
            tabs.addAll(state.categories
                .map((e) => Tab(text: e.capitalizeFirst()))
                .toList());
            _tabController = TabController(length: tabs.length, vsync: this);
            setState(() {});
          }
        },
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScroller) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const Divider(),
                    Padding(
                      padding: REdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon:
                                  SvgPicture.asset('assets/svgs/search.svg')
                                      .paddingAll(16),
                              hintText: 'Search',
                            ),
                            // onTapOutside:
                          ),
                          SizedBox(height: 20.h),
                          tabs.length == 1
                              ? const SizedBox.shrink()
                              : TabBar(
                                  tabs: tabs,
                                  controller: _tabController,
                                ),
                          // SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ];
          },
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductFailure) {
                return const ProductLoadingState();
              }
              if (state is ProductSuccess) {
                
                return TabBarView(
                  controller: _tabController,
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 9,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductWidget(product: product);
                      },
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 9,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductWidget(product: product);
                      },
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 9,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductWidget(product: product);
                      },
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 9,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductWidget(product: product);
                      },
                    ),
                  ],
                );
              }
              return const ProductLoadingState();
            },
          ).paddingAll(20),
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 159.w,
          height: 171.h,
          child: ExtendedImage.network(
            '${product.image}',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          '${product.name}',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xffFFFFFF),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          NumberFormat.currency(symbol: '\$').format(
            int.parse('${product.price}'),
          ),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xffFFFFFF),
          ),
        ),
      ],
    );
  }
}

class ProductLoadingState extends StatelessWidget {
  const ProductLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonGridLoader(
      items: 6,
      highlightColor: const Color(0xff3478F6).withOpacity(0.5),
      baseColor: const Color(0xff3478F6).withOpacity(0.2),
      childAspectRatio: 0.7,
      builder: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 170.w,
            height: 170.h,
            color: const Color(0xff3478F6),
          ),
          const Skeletonizer(
            child: Text('BLUE Rescue Clay Skin Renew Mask Clay '),
          ),
        ],
      ),
    );
  }
}
