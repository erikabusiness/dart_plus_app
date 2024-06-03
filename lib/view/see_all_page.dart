import 'package:dart_plus_app/widgets/title_section.dart';
import 'package:flutter/material.dart';
import '../models/media.dart';
import '../widgets/grid_view_vertical.dart';
import '../widgets/search_bar.dart';
import '../services/voiceControl.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  List<Media> allMediaItems = [];
  List<Media> filteredMediaItems = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String tela = "";
  late VoiceControl voiceControl;

  @override
  void initState() {
    super.initState();
    voiceControl = VoiceControl();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final List<Media> mediaItems = args["medias"] as List<Media>;
      tela = args["tela"] as String;
      setState(() {
        allMediaItems = mediaItems;
        filteredMediaItems = mediaItems;
      });
    });

    searchController.addListener(_filterMediaItems);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterMediaItems);
    searchController.dispose();
    super.dispose();
  }

  void _filterMediaItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredMediaItems = allMediaItems.where((media) {
        return media.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchController.clear();
      }
    });
  }

  void _onVoiceResult(String text) {
    searchController.text = text;
    _filterMediaItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: WidgetTitleSection(title: tela),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          if (isSearching)
            WidgetSearchBar(
              controller: searchController,
              onChanged: (query) {
                _filterMediaItems();
              },
              onMicPressed: () {
                voiceControl.startListening(_onVoiceResult);
              },
            ),
          Expanded(
            child: filteredMediaItems.isNotEmpty
                ? WidgetGridViewVertical(mediaItems: filteredMediaItems)
                : const Center(child: Text('Nenhum dado disponível')),
          ),
        ],
      ),
    );
  }
}
