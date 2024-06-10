import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.controller,
    this.keyboardType,
    this.initialValue,
    this.label,
    this.labelStyle,
    this.hint,
    this.isPassword = false,
    this.isRequired = false,
    this.requiredText = "Input type tidak boleh kosong",
    this.maxLength,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.inputFormatters,
    this.prefix,
    this.readOnly = false,
    this.style,
    this.minLines,
    this.maxLines,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.onChange,
    this.alignLabelWithHint = false,
    this.borderRadius,
    this.borderColor,
    this.inputAction,
    this.hintStyle,
    this.enabled = true,
    this.validator,
    this.contentPadding,
    this.errorFontSize,
    this.focusedBorderColor,
    this.isFilled,
    this.backgroundColor,
    this.isDense,
    this.onTap,
    this.autoFocus,
    this.prefixIconConstraints,
    this.height,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? label;
  final String? hint;
  final bool isPassword;
  final bool isRequired;
  final String requiredText;
  final int? maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final bool readOnly;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final int? minLines;
  final int? maxLines;
  final double? borderRadius;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Function(String)? onChange;
  final bool? alignLabelWithHint;
  final Color? borderColor;
  final TextInputAction? inputAction;
  final bool enabled;
  final String? Function(String?)? validator;
  final EdgeInsets? contentPadding;
  final double? errorFontSize;
  final Color? focusedBorderColor;
  final bool? isFilled;
  final Color? backgroundColor;
  final bool? isDense;
  final void Function()? onTap;
  final bool? autoFocus;
  final BoxConstraints? prefixIconConstraints;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.h,
      child: TextFormField(
        key: key,
        autofocus: autoFocus ?? false,
        onTap: onTap,
        keyboardType: keyboardType,
        obscureText: isPassword,
        textInputAction: inputAction,
        maxLength: maxLength,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        controller: controller,
        readOnly: readOnly,
        enabled: enabled,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon,
          isDense: isDense,
          filled: isFilled,
          fillColor: backgroundColor,
          errorMaxLines: 2,
          errorText: errorText == null
              ? null
              : errorText?.isEmpty == true
                  ? null
                  : errorText,
          errorStyle: redTextStyle.copyWith(
            fontSize: errorFontSize ?? 14.sp,
          ),
          floatingLabelBehavior: floatingLabelBehavior,
          hintText: hint,
          labelText: label,
          alignLabelWithHint: alignLabelWithHint,
          labelStyle: labelStyle ??
              blackTextStyle.copyWith(
                fontSize: 13.sp,
                color: errorText?.isNotEmpty == true ? ColorStyle.r5 : ColorStyle.primary,
              ),
          hintStyle: hintStyle ??
              greyTextStyle.copyWith(
                fontSize: 13.sp,
              ),
          counterText: "",
          contentPadding: contentPadding,
          suffixIcon: suffixIcon,
          prefix: prefix,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? const Color(0xffBBBDC7)),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.r),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? const Color(0xffBBBDC7)),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.r),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  focusedBorderColor ?? (readOnly ? const Color(0xffBBBDC7) : ColorStyle.primary),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.r),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorStyle.r5),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.r),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorStyle.r5),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.r),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? const Color(0xffBBBDC7)),
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 8.r),
            ),
          ),
          // suffixIconConstraints: BoxConstraints(minHeight: 24.h, minWidth: 24.w),
        ),
        onChanged: (text) {
          // controller?.text = text;
          onChange?.call(text);
        },
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: style ??
            blackTextStyle.copyWith(
              fontSize: 13.sp,
            ),
      ),
    );
  }
}
