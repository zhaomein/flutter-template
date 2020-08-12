import 'package:com.kaiyouit.caiwai/data/providers/api_provider.dart';

const LIMIT_REQUEST_TIME = 30;
const LIMIT_GET_CHAT_ROOMS = 15;
const LIMIT_GET_MESSAGES = 20;

const BASE_URL = 'https://example.com/api';

const register = {
  'url': '$BASE_URL/register',
  'method': Method.POST
};

const login = {
  'url': '$BASE_URL/login',
  'method': Method.POST
};
