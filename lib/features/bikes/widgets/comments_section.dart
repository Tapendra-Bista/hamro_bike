import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/utils/timestamps_convertor.dart';
import 'package:hamro_bike/features/authentication/controllers/authentication_controllers.dart';
import 'package:hamro_bike/features/bikes/controller/bikes_controller.dart';
import 'package:hamro_bike/features/bikes/model/comment_model.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:hamro_bike/features/profile/controller/profile_controller.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({
    super.key,
    required this.bike,
    required this.controller,
  });

  final CreatePostModel bike;
  final BikesController controller;

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _commentController = TextEditingController();
  ProfileController? _profileController;
  AuthenticationController? _authController;

  @override
  void initState() {
    super.initState();
    try {
      _profileController = Get.find<ProfileController>();
      _authController = Get.find<AuthenticationController>();
    } catch (e) {
      // Controllers not found, will handle gracefully
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;

    final userName =
        _profileController?.userProfile?.name ?? CommentsStrings.anonymous;
    final userProfile = _profileController?.userProfile?.profile ?? '';

    widget.controller.addComment(
      postId: widget.bike.postId,
      comment: _commentController.text.trim(),
      userName: userName,
      userProfile: userProfile,
    );

    _commentController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Text(
            CommentsStrings.comments,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: ConstantColors.secondaryButtonColor,
            ),
          ),
        ),

        // Comments List - Scrollable
        Expanded(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: widget.controller.getComments(widget.bike.postId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ConstantColors.primaryButtonColor,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    CommentsStrings.noCommentsYet,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: ConstantColors.secondaryTextColor,
                    ),
                  ),
                );
              }

              final comments = snapshot.data!
                  .map((data) => CommentModel.fromJson(data))
                  .toList();

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  final isOwnComment =
                      comment.userId == _authController?.currentUserId;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Profile Picture
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: comment.userProfile,
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[800],
                              child: const Icon(Icons.person),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[800],
                              child: const Icon(Icons.person),
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        // Comment Content
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: ConstantColors.containerColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        comment.userName,
                                        style: context.textTheme.bodySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: ConstantColors
                                                  .secondaryButtonColor,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (isOwnComment)
                                      InkWell(
                                        onTap: () {
                                          widget.controller.deleteComment(
                                            widget.bike.postId,
                                            comment.commentId,
                                          );
                                        },
                                        child: Icon(
                                          Icons.delete_outline,
                                          size: 16.sp,
                                          color: Colors.red,
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  comment.comment,
                                  style: context.textTheme.bodySmall,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  TimestampConverter.formatTimeAgo(
                                    comment.timestamp,
                                  ),
                                  style: context.textTheme.bodySmall!.copyWith(
                                    fontSize: 10.sp,
                                    color: ConstantColors.secondaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Comment Input - Fixed at bottom
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(color: ConstantColors.containerColor, width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  style: context.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: CommentsStrings.addCommentHint,
                    hintStyle: context.textTheme.bodySmall!.copyWith(
                      color: ConstantColors.secondaryTextColor,
                    ),
                    filled: true,
                    fillColor: ConstantColors.containerColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                  ),
                  maxLines: null,
                ),
              ),
              SizedBox(width: 8.w),
              CircleAvatar(
                radius: 20.r,
                backgroundColor: ConstantColors.primaryButtonColor,
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 18),
                  onPressed: _addComment,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
