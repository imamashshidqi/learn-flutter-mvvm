import 'package:flutter_mvvm/data/repositories/movie_repository.dart';
import 'package:flutter_mvvm/data/services/omdb_service.dart';
import 'package:flutter_mvvm/routes/app_routes.dart';
import 'package:flutter_mvvm/view_models/movie_controller.dart';
import 'package:flutter_mvvm/view_models/movie_detail_controller.dart';
import 'package:flutter_mvvm/views/movie_detail_view.dart';
import 'package:flutter_mvvm/views/movie_view.dart';
import 'package:get/get.dart';
import 'package:flutter_mvvm/domain/usecases/movie_recommendations_usecase.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => MovieView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OmdbService());

        Get.lazyPut(
          () => MovieRepository(omdbService: Get.find<OmdbService>()),
        );

        Get.lazyPut(
          () => MovieController(repository: Get.find<MovieRepository>()),
        );
      }),
    ),
    GetPage(
      name: Routes.detail,
      page: () => MovieDetailView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(
          () => MovieRecommendationsUsecase(
            repository: Get.find<MovieRepository>(),
          ),
        );
        Get.lazyPut(
          () => MovieDetailController(
            useCase: Get.find<MovieRecommendationsUsecase>(),
          ),
        );
      }),
    ),
  ];
}
