import 'package:flutter/material.dart';

import '../activity/activity_screen.dart';
import '../more/more_screen.dart';
import '../saved/saved_screen.dart';
import '../search/search_screen.dart';
import 'widgets/community_tab.dart';
import 'widgets/for_you_tab.dart';
import 'widgets/wiki_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  int _homeTab = 0;

  final List<Widget> _pages = const [
    SizedBox.shrink(),
    SavedScreen(),
    SearchScreen(),
    ActivityScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isForYou = _selectedPage == 0 && _homeTab == 1;
    return Scaffold(
      backgroundColor: isForYou ? const Color(0xFF061B17) : Colors.white,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _selectedPage,
          children: [
            _HomeContent(
              selectedTab: _homeTab,
              onTabChanged: (index) => setState(() => _homeTab = index),
            ),
            ..._pages.skip(1),
          ],
        ),
      ),
      bottomNavigationBar: WikiBottomNavigation(
        selectedIndex: _selectedPage,
        dark: isForYou,
        onTap: (index) => setState(() => _selectedPage = index),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.selectedTab, required this.onTabChanged});

  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final dark = selectedTab == 1;
    return Column(
      children: [
        _WikiHeader(dark: dark),
        _HomeTabs(
          selectedTab: selectedTab,
          dark: dark,
          onChanged: onTabChanged,
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: selectedTab == 0
                ? const CommunityTab(key: ValueKey('community'))
                : const ForYouTab(key: ValueKey('for-you')),
          ),
        ),
      ],
    );
  }
}

class _WikiHeader extends StatelessWidget {
  const _WikiHeader({required this.dark});
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final foreground = dark ? Colors.white : const Color(0xFF202122);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 18, 8),
      child: SizedBox(
        height: 62,
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Wikipiye',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 31,
                  letterSpacing: -1.2,
                  color: foreground,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.notifications_none, size: 30, color: foreground),
                Positioned(
                  right: -8,
                  top: -8,
                  child: Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB32424),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabs extends StatelessWidget {
  const _HomeTabs({
    required this.selectedTab,
    required this.dark,
    required this.onChanged,
  });
  final int selectedTab;
  final bool dark;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final foreground = dark ? Colors.white : const Color(0xFF202122);
    final muted = dark ? const Color(0xFFB8C7C3) : const Color(0xFF54595D);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 18, 12),
      child: Row(
        children: [
          _TabLabel(
            label: 'Community',
            selected: selectedTab == 0,
            dark: dark,
            onTap: () => onChanged(0),
          ),
          const SizedBox(width: 26),
          _TabLabel(
            label: 'For you',
            selected: selectedTab == 1,
            dark: dark,
            onTap: () => onChanged(1),
          ),
          const Spacer(),
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: dark ? const Color(0xFF9DB2AD) : const Color(0xFF72777D),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: dark
                        ? const Color(0xFFB8C7C3)
                        : const Color(0xFF54595D),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'ID',
                    style: TextStyle(
                      color: dark ? const Color(0xFF061B17) : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: muted, size: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.label,
    required this.selected,
    required this.dark,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final bool dark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final active = dark ? Colors.white : const Color(0xFF3366CC);
    final inactive = dark ? const Color(0xFFEAF0EE) : const Color(0xFF202122);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? active : inactive,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 3,
              width: selected ? (label == 'Community' ? 74 : 48) : 0,
              decoration: BoxDecoration(
                color: active,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
