import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final String imageUrl;
  const CircularImage({Key key, this.imageUrl}) : super(key: key);

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Container(
        padding: EdgeInsets.all(50),
        child: CircularProgressIndicator(),
      ),
      imageUrl: imageUrl ?? " ",
      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      errorWidget: (context, url, error) {
        return Container(
          child: _imageWidget(AssetImage("assets/news.jpeg")),
        );
      },
    );
  }
}
