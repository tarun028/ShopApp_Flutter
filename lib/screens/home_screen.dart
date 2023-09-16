import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/screens/users_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../models/products_model.dart';
import '../consts/global_colors.dart';
import '../services/api_handler.dart';
import '../widget/appbar_icons.dart';
import '../widget/feeds_grid.dart';
import '../widget/sale_widget.dart';
import 'categories_screen.dart';
import 'feed_screen.dart';


//import '../Models/products_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;
  List<ProductsModel> productsList =[];
  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }
  @override
  void didChangeDependencies() {
    getProducts();
    super.didChangeDependencies();
  }
 Future<void> getProducts() async{
    productsList = await APIHandler.getAllProducts(limit: '10');

  setState(() {
    
  });
 }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            title: const Text('Home'),
            leading: AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const CategoriesScreen(),
                  ),
                );
              }, // Provide your function here
              icon: IconlyBold.category,
            ),
            actions: [
              AppBarIcons(
                function: () {
                  Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const UsersScreen(),
                  ),
                );
                }, // Provide your function here
                icon: IconlyBold.user3,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Search",
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      suffixIcon: Icon(
                        IconlyLight.search,
                        color: lightIconsColor,
                      )),
                ),
                SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.25,
                          child: Swiper(
                            itemCount: 3,
                            itemBuilder: (ctx, index) {
                              return const SaleWidget();
                            },
                            pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white, activeColor: Colors.red),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                "Latest Products",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              AppBarIcons(
                                  function: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: FeedsScreen(),
                                      ),
                                    );
                                  },
                                  icon: IconlyBold.arrowRight2),
                            ],
                          ),
                        ),
                        productsList.isEmpty?Container(): FeedsGridWidget(productsList: productsList)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
