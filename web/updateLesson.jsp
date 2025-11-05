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
        
        <form action="UpdateLessonController" method="POST"
              class="bg-white p-6 rounded-md shadow-md w-full max-w-md space-y-4">

            <h2 class="text-xl font-semibold text-indigo-700 text-center">Cập nhật bài học</h2>

            <input type="hidden" name="lessonID" value="${lesson.lessonID}">
            <input type="hidden" name="courseID" value="${lesson.course.courseID}">

            <div>
                <label class="font-medium">Tiêu đề</label>
                <input class="border w-full p-2 rounded-md"
                       type="text" name="title" value="${lesson.title}" required/>
            </div>

            <div>
                <label class="font-medium">Video URL</label>
                <input class="border w-full p-2 rounded-md"
                       type="text" name="videoURL" value="${lesson.videoURL}" required/>
            </div>

            <div class="flex gap-2 pt-2">
                <button type="submit"
                        class="bg-indigo-600 flex-1 text-white py-2 rounded-md hover:bg-indigo-700">
                    Lưu
                </button>
                <a href="UpdateCourseController?uid=${lesson.course.courseID}"
                   class="bg-gray-400 flex-1 text-white text-center py-2 rounded-md hover:bg-gray-500">
                    Hủy
                </a>
            </div>
        </form>
        
    </main>

    <footer class="bg-gray-800 text-white py-6 mt-auto w-full">
        <div class="max-w-7xl mx-auto px-4 text-center">
            <p class="text-sm">&copy; 2025 SkillUp Easy | Liên hệ: contact@skillupeasy.vn</p>
        </div>
    </footer>
</body>
</html>