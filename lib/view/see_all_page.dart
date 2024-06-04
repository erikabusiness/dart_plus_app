import 'package:flutter/material.dart';
import '../models/media.dart';
import '../services/VoiceCommandService.dart';
import '../widgets/grid_view_vertical.dart';
import '../widgets/search_bar.dart';
import '../widgets/title_section.dart';

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
  late VoiceCommandService voiceCommandService;

  @override
  void initState() {
    super.initState();
    voiceCommandService = VoiceCommandService();
    voiceCommandService.initialize();

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
    setState(() {
      searchController.text = text;
    });
    _filterMediaItems();
  }

  void _onVoiceStatus(String status) {
    print('Voice status: $status');
  }

  void _startListening() {
    voiceCommandService.startListening(_onVoiceResult, _onVoiceStatus);
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
