import 'package:cinema_ui_flutter/presentation/widgets/CustomButton/custom_bottom.dart';
import 'package:flutter/material.dart';

import 'package:cinema_ui_flutter/presentation/views/views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndex = 0;
  List<Widget> pages = [];
  void onPressed(int index) {
    setState(() => _pageIndex = index);
  }

  @override
  void initState() {
    super.initState();

    pages = [
      const HomeView(),
      CategoriesView(onPressed: () => onPressed(0)),
      const FavoritesView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: _pageIndex,
              children: pages,
            ),
            if (_pageIndex != 1)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: _NavigationBottomBar(onpressed: onPressed),
              )
          ],
        ),
      ),
    );
  }
}

class _NavigationBottomBar extends StatelessWidget {
  final Function(int) onpressed;
  const _NavigationBottomBar({required this.onpressed});

  @override
  Widget build(BuildContext context) {
    const List<IconData> icons = [
      Icons.home,
      Icons.category,
      Icons.favorite,
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...icons
              .asMap()
              .map(
                (i, e) => MapEntry(
                  i,
                  CustomButton(icon: e, onpressed: () => onpressed(i)),
                ),
              )
              .values
              .toList()
        ],
      ),
    );
  }
}


// import 'package:cinema_ui_flutter/presentation/widgets/CustomButton/custom_bottom.dart';
// import 'package:flutter/material.dart';

// import 'package:cinema_ui_flutter/presentation/views/views.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int currentIndex = 0;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(keepPage: true);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   final List<Widget> _pages = const [
//     HomeView(),
//     FavoritesView(),
//     CategoriesView(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     if (_pageController.hasClients) {
//       _pageController.animateToPage(
//         currentIndex,
//         curve: Curves.easeInOut,
//         duration: const Duration(milliseconds: 250),
//       );
//     }
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             PageView(
//               // physics: const NeverScrollableScrollPhysics(),
//               controller: _pageController,
//               // onPageChanged: (value) {
//               //   setState(() {
//               //     currentIndex = value;
//               //   });
//               // },
//               children: _pages,
//               // itemCount: _pages.length,
//               // itemBuilder: (context, index) => _pages[index],
//             ),
//             Positioned(
//               bottom: 20,
//               left: 20,
//               right: 20,
//               child: _NavigationBottomBar(
//                 onpressed: (i) {
//                   setState(() {
//                     currentIndex = i;
//                   });
//                   // _pageController.jumpToPage(i);
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _NavigationBottomBar extends StatelessWidget {
//   final Function(int) onpressed;
//   const _NavigationBottomBar({required this.onpressed});

//   @override
//   Widget build(BuildContext context) {
//     const List<IconData> icons = [
//       Icons.home,
//       Icons.category,
//       Icons.favorite,
//       // Icons.person,
//     ];

//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           ...icons
//               .asMap()
//               .map(
//                 (i, e) => MapEntry(
//                   i,
//                   // IconButton(
//                   //   onPressed: () => onpressed(i),
//                   //   icon: Icon(
//                   //     e,
//                   //     color: Colors.white60,
//                   //     size: 30,
//                   //   ),
//                   // ),
//                   CustomButton(icon: e, onpressed: () => onpressed(i)),
//                 ),
//               )
//               .values
//               .toList()
//         ],
//       ),
//     );
//   }
// }

