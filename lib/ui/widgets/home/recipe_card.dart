import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_event.dart';
import 'package:retsept_cherno/data/models/coment_model.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
import 'package:retsept_cherno/ui/widgets/home/controller/coment_controller.dart';
import 'package:retsept_cherno/ui/widgets/home/controller/like_controller.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({super.key, required this.retsept});
  final RetseptModel retsept;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  int likesLocal = 0;
  int comentLocal = 0;
  bool liked = false;
  @override
  void initState() {
    context.read<RetseptBloc>().add(LoadRetsepts());
    likesLocal = widget.retsept.likes;
    comentLocal = widget.retsept.coments.length;
    super.initState();
  }

  final comentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Recipe Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.retsept.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
              ),
              Positioned(
                bottom: 8.0,
                left: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 12.0),
                      const SizedBox(width: 4.0),
                      Text(
                        widget.retsept.rate.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 8.0,
                right: 8.0,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        liked
                            ? Icons.favorite_border
                            : Icons
                                .favorite, // Update icon based on liked state
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final updatedLikes =
                            await LikeController().handleLikeButton(
                          retseptId: widget.retsept.id,
                          likesLocal: likesLocal,
                          isLike: liked,
                        );

                        setState(() {
                          likesLocal =
                              updatedLikes; // Update the local like count
                          liked = !liked; // Toggle the liked state
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Chef Information
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/chef2.png'), // Replace with your actual image asset
                radius: 20.0,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Kelly Mayer',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: Colors.black, size: 12.0),
                    SizedBox(width: 4.0),
                    Text(
                      '4.8',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Recipe Title
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              widget.retsept.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Recipe Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoChip(
                  Icons.local_fire_department, widget.retsept.dietaryTarget),
              _buildInfoChip(Icons.fastfood, widget.retsept.difficulty),
              _buildInfoChip(Icons.timer, widget.retsept.preparationTime),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildInfoChip(Icons.favorite, likesLocal.toString()),
              const SizedBox(width: 10),
              _buildInfoChip(Icons.comment, comentLocal.toString()),
            ],
          ),
          const SizedBox(height: 16.0),
          // Tabs
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar( 
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Preparation'),
                    Tab(text: 'Ingredients'),
                    Tab(text: 'Comments'),
                  ],
                ),
                SizedBox(
                  height: 400.0,
                  child: TabBarView(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.retsept.preparation.length,
                          itemBuilder: (ctx, index) {
                            // print(retsept.coments);
                            return _buildPreperation(
                              widget.retsept.preparation[index],
                            );
                          },
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.retsept.ingredients.length,
                          itemBuilder: (ctx, index) {
                            // print(retsept.coments);
                            return _buildIngredients(
                                widget.retsept.ingredients[index]);
                          },
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: widget.retsept.coments.length,
                                itemBuilder: (ctx, index) {
                                  // print(retsept.coments);
                                  return _buildComment(
                                    ComentModel.fromJson(
                                        widget.retsept.coments[index]),
                                  );
                                },
                                padding: const EdgeInsets.all(8.0),
                              ),
                            ),
                            TextField(
                              controller: comentController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 217, 229, 240),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    int updatedLocalComment =
                                        await ComentControllr().sendConment(
                                            retseptId: widget.retsept.id,
                                            coment: comentController.text);
                                    comentController.text = '';
                                    comentLocal++;
                                    setState(() {
                                      comentLocal = updatedLocalComment;
                                    });
                                  },
                                  icon: const Icon(Icons.send),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16.0),
      label: Text(label),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildComment(ComentModel comet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.person,
                size: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                comet.sender,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Text(comet.title),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(comet.date),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.calendar_month,
                size: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIngredients(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8.0),
          Expanded(
            child: Expanded(
              child: ListTile(
                leading: const Icon(Icons.circle),
                title: Text(text),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreperation(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8.0),
          Expanded(
            child: ListTile(
              leading: const Icon(Icons.circle),
              title: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
