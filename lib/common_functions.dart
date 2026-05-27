import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import 'colors.dart';
import 'main.dart';
import 'dart:ui' as ui;

BuildContext get bContext => navigatorKey.currentContext!;

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

ImagePicker _picker = ImagePicker();

Map<String, String> areaCode = {
  "AN": "Andaman and Nicobar Islands",
  "AP": "Andhra Pradesh",
  "AR": "Arunachal Pradesh",
  "AS": "Assam",
  "BR": "Bihar",
  "CG": "Chandigarh",
  "CH": "Chhattisgarh",
  "DN": "Dadra and Nagar Haveli",
  "DD": "Daman and Diu",
  "DL": "Delhi",
  "GA": "Goa",
  "GJ": "Gujarat",
  "HR": "Haryana",
  "HP": "Himachal Pradesh",
  "JK": "Jammu and Kashmir",
  "JH": "Jharkhand",
  "KA": "Karnataka",
  "KL": "Kerala",
  "LA": "Ladakh",
  "LD": "Lakshadweep",
  "MP": "Madhya Pradesh",
  "MH": "Maharashtra",
  "MN": "Manipur",
  "ML": "Meghalaya",
  "MZ": "Mizoram",
  "NL": "Nagaland",
  "OR": "Odisha",
  "PY": "Puducherry",
  "PB": "Punjab",
  "RJ": "Rajasthan",
  "SK": "Sikkim",
  "TN": "Tamil Nadu",
  "TS": "Telangana",
  "TR": "Tripura",
  "UP": "Uttar Pradesh",
  "UK": "Uttarakhand",
  "WB": "West Bengal"
};

getTimePeriod(double time) {
  if (time >= 12) {
    return 'pm';
  } else {
    return 'am';
  }
}

bool isSameDay(DateTime date1, DateTime date2) =>
    date1.day == date2.day &&
    date1.month == date2.month &&
    date1.year == date2.year;

Map sortMap(Map map) {
  Map sortedMap = {};
  var gg = map.keys.toList()
    ..sort((a, b) =>
        num.parse(a.split('-')[0]).compareTo(num.parse(b.split('-')[0])));

  LinkedHashMap lSMap =
      LinkedHashMap.fromIterable(gg, key: (k) => k, value: (k) => map[k]);
  sortedMap = lSMap;
  return sortedMap;
}

String amountText(double amount) {
  String amountString = amount.toStringAsFixed(2);

  if (amountString.split('.')[1][1] == '0') {
    amountString =
        '${amountString.split('.')[0]}.${amountString.split('.')[1][0]}';
    if (amountString.split('.')[1][0] == '0') {
      amountString = amountString.split('.')[0];
    }
  }
  return amountString;
}

String regExpText(String text) {
  return text.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},');
}

String convertAmountString(double amount) {
  var strToReturn = '';
  String aS = amount.round().toStringAsFixed(0);
  final list = aS.split('.');
  aS = list[0];
  final length = aS.length;
  if (length < 6) {
    strToReturn = amountText(amount);
  } else if (length == 6) {
    String trail = aS.substring(length - 5, length);
    String lead = aS.substring(0, length - 5);
    if (trail[0] != '0') lead = '$lead.${trail[0]}';
    strToReturn = '${lead}L';
  } else if (length == 7) {
    String trail = aS.substring(length - 6, length);
    String lead = '${aS.substring(0, length - 6)}0';
    if (trail[0] != '0') lead = '$lead.${trail[0]}';
    strToReturn = '${lead}L';
  } else if (length > 7) {
    String trail = aS.substring(length - 7, length);
    String lead = aS.substring(0, length - 7);
    if (trail[0] != '0') lead = '$lead.${trail[0]}';
    strToReturn = '${lead}Cr';
  }
  return strToReturn;
}

getTimeDifferenceText(Duration differnce) {
  if (differnce.inDays != 0) {
    return '${differnce.inDays} ${differnce.inDays > 1 ? 'days' : 'day'}';
  }

  if (differnce.inHours != 0) {
    return '${differnce.inHours} ${differnce.inHours > 1 ? 'hrs' : 'hr'}'
        ' ${(differnce.inMinutes / 60).toStringAsFixed(0)} min';
  }

  if (differnce.inMinutes != 0) {
    return '${differnce.inMinutes} ${differnce.inMinutes > 1 ? 'minutes' : 'minute'}';
  }

  if (differnce.inSeconds != 0) {
    return '${differnce.inSeconds} ${differnce.inSeconds > 1 ? 'seconds' : 'second'}';
  }
}

