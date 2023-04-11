/*
import 'dart:math';
import 'package:flutter/material.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

//crio uma classe stateful chamada TransitionUser
class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  //adiciono duas transações para visualizar no app
  //Detalhe: A classe transition possui as seguintes informações: id, titulo, valor, data.
   final _transactions = [
      Transaction(
        id: 't1',
        title: 'Novo Tênis de corrida',
        value: 310.76,
        date: DateTime.now()
      ),
      Transaction(
        id: 't2',
        title: 'Conta de luz',
        value: 211.30,
        date: DateTime.now(), //detalhe interessante é a função DateTimme.now() que pega as informações atuais de data e hora
      ),
    ];
    
    //Crio a função privada _addTransaction, ela recebe o título e valor como parametros    
    _addTransaction(String title, double value) {
      final newTransaction = Transaction(
        id: Random().nextDouble.toString(),
        title: title,
        value: value,
        date: DateTime.now()
      );

      //crio um set para introduzir a nova transação a lista privada _transactions
       setState(() {
      _transactions.add(newTransaction);
    });

    }


  @override
  Widget build(BuildContext context) {
    return Column(
      //logo essa classe ira retornar o resultado de suas informações enviadas como parametro para outras classes que irão tratar os dados
      children: <Widget>[
        TransactionList(_transactions),
        TransactionForm.onSubmit(_addTransaction),
      ],
    );
  }
}
*/