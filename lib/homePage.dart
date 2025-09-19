import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apiResponseModalClass.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  late Future<List<Photo>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pexels Photos'),
      ),
      body: FutureBuilder<List<Photo>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No photos available.'));
          } else {
            final photos = snapshot.data!;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return GestureDetector(
                  onTap: () {
                    // You can add a functionality like opening the photo URL in a browser
                    print('Photo URL: ${photo.url}');
                  },
                  child: GridTile(
                    child: Image.network(
                      photo.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(photo.photographer),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }


  Future<List<Photo>> fetchPhotos() async {
    final String apiKey = 'owB5CYdIzZjUnUT1sMU8ReWcowSDTHH1uwOIrEgmNJDMgKpojH5Gda8I';
    final String url = "https://api.pexels.com/v1/curated?page=1&per_page=40";

    final Map<String, String> headers = {
      'Authorization': apiKey,
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> photosJson = data['photos'];

        // Convert the JSON data into a list of Photo objects
        List<Photo> photos = photosJson.map((photoJson) => Photo.fromJson(photoJson)).toList();

        return photos;
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

}
