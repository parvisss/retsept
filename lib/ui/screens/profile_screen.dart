import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_state.dart';
import 'package:retsept_cherno/bloc/user/user_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_event.dart';
import 'package:retsept_cherno/bloc/user/user_state.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
import 'package:retsept_cherno/ui/widgets/profile/followers_and_circle_avatar_following_widget.dart';
import 'package:retsept_cherno/ui/widgets/search/build_recipe_card_widget.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool isFollowing = false;
  int followingCount = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<UserBloc>().add(LoadUserDataEvent());
    super.initState();
  }

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
      followingCount += isFollowing ? 1 : -1;
    });
  }

  void _shareProfile() {
    const String profileUrl = 'https://t.me/Flutter_with_Javohir';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: BlocBuilder<RetseptBloc, RetseptState>(
          builder: (context, state) {
            if (state is RetseptLoading) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is RetseptError) {
              return SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.message),
                  ),
                ),
              );
            } else if (state is RetseptLoaded) {
              final List<RetseptModel> retsepts = state.retsepts;
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  BlocBuilder<RetseptBloc, RetseptState>(
                    builder: (context, state) {
                      return SliverAppBar(
                        expandedHeight: 600,
                        pinned: true,
                        floating: false,
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
                            shareProfile: _shareProfile,
                          ),
                        ),
                        bottom: const TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          tabs: [
                            Tab(text: "Posts"),
                            Tab(text: 'Favorites'),
                          ],
                        ),
                      );
                    },
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 120,
                            ),
                            Flexible(
                              child: GridView.builder(
                                padding: const EdgeInsets.all(16.0),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 16.0,
                                ),
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return BuildRecipeCardWidget(
                                    retsept: retsepts.first,
                                  ); // Fixed imagePath parameter
                                },
                              ),
                            ),
                          ],
                        ),
                        const Center(
                          child: Text(
                            "Less Details",
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SliverFillRemaining(
              child: Center(child: Text("Unexpected state")),
            );
          },
        ),
      ),
    );
  }
}
