import 'package:flutter/material.dart';
import '../models/media.dart';
import '../widgets/grid_view_vertical.dart';
import '../widgets/search_bar.dart';
import '../widgets/title_section.dart';
import '../services/voice_command_service.dart';

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
  final VoiceCommandService _voiceCommandService = VoiceCommandService();

  @override
  void initState() {
    super.initState();
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
    _initializeVoiceCommandService();
  }

  void _initializeVoiceCommandService() async {
    await _voiceCommandService.initialize();
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

  void _startListening() {
    _voiceCommandService.startListening((text) {
      setState(() {
        searchController.text = text;
        _filterMediaItems();
      });
    }, (status) {});
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
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.mic),
              onPressed: _startListening,
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
              onMicPressed: _startListening,
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
