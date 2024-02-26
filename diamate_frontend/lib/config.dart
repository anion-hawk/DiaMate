import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:diamate_frontend/presentation/register_screen/register_screen.dart'
    as reg;

String baseUrl = "http://192.168.2.103:3000";

final url_register = '$baseUrl/auth/register';
final url_cookieCheck = '$baseUrl/user/test';
final url_selfProfile = '$baseUrl/user/profile';
final url_profileStatus = '$baseUrl/user/status';

final show_post = "$baseUrl/forum/show";
final compUserProf = "$baseUrl/user/complete-profile";
final own_post = "$baseUrl/forum/post";
final forum = "$baseUrl/forum/posts";

// // Cookie Management
// var cj = new CookieJar();
// var cookies = [];

// var usaved;
// var psaved;
