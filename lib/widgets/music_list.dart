import 'package:flutter/material.dart';
import 'package:music_player/widgets/music_detail_item.dart';

import '../models/artist.dart';

class MusicList extends StatelessWidget {
  const MusicList(
      {Key? key,
      required this.searchedArtist,
      required this.selectedMusic,
      required this.onMusicSelected})
      : super(key: key);

  final List<Artist> searchedArtist;
  final Artist? selectedMusic;
  final void Function(Artist) onMusicSelected;

  @override
  Widget build(BuildContext context) {
    return searchedArtist.isNotEmpty
        ? Expanded(
            child: ListView.builder(
                itemBuilder: ((context, index) =>
                    musicComponent(searchedArtist[index])),
                itemCount: searchedArtist.length))
        : const Padding(
            padding: EdgeInsets.only(top: 24),
            child: Center(
              child: Text("No Artist Found"),
            ),
          );
  }

  musicComponent(Artist artist) {
    final isSelected = selectedMusic?.previewUrl == artist.previewUrl;
    return InkWell(
      onTap: () => onMusicSelected(artist),
      child: Container(
          color: isSelected ? Colors.grey.shade400 : Colors.grey.shade200,
          child: Padding(
            padding: EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MusicDetailitem(artist: artist),
                    Visibility(
                      visible: selectedMusic?.previewUrl == artist.previewUrl,
                      child: Icon(
                        Icons.graphic_eq,
                        color: Colors.grey.shade600,
                        size: 30,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  thickness: 2,
                  color: Colors.grey.shade400,
                )
              ],
            ),
          )),
    );
  }
}
