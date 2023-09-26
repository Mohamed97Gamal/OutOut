import 'package:flutter/material.dart';

class ShowPasswordTextField extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final Icon? icon;
  final Icon? prefixIcon;
  final bool? autoValidate;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final TextStyle? style;
  final InputBorder? border;
  final Iterable<String>? autofillHints;

  const ShowPasswordTextField({
    Key? key,
    this.border,
    this.style,
    this.validator,
    this.controller,
    this.labelText,
    this.initialValue,
    this.autoValidate,
    this.prefixIcon,
    this.icon,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.hintText,
    this.autofillHints,
  }) : super(key: key);

  @override
  _ShowPasswordTextFieldState createState() => _ShowPasswordTextFieldState();
}

class _ShowPasswordTextFieldState extends State<ShowPasswordTextField> {
  late bool hidePassword;

  @override
  void initState() {
    hidePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: widget.style,
      autofillHints: widget.autofillHints,
      initialValue: widget.controller == null ? widget.initialValue : null,
      autovalidateMode: (widget.autoValidate ?? false) ? AutovalidateMode.always : AutovalidateMode.disabled,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        labelText: widget.labelText,
        hintText: widget.hintText,
        errorMaxLines: 3,
        icon: widget.icon,
        suffixIcon: GestureDetector(
          child: IntrinsicHeight(
            child: SizedBox(
              width: 80.0,
              child: Center(
                child: Card(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                  color: const Color(0xff99544f),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    child: Text(
                      hidePassword ? "SHOW" : "HIDE",
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          onTap: () => setState(() => hidePassword = !hidePassword),
        ),
      ),
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted ?? (_) {},
      controller: widget.controller,
      validator: widget.validator,
      textDirection: TextDirection.ltr,
      obscureText: hidePassword,
    );
  }
}
