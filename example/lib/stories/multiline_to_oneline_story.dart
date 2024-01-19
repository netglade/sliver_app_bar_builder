// ignore_for_file: no-empty-block, avoid-local-functions

import 'package:flutter/material.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class MultilineToOneLineStory extends StatelessWidget {
  const MultilineToOneLineStory({super.key});

  double _leftPaddingForExpandRatio(double expandRatio) {
    return 10 + (1 - expandRatio) * 40;
  }

  TextStyle _styleForExpandRatio({required double expandRatio, required double knobFontSize}) {
    return TextStyle(
      fontSize: knobFontSize + expandRatio * 10,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  double _heightFromPainterForExpandRatio({
    required BuildContext context,
    required double expandRatio,
    required String knobText,
    required double knobFontSize,
  }) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final paddingSpace = EdgeInsets.only(left: _leftPaddingForExpandRatio(expandRatio));

    final painter = TextPainter()
      ..text = TextSpan(
        text: knobText,
        style: _styleForExpandRatio(expandRatio: expandRatio, knobFontSize: knobFontSize),
      )
      ..textDirection = TextDirection.ltr
      ..layout(maxWidth: screenWidth - paddingSpace.left * 2);

    return painter.height;
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

    // Content.
    final knobOneLineThreshold = context.knobs.slider(
      label: 'One line threshold',
      description: "Settings to this demo's contentBuilder font size.",
      initial: 0.9,
    );
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
      initial: 'Some very long text that is multiline when expanded and one line when shrunken',
    );

    final initialHeight = _heightFromPainterForExpandRatio(
      context: context,
      expandRatio: 1,
      knobText: knobText,
      knobFontSize: knobFontSize,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarBuilder(
            barHeight: knobBarHeight,
            backgroundColorAll: Colors.lime,
            initialBarHeight: knobInitialBarHeight,
            pinned: true,
            initialContentHeight: initialHeight,
            leadingActionsPadding: const EdgeInsets.symmetric(horizontal: 8),
            collapseTrailingActions: true,
            trailingActionsPadding: const EdgeInsets.symmetric(horizontal: 8),
            contentBuilder: (context, expandRatio, contentHeight, centerPadding, overlapsContent) {
              final paddingSpace = centerPadding.copyWith(left: _leftPaddingForExpandRatio(expandRatio));
              final textStyle = _styleForExpandRatio(expandRatio: expandRatio, knobFontSize: knobFontSize);
              final textHeight = _heightFromPainterForExpandRatio(
                context: context,
                expandRatio: expandRatio,
                knobText: knobText,
                knobFontSize: knobFontSize,
              );

              return Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: contentHeight,
                    padding: paddingSpace,
                    child: AnimatedContainer(
                      height: expandRatio > knobOneLineThreshold ? textHeight : knobBarHeight,
                      alignment: Alignment.centerLeft,
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        knobText,
                        overflow: expandRatio > knobOneLineThreshold ? null : TextOverflow.ellipsis,
                        softWrap: true,
                        style: textStyle,
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
                  child: IconButton(
                    icon: const Icon(Icons.lightbulb, color: Colors.yellow),
                    onPressed: () {},
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
    );
  }
}
