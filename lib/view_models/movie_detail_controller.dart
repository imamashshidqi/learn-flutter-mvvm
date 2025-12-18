import 'package:get/get.dart';
import 'package:flutter_mvvm/domain/models/movie_detail_result_model.dart';
import 'package:flutter_mvvm/domain/usecases/movie_recommendations_usecase.dart';

class MovieDetailController extends GetxController {
  final MovieRecommendationsUsecase _useCase;

  MovieDetailController({required MovieRecommendationsUsecase useCase})
    : _useCase = useCase;

  // State
  var isLoading = false.obs;
  var data = Rxn<MovieDetailResult>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    String imdbID = (args is Map) ? args['id'] : args;
    loadData(imdbID);
  }

  void loadData(String id) async {
    try {
      isLoading(true);
      final result = await _useCase.execute(id);
      data.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
