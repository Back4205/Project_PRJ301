<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="model.Course"%>
<%
    // Scriptlet MỚI của bạn (tính tổng tiền)
    List<Course> cart = (List<Course>) session.getAttribute("cart");
    double totalPrice = 0;
    if (cart != null) {
        for (Course c : cart) {
            totalPrice += c.getPrice();
        }
    }
    request.setAttribute("totalPrice", totalPrice);
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng | SkillUp Easy</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            /* Tùy chỉnh thanh cuộn nếu cần */
            ::-webkit-scrollbar {
                width: 8px;
            }
            ::-webkit-scrollbar-track {
                background: #f1f1f1;
            }
            ::-webkit-scrollbar-thumb {
                background: #888;
                border-radius: 4px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #555;
            }
        </style>
    </head>

    <body class="flex flex-col min-h-screen bg-gray-50 font-sans">

        <%-- ****** HEADER CŨ (TỪ PHIÊN BẢN TRƯỚC) ****** --%>
        <header class="bg-indigo-600 shadow-lg sticky top-0 z-10">
            <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
                <div class="text-2xl font-bold text-white">
                    <a href="HomeController">SkillUp Easy 🎓</a>
                </div>
                <nav class="space-x-4 flex items-center">
                    <%-- 
                        Lưu ý: Header này không có logic 'Đăng nhập'
                        Nó chỉ hiển thị tên (nếu có) và nút 'Đăng xuất' 
                    --%>
<!--                    <a class="text-white hover:text-red-200 font-medium ">${sessionScope.fullname}</a>-->
                    <a href="MyCoursesController" class="text-white hover:text-indigo-200 font-medium ">Khóa Học Của Tôi</a>
                    <a href="${pageContext.request.contextPath}/CartController" class="relative text-white hover:text-indigo-200">
                        <i class="fa-solid fa-cart-shopping text-2xl"></i>
                        <c:if test="${not empty sessionScope.cart && fn:length(sessionScope.cart) > 0}">
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




        <main class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div class="max-w-5xl mx-auto">
                <h2 class="text-3xl font-extrabold text-gray-900 mb-8 flex items-center">
                    <i class="fa-solid fa-bag-shopping mr-3 text-indigo-600"></i> Giỏ hàng của bạn
                </h2>

                <% if (cart == null || cart.isEmpty()) { %>
                <div class="text-center py-16 bg-white rounded-2xl shadow-sm">
                    <i class="fa-solid fa-cart-arrow-down text-6xl text-gray-300 mb-4"></i>
                    <p class="text-xl text-gray-500 mb-6">Giỏ hàng của bạn đang trống.</p>
                    <a href="HomeController" class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 transition duration-150">
                        <i class="fa-solid fa-arrow-left mr-2"></i> Tiếp tục mua sắm
                    </a>
                </div>
                <% } else { %>
                <div class="bg-white shadow overflow-hidden sm:rounded-lg">
                    <ul role="list" class="divide-y divide-gray-200">
                        <% for (Course c : cart) { %>
                        <li class="px-4 py-5 sm:px-6 hover:bg-gray-50 transition duration-150 flex flex-col sm:flex-row items-start sm:items-center justify-between">
                            <div class="flex-1 mb-4 sm:mb-0">
                                <div class="flex items-center justify-between">
                                    <h3 class="text-lg leading-6 font-medium text-indigo-600 truncate">
                                        <%= c.getTitle() %>
                                    </h3>
                                    <p class="ml-2 flex-shrink-0 flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800 sm:hidden">
                                        <fmt:formatNumber value="<%= c.getPrice() %>" type="currency" currencySymbol="₫"/>
                                    </p>
                                </div>
                                <div class="mt-2 sm:flex sm:justify-between">
                                    <div class="sm:flex">
                                        <p class="flex items-center text-sm text-gray-500">
                                            <i class="fa-solid fa-barcode mr-1.5 text-gray-400"></i>
                                            Mã khóa học: <%= c.getCourseID() %>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="flex items-center justify-between sm:justify-end w-full sm:w-auto sm:ml-6 space-x-4">
                                <p class="hidden sm:block px-3 py-1 inline-flex text-base leading-5 font-semibold rounded-full bg-indigo-100 text-indigo-800">
                                    <fmt:formatNumber value="<%= c.getPrice() %>" type="currency" currencySymbol="₫"/>
                                </p>

                                <div class="flex space-x-2">
                                    <form action="CartController" method="post" class="inline">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="courseID" value="<%= c.getCourseID() %>">
                                        <button type="submit" class="inline-flex items-center px-3 py-2 border border-gray-300 shadow-sm text-sm leading-4 font-medium rounded-md text-gray-700 bg-white hover:bg-red-50 hover:text-red-600 focus:outline-none transition duration-150" title="Xóa khỏi giỏ">
                                            <i class="fa-solid fa-trash-can sm:mr-2"></i> <span class="hidden sm:inline">Xóa</span>
                                        </button>
                                    </form>
                                    <form action="CartController" method="post" class="inline">
                                        <input type="hidden" name="action" value="buy">
                                        <input type="hidden" name="courseID" value="<%= c.getCourseID() %>">
                                        <button type="submit" class="inline-flex items-center px-3 py-2 border border-transparent shadow-sm text-sm leading-4 font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none transition duration-150" title="Mua ngay">
                                            <i class="fa-regular fa-credit-card sm:mr-2"></i> <span class="hidden sm:inline">Mua ngay</span>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </li>
                        <% } %>
                    </ul>

                    <div class="px-4 py-5 sm:px-6 bg-gray-50 border-t border-gray-200">
                        <div class="flex flex-col sm:flex-row justify-between items-center mb-4">
                            <div class="text-lg font-medium text-gray-900 mb-4 sm:mb-0">
                                Tổng cộng: <span class="text-2xl font-bold text-indigo-600 ml-2"><fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="₫"/></span>
                            </div>
                            <div class="flex space-x-3">
                                <form action="CartController" method="post">
                                    <input type="hidden" name="action" value="clear">
                                    <button type="submit" class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-red-50 hover:text-red-700 focus:outline-none transition duration-150">
                                        <i class="fa-solid fa-broom mr-2"></i> Xóa toàn bộ
                                    </button>
                                </form>
                                <a href="HomeController" class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 transition duration-150">
                                    <i class="fa-solid fa-arrow-left mr-2"></i> Tiếp tục xem
                                </a>
                                <form action="CartController" method="post">
                                    <input type="hidden" name="action" value="buyAll">
                                    <button type="submit"
                                            class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none transition duration-150">
                                        Thanh toán tất cả <i class="fa-solid fa-arrow-right ml-2"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </main>




        <footer class="bg-gray-800 text-white py-6 mt-auto">
            <div class="max-w-7xl mx-auto px-4 text-center">
                <p class="text-sm">&copy; 2025 SkillUp Easy | Liên hệ: contact@skillupeasy.vn</p>
            </div>
        </footer>


    </body>
</html>