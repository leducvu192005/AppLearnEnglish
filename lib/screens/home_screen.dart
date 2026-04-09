import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  double progress = 0.0;
  int completed = 0;
  int total = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final quizSnapshot = await _firestore.collection('quizzes').get();
      total = quizSnapshot.docs.length;

      int done = 0;
      final userProgress = await _firestore
          .collection('users')
          .doc(uid)
          .collection('progress')
          .get();

      for (var doc in userProgress.docs) {
        final data = doc.data();
        if ((data['percent'] ?? 0) > 0) done++;
      }

      setState(() {
        completed = done;
        progress = total == 0 ? 0 : completed / total;
        isLoading = false;
      });
    } catch (e) {
      print('❌ Lỗi tải tiến độ: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Xin chào   ${user?.email?.split('@').first ?? 'Người học'} 👋\nHãy bắt đầu học nào",
          style: const TextStyle(
            fontWeight: FontWeight.bold,

            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _loadProgress,
            icon: const Icon(Icons.refresh, color: Colors.black54),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🌟 Tiến độ học tập
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tiến độ học tập của bạn",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: progress,
                          borderRadius: BorderRadius.circular(8),
                          minHeight: 10,
                          color: Colors.blueAccent,
                          backgroundColor: Colors.blueAccent.withOpacity(0.2),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "$completed / $total Bài flashcard đã hoàn thành (${(progress * 100).toStringAsFixed(0)}%)",
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Luyện tập kỹ năng",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildSkillCard(
                          title: "Nghe",
                          icon: Icons.hearing_rounded,
                          gradient: [Colors.blueAccent, Colors.lightBlue],
                          onTap: () =>
                              Navigator.pushNamed(context, '/skills/listening'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSkillCard(
                          title: "Nói",
                          icon: Icons.mic_rounded,
                          gradient: [Colors.pinkAccent, Colors.redAccent],
                          onTap: () =>
                              Navigator.pushNamed(context, '/skills/speaking'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSkillCard(
                          title: "Đọc",
                          icon: Icons.menu_book_rounded,
                          gradient: [Colors.green, Colors.lightGreen],
                          onTap: () =>
                              Navigator.pushNamed(context, '/skills/reading'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSkillCard(
                          title: "Viết",
                          icon: Icons.edit_note_rounded,
                          gradient: [Colors.indigoAccent, Colors.blueGrey],
                          onTap: () =>
                              Navigator.pushNamed(context, '/skills/writing'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Danh mục học tập",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // 📚 Danh mục (hiển thị dạng grid)
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildCategoryCard(
                        title: "Từ vựng",
                        icon: Icons.book_rounded,
                        gradient: [Colors.greenAccent, Colors.teal],
                        onTap: () =>
                            Navigator.pushNamed(context, '/vocabulary'),
                      ),
                      _buildCategoryCard(
                        title: "Quiz",
                        icon: Icons.quiz_rounded,
                        gradient: [Colors.orangeAccent, Colors.deepOrange],
                        onTap: () => Navigator.pushNamed(context, '/quiz'),
                      ),
                      // 🆕 Thêm card dẫn đến trang quá trình
                      _buildCategoryCard(
                        title: "Quá trình học",
                        icon: Icons.trending_up,
                        gradient: [Colors.purpleAccent, Colors.deepPurple],
                        onTap: () => Navigator.pushNamed(context, '/progress'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  // 🔹 Card kỹ năng
  Widget _buildSkillCard({
    required String title,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Card danh mục (Từ vựng, Quiz, Quá trình)
  Widget _buildCategoryCard({
    required String title,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 36),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
