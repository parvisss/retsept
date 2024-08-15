import 'package:flutter/material.dart';
import 'package:retsept_cherno/ui/widgets/profile/followers_and_circle_avatar_following_widget.dart';
import 'package:retsept_cherno/ui/widgets/profile/silver_fill_reamining_widget.dart';
import 'package:share_plus/share_plus.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isFollowing = false;
  int followingCount = 0;
  final ScrollController _scrollController = ScrollController();

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
      followingCount += isFollowing ? 1 : -1;
    });
  }

  void _shareProfile() {
    final String profileUrl = 'https://t.me/Flutter_with_Javohir';
    Share.share('Check out this amazing chef profile!\n$profileUrl');
    Navigator.pushNamed(context, '/profile');
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 500,
                pinned: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: _scrollToTop,
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: FollowersAndCircleAvatarFollowingWidget(
                    isFollowing: isFollowing,
                    followingCount: followingCount,
                    toggleFollow: _toggleFollow,
                    shareProfile: () => _shareProfile(),
                  ),
                ),
                bottom: const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Posts"),
                    Tab(text: 'Less Details'),
                  ],
                ),
              ),
              const SilverFillReaminingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
