import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_state.dart';
import 'package:retsept_cherno/data/models/user_model.dart';
import 'package:retsept_cherno/ui/widgets/profile/followers_and_circle_avatar_following_widget.dart';
import 'package:retsept_cherno/ui/widgets/search/build_recipe_card_widget.dart';

class CustomScrollViewWidget extends StatelessWidget {
  final UserModel user;
  final bool isFollowing;
  final int followingCount;
  final ScrollController scrollController;
  final VoidCallback toggleFollow;
  final VoidCallback shareProfile;
  final VoidCallback scrollToTop;

  const CustomScrollViewWidget({
    super.key,
    required this.user,
    required this.isFollowing,
    required this.followingCount,
    required this.scrollController,
    required this.toggleFollow,
    required this.shareProfile,
    required this.scrollToTop,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        BlocBuilder<RetseptBloc, RetseptState>(
          builder: (context, state) {
            if (state is RetseptLoading) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is RetseptError) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(state.message),
                ),
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
                    onPressed: scrollToTop,
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: FollowersAndCircleAvatarFollowingWidget(
                    user,
                    isFollowing: isFollowing,
                    followingCount: followingCount,
                    toggleFollow: toggleFollow,
                    shareProfile: shareProfile,
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
            return const SliverToBoxAdapter(
              child: Center(child: Text("Empty Data")),
            );
          },
        ),
        SliverFillRemaining(
          child: TabBarView(
            children: [
              _buildTabContent(user.posts),
              _buildTabContent(user.favorites),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(List<dynamic> items) {
    return Column(
      children: [
        const SizedBox(height: 120),
        Flexible(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return BuildRecipeCardWidget(
                retseptId: items[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
