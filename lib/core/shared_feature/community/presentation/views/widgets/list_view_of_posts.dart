import 'package:canc_app/core/di/dependency_injection.dart';
import 'package:canc_app/core/shared_feature/community/data/models/post_model.dart';
import 'package:canc_app/core/shared_feature/community/data/repositories/community_repository.dart';
import 'package:canc_app/core/shared_feature/community/presentation/views/widgets/post_item.dart';
import 'package:flutter/material.dart';

class ListOfPosts extends StatefulWidget {
  const ListOfPosts({
    super.key,
  });

  @override
  State<ListOfPosts> createState() => _ListOfPostsState();
}

class _ListOfPostsState extends State<ListOfPosts> {
  final CommunityRepository _repository = getIt<CommunityRepository>();
  final List<PostModel> _posts = [];
  bool _isLoading = false;
  String? _error;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _hasMorePosts = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    if (!_hasMorePosts || _isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await _repository.getPosts(
        pageNumber: _currentPage,
        pageSize: 10,
      );

      result.fold(
        (failure) {
          setState(() {
            _error = failure.errorMessage;
            _isLoading = false;
          });
        },
        (newPosts) {
          setState(() {
            _posts.addAll(newPosts);
            _currentPage++;
            _hasMorePosts = newPosts.isNotEmpty;
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _error = null;
                  _posts.clear();
                  _currentPage = 1;
                  _hasMorePosts = true;
                });
                _loadPosts();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_posts.isEmpty && _isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Expanded(
      child: Container(
        color: const Color(0xffD9D9D9),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _posts.clear();
              _currentPage = 1;
              _hasMorePosts = true;
            });
            await _loadPosts();
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _posts.length + (_hasMorePosts ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _posts.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return PostItem(
                post: _posts[index],
                onDelete: () {
                  setState(() {
                    _posts.removeAt(index);
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
