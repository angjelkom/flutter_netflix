import 'package:flutter/material.dart';
import 'package:flutter_netflix/model/episode.dart';
import 'package:flutter_netflix/widgets/poster_image.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EpisodeBox extends StatelessWidget {
  const EpisodeBox(
      {super.key,
      required this.episode,
      this.laughs,
      this.fill = false,
      this.padding});

  final Episode episode;
  final int? laughs;
  final bool fill;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: PosterImage(episode: episode, width: 110.0),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${episode.episodeNumber}. ${episode.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '58m',
                    style:
                        TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
                  )
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(LucideIcons.download))
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          episode.overview ?? episode.name,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 32.0,
        )
      ],
    );
  }
}
