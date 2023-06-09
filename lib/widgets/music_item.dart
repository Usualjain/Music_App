import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:music_app/data/music_data.dart';

import '../screens/song_screen.dart';

final data = MusicData().musicList;

class MusicItem extends StatelessWidget{
  const MusicItem({
    super.key,
});


  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height- MediaQuery.of(context).padding.bottom;
    double deviceWidth = MediaQuery.of(context).size.width;

    return ListView.separated(
      separatorBuilder: (context, index) =>
          Divider(color: Theme.of(context).colorScheme.secondary,
            indent: deviceWidth*0.04,
            endIndent: deviceWidth*0.04,
          ),
      padding: const EdgeInsets.all(0),
      itemCount: data.length,
        itemBuilder: (context, index)=>
            ListTile(
              title: Text(data[index].title, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
              subtitle: Text(data[index].artist),
              leading: SizedBox(
                  height: deviceHeight*0.1,
                  width: deviceWidth*0.13,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(deviceHeight*0.01),
                      child: Image.network(data[index].url,
                        fit: BoxFit.fill, )
                  )
              ),
              trailing: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.add),
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SongScreen(song: data[index],currentIndex: index,)));
              },
            )
    );
  }
}