import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacist_application/core/util/theme.dart';

import '../../../core/util/palette.dart';

class MainUnfilledTextField extends StatelessWidget {

  const MainUnfilledTextField(
      {Key? key, this.controller, this.keyboardType, this.formatters, this.labelText, this.validator, this.isRequired = false})
      : super(key: key);
  final String? Function(String?)? validator;
  final bool isRequired;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(isRequired &&(value == null || value.isEmpty)) {
          return "$labelText is Required";
        }
        if(validator != null){
          validator!(value);
        }
        return null;
      },
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      inputFormatters: formatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            color: Theme.of(context).isDark
                ? ColorConfig.DARK_FieldBorder
                : ColorConfig.FieldBorder,
            width: 2,
          ),
        ),
      ),
    );
  }

  static const Map<String, Map<String, String>> translations = {
    'en': {
      'stores': 'Stores',
      'pending_stores': 'Stores Pending Approval',
    },
    'ar': {
      'stores': 'المتاجر',
      'pending_stores': 'متاجر تنتظر الموافقة',
    }
  };
}