showSnackbar(
  String msg, {
  Color color = Colors.red,
  int duration = 2,
  double bottom = 20,
}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).hideCurrentSnackBar();
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        msg,
        softWrap: true,
        style: Theme.of(navigatorKey.currentContext!)
            .textTheme
            .displayMedium!
            .copyWith(fontSize: 14, color: Colors.white, letterSpacing: .4),
      ),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    duration: Duration(seconds: duration),
    margin: EdgeInsets.only(
      bottom: bottom,
      right: 20,
      left: 20,
    ),
  ));
}

noInternetSnackbar() =>
    showSnackbar('Something went wrong, Check internet connection');

Future<String> imgFromCamera() async {
  final image = await _picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    return image.path;
  } else {
    return '';
  }
}

Future<String> imgFromGallery() async {
  final image = await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    return image.path;
  } else {
    return '';
  }
}

String getInitials(String text) {
  var textList = text.trim().split(' ');
  if (textList.length == 1 && textList[0] == '') {
    return '';
  } else if (textList.length >= 2) {
    return '${textList[0].substring(0, 1)}${textList[1].substring(0, 1)}';
  } else {
    return textList[0].length == 1 ? textList[0] : textList[0].substring(0, 2);
  }
}

void launchCall(mobileNumber) async {
  try {
    var url = Uri.parse('tel:$mobileNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (kDebugMode) {
        print('could not launch ');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

checkIfValid(String? text) => (text != '' && text != null);

hideKeyBoard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());

double horizontalPaddingFactor = 0.05;

screenHorizontalPadding(double dW) =>
    EdgeInsets.symmetric(horizontal: dW * horizontalPaddingFactor);

List<BoxShadow> get shadow => [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        offset: const Offset(0, 4),
        spreadRadius: 0,
        blurRadius: 5,
      )
    ];

BoxDecoration commonBoxDecoration(double radius, BuildContext context) =>
    BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: 1, color: getPrimaryFadeBorder(context)),
        boxShadow: shadow);

bool iOSCondition(double dH) {
  return Platform.isIOS && dH > 850;
}

BorderSide dividerBorder(BuildContext context) {
  return BorderSide(color: getGreyColor(context), width: 1);
}

String addPiece(String? piece) {
  if (piece == null || piece == '') {
    return '';
    //
  } else {
    return '$piece, ';
  }
}

handlePermissionsFunction() async {
  try {
    Map<Permission, PermissionStatus> statuses = {};
    if (Platform.isIOS) {
      statuses =
          await [Permission.location, Permission.locationAlways].request();

      if (statuses.containsValue(PermissionStatus.permanentlyDenied) ||
          statuses.containsValue(PermissionStatus.denied)) {
        // showSnackbar('Please enable location', Colors.red);
        return false;
      } else {
        return true;
      }
    } else {
      statuses = await [Permission.location].request();

      if ((statuses[Permission.location] == PermissionStatus.denied) ||
          (statuses[Permission.location] ==
              PermissionStatus.permanentlyDenied)) {
        // showSnackbar('Please enable location', Colors.red);
        return false;
      } else {
        return true;
      }
    }
  } catch (e) {
    return false;
  }
}

DateTime getParseDate(String date) => DateTime.parse(date).toLocal();

double checkNullAndGetDouble(value) => (value ?? 0).toDouble();

String numberToPositionString(int number) {
  if (number >= 11 && number <= 13) {
    return '${number}th';
    //
  } else if (number.toString().endsWith('1')) {
    return '${number}st';
  } else if (number.toString().endsWith('2')) {
    return '${number}nd';
  } else if (number.toString().endsWith('3')) {
    return '${number}rd';
  } else {
    return '${number}th';
  }
}

int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
}

String getDate(DateTime date,
    {bool showTime = false, String format = 'dd MMM yyyy \u25CF hh:mm a'}) {
  return calculateDifference(date) == 0
      ? showTime
          ? DateFormat('hh:mm a').format(date)
          : 'Today'
      : DateFormat(format).format(date);
}

Color getThemeColor() {
  return Theme.of(navigatorKey.currentState!.context).primaryColor;
}

String formatTime(num time) {
  if (time > 12) {
    time = time - 12;
    formatTime(time);
    if (time < 10) {
      return '0$time:00';
    } else {
      return '$time:00';
    }
  } else {
    if (time < 10) {
      return '0$time:00';
    } else {
      return '$time:00';
    }
  }
}

