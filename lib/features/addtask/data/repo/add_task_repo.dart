import 'package:dartz/dartz.dart';
import 'package:to_do_app/Core/network/api_helper.dart';
import 'package:to_do_app/Core/network/api_response.dart';
import 'package:to_do_app/Core/network/end_points.dart';

class AddTaskRepo {
  APIHelper apiHelper = APIHelper();

  Future<Either<String, String>> addTask({
    required String title,
    required String describtion,
  }) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.addtask,
        data: {"title": title, "description": describtion},
      );

      if (response.status) {
        // success
        return Right(response.message);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}
