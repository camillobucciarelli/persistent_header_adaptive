# Persistent Header Adaptive

[![pub package](https://img.shields.io/pub/v/persistent_header_adaptive.svg)](https://pub.dev/packages/persistent_header_adaptive)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter package that provides a `SliverPersistentHeader` with adaptive height capabilities, automatically adjusting to its content's size without requiring a fixed height.

## Features

- Create `SliverPersistentHeader` widgets without specifying fixed heights
- Automatically adapts to the height of its content
- Supports both pinned and floating headers
- Compatible with `CustomScrollView` and other sliver-based scrolling widgets
- Optimized for smooth rendering and performance

## Installation

Add this package to your `pubspec.yaml` file:

```yaml
dependencies:
  persistent_header_adaptive: ^2.1.2
```

Run the install command:

```bash
flutter pub get
```

## Usage

### Basic Implementation

First, create your header widget:

```dart
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('line 1'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('line 2.1'),
              Text('line 2.2'),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('button'),
          ),
        ],
      ),
    );
  }
}
```

Then use `AdaptiveHeightSliverPersistentHeader` in a `CustomScrollView`:

```dart
class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const AdaptiveHeightSliverPersistentHeader(
              child: Header(),
              floating: true,
              needRepaint: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('card $index'),
                  ),
                ),
                childCount: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
```

## Parameters

The `AdaptiveHeightSliverPersistentHeader` widget supports the following parameters:

| Parameter      | Type      | Default | Description                                                                     |
|---------------|-----------|---------|---------------------------------------------------------------------------------|
| `child`        | `Widget`  | required| The widget to display as the header                                             |
| `pinned`       | `bool`    | `false` | Whether the header should remain visible at the start of the viewport           |
| `floating`     | `bool`    | `false` | Whether the header should become visible when scrolling up even when not at top |
| `needRepaint`  | `bool`    | `false` | Whether the header should repaint on rebuild                                    |
| `initialHeight`| `double`  | `0.0`   | Initial height to use before the widget's actual height is calculated           |

## How It Works

`AdaptiveHeightSliverPersistentHeader` uses a combination of `SizeReportingWidget` and `OverflowBox` to:

1. Render the child widget without height constraints
2. Measure the resulting rendered size
3. Update the sliver's height to match the content's height
4. Trigger a layout update when the content size changes

This approach eliminates the need to manually specify heights for header widgets while ensuring proper layout and scrolling behavior.

## Examples

### Pinned Header

```dart
AdaptiveHeightSliverPersistentHeader(
  pinned: true,
  child: MyHeaderWidget(),
)
```

### Floating Header

```dart
AdaptiveHeightSliverPersistentHeader(
  floating: true,
  child: MyHeaderWidget(),
)
```

### With Initial Height

```dart
AdaptiveHeightSliverPersistentHeader(
  initialHeight: 100, // Initial height guess for better performance
  floating: true,
  child: MyHeaderWidget(),
)
```

## Performance Considerations

For optimal performance:

- Set a reasonable `initialHeight` if you can approximate the header's height
- Use `needRepaint: false` when the header content rarely changes
- Apply appropriate keys to header widgets to preserve state when appropriate

## Contributing

Contributions are welcome! If you find a bug or want to add a feature, please file an issue or submit a pull request on the [GitHub repository](https://github.com/camillobucciarelli/persistent_header_adaptive).

## License

This package is available under the MIT License.

```
