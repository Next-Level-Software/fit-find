import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PickupAndDestinationWidget extends StatelessWidget {
  const PickupAndDestinationWidget({
    super.key,
    required this.pickupLocation,
    required this.destination,
  });

  final String pickupLocation;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(12),
            // Container(
            //   height: 12,
            //   width: 12,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Get.theme.shadowColor,
            //       width: 3,
            //     ),
            //     shape: BoxShape.circle,
            //   ),
            // ),
            const Icon(
              Icons.gps_fixed_outlined,
              size: 18,
            ),
            DottedLine(
              dashGapLength: 3,
              direction: Axis.vertical,
              lineLength: 45,
              dashLength: 2,
              lineThickness: 2,
              dashColor: Get.theme.shadowColor,
            ),
            // Container(
            //   height: 12,
            //   width: 12,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Get.theme.shadowColor,
            //       width: 3,
            //     ),
            //     shape: BoxShape.circle,
            //   ),
            // ),
            const Icon(
              Icons.location_pin,
              size: 18,
            ),
          ],
        ),
        const Gap(8),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pickup'.tr,
                style: Get.textTheme.labelMedium,
              ),
              const Gap(14),
              Text(
                pickupLocation,
                style: Get.textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Text(
                'Destination'.tr,
                style: Get.textTheme.labelMedium,
              ),
              const Gap(4),
              Text(
                destination,
                style: Get.textTheme.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
