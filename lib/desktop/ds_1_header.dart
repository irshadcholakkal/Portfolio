import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
// import 'package:rive/rive.dart' hide Image;


import '../statics/data_values.dart';
import '../theme/app_theme.dart';
import '../widgets/nav_bar.dart';
import '../widgets/social_profiles.dart';

class DS1Header extends StatefulWidget {
  const DS1Header({Key? key}) : super(key: key);

  @override
  State<DS1Header> createState() => _DS1HeaderState();
}

class _DS1HeaderState extends State<DS1Header> {
  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMITrigger? _toggleTrigger;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  void _loadRiveFile() async {
    try {
      final bytes = await RiveFile.asset('assets/images/sith_de_mayo (2).riv');
      final artboard = bytes.mainArtboard;

      var controller = StateMachineController.fromArtboard(
        artboard,
        'State Machine 1',
      );

      if (controller != null) {
        artboard.addController(controller);
        _toggleTrigger = controller.findSMI('toggle') as SMITrigger;
        debugPrint('Toggle trigger found: ${_toggleTrigger != null}');
        _controller = controller;
      }

      setState(() => _riveArtboard = artboard);
    } catch (e) {
      debugPrint('Error loading Rive file: $e');
    }
  }

  void _onTapDown(_) {
    _toggleTrigger?.fire();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppThemeData.backgroundBlack,
      color: Colors.transparent,
      width: double.infinity,
      height: MediaQuery.of(context).size.height, 
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTapDown: _onTapDown,
              child: _riveArtboard != null
                  ? Rive(
                      artboard: _riveArtboard!,
                      fit: BoxFit.cover, // Changed to cover for full screen
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),

          // Header Content Overlay
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  // Header Data
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/Remove background project.png'),
                  ),

                  // const CircleAvatar(
                  //   radius: 100,
                  //   backgroundImage: AssetImage('assets/images/Remove background project.jpeg'),
                  // ),


                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 60.0,
                    runSpacing: 20.0,
                    children: headerData(),
                  ),

                  const Spacer(), // Pushes navigation bar to bottom
NavBar().desktopNavBar(),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Header Data Section
  List<Widget> headerData() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            DataValues.headerGreetings,
            style: AppThemeData.darkTheme.textTheme.headlineSmall?.copyWith(
              // Optional: Make text more visible against the animation
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                )
              ],
            ),
          ),
          SelectableText(
            DataValues.headerName,
            style: AppThemeData.darkTheme.textTheme.displayMedium?.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                )
              ],
            ),
          ),
          SelectableText(
            DataValues.headerTitle,
            style: AppThemeData.darkTheme.textTheme.titleLarge?.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          const SocialProfiles(),
        ],
      ),
    ];
  }
}
