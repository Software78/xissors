import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
      body: Column(
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
                  title: Text('SUBTOTAL'),
                  trailing: Text('₦0.00'),
                  visualDensity: VisualDensity(vertical: -2),
                ),
                const ListTile(
                  title: Text('SUBTOTAL'),
                  trailing: Text('₦0.00'),
                  visualDensity: VisualDensity(vertical: -2),
                ),
                ListTile(
                  title: const Text('SUBTOTAL'),
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
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final products = state.products;
                return ListView.builder(
                  itemBuilder: (context, index) =>  CartProductWidget(
                    product: products.keys.elementAt(index),
                    quantity: products.values.elementAt(index),
                  ),
                  itemCount: products.length,
                );
              },
            ),
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
    return const FlutterLogo();
  }
}
