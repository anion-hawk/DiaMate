import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:diamate_frontend/presentation/register_screen/register_screen.dart'
    as reg;

String baseUrl = "";

final login = baseUrl + "/auth/login";
final show_post = baseUrl + "/forum/show";
final registration = baseUrl + "/auth/register";
final compUserProf = baseUrl + "/user/complete-profile";
final own_post = baseUrl + "/forum/post";
final forum = baseUrl + "/forum/posts";

// Cookie Management

var cj = new CookieJar();
var cookies = [];

var usaved;
var psaved;
