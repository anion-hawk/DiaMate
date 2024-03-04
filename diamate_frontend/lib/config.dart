import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:diamate_frontend/presentation/register_screen/register_screen.dart'
    as reg;

String baseUrl = "http://192.168.250.46:3000";

final url_register = '$baseUrl/auth/register';
final url_cookieCheck = '$baseUrl/user/test';
final url_selfProfile = '$baseUrl/user/profile';
final url_profileStatus = '$baseUrl/user/status';

final show_post = "$baseUrl/forum/show";
final compUserProf = "$baseUrl/user/complete-profile";
final own_post = "$baseUrl/forum/post";
final forum = "$baseUrl/forum/posts";
final selffollowdetails = baseUrl + "/user/self-follow-details";
final selfPosts = "$baseUrl/forum/selfposts";

final medlist = "$baseUrl/planner/medicinelist";
final insertmed = "$baseUrl/planner/insert-medicine";

final dietlist = "$baseUrl/planner/dietlist";
final insertdiet = "$baseUrl/planner/insert-diet";

final sugarlist = "$baseUrl/planner/sugarlist";
final insertsugar = "$baseUrl/planner/insert-sugar";
// // Cookie Management
// var cj = new CookieJar();
// var cookies = [];

// var usaved;
// var psaved;
