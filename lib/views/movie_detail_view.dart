import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mvvm/view_models/movie_detail_controller.dart';

class MovieDetailView extends GetView<MovieDetailController> {
  MovieDetailView({super.key});

  final String argImdbID = Get.arguments ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar transparan agar gambar terlihat penuh
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 10)],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final movie = controller.movieDetail.value;
        if (movie == null) return Center(child: Text("Data tidak ditemukan"));

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER GAMBAR (HERO DESTINATION)
              Stack(
                children: [
                  Container(
                    height: 400,
                    width: double.infinity,
                    // Menangkap Hero dari halaman sebelumnya
                    child: Hero(
                      tag: movie.imdbID.isNotEmpty ? movie.imdbID : argImdbID,
                      child: Image.network(
                        movie.poster,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: Colors.grey),
                      ),
                    ),
                  ),
                  // Gradient agar teks putih terbaca
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                          stops: [0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // KONTEN TEKS (Dengan Animasi Slide Up)
              Transform.translate(
                offset: Offset(0, -40), // Sedikit naik menumpuk gambar
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5),
                          Text(movie.year),
                          SizedBox(width: 20),
                          Icon(
                            Icons.movie_creation,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5),
                          Text(movie.genre),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 20),

                      // Animasi Teks Plot (Muncul perlahan)
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Plot Summary",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              movie.plot,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
