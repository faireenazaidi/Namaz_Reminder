import 'package:intl/intl.dart';

class PrayerDurationCalculator {
  // Function to find today's prayer timings from the listData based on today's Gregorian date
  static Map<String, dynamic> getTimingsForToday(List listData) {
    // Get today's date in DD-MM-YYYY format
    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    // Find the matching entry based on the Gregorian date
    for (var entry in listData) {
      String gregorianDate = entry['date']['gregorian']['date'];

      if (gregorianDate == todayDate) {
        return entry;
      }
    }

    // If no matching entry is found, throw an exception
    throw Exception('No prayer timings found for today.');
  }

  // Function to find the current prayer based on the time
  static String getCurrentPrayer(Map<String, dynamic> timings, DateTime currentTime) {
    // Parse timings and match with the current time
    DateTime fajrStart = _parseTime(timings['timings']['Fajr'], currentTime);
    DateTime sunriseEnd = _parseTime(timings['timings']['Sunrise'], currentTime);
    DateTime dhuhrStart = _parseTime(timings['timings']['Dhuhr'], currentTime);
    DateTime asrStart = _parseTime(timings['timings']['Asr'], currentTime);
    DateTime sunsetEnd = _parseTime(timings['timings']['Sunset'], currentTime);
    DateTime maghribStart = _parseTime(timings['timings']['Maghrib'], currentTime);
    DateTime ishaStart = _parseTime(timings['timings']['Isha'], currentTime);
    DateTime midnightEnd = _parseTime(timings['timings']['Midnight'], currentTime);

    if (_isBetween(currentTime, fajrStart, sunriseEnd)) {
      return 'Fajr';
    } else if (_isBetween(currentTime, dhuhrStart, asrStart)) {
      return 'Dhuhr';
    } else if (_isBetween(currentTime, asrStart, sunsetEnd)) {
      return 'Asr';
    }
    // else if (_isBetween(currentTime, sunsetEnd, maghribStart)) {
    //   return 'Maghrib';
    // }
    else if (_isBetween(currentTime, maghribStart, ishaStart)) {
      return 'Maghrib';
    } else if (_isBetween(currentTime, ishaStart, midnightEnd)) {
      return 'Isha';
    } else {
      return 'No prayer ongoing'; // If it's between prayers, handle accordingly
    }
  }

  // Function to calculate the remaining time and percentage for the current or upcoming prayer
  static Map<String, dynamic> calculatePrayerTimeInfo(Map<String, dynamic> timings, String currentPrayer, DateTime currentTime) {
    DateTime prayerEndTime;
    DateTime prayerStartTime;

    // Get the prayer's start and end times
    switch (currentPrayer) {
      case 'Fajr':
        prayerStartTime = _parseTime(timings['timings']['Fajr'], currentTime);
        prayerEndTime = _parseTime(timings['timings']['Sunrise'], currentTime);
        break;
      case 'Dhuhr':
        prayerStartTime = _parseTime(timings['timings']['Dhuhr'], currentTime);
        prayerEndTime = _parseTime(timings['timings']['Asr'], currentTime);
        break;
      case 'Asr':
        prayerStartTime = _parseTime(timings['timings']['Asr'], currentTime);
        prayerEndTime = _parseTime(timings['timings']['Sunset'], currentTime);
        break;
      case 'Maghrib':
        prayerStartTime = _parseTime(timings['timings']['Maghrib'], currentTime);
        prayerEndTime = _parseTime(timings['timings']['Isha'], currentTime);
        break;
      case 'Isha':
        prayerStartTime = _parseTime(timings['timings']['Isha'], currentTime);
        prayerEndTime = _parseTime(timings['timings']['Midnight'], currentTime);
        break;
      default:
        throw Exception('Unknown prayer name.');
    }

    // If the current time is after the prayer end time, return
    if (currentTime.isAfter(prayerEndTime)) {
      throw Exception('The current prayer time has already passed.');
    }

    // Calculate the total duration of the prayer
    Duration totalDuration = prayerEndTime.difference(prayerStartTime);

    // Calculate the time passed so far
    Duration timePassed = currentTime.difference(prayerStartTime);

    // Check if totalDuration is valid (greater than zero) before calculating percentage
    if (totalDuration.inMilliseconds <= 0) {
      throw Exception('Invalid prayer time duration.');
    }

    // Calculate the percentage of time passed (as an integer)
    int percentagePassed = ((timePassed.inMilliseconds / totalDuration.inMilliseconds) * 100).round();

    // Calculate the remaining percentage
    int percentageRemaining = 100 - percentagePassed;

    return {
      'remainingTime': prayerEndTime.difference(currentTime),
      'percentagePassed': percentagePassed,
      'percentageRemaining': percentageRemaining
    };
  }

