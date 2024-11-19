import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolioo/mobile/ms_7_contact.dart';

import 'package:rive/rive.dart';

import 'desktop/ds_1_header.dart';
import 'desktop/ds_2_about_me.dart';
import 'desktop/ds_4_experience.dart';
import 'desktop/ds_7_contact.dart';
import 'desktop/ds_8_footer.dart';
import 'mobile/ms_1_header.dart';
import 'mobile/ms_2_about_me.dart';
import 'mobile/ms_4_experience.dart';
import 'mobile/ms_8_footer.dart';
import 'theme/app_theme.dart';
import 'theme/responsive_screen_provider.dart';
import 'widgets/nav_bar.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
await
Firebase.initializeApp(
  options: const FirebaseOptions(
  apiKey: "AIzaSyB8LFhbEjynC6vA7iANtXWoPP3NjBag2tQ",
  authDomain: "portfolio-3e05e.firebaseapp.com",
  projectId: "portfolio-3e05e",
  storageBucket: "portfolio-3e05e.firebasestorage.app",
  messagingSenderId: "316098728235",
  appId: "1:316098728235:web:3fbd05de61f94927c1756e",
  measurementId: "G-7VX1R1127K"

  )
);
}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Muhammad Irshad Cholakkal",
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.darkTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showBackToTopButton = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(
        () {
          setState(
            () {
              if (_scrollController.offset >= 300) {
                _showBackToTopButton = true;
              } else {
                _showBackToTopButton = false;
              }
            },
          );
        },
      );

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    Widget desktopUI() {
      return ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: const [
          DS1Header(),
          DS2AboutMe(),
          DS4Experience(),
          // DS3Projects(),
          DS7Contact(),
          DS8Footer(),
        ],
      );
    }

    Widget mobileUI() {
      return ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: const [
          MS1Header(),
          MS2AboutMe(),
          MS4Experience(),
          // MS3Projects(),
          MS7Contact(),
          MS8Footer(),
        ],
      );
    }

    return Scaffold(
      appBar: ResponsiveScreenProvider.isDesktopScreen(context)
          ? null
          : AppBar(elevation: 0.0),
      drawer: ResponsiveScreenProvider.isDesktopScreen(context)
          ? null
          : NavBar().mobileNavBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Container(
          // color: AppThemeData.backgroundGrey,
          color: Colors.transparent,
          child: Stack(
            children: [
              const Positioned.fill(
                  child: RiveAnimation.asset(
                'assets/images/cosmos.riv',
                fit: BoxFit.cover,
              )),
              ResponsiveScreenProvider.isDesktopScreen(context)
                  ? desktopUI()
                  : mobileUI(),
            ],
          ),
        ),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              tooltip: 'Go to top',
              backgroundColor: AppThemeData.buttonPrimary,
              foregroundColor: AppThemeData.iconSecondary,
              child: const Icon(
                Icons.arrow_upward_rounded,
              ),
            ),
    );
  }
}
