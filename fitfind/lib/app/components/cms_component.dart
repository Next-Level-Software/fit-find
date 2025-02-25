import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../utils/spaces.dart';
import '/app/constants/app_constants.dart';

class CMSModal {
  CMSModal._();
  static termsAndConditionModel() {
    Dialog errorDialog = Dialog(
      insetPadding: const EdgeInsets.all(kPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: SizedBox(
        width: Get.width * .95,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(Get.context!);
                      },
                    ),
                    Expanded(
                      child: Text(
                        'Terms and conditions'.tr,
                        textAlign: TextAlign.center,
                        style: Get.theme.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SpaceH12(),
                Html(
                  data: """<p>
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
</p>
""",
                )
              ],
            ),
          ),
        ),
      ),
    );
    showDialog(
        context: Get.context!,
        useSafeArea: true,
        builder: (BuildContext context) => errorDialog);
  }

  static privacyPolicyModel() {
    Dialog errorDialog = Dialog(
      insetPadding: const EdgeInsets.all(kPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: SizedBox(
        width: Get.width * .95,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centers the Row's content
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(
                            Get.context!); // Custom back button behavior
                      },
                    ),
                    Expanded(
                      child: Text(
                        'Privacy policy'.tr, // Your centered title
                        textAlign: TextAlign.center,
                        style: Get.theme.textTheme
                            .bodyLarge, // Ensures the title is centered
                      ),
                    ),
                    const SizedBox(
                        width:
                            48), // Placeholder to balance the back button space
                  ],
                ),
                const SpaceH12(),
                Html(
                  data: """<p>
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
</p>
""",
                )
              ],
            ),
          ),
        ),
      ),
    );
    showDialog(
        context: Get.context!,
        useSafeArea: true,
        builder: (BuildContext context) => errorDialog);
  }
}
