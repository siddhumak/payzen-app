import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:payzen_app/constant/app_gradients.dart';

/// A reusable AppBar for collection-related screens.
class CustomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final int notificationCount;

  const CustomeAppbar({
    super.key,
    this.title,
    this.onNotificationTap,
    this.onProfileTap,
    this.notificationCount = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.splashBackground),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(
                  LucideIcons.menu,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  print('open drawer');
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        title: Center(
          child: Text(
            title ?? '',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          // Notification Icon with Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(
                  LucideIcons.bell,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: onNotificationTap,
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Profile Icon
          IconButton(
            icon: const Icon(LucideIcons.user, color: Colors.white, size: 20),
            onPressed: onProfileTap,
          ),
        ],
      ),
    );
  }
}
