import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FreeToolsSection extends StatelessWidget {
  const FreeToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ToolItem> tools = [
      _ToolItem(
        badge: "LOANS",
        badgeBg: const Color(0xFFD1FAE5), // bg-green-100
        badgeText: const Color(0xFF047857), // text-green-700
        title: "Check Your Latest Credit Score",
        subtitle: "Free credit score check",
        bgColor: const Color(0xFFF0FDF4), // bg-green-50
        emoji: "📊",
      ),
      _ToolItem(
        badge: "MF TRACKER",
        badgeBg: const Color(0xFFDBEAFE), // bg-blue-100
        badgeText: const Color(0xFF1D4ED8), // text-blue-700
        title: "Track Mutual Fund Portfolio",
        subtitle: "Monitor your investments",
        bgColor: const Color(0xFFEFF6FF), // bg-blue-50
        emoji: "🔍",
      ),
      _ToolItem(
        badge: "NEW",
        badgeBg: const Color(0xFFFECACA), // bg-red-100
        badgeText: const Color(0xFFB91C1C), // text-red-700
        title: "Easy Tax Filing, Now With AI",
        subtitle: "Smart tax assistance",
        bgColor: const Color(0xFFFFF7ED), // bg-orange-50
        emoji: "🤖",
      ),
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Free Tools",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827), // text-gray-900
            ),
          ),
          const SizedBox(height: 16),
          Column(children: tools.map((tool) => _ToolCard(tool)).toList()),
        ],
      ),
    );
  }
}

class _ToolItem {
  final String badge;
  final Color badgeBg;
  final Color badgeText;
  final String title;
  final String subtitle;
  final Color bgColor;
  final String emoji;

  _ToolItem({
    required this.badge,
    required this.badgeBg,
    required this.badgeText,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.emoji,
  });
}

class _ToolCard extends StatelessWidget {
  final _ToolItem tool;

  const _ToolCard(this.tool);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tool.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: tool.badgeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              tool.badge,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: tool.badgeText,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Content Row
          Row(
            children: [
              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tool.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827), // text-gray-900
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tool.subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B7280), // text-gray-600
                      ),
                    ),
                  ],
                ),
              ),

              // Emoji
              Text(tool.emoji, style: const TextStyle(fontSize: 20)),

              // Chevron
              const SizedBox(width: 8),
              const Icon(
                LucideIcons.chevronRight,
                size: 20,
                color: Color(0xFF9CA3AF), // text-gray-400
              ),
            ],
          ),
        ],
      ),
    );
  }
}
