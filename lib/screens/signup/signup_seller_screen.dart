import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/address.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:lojavirtual/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:validadores/Validador.dart';

class SignUpSellerScreen extends StatefulWidget {
  @override
  _SignUpSellerScreenState createState() => _SignUpSellerScreenState();
}

class _SignUpSellerScreenState extends State<SignUpSellerScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  bool _ClientCheck = true;

  Widget _buildClientCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Text(
            'Cliente:',
            style: kLabelStyle,
          ),
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: !_ClientCheck,
              checkColor: Colors.green,
              activeColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  _ClientCheck = value;
                  if(_ClientCheck == true){
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 137),
            child:
            Text(
              'Vendedor:',
              style: kLabelStyle,
            ),
          ),
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _ClientCheck,
              checkColor: Colors.green,
              activeColor: Colors.black,
              onChanged: (value) {
                if(_ClientCheck == false){
                  setState(() {
                    _ClientCheck = value;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    _buildClientCheckbox(),
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        hintText: 'Nome Completo',
                        hintStyle: kHintTextStyle,
                      ),
                      enabled: !userManager.loading,
                      validator: (name) {
                        if (name.isEmpty)
                          return 'Campo obrigatório';
                        else if (name
                            .trim()
                            .split(' ')
                            .length <= 1)
                          return 'Preencha seu Nome Completo';
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: 'Email',
                        hintStyle: kHintTextStyle,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !userManager.loading,
                      validator: (email) {
                        if (email.isEmpty)
                          return 'Campo obrigatório';
                        else if (!emailValid(email))
                          return 'Email inválido';
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.local_phone,
                          color: Colors.black,
                        ),
                        hintText: 'Telefone',
                        hintStyle: kHintTextStyle,
                      ),
                      enabled: !userManager.loading,
                      validator: (telefone) {
                        if (telefone.isEmpty)
                          return 'Campo obrigatório';
                        else if (!telefoneValid(telefone))
                          return 'Telefone inválido';
                        return null;
                      },
                      onSaved: (telefone) => user.telefone = telefone,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.comment,
                          color: Colors.black,
                        ),
                        hintText: 'CPF',
                        hintStyle: kHintTextStyle,
                      ),
                      enabled: !userManager.loading,
                      validator: (value) {
                        // Aqui entram as validações
                        return Validador()
                            .add(Validar.CPF, msg: 'CPF Inválido')
                            .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                            .minLength(11)
                            .maxLength(11)
                            .valido(value,clearNoNumber: true);
                      },
                      onSaved: (cpf) => user.cpf = cpf,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                        hintText: 'Endereço',
                        hintStyle: kHintTextStyle,
                      ),
                      enabled: !userManager.loading,
                      validator: (address) {
                        if (address.isEmpty)
                          return 'Campo obrigatório';
                        else if (!addressValid(address))
                          return 'Endereço inválido';
                        return null;
                      },
                      onSaved: (address) => user.address = Address as Address,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.business,
                          color: Colors.black,
                        ),
                        hintText: 'CNPJ (opcional)',
                        hintStyle: kHintTextStyle,
                      ),
                      enabled: !userManager.loading,
                      onSaved: (cnpj) => user.cnpj = cnpj,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        hintText: 'Senha',
                        hintStyle: kHintTextStyle,
                      ),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass) {
                        if (pass.isEmpty)
                          return 'Campo obrigatório';
                        else if (pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        hintText: 'Confirme a Senha',
                        hintStyle: kHintTextStyle,
                      ),
                      obscureText: true,
                      enabled: !userManager.loading,
                      validator: (pass) {
                        if (pass.isEmpty)
                          return 'Campo obrigatório';
                        else if (pass.length < 6)
                          return 'Senha muito curta';
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.black,
                        ),
                        hintText: 'Chave de Acesso',
                        hintStyle: kHintTextStyle,
                      ),
                      enabled: !userManager.loading,
                      validator: (key) {
                        if (key.isEmpty)
                          return 'Campo obrigatório';
                        else if (!keyValid(key))
                          return 'Chave de Acesso inválida';
                        return null;
                      },
                      onSaved: (key) => user.key = key,
                    ),
                    const SizedBox(height: 16,),
                    RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      disabledColor: Theme
                          .of(context)
                          .primaryColor
                          .withAlpha(100),
                      textColor: Colors.white,
                      onPressed: userManager.loading ? null : () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();

                          if (user.password != user.confirmPassword) {
                            scaffoldKey.currentState.showSnackBar(
                                const SnackBar(
                                  content: Text('Senhas não coincidem!'),
                                  backgroundColor: Colors.red,
                                )
                            );
                            return;
                          }

                          userManager.signUp(
                              user: user,
                              onSuccess: () {
                                Navigator.of(context).pop();
                              },
                              onFail: (e) {
                                scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Falha ao cadastrar: $e'),
                                      backgroundColor: Colors.red,
                                    )
                                );
                              }
                          );
                        }
                      },
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: userManager.loading ?
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                          : const Text(
                        'Cadastrar-se',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool addressValid(String address) {}

  bool keyValid(String key) {}
  bool telefoneValid(String telefone) {}

}






