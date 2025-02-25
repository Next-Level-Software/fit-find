import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
// import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/spaces.dart';
import '/app/constants/app_constants.dart';

class CustomWeekCalender extends StatefulWidget {
  /// get the list of DateTime of first current week
  final Function(List<DateTime>) onInit;

  /// get the list of current data
  final List<dynamic> currentWeekData;

  /// get the list of DateTime on current week
  final Function(List<DateTime>)? onWeekChange;

  /// get DateTime on any date click
  final Function(DateTime)? onDateChange;

  /// disable next and back button if true
  final bool? isLoading;

  /// default selected date
  final DateTime selectedDate;

  final bool? onlyCurrentWeek;

  const CustomWeekCalender({
    super.key,
    required this.onInit,
    required this.currentWeekData,
    this.onWeekChange,
    this.onDateChange,
    this.isLoading,
    required this.selectedDate,
    this.onlyCurrentWeek,
  });

  @override
  State<CustomWeekCalender> createState() => _CustomWeekCalenderState();
}

class _CustomWeekCalenderState extends State<CustomWeekCalender> {
  CarouselSliderController carouselController = CarouselSliderController();

  DateTime today = DateTime.now();
  DateTime startDate = DateTime.now();

  DateTime? selectedDate;
  List<DateTime> currentWeek = [];
  int currentWeekIndex = 0;

  List<List<DateTime>> listOfWeeks = [];
  List<List<DateTime>> listOfPreviousWeeks = [];

  late DateTime startOfCurrentWeek;
  late DateTime endOfCurrentWeek;

