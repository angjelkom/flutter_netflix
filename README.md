# 🚀 Netflix UI Clone in Flutter using BloC

![Backdrop](https://user-images.githubusercontent.com/9529847/200143091-d3d65ea0-128d-4adc-800f-369158b11f71.png)

The Project uses BloC package to manage the state and GoRouter for navigation. It use the awesome [TMDB](https://www.themoviedb.org/) [API](https://www.themoviedb.org/documentation/api) to fetch the needed tv shows and movie data.

The main purpose of this project is to demonstrate the usage of BloC and GoRouter combined but even more to demonstrate Slivers usage in Flutter. It heavily depends on Slivers, like CustomScrollView, SliverList, GridView, SliverAppBar and even SliverPersistentHeader. It also has a BottomBarNavigation nicely implemented with GoRouter's ShellRoute. Apart from that it uses Hero Widgets in order to animate a simple small transition when moving from Home -> Tv Shows and a CustomPainter to replicate the smiley faces on the profiles.

It contains various screens like Profile Selection, Home, New & Hot, Movie and Tv Show Details Page.

Apart from that the project implements custom App Icon and Splash Screen and on Android it uses the new Android 12 API for showing Splash screen.

NOTE: This project is not a complete Netflix UI Clone but I would say it's the most "complete" compared to other on the internet which in their way are awesome as well!

# Download
For those that want to have a quick look at the app you can download and install the apk on an android device or emulator from [Releases](https://github.com/angjelkom/flutter_netflix/releases/download/v1.0.0/flutter-netflix-v1.0.0.apk).

# Running
1. Get Packages
```dart
flutter pub get
```
2. Get an API key from [TMDB](https://www.themoviedb.org/documentation/api) and replace it in `lib/api/api.dart`
```dart
final apiKey = 'INSERT_YOUR_API_KEY_HERE';
```
3. Run App
```dart
flutter run --release
```

# Links

[Netflix Clone in Flutter using BloC, GoRouter and TMDB - Medium](https://medium.com/@angjelkom/netflix-clone-in-flutter-using-bloc-gorouter-and-tmdb-2eeff4d22a75)

[TMDB Site](https://www.themoviedb.org/)

[TMDB API](https://www.themoviedb.org/documentation/api)


# Credits
<section style="display:flex;justify-content:space-around;align-items:center;">
<a href="https://www.themoviedb.org/" target="_blank"><img alt="The Movie DB" width="300px" src="https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg" /></a>
<a href="https://flutter.dev/" target="_blank"><img alt="Flutter" width="300px" src="https://user-images.githubusercontent.com/9529847/200143348-055a2186-8019-43a1-8efc-39d7ffd888ba.svg" /></a>
<a href="https://netflix.com/" target="_blank"><img alt="Netflix" width="300px" src="https://user-images.githubusercontent.com/9529847/200143140-67eec42b-fada-4c48-8183-6e3cd650a674.png" /></a>
</section>

# Licence
flutter_netflix is Licenced under the [MIT Licence](https://github.com/echonox/main/LICENSE)
