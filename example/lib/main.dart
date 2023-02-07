import 'package:flutter/material.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';
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
        Story(
          name: 'tst',
          builder: (context) {
            return CustomScrollView(
              slivers: [
                SliverAppBarBuilder(
                  barHeight: 60,
                  pinned: true,
                  initialContentHeight: 150,
                  leadingActions: [
                    (context, expandRatio, barHeight, overlapsContent) {
                      return Container(
                        color: Colors.green,
                        height: barHeight,
                        child: const BackButton(),
                      );
                    }
                  ],
                  contentBuilder: (context, expandRatio, contentHeight, overlapsContent) {
                    return Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.translationValues(10 + (1 - expandRatio) * 40, 0, 0),
                      child: Text(
                        'aaa',
                        style: TextStyle(
                          fontSize: 22 + expandRatio * 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color:
                                  Color.lerp(Colors.black, Colors.transparent, 1 - expandRatio) ?? Colors.transparent,
                              blurRadius: 10,
                              offset: const Offset(4, 2),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      for (int i = 0; i < 100; i++)
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                          color: i.isEven ? Colors.blue.shade200 : Colors.black12,
                          child: Text(i.toString()),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
