import 'package:flutter/material.dart';
import 'package:flutter_challenge/constants/theme.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top user information section
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // User avatar
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.lightGrayBackground,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        "lib/assets/p_avatar.png",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // User name
                  Text(
                    "Lucy Bond",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Email address
                  Text(
                    "lucybond08@gmail.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textTertiary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Divider
                  Container(height: 1, color: AppTheme.dividerColor),
                ],
              ),
            ),

            // Menu list section
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.person,
                    title: "Personal details",
                    onTap: () {},
                  ),
                  SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.settings,
                    title: "Settings",
                    onTap: () {},
                  ),
                  SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.credit_card,
                    title: "Payment details",
                    onTap: () {},
                  ),
                  SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: "FAQ",
                    onTap: () {},
                  ),
                  SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.home,
                    title: "Switch to hosting",
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Build a single menu item row
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.lightGrayBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(icon, color: Colors.black87, size: 22),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
