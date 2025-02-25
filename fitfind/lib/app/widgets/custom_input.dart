// import 'package:awesome_select/awesome_select.dart';
// import 'package:enefty_icons/enefty_icons.dart';
import 'package:icons_plus/icons_plus.dart';

import '/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// ================================================================
/// Custom Input
/// ================================================================

enum InputDecorationType {
  outlined,
  underlined,
}

class CustomInput extends StatefulWidget {
  CustomInput({
    super.key,
    this.icon,
    this.iconBackground,
    this.iconColor,
    this.isObscure,
    this.title,
    this.hint,
    this.hintColor,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.formValidator,
    this.isEnabled = true,
    this.minLines = 1,
    this.maxLines,
    this.onTap,
    this.autoFocus = false,
    this.isUpperTitle = false,
    this.backgroundColor,
    this.onChange,
    this.suffixIcon,
    this.maxLength,
    this.readOnly = false,
    this.inputFormatters,
    this.borderColor,
    this.isBoldHint,
  });

  IconData? icon;
  Color? iconBackground;
  bool? isBoldHint;
  Color? borderColor;
  Color? iconColor;
  bool? isObscure;
  String? title;
  String? hint;
  Color? hintColor;
  TextInputType? textInputType;
  TextInputAction? textInputAction;
  TextEditingController? controller;
  FormFieldValidator? formValidator;
  bool? isEnabled;
  bool? autoFocus = false;
  bool? isUpperTitle = true;
  int minLines;
  int? maxLines;
  int? maxLength;
  Function()? onTap;
  Function(String)? onChange;
  Color? backgroundColor;
  Widget? suffixIcon;
  bool? readOnly;
  List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isPasswordShow = true;

  showOrHidePassword() {
    print(isPasswordShow);
    setState(() {
      isPasswordShow = !isPasswordShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title?.isNotEmpty ?? false)
            if (widget.isUpperTitle ?? false)
              Text(
                widget.title.toString(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
          if (widget.title?.isNotEmpty ?? false)
            if (widget.isUpperTitle ?? false) const Gap(4),
          TextFormField(
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly ?? false,
            onChanged: widget.onChange,
            maxLength: widget.maxLength,
            autofocus: widget.autoFocus ?? false,
            onTap: widget.onTap,
            minLines: widget.isObscure ?? false ? 1 : widget.minLines,
            maxLines: widget.isObscure ?? false
                ? 1
                : widget.minLines == 1
                    ? 1
                    : widget.maxLines ?? widget.minLines + 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.formValidator,
            controller: widget.controller,
            keyboardType: (widget.textInputAction == TextInputAction.newline
                ? TextInputType.multiline
                : widget.textInputType),
            textInputAction: widget.textInputAction,
            cursorColor: theme.primaryColor,
            obscureText: widget.isObscure ?? false ? isPasswordShow : false,
            enabled: widget.isEnabled,
            decoration: customInputDecoration(
              titleColor: AppColors.primaryBlackColor,
              isBoldHint: widget.isBoldHint,
              borderColor: widget.borderColor,
              iconBackground: widget.iconBackground,
              readOnly: widget.readOnly,
              backgroundColor: widget.backgroundColor,
              hint: widget.hint,
              hintColor: AppColors.primaryBlackColor,
              icon: widget.icon,
              iconColor: AppColors.primaryBlackColor,
              suffixIcon: widget.suffixIcon ??
                  (widget.isObscure == true
                      ? IconButton(
                          splashRadius: 25,
                          onPressed: () {
                            showOrHidePassword();
                          },
                          icon: Icon(
                              isPasswordShow
                                  ? EvaIcons.eye_outline
                                  : EvaIcons.eye_off_outline,
                              color: AppColors.primaryBlackColor
                              // Get.theme.disabledColor,
                              ),
                        )
                      : null),
              title: (widget.isUpperTitle ?? false) ? null : widget.title,
            ),
          ),
        ],
      ),
    );
  }
}

