import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.onSave,
  }) : super(key: key);

  final String title;
  final String initialValue;
  final Function(String p1) onSave;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String fieldValue = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: Focus(
              onFocusChange: (value) {
                if (value) {
                  fieldValue = widget.initialValue;
                } else if (fieldValue != widget.initialValue) {
                  widget.onSave(fieldValue);
                }
              },
              child: TextFormField(
                initialValue: widget.initialValue,
                onChanged: (value) {
                  fieldValue = value;
                  widget.onSave(fieldValue);
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.only(left: 2),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      // color: Colors.black,r
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
