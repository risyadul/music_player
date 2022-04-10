import 'package:flutter/material.dart';
import 'package:music_player/models/artist.dart';

class MusicDetailitem extends StatelessWidget {
  const MusicDetailitem({Key? key, required this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Image.network(artist.artworkUrl),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artist.trackName,
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              artist.artistName,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 5),
            Text(
              artist.collectionName,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.normal),
            )
          ],
        )
      ],
    );
  }
}
