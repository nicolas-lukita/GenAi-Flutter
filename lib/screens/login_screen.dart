import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_bloc.dart';
import 'package:gen_ai_frontend/bloc/api/api_event.dart';
import 'package:gen_ai_frontend/constants/colors.dart';
import 'package:gen_ai_frontend/repositories/api_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  ApiRepository apiRepository = ApiRepository();
  bool _isHintTextVisible = true;

  @override
  initState() {
    super.initState();
    _controller.text = "H206674711";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundWhite,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(18),
            width: 330,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "歡迎登入財富管理聊天機器人",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _isHintTextVisible ? '請輸入身分證號碼' : "",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      fillColor: Colors.grey[200],
                      alignLabelWithHint: true,
                      filled: true,
                    ),
                    textAlign:
                        _isHintTextVisible ? TextAlign.center : TextAlign.start,
                    onTap: () {
                      setState(() {
                        _isHintTextVisible = false;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _isHintTextVisible = value.isEmpty;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 48,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundBlack,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        BlocProvider.of<ApiBloc>(context)
                            .add(ApiGetUserDataEvent(userId: _controller.text));
                      },
                      child: const Text(
                        "登入",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
