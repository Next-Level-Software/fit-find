
import '/app/components/have_account.dart';
import 'package:flutter/material.dart';

import 'cms_component.dart';

class privacyPolicy extends StatelessWidget {
  privacyPolicy({super.key, this.onPressed, this.isAccount});
  Function()? onPressed;
  bool? isAccount = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        termAndPolicy(),
        isAccount != true
            ? HaveAccount(
                text1: "Already have an account?",
                text2: "Log In",
                color: Colors.black,
                linkColor: Colors.black,
                onPressed: onPressed,
              )
            : SizedBox(),
      ],
    );
  }

  Row termAndPolicy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0)),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 0),
            ),
          ),
          onPressed: () {
            CMSModal.termsAndConditionModel();
          },
          child: Text(
            "Terms to Use",
            style: TextStyle(
              fontSize: 12,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFFED1C24),
              // fontWeight: FontWeight.bold,
              color: Color(0xFFED1C24),
            ),
          ),
        ),
        Text(" and "),
        TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0)),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 0),
            ),
          ),
          onPressed: () {
            CMSModal.privacyPolicyModel();
          },
          child: Text(
            "Privacy Policy",
            style: TextStyle(
              fontSize: 12,

              decoration: TextDecoration.underline,
              decorationColor: Color(0xFFED1C24),
              // fontWeight: FontWeight.bold,
              color: Color(0xFFED1C24),
            ),
          ),
        ),
      ],
    );
  }
}