  @override
  void initState() {
    selectedDate = widget.selectedDate;
    print("---------_ $selectedDate _----------");

    initCalender();
    super.initState();
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  initCalender() {
    // var date = widget.selectedDate ?? DateTime.now();
    startDate = widget.selectedDate;
    selectedDate = widget.selectedDate;

    DateTime startOfStartedDate =
        getDate(startDate.subtract(Duration(days: startDate.weekday % 7)));

    startOfCurrentWeek = getDate(
      today.subtract(
        Duration(days: today.weekday % 7),
      ),
    );

    endOfCurrentWeek = getDate(
      getDate(
        today.subtract(
          Duration(days: today.weekday % 7),
        ),
      ).add(
        Duration(days: 6),
      ),
    );

    // List<DateTime> minus3Days = [];
    // List<DateTime> add3Days = [];
    // for (int index = 0; index < 3; index++) {
    //   DateTime minusDate = today.add(Duration(days: -(index + 1)));
    //   minus3Days.add(minusDate);
    //   DateTime addDate = today.add(Duration(days: (index + 1)));
    //   add3Days.add(addDate);
    // }
    // currentWeek.addAll(minus3Days.reversed.toList());
    // currentWeek.add(today);
    // currentWeek.addAll(add3Days);

    currentWeek.add(startOfStartedDate);
    for (int index = 0; index < 6; index++) {
      DateTime addDate = startOfStartedDate.add(Duration(days: (index + 1)));
      currentWeek.add(addDate);
    }

    print("============");
    print("currentWeek: ${currentWeek}");
    print("============");

    listOfWeeks.add(currentWeek);

    // Adding first week
    listOfPreviousWeeks.add(currentWeek);

    getMorePreviousWeeks();
    getMoreNextWeek();
    currentWeekIndex++;

    List<DateTime> previousWeek = [];
    List<DateTime> nextWeek = [];

    previousWeek = listOfPreviousWeeks[currentWeekIndex + 1];
    nextWeek = listOfPreviousWeeks[0];

    previousWeek.addAll(currentWeek.toList());
    previousWeek.addAll(nextWeek.toList());

    print("---------------");
    print("previousWeek: ${previousWeek}");
    print("---------------");

    // Logger().wtf("Start Date: $startDate");
    // Logger().wtf("startOfCurrentWeek: $startOfCurrentWeek");
    // Logger().wtf("endOfCurrentWeek: $endOfCurrentWeek");

    // Logger().w("listOfWeeks: $listOfWeeks");
    // Logger().w("listOfPreviousWeeks: $listOfPreviousWeeks");

    // if (startDate.isBefore(startOfCurrentWeek)) {
    //   Logger().wtf(
    //     "start date is less: ${startDate.toIso8601String()}\nAdd more dates",
    //   );
    //   currentWeekIndex = currentWeekIndex + 1;
    //   getMoreNextWeek();
    // } else {
    //   Logger().wtf("No need more data");
    // }

    widget.onInit.call(previousWeek.toList());

    setState(() {});
  }

  getMorePreviousWeeks() {
    List<DateTime> minus7Days = [];
    DateTime startFrom = listOfWeeks.isEmpty
        ? DateTime.now()
        : listOfWeeks[currentWeekIndex].isEmpty
            ? DateTime.now()
            : listOfWeeks[currentWeekIndex].first;

    for (int index = 0; index < 7; index++) {
      DateTime minusDate = startFrom.add(Duration(days: -(index + 1)));
      minus7Days.add(minusDate);
    }
    listOfWeeks.add(minus7Days.reversed.toList());

    // Adding other week
    listOfPreviousWeeks.add(minus7Days.reversed.toList());
    setState(() {});
  }

  getMoreNextWeek() {
    Logger().i("currentWeekIndex: $currentWeekIndex");

    List<DateTime> add7Days = [];
    DateTime startFrom = listOfWeeks.isEmpty
        ? DateTime.now()
        : listOfWeeks[currentWeekIndex].isEmpty
            ? DateTime.now()
            : listOfWeeks[currentWeekIndex].last;

    print("startFrom: $startFrom");

    for (int index = 0; index < 7; index++) {
      DateTime addedDate = startFrom.add(Duration(days: (index + 1)));
      add7Days.add(addedDate);
    }
    print("add7Days:$add7Days");
    listOfWeeks.insert(0, add7Days.toList());

    // Adding other week
    listOfPreviousWeeks.insert(0, add7Days.toList());

    setState(() {});
  }

  onDateSelect(DateTime date) {
    selectedDate = date;
    print("---------_ $selectedDate _----------");

    widget.onDateChange?.call(selectedDate!);
    setState(() {});
  }

  onBackClick() {
    carouselController.nextPage();
  }

  onNextClick() {
    // print('----, ${currentWeekIndex} ---');
    // int isTodayFound = listOfWeeks[currentWeekIndex].indexWhere((element) =>
    //     (element.day == today.day) &&
    //     (element.month == today.month) &&
    //     (element.year == today.year));
    // if (currentWeekIndex == 0) {
    //   print("------");
    //   // if (isTodayFound == -1) {
    //   print('----------------');
    //   print('------Else------');
    //   print('----------------');
    //   getMoreNextWeek();
    //   currentWeekIndex++;
    //   var next = listOfWeeks[currentWeekIndex];
    //   widget.onWeekChange?.call(next);
    //   // }
    // }
    carouselController.previousPage();
  }

  onWeekChange(index) {
    if (currentWeekIndex > index) {
      // Next
      print("Next ------------");
      // if (startDate.isBefore(startOfCurrentWeek)) {
      //   Logger().wtf(
      //     "start date is less: ${startDate.toIso8601String()}\nAdd more dates",
      //   );

      //   getMoreNextWeek();
      // } else {
      //   Logger().wtf("No need more data");
      // }
    }

    if (currentWeekIndex < index) {
      // Back
      print("Back ------------");
    }

    print("index: $index");
    print("currentWeekIndex: $currentWeekIndex");
    print("listOfWeeks Length: ${listOfWeeks.length}");

    currentWeekIndex = index;
    currentWeek = listOfWeeks[currentWeekIndex];

    if (currentWeekIndex + 1 == listOfWeeks.length) {
      getMorePreviousWeeks();
      var previous = listOfWeeks[currentWeekIndex + 1];
      widget.onWeekChange?.call(previous);
    } else {
      //
      print("------------- NExt");
    }

    if (index == 0) {
      // getMoreNextWeek();
      // carouselController.nextPage();
      // var next = listOfWeeks[0];
      // print("$next ---------");
      // widget.onWeekChange?.call(next);
    }

    setState(() {});
  }

  // =================

  isNextEnabled() {
    return listOfWeeks[currentWeekIndex].last.isBefore(DateTime.now());
  }

  isCurrentYear() {
    return DateFormat('yyyy').format(currentWeek[0]) ==
        DateFormat('yyyy').format(today);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // double boxHeight = Get.width / 7;
    double boxHeight = 70.h;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: currentWeek.isEmpty
              ? SizedBox()
              : Container(
                  color: Get.theme.cardColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isCurrentYear()
                                ? DateFormat('MMMM').format(
                                    currentWeek[0],
                                  )
                                : DateFormat('MMMM yyyy').format(
                                    currentWeek[0],
                                  ),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge!.copyWith(),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (widget.onlyCurrentWeek == true ||
                                    widget.isLoading == true)
                                ? null
                                : onBackClick,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new,
                                  color: (widget.onlyCurrentWeek == true ||
                                          widget.isLoading == true)
                                      ? AppColors.grey
                                      : AppColors.grey,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              onNextClick();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SpaceH4(),
                      CarouselSlider(
                        controller: carouselController,
                        items: [
                          if (listOfWeeks.isNotEmpty)
                            for (int ind = 0; ind < listOfWeeks.length; ind++)
                              Container(
                                height: boxHeight,
                                width: Get.width,
                                // color: AppColors.grey,
                                child: Row(
                                  children: [
                                    for (int weekIndex = 0;
                                        weekIndex < listOfWeeks[ind].length;
                                        weekIndex++)
                                      dateCard(ind, weekIndex, theme),
                                  ],
                                ),
                              ),
                        ],
                        options: CarouselOptions(
                          initialPage: currentWeekIndex,
                          scrollPhysics: (widget.isLoading == true)
                              ? NeverScrollableScrollPhysics()
                              : ClampingScrollPhysics(),
                          height: boxHeight,
                          viewportFraction: 1,
                          enableInfiniteScroll: false,
                          reverse: true,
                          onPageChanged: (index, reason) {
                            onWeekChange(index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        widget.isLoading == true
            ? LinearProgressIndicator(
                color: AppColors.primaryColor,
                backgroundColor: AppColors.grey50,
              )
            : SizedBox(
                height: 4,
              ),
      ],
    );
  }

  Widget dateCard(
    int ind,
    int weekIndex,
    ThemeData theme,
  ) {
    var index = widget.currentWeekData.indexWhere(
      (element) {
        return element.date == listOfWeeks[ind][weekIndex];
      },
    );

    return Expanded(
      child: GestureDetector(
        onTap: () {
          onDateSelect(
            listOfWeeks[ind][weekIndex],
          );
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: DateFormat('dd-MM-yyyy')
                          .format(listOfWeeks[ind][weekIndex]) ==
                      DateFormat('dd-MM-yyyy').format(selectedDate ?? today)
                  ? Get.theme.progressIndicatorTheme.color
                  : index >= 0
                      ? Get.theme.progressIndicatorTheme.color
                      : Colors.transparent,
              shape: BoxShape.circle),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat(
                      'EEE',
                    ).format(
                      listOfWeeks[ind][weekIndex],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: DateFormat('dd-MM-yyyy')
                                  .format(listOfWeeks[ind][weekIndex]) ==
                              DateFormat('dd-MM-yyyy')
                                  .format(selectedDate ?? today)
                          ? Get.theme.cardColor // Selected date color
                          : Get.theme
                              .shadowColor, // Default color for other dates
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        Text(
                          "${listOfWeeks[ind][weekIndex].day}",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.labelSmall!.copyWith(
                            color: DateFormat('dd-MM-yyyy')
                                        .format(listOfWeeks[ind][weekIndex]) ==
                                    DateFormat('dd-MM-yyyy')
                                        .format(selectedDate ?? today)
                                ? Get.theme.cardColor // Selected date color
                                : Get.theme.shadowColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (DateFormat('dd-MM-yyyy')
                      .format(listOfWeeks[ind][weekIndex]) ==
                  DateFormat('dd-MM-yyyy').format(today))
                Positioned(
                  right: -7,
                  bottom: 22,
                  child: Icon(
                    size: 12,
                    Icons.calendar_month,
                    color: DateFormat('dd-MM-yyyy')
                                .format(listOfWeeks[ind][weekIndex]) !=
                            DateFormat('dd-MM-yyyy')
                                .format(selectedDate ?? today)
                        ? Get.theme.primaryColor
                        : Get.theme.cardColor,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
