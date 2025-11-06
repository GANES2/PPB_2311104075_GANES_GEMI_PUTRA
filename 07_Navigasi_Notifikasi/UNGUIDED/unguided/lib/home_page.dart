import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'product.dart';
import 'product_detail_page.dart';
import 'cart_page.dart';
import 'favorites_page.dart';
import 'account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  Timer? _timer;

  final List<Product> products = [
    Product(
      id: 1,
      name: "iPhone 17 Pro",
      price: 15000000,
      description: "iPhone Terbaru",
      imageUrl: "assets/iPhone 17 Pro.png",
      rating: 4.5,
      stock: 15,
      category: "iPhone",
      isNew: true,
      isHot: true,
    ),
    Product(
      id: 2,
      name: "13-inch MacBook Air",
      price: 20000000,
      description: "Laptop performa tinggi untuk bekerja dan gaming",
      imageUrl: "assets/Mac.png",
      rating: 4.8,
      stock: 8,
      category: "MacBook",
      isHot: true,
    ),
    Product(
      id: 3,
      name: "iPad Air",
      price: 8000000,
      description: "Tablet portabel dengan layar HD dan stylus",
      imageUrl: "assets/iPad Air M3.png",
      rating: 4.0,
      stock: 18,
      category: "iPad",
    ),
    Product(
      id: 4,
      name: "iPhone 15",
      price: 12000000,
      description: "iPhone dengan kamera canggih",
      imageUrl: "assets/iPhone17.png",
      rating: 4.6,
      stock: 20,
      category: "iPhone",
      isOnSale: true,
      originalPrice: 14000000,
    ),
    Product(
      id: 5,
      name: "MacBook Air",
      price: 18000000,
      description: "Laptop ringan untuk produktivitas",
      imageUrl: "assets/MacBook Pro M4 Pro.png",
      rating: 4.7,
      stock: 12,
      category: "MacBook",
      isNew: true,
    ),
    Product(
      id: 6,
      name: "iPad Pro",
      price: 15000000,
      description: "Tablet profesional dengan Apple Pencil",
      imageUrl: "assets/iPad ProM4.png",
      rating: 4.8,
      stock: 10,
      category: "iPad",
      isHot: true,
    ),
  ];

  String searchQuery = '';
  String selectedCategory = 'All';
  List<Product> filteredProducts = [];
  List<Product> favoriteProducts = [];
  List<Product> cartProducts = [];
  bool isDarkMode = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> promoImages = [
    'assets/iPhone 17 Pro.png',
    'assets/Mac.png',
    'assets/iPhone17.png',
    'assets/MacBook Pro M4 Pro.png',
    'assets/iPad ProM4.png',
    'assets/iPad Air M3.png',
  ];

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
    _pageController = PageController();
    _startAutoSlide();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page?.toInt() ?? 0) + 1;
        if (nextPage >= 4) nextPage = 0;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _filterProducts() {
    setState(() {
      filteredProducts = products.where((product) {
        final matchesSearch = product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                             product.description.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesCategory = selectedCategory == 'All' || product.category == selectedCategory;
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _toggleFavorite(Product product) {
    setState(() {
      if (favoriteProducts.contains(product)) {
        favoriteProducts.remove(product);
      } else {
        favoriteProducts.add(product);
      }
    });
  }

  void _addToCart(Product product) {
    setState(() {
      cartProducts.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ditambahkan ke keranjang!'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Lihat Keranjang',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to cart page (would be implemented)
          },
        ),
      ),
    );
  }

  List<String> get categories => ['All', ...products.map((p) => p.category).toSet()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Toko Kanesuuu_',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1a1a2e),
                Color(0xFF16213e),
                Color(0xFF0f3460),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFf8f9fa),
              Color(0xFFe9ecef),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Slider
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(promoImages[index % promoImages.length]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Promo Special Apple Products',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    searchQuery = value;
                    _filterProducts();
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF0f3460)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox(height: 12),

              // Category Filter
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == selectedCategory;
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FilterChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Color(0xFF0f3460),
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category;
                            _filterProducts();
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: Color(0xFF0f3460),
                        checkmarkColor: Colors.white,
                        elevation: 2,
                        shadowColor: Colors.black.withOpacity(0.1),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),

              Text(
                'Produk ${selectedCategory == 'All' ? 'Terbaru' : selectedCategory}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0f3460),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 12),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Simulate refresh
                    await Future.delayed(Duration(seconds: 1));
                    setState(() {
                      filteredProducts = products;
                      searchQuery = '';
                      selectedCategory = 'All';
                    });
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: filteredProducts[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  product: filteredProducts[index],
                                  onFavoriteToggle: _toggleFavorite,
                                  onAddToCart: _addToCart,
                                  isFavorite: favoriteProducts.contains(filteredProducts[index]),
                                ),
                              ),
                            );
                          },
                          isFavorite: favoriteProducts.contains(filteredProducts[index]),
                          onFavoriteToggle: () => _toggleFavorite(filteredProducts[index]),
                          onAddToCart: () => _addToCart(filteredProducts[index]),
                          isDarkMode: isDarkMode,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF0f3460),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on home page
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(
                    favoriteProducts: favoriteProducts,
                    onFavoriteToggle: _toggleFavorite,
                    onAddToCart: _addToCart,
                    isDarkMode: isDarkMode,
                  ),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cartProducts: cartProducts,
                    onRemoveFromCart: (product) {
                      setState(() {
                        cartProducts.remove(product);
                      });
                    },
                    onAddToCart: _addToCart,
                    isDarkMode: isDarkMode,
                  ),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountPage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;
  final bool isDarkMode;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  if (product.isOnSale && product.originalPrice != null)
                    Row(
                      children: [
                        Text(
                          'Rp${NumberFormat.decimalPattern('id').format(product.originalPrice!)}',
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Rp${NumberFormat.decimalPattern('id').format(product.price)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      'Rp${NumberFormat.decimalPattern('id').format(product.price)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Stok: ${product.stock}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Badges
            Positioned(
              top: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.isNew)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (product.isHot)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'HOT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (product.isOnSale)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'SALE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Favorite button
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: onFavoriteToggle,
                iconSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