  // Function to find the upcoming prayer if there is a gap
  static Map<String, dynamic> getUpcomingPrayer(Map<String, dynamic> timings, DateTime currentTime) {
    // Get all prayer times and sort them
    List<Map<String, DateTime>> prayerTimes = [
      {'Fajr': _parseTime(timings['timings']['Fajr'], currentTime)},
      {'Dhuhr': _parseTime(timings['timings']['Dhuhr'], currentTime)},
      {'Asr': _parseTime(timings['timings']['Asr'], currentTime)},
      {'Maghrib': _parseTime(timings['timings']['Maghrib'], currentTime)},
      {'Isha': _parseTime(timings['timings']['Isha'], currentTime)},
      {'Midnight': _parseTime(timings['timings']['Midnight'], currentTime)}
    ];

    // Sort prayer times by the time of day
    prayerTimes.sort((a, b) => a.values.first.compareTo(b.values.first));

    // Find the next upcoming prayer
    for (var prayerTime in prayerTimes) {
      var prayerName = prayerTime.keys.first;
      DateTime prayerTimeValue = prayerTime.values.first;

      // If the prayer is in the future, calculate remaining time and percentage
      if (currentTime.isBefore(prayerTimeValue)) {
        // Calculate the remaining time for the upcoming prayer
        Duration remainingTime = prayerTimeValue.difference(currentTime);

        // Get the end time of the upcoming prayer
        DateTime nextPrayerEndTime;
        switch (prayerName) {
          case 'Fajr':
            nextPrayerEndTime = _parseTime(timings['timings']['Sunrise'], currentTime);
            break;
          case 'Dhuhr':
            nextPrayerEndTime = _parseTime(timings['timings']['Asr'], currentTime);
            break;
          case 'Asr':
            nextPrayerEndTime = _parseTime(timings['timings']['Sunset'], currentTime);
            break;
          case 'Maghrib':
            nextPrayerEndTime = _parseTime(timings['timings']['Isha'], currentTime);
            break;
          case 'Isha':
            nextPrayerEndTime = _parseTime(timings['timings']['Midnight'], currentTime);
            break;
          default:
            throw Exception('Unknown prayer name.');
        }

        // Calculate the total duration of the upcoming prayer
        Duration totalDuration = nextPrayerEndTime.difference(prayerTimeValue);

        // Check if totalDuration is valid (greater than zero) before calculating percentage
        if (totalDuration.inMilliseconds <= 0) {
          throw Exception('Invalid prayer duration for upcoming prayer.');
        }

        // Calculate the remaining percentage for the upcoming prayer
        double percentageRemaining = (remainingTime.inMilliseconds / totalDuration.inMilliseconds) * 100;

        // Ensure the percentage remains between 0 and 100
        percentageRemaining = percentageRemaining.clamp(0, 100).toDouble();

        return {
          'upcomingPrayer': prayerName,
          'remainingTime': remainingTime,
          'percentageRemaining': percentageRemaining.round(),
        };
      }
    }

    // If all prayers have passed, return the next day's first prayer
    return {
      'upcomingPrayer': 'Fajr',
      'remainingTime': _parseTime(timings['timings']['Fajr'], currentTime).add(Duration(days: 1)).difference(currentTime),
      'percentageRemaining': 100
    };
  }

  // Helper function to check if a time is between two other times
  static bool _isBetween(DateTime currentTime, DateTime startTime, DateTime endTime) {
    return currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
  }

  // Helper function to parse time strings and combine with current date
  static DateTime _parseTime(String timeString, DateTime currentTime) {
    // Parse the prayer time without the year (e.g., "04:51" becomes DateTime)
    DateTime parsedTime = DateFormat("HH:mm").parse(timeString.split(' ')[0]);

    // Combine it with the current date (we preserve the current date, and use the parsed time for hour and minute)
    return DateTime(currentTime.year, currentTime.month, currentTime.day, parsedTime.hour, parsedTime.minute);
  }
}


