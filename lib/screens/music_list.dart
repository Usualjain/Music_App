import 'package:flutter/material.dart';

import 'package:music_app/data/music_data.dart';
import 'package:music_app/widgets/headerpic.dart';
import 'package:music_app/widgets/music_item.dart';

class MusicScreen extends StatelessWidget{
  const MusicScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final data = MusicData();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(),
          const SizedBox(height: 6, width: double.infinity,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text('Popular Songs', style: Theme.of(context).textTheme.titleLarge!.copyWith(color:Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),),
              ),
              TextButton(onPressed: (){}, child: Text('More', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary,  fontWeight: FontWeight.bold),))
            ],
          ),
          const SizedBox(
              width: double.infinity,
              height: 533,
              child: MusicItem()
          ),
        ],
      ),
    );
  }
}