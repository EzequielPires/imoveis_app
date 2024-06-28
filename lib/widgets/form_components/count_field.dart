import 'package:flutter/material.dart';

class CountField extends StatefulWidget {
  final int count;
  final String title;
  final Function(int value) onChange;
  const CountField(
      {super.key,
      required this.count,
      required this.title,
      required this.onChange});

  @override
  State<CountField> createState() => _CountFieldState();
}

class _CountFieldState extends State<CountField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            IconButton.filledTonal(
                onPressed: () {
                  setState(() {
                    widget.onChange(
                        widget.count > 0 ? widget.count - 1 : widget.count);
                  });
                },
                icon: const Icon(
                  Icons.remove,
                  size: 16,
                )),
            const SizedBox(
              width: 8,
            ),
            Text('${widget.count}'),
            const SizedBox(
              width: 8,
            ),
            IconButton.filledTonal(
                onPressed: () {
                  setState(() {
                    widget.onChange(
                        widget.count < 10 ? widget.count + 1 : widget.count);
                  });
                },
                icon: const Icon(
                  Icons.add,
                  size: 16,
                )),
          ],
        )
      ],
    );
  }
}
