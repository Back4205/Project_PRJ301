<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Khóa Học - ${course.title}</title>

        <script src="https://cdn.tailwindcss.com"></script>

        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />

        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
            .md\:sticky-sidebar {
                position: -webkit-sticky;
                position: sticky;
                top: 84px; /* 72px header + 12px padding */
            }
            /* Style cho sao vàng khi hiển thị */
            .star-rating {
                color: #fbbf24; /* Tailwind 'text-amber-400' */
            }
        </style>
    </head>

    <body class="bg-gray-100 font-sans flex flex-col min-h-screen">

        <%-- Kiểm tra session --%>
        <%
            if (session.getAttribute("fullname") == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

        <header class="bg-indigo-600 shadow-lg sticky top-0 z-10">
            <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
                <div class="text-2xl font-bold text-white">
                    <a href="HomeController">SkillUp Easy 🎓</a>
                </div>

                <nav class="space-x-4 flex items-center">
<!--                    <a class="text-white hover:text-red-200 font-medium ">${sessionScope.fullname}</a>-->
                    <a href="MyCoursesController" class="text-white hover:text-indigo-200 font-medium ">Khóa Học Của Tôi</a>
                    <a href="${pageContext.request.contextPath}/CartController" class="relative text-white hover:text-indigo-200">
                        <i class="fa-solid fa-cart-shopping text-2xl"></i>
                        <c:if test="${not empty sessionScope.cart}">
                            <span class="absolute -top-2 -right-3 bg-red-500 text-white text-xs rounded-full px-2 py-0.5">
                                ${fn:length(sessionScope.cart)}
                            </span>
                        </c:if>
                    </a>
                    <form action="LogoutController" method="GET">
                        <button type="submit" class="bg-white text-red-600 py-1 px-3 rounded-md font-semibold hover:bg-gray-100 transition duration-150">${sessionScope.fullname}</button>
                    </form>
                </nav>
            </div>
        </header>

        <main class="flex-grow">

            <div class="max-w-5xl mx-auto mt-10 bg-white p-8 rounded-2xl shadow-lg">
                <div class="flex flex-col md:flex-row gap-8">

                    <div class="flex-1">
                        <img src="${pageContext.request.contextPath}/${course.thumbnailURL}" 
                             alt="${course.title}" 
                             class="w-full rounded-xl border shadow-sm aspect-video object-cover">
                    </div>

                    <div class="flex-1">
                        <h1 class="text-3xl font-bold mb-2">${course.title}</h1>
                        <p class="text-gray-600 mb-4">${course.description}</p>

                        <p class="text-indigo-600 font-semibold mb-2">
                            <c:choose>
                                <c:when test="${course.category == 1}">Ngành học: Information technology  </c:when>
                                <c:when test="${course.category == 2}">Ngành học: Information technology  </c:when>
                                <c:when test="${course.category == 3}">Ngành học: Information technology </c:when>
                                <c:when test="${course.category == 4}">Ngành học: Information technology  </c:when>
                                <c:when test="${course.category == 5}">Ngành học: Information technology  </c:when>
                                <c:when test="${course.category == 6}">Ngành học: Business administration </c:when>
                                <c:when test="${course.category == 7}">Ngành học: Business administration </c:when>
                                <c:when test="${course.category == 8}">Ngành học: Business administration</c:when>
                                <c:when test="${course.category == 9}">Ngành học: Business administration </c:when>
                                <c:when test="${course.category == 10}">Ngành học: Business administration</c:when>
                                <c:when test="${course.category == 11}">Ngành học:language industry  </c:when>
                                <c:when test="${course.category == 12}">Ngành học:language industry </c:when>
                                <c:when test="${course.category == 13}">Ngành học:language industry </c:when>
                                <c:when test="${course.category == 14}">Ngành học:language industry</c:when>
                                <c:when test="${course.category == 15}">Ngành học:language industry </c:when>
                                <c:otherwise>Unknown</c:otherwise>
                            </c:choose> 
                        </p>
                        <p class="text-gray-800 font-medium mb-2">
                            <c:choose>
                                <c:when test="${course.category == 1}">Kỳ học: 1  </c:when>
                                <c:when test="${course.category == 2}">Kỳ học: 2  </c:when>
                                <c:when test="${course.category == 3}">Kỳ học: 3</c:when>
                                <c:when test="${course.category == 4}">Kỳ học: 4  </c:when>
                                <c:when test="${course.category == 5}">Kỳ học: 5 </c:when>
                                <c:when test="${course.category == 6}">Kỳ học: 1 </c:when>
                                <c:when test="${course.category == 7}">Kỳ học: 2 </c:when>
                                <c:when test="${course.category == 8}">Kỳ học: 3</c:when>
                                <c:when test="${course.category == 9}">Kỳ học: 4 </c:when>
                                <c:when test="${course.category == 10}">Kỳ học: 5</c:when>
                                <c:when test="${course.category == 11}">Kỳ học: 1 </c:when>
                                <c:when test="${course.category == 12}">Kỳ học: 2</c:when>
                                <c:when test="${course.category == 13}">Kỳ học: 3 </c:when>
                                <c:when test="${course.category == 14}">Kỳ học: 4</c:when>
                                <c:when test="${course.category == 15}">Kỳ học: 5 </c:when>
                                <c:otherwise>Unknown</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="text-2xl font-bold mb-4">
                            <c:choose>
                                <c:when test="${course.price == 0}">Miễn phí 🎉</c:when>
                                <c:otherwise>${course.price} VNĐ</c:otherwise>
                            </c:choose>
                        </p>

                        <form action="CartController" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="courseID" value="${course.courseID}">
                            <button type="submit" 
                                    class="bg-blue-600 text-white px-5 py-2 rounded hover:bg-blue-700 transition">
                                🛒 Thêm vào giỏ hàng
                            </button>
                        </form>


                        <form action="EnrollController" method="post">
                            <input type="hidden" name="courseID" value="${course.courseID}">
                            <input type="hidden" name="price" value="${course.price}">

                            <div class="flex gap-4">
                                <button type="submit" name="action" value="buy"
                                        class="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700 transition duration-150">
                                    💳 Mua ngay
                                </button>
                            </div>
                        </form>

                        <div class="mt-6">
                            <p class="text-sm font-medium text-gray-700 mb-3">Chấp nhận thanh toán an toàn:</p>
                            <div class="flex items-center space-x-4 text-3xl text-gray-500">
                                <i class="fa-brands fa-cc-visa" title="Visa"></i>
                                <i class="fa-brands fa-cc-mastercard" title="Mastercard"></i>
                                <i class="fa-brands fa-cc-paypal" title="PayPal"></i>
                                <i class="fa-brands fa-cc-amex" title="American Express"></i>
                                <!-- Thêm MoMo và ZaloPay -->

                                <img src="https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png" alt="MoMo" title="MoMo" class="w-8 h-8 object-contain" />
                                <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-ZaloPay-Square-1024x1024.png" alt="ZaloPay" title="ZaloPay" class="w-8 h-8 object-contain" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="max-w-5xl mx-auto mt-10 mb-10 px-8">




                <h3 class="text-xl font-semibold mb-4 text-gray-800">Các đánh giá khóa học </h3>

                <c:choose>
                    <c:when test="${empty listReviews}">
                        <p class="text-gray-500 italic">Chưa có đánh giá nào cho khóa học này.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${listReviews}">
                            <div class="bg-white p-5 rounded-lg shadow-md mb-4">
                                <div class="flex justify-between items-center mb-2">
                                    <h4 class="font-semibold text-gray-900">
                                        ${r.user.fullName}
                                    </h4>
                                    <div class="star-rating">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= r.rating}">⭐</c:when>
                                                <c:otherwise>☆</c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                                <p class="text-gray-700">${r.comment}</p>
                                <p class="text-xs text-gray-500 mt-2">
                                    Đã đăng ngày ${r.reviewDate}
                                </p>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

            </div>

        </main>

        <footer class="bg-gray-900 text-white py-6">
            <div class="max-w-7xl mx-auto px-4 text-center">
                <p class="text-sm">&copy; 2025 SkillUp Easy Admin Panel.</p>
            </div>
        </footer>

    </body>
</html>