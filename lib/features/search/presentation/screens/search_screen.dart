import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/recent_searchs.dart';
import '../widgets/search_header.dart';
import '../widgets/search_results.dart';
import '../widgets/tags_bar.dart';

class SearchScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            spacing: 16.h,
            children: [
              SearchHeader(
                controller: _controller,
                focusNode: _focusNode,
              ),
              TagsBar(
                onTagSelected: (value) {},
              ),
              // RecentSearchs(onSearchSelected: (value) {}),
              const Expanded(child: SearchResults()),
            ],
          ),
        ),
      ),
    );
  }
}
