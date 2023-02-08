import 'package:flutter/widgets.dart';

/// Widget builder to build a content of `SliverAppBarBuilder`.
typedef ExpandRatioBuilderContentCallback = Widget Function(
  BuildContext context,
  double expandRatio,
  double contentHeight,
  bool overlapsContent,
);
