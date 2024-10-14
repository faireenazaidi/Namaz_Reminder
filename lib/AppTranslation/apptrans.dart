abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en_US": enUS,
    "ur": ur,
    "hi": hi,
  };
}

// Login/SignUp English Translations
final Map<String, String> enUS = {
  'log': 'Login/Signup',
  'otp': "Enter your phone number to send the OTP",
  'number': "Enter your phone number",
  'sendOtp': "Send OTP",
  'withGoogle': "Login with Google",
  'userId': "User Id",
  'validation': "Invalid Mobile Number ",


  // Verifying your Account
  'verification': "Verifying Your Account",
  'codeVerification': "Enter the 6-digit verification code sent to the number ending in the last 4 digits",
  'notGetOtp': "Didn't receive an OTP?",
  'Resend': "Resend OTP in",


  // Account setup
  'setup': "Setup your Account",
  'helpUS': "Help us get to know you better",
  'enterName': "Enter your name",
  'gender': "Gender",
  'male': "Male",
  'female': "Female",
  'next': "Next",

  // Select your calculation method
  'setUp': "Setup your Account",
  'calMethod': "Select your Calculation Method",
  'selectName': "Select Name",

  // School of thought
  'thought': "Select your School of Thought",
  'timePrayer': "Times of Prayer",

  //DashBoard
  'title': "Prayer O'Clock",
  'nextPrayerTime': "starts at",
  'upcoming': "UPCOMING PRAYERS",
  'fajr': "Fajr",
  'zuhr': "ZUHR",
  'leaderboard': "LEADERBOARD",
  'outOf': "Out of",
  'peoplePeers': "people in peers",
  'leftFor': "Left for",
  'prayer': "Prayer",
  'markPrayed': "Mark as Prayed",
  'start' : "Starts at",

  // Mark as Prayed Popup
  'markPrayerTime': "Mark Your Prayer Time",
  'atMosque': "Prayed at Mosque/Jamat time",
  'submit': "Submit",

  //Upcoming Prayers
  'starts': "Starts at",
  'ends': "Ends at",


  //Drawer
  'editProfile': "Edit Profile",
  'missPrayers': "Missed Prayers",
  'leader': "Leaderboard",
  'peer': "Peer Circle",
  'notification': "Notifications",
  'setting': "Settings",
  'fq': "F&Q",
  'feedback': "Feedback",
  'logout': "Logout",


  //Profile
  'fullName': "Full Name",
  'num': "Phone Number",
  'email': "Email",
  'schoolThought': "School of Thought",

  //LeaderBoard
  'daily': "Daily",
  'weekly': "Weekly",
  'f': "F",
  'z': "Z",
  'a': "A",
  'm': "M",
  'i': "I",
  'overall': "Overall",

  //Missed Prayers
  'timeline': "TODAY'S TIMELINE",

  //Peer Circle
  'search': "Search Username",
  'add': "Add",
  'noFriends': "No friends found",
  'remove': "Remove",

  //Add
  'suggest': "SUGGESTIONS",
  'invite': "Invite",
  'pending': "Pending",
  'accepted': "Accepted",
  'addTitle': "Invite friends",


  //Notification Setting
  'notificationSetting': "Notification Settings",
  'notiSound': "Notification Sound",
  'default': "Default ",
  'pause': "Pause all",
  'temPauseNotification': "Temporarily pause notifications",
  'quietMode': "Quiet mode",
  'aboutQuietMode': "Automatically mute notifications at night or whenever you need to focus.",
  'friendReq': "Friend requests ",
  'aboutFriendReq': "Notify when someone sends you a joining request.",
  'friendNamaz': "Friend Namaz Prayed",
  'preNamaz': "pre Namaz Alert",
  'minAgo': "min ago",

  //Notification Sound
  'callPrayer': "Call to Prayer",
  'classic': "Classic",
  'beap': "Beap",
  'beep beep': "Beep Beep",


  //Pre Namaz Alert
  'minutesAgo': "minutes Ago",
  'noAlert': "No Alert",


  //settings
  'hijriAdjustment': "Hijri Date Adjustment",
  'prayerSetting': "Prayer Time setting",
  'friendRq': "Friend Request",
  'aboutFriendR': "Manage who can send you joining request",
  'appLang': "App Language",
  'privacy': "Privacy & Security",

  //Hijri Date Adjustment
  'twoDays': "Two days ago",
  'oneDay': "One day ago",
  'none': "None",
  'oneAhead': "One day ahead",
  'twoAhead': "Two days ahead",

  //Prayer Times
  'time': "times",

  //Friend Request
  'everyone': "Everyone",
  'myContact': "Only my contacts",
  'noOne': "No One",

  //FAQs
  'faqs': "FAQs",
  'purposeOfApp': "This app is designed to help Muslims with their daily spiritual practices by providing access to various Islamic resources, such as Quran readings, prayer times, supplications (duas), and Islamic lectures.",


  //Feedback
  'leaveFeed': "Leave us a feedback",
  'mailAdd': "Mail address(optional)",
  'enterEmail': "Enter your email address",
  'onaScale': "On a scale of 1-5 how likely you are to recommend this tool to someone you know?",
  'notLikely': "Not likely at all",
  'extremely': "Extremely likely",
  'suggestion': "Suggestion or comment,if any",
  'saySomething': "Say something here...",


  //Logout
  'logOut': "Do you want to logout?",
  'cancel': "Cancel",
  'yes': "Yes",

};

//Hindi Translations
final Map<String, String> hi = {

};

//Urdu Translations
final Map<String, String> ur = {

};

