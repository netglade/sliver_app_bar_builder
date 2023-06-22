// ignore_for_file: avoid_redundant_argument_values, no-empty-block

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class PlayWithParametersStory extends StatefulWidget {
  const PlayWithParametersStory({
    super.key,
  });

  @override
  State<PlayWithParametersStory> createState() => _PlayWithParametersStoryState();
}

class _PlayWithParametersStoryState extends State<PlayWithParametersStory> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Shader _shaderCallback(Rect rect) {
    return const LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [Colors.black, Colors.transparent],
      stops: [0.6, 1],
    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
  }

  Future<void> _onStretchCallback() {
    // ignore: avoid_print, for demo purposes
    print('ping on stretch');

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    // Bar.
    final knobBarHeight = context.knobs
        .sliderInt(
          label: 'Bar height',
          description: 'Height of bar when shrunken.',
          initial: 60,
          min: 40,
          max: 150,
        )
        .toDouble();
    final knobInitialBarHeight = context.knobs
        .sliderInt(
          label: 'Initial bar height',
          description: 'Height of bar when expanded.',
          initial: 60,
          min: 40,
          max: 150,
        )
        .toDouble();

    // Backgrounds.
    final knobBackgroundColorAll = context.knobs.options(
      label: 'Background color - all',
      description: 'Background of the whole app bar.',
      initial: Colors.blue,
      options: [
        const Option(value: Colors.transparent, label: 'Invisible'),
        const Option(value: Colors.blue, label: 'Blue'),
        const Option(value: Colors.white, label: 'White'),
        const Option(value: Color(0xFF37C999), label: 'GreenBlue'),
        const Option(value: Color(0xFFE96E63), label: 'Salmon'),
      ],
    );
    final knobBackgroundColorBar = context.knobs.options(
      label: 'Background color - bar',
      description:
          'Background for only the bar, so if the content is separated, only the bar part will have this color.',
      initial: Colors.transparent,
      options: [
        const Option(value: Colors.transparent, label: 'Invisible'),
        const Option(value: Colors.blue, label: 'Blue'),
        const Option(value: Colors.pink, label: 'Pink'),
        const Option(value: Colors.green, label: 'Green'),
      ],
    );

    // Content.
    final knobContentBelowBar = context.knobs.boolean(
      label: 'Separate content',
      description: 'Determines if the content is below the bar or above it.',
      initial: false,
    );
    final knobInitialContentHeight = context.knobs
        .sliderInt(
          label: 'Initial content height',
          description: 'Height of content when expanded.',
          initial: 300,
          min: 30,
          max: 300,
        )
        .toDouble();

    // Sliver settings.
    final knobPinned = context.knobs.boolean(
      label: 'Pinned',
      initial: true,
    );
    final knobFloating = context.knobs.boolean(
      label: 'Floating',
      initial: false,
    );

    // Leading actions.
    final knobCollapseLeadingActions = context.knobs.boolean(
      label: 'Collapse leading actions',
      description: 'Collapses leading actions when scrolling.',
      initial: false,
    );
    final knobLeadingActionsPadding = context.knobs
        .sliderInt(
          label: 'Leading actions padding',
          description: 'Collapses trailing actions when scrolling.',
          max: 10,
        )
        .toDouble();

    // Trailing actions.
    final knobCollapseTrailingActions = context.knobs.boolean(
      label: 'Collapse trailing actions',
      description: 'Collapses trailing actions when scrolling.',
      initial: false,
    );
    final knobTrailingActionsPadding = context.knobs
        .sliderInt(
          label: 'Trailing actions padding',
          description: 'Collapses trailing actions when scrolling.',
          max: 10,
        )
        .toDouble();

    // Misc.
    final knobDebug = context.knobs.boolean(
      label: 'Debug',
      description: 'Shows background color for each section - bar, content, leading and trailing actions, whole, ...',
      initial: false,
    );

    // Content customization.
    final knobFontSize = context.knobs
        .sliderInt(
          label: 'Font Size',
          description: "Settings to this demo's contentBuilder font size.",
          initial: 22,
          min: 15,
          max: 30,
        )
        .toDouble();
    final knobText = context.knobs.text(
      label: 'Heading',
      description: "Settings to this demo's contentBuilder text.",
      initial: 'My App Bar',
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarBuilder(
            barHeight: knobBarHeight,
            debug: knobDebug,
            backgroundColorBar: knobBackgroundColorBar,
            backgroundColorAll: knobBackgroundColorAll,
            initialBarHeight: knobInitialBarHeight,
            pinned: knobPinned,
            floating: knobFloating,
            initialContentHeight: knobInitialContentHeight,
            collapseLeadingActions: knobCollapseLeadingActions,
            leadingActionsPadding: EdgeInsets.symmetric(horizontal: knobLeadingActionsPadding),
            collapseTrailingActions: knobCollapseTrailingActions,
            trailingActionsPadding: EdgeInsets.symmetric(horizontal: knobTrailingActionsPadding),
            contentBelowBar: knobContentBelowBar,
            stretch: true,
            stretchConfiguration: OverScrollHeaderStretchConfiguration(
              stretchTriggerOffset: 100,
              onStretchTrigger: _onStretchCallback,
            ),
            contentBuilder: (context, expandRatio, contentHeight, centerPadding, overlapsContent) {
              return Stack(
                children: [
                  // All height image that fades away on scroll.
                  Opacity(
                    opacity: expandRatio,
                    child: ShaderMask(
                      shaderCallback: _shaderCallback,
                      blendMode: BlendMode.dstIn,
                      child: Image(
                        height: contentHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image:
                            const NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                      ),
                    ),
                  ),

                  // Using alignment and padding, centers text to center of bar.
                  Container(
                    alignment: Alignment.centerLeft,
                    height: contentHeight,
                    padding: centerPadding.copyWith(left: 10 + (1 - expandRatio) * 40),
                    child: Text(
                      knobText,
                      style: TextStyle(
                        fontSize: knobFontSize + expandRatio * 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Color.lerp(Colors.black, Colors.transparent, 1 - expandRatio) ?? Colors.transparent,
                            blurRadius: 10,
                            offset: const Offset(4, 2),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            leadingActions: [
              (context, expandRatio, barHeight, overlapsContent) => SizedBox(
                    height: barHeight,
                    child: const BackButton(color: Colors.white),
                  ),
            ],
            trailingActions: [
              (context, expandRatio, barHeight, overlapsContent) {
                return Container(
                  height: barHeight,
                  alignment: Alignment.center,
                  transform: Matrix4.translationValues(expandRatio * 28, 0, 0),
                  child: Text(
                    _counter.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
              (context, expandRatio, barHeight, overlapsContent) {
                return Container(
                  height: barHeight,
                  alignment: Alignment.center,
                  transform: Matrix4.translationValues(0, -expandRatio * barHeight, 0),
                  child: Opacity(
                    opacity: Tween<double>(begin: 1, end: 0).transform((expandRatio * 2).clamp(0.0, 1.0)),
                    child: IconButton(
                      icon: Icon(Icons.lightbulb, color: Color.lerp(Colors.yellow, Colors.red, expandRatio)),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
