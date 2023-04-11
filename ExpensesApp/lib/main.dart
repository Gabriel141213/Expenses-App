import 'package:login/components/chart.dart';
import 'package:flutter/material.dart';
import 'package:login/components/transaction_form.dart';
import '../models/transaction.dart';
import 'dart:math';
import 'package:login/components/transaction_list.dart';

main() => runApp(ExpensesApp());

//crio a classe ExpensesApp como stateless
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final ThemeData tema = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: Colors.purple,
        accentColor: Colors.amber,

        fontFamily: 'Quicksans',
        
        textTheme: ThemeData.light().textTheme.copyWith(
          subtitle1: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )
        ),
        appBarTheme: AppBarTheme(
        textTheme: ThemeData.light().textTheme.copyWith(
          subtitle2: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.w700
          )
        )
        )
    ) 

); //retorna a classe MyHomePage
    
  }
}

//crio a classe MyHomePage como stateless
class MyHomePage extends StatefulWidget {
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    final List<Transaction>_transactions = [
      
      Transaction(
        id: 't1',
        title: 'Novo Tênis de corrida',
        value: 310.76,
        date: DateTime.now().subtract(Duration(days: 3)),
      ),
      Transaction(
        id: 't2',
        title: 'Conta de luz',
        value: 211.30,
        date: DateTime.now().subtract(Duration(days: 4)), //detalhe interessante é a função DateTimme.now() que pega as informações atuais de data e hora
      ),
    
    ];

    List<Transaction> get _recentTransactions {
      return _transactions.where((tr) {
        return tr.date.isAfter(DateTime.now().subtract(
          Duration(days: 7),
        ));
      }).toList();
    }
    
     //Crio a função privada _addTransaction, ela recebe o título e valor como parametros    
    _addTransaction(String title, double value, DateTime date) {
      Random random = new Random();
      int randomNumber = random.nextInt(100);
      final newTransaction = Transaction(
        id: randomNumber.toString(),
        title: title,
        value: value,
        date: date,
      );

      print(newTransaction.id);


      //crio um set para introduzir a nova transação a lista privada _transactions
       setState(() {
      _transactions.add(newTransaction);
       });

       Navigator.of(context).pop();
    }

   _removeTransaction(String id) {
        setState(() {
          _transactions.removeWhere((tr) {
            return tr.id == id;
          });  
        });
    }

  _opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm.onSubmit(_addTransaction);
      }
    );
  }

    @override
  Widget build(BuildContext context) {
    final availabeHeight = MediaQuery.of(context).size.height;
    return Scaffold( //Esqueleto do aplicativo
      appBar: AppBar( //Defino a App bar
        title: const Text(
          'Despesas pessoais',
          style: TextStyle(
            fontFamily: 'OpenSans',
          ),
          ), //dou a ela o titulo de 'despesas pessoais'
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _opentransactionFormModal(context),
          ),
        ],
      ),
      body: Container(//metodo que habilita o scroll
        child: Column( //essa coluna é a coluna principal do app, nela estarao armazenadas todas as informações
          crossAxisAlignment: CrossAxisAlignment.stretch, //defino o alinhamento secundário
          children: <Widget>[
              Chart(_recentTransactions),
               Column(
                //logo essa classe ira retornar o resultado de suas informações enviadas como parametro para outras classes que irão tratar os dados
                children: <Widget>[
                  Container(
                    height: availabeHeight * 0.7,
                    child:
                    TransactionList(_transactions, _removeTransaction)
                    ),
                  //TransactionForm.onSubmit(_addTransaction),
                ],
                ),
               /*Quantidade()*/
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _opentransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

  }
}