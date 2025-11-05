<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập tài khoản</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Font và CSS của Colorlib -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,500,600,700" rel="stylesheet">
    <link rel="stylesheet" href="colorlib-regform-7/css/style.css">
    <link rel="stylesheet" href="colorlib-regform-7/fonts/material-icon/css/material-design-iconic-font.min.css">

    <style>
        /* Tuỳ chỉnh thêm để khớp với giao diện cũ */
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

        .register-link {
            text-align: center;
            margin-top: 25px;
            font-size: 0.95rem;
            color: #666;
        }

        .register-link a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<%
    // Lấy cookie để hiển thị email đã lưu
    Cookie[] cookies = request.getCookies();
    String savedUsername = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("COOKIE_EMAIl".equals(cookie.getName())) {
                savedUsername = cookie.getValue();
                break;
            }
        }
    }
    if (savedUsername != null) {
        pageContext.setAttribute("UsernameSaved", savedUsername);
    }
%>

<div class="main">

    <section class="sign-in">
        <div class="container">
            <div class="signin-content">

                <div class="signin-image">
                    <figure><img src="colorlib-regform-7/images/signin-image.jpg" alt="Đăng nhập hình ảnh"></figure>
<!--                    <a href="register.jsp" class="signup-image-link">Tạo tài khoản mới</a>-->
                </div>

                <div class="signin-form">
                    <h2 class="form-title">Đăng nhập</h2>

                    <% String errorMessage = (String) request.getAttribute("error");
                       if (errorMessage != null) { %>
                        <p class="error-message"><%= errorMessage %></p>
                    <% } %>

                    <form method="POST" action="LoginController" class="register-form" id="login-form">
                        <div class="form-group">
                            <label for="email"><i class="zmdi zmdi-email"></i></label>
                            <input type="text" name="email" id="email" value="${UsernameSaved}" placeholder="Nhập email" required/>
                        </div>
                        <div class="form-group">
                            <label for="password"><i class="zmdi zmdi-lock"></i></label>
                            <input type="password" name="password" id="password" placeholder="Nhập mật khẩu" required/>
                        </div>
                        <div class="form-group">
                            <input type="checkbox" name="rememberMe" id="rememberMe" value="true" class="agree-term" />
                            <label for="rememberMe" class="label-agree-term"><span><span></span></span>Ghi nhớ tôi</label>
                        </div>
                        <div class="form-group form-button" style="text-align: center">
                            <input type="submit" name="signin" id="signin" class="form-submit" value="Đăng nhập"/>
                        </div>
                    </form>

                    <div class="register-link">
                        Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a>
                    </div>
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
