import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.onArtistSearch}) : super(key: key);

  final void Function(String) onArtistSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          onArtistSearch.call(value);
        },
        style: TextStyle(color: Colors.grey.shade700),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade700,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          hintText: "Search Artist",
        ),
      ),
    );
  }
}
