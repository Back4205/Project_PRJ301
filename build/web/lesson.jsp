<%--
    Document   : lesson.jsp
    Created on : Oct 23, 2025, 7:06:20 PM
    Author     : Vuong Bach
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Bài học: ${course.title}</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    </head>
    <body class="bg-gray-100 flex flex-col min-h-screen">
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
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
        </c:if>
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 3}">
            <header class="bg-indigo-600 shadow-lg sticky top-0 z-10">
                <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
                    <div class="text-2xl font-bold text-white">
                        <a href="HomeController">SkillUp Admin ⚙️</a>
                    </div>

                    <nav class="space-x-4 flex items-center">

                        <!--<a class="text-white hover:text-red-200 font-medium ">${sessionScope.fullname}</a>-->
                        <a href="ListCourseController" class="text-white hover:text-red-200 font-medium ">Quản Lý Khóa Học</a>
                        <a href="ListUserController" class="text-white hover:text-red-200 font-medium">Quản Lý Người Dùng</a>

                        <form action="LogoutController" method="GET" class="inline">
                            <button type="submit" class="bg-white text-red-600 py-1 px-3 rounded-md font-semibold hover:bg-gray-100 transition duration-150">${sessionScope.fullname}</button>
                        </form>
                    </nav>
                </div>
            </header>
        </c:if>
        <main class="flex-grow">
            <%-- Responsive layout: stacks vertically on mobile (flex-col), side-by-side on desktop (md:flex-row) --%>
            <div class="max-w-6xl mx-auto mt-10 px-4 flex flex-col md:flex-row gap-8">

                <div class="w-full md:w-3/4">
                    <h1 class="text-3xl font-bold mb-4">${course.title}</h1>

                    <div class="aspect-video bg-black rounded-lg shadow-lg">
                        <iframe id="video-player" 
                                width="100%" 
                                height="100%" 
                                src="${listLessons[0].videoURL}" 
                                title="YouTube video player" 
                                frameborder="0" 
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                                allowfullscreen>
                        </iframe>
                    </div>

                    <div class="mt-4 bg-white p-4 rounded-lg shadow">
                        <h2 class="text-xl font-semibold">Mô tả khóa học</h2>
                        <p class="text-gray-700 mt-2">${course.description}</p>
                    </div>

                    <div class="mt-10">
                        <h2 class="text-2xl font-bold mb-6 text-gray-800">Đánh giá khóa học</h2>
                        <hr class="my-6 border-gray-300">

                        <h3 class="text-xl font-semibold mb-4 text-gray-800">Viết đánh giá của bạn</h3>

                       <form action="${pageContext.request.contextPath}/AddReviewController" method="post">
                            <input type="hidden" name="courseID" value="${course.courseID}">

                            <div class="mb-4">
                                <label for="rating" class="block text-gray-700 font-medium mb-1">Số sao:</label>
                                <select id="rating" name="rating" class="border rounded-lg px-3 py-2 w-full" required>
                                    <option value="" disabled selected>-- Chọn số sao --</option>
                                    <option value="5">★★★★★ (5 sao)</option>
                                    <option value="4">★★★★☆ (4 sao)</option>
                                    <option value="3">★★★☆☆ (3 sao)</option>
                                    <option value="2">★★☆☆☆ (2 sao)</option>
                                    <option value="1">★☆☆☆☆ (1 sao)</option>
                                </select>
                            </div>

                            <div class="mb-4">
                                <label for="comment" class="block text-gray-700 font-medium mb-1">Nhận xét:</label>
                                <textarea id="comment" name="comment" rows="4"
                                          class="border rounded-lg px-3 py-2 w-full" required></textarea>
                            </div>

                            <button type="submit"
                                    class="bg-indigo-600 hover:bg-indigo-700 text-white font-semibold px-5 py-2 rounded-lg">
                                Gửi đánh giá
                            </button>

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
                        </form>
                    </div>
                </div>

                <div class="w-full md:w-1/4 bg-white p-4 rounded-lg shadow-lg" style="align-self: flex-start;">
                    <h2 class="text-xl font-bold mb-4 border-b pb-2">Nội dung bài học</h2>
                    <ul class="space-y-2">
                        <c:forEach var="lesson" items="${listLessons}" varStatus="loop">
                            <li>
                                <a href="#" 
                                   class="block p-3 rounded-md hover:bg-indigo-100 text-gray-800"
                                   onclick="changeVideo('${lesson.videoURL}', this); return false;">
                                    <strong>Bài ${loop.count}:</strong> ${lesson.title}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </main>

        <footer class="bg-gray-800 text-white py-6">
            <div class="max-w-7xl mx-auto px-4 text-center">
                <p class="text-sm">&copy; 2025 SkillUp Easy | Liên hệ: contact@skillupeasy.vn</p>
            </div>
        </footer>   

        <script>
            function changeVideo(videoUrl, element) {
                // Đặt video mới cho iframe
                document.getElementById('video-player').src = videoUrl;

                // (Tùy chọn) Highlight bài học đang active
                document.querySelectorAll('.lesson-active').forEach(el => el.classList.remove('lesson-active', 'bg-indigo-100'));
                element.classList.add('lesson-active', 'bg-indigo-100');
            }

            // Tự động highlight bài đầu tiên khi tải trang
            document.addEventListener('DOMContentLoaded', (event) => {
                const firstLesson = document.querySelector('ul.space-y-2 li:first-child a');
                // Thêm kiểm tra 'if' để tránh lỗi nếu listLessons rỗng
                if (firstLesson) {
                    firstLesson.classList.add('lesson-active', 'bg-indigo-100');
                }
            });
        </script>
    </body>
</html>