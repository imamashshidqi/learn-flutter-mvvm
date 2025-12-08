import 'package:flutter_mvvm/data/repositories/movie_repository.dart';
import 'package:flutter_mvvm/models/movie_detail_model.dart';
import 'package:get/get.dart';

class MovieDetailController extends GetxController {
  final MovieRepository _repository;

  MovieDetailController({required MovieRepository repository})
    : _repository = repository;

  var isLoading = false.obs;
  var movieDetail = Rxn<MovieDetail>();
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final String imdbID = Get.arguments;
    fetchDetail(imdbID);
  }

  void fetchDetail(String id) async {
    try {
      isLoading.value = true;

      final result = await _repository.getMovieDetail(id);

      movieDetail.value = result;
    } catch (e) {
      errorMessage.value = "Terjadi Kesalahan $e";
    } finally {
      isLoading.value = true;
    }
  }
}
