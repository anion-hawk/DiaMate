import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

String baseUrl = (dotenv.dotenv.env['API_URL'])!;

final login = baseUrl + "/auth/login";
final show_post = baseUrl + "/forum/show";
final registration = baseUrl + "/auth/register";
final compUserProf = baseUrl + "/user/complete-profile";
final own_post = baseUrl + "/forum/post";