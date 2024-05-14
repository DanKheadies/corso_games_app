import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController cont;
  final bool? obscure;
  final FocusNode? focusNode;
  final Function()? onEditComplete;
  final Function(String) onChange;
  final Function()? onTap;
  final Function(PointerDownEvent)? onTapOutside;

  const CustomTextField({
    super.key,
    required this.cont,
    required this.label,
    required this.onChange,
    this.focusNode,
    this.obscure,
    this.onEditComplete,
    this.onTap,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: cont,
      obscureText: obscure ?? false,
      onEditingComplete: onEditComplete,
      onChanged: onChange,
      onTap: onTap,
      onTapOutside: onTapOutside,
      focusNode: focusNode,
      style: TextStyle(
        color: Theme.of(context).colorScheme.surface,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          // color: Theme.of(context).colorScheme.tertiary,
          color: Theme.of(context).colorScheme.surface,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            // color: ccWhite,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
