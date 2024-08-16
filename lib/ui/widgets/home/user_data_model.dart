import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_bloc.dart';
import 'package:retsept_cherno/bloc/user/user_state.dart';
import 'package:retsept_cherno/data/models/user_model.dart';
import 'package:retsept_cherno/ui/screens/profile_screen.dart';

class UserDataModel extends StatelessWidget {
  const UserDataModel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          UserModel user = UserModel.fromJson(state.userData);
          return InkWell(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      user.image), // Replace with your actual image asset
                  radius: 20.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  user.name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.black, size: 12.0),
                      const SizedBox(width: 4.0),
                      Text(
                        user.rate.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProfileScreen(user),),);
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
