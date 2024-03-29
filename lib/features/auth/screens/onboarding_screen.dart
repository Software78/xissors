import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:story_view/story_view.dart';
import 'package:xissors/core/navigation/navigator.dart';
import 'package:xissors/core/theme/primary_theme.dart';
import 'package:xissors/features/auth/screens/login_screen.dart';

const loginButtonKey = ValueKey('loginButton');

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late List<StoryItem> items;
  late StoryController storyController;
  late List<String> storyText;
  late int index = 0;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    storyController = StoryController();
    items = List.generate(
      3,
      (index) => StoryItem(
        Image.asset(
          'assets/images/tile_${index + 1}.png',
          // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
          //     FadeTransition(opacity: animationController, child: child),
          // color: context.theme.scaffoldBackgroundColor,
          width: double.infinity,
          height: double.infinity,
        ),
        duration: const Duration(seconds: 5),
      ),
    );
    storyText = [
      'Save money & get up to 40% commission on selling products',
      'Make more money by growing your business',
      'Send commisions & tips directly to your bank account',
    ];
    storyController.playbackNotifier.listen((value) {
      setState(() {
        if (index != 2) {
          index++;
        } else {
          index = 0;
        }
      });
      animationController.reset();
      animationController.forward();
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    storyController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void login() {
    context.navigator.go(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IgnorePointer(
            child: StoryView(
              storyItems: items,
              controller: storyController,
              repeat: true,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/scissors.svg'),
                  const Spacer(
                    flex: 6,
                  ),
                  FadeTransition(
                    opacity: animationController,
                    child: Text(
                      storyText[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FontFamily.inter.value,
                        fontSize: 30.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).flexible(flex: 2),
                  const Spacer(),
                  ElevatedButton(
                    key: loginButtonKey,
                    onPressed: login,
                    child: const Text('Log In'),
                  ).flexible(),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffE3EDFF)),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        color: Color(0xff3478F6),
                      ),
                    ),
                  ).flexible(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
