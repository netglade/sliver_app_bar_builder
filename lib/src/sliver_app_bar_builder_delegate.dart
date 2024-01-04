import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_app_bar_builder/src/types/expand_ratio_builder_bar_callback.dart';
import 'package:sliver_app_bar_builder/src/types/expand_ratio_builder_content_callback.dart';

/// Custom [SliverPersistentHeaderDelegate] implementation.
///
/// {@template SliverAppBarBuilderDelegate}
/// App bar consists of **bar** and **content**.
///
/// Bar has a height of [barHeight].
/// Using [initialBarHeight] sets an initial bar height when the app bar is expanded.
/// By default, [initialBarHeight] is set to [barHeight].
///
/// Bar contains [leadingActions] and [trailingActions] that user can specify.
/// By default, [leadingActions] contains [BackButton].
///
/// Below bar there is content.
/// Content shrinks (or expands when smaller) its height from [initialContentHeight] to [barHeight].
/// {@endtemplate}
class SliverAppBarBuilderDelegate extends SliverPersistentHeaderDelegate {
  /// {@template SliverAppBarBuilderDelegate.viewPadding}
  /// Safe area padding of the device.
  /// Used to prepend app bar with spacing.
  /// {@endtemplate}
  final EdgeInsets viewPadding;

  /// {@template SliverAppBarBuilderDelegate.barHeight}
  /// Height of the bar when shrunk.
  /// {@endtemplate}
  final double barHeight;

  /// {@template SliverAppBarBuilderDelegate.barInitialHeight}
  /// Defines an initial height of bar when the header is expanded.
  ///
  /// Useful to initially make bar height larger (or smaller)
  /// or to prevent weird spacing.
  /// {@endtemplate}
  final double? initialBarHeight;

  /// {@template SliverAppBarBuilderDelegate.contentBuilder}
  /// Defines [ExpandRatioBuilderContentCallback] builder to build content widget.
  ///
  /// [initialContentHeight] must also be defined.
  /// {@endtemplate}
  // ignore: prefer-correct-callback-field-name, public api
  final ExpandRatioBuilderContentCallback? contentBuilder;

  /// {@template SliverAppBarBuilderDelegate.contentHeight}
  /// Height of content when expanded.
  /// When [contentBelowBar] is false, if [initialContentHeight] is less than bar height, bar's height is used instead.
  ///
  /// [contentBuilder] must also be defined.
  /// {@endtemplate}
  final double? initialContentHeight;

  /// {@template SliverAppBarBuilderDelegate.actionsPadding}
  /// Padding for content.
  /// {@endtemplate}
  final EdgeInsets? contentPadding;

  /// {@template SliverAppBarBuilderDelegate.leadingActions}
  /// List of [ExpandRatioBuilderBarCallback] to be placed in leading (top right in bar) position.
  /// {@endtemplate}
  final List<ExpandRatioBuilderBarCallback> leadingActions;

  /// {@template SliverAppBarBuilderDelegate.shrinkLeadingActions}
  /// Sets whether leading actions should be collapsed above viewport on scroll.
  /// {@endtemplate}
  final bool collapseLeadingActions;

  /// {@template SliverAppBarBuilderDelegate.actionsPadding}
  /// Padding for leading actions.
  /// {@endtemplate}
  final EdgeInsets? leadingActionsPadding;

  /// {@template SliverAppBarBuilderDelegate.trailingActions}
  /// List of [ExpandRatioBuilderBarCallback] to be placed in leading (top right in bar) position.
  /// {@endtemplate}
  final List<ExpandRatioBuilderBarCallback> trailingActions;

  /// {@template SliverAppBarBuilderDelegate.shrinkTrailingActions}
  /// Sets whether trailing actions should be collapsed above viewport on scroll.
  /// {@endtemplate}
  final bool collapseTrailingActions;

  /// {@template SliverAppBarBuilderDelegate.actionsPadding}
  /// Padding for trailing actions.
  /// {@endtemplate}
  final EdgeInsets? trailingActionsPadding;

  /// {@template SliverAppBarBuilderDelegate.debug}
  /// Used for debugging purposes.
  /// Adds colors to each section - everything, bar, content, leading actions, trailing actions.
  /// {@endtemplate}
  final bool debug;

  /// {@template SliverAppBarBuilderDelegate.backgroundColor}
  /// Color used to color bar.
  /// {@endtemplate}
  final Color? backgroundColorBar;

  /// {@template SliverAppBarBuilderDelegate.allBackgroundColor}
  /// Color used to color the whole app bar.
  /// {@endtemplate}
  ///
  /// Defaults to primary color.
  final Color? backgroundColorAll;

  /// {@template SliverAppBarBuilderDelegate.contentBelowBar}
  /// Determines if the content is below the bar or in stack with it.
  /// {@endtemplate}
  final bool contentBelowBar;

  /// {@template SliverAppBarBuilderDelegate.stretch}
  /// Determines if content is expanded on stretch.
  /// {@endtemplate}
  final bool stretch;

  /// {@template SliverAppBarBuilderDelegate.stretchConfiguration}
  /// Setups `OverScrollHeaderStretchConfiguration` that is applied when [stretch] is enabled.
  /// {@endtemplate}
  final OverScrollHeaderStretchConfiguration? _stretchConfiguration;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => stretch ? _stretchConfiguration : null;

  @override
  double get maxExtent {
    final addToAll = viewPadding.top;

    return addToAll + _maxExtentWithoutSafeArea;
  }

  @override
  double get minExtent => viewPadding.top + _minExtentWithoutSafeArea;

