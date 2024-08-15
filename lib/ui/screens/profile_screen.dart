import 'package:flutter/material.dart';
import 'package:retsept_cherno/ui/screens/tadbox_screen.dart';
import 'package:retsept_cherno/ui/widgets/followers_and_circle_avatar_following_widget.dart';
import 'package:retsept_cherno/ui/widgets/silver_fill_reamining_widget.dart';
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
    // Profil URL-manzili
    final String profileUrl = 'https://t.me/Flutter_with_Javohir';

    // Profilni ulashish

    Share.share('Check out this amazing chef profile!\n$profileUrl');

    // Profil sahifasiga o'tish
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: _scrollToTop,
            ),
          ],
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  FollowersAndCircleAvatarFollowingWidget(
                    isFollowing: isFollowing,
                    followingCount: followingCount,
                    toggleFollow: _toggleFollow,
                    shareProfile: () => _shareProfile(),
                  ),
                  const SizedBox(height: 24.0),
                  const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Posts"),
                      Tab(text: 'Less Details'),
                    ],
                  ),
                ],
              ),
            ),
            const SilverFillReaminingWidget(),
          ],
        ),
       
      ),
    );
  }
}
