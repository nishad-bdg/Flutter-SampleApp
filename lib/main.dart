import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator',
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ["Taka", "Dollars", "Pounds", "Others"];
  var _currentValue = '';
  var displayResult = '';

  @override
  void initState() {
    super.initState();
    _currentValue = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                _getImageAsset(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: principalController,
                    validator:(String value){
                      if(value.isEmpty){
                        return 'Please enter the principal amount';
                      }
                      
                    },
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: textStyle,
                      labelText: 'Principal',
                      hintText: 'Enter Principal e.g. 12000',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: rateController,
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please enter rate amount';
                      }
                      
                    },
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: textStyle,
                      labelText: 'Rate Of Interest',
                      hintText: 'Rate Of Interest',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: termController,
                          validator: (String value){
                            if(value.isEmpty){
                              return "Please enter Term";
                            }
                            
                          },
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelStyle: textStyle,
                              hintText: "Term",
                              labelText: "Term",
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Container(width: 25.0),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentValue,
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this._currentValue = newValueSelected;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                          ),
                          color: Colors.indigo,
                          onPressed: () {
                            
                            setState(() {
                              if(_formKey.currentState.validate()){
                                this.displayResult = "Error Found In Form";
                              }
                              this.displayResult = _calculateTotalReturns();
                              
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.5,
                          ),
                          color: Colors.blueAccent,
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      this.displayResult,
                      style: textStyle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _getImageAsset() {
    AssetImage assetImage = AssetImage("images/bank.png");
    Image image = Image(
      image: assetImage,
      height: 125.0,
      width: 125.0,
    );
    return Container(
        margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
        child: Center(
          child: image,
        ));
  } //getImageAsset

  String _calculateTotalReturns() {
    double principle = double.parse(principalController.text);
    double roi = double.parse(rateController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principle + (principle * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentValue';
    return result;
  } //calcuateTotalReturns

  void _reset() {
    principalController.text = "";
    rateController.text = "";
    termController.text = "";
    displayResult = "";
    _currentValue = _currencies[0];
  }
} //class ends
