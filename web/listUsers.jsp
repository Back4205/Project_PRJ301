<%--
    Document   : listuser (Đã sửa tên file cho đúng)
    Created on : Oct 20, 2025, 1:46:41 PM
    Author     : Vuong Bach
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Người Dùng - SkillUp Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            /* 2. Đổi nền thành xám nhạt để làm nổi bật card */
            background-color: #f4f5f7;
        }
    </style>
</head>
<%
    if (session.getAttribute("fullname") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<body class="min-h-screen flex flex-col text-gray-800">
    <header class="bg-indigo-600 shadow-lg sticky top-0 z-10">
        <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
            <div class="text-2xl font-bold text-white">
                <a href="HomeController">SkillUp Admin ⚙️</a>
            </div>
            
            <nav class="space-x-4 flex items-center">
<!--                <a class="text-white hover:text-red-200 font-medium ">${sessionScope.fullname}</a>-->
                <a href="ListCourseController" class="text-white hover:text-red-200 font-medium ">Quản Lý Khóa Học</a>
                <a href="ListUserController" class="text-white hover:text-red-200 font-medium">Quản Lý Người Dùng</a>
                <a href="login.jsp" class="bg-white text-red-600 py-1 px-3 rounded-md font-semibold hover:bg-gray-100 transition duration-150">${sessionScope.fullname}</a>
            </nav>
        </div>
    </header>
    
    <main class="p-6 max-w-7xl mx-auto w-full flex-grow">
        <h2 class="text-3xl font-bold mb-6 text-gray-800">Danh Sách Người Dùng</h2>

        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="w-full text-left">
                <thead class="bg-gray-100 text-gray-600 uppercase text-sm">
                    <tr>
                        <th class="p-4">ID</th>
                        <th class="p-4">Họ Tên</th>
                        <th class="p-4">Email</th>
                        <th class="p-4">Quyền</th>
                        <th class="p-4">Ngày Tạo</th>
                        <th class="p-4 text-center"></th>
                    </tr>
                </thead>
                <tbody class="text-gray-700">
                    <c:forEach var="u" items="${sessionScope.listUser}">
                        <tr class="border-t border-gray-200 hover:bg-gray-50">
                            <td class="p-4">${u.userID}</td>
                            <td class="p-4 font-medium text-gray-900">${u.fullName}</td>
                            <td class="p-4">${u.email}</td>
                            <td class="p-4">
                                <c:choose>
                                    <c:when test="${u.role == 1}">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-blue-100 text-blue-800">
                                            User
                                        </span>
                                    </c:when>
                                    <c:when test="${u.role == 3}">
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">
                                            Admin
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="px-3 py-1 text-xs font-semibold rounded-full bg-gray-100 text-gray-800">
                                            Unknown
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="p-4 text-sm">${u.registerDate}</td>
                            <td class="p-4 text-center space-x-3">
                                <a href="UpdateUserController?uid=${u.userID}" 
                                   class="text-indigo-600 hover:underline font-medium">Sửa</a>
                                <a href="DeleteUserController?uid=${u.userID}" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')" 
                                   class="text-red-600 hover:underline font-medium">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty sessionScope.listUser}">
                        <tr>
                            <td colspan="6" class="p-4 text-center text-gray-500">
                                Không tìm thấy người dùng nào.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>

    <footer class="bg-gray-800 text-white py-6 mt-auto">
        <div class="max-w-7xl mx-auto px-4 text-center">
            <p class="text-sm">&copy; 2025 SkillUp Easy | Liên hệ: contact@skillupeasy.vn</p>
        </div>
    </footer>
</body>
</html>