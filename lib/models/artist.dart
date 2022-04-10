class Artist {
  final String artistName;
  final String collectionName;
  final String trackName;
  final String previewUrl;
  final String artworkUrl;
  Artist(this.artistName, this.collectionName, this.trackName, this.previewUrl,
      this.artworkUrl);

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(json['artistName'], json['collectionName'], json['trackName'],
        json['previewUrl'], json['artworkUrl100']);
  }
}
