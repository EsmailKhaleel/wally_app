// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallyapp/screens/wallpaper_screen.dart';

class ExploreScreen extends StatelessWidget {
  var images = [
    "https://thumbs.dreamstime.com/b/yellow-dahlia-fine-art-flower-photography-black-background-yellow-dahlia-fine-art-flower-photography-black-background-198343653.jpg",
    "https://w0.peakpx.com/wallpaper/654/556/HD-wallpaper-white-flower-ds-ali-flowers-black-lotus-pink-beautiful-nature-new-thumbnail.jpg",
    "https://as1.ftcdn.net/v2/jpg/02/96/12/56/1000_F_296125609_R9udLZ4jFj6Qx8RbBHo8EWCX78714uxL.jpg",
    "https://c0.wallpaperflare.com/preview/781/619/672/red-rose-behind-white-flowers-in-black-background-thumbnail.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOoCUh46b_yY--kR1U4KPXUiNvy471AM00HsRij1rYsOv4HL4K9TsdtDPtA_7QpAzxRWM&usqp=CAU",
    "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
            child: Text(
              "Explore",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            physics: NeverScrollableScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WallpaperScreen(image: images[index])));
                  },
                  child: Hero(
                    tag: images[index],
                    child: CachedNetworkImage(
                      imageUrl: images[index],
                      imageBuilder: (context, imageProvider) => Image(
                        image: NetworkImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
