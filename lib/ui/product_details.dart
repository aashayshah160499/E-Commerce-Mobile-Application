import 'package:flutter/material.dart';
import 'package:flutterfireauth/main.dart';
import 'package:flutterfireauth/ui/home.dart';
import 'package:flutterfireauth/db/product.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_quantity;
  final product_detail_picture;
  final product_detail_brand;
  final product_detail_category;
  final product_detail_id;

  ProductDetails({this.product_detail_name,
    this.product_detail_new_price,
    this.product_detail_quantity,
    this.product_detail_picture,
    this.product_detail_brand,
    this.product_detail_category,
    this.product_detail_id});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  ProductService _productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new HomePage()));
            },
            child: Text('Shopping App')),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            height: 250,
            child: GridTile(
              child: Container(
                color: Colors.white70,
                child: Image.network(widget.product_detail_picture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(
                    widget.product_detail_name,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("${widget.product_detail_quantity} Available",
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      Expanded(
                        child: new Text(
                          "Rs ${widget.product_detail_new_price}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // First Buttons on Product Details
          Row(
            children: <Widget>[
              // Size Button
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Category"),
                            content: new Text('Category : ${widget.product_detail_category}'),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text('Close'),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.black45,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
//                      Expanded(
//                        child: new Icon(Icons.arrow_drop_down),
//                      ),
                    ],
                  ),
                ),
              ),
              // Color Button
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Brand"),
                            content: Text('Brand: ${widget.product_detail_brand}'),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text('Close'),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.black45,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Brand',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
//                      Expanded(
//                        child: new Icon(Icons.arrow_drop_down),
//                      ),
                    ],
                  ),
                ),
              ),
              // Quantity Button
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Quantity"),
                            content: new Text('Available Quantity : ${widget.product_detail_quantity}'),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text('Close'),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.black45,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          'Quantity',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
//                      Expanded(
//                        child: new Icon(Icons.arrow_drop_down),
//                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Second Buttons on Product Details
          Row(
            children: <Widget>[
              // Size Button
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    _productService.uploadToCart({
                        "name": widget.product_detail_name,
                        "price": widget.product_detail_new_price,
                        "images": widget.product_detail_picture,
                        "quantity": int.parse('1'),
                        "category": widget.product_detail_category.toString(),
                        "brand": widget.product_detail_brand.toString()
                    }
                    );
                    _key.currentState
                        .showSnackBar(SnackBar(content: Text("Product Added to Cart")));
                  },
                  color: Colors.pink,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text("Buy Now"),
                ),
              ),
              new IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.red,
                  onPressed: () {}),
              new IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {
                    _productService.uploadToFavorites({
                      "name": widget.product_detail_name,
                      "price": widget.product_detail_new_price,
                      "images": widget.product_detail_picture,
                      "quantity": widget.product_detail_quantity.toString(),
                      "category": widget.product_detail_category.toString(),
                      "brand": widget.product_detail_brand.toString()
                    }
                    );
                    _key.currentState
                        .showSnackBar(SnackBar(content: Text("Product Added to Favorites")));
                  }),
            ],
          ),
          Divider(),
          new ListTile(
            title: new Text("Product Details"),
            subtitle: new Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          ),
          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  12.0,
                  5.0,
                  5.0,
                  5.0,
                ),
                child: new Text(
                  "Product Name:",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_name),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  12.0,
                  5.0,
                  5.0,
                  5.0,
                ),
                child: new Text(
                  "Product Brand:",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_brand),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  12.0,
                  5.0,
                  5.0,
                  5.0,
                ),
                child: new Text(
                  "Product Condition:",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Text("New"),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("Similar Products"),
          ),
          // Similar Products Section
          Container(
            height: 250.0,
            child: Similar_products(),
          )
        ],
      ),
    );
  }
}

class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  var product_list = [
    {
      'name': 'Pants',
      'picture': 'images/products/pants1.jpg',
      'old_price': 100,
      'price': 75,
    },
    {
      'name': 'Heels',
      'picture': 'images/products/hills1.jpeg',
      'old_price': 40,
      'price': 25,
    },
    {
      'name': 'Skirt',
      'picture': 'images/products/skt1.jpeg',
      'old_price': 60,
      'price': 40,
    },
    {
      'name': 'Shoes',
      'picture': 'images/products/shoe1.jpg',
      'old_price': 50,
      'price': 19,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_single_prod(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Similar_single_prod({
    this.prod_name,
    this.prod_picture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                // passing the values of the product to the product details page
                  builder: (context) => new ProductDetails(
                    product_detail_name: prod_name,
                    product_detail_picture: prod_picture,
                    product_detail_new_price: prod_price,
                    product_detail_quantity: prod_old_price,
                  ))),
              child: GridTile(
                  footer: Container(
                      color: Colors.white70,
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                prod_name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16.0),
                              )),
                          Expanded(
                              child: Text(
                                "Rs ${prod_price}",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              )),
                        ],
                      )),
                  child: Image.asset(
                    prod_picture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
