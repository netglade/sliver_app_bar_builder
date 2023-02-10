# sliver_app_bar_builder

<a href="https://netglade.cz/en">
  <picture>
     <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_light.png">
     <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_dark.png">
     <img alt="netglade" src="https://raw.githubusercontent.com/netglade/.github/main/assets/netglade_logo_dark.png">
   </picture>
</a>

Developed with 💚 by [netglade][netglade_link]

[![ci][ci_badge]][ci_badge_link]
[![pub package][pub_badge]][pub_badge_link]
[![license: MIT][license_badge]][license_badge_link]
[![style: netglade analysis][style_badge]][style_badge_link]

---

A truly customizable sliver for app bars with the benefit of using builders.
Check the [storybook demo][storybook_demo_link] and play with it yourself.

`SliverAppBarBuilder` supports various configurations:

- bar
  - height
  - initialHeight (when expanded)
  - background (for everything or bar only)
- content
  - builder
  - initialHeight
  - toggle contentBelowBar (whether content is on top or below bar)
  - padding
- leading and trailing actions
  - list of builders
  - toggle collapsing
  - padding
- stretching
  - toggle stretch
  - stretchConfiguration
- misc
  - pinned mode
  - toggle mode
  - toggle debug (so you can debug each part visually)

[![][storybook_image_link]][storybook_demo_link]

## Getting Started

Using the package is simple.
Just use the sliver `SliverAppBarBuilder` in place of `SliverAppBar`,
configure all the properties,
and enjoy.

Each builder, for content or leading/trailing actions,
provides expand ratio and content/bar height,
so you can easily use these values to customize your headers.

- `expandRatio` is a value between `1.0` when expanded and `0.0` when shrunken
- `contentHeight`/`barHeight` are current heights of corresponding parts

Content builder has additional property:
- `centerPadding`, when `contentBelowBar` is false, is a value used to offset content to center it with bar

An example of a header with title moving from under back button to its right might look like this:

```dart
CustomScrollView(
  slivers: [
    SliverAppBarBuilder(
      barHeight: 60,
      pinned: true,
      leadingActions: [
        (context, expandRatio, barHeight, overlapsContent) {
          return SizedBox(
            height: barHeight,
            child: const BackButton(),
          );
        }
      ],
      initialContentHeight: 150,
      contentBuilder: (context, expandRatio, contentHeight, overlapsContent) {
        return Container(
          alignment: Alignment.centerLeft,
          height: 60,
          transform: Matrix4.translationValues(10 + (1 - expandRatio) * 40, 0, 0),
          child: Text(
            'My Title',
            style: TextStyle(
              fontSize: 22 + expandRatio * 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    ),
  ],
);
```

[storybook_image_link]: https://github.com/netglade/sliver_app_bar_builder/raw/main/screenshots/storybook.png
[storybook_demo_link]: https://netglade.github.io/sliver_app_bar_builder

[netglade_link]: https://netglade.cz/en

[ci_badge]: https://github.com/netglade/sliver_app_bar_builder/workflows/ci/badge.svg
[ci_badge_link]: https://github.com/netglade/sliver_app_bar_builder/actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_badge_link]: https://opensource.org/licenses/MIT
[pub_badge]: https://img.shields.io/pub/v/sliver_app_bar_builder.svg
[pub_badge_link]: https://pub.dartlang.org/packages/sliver_app_bar_builder
[style_badge]: https://img.shields.io/badge/style-netglade_analysis-26D07C.svg
[style_badge_link]: https://pub.dev/packages/netglade_analysis
