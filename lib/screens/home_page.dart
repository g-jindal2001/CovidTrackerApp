import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../providers/data.dart';

import '../screens/country.dart';

import '../widgets/app_drawer.dart';
import '../widgets/card_home_page.dart';
import '../widgets/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _userInput;
  final _searchFocusNode = FocusNode();
  final _searchController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _isLoading = false;
  bool oneTime = false;

  @override
  void initState() {
    _searchFocusNode.addListener(_removeText);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //To load initial Data one time
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Data>(context, listen: false)
          .loadAndUpdateCoviddata()
          .then((_) => setState(() {
                _isLoading = false;
              }));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_removeText);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _removeText() {
    if (!_searchFocusNode.hasFocus) {
      _searchController.clear();
    }
  }

  void _saveForm() async {
    _form.currentState.save();
    try {
      await Provider.of<Data>(context, listen: false)
          .loadAndUpdateCovidCountryData(_userInput.toString());
    } catch (error) {
      return;
    }

    if (_userInput.toString().isNotEmpty) {
      Navigator.of(context).pushNamed(
        Country.routeName,
        arguments: {
          'input':
              toBeginningOfSentenceCase(_userInput.toString().toLowerCase()),
          'one_time': oneTime,
        },
      );
      print(_userInput);
    }
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<Data>(context, listen: false).loadAndUpdateCoviddata();
  }

  @override
  Widget build(BuildContext context) {
    final covidData = Provider.of<Data>(context).data;
    final deviceSize = MediaQuery.of(context).size;
    final devicePadding = MediaQuery.of(context).padding;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Home Page'),
          )
        : AppBar(
            title: Text('Home Page'),
          );

    final finalHeightExcludingAppBar =
        deviceSize.height - appBar.preferredSize.height - devicePadding.top;

    final content = ListView(
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          height: finalHeightExcludingAppBar * 0.1,
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search By Country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(),
                  ),
                ),
                focusNode: _searchFocusNode,
                controller: _searchController,
                onSaved: (value) {
                  _userInput = value;
                },
                onEditingComplete: () {
                  setState(() {});
                },
                onFieldSubmitted: (value) {
                  _saveForm();
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        _isLoading
            ? ShimmerObjects().shimmerHomePage()
            : Container(
                height: finalHeightExcludingAppBar * 0.21,
                child: CardHomePage(
                  'Cases',
                  Icons.insights,
                  covidData['cases'],
                  Colors.lightBlue,
                ),
              ),
        _isLoading
            ? ShimmerObjects().shimmerHomePage()
            : Container(
                height: finalHeightExcludingAppBar * 0.21,
                child: CardHomePage(
                  'Active Cases',
                  Icons.people,
                  covidData['activeCases'],
                  Colors.orange,
                ),
              ),
        _isLoading
            ? ShimmerObjects().shimmerHomePage()
            : Container(
                height: finalHeightExcludingAppBar * 0.21,
                child: CardHomePage(
                  'Recovered',
                  Icons.science,
                  covidData['recovered'],
                  Colors.green,
                ),
              ),
        _isLoading
            ? ShimmerObjects().shimmerHomePage()
            : Container(
                height: finalHeightExcludingAppBar * 0.21,
                child: CardHomePage(
                  'Deaths',
                  MdiIcons.skullCrossbones,
                  covidData['deaths'],
                  Colors.red,
                ),
              ),
      ],
    );

    final pageBody = SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        child: content,
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            drawer: AppDrawer(),
            body: RefreshIndicator(
              onRefresh: () => _refreshData(context),
              child: pageBody,
            ),
          );
  }
}