/// ================================================================
/// Google input
/// ================================================================

class CustomGoogleInput extends StatelessWidget {
  const CustomGoogleInput({
    super.key,
    this.controller,
    this.itemClick,
    this.itemClickWithLatLng,
    this.title,
    this.hint,
    this.inputDecorationType = InputDecorationType.outlined,
    this.isDense,
  });

  final TextEditingController? controller;
  final Function(Prediction)? itemClickWithLatLng;
  final Function(Prediction)? itemClick;
  final String? title;
  final String? hint;
  final InputDecorationType? inputDecorationType;
  final bool? isDense;

  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller ?? TextEditingController(),
      googleAPIKey: API_KEY,
      debounceTime: 800,
      itemClick: (Prediction prediction) {
        if (controller == null) return;
        controller?.text = prediction.description ?? "";
        controller?.selection = TextSelection.fromPosition(
          TextPosition(
            offset: prediction.description?.length ?? 0,
          ),
        );

        itemClick?.call(prediction);
      },
      inputDecoration: customInputDecoration(
        title: title,
        hint: hint ?? "Enter your location",
        // isDense: isDense,
      ),
      getPlaceDetailWithLatLng: itemClickWithLatLng,
      isLatLngRequired: true,
    );
  }
}

/// ----------------------------------------------------------------

/// =================================================================
///  Custom Searchable Dropdown
/// =================================================================

// class CustomSearchableDropdown extends StatelessWidget {
//   CustomSearchableDropdown({
//     super.key,
//     required selectedValue,
//     this.listOfChoices,
//   });
//   List? listOfChoices;
//   var selectedValue;
//   @override
//   Widget build(BuildContext context) {
//     return SmartSelect(
//       isMultiChoice: false,
//       title: 'Category',
//       choiceItems: [
//         for (var item in listOfChoices?.toList() ?? [])
//           S2Choice(
//             value: item,
//             title: item.title,
//           ),
//       ],
//     );
//   }
// }

/// ================================================================
/// Phone Input
/// ================================================================

class CustomPhoneInput extends StatefulWidget {
  CustomPhoneInput({
    super.key,
    this.controller,
    required this.onCountryChange,
    this.formValidator,
    this.autoFocus,
    this.isRead = true,
    this.initialCountryCode,
    this.borderColor,
    this.isUpperTitle = true,
    this.textInputAction = TextInputAction.done,
  });
  TextEditingController? controller;
  FormFieldValidator? formValidator;
  Function(Country)? onCountryChange;
  String? initialCountryCode;
  bool? isRead = true;

  bool? autoFocus;
  Color? borderColor;
  final bool? isUpperTitle;
  final TextInputAction textInputAction;

  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isUpperTitle == true)
          Text(
            'Phone number',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          ),
        if (widget.isUpperTitle == true) const Gap(4),
        IntlPhoneField(
          validator: (value) {
            return null;
          },
          onCountryChanged: widget.onCountryChange,
          autofocus: widget.autoFocus ?? false,
          controller: widget.controller,
          flagsButtonPadding: const EdgeInsets.only(left: 5),
          dropdownIconPosition: IconPosition.trailing,
          cursorColor: Get.theme.disabledColor,
          keyboardType: TextInputType.phone,
          textInputAction: widget.textInputAction,
          initialValue: "",
          languageCode: Get.locale.toString() == "en_US" ? 'en' : 'es',
          pickerDialogStyle: PickerDialogStyle(
            countryNameStyle: const TextStyle(),
            countryCodeStyle: const TextStyle(
              debugLabel: AutofillHints.countryCode,
              leadingDistribution: TextLeadingDistribution.proportional,
              // locale: Locale('ar', 'SA')
            ),
            searchFieldInputDecoration: customInputDecoration(
              hint: 'Search country'.tr,
            ),
          ),
          dropdownIcon: const Icon(
            EvaIcons.arrow_ios_downward_outline,
            size: 18,
          ),
          initialCountryCode: widget.initialCountryCode ?? initialCountry,
          decoration: customInputDecoration(
              hint: 'Phone number'.tr,
              // suffixIcon: const Icon(Icons.call_outlined)),
              suffixIcon: null),
          enabled: widget.isRead ?? true,
        ),
      ],
    );
  }
}

