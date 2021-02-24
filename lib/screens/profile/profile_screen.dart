import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/common/login_card.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/screens/reset_password/reset_screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
final User user = User();
class _ProfileScreenState extends State<ProfileScreen> {
  final MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
      mask: '(##)#####-####',filter: {'#': RegExp('[0-9]')}
  );
  String url =
      'https://static.thenounproject.com/png/630740-200.png';
  bool isPasswordTextField = true;
  bool showPassword = true;
  String nome = 'default';
  String phone;
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey2,
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        /* if(showsnackbar == true) {
                        const snack = SnackBar(content: Text(
                        'Dados salvos com sucesso!',
                        style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.black,
                        duration: Duration(seconds: 2),
                      );
                      Scaffold.of(context).showSnackBar(snack);
                      }*/
      ),
      body: Consumer<UserManager>(builder: (_, userManager, __) {
        if (userManager.user == null) {
          return LoginCard();
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                    Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage('$url')),
                      ),
                    ),


                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: formKey2,
                  child:
                  TextFormField(
                    initialValue: userManager.user.name,
                    style: TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Insira um nome',
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(Icons.person_outline),
                    ),
                    enabled: !userManager.loading,
                    validator: (name) {
                      if(name == userManager.user.name)
                        return 'Nenhuma mudança feita';
                      if (name.isEmpty)
                        return 'Campo Vazio';
                      else if (name.trim().split(' ').length <= 1)
                        return 'Preencha um nome válido';
                      else{
                        return null;
                      }
                    },
                    onSaved: (name) => nome = name,
                  ),

                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: '${userManager.user.email}',
                    hintStyle: TextStyle(color: Colors.black),
                    icon: Icon(Icons.alternate_email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  enabled: false,
                ),
                Form(
                  key:formKey3,
                  child: TextFormField(
                    initialValue: userManager.user.telefone,
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'Insira um telefone',
                      hintStyle: TextStyle(color: Colors.black),
                      icon: Icon(Icons.phone_android),
                    ),
                    keyboardType: TextInputType.phone,
                    enabled: true,
                    inputFormatters: [phoneFormatter],
                    validator: (telefone){
                      if(telefone == userManager.user.telefone)
                        return 'Nenhuma mudança feita';
                      if (telefone.isEmpty)
                        return 'Campo Vazio';
                      else if(telefone.length < 13)
                        return 'Número inválido';
                      else{
                        return null;
                      }
                    },
                    onSaved: (telefone) => phone = telefone,
                  ),
                ),


                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed:userManager.loading ? null : () {
                      if (formKey3.currentState.validate()) {
                        formKey3.currentState.save();
                        scaffoldKey2.currentState.showSnackBar(
                          const SnackBar(
                            content: Text('Dados Salvos com Sucesso'),
                            backgroundColor: Colors.black,
                          ),
                        );
                        Firestore.instance.document('users/${userManager.user.id}').updateData(
                            {'telefone': '$phone'});
                        setState(() {
                          userManager.user.telefone = phone;
                        });
                      }
                      if (formKey2.currentState.validate()) {
                        formKey2.currentState.save();
                        scaffoldKey2.currentState.showSnackBar(
                          const SnackBar(
                            content: Text('Dados Salvos com Sucesso'),
                            backgroundColor: Colors.black,
                          ),
                        );
                        Firestore.instance.document('users/${userManager.user.id}').updateData(
                            {'name': '$nome'}
                        );
                        setState(() {
                          userManager.user.name = nome;
                        });
                        /*showDialog(
                                  context: context,
                                  builder: (context)=> AlertDialog(
                                    title: Text('Tem certeza que deseja alterar seus dados?'),
                                    content: Text('A ação não poderá ser desfeita'),
                                    actions: [
                                      FlatButton(onPressed: (){

                                        Navigator.pop(context);
                                      },
                                          child: Text('Sim')),
                                      FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancelar'))
                                    ],
                                  ));*/
                      }
                      debugPrint(userManager.user.name);
                      debugPrint(userManager.user.telefone);
                    },
                    child: const Text(
                      'Atualizar Dados',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed:() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ResetScreen()));
                    },
                    child: const Text(
                      'Redefinir Senha',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ])),
        );
      }),
    );
  }
}
