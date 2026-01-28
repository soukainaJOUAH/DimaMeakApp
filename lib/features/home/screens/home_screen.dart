import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool isVoiceEnabled;

  const HomeScreen({
    super.key,
    required this.isVoiceEnabled,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  @override
  void initState() {
    super.initState();

    if (widget.isVoiceEnabled) {
      // start voice listening
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      // 🔹 AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.notifications_none),
          color: Colors.black87,
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(
                Icons.person,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),

      // 🔹 Body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // 🔍 Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Recherche',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF4F6FB),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            // 🟦 Mes demandes card
            GestureDetector(
              onTap: () {},
              child: Container(
                height: size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0A3D91),
                      Color(0xFF0E7C7B),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // 🔵 Decorative circles
                    Positioned(
                      top: -40,
                      right: -40,
                      child: _Circle(size: 140),
                    ),
                    Positioned(
                      top: 30,
                      right: 20,
                      child: _Circle(size: 80),
                    ),

                    // 🔹 Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mes demandes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Color(0xFF0A3D91),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0E7C7B),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }
}

// 🔵 Decorative circle widget
class _Circle extends StatelessWidget {
  final double size;

  const _Circle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.12),
      ),
    );
  }
}
