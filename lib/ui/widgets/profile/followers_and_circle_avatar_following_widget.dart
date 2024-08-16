import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_state.dart';
import 'package:retsept_cherno/data/models/user_model.dart';
import 'dart:ui'; // Import to use ImageFilter

class FollowersAndCircleAvatarFollowingWidget extends StatelessWidget {
  final bool isFollowing;
  final int followingCount;
  final VoidCallback toggleFollow;
  final VoidCallback shareProfile;

  const FollowersAndCircleAvatarFollowingWidget({
    required this.isFollowing,
    required this.followingCount,
    required this.toggleFollow,
    required this.shareProfile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          UserModel user = UserModel.fromJson(state.userData);
          return Stack(
            children: [
              // Background image container with blur effect and fixed height
              Container(
                height: 300.0, // Fixed height for the background image
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      user.image,
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),

              // Rest of the content
              Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Column(
                  children: [
                    Container(
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
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
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
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
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
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: toggleFollow,
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(128, 40),
                            backgroundColor:
                                isFollowing ? Colors.grey : Colors.black,
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
                          onPressed: shareProfile,
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
                  ],
                ),
              ),
              // Positioned rounded image
              Positioned(
                top: 200.0 - 50, // Adjust based on your layout
                left: MediaQuery.of(context).size.width / 2 - 75,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4.0),
                    image: DecorationImage(
                      image: NetworkImage(user.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const Center();
      },
    );
  }
}
