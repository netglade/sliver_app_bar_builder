import 'package:flutter/widgets.dart';

/// Widget builder to build a content of `SliverAppBarBuilder`.
typedef ExpandRatioBuilderContentCallback = Widget Function(
  BuildContext context,
  double expandRatio,
  double contentHeight,
  EdgeInsets centerPadding,
  // ignore: avoid_positional_boolean_parameters, prefer-named-boolean-parameters, used in typedef
  bool overlapsContent,
);
