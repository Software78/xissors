import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:xissors/core/navigation/navigator.dart';
import 'package:xissors/core/theme/primary_theme.dart';
import 'package:xissors/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:xissors/features/products/screens/product_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController, _passwordController;
  late GlobalKey<FormState> _formKey;
  late bool obscureText;
  @override
  void initState() {
    super.initState();
    obscureText = true;
    _emailController = TextEditingController(text: 'user1@gmail.com');
    _passwordController = TextEditingController(text: '001122');
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void attemptLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthLoginEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  void login() {
    context.navigator.pushReplacement(ProductScreen.routeName);
  }

  void toggleVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.loaderOverlay.hide();
            if (state.isSuccess) {
              login();
            } else {
              Fluttertoast.showToast(msg: state.message);
            }
          }
          if (state is AuthFailure) {
            context.loaderOverlay.hide();
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is AuthLoading) {
            context.loaderOverlay.show();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: REdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.googleSans.value,
                          color: const Color(0xff3478F6),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'Log In',
                    style: TextStyle(
                      fontFamily: FontFamily.roobert.value,
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Make sure your information is accurate',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xff757E86),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  TextFormField(
                    controller: _emailController,
                    autofocus: true,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: ValidationBuilder().email().build(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(' '),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        splashRadius: 1,
                        onPressed: toggleVisibility,
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: ValidationBuilder().required().build(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(' '),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        text: 'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: FontFamily.googleSans.value,
                          color: const Color(0xff3478F6),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: attemptLogin,
                    child: const Text("Continue"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
