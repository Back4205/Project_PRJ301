<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập Nhật Khóa Học - SkillUp Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
                background-color: #f4f5f7; /* Thay đổi màu nền 1 chút cho dịu mắt */
            }
            /* Đảm bảo textarea giữ nguyên style của input */
            textarea {
                transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
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
<!--                    <a class="text-white hover:text-red-200 font-medium ">${sessionScope.fullname}</a>-->
                    <a href="ListCourseController" class="text-white hover:text-red-200 font-medium">Quản Lý Khóa Học</a>
                    <a href="ListUserController" class="text-white hover:text-red-200 font-medium">Quản Lý Người Dùng</a>
                    <a href="login.jsp" class="bg-white text-red-600 py-1 px-3 rounded-md font-semibold hover:bg-gray-100 transition duration-150">${sessionScope.fullname}</a>
                </nav>
            </div>
        </header>

        <main class="p-6 w-full max-w-4xl mx-auto">
            <div class="bg-white p-6 rounded-lg shadow-md">
                <h2 class="text-2xl font-semibold mb-6 text-center text-indigo-700">Cập Nhật Thông Tin Khóa Học</h2>

                <form action="UpdateCourseController" method="POST" class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium">ID Khóa Học</label>
                        <input type="text" name="ID" value="${p.courseID}" class="w-full border rounded-md p-2 bg-gray-100" readonly/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Tên Khóa Học</label>
                        <input type="text" name="title" value="${p.title}" class="w-full border rounded-md p-2" required />
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Mô Tả</label>
                        <textarea name="description" rows="4" class="w-full border rounded-md p-2" required>${p.description}</textarea>
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Link Ảnh Bìa (Thumbnail)</label>
                        <input type="text" name="thumbnail" value="${p.thumbnailURL}" class="w-full border rounded-md p-2" />
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Giá</label>
                        <input type="number" name="price" value="${p.price}" class="w-full border rounded-md p-2" required />
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Danh Mục</label>
                        <input type="text" name="category" value="${p.category}" class="w-full border rounded-md p-2" required />
                    </div>


                    <div class="mt-8 bg-white p-6 rounded-lg shadow-md">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-xl font-semibold">Danh Sách Bài Học</h3>
                            <a href="AddLessonController?courseID=${p.courseID}"
                               class="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700">
                                + Thêm Bài Học
                            </a>
                        </div>

                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse">
                                <thead>
                                    <tr class="bg-gray-100">
                                        <th class="p-3 border">Bài</th>
                                        <th class="p-3 border">Tiêu đề</th>
                                        <th class="p-3 border">Video URL</th>
                                        <th class="p-3 border text-center"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="l" items="${lessons}" varStatus="loop">
                                        <tr>
                                            <td class="p-3 border w-16 text-center">${loop.count}</td>
                                            <td class="p-3 border">${l.title}</td>
                                            <td class="p-3 border">${l.videoURL}</td>
                                            <td class="p-3 border text-center space-x-2 w-32">
                                                <a href="UpdateLessonController?lessonID=${l.lessonID}"
                                                   class="text-blue-600 hover:underline">Sửa</a>
                                                <a href="DeleteLessonController?lessonID=${l.lessonID}&courseID=${p.courseID}"
                                                   class="text-red-600 hover:underline"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa bài học này?')">
                                                    Xóa
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty lessons}">
                                        <tr>
                                            <td colspan="4" class="p-3 border text-center text-gray-500">Chưa có bài học nào.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="text-center pt-4">
                        <button type="submit"
                                class="bg-indigo-600 text-white px-6 py-2 rounded-md hover:bg-indigo-700 transition duration-150">
                            Cập Nhật Khóa Học
                        </button>
                        <a href="ListCourseController" class="ml-2 text-gray-600 hover:text-indigo-600">Hủy</a>
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