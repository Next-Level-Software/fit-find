import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import 'custom_input.dart';

class CustomDropdownInput extends StatefulWidget {
  CustomDropdownInput({
    super.key,
    this.icon,
    this.iconColor,
    this.title,
    this.hint,
    this.hintColor,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.formValidator,
    this.isUpperTitle = false,
    this.backgroundColor,
    this.borderColor,
    this.selectedItem,
    this.onChange,
    this.suffixIcon,
    this.readOnly,
    this.dropDownList,
    this.enableSearch,
  });

  IconData? icon;
  Color? iconColor;
  String? title;
  String? hint;
  String? selectedItem;
  Color? hintColor;
  TextInputType? textInputType;
  TextInputAction? textInputAction;
  SingleValueDropDownController? controller;
  FormFieldValidator? formValidator;
  bool? isUpperTitle = true;
  Function(dynamic)? onChange;
  Color? backgroundColor, borderColor;
  Widget? suffixIcon;
  bool? readOnly;
  List<DropDownValueModel>? dropDownList;
  bool? enableSearch;

  @override
  State<CustomDropdownInput> createState() => _CustomDropdownInputState();
}

class _CustomDropdownInputState extends State<CustomDropdownInput> {
  bool isPasswordShow = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.isUpperTitle ?? false)
          Text(
            widget.title.toString(),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        if (widget.isUpperTitle ?? false) Gap(8),
        DropDownTextField(
          // readOnly: widget.readOnly ?? false,
          isEnabled: widget.readOnly ?? true,
          onChanged: widget.onChange,
    
          dropDownList: widget.dropDownList ?? [],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          listTextStyle: Get.textTheme.bodyMedium,
          validator: widget.formValidator,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          dropdownRadius: kBorderRadius,
          enableSearch: widget.enableSearch ?? false,
          dropDownIconProperty: IconProperty(
              color: AppColors.primaryBlackColor,
              icon: widget.title == 'Specialization certificate'
                  ? Icons.upload_file_outlined
                  : null),
          clearOption: false,
          initialValue: (widget.selectedItem?.isEmpty ?? true)
              ? null
              : widget.selectedItem,
          textFieldDecoration: customInputDecoration(
            titleColor: AppColors.primaryBlackColor,
            readOnly: widget.readOnly,
            backgroundColor: widget.backgroundColor,
            hint: widget.hint,
            hintColor: widget.hintColor,
            borderColor: widget.borderColor ?? Colors.transparent,
            icon: widget.icon,
            iconColor: widget.iconColor,
            suffixIcon: widget.suffixIcon,
            title: (widget.isUpperTitle ?? false) ? null : widget.title,
          ),
        ),
      ],
    );
  }
}

class CustomMultiDropdownInput extends StatefulWidget {
  CustomMultiDropdownInput({
    super.key,
    this.icon,
    this.iconColor,
    this.title,
    this.hint,
    this.hintColor,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.formValidator,
    this.isUpperTitle = false,
    this.backgroundColor,
    this.selectedItem,
    this.onChange,
    this.suffixIcon,
    this.readOnly = false,
    this.dropDownList,
    this.enableSearch,
  });

  IconData? icon;
  Color? iconColor;
  String? title;
  String? hint;
  dynamic selectedItem;
  Color? hintColor;
  TextInputType? textInputType;
  TextInputAction? textInputAction;
  MultiValueDropDownController? controller;
  FormFieldValidator? formValidator;
  bool? isUpperTitle = true;
  Function(dynamic)? onChange;
  Color? backgroundColor;
  Widget? suffixIcon;
  bool? readOnly;
  List<DropDownValueModel>? dropDownList;
  bool? enableSearch;

  @override
  State<CustomMultiDropdownInput> createState() =>
      _CustomMultiDropdownInputState();
}

class _CustomMultiDropdownInputState extends State<CustomMultiDropdownInput> {
  bool isPasswordShow = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.isUpperTitle ?? false)
          Text(
            widget.title.toString(),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        if (widget.isUpperTitle ?? false) const Gap(8),
        DropDownTextField.multiSelection(
          displayCompleteItem: true,
          onChanged: widget.onChange,
          dropDownIconProperty: IconProperty(
            color: AppColors.primaryBlackColor,
          ),
          dropDownList: widget.dropDownList ?? [],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.formValidator,
          controller: widget.controller,
          dropdownRadius: kBorderRadius,
          listTextStyle: Get.textTheme.bodySmall,

          submitButtonTextStyle: const TextStyle(color: Colors.white),
          clearOption: true,
          // initialValue: ["termite", "ant"],
          initialValue: (widget.selectedItem?.isEmpty ?? true)
              ? null
              : widget.selectedItem,

          textFieldDecoration: customInputDecoration(
            readOnly: widget.readOnly,
            backgroundColor: widget.backgroundColor,
            hint: widget.hint,
            hintColor: widget.hintColor,
            icon: widget.icon,
            iconColor: widget.iconColor,
            suffixIcon: widget.suffixIcon,
            title: (widget.isUpperTitle ?? false) ? null : widget.title,
          ),
        ),
      ],
    );
  }
}

/// ================================================================
/// Custom Document Input
/// ================================================================

class CustomDocumentInput extends StatelessWidget {
  const CustomDocumentInput({
    super.key,
    this.title,
    this.hint,
    this.filePath,
    this.fileName,
    this.onRemoveTap,
    this.onTap,
    this.suffixIcon,
  });

  final String? title;
  final String? hint;
  final String? filePath;
  final String? fileName;
  final Function()? onRemoveTap;
  final Function()? onTap;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      readOnly: true,
      title: title,
      isUpperTitle: true,
      icon: filePath == null
          ? Icons.file_copy_outlined
          : Icons.cloud_upload_rounded,
      iconColor: filePath == null ? null : AppColors.primaryBlackColor,
      hintColor: filePath == null ? null : AppColors.primaryBlackColor,
      hint: fileName ?? (hint ?? "Choose a file".tr),
      onTap: onTap,
      // onTap: controller.onInsuranceUpload,
      suffixIcon: filePath == null
          ? IconButton(
              onPressed: onTap,
              icon: Icon(
                suffixIcon ?? Icons.upload_rounded,
                color: Get.theme.primaryColor,
              ),
            )
          : IconButton(
              onPressed: onRemoveTap,
              tooltip: "Remove".tr,
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
    );
  }
}
