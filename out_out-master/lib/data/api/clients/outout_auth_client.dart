import 'package:dio/dio.dart';
import 'package:out_out/data/view_models/auth/logout_request.dart';
import 'package:out_out/data/view_models/auth/reset_password_request.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/data/view_models/basic/string_operation_result.dart';
import 'package:out_out/data/view_models/profile/change_password_request.dart';
import 'package:out_out/data/view_models/auth/otp_verification_time_left_response_operation_result.dart';
import 'package:out_out/data/view_models/auth/verify_reset_password_request.dart';
import 'package:retrofit/retrofit.dart';

part 'outout_auth_client.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class OutOutAuthClient {
  factory OutOutAuthClient(Dio dio, {String baseUrl}) = _OutOutAuthClient;

  @POST("/Auth/ChangePassword")
  Future<BooleanOperationResult> changePassword(@Body() ChangePasswordRequest request);

  @GET("/Auth/ForgetPassword")
  Future<BooleanOperationResult> forgetPassword(@Query("email") String email);

  @POST("/Auth/VerifyResetPassword")
  Future<StringOperationResult> verifyResetPassword(@Body() VerifyResetPasswordRequest request);

  @POST("/Auth/ResetPassword")
  Future<BooleanOperationResult> resetPassword(@Body() ResetPasswordRequest request);

  @GET("/Auth/ResendVerificationEmail")
  Future<BooleanOperationResult> resendVerificationEmail(@Query("email") String email);

  @GET("/Auth/TimeLeftVerification")
  Future<OTPVerificationTimeLeftResponseOperationResult> timeLeftVerification(@Query("email") String email);

  @POST("/Auth/Logout")
  Future<BooleanOperationResult> logout(@Body() LogoutRequest request);
}
