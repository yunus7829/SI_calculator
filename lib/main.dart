import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "simple interest calculator app",
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.lightGreen,
        // accentColor: Colors.pink,
      ),
    ),
  );
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Ponds'];
  final _minimumPadding = 5.0;
  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termsController = TextEditingController();
  var displayresult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //backgroundColor: Colors.deepOrangeAccent,
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principalController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter principle amount";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Principal ',
                        hintText: 'Enter principal eg:1000',
                        labelStyle: textStyle,
                        errorStyle: TextStyle(color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter rate of interest';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of interest',
                          hintText: 'in percent %',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termsController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter time';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Terms',
                              hintText: 'in years',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                        Container(width: _minimumPadding * 5),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (newValueSelected) {
                            _onDropDownItemSelected(newValueSelected!);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: ElevatedButton(
                          // color:Theme.of(context).primaryColorLight,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent),
                          // ElevatedButton.styleFrom(primary: Colors.indigo),
                          child: Text(
                            "Calulate",
                            textScaleFactor: 1.4,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                this.displayresult = _calculateTotalReturns();
                              }
                            });
                          },
                        )),
                        Container(width: _minimumPadding),
                        Expanded(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                          child: Text(
                            "Reset",
                            style: textStyle,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        )),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 10),
                  child: Text(
                    displayresult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 200.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double terms = double.parse(termsController.text);
    double totalAmountPayable = principal + (principal * roi * terms) / 100;
    String result =
        'After $terms years,your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termsController.text = '';
    displayresult = '';
    _currentItemSelected = _currencies[0];
  }
}
