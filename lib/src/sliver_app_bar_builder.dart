import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_app_bar_builder/src/sliver_app_bar_builder_delegate.dart';
import 'package:sliver_app_bar_builder/src/types/expand_ratio_builder_bar_callback.dart';
import 'package:sliver_app_bar_builder/src/types/expand_ratio_builder_content_callback.dart';

/// {@template SliverAppBarBuilder}
/// Sliver for an app bar that uses [SliverAppBarBuilderDelegate].
///
/// This sliver is customizable,
/// exposes [ExpandRatioBuilderContentCallback] builder to build a content based on expand ratio and/or content height
///   with center padding that provides padding one can use to center content to bar,
/// exposes [ExpandRatioBuilderBarCallback] builder to build leading or trailing actions based on expand ratio and/or bar height,
/// exposes paddings for content and leading and trailing actions,
/// provides a way to collapse leading and trailing actions,
/// and provides a debug mode.
/// {@endtemplate}
///
/// {@macro SliverAppBarBuilderDelegate}
class SliverAppBarBuilder extends StatelessWidget {
  /// Whether to stick the header to the start of the viewport once it has
  /// reached its minimum size.
  ///
  /// Defaults to false.
  final bool pinned;

  /// Whether the header should immediately grow again if the user reverses
  /// scroll direction.
  ///
  /// Defaults to false.
  final bool floating;

  /// {@macro SliverAppBarBuilderDelegate.barHeight}
  final double barHeight;

  /// {@macro SliverAppBarBuilderDelegate.barInitialHeight}
  final double? initialBarHeight;

  /// {@macro SliverAppBarBuilderDelegate.contentBuilder}
  final ExpandRatioBuilderContentCallback? contentBuilder;

  /// {@macro SliverAppBarBuilderDelegate.contentHeight}
  final double? initialContentHeight;

  /// {@macro SliverAppBarBuilderDelegate.actionsPadding}
  final EdgeInsets? contentPadding;

  /// {@macro SliverAppBarBuilderDelegate.leadingActions}
  ///
  /// Defaults to [BackButton].
  final List<ExpandRatioBuilderBarCallback>? leadingActions;

  /// {@macro SliverAppBarBuilderDelegate.shrinkLeadingActions}
  ///
  /// Defaults to false.
  final bool collapseLeadingActions;

  /// {@macro SliverAppBarBuilderDelegate.actionsPadding}
  final EdgeInsets? leadingActionsPadding;

  /// {@macro SliverAppBarBuilderDelegate.trailingActions}
  final List<ExpandRatioBuilderBarCallback> trailingActions;

  /// {@macro SliverAppBarBuilderDelegate.shrinkTrailingActions}
  ///
  /// Defaults to false.
  final bool collapseTrailingActions;

  /// {@macro SliverAppBarBuilderDelegate.actionsPadding}
  final EdgeInsets? trailingActionsPadding;

  /// {@macro SliverAppBarBuilderDelegate.debug}
  final bool debug;

  /// {@macro SliverAppBarBuilderDelegate.backgroundColor}
  final Color? backgroundColorBar;

  /// {@macro SliverAppBarBuilderDelegate.allBackgroundColor}
  final Color? backgroundColorAll;

  /// {@macro SliverAppBarBuilderDelegate.contentBelowBar}
  ///
  /// Defaults to true.
  final bool contentBelowBar;

  /// {@macro SliverAppBarBuilderDelegate.stretch}
  final bool stretch;

  /// {@macro SliverAppBarBuilderDelegate.stretchConfiguration}
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;

  /// {@macro SliverAppBarBuilder}
  ///
  /// {@macro SliverAppBarBuilderDelegate}
  const SliverAppBarBuilder({
    required this.barHeight,
    this.pinned = false,
    this.floating = false,
    this.initialBarHeight,
    this.contentBuilder,
    this.initialContentHeight,
    this.contentPadding,
    this.leadingActions,
    this.collapseLeadingActions = false,
    this.leadingActionsPadding,
    this.trailingActions = const [],
    this.collapseTrailingActions = false,
    this.trailingActionsPadding,
    this.debug = false,
    this.backgroundColorBar,
    this.backgroundColorAll,
    this.contentBelowBar = true,
    this.stretch = false,
    this.stretchConfiguration,
    super.key,
  }) : assert(
          !((initialContentHeight != null) ^ (contentBuilder != null)),
          'both contentHeight and contentBuilder has to be either set or not set',
        );

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: pinned,
      floating: floating,
      delegate: SliverAppBarBuilderDelegate(
        viewPadding: MediaQuery.viewPaddingOf(context),
        barHeight: barHeight,
        initialBarHeight: initialBarHeight,
        initialContentHeight: initialContentHeight,
        contentBuilder: contentBuilder,
        contentPadding: contentPadding,
        leadingActions: leadingActions ?? [(_, __, ___, ____) => const BackButton()],
        leadingActionsPadding: leadingActionsPadding,
        collapseLeadingActions: collapseLeadingActions,
        trailingActions: trailingActions,
        trailingActionsPadding: trailingActionsPadding,
        collapseTrailingActions: collapseTrailingActions,
        contentBelowBar: contentBelowBar,
        backgroundColorAll: backgroundColorAll ?? Theme.of(context).primaryColor,
        backgroundColorBar: backgroundColorBar,
        debug: debug,
        stretch: stretch,
        stretchConfiguration: stretchConfiguration,
      ),
    );
  }
}
