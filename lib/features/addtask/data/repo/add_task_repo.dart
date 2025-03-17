import 'package:dartz/dartz.dart';
import 'package:to_do_app/Core/network/api_helper.dart';
import 'package:to_do_app/Core/network/api_response.dart';
import 'package:to_do_app/Core/network/end_points.dart';
import 'package:to_do_app/features/addtask/data/model/add_task_response_model.dart';
import 'package:to_do_app/features/addtask/data/model/get_task_reposne_model.dart';

class AddTaskRepo {
  APIHelper apiHelper = APIHelper();

  Future<Either<String, List<TaskModel>>> addTask({
    required String title,
    required String describtion,
  }) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.addtask,
        data: {"title": title, "description": describtion},
        isAuthorized: false,
      );

      if (response.status) {
        // success
        AddTaskResponseModel addTaskResponseModel =
            AddTaskResponseModel.fromJson(response.data);

        return Right(addTaskResponseModel.message as List<TaskModel>);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}