  double get _maxExtentWithoutSafeArea {
    final initialContentHeightTmp = initialContentHeight ?? 0;
    final initialBarHeightTmp = initialBarHeight ?? 0;
    final barHeightTmp = max(initialBarHeightTmp, barHeight);

    return contentBelowBar ? barHeightTmp + initialContentHeightTmp : max(initialContentHeightTmp, barHeightTmp);
  }

  double get _minExtentWithoutSafeArea => barHeight;

  /// {@macro SliverAppBarBuilderDelegate}
  const SliverAppBarBuilderDelegate({
    required this.viewPadding,
    required this.barHeight,
    this.initialBarHeight,
    this.initialContentHeight,
    this.contentBuilder,
    this.contentPadding,
    this.leadingActions = const [],
    this.leadingActionsPadding,
    this.collapseLeadingActions = false,
    this.trailingActions = const [],
    this.trailingActionsPadding,
    this.collapseTrailingActions = false,
    this.backgroundColorAll,
    this.backgroundColorBar,
    this.contentBelowBar = true,
    this.debug = false,
    this.stretch = false,
    OverScrollHeaderStretchConfiguration? stretchConfiguration,
  }) : _stretchConfiguration = stretchConfiguration;

  @override
  bool shouldRebuild(covariant SliverAppBarBuilderDelegate oldDelegate) {
    return viewPadding != oldDelegate.viewPadding ||
        barHeight != oldDelegate.barHeight ||
        initialBarHeight != oldDelegate.initialBarHeight ||
        initialContentHeight != oldDelegate.initialContentHeight ||
        contentBuilder != oldDelegate.contentBuilder ||
        contentPadding != oldDelegate.contentPadding ||
        leadingActions != oldDelegate.leadingActions ||
        leadingActionsPadding != oldDelegate.leadingActionsPadding ||
        collapseLeadingActions != oldDelegate.collapseLeadingActions ||
        trailingActions != oldDelegate.trailingActions ||
        trailingActionsPadding != oldDelegate.trailingActionsPadding ||
        collapseTrailingActions != oldDelegate.collapseTrailingActions ||
        backgroundColorAll != oldDelegate.backgroundColorAll ||
        backgroundColorBar != oldDelegate.backgroundColorBar ||
        contentBelowBar != oldDelegate.contentBelowBar ||
        debug != oldDelegate.debug;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final expandRatio = (_maxExtentWithoutSafeArea - _minExtentWithoutSafeArea == 0)
        ? 1.0
        : (min(_maxExtentWithoutSafeArea - _minExtentWithoutSafeArea, shrinkOffset) /
            (_maxExtentWithoutSafeArea - _minExtentWithoutSafeArea));

    final barHeightTmp = initialBarHeight ?? barHeight;
    final contentBuilderTmp = contentBuilder;

    final barHeightTween = Tween(begin: barHeightTmp, end: barHeight);
    final barHeightTransformed = barHeightTween.transform(expandRatio);

    final contentTopOffset = Tween(
      begin: contentBelowBar ? viewPadding.top + barHeightTmp : 0,
      end: contentBelowBar ? viewPadding.top : 0,
    );
    final contentTopOffsetTransformed = contentTopOffset.transform(expandRatio);

    return LayoutBuilder(
      builder: (context, constraints) {
        final allHeight = constraints.maxHeight - contentTopOffsetTransformed;

        return Container(
          constraints: const BoxConstraints.expand(),
          color: debug ? Colors.yellow.withOpacity(0.5) : backgroundColorAll,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Colors bar in debug or with backgroundColorBar color by default.
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: debug ? Colors.red.withOpacity(0.5) : backgroundColorBar,
                  height: viewPadding.top + barHeightTransformed,
                ),
              ),

              // Content.
              if (contentBuilderTmp != null)
                Positioned.fill(
                  top: contentTopOffsetTransformed.toDouble(),
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    color: debug ? Colors.deepPurple.withOpacity(0.5) : null,
                    padding: contentPadding,
                    // Wrap prevents overflow.
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      clipBehavior: Clip.hardEdge,
                      children: [
                        contentBuilderTmp(
                          context,
                          1 - expandRatio,
                          allHeight,
                          EdgeInsets.only(top: !contentBelowBar ? viewPadding.top : 0),
                          overlapsContent,
                        ),
                      ],
                    ),
                  ),
                ),
              Container(
                padding: EdgeInsets.only(top: viewPadding.top),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Color initial bar in debug.
                    if (debug)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.red.withOpacity(0.5),
                          height: barHeightTmp,
                        ),
                      ),

                    // Trailing Actions.
                    Positioned(
                      top: collapseTrailingActions ? (-expandRatio * barHeightTmp) : 0,
                      right: 0,
                      child: Container(
                        color: debug ? Colors.green.withOpacity(0.5) : null,
                        height: collapseTrailingActions ? barHeightTmp : barHeightTransformed,
                        padding: trailingActionsPadding,
                        // Wrap prevents overflow.
                        child: Wrap(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            for (final action in trailingActions)
                              action(
                                context,
                                expandRatio,
                                barHeightTransformed - (trailingActionsPadding?.vertical ?? 0),
                                overlapsContent,
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Leading Actions.
                    Positioned(
                      top: collapseLeadingActions ? (-expandRatio * barHeightTmp) : 0,
                      left: 0,
                      child: Container(
                        color: debug ? Colors.orange.withOpacity(0.5) : null,
                        height: collapseLeadingActions ? barHeightTmp : barHeightTransformed,
                        padding: leadingActionsPadding,
                        // Wrap prevents overflow.
                        child: Wrap(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            for (final action in leadingActions)
                              action(
                                context,
                                expandRatio,
                                barHeightTransformed - (leadingActionsPadding?.vertical ?? 0),
                                overlapsContent,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
