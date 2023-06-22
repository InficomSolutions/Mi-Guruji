class TGuruJiUrl {
  static const url = 'https://admin.miguruji.com/';
  static const baseUrl = 'https://admin.miguruji.com/api/api/';
  //sign up
  static const gettimetable = '${baseUrl}all_timetable';
  static const addseniority = '${baseUrl}add_seniority_list';
  static const addtimetable = '${baseUrl}timetable';
  static const getseniority = '${baseUrl}all_seniority_list';
  static const addresult = '${baseUrl}add_student_result';
  static const getresult = '${baseUrl}all_student_result';
  static const examinfo = '${baseUrl}exam_info';
  static const addamount = '${baseUrl}user_wallet_recharge';
  static const plans = '${baseUrl}subscription_plans';
  static const userdata = '${baseUrl}user_details_by_id';
  static const sportrules = '${baseUrl}all_sports';
  static const slider = '${baseUrl}slider';
  static const commitee = '${baseUrl}all_committee';
  static const student = '${baseUrl}all_student';
  static const foregotpassword = '${baseUrl}forget_password';
  static const schoolRegistration = '${baseUrl}school_register';
  static const registration = '${baseUrl}user_register';
  static const studentinfo = '${baseUrl}add_student_list';
  static const teacherInfo = '${baseUrl}add_teachers_info';
  static const laterPad = '${baseUrl}letterpad_details';
  static const booklist = '${baseUrl}book_by_class';
  static const addtask = '${baseUrl}monthly_task';
  static const gettask = '${baseUrl}all_monthly_task';
  static const addnutrition = '${baseUrl}nutrition_food';
  static const login = '${baseUrl}user_signin';
  static const blog = '${baseUrl}blogs_list';
  static const latestnews = '${baseUrl}latest_news';
  static const routine = '${baseUrl}all_routine';
  static const notificationapi = '${baseUrl}notification';
  static const routineinfo = '${baseUrl}all_routine_info';
  static const questionpaper = '${baseUrl}all_question_paper';
  static const govermentcircular = '${baseUrl}all_governing_circulars';
  static const vivdhform = '${baseUrl}form_list';
  static const updates = '${baseUrl}all_updates';
  static const userprofileupdate = '${baseUrl}user_profile_update';
  static const educationalapp = '${baseUrl}educational_app_list';
  static const teacherdata = '${baseUrl}motivational_teacher';
  static const downlaodcount = '${baseUrl}downloads_count';
  static const downloaddeduction = '${baseUrl}user_wallet_downloads_deduction';
  static const getusertotal = '${baseUrl}User_total';
  static const history = '${baseUrl}wallet_history';
  static const buyplan = '${baseUrl}subcribed_plan';
  static const getplan = '${baseUrl}subcribed_plan_user';
  static const razorpayurl = '${baseUrl}razorpay_secret';
}

var weeklist = [
  "सोमवार",
  "मंगळवार",
  "बुधवार",
  "गुरुवार",
  "शुक्रवार",
  "शनिवार",
  // 'Monday',
  // 'Tuesday',
  // 'Wednesday',
  // 'Thursday',
  // 'Friday',
  // 'Saturday',
  // 'Sunday'
];

List<bool> playpause = [];
List player = [];
List history = [];
var razorpaykeyvalue;
var usertotal;
var userdownloads;
var timetabledata = [];
var serpratetimetablewithclass = [];
var logindata;
var userdata;
var date = [];
var resultdata = [];
var allresultdata = [];
var montlytaskdata = [];
var newsdata = [];
var bookdata = [];
List totalclass = [];
List totalsubject = [];
var latterpaddata = [];
var blogdata = [];
var govermentcirculardata = [];
var questionpaperdata = [];
var sportrules = [];
var appdata = [];
var formdata = [];
var updatedata = [];
var teacherdata = [];
var paripathdata = [];
var constitustion = [];
var national = [];
var rajyagit = [];
var prayer = [];
var dailyprayer = [];
var debate = [];
var group = [];
var story = [];
var commiteedata = [];
var slider = [];
var notification = [];
var plansdata = [];
var studentdata = [];
var getexamdata = [];
var sinoritydata = [];
var subscribeddata = [];
