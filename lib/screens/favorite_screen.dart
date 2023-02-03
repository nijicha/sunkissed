import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sunkissed/main.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<AppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ${appState.favorites.length} favorites:'),
        ),
        Expanded(
          // Make better use of wide windows with a grid.
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: [
              for (var wordPair in appState.favorites)
                ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.close_rounded, semanticLabel: 'Delete'),
                    color: theme.colorScheme.primary,
                    onPressed: () {
                      appState.removeFavorite(wordPair);
                    },
                  ),
                  title: Text(
                    wordPair.asLowerCase,
                    semanticsLabel: wordPair.asPascalCase,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}