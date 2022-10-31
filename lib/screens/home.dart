import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vladimir/blocs/navbar_bloc/navbar_bloc.dart';
import 'package:test_vladimir/blocs/navbar_bloc/navbar_events.dart';
import 'package:test_vladimir/blocs/navbar_bloc/navbar_state.dart';
import 'package:test_vladimir/consts/colors.dart';
import 'package:test_vladimir/consts/fonts.dart';
import 'package:test_vladimir/repositories/user_repository.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userRepository}) : super(key: key);
  final UserRepository userRepository;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NavbarBloc _navbarBloc;
  List<String>? listUser = ['Loading...','Loading...'];
  List<String>? dataFromApi = ['Loading...'];
  Future<List<String>?> getData() async{
    listUser  = await widget.userRepository.getData();
  }

Future getResponceData() async{
    Dio dio = Dio();
    if(!kIsWeb){
      (dio.httpClientAdapter
      as DefaultHttpClientAdapter)
          .onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host,
            int port) =>
        true;
      };
    }
    var response = await dio.get('http://numbersapi.com/random/trivia');
    log(response.data.toString());
    dataFromApi![0] = response.data.toString();
  }
  @override
  void initState() {
    super.initState();
    getData();
    _navbarBloc = BlocProvider.of<NavbarBloc>(context);
    getResponceData();
  }

  Scaffold buildHomepage(String name,String login, String data, int currentIndex) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(name??'',
            style: const TextStyle(
              fontFamily: medium
            ),),
            Text(login??'',
              style: const TextStyle(
                  fontFamily: medium
              ),),
            Text(data??'',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: medium,
                fontSize: 20
              ),),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: fieldColor,
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) {
            _navbarBloc.add(
            NavbarItems.first
          );
          }
          if (index == 1) {
            _navbarBloc.add(
              NavbarItems.second
          );
          };
        },
        items: const [
          BottomNavigationBarItem(

            icon: Icon(Icons.looks_one,
            color: backgroundColor,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two,color: backgroundColor,),

            label: '',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(builder: (context, state) {
      return state is ShowFirstState
          ? buildHomepage(listUser![0],listUser![1],'', state.itemIndex)
          : state is ShowSecondState
              ? buildHomepage('','',dataFromApi![0], state.itemIndex)
              : Container();
    });
  }
}
