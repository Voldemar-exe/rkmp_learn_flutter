import 'package:flutter/material.dart';

class TestListingWidgetScreen extends StatelessWidget {
  const TestListingWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
          itemCount: 50,
          itemBuilder: (context, index) {
            final number = index + 1;
            return Column(
              children: [
                Text("$number"),
                Text("Нилов Владимир Владимирович"),
                Text("ИКБО-06-22"),
                Text("22И1745"),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),

      ),
    );
  }
}

class DeletionScreen extends StatefulWidget {
  const DeletionScreen({super.key});

  @override
  State<DeletionScreen> createState() => _DeletionScreenState();
}
class _DeletionScreenState extends State<DeletionScreen> {
  List<String> items = ['А', 'Б', 'В', 'Г', 'Д'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _StatefulItem(
            key: ValueKey(items[index].hashCode),
            name: items[index],
            onDelete: () {
              setState(() {
                items.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}
class _StatefulItem extends StatefulWidget {
  final String name;
  final VoidCallback onDelete;

  const _StatefulItem({
    super.key,
    required this.name,
    required this.onDelete,
  });

  @override
  State<_StatefulItem> createState() => _StatefulItemState();
}
class _StatefulItemState extends State<_StatefulItem> {
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: widget.key,
      title: Text(widget.name),
      tileColor: _isHighlighted ? Colors.red[200] : null,
      leading: Icon(_isHighlighted ? Icons.star : Icons.person),
      onTap: widget.onDelete,
      onLongPress: () {
        setState(() {
          _isHighlighted = true;
        });
      },
    );
  }
}