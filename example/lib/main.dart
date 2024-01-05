import 'package:flutter/material.dart';
import 'package:sliver_app_bar_builder_example/stories/multiline_to_oneline_story.dart';
import 'package:sliver_app_bar_builder_example/stories/play_with_parameters_story.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const StorybookApp());
}

// ignore: prefer-match-file-name, ok for example
class StorybookApp extends StatelessWidget {
  const StorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(
      plugins: initializePlugins(
        initialDeviceFrameData: (
          device: Devices.ios.iPhone13ProMax,
          isFrameVisible: true,
          orientation: Orientation.portrait,
        ),
      ),
      wrapperBuilder: (context, child) => MaterialApp(
        navigatorKey: GlobalKey(),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: child)),
      ),
      initialStory: 'Default',
      stories: [
        Story(
          name: 'Default',
          builder: (context) => const PlayWithParametersStory(),
        ),
        Story(
          name: 'Multiline to one line',
          builder: (context) => const MultilineToOneLineStory(),
        ),
      ],
    );
  }
}
