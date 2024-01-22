import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/shared/global.dart';
import 'package:flutter/material.dart';

class FeedListItem extends StatelessWidget {
  final FeedModel model;
  const FeedListItem(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            '${Global.apiRoot}/api/file/${model.imageId}',
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'asset/logo.png',
                width: 100,
                height: 100,
              );
            },
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.title ?? "제목 없음",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(model.content ?? "내용 없음"),
              const SizedBox(height: 6),
              Text(
                '${model.price} 원',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              )
            ],
          ),
        )),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          height: 100,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
              Row(
                children: [
                  Icon(Icons.favorite_border, size: 16),
                  SizedBox(width: 4),
                  Text('4'),
                  SizedBox(width: 6),
                  Icon(Icons.comment_outlined, size: 16),
                  SizedBox(width: 4),
                  Text('2'),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
