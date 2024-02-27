import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:xissors/core/navigation/navigator.dart';
import 'package:xissors/features/products/bloc/cart/cart_bloc.dart';
import 'package:xissors/features/products/data/models/models.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';
  const OrderScreen({super.key, required this.product});

  final Product product;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(AddProduct(widget.product));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
        leadingWidth: 60,
        leading: InkWell(
          onTap: () => context.navigator.pop(),
          child: Padding(
            padding: REdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, size: 14.sp),
                Text(
                  'Back',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: REdgeInsets.all(24),
              child: ExpansionTile(
                title: const Text(
                  'VIEW BREAKDOWN',
                ),
                initiallyExpanded: true,
                trailing: SvgPicture.asset('assets/svgs/preview.svg'),
                children: [
                  const ListTile(
                    title: Text('SUBTOTAL'),
                    trailing: Text('₦0.00'),
                    visualDensity: VisualDensity(vertical: -2),
                  ),
                  const ListTile(
                    title: Text('YOUR COMMISSION'),
                    trailing: Text('\$0.00'),
                    visualDensity: VisualDensity(vertical: -2),
                  ),
                  const ListTile(
                    title: Text('TAX (5%)'),
                    trailing: Text('\$0.00'),
                    visualDensity: VisualDensity(vertical: -2),
                  ),
                  ListTile(
                    title: const Text('TOTAL'),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    trailing: const Text('₦0.00'),
                    visualDensity: const VisualDensity(vertical: 4),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Color(0xff434D6B),
            ),
            ListTile(
              title: const Text('ADD SERVICE'),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: REdgeInsets.symmetric(horizontal: 24),
              trailing: SvgPicture.asset('assets/svgs/add.svg'),
              visualDensity: const VisualDensity(vertical: -2),
            ),
            const Divider(
              thickness: 1,
              color: Color(0xff434D6B),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PRODUCTS ( ${context.read<CartBloc>().state.products.length} )',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff888f9b),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('New Product'),
                  )
                ],
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final products = state.products;
                log(products.toString());
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: REdgeInsets.symmetric(horizontal: 24),
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Divider(
                      thickness: 1,
                      color: Color(0xff434D6B),
                    ),
                  ),
                  itemBuilder: (context, index) => CartProductWidget(
                    product: products.keys.elementAt(index),
                    quantity: products.values.elementAt(index),
                  ),
                  itemCount: products.length,
                );
              },
            ),
            const Divider(
              thickness: 1,
              color: Color(0xff434D6B),
            ),
            ListTile(
              contentPadding: REdgeInsets.symmetric(horizontal: 24),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              title: const Text('TOTAL'),
            ),
            Padding(
              padding: REdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('PROCEED TO PAYMENT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 122.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ExtendedImage.network(
            '${product.image}',
            width: 96.w,
            fit: BoxFit.cover,
            height: 121.h,
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${product.name}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                NumberFormat.currency(symbol: '\$').format(
                  int.parse('${product.price}'),
                ),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xffF8B02B),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: () =>
                        context.read<CartBloc>().add(RemoveProduct(product)),
                    child: const CircleAvatar(
                      radius: 11,
                      child: Icon(Icons.remove, size: 12),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  InkWell(
                    onTap: () =>
                        context.read<CartBloc>().add(AddProduct(product)),
                    child: const CircleAvatar(
                      radius: 11,
                      child: Icon(Icons.add, size: 12),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
