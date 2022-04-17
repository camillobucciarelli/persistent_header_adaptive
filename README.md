Sliver Persistent Header with intrinsic height.

## Features

With this package you can create a SliverPersisteHeader without specifying the height of this.

## Getting started

add this package to the dependencies block in your application.

```yaml
dependencies:
  ...
  persistent_header_adaptive: ^1.0.0
```

## Usage

you can create your own header widget like the following one

```dart
class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

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

and use the `AdaptiveHeightSliverPersistentHeader` to put thew header in a `CustomScrollView` as a `SliverPersisteHeader`

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
