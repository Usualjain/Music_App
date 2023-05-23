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

    double deviceHeight = MediaQuery.of(context).size.height- MediaQuery.of(context).padding.bottom;
    double deviceWidth = MediaQuery.of(context).size.width;

    final data = MusicData().musicList;

    Random random = Random();
    int headerIndex = random.nextInt(data.length);

    return SizedBox(
        height: deviceHeight*0.34,
        width: double.infinity,

        child: Stack(
          children: [
            Image.network(data[headerIndex].url, fit:BoxFit.fill,width: double.infinity,),
            Container(
              padding: EdgeInsets.symmetric(vertical: deviceHeight*0.029, horizontal: deviceWidth*0.03),
              alignment: Alignment.bottomLeft,
              child: Text(data[headerIndex].artist,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,

                ),),
            ),

            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(vertical: deviceHeight*0.014, horizontal: deviceWidth*0.037),
              child: Stack(alignment: Alignment.center,
                children: [
                  Icon(Icons.circle,color: Theme.of(context).colorScheme.primary,size: deviceWidth*0.16, ),
                  IconButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SongScreen(song: data[headerIndex],currentIndex: headerIndex,)));
                    },
                    icon: Icon(Icons.play_arrow, size: deviceWidth*0.08),
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