import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final void Function(bool) onChanged;

  const CustomCheckbox({super.key, required this.isChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,width: 30,
    child: MSHCheckbox(
      size: 30,
      value: isChecked,
      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
        checkedColor: const Color.fromARGB(255, 216, 196, 154).withAlpha(255),
      ),
      style: MSHCheckboxStyle.stroke,
      onChanged: onChanged
    ),
    );
  }
}