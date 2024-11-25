import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NumberInputWidget extends HookWidget {
  final String title;
  final int defaultValue;
  final void Function(int value)? onChanged;

  const NumberInputWidget({
    super.key,
    required this.title,
    this.defaultValue = 0,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: defaultValue.toString());

    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 200,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (onChanged != null) {
                final intValue = int.tryParse(value);
                if (intValue != null) {
                  onChanged!(intValue);
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
