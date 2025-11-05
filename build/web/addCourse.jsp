<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm Khóa Học - SkillUp Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
                /* 2. Sửa nền */
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
                    <a href="homeAdmin.jsp">SkillUp Admin ⚙️</a>
                </div>
                <nav class="space-x-4 flex items-center">
<!--                    <a class="text-white hover:text-red-200 font-medium ">${sessionScope.fullname}</a>-->
                    <a href="ListCourseController" class="text-white hover:text-red-200 font-medium">Quản Lý Khóa Học</a>
                    <a href="ListUserController" class="text-white hover:text-red-200 font-medium">Quản Lý Người Dùng</a>
                    <a href="login.jsp" class="bg-white text-red-600 py-1 px-3 rounded-md font-semibold hover:bg-gray-100 transition duration-150">${sessionScope.fullname}</a>
                </nav>
            </div>
        </header>

        <main class="p-6 w-full flex-grow flex items-center justify-center">
            <div class="w-full max-w-lg bg-white p-6 rounded-lg shadow-md">
                <h2 class="text-2xl font-semibold mb-6 text-center text-indigo-700">Thêm Khóa Học Mới</h2>

                <form action="AddCourseController" method="POST" class="space-y-4">

                    <c:if test="${not empty error}">
                        <div class="p-3 bg-red-100 border border-red-300 text-red-700 rounded-md text-sm">
                            ${error}
                        </div>
                    </c:if>

                    <div>
                        <label class="block text-sm font-medium">Tên Khóa Học</label>
                        <input type="text" name="title" value="${param.title}" class="w-full border rounded-md p-2" required />
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Mô Tả</label>
                        <textarea name="description" rows="4" class="w-full border rounded-md p-2" required>${param.description}</textarea>
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Link Ảnh Bìa (Thumbnail)</label>
                        <input type="text" name="thumbnail" value="${param.thumbnail}" class="w-full border rounded-md p-2" />
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Giá</label>
                        <input type="number" name="price" value="${param.price}" class="w-full border rounded-md p-2" required />
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Danh Mục</label>

                        <select name="category" class="w-full border rounded-md p-2 bg-white" required>

                            <option value="" disabled ${empty param.category ? 'selected' : ''}>-- Vui lòng chọn một danh mục --</option>

                            <option value="1" ${param.category == 1 ? 'selected' : ''}>SE kỳ 1</option>
                            <option value="2" ${param.category == 2 ? 'selected' : ''}>SE kỳ 2</option>
                            <option value="3" ${param.category == 3 ? 'selected' : ''}>SE kỳ 3</option>
                            <option value="4" ${param.category == 4 ? 'selected' : ''}>SE kỳ 4</option>
                            <option value="5" ${param.category == 5 ? 'selected' : ''}>SE kỳ 5</option>
                            <option value="6" ${param.category == 6 ? 'selected' : ''}>HS kỳ 1</option>
                            <option value="7" ${param.category == 7 ? 'selected' : ''}>HS kỳ 2</option>
                            <option value="8" ${param.category == 8 ? 'selected' : ''}>HS kỳ 3</option>
                            <option value="9" ${param.category == 9 ? 'selected' : ''}>HS kỳ 4</option>
                            <option value="10" ${param.category == 10 ? 'selected' : ''}>HS kỳ 5</option>
                            <option value="11" ${param.category == 11 ? 'selected' : ''}>HA kỳ 1</option>
                            <option value="12" ${param.category == 12 ? 'selected' : ''}>HA kỳ 2</option>
                            <option value="13" ${param.category == 13 ? 'selected' : ''}>HA kỳ 3</option>
                            <option value="14" ${param.category == 14 ? 'selected' : ''}>HA kỳ 4</option>
                            <option value="15" ${param.category == 15 ? 'selected' : ''}>HA kỳ 5</option>
                        </select>
                    </div>

                    <div class="pt-2">
                        <button type="submit"
                                class="w-full bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 transition duration-150">
                            Thêm Khóa Học
                        </button>
                        <a href="ListCourseController" class="block text-center mt-3 text-sm text-gray-600 hover:text-indigo-600">Hủy</a>
                    </div>
                </form>
            </div>
        </main>

        <footer class="bg-gray-800 text-white py-6 mt-auto">
            <div class="max-w-7xl mx-auto px-4 text-center">
                <p class="text-sm">&copy; 2025 SkillUp Easy | Liên hệ: contact@skillupeasy.vn</p>
            </div>
        </footer>
    </body>
</html>