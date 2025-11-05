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
<%-- Thêm 'flex flex-col min-h-screen' để body chiếm toàn màn hình và xếp con theo cột --%>
<body class="flex flex-col min-h-screen bg-gray-100">

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

    <%-- Thêm 'flex-grow' để nội dung chính lấp đầy không gian, đẩy footer xuống --%>
    <main class="flex-grow">
        <div class="max-w-7xl mx-auto px-4 pt-8">
            <h2 class="text-3xl font-bold mb-6">Khóa Học Của Tôi 📚</h2>

            <c:choose>
                <c:when test="${empty courseList}">
                    <p class="text-gray-500 italic">Bạn chưa mua khóa học nào.</p>
                </c:when>
                <c:otherwise>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                        <c:forEach var="course" items="${courseList}">
                            <div class="bg-white p-4 rounded-xl shadow-lg border border-gray-100 flex flex-col">
                                <div class="h-32 bg-indigo-100 mb-4 flex items-center justify-center rounded-lg overflow-hidden">
                                    <img src="${pageContext.request.contextPath}/${course.thumbnailURL}" alt="${course.title}" class="object-cover h-full w-full"/>
                                </div>
                                <h3 class="text-xl font-bold text-gray-900 mb-2">${course.title}</h3>
                                <p class="text-gray-600 text-sm mb-2">${course.description}</p>
                                <span class="text-lg font-semibold ${course.price == 0 ? 'text-green-600' : 'text-red-600'}">
                                    <c:choose>
                                        <c:when test="${course.price == 0}">Miễn Phí</c:when>
                                        <c:otherwise>${course.price} VNĐ</c:otherwise>
                                    </c:choose>
                                </span>
                                <a href="DetailCourseController?id=${course.courseID}" class="mt-3 inline-block text-indigo-600 font-semibold hover:text-indigo-800">
                                    Xem chi tiết →
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </main>

    <%-- Bỏ 'mt-auto' vì 'flex-grow' ở main đã xử lý --%>
    <footer class="bg-gray-800 text-white py-6">
        <div class="max-w-7xl mx-auto px-4 text-center">
            <p class="text-sm">&copy; 2025 SkillUp Easy | Liên hệ: contact@skillupeasy.vn</p>
        </div>
    </footer>    

</body>

</html>