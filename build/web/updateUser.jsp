<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <script src="https://cdn.tailwindcss.com"></script>
        <title>Cập nhật bài học</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
        </style>
    </head>

    <body class="bg-gray-100 min-h-screen flex flex-col text-gray-800">

        <header class="bg-indigo-600 shadow-lg sticky top-0 z-10 w-full">
            <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
                <div class="text-2xl font-bold text-white">
                    <a href="HomeController">SkillUp Admin ⚙️</a>
                </div>
                <nav class="space-x-4 flex items-center">
    <!--                <a class="text-white hover:text-red-200 font-medium ">${sessionScope.fullname}</a>-->
                    <a href="ListCourseController" class="text-white hover:text-red-200 font-medium">Quản Lý Khóa Học</a>
                    <a href="ListUserController" class="text-white hover:text-red-200 font-medium">Quản Lý Người Dùng</a>
                    <a href="login.jsp" class="bg-white text-red-600 py-1 px-3 rounded-md font-semibold hover:bg-gray-100 transition duration-150">${sessionScope.fullname}</a>
                </nav>
            </div>
        </header>

        <main class="p-6 w-full flex-grow flex items-center justify-center">
            <div class="w-full max-w-md bg-white p-6 rounded-lg shadow-md">
                <h2 class="text-2xl font-semibold mb-6 text-center text-indigo-700">Cập Nhật Người Dùng</h2>

                <form action="UpdateUserController" method="POST" class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium">ID</label>
                        <input type="text" name="ID" value="${p.userID}" class="w-full border rounded-md p-2"  readonly/>
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Họ tên</label>
                        <input type="text" name="fname" value="${p.fullName}" class="w-full border rounded-md p-2" readonly />
                    </div>

                    <div>
                        <label class="block text-sm font-medium">Email</label>
                        <input type="email" name="email" value="${p.email}" class="w-full border rounded-md p-2" readonly />
                    </div>

                    <div>
                        <label class="block text-sm font-medium mb-1">Vai trò</label>
                        <div class="flex gap-4">

                            <label class="inline-flex items-center">
                                <input type="radio" name="role" value="1" 
                                       ${p.role == 1 ? "checked" : ""} class="mr-1">
                                User
                            </label>

                            <label class="inline-flex items-center">
                                <input type="radio" name="role" value="3" 
                                       ${p.role == 3 ? "checked" : ""} class="mr-1">
                                Admin
                            </label>

                        </div>
                    </div>



                    <div class="text-center">
                        <button type="submit" 
                                class="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 transition duration-150">
                            Cập Nhật
                        </button>
                        <a href="ListUserController" class="ml-2 text-gray-600 hover:text-indigo-600">Hủy</a>
                    </div>
                </form>
            </div>
        </main>

        <!-- Footer -->
        <footer class="bg-gray-800 text-white py-6 mt-auto">
            <div class="max-w-7xl mx-auto px-4 text-center">
                <p class="text-sm">&copy; 2025 SkillUp Easy | Liên hệ: contact@skillupeasy.vn</p>
            </div>
        </footer>
    </body>
</html>
