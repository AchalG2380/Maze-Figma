import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';

class NewsItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String website;
  final String time;

  const NewsItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.website,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.lightDarkBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(4.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: AppColor.lightDarkBackground,
                    child: const Icon(
                      Icons.newspaper,
                      color: AppColor.textSecondary,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    website,
                    style: const TextStyle(
                      color: AppColor.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.bookmark_border,
                        color: AppColor.textPrimary,
                        size: 23,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
