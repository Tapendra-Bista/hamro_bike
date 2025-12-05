import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/routes/routes_name.dart';

import '../../create_post/model/create_post_model.dart';
import '../controller/your_ads_controller.dart';
import '../widgets/bottom_sheet_screen.dart';

class SmoothSlideTile extends StatefulWidget {
  const SmoothSlideTile({super.key, required this.child, required this.ad});

  final Widget child; // the main content of the tile
  final CreatePostModel ad;
  @override
  State<SmoothSlideTile> createState() => _SmoothSlideTileState();
}

class _SmoothSlideTileState extends State<SmoothSlideTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double maxSlide = 130; // total width of action buttons

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      lowerBound: 0,
      upperBound: 1,
    );
  }

  void _open() => _controller.forward();
  void _close() => _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (d) {
        _controller.value -= d.delta.dx / maxSlide;
      },
      onHorizontalDragEnd: (d) {
        if (_controller.value > 0.5) {
          _open();
        } else {
          _close();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double slide = _controller.value * maxSlide;

          return Stack(
            children: [
              // ACTIONS (only visible when sliding)
              if (_controller.value > 0)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ClipRect(
                      child: SizedBox(
                        width: slide,
                        child: ActionWidgets(ad: widget.ad),
                      ),
                    ),
                  ),
                ),

              // FRONT TILE
              Transform.translate(
                offset: Offset(-slide, 0),
                child: widget.child,
              ),
            ],
          );
        },
      ),
    );
  }
}

class ActionWidgets extends StatelessWidget {
  const ActionWidgets({super.key, required this.ad});

  final CreatePostModel ad;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<YourAdsController>();
    return Container(
      padding: EdgeInsets.only(right: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.blue),
            onPressed: () async {
              final result = await Get.toNamed(
                RoutesName.createPost,
                arguments: {'editMode': true, 'post': ad},
              );

              // Refresh list if post was updated
              if (result == true) {
                controller.fetchYourAds();
              }
            },
          ),
          SizedBox(width: 10.w),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () async {
              final confirmed = await Get.dialog<bool>(
                AlertDialog(
                  backgroundColor: ConstantColors.containerColor,
                  title: const Text('Delete Post'),
                  content: const Text(
                    'Are you sure you want to delete this post?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(result: false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Get.back(result: true),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                await controller.deletePost(ad.postId);
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.ad});

  final CreatePostModel ad;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: ConstantColors.containerColor,
      onTap: () {
        showModalBottomSheet(
          backgroundColor: ConstantColors.dividersColor,
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          builder: (context) {
            return BottomSheetScreen(ad: ad);
          },
        );
      },
      contentPadding: EdgeInsets.only(right: 12.w, bottom: 0, top: 0),
      horizontalTitleGap: 10.w,

      // Leading Image
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: CachedNetworkImage(
          height: 65.h,
          width: 65.w,
          fit: BoxFit.cover,
          imageUrl: ad.imageUrls.first,
          placeholder: (context, url) => SizedBox(
            height: 25.w,
            width: 25.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor: AlwaysStoppedAnimation<Color>(
                ConstantColors.primaryButtonColor,
              ),
            ),
          ),
        ),
      ),

      // Title
      title: Text(
        ad.title,
        style: context.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: ConstantColors.secondaryButtonColor,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),

      // Subtitle
      subtitle: Text(
        ad.description,
        style: context.textTheme.bodySmall,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
