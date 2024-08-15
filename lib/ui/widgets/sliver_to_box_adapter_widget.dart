import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SliverToBoxAdapterWidget extends StatefulWidget {
  const SliverToBoxAdapterWidget({super.key});

  @override
  State<SliverToBoxAdapterWidget> createState() =>
      _SliverToBoxAdapterWidgetState();
}

class _SliverToBoxAdapterWidgetState extends State<SliverToBoxAdapterWidget> {
  @override
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
    final String apkUrl =
        'https://your-file-sharing-service.com/app-release.apk';
    Share.share('Download the app here: $apkUrl');
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 220.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/food2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 16.0,
                bottom: 16.0,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(
                        '4.9',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 180.0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Column(
                        children: [
                          Text(
                            '15K',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 120),
                      Column(
                        children: [
                          Text(
                            '$followingCount',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Following',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 130.0,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 4.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/chef2.png'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60.0),
          const Text(
            'Celina Damon',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Toronto, Canada',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'To cook is to see how simple ingredients can create magic on the plate.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleFollow,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(128, 40),
                  backgroundColor: isFollowing ? Colors.grey : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  isFollowing ? 'Unfollow' : 'Follow',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 16.0),
              OutlinedButton(
                onPressed: _shareProfile,
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(150, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'Share Profile',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Posts"),
              Tab(text: 'Less Details'),
              Tab(text: 'More Details'),
            ],
          ),
        ],
      ),
    );
  }
}
