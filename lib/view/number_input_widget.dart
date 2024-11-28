import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NumberInputWidget extends HookWidget {
  final String title;
  final int defaultValue;
  final double inputFieldWidth;
  final int Function(int value)? onChanged;

  const NumberInputWidget({
    super.key,
    required this.title,
    this.inputFieldWidth = 60,
    this.defaultValue = 0,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: defaultValue.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title),
        const SizedBox(width: 10),
        SizedBox(
          width: inputFieldWidth,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (onChanged == null) return;
              final intValue = int.tryParse(value);
              if (intValue == null) return;
              final result = onChanged!(intValue);
              controller.text = result.toString();
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            },
          ),
        ),
      ],
    );
  }
}
