import 'package:flutter/material.dart';
import 'package:flutter_challenge/api/home.dart';
import 'package:flutter_challenge/constants/theme.dart';
import 'package:flutter_challenge/utils/ToastUtils.dart';
import 'package:flutter_challenge/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Search input controller
  final TextEditingController _searchController = TextEditingController();

  // Category card data
  CategoryCardList _tripsList = CategoryCardList(items: const []);
  CategoryCardList _livingStyleList = CategoryCardList(items: const []);
  CategoryCardList _otherExperiencesList = CategoryCardList(items: const []);

  // Build category section title
  Widget _buildCategoryTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            GestureDetector(
              onTap: () {
                // See all callback
              },
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build single small card
  Widget _buildSmallCard(
      String imageUrl,
      String title,
      String description,
      int rentedPropsCount, {
        bool showRentedPropsCount = false,
      }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: double.infinity,
                height: 180,
                color: const Color(0xFFF0F0F0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 30,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFAAAAAA),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (showRentedPropsCount) ...[
                      const SizedBox(height: 2),
                      Text(
                        "$rentedPropsCount rented props",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFBBBBBB),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build two-column card row
  Widget _buildCategoryCardRow(List<CategoryCardItem> items) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          children: [
            if (items.isNotEmpty)
              _buildSmallCard(
                items[0].imageUrl,
                items[0].title,
                items[0].description,
                items[0].rentedPropsCount,
              )
            else
              const Expanded(child: SizedBox()),
            const SizedBox(width: 16),
            if (items.length > 1)
              _buildSmallCard(
                items[1].imageUrl,
                items[1].title,
                items[1].description,
                items[1].rentedPropsCount,
              )
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  // Build two-column card row with rented props count
  Widget _buildCategoryCardRowWithProps(List<CategoryCardItem> items) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          children: [
            if (items.isNotEmpty)
              _buildSmallCard(
                items[0].imageUrl,
                items[0].title,
                items[0].description,
                items[0].rentedPropsCount,
                showRentedPropsCount: true,
              )
            else
              const Expanded(child: SizedBox()),
            const SizedBox(width: 16),
            if (items.length > 1)
              _buildSmallCard(
                items[1].imageUrl,
                items[1].title,
                items[1].description,
                items[1].rentedPropsCount,
                showRentedPropsCount: true,
              )
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Delay data loading to avoid issues during startup
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _initCategoryData();
      }
    });
  }

  // Build scroll view content
  List<Widget> _getScrollChildren() {
    return [

      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.lightGrayBackground,
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search address, city, location",
                hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF999999),
                  size: 22,
                ),

                suffixIcon: PopupMenuButton<String>(
                  tooltip: "Filter",
                  onSelected: (value) {
                    ToastUtils.showToast(context, "Filtered by: $value");
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'All', child: Text('All')),
                  ],
                  child: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.tune,
                      color: Color(0xFF666666),
                      size: 24,
                    ),
                  ),
                ),

                suffixIconConstraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
      ),

      const SliverToBoxAdapter(child: SizedBox(height: 12)),
      _buildCategoryTitle("Find your next trip"),
      const SliverToBoxAdapter(child: SizedBox(height: 12)),
      _buildCategoryCardRowWithProps(_tripsList.items),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      _buildCategoryTitle("Explore your lifestyle"),
      const SliverToBoxAdapter(child: SizedBox(height: 12)),
      _buildCategoryCardRow(_livingStyleList.items),
      const SliverToBoxAdapter(child: SizedBox(height: 16)),
      _buildCategoryTitle("Want to discover more experiences"),
      const SliverToBoxAdapter(child: SizedBox(height: 12)),
      _buildCategoryCardRow(_otherExperiencesList.items),
      const SliverToBoxAdapter(child: SizedBox(height: 20)),
    ];
  }

  // Initialize category data
  void _initCategoryData() async {
    try {
      final trips = await getTripsListAPI();
      final livingStyle = await getLivingStyleListAPI();
      final otherExperiences = await getOtherExperiencesListAPI();

      setState(() {
        _tripsList = trips;
        _livingStyleList = livingStyle;
        _otherExperiencesList = otherExperiences;
      });
    } catch (e) {
      ToastUtils.showToast(
        context,
        "Failed to load data. Please check your network connection.",
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundColor,
      child: CustomScrollView(
        slivers: _getScrollChildren(),
      ),
    );
  }
}