/// ================================================================
/// Verification Input
/// ================================================================

class CustomVerificationInput extends StatelessWidget {
  CustomVerificationInput({
    super.key,
    required this.onSubmitted,
    this.onChange,
    this.textEditingController,
  });

  Function(String) onSubmitted;
  Function(String)? onChange;
  TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return PinCodeTextField(
      appContext: context,
      length: 4,
      animationType: AnimationType.scale,
      cursorColor: theme.primaryColor,
      // cursorHeight: 20,
      // backgroundColor: AppColors.white,
      controller: textEditingController,

      // boxShadows: const [
      //   BoxShadow(
      //     color: AppColors.blue,
      //   ),
      // ],
      textStyle: TextStyle(
        color: Get.theme.primaryColor,
        // theme.primaryColor
      ),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        activeColor: Get.theme.primaryColor,
        inactiveColor: Color(0xFFF4F6FA),
        selectedColor: Get.theme.primaryColor,
        fieldHeight: 53,
        // fieldWidth: 50,
        activeFillColor: Get.theme.primaryColor,
        inactiveFillColor: theme.splashColor.withOpacity(.2),
        selectedFillColor: Get.theme.scaffoldBackgroundColor,
      ),
      obscureText: false,
      obscuringCharacter: "*",

      enableActiveFill: false,
      keyboardType: TextInputType.number,
      autoFocus: true,
      onSubmitted: onSubmitted,
      onCompleted: onSubmitted,
      beforeTextPaste: (text) {
        return true;
      },
      onChanged: onChange ?? (String value) {},
    );
  }
}

/// ================================================================
/// Custom Input Decoration
/// ================================================================

InputDecoration customInputDecoration({
  Color? backgroundColor,
  IconData? icon,
  Color? iconBackground,
  Color? iconColor,
  Widget? suffixIcon,
  String? title,
  String? hint,
  Color? hintColor,
  bool? readOnly,
  bool? isBoldHint,
  Color? borderColor,
  Color? titleColor,
}) {
  var theme = Get.theme;

  return InputDecoration(
      counterText: "",
      errorMaxLines: 3,
      fillColor: backgroundColor ?? theme.cardColor,
      contentPadding: const EdgeInsets.all(kPadding / 2),
      prefixIcon: icon == null
          ? null
          : Container(
              margin: const EdgeInsets.only(right: 3),
              decoration: BoxDecoration(
                color: iconBackground,
                // color: iconBackground ??
                //     iconColor?.withOpacity(.2) ??
                //     Get.theme.primaryColor.withOpacity(.2),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kBorderRadius),
                  bottomLeft: Radius.circular(kBorderRadius),
                ),
              ),
              child: Icon(
                icon,
                color: iconColor ?? theme.disabledColor,
              ),
            ),
      // label: widget.title == null ? null : Text(widget.title ?? ""),
      suffixIcon: suffixIcon,
      labelStyle: TextStyle(
        color: titleColor ?? theme.disabledColor,
      ),
      floatingLabelStyle: TextStyle(
        color: theme.primaryColor,
      ),
      labelText: title,
      hintText: hint,
      alignLabelWithHint: true,
      hintStyle: theme.textTheme.bodySmall!.copyWith(
          color: hintColor,
          fontWeight: isBoldHint != null ? FontWeight.bold : null),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: BorderSide(
          color: borderColor ?? theme.dividerColor,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: BorderSide(
          color: borderColor ?? Colors.black12,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: BorderSide(
          color: readOnly == true ? theme.dividerColor : theme.primaryColor,
          width: 1,
        ),
      )
      //  UnderlineInputBorder(
      //   borderSide: BorderSide(
      //     color: AppColors.greyBackground,
      //   ),
      // ),
      );
}
