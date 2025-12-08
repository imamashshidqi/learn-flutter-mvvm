import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view_models/movie_detail_controller.dart';
import 'package:get/get.dart';

class MovieDetailView extends GetView<MovieDetailController> {
  const MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Film")),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  movie.poster,
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.broken_image, size: 100),
                ),
              ),
              SizedBox(height: 20),
              Text(
                movie.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "${movie.year} • ${movie.director}",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              Chip(label: Text(movie.genre)),
              SizedBox(height: 20),
              Text(
                "Plot:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(movie.plot),
            ],
          ),
        );
      }),
    );
  }
}
