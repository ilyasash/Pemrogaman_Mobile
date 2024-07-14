import 'package:flutter/material.dart';
import 'package:mobile_app/Widget/image_place.dart';
import 'package:mobile_app/Widget/namestyle.dart';
import 'package:mobile_app/Widget/recept_card.dart';
import 'package:mobile_app/Widget/dialog.dart';

const nugget = 'Nugget Krispi';
const sosis = 'Sosis Goreng';
const mie = 'Indomie Goreng';
const nasiGoreng = 'Nasi Goreng';

const bahanNugget = [
  'Daging ayam fillet',
  'Tepung roti',
  'Telur',
  'Garam',
  'Merica',
  'Minyak goreng',
];

const bahanSosis = [
  'Sosis',
  'Telur',
  'Tepung terigu',
  'Tepung roti',
  'Garam',
  'Minyak goreng',
];

const bahanMie = [
  'Indomie',
  'Bumbu Indomie',
  'Air',
  'Telur',
  'Minyak goreng',
];

const bahanNasiGoreng = [
  'Nasi',
  'Bawang putih',
  'Bawang merah',
  'Telur',
  'Kecap manis',
  'Garam',
  'Merica',
  'Minyak goreng',
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  void _showDialog(BuildContext context, {String? title, String? msg}) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title ?? '',
        message: msg ?? '',
        buttonText: 'Close',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'chef_image',
              child: InkWell(
                onTap: () {
                  _showDialog(
                    context,
                    title: 'Menu Hemat Sahur',
                    msg: 'Bagi Mahasiswa yang mau hemat lets cook with me',
                  );
                },
                child: imageplaceView(
                  imageUrl: 'assets/chef_yasa.png',
                  size: 200,
                   onPressed: () {},
                ),
              ),
            ),
            NameStyle(
              text: 'Menu Sahur',
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            TitleText(
              text: 'By chef Maulana Ilyasa',
              fontSize: 20.0,
              color: Color.fromARGB(255, 33, 144, 255),
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),
            ReceptCard(
              text: 'Indomie Goreng',
              onPressed: () {
                _showDialog(
                  context,
                  title: 'Indomie Goreng',
                  msg: 'Bahan: ${bahanMie.join(", ")}\n\n'
                      'Cara membuat:\n'
                      '- Rebus Indomie hingga matang\n'
                      '- Tumis telur dengan bumbu Indomie\n'
                      '- Campurkan telur dan Indomie yang sudah matang\n'
                      '- Sajikan',
                );
              },
            ),
            ReceptCard(
              text: 'Sosis Goreng',
              onPressed: () {
                _showDialog(
                  context,
                  title: 'Sosis Goreng',
                  msg: 'Bahan: ${bahanSosis.join(", ")}\n\n'
                      'Cara membuat:\n'
                      '- Goreng sosis dalam minyak panas hingga kecokelatan dan renyah\n'
                      '- Sajikan',
                );
              },
            ),
            ReceptCard(
              text: 'Nugget Krispi',
              onPressed: () {
                _showDialog(
                  context,
                  title: 'Nugget Krispi',
                  msg: 'Bahan: ${bahanNugget.join(", ")}\n\n'
                      'Cara membuat:\n'
                      '- Campurkan daging ayam fillet dengan garam dan merica\n'
                      '- Celupkan daging ayam ke dalam telur yang sudah dikocok\n'
                      '- Gulingkan daging ayam ke dalam tepung roti\n'
                      '- Goreng dalam minyak panas hingga kecokelatan dan renyah\n'
                      '- Sajikan',
                );
              },
            ),
            ReceptCard(
              text: 'Nasi Goreng',
              onPressed: () {
                _showDialog(
                  context,
                  title: 'Nasi Goreng',
                  msg: 'Bahan: ${bahanNasiGoreng.join(", ")}\n\n'
                      'Cara membuat:\n'
                      '- Tumis bawang putih dan bawang merah hingga harum\n'
                      '- Masukkan telur dan aduk hingga matang\n'
                      '- Tambahkan nasi, kecap manis, garam, dan merica\n'
                      '- Aduk rata hingga nasi tercampur bumbu dan matang\n'
                      '- Sajikan',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
