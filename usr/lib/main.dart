import 'package:flutter/material.dart';

void main() {
  runApp(const FoolOfStarApp());
}

class FoolOfStarApp extends StatelessWidget {
  const FoolOfStarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fool of star',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          secondary: Color(0xFFB388FF),
          surface: Color(0xFF121212),
          background: Color(0xFF0A0A0A),
        ),
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        '/home': (context) => const MainScaffold(),
      },
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 80, color: Color(0xFF00E5FF)),
            const SizedBox(height: 24),
            Text(
              'fool of star',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Zero-Knowledge Enterprise Security',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 64),
            ElevatedButton.icon(
              icon: const Icon(Icons.fingerprint, size: 28),
              label: const Text('Tap to Authenticate'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: const Color(0xFF00E5FF).withOpacity(0.1),
                foregroundColor: const Color(0xFF00E5FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Color(0xFF00E5FF)),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'End-to-End Encrypted',
              style: TextStyle(fontSize: 12, color: Colors.white38),
            )
          ],
        ),
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _views = [
    const DashboardView(),
    const WalletTradeView(),
    const AiAssistantView(),
    const VaultView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _views[_currentIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF121212),
        indicatorColor: const Color(0xFF00E5FF).withOpacity(0.2),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.swap_horiz_outlined), selectedIcon: Icon(Icons.swap_horiz), label: 'Trade'),
          NavigationDestination(icon: Icon(Icons.smart_toy_outlined), selectedIcon: Icon(Icons.smart_toy), label: 'AI Agent'),
          NavigationDestination(icon: Icon(Icons.lock_outline), selectedIcon: Icon(Icons.lock), label: 'Vault'),
        ],
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Unified Balance', style: TextStyle(color: Colors.white54, fontSize: 16)),
                SizedBox(height: 4),
                Text('\$142,500.00', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
              ],
            ),
            CircleAvatar(
              backgroundColor: const Color(0xFF00E5FF).withOpacity(0.1),
              child: const Icon(Icons.person, color: Color(0xFF00E5FF)),
            )
          ],
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(child: _buildActionButton(Icons.send, 'Send')),
            const SizedBox(width: 16),
            Expanded(child: _buildActionButton(Icons.qr_code_scanner, 'Scan')),
            const SizedBox(width: 16),
            Expanded(child: _buildActionButton(Icons.call_received, 'Receive')),
          ],
        ),
        const SizedBox(height: 32),
        const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTransactionTile('AI Trade Executed', 'Swapped USD to App Coin', '+\$450.00', Colors.greenAccent),
        _buildTransactionTile('Sent to Sarah', 'Lunch split', '-\$15.00', Colors.white),
        _buildTransactionTile('Encrypted Brokerage', 'Auto-split 1% fee', '-\$4.50', Colors.white38),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF00E5FF)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(String title, String subtitle, String amount, Color amountColor) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF1E1E1E),
        child: Icon(Icons.compare_arrows, color: amountColor == Colors.greenAccent ? Colors.greenAccent : Colors.white),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      trailing: Text(amount, style: TextStyle(color: amountColor, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}

class WalletTradeView extends StatelessWidget {
  const WalletTradeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Global Swap Engine', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Zero slippage. Instant settlement.', style: TextStyle(color: Colors.white54)),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pay', style: TextStyle(color: Colors.white54)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('1,000.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      children: [
                        Icon(Icons.attach_money, size: 16),
                        SizedBox(width: 4),
                        Text('USD', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: Icon(Icons.arrow_downward, color: Color(0xFF00E5FF))),
              ),
              const Text('Receive', style: TextStyle(color: Colors.white54)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('990.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Color(0xFFB388FF)),
                        SizedBox(width: 4),
                        Text('FSC (App Coin)', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('Note: A flat 1% encrypted brokerage fee is applied and automatically split into operational, FD, security, and backup funds.', style: TextStyle(fontSize: 12, color: Colors.white38), textAlign: TextAlign.center),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E5FF),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () {},
            child: const Text('Execute Trade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}

class AiAssistantView extends StatelessWidget {
  const AiAssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          color: const Color(0xFF1E1E1E),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Personal AI Assistant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Local, Privacy-First Intelligence', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 12)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildChatBubble('Hello! I am your secure financial assistant. How can I help you today?', isMe: false),
              _buildChatBubble('Exchange 100 USD into the native App Coin.', isMe: true),
              _buildChatBubble('Executing secure transfer with 0 slippage. 1% network fee applied invisibly. Done.', isMe: false),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF1E1E1E),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'e.g., Send \$15 to Sarah...',
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  backgroundColor: const Color(0xFF00E5FF),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildChatBubble(String text, {required bool isMe}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF00E5FF).withOpacity(0.2) : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
          ),
          border: isMe ? Border.all(color: const Color(0xFF00E5FF).withOpacity(0.5)) : null,
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? const Color(0xFF00E5FF) : Colors.white),
        ),
      ),
    );
  }
}

class VaultView extends StatelessWidget {
  const VaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Row(
          children: [
            Icon(Icons.shield, color: Color(0xFFB388FF), size: 28),
            SizedBox(width: 12),
            Text('DigiLocker Vault', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        const Text('Zero-Trust, End-to-End Encrypted Document Storage', style: TextStyle(color: Colors.white54)),
        const SizedBox(height: 32),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _buildDocCard(Icons.badge, 'National ID', 'Verified'),
            _buildDocCard(Icons.drive_eta, 'Driver License', 'Verified'),
            _buildDocCard(Icons.account_balance, 'Tax Records', 'Encrypted'),
            _buildDocCard(Icons.add, 'Add Document', 'Secure Upload'),
          ],
        )
      ],
    );
  }

  Widget _buildDocCard(IconData icon, String title, String status) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: const Color(0xFFB388FF)),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(status, style: const TextStyle(fontSize: 12, color: Colors.white54)),
        ],
      ),
    );
  }
}
