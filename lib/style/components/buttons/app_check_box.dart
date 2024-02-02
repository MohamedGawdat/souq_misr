import 'package:flutter/material.dart';

class AppCheckBox extends StatefulWidget {
  final ValueChanged<bool> callBack;
  bool? value;
  bool canChangeToFalse;
  AppCheckBox({
    super.key,
    required this.callBack,
    this.value = false,
    this.canChangeToFalse = true,
  });

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: widget.value,
        onChanged: (v) {
          // print(v!);
          if (widget.canChangeToFalse) {
            setState(() {
              widget.value = !widget.value!;
            });
          } else {
            if (!v!) {
            } else {
              setState(() {
                widget.value = !widget.value!;
              });
            }
          }
          widget.callBack(v!);
        });
  }
}
