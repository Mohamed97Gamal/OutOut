import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomCheckBoxGroupFormField<T> extends StatefulWidget {
  final String name;
  final List<FormBuilderFieldOption<T>> options;
  final List<T>? initialValue;
  final ValueChanged<List<T>?>? onChanged;

  const CustomCheckBoxGroupFormField({
    Key? key,
    required this.name,
    required this.options,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomCheckBoxGroupFormFieldState<T> createState() => _CustomCheckBoxGroupFormFieldState<T>();
}

class _CustomCheckBoxGroupFormFieldState<T> extends State<CustomCheckBoxGroupFormField<T>> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FormBuilderField<List<T>>(
        initialValue: widget.initialValue ?? <T>[],
        builder: (field) {
          return Column(
            children: [
              for (final option in widget.options)
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: field.value?.contains(option.value) ?? false,
                  title: option.child,
                  onChanged: (newValue) {
                    if (newValue ?? false) {
                      var list = [...field.value!, option.value];
                      field.didChange(list);
                    } else {
                      var list = [...field.value!]..remove(option.value);
                      field.didChange(list);
                    }
                  },
                ),
            ],
          );
        },
        name: widget.name,
      ),
    );
  }
}
