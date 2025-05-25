import 'dart:developer';

String phoneNumberFilter(String userNumber) {
  log("userNumber: $userNumber");
  if (userNumber[0] == "0") {
    String formattedNumber = userNumber.replaceFirst("0", "255");
    return formattedNumber;
  } else if (userNumber[0] == "+") {
    String formattedNumber = userNumber.substring(1);

    return formattedNumber;
  } else if (userNumber[0] == "2") {
    return userNumber;
  } else {
    return 'invalid format';
  }
}

String userViewPhoneNumber(String userNumber) {
  if (userNumber.startsWith('255')) {
    return '0${userNumber.substring(3)}';
  } else if (userNumber.startsWith('+255')) {
    return '0${userNumber.substring(4)}';
  }
  return userNumber;
}
