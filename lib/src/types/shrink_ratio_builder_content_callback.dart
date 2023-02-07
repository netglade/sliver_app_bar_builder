import 'package:flutter/widgets.dart';

/// Widget builder to build a content of `SliverAppBarBuilder`.
typedef ShrinkRatioBuilderContentCallback = Widget Function(
  BuildContext context,
  double expandRatio,
  double contentHeight,
  bool overlapsContent,
);
