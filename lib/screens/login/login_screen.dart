import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/utilities/constants.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
        ],
      ),
      body: Center(
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, child){
                if(userManager.loadingFace){
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor
                      ),
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: Carousel(
                          images: [
                            NetworkImage(
                                'https://pbs.twimg.com/media/EtrK_AXWgAEcZ8m?format=png&name=small'),
                          ],
                          dotSize: 0.0,
                          dotBgColor: Colors.transparent,
                          dotColor: Colors.white,
                          autoplay: false,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
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
                      autocorrect: false,
                      validator: (email){
                        if(!emailValid(email))
                          return 'Email inválido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    TextFormField(
                      controller: passController,
                      enabled: !userManager.loading,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15.0, left: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        hintText: 'Senha',
                        hintStyle: kHintTextStyle,
                      ),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass){
                        if(pass.isEmpty || pass.length < 6)
                          return 'Senha inválida';
                        return null;
                      },
                    ),
                    child,
                    const SizedBox(height: 16,),
                    RaisedButton(
                      elevation: 5.0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: userManager.loading ? null : (){
                        if(formKey.currentState.validate()){
                          userManager.signIn(
                              user: User(
                                  email: emailController.text,
                                  password: passController.text
                              ),
                              onFail: (e){
                                scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Falha ao entrar: $e'),
                                      backgroundColor: Colors.red,
                                    )
                                );
                              },
                              onSuccess: (){
                                Navigator.of(context).pop();
                              }
                          );
                        }
                      },
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).primaryColor
                          .withAlpha(100),
                      textColor: Colors.white,
                      child: userManager.loading ?
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ) :
                      const Text(
                        'Entrar',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                      height: 20.0,
                      child: Text(
                        'Não possui uma conta?',
                        textAlign: TextAlign.center,
                        style: kLabelStyle,
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                    RaisedButton(
                      elevation: 5.0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed('/signup');
                      },
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).primaryColor
                          .withAlpha(100),
                      textColor: Colors.white,
                      child: const Text(
                        'Cadastrar-se',
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/reset');
                  },
                  padding: EdgeInsets.zero,
                  child: const Text(
                      'Esqueci minha senha'
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
