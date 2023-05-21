import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:music_app/data/music_data.dart';
import 'package:music_app/screens/song_screen.dart';

class Header extends StatelessWidget{

  const Header({
    super.key,
});

  @override
  Widget build(BuildContext context) {

    final data = MusicData().musicList;

    Random random = Random();
    int headerIndex = random.nextInt(data.length);

    return SizedBox(
        height: 300,
        width: double.infinity,

        child: Stack(
          children: [
            Image.network(data[headerIndex].url, fit:BoxFit.fill,width: double.infinity,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              alignment: Alignment.bottomLeft,
              child: Text(data[headerIndex].artist,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),),
            ),

            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Stack(alignment: Alignment.center,
                children: [
                  Icon(Icons.circle,color: Theme.of(context).colorScheme.primary,size: 60, ),
                  IconButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SongScreen(song: data[headerIndex],currentIndex: headerIndex,)));
                    },
                    icon: const Icon(Icons.play_arrow, size: 30),
                    color: Colors.white,
                    // iconSize: 35,
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}