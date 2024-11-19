import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../statics/data_values.dart';
import '../theme/app_theme.dart';
import '../widgets/social_profiles.dart';

class MS1Header extends StatefulWidget {
  const MS1Header({Key? key}) : super(key: key);

  @override
  State<MS1Header> createState() => _MS1HeaderState();
}

class _MS1HeaderState extends State<MS1Header> {
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

  List<Widget> headerData() {
    return [
      
      Column(
        children: [
          SelectableText(
            DataValues.headerGreetings,
            style: AppThemeData.darkTheme.textTheme.headlineSmall,
          ),
          SelectableText(
      
            
            DataValues.headerName,
            maxLines: 4,
            style: AppThemeData.darkTheme.textTheme.headlineSmall?.copyWith(
              color: Colors.white
            ),

            textAlign: TextAlign.center,
          ),
          SelectableText(
            DataValues.headerTitle,
            style: AppThemeData.darkTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 20.0),
          const SocialProfiles(),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppThemeData.backgroundBlack,
      width: double.infinity,
      height: MediaQuery.of(context).size.height, 
      child: Stack(
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

              Positioned.fill(
                child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 3),
                      
                  // Header Data
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/Remove background project.png'),
                  ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: headerData(),
                    // ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 60.0,
                      runSpacing: 20.0,
                      children: headerData(),
                    ),
                    Spacer(),
                  ],
                )),
              ),
            ],
      ),
    );
  }
}
