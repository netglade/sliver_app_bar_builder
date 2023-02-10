import 'package:flutter/material.dart';
import 'package:sliver_app_bar_builder_example/stories/sliver_app_bar_builder_story.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(StorybookApp());
}

// ignore: prefer-match-file-name, ok for example
class StorybookApp extends StatelessWidget {
  final _plugins = initializePlugins(
    knobsSidePanel: true,
    initialDeviceFrameData: DeviceFrameData(
      device: Devices.ios.iPhone13ProMax,
    ),
  );

  StorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(
      plugins: _plugins,
      wrapperBuilder: (context, child) => MaterialApp(
        navigatorKey: GlobalKey(),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        home: Scaffold(body: Center(child: child)),
      ),
      initialStory: 'SliverAppBarBuilder',
      stories: [
        Story(
          name: 'SliverAppBarBuilder',
          description: 'SliverAppBarBuilder demo',
          builder: (context) => const SliverAppBarBuilderStory(),
        ),
      ],
    );
  }
}
