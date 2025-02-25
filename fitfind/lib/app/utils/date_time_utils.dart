class DateTimeUtils {
  DateTimeUtils._();
  static DateTime now = DateTime.now();
  static Duration remainingDuration(DateTime targetDate) =>
      targetDate.difference(now);

  static isTimeExceeded(DateTime targetDate) =>
      (remainingDuration(targetDate).isNegative) ||
      (targetDate.year == now.year &&
          targetDate.month == now.month &&
          targetDate.day == now.day);

  static String calculateRemainingTime(DateTime targetDate) {
    if (targetDate.year == now.year &&
        targetDate.month == now.month &&
        targetDate.day == now.day) {
      return 'Today';
    }

    if (isTimeExceeded(targetDate)) {
      // The target date has already passed
      Duration exceededDuration = now.difference(targetDate);
      String exceededTime = _formatDuration(exceededDuration);
      return exceededTime;
    } else {
      // The target date is in the future
      String remainingTime = _formatDuration(remainingDuration(targetDate));
      return remainingTime;
    }
  }

  static String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    int days = duration.inDays;
    int months = days ~/ 30;
    days = days % 30;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);

    if (months > 0 && days > 0) {
      return '${months}mo, ${days}d';
    } else if (months > 0) {
      return '${months}mo, ${hours}h';
    } else if (days > 0) {
      return '${days}d, ${hours}h';
    } else {
      return '${hours}h, ${minutes}m';
    }
  }

  static bool isAdult(DateTime dateOfBirth) {
    final now = DateTime.now();
    final age = now.difference(dateOfBirth).inDays ~/ 365;

    return age >= 18;
  }
}
