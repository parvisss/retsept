import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_state.dart';
import 'package:retsept_cherno/bloc/user/user_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_event.dart';
import 'package:retsept_cherno/bloc/user/user_state.dart';
import 'package:retsept_cherno/data/models/user_model.dart';
import 'package:retsept_cherno/ui/widgets/home/custom_scroll_view_widget.dart';
import 'package:retsept_cherno/ui/widgets/profile/followers_and_circle_avatar_following_widget.dart';
import 'package:retsept_cherno/ui/widgets/search/build_recipe_card_widget.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen(this.user, {super.key});
  UserModel? user;

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool isFollowing = false;
  int followingCount = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (widget.user == null) {
      context.read<UserBloc>().add(LoadUserDataEvent());
    }
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
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is UserError) {
              return SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.message),
                  ),
                ),
              );
            } else if (state is UserLoaded) {
              // Ensure that posts and favorites are List<String>
              List<String> posts = state.userData['posts']
                  .map<String>((item) => item.toString())
                  .toList();
              List<String> favorites = state.userData['favorites']
                  .map<String>((item) => item.toString())
                  .toList();

              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  BlocBuilder<RetseptBloc, RetseptState>(
                    builder: (context, state) {
                      if (state is RetseptLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is RetseptError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      if (state is RetseptLoaded) {
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
                              widget.user,
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
                      }
                      return const Center(
                        child: Text("Empty Data"),
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
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  return BuildRecipeCardWidget(
                                    retseptId: posts[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
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
                                itemCount: favorites.length,
                                itemBuilder: (context, index) {
                                  return BuildRecipeCardWidget(
                                    retseptId: favorites[index],
                                  );
                                },
                              ),
                            ),
                          ],
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
