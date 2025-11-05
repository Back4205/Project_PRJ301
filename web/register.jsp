<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font và CSS từ Colorlib -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,500,600,700" rel="stylesheet">
    <link rel="stylesheet" href="colorlib-regform-7/css/style.css">
    <link rel="stylesheet" href="colorlib-regform-7/fonts/material-icon/css/material-design-iconic-font.min.css">

    <style>
        .message {
            color: #007bff;
            background: rgba(0, 123, 255, 0.08);
            border: 1px solid rgba(0, 123, 255, 0.2);
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 15px;
            text-align: center;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .error-message {
            color: #e53935;
            background: rgba(255, 0, 0, 0.08);
            border: 1px solid rgba(255, 0, 0, 0.3);
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 15px;
            text-align: center;
            font-size: 0.9rem;
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            font-size: 0.95rem;
            color: #666;
        }

        .login-link a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
            color: #43a047;
        }
    </style>
</head>
<body>

<div class="main">
    <section class="signup">
        <div class="container">
            <div class="signup-content">

                <div class="signup-form">
                    <h2 class="form-title">Đăng ký </h2>

                    <% 
                        String message = (String) request.getAttribute("message");
                        String error = (String) request.getAttribute("error");
                        if (message != null) { %>
                            <p class="message"><%= message %></p>
                    <% } else if (error != null) { %>
                            <p class="error-message"><%= error %></p>
                    <% } %>

                    <form method="POST" action="RegisterController" class="register-form" id="register-form">
                        <div class="form-group">
                            <label for="fullName"><i class="zmdi zmdi-account"></i></label>
                            <input type="text" name="fullName" id="fullName" placeholder="Họ và tên" required/>
                        </div>

                        <div class="form-group">
                            <label for="email"><i class="zmdi zmdi-email"></i></label>
                            <input type="email" name="email" id="email" placeholder="Email" required/>
                        </div>

                        <div class="form-group">
                            <label for="password"><i class="zmdi zmdi-lock"></i></label>
                            <input type="password" name="password" id="password" placeholder="Mật khẩu" required/>
                        </div>

                        <div class="form-group">
                            <label for="confirm_password"><i class="zmdi zmdi-lock-outline"></i></label>
                            <input type="password" name="confirm_password" id="confirm_password" placeholder="Xác nhận mật khẩu" required/>
                        </div>

                        <div class="form-group form-button" style="text-align: center">
                            <input type="submit" name="signup" id="signup" class="form-submit" value="Đăng ký"/>
                        </div>
                    </form>

                    <div class="login-link">
                        Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a>
                    </div>
                </div>

                <div class="signup-image">
                    <figure><img src="colorlib-regform-7/images/signup-image.jpg" alt="sign up image"></figure>
<!--                    <a href="login.jsp" class="signup-image-link">Tôi đã có tài khoản</a>-->
                </div>
            </div>
        </div>
    </section>
</div>

<!-- JS -->
<script src="colorlib-regform-7/vendor/jquery/jquery.min.js"></script>
<script src="colorlib-regform-7/js/main.js"></script>

</body>
</html>