// class PrayerDurationCalculator {
//
//   // Function to find today's prayer timings from the listData based on today's Gregorian date
//   static Map<String, dynamic> getTimingsForToday(List listData) {
//     // Get today's date in DD-MM-YYYY format
//     String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//
//     // Find the matching entry based on the Gregorian date
//     for (var entry in listData) {
//       String gregorianDate = entry['date']['gregorian']['date'];
//
//       if (gregorianDate == todayDate) {
//         return entry;
//       }
//     }
//
//     // If no matching entry is found, throw an exception
//     throw Exception('No prayer timings found for today.');
//   }
//
//   // Function to find the current prayer based on the time
//   static String getCurrentPrayer(Map<String, dynamic> timings, DateTime currentTime) {
//     // Parse timings and match with the current time
//     DateTime fajrStart = _parseTime(timings['timings']['Fajr'], currentTime);
//     DateTime sunriseEnd = _parseTime(timings['timings']['Sunrise'], currentTime);
//     DateTime dhuhrStart = _parseTime(timings['timings']['Dhuhr'], currentTime);
//     DateTime asrStart = _parseTime(timings['timings']['Asr'], currentTime);
//     DateTime sunsetEnd = _parseTime(timings['timings']['Sunset'], currentTime);
//     DateTime maghribStart = _parseTime(timings['timings']['Maghrib'], currentTime);
//     DateTime ishaStart = _parseTime(timings['timings']['Isha'], currentTime);
//     DateTime midnightEnd = _parseTime(timings['timings']['Midnight'], currentTime);
//
//     if (_isBetween(currentTime, fajrStart, sunriseEnd)) {
//       return 'Fajr';
//     } else if (_isBetween(currentTime, dhuhrStart, asrStart)) {
//       return 'Dhuhr';
//     } else if (_isBetween(currentTime, asrStart, sunsetEnd)) {
//       return 'Asr';
//     } else if (_isBetween(currentTime, sunsetEnd, maghribStart)) {
//       return 'Maghrib';
//     } else if (_isBetween(currentTime, maghribStart, ishaStart)) {
//       return 'Maghrib';
//     } else if (_isBetween(currentTime, ishaStart, midnightEnd)) {
//       return 'Isha';
//     } else {
//       return 'No prayer ongoing'; // If it's between prayers, handle accordingly
//     }
//   }
//
//   // Function to calculate the remaining time and percentage for the current prayer
//   static Map<String, dynamic> calculatePrayerTimeInfo(Map<String, dynamic> timings, String currentPrayer, DateTime currentTime) {
//     DateTime prayerEndTime;
//     DateTime prayerStartTime;
//
//     // Get the prayer's start and end times
//     switch (currentPrayer) {
//       case 'Fajr':
//         prayerStartTime = _parseTime(timings['timings']['Fajr'], currentTime);
//         prayerEndTime = _parseTime(timings['timings']['Sunrise'], currentTime);
//         break;
//       case 'Dhuhr':
//         prayerStartTime = _parseTime(timings['timings']['Dhuhr'], currentTime);
//         prayerEndTime = _parseTime(timings['timings']['Asr'], currentTime);
//         break;
//       case 'Asr':
//         prayerStartTime = _parseTime(timings['timings']['Asr'], currentTime);
//         prayerEndTime = _parseTime(timings['timings']['Sunset'], currentTime);
//         break;
//       case 'Maghrib':
//         prayerStartTime = _parseTime(timings['timings']['Maghrib'], currentTime);
//         prayerEndTime = _parseTime(timings['timings']['Isha'], currentTime);
//         break;
//       case 'Isha':
//         prayerStartTime = _parseTime(timings['timings']['Isha'], currentTime);
//         prayerEndTime = _parseTime(timings['timings']['Midnight'], currentTime);
//         break;
//       default:
//         throw Exception('Unknown prayer name.');
//     }
//
//     // If the current time is after the prayer end time, return
//     if (currentTime.isAfter(prayerEndTime)) {
//       throw Exception('The current prayer time has already passed.');
//     }
//
//     // Calculate the total duration of the prayer
//     Duration totalDuration = prayerEndTime.difference(prayerStartTime);
//
//     // Calculate the time passed so far
//     Duration timePassed = currentTime.difference(prayerStartTime);
//
//     // Calculate the percentage of time passed (as an integer)
//     int percentagePassed = ((timePassed.inMilliseconds / totalDuration.inMilliseconds) * 100).round();
//
//     // Calculate the remaining percentage
//     int percentageRemaining = 100 - percentagePassed;
//
//     return {
//       'remainingTime': prayerEndTime.difference(currentTime),
//       'percentagePassed': percentagePassed,
//       'percentageRemaining': percentageRemaining
//     };
//   }
//
//   // Helper function to check if a time is between two other times
//   static bool _isBetween(DateTime currentTime, DateTime startTime, DateTime endTime) {
//     return currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
//   }
//
//   // Helper function to parse time strings and combine with current date
//   static DateTime _parseTime(String timeString, DateTime currentTime) {
//     // Parse the prayer time without the year (e.g., "04:51" becomes DateTime)
//     DateTime parsedTime = DateFormat("HH:mm").parse(timeString.split(' ')[0]);
//
//     // Combine it with the current date (we preserve the current date, and use the parsed time for hour and minute)
//     return DateTime(currentTime.year, currentTime.month, currentTime.day, parsedTime.hour, parsedTime.minute);
//   }
// }




// class PrayerTimings {
//   String fajr;
//   String sunrise;
//   String dhuhr;
//   String asr;
//   String sunset;
//   String maghrib;
//   String isha;
//   String imsak;
//   String midnight;
//   String firstthird;
//   String lastthird;
//
//   PrayerTimings({
//     required this.fajr,
//     required this.sunrise,
//     required this.dhuhr,
//     required this.asr,
//     required this.sunset,
//     required this.maghrib,
//     required this.isha,
//     required this.imsak,
//     required this.midnight,
//     required this.firstthird,
//     required this.lastthird,
//   });
// }
