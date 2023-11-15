import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/auth/application_user_response_operation_result.dart';
import 'package:out_out/data/view_models/auth/external_authentication_request.dart';
import 'package:out_out/data/view_models/auth/login_response_operation_result.dart';
import 'package:out_out/data/view_models/auth/refresh_token_request.dart';
import 'package:out_out/data/view_models/auth/customer_registration_request.dart';
import 'package:out_out/data/view_models/auth/login_request.dart';
import 'package:out_out/data/view_models/auth/verify_account_request.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST("/Auth/Login")
  Future<LoginResponseOperationResult> login(@Body() LoginRequest request);

  @POST("/Auth/RefreshAccessToken")
  Future<LoginResponseOperationResult> refreshAccessToken(@Body() RefreshTokenRequest request);

  @POST("/Auth/Register")
  Future<ApplicationUserResponseOperationResult> register(@Body() CustomerRegistrationRequest request);

  @POST("/Auth/VerifyAccount")
  Future<LoginResponseOperationResult> verifyAccount(@Body() VerifyAccountRequest request);

  @POST("/Auth/ExternalAuthentication")
  Future<LoginResponseOperationResult> externalAuthentication(@Body() ExternalAuthenticationRequest request);
}
