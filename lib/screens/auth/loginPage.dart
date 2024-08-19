import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:shopipi_mobile_v2/https/authApi.dart';
import 'package:shopipi_mobile_v2/provider/authProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _loading = false;
  bool _hindden = true;

  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailError = 'Vui lòng nhập email';
      });
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        setState(() {
          _emailError = 'Vui lòng nhập email hợp lệ';
        });
      } else {
        setState(() {
          _emailError = null;
        });
      }
    }
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordError = 'Vui lòng nhập mật khẩu';
      });
    } else if (value.length < 3) {
      setState(() {
        _passwordError = 'Mật khẩu phải có ít nhất 3 ký tự';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }

  void _login() async {
    // Thực hiện đăng nhập chỉ khi không có lỗi
    if (_emailError != null && _passwordError != null) return;

    setState(() {
      _loading = true;
    });

    try {
      final data = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      // Gọi API đăng nhập ở đây
      await authApi.login(data);

      // Lưu thông tin user vào provider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.fetchUser();

      setState(() {
        _loading = false;
      });

      print('Đăng nhập thành công với email: ${_emailController.text}');
    } catch (e) {
      print('Đăng nhập thất bại: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const GFImageOverlay(
                  height: 100,
                  width: 100,
                  shape: BoxShape.circle,
                  image: AssetImage('assets/images/logo.png'),
                  boxFit: BoxFit.contain,
                ),
                SizedBox(height: 16),
                // Form
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // TextFormField cho email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: _emailError,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: _validateEmail,
                        ),
                        SizedBox(height: 16),

                        // TextFormField cho mật khẩu
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            errorText: _passwordError,
                          ),
                          obscureText: true,
                          onChanged: _validatePassword,
                        ),
                        SizedBox(height: 24),

                        // Nút đăng nhập
                        GFButton(
                          onPressed: _loading ? null : _login,
                          shape: GFButtonShape.pills,
                          text: 'Đăng nhập',
                        ),
                      ],
                    ),
                  ),
                ),
                // Phần chưa có tài khoản? Đăng ký
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Chưa có tài khoản?'),
                    GFButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      text: 'Đăng ký',
                      type: GFButtonType.transparent,
                      size: GFSize.SMALL,
                      shape: GFButtonShape.square,
                      fullWidthButton: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_loading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
