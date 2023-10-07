import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tongue_techies_frontend/services/news.service.dart';
import 'package:tongue_techies_frontend/models/news.models.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  final NewsAPIService _apiService = NewsAPIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Page'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<dynamic>(
        future: _apiService.getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
              color: Colors.white,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading news'));
          } else if (snapshot.hasData && snapshot.data is NewsModel) {
            NewsModel news = snapshot.data as NewsModel;
            return ListView.builder(
              itemCount: news.data.length,
              itemBuilder: (context, index) {
                Datum newsItem = news.data[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        newsItem.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          newsItem.thumbnailUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () => _launchURL(newsItem.link),
                    ),
                  ),
                );
              },
            );
          } else {
            // Handle other error cases here
            return Center(child: Text('Error loading news'));
          }
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
