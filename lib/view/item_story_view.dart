import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/dart/colors.dart';

Widget addStoryWidget({required double size, required IconData iconData}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [
                  greenGradient.lightShade,
                  greenGradient.darkShade
                ]
            ),
          ),
          child: Icon(iconData, color: Colors.white,),
        ),
        const Text("New Status", style: TextStyle(fontSize: 12, color: lightGrey))
      ],
    );
}

Widget storyWidget({required double size, required String imgUrl}) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.all(8),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          )
        ),
      ),
      const Text("Amy", style: TextStyle(fontSize: 12, color: lightGrey))
    ],
  );
}

Widget chatWidget({required double size, required String imgUrl}) {
  return Column(
    children: [
      Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            width: size,
            height: size,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                )
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Jordon Moran", style: TextStyle(fontSize: 15, color: darkGrey)),
              SizedBox(height: 10),
              Text("Bro, their fire", style: TextStyle(fontSize: 13, color: lightGrey)),
            ],
          ),
        ],
      ),
      const Divider(thickness: 1, color: superLightGrey),
    ],
  );
}