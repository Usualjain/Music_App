import 'package:flutter/material.dart';

import 'package:music_app/data/music_data.dart';
import 'package:music_app/widgets/headerpic.dart';
import 'package:music_app/widgets/music_item.dart';

class MusicScreen extends StatelessWidget{
  const MusicScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom;
    double deviceWidth = MediaQuery.of(context).size.width;

    final data = MusicData();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(),
          SizedBox(height: deviceHeight*0.01, width: double.infinity,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: deviceWidth*0.04),
                child: Text('Popular Songs', style: Theme.of(context).textTheme.titleLarge!.copyWith(color:Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),),
              ),
              TextButton(onPressed: (){}, child: Text('More', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary,  fontWeight: FontWeight.bold),))
            ],
          ),
          SizedBox(
              width: double.infinity,
              height: deviceHeight*0.585,
              child: const MusicItem()
          ),
        ],
      ),
    );
  }
}