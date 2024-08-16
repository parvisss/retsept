import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_event.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_state.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
import 'package:retsept_cherno/ui/widgets/search/build_chef_list_widget.dart';
import 'package:retsept_cherno/ui/widgets/search/build_griw_view_widget.dart';
import 'package:retsept_cherno/ui/widgets/search/build_tag_list_widget.dart';
import 'package:retsept_cherno/ui/widgets/search/filtr_widget.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  String _filterSelection = 'All'; // Default filter selection

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<RetseptBloc, RetseptState>(
          builder: (context, state) {
            if (state is RetseptLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is RetseptError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(state.message),
                ),
              );
            }
            if (state is RetseptLoaded) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.white],
                  ),
                ),
                child: Column(
                  children: [
                    // Search bar and filter button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextField(
                                onChanged: (query) {
                                  setState(() {
                                    _searchQuery = query;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  prefixIcon: Icon(Icons.search),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          FilterWidget(
                            onFilterSelected: (String filter) {
                              setState(() {
                                _filterSelection = filter;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Tab bar
                    const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(text: 'Recipes'),
                        Tab(text: 'Chefs'),
                        Tab(text: 'Tags'),
                        Tab(text: 'All'),
                      ],
                    ),

                    // Expanded grid view for the images
                    Expanded(
                      child: TabBarView(
                        children: [
                          BuildGridViewWidget(
                            searchQuery: _searchQuery,
                            retsepts: _filterRecipes(state.retsepts),
                          ),
                          BuildChefListWidget(
                            searchQuery: _searchQuery,
                            filterSelection: _filterSelection,
                          ),
                          BuildTagListWidget(
                            searchQuery: _searchQuery,
                            filterSelection: _filterSelection,
                          ),
                          // "All" tab content combining all data
                          ListView(
                            children: [
                              if (_filterSelection == 'All' ||
                                  _filterSelection == 'Recipes')
                                Container(
                                  height: 200, // Size it to a specific height
                                  child: BuildGridViewWidget(
                                    searchQuery: _searchQuery,
                                    retsepts: _filterRecipes(state.retsepts),
                                  ),
                                ),
                              if (_filterSelection == 'All' ||
                                  _filterSelection == 'Chefs')
                                Container(
                                  height: 200, // Size it to a specific height
                                  child: BuildChefListWidget(
                                    searchQuery: _searchQuery,
                                    filterSelection: _filterSelection,
                                  ),
                                ),
                              if (_filterSelection == 'All' ||
                                  _filterSelection == 'Tags')
                                Container(
                                  height: 200, // Size it to a specific height
                                  child: BuildTagListWidget(
                                    searchQuery: _searchQuery,
                                    filterSelection: _filterSelection,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Empty data"),
              ),
            );
          },
        ),
      ),
    );
  }

  List<RetseptModel> _filterRecipes(List<RetseptModel> retsepts) {
    if (_filterSelection == 'Recipes' || _filterSelection == 'All') {
      return retsepts;
    }
    return [];
  }
}
