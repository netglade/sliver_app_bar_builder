import 'package:flutter/widgets.dart';

/// Widget builder to build a bar (leading and trailing actions) of `SliverAppBarBuilder`.
typedef ShrinkRatioBuilderBarCallback = Widget Function(
  BuildContext context,
  double expandRatio,
  double barHeight,
  bool overlapsContent,
);
