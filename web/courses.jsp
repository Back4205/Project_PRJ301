<%--
    Document   : listcourse
    Created on : Oct 20, 2025, 1:46:41 PM
    Author     : Vuong Bach
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Khóa Học - SkillUp Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                font-family: 'Inter', sans-serif;
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
            
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-3xl font-bold text-gray-800">Danh Sách Khóa Học</h2>
                <a href="addCourse.jsp"
                   class="bg-indigo-600 text-white px-4 py-2 rounded-md font-semibold hover:bg-indigo-700 transition duration-150">
                    + Thêm Khóa Học
                </a>
            </div>

            <div class="bg-white rounded-lg shadow-md overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-gray-100 text-gray-600 uppercase text-sm">
                        <tr>
                            <th class="p-4">ID</th>
                            <th class="p-4">Tên Khóa Học</th>
                            <th class="p-4">Mô Tả</th>
                            <th class="p-4">Giá</th>
                            <th class="p-4">Người Tạo</th>
                            <th class="p-4">Danh Mục</th>
                            <th class="p-4">Ngày Tạo</th>
                             <th class="p-4">slbr</th>
                            <th class="p-4 text-center"></th>
                        </tr>
                    </thead>
                    <tbody class="text-gray-700">
                        <c:forEach var="u" items="${sessionScope.listCourse}">
                            <tr class="border-t border-gray-200 hover:bg-gray-50">
                                <td class="p-4 text-center">${u.courseID}</td>
                                <td class="p-4 font-medium text-gray-900">${u.title}</td>
                                <td class="p-4 max-w-xs truncate" title="${u.description}">${u.description}</td>
                                <td class="p-4">${u.price}</td>
                                <td class="p-4">
                                    <c:choose>
                                        <c:when test="${u.admin == 1}">
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
                                <td class="p-4">
                                    <span class="px-3 py-1 text-xs font-semibold rounded-full bg-indigo-100 text-indigo-800">
                                        <c:choose>
                                            <c:when test="${u.category == 1}">SE kỳ 1</c:when>
                                            <c:when test="${u.category == 2}">SE kỳ 2</c:when>
                                            <c:when test="${u.category == 3}">SE kỳ 3</c:when>
                                            <c:when test="${u.category == 4}">SE kỳ 4</c:when>
                                            <c:when test="${u.category == 5}">SE kỳ 5</c:when>
                                            <c:when test="${u.category == 6}">HS kỳ 1</c:when>
                                            <c:when test="${u.category == 7}">HS kỳ 2</c:when>
                                            <c:when test="${u.category == 8}">HS kỳ 3</c:when>
                                            <c:when test="${u.category == 9}">HS kỳ 4</c:when>
                                            <c:when test="${u.category == 10}">HS kỳ 5</c:when>
                                            <c:when test="${u.category == 11}">HA kỳ 1</c:when>
                                            <c:when test="${u.category == 12}">HA kỳ 2</c:when>
                                            <c:when test="${u.category == 13}">HA kỳ 3</c:when>
                                            <c:when test="${u.category == 14}">HA kỳ 4</c:when>
                                            <c:when test="${u.category == 15}">HA kỳ 5</c:when>
                                            <c:otherwise>Unknown</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td class="p-4 text-sm">${u.createDate}</td>
                                <td class="p-4 text-sm">${u.number}</td>
                                <td class="p-4 text-center space-x-3">
                                    <a href="UpdateCourseController?uid=${u.courseID}" class="text-indigo-600 hover:underline font-medium">Sửa</a>
                                    <a href="DeleteCourseController?uid=${u.courseID}" onclick="return confirm('Xóa khóa học này?')" class="text-red-600 hover:underline font-medium">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                            
                        <c:if test="${empty sessionScope.listCourse}">
                            <tr>
                                <td colspan="8" class="p-4 text-center text-gray-500">
                                    Không tìm thấy khóa học nào.
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