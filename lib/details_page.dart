import 'package:coffee_shop_ui_challange/main.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String img, price, name;
  DetailsPage(this.img, this.price, this.name);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.brown[400],
          label: Text(
            'Buy now',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          onPressed: () {},
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(seconds: 1),
                        pageBuilder: (_, __, ___) => HomePage()));
              },
              icon: Icon(Icons.arrow_back, color: Colors.black87)),
        ),
        body: Column(
          children: [
            Container(
              height: 60,
              child: Center(
                child: Text(
                  widget.name,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                ),
              ),
            ),
            Container(
              height: 250,
              child: Hero(
                  tag: widget.img,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      widget.img,
                    ),
                  ))),
            ),
            Row(
              children: [
                SizedBox(width: 20),
                Container(
                  height: 60,
                  child: Center(
                    child: Text(
                      '\$' + widget.price + '.00',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 50),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