get12HrFormat(double time) {
  if (time >= 13 && time <= 24) {
    if (time == 13.00) {
      return 1.0;
    } else if (time == 13.30) {
      return 1.3;
    } else if (time == 14.00) {
      return 2.0;
    } else if (time == 14.30) {
      return 2.3;
    } else if (time == 15.00) {
      return 3.0;
    } else if (time == 15.30) {
      return 3.3;
    } else if (time == 16.00) {
      return 4.0;
    } else if (time == 16.30) {
      return 4.3;
    } else if (time == 17.00) {
      return 5.0;
    } else if (time == 17.30) {
      return 5.3;
    } else if (time == 18.00) {
      return 6.0;
    } else if (time == 18.30) {
      return 6.3;
    } else if (time == 19.00) {
      return 7.0;
    } else if (time == 19.30) {
      return 7.3;
    } else if (time == 20.00) {
      return 8.0;
    } else if (time == 20.30) {
      return 8.3;
    } else if (time == 21.00) {
      return 9.0;
    } else if (time == 21.30) {
      return 9.3;
    } else if (time == 22.00) {
      return 10.0;
    } else if (time == 22.30) {
      return 10.3;
    } else if (time == 23.00) {
      return 11.0;
    } else if (time == 23.30) {
      return 11.3;
    } else if (time == 24.00) {
      return 0.0;
    } else if (time == 24.30) {
      return 0.3;
    }
  } else {
    return time;
  }
}

getYearsDiff(DateTime date) {
  return (DateTime.now().difference(date).inDays) ~/ 365;
}

getWeekNumber(String day) {
  switch (day) {
    case 'Mon':
      return 1;
    case 'Tue':
      return 2;
    case 'Wed':
      return 3;
    case 'Thu':
      return 4;
    case 'Fri':
      return 5;
    case 'Sat':
      return 6;
    case 'Sun':
      return 7;
  }
}

getWeekDays(int index) {
  switch (index) {
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
  }
}

get12HrClockFormat(String time) {
  if (double.parse(time.replaceAll(":", '.')) >= 13 &&
      double.parse(time.replaceAll(":", '.')) <= 24) {
    if (time == '13:00' || time == '13:0') {
      return "01:00";
    } else if (time == '13:30' || time == '13:3') {
      return "01:30";
    } else if (time == '14:00' || time == '14:0') {
      return "02:00";
    } else if (time == '14:30' || time == '14:3') {
      return "02:30";
    } else if (time == '15:00' || time == '15:0') {
      return "03:00";
    } else if (time == '15:30' || time == '15:3') {
      return "03:30";
    } else if (time == '16:00' || time == '16:0') {
      return "04:00";
    } else if (time == '16:30' || time == '16:3') {
      return "04:30";
    } else if (time == '17:00' || time == '17:0') {
      return "05:00";
    } else if (time == '17:30' || time == '17:3') {
      return "05:30";
    } else if (time == '18:00' || time == '18:0') {
      return "06:00";
    } else if (time == '18:30' || time == '18:3') {
      return "06:30";
    } else if (time == '19:00' || time == '19:0') {
      return "07:00";
    } else if (time == '19:30' || time == '19:3') {
      return "07:30";
    } else if (time == '20:00' || time == '20:0') {
      return "08:00";
    } else if (time == '20:30' || time == '20:3') {
      return "08:30";
    } else if (time == '21:00' || time == '21:0') {
      return "09:00";
    } else if (time == '21:30' || time == '21:3') {
      return "09:30";
    } else if (time == '22:00' || time == '22:0') {
      return "10:00";
    } else if (time == '22:30' || time == '22:3') {
      return "10:30";
    } else if (time == '23:00' || time == '23:0') {
      return "11:00";
    } else if (time == '23:30' || time == '23:3') {
      return "11:30";
    } else if (time == '24:00' || time == '24:0') {
      return "00:00";
    } else if (time == '24:30' || time == '24:3') {
      return "00:30";
    }
  } else {
    return time;
  }
}

List defaultSlots = [
  {
    'title': 'Morning',
    'isSelected': false,
    'id': 'Slot1',
    'startTime': 5,
    'endTime': 12,
    'priceAndQuantity': [],
  },
  {
    'title': 'Afternoon',
    'isSelected': false,
    'id': 'Slot2',
    'startTime': 12,
    'endTime': 16,
    'priceAndQuantity': [],
  },
  {
    'title': 'Evening',
    'isSelected': false,
    'id': 'Slot3',
    'startTime': 16,
    'endTime': 20,
    'priceAndQuantity': [],
  },
  {
    'title': 'Night',
    'isSelected': false,
    'id': 'Slot4',
    'startTime': 20,
    'endTime': 5,
    'priceAndQuantity': [],
  },
];

getDuration(int minutes) {
  if (minutes != 0) {
    int remainder = 0;
    int quotient = 0;
    String min = '';
    String sec = '';
    quotient = minutes ~/ 60;
    remainder = minutes % 60;
    min = '$quotient';
    sec = "$remainder";

    if (quotient < 9) {
      min = '0$quotient';
    } else {
      min = '$quotient';
    }

    if (remainder < 9) {
      sec = '0$remainder';
    } else {
      sec = '$remainder';
    }
    return '$min:$sec';
  } else {
    return '00:00';
  }
}
