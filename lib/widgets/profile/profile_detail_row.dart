import 'package:flutter/material.dart';

class ProfileDetailRow extends StatefulWidget {
  final String label;
  final String content;
  final bool isEditable;
  final bool? isObscure;
  final Function(String) onChange;
  final Function(String) onSubmit;
  final void Function()? onPopup;

  const ProfileDetailRow({
    super.key,
    required this.label,
    required this.content,
    this.isEditable = true,
    this.isObscure = false,
    required this.onChange,
    required this.onSubmit,
    this.onPopup,
  });

  @override
  State<ProfileDetailRow> createState() => _ProfileDetailRowState();
}

class _ProfileDetailRowState extends State<ProfileDetailRow> {
  late TextEditingController textCont;

  bool isEditing = false;
  String localContent = '';

  @override
  void initState() {
    super.initState();

    textCont = TextEditingController(
      text: widget.content,
    );
    textCont.selection = TextSelection.fromPosition(
      TextPosition(
        offset: textCont.text.length,
      ),
    );
    localContent = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        top: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              child: TextField(
                controller: textCont,
                enabled: widget.isEditable ? isEditing : false,
                onChanged: (value) {
                  widget.onChange(value);
                  setState(() {
                    localContent = value;
                  });
                },
                onSubmitted: (value) {
                  widget.onSubmit(value);
                  setState(() {
                    isEditing = false;
                    localContent = value;
                  });
                },
                obscureText: widget.isObscure ?? false,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  labelText: widget.label.toUpperCase(),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  filled: true,
                  fillColor: isEditing
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).scaffoldBackgroundColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                      width: 2,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          widget.isEditable || widget.onPopup != null
              ? Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isEditing ? Icons.save : Icons.edit,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: widget.onPopup ??
                        () {
                          isEditing ? widget.onSubmit(localContent) : () {};
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                  ),
                )
              : const SizedBox(width: 30),
        ],
      ),
    );
  }
}
