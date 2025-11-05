<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khám Phá Khóa Học - SkillUp</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f7f7f7;
        }
        .filter-active {
            background-color: #4f46e5;
            color: white;
            font-weight: 600;
        }
        /* Sidebar chỉ dài vừa đến hết Kỳ 5 */
        .md\:sticky-sidebar {
            position: -webkit-sticky;
            position: sticky;
            top: 84px;
            max-height: 550px; /* Giới hạn chiều cao */
            overflow-y: auto;
            scrollbar-width: thin;
            scrollbar-color: #ccc transparent;
        }
        .md\:sticky-sidebar::-webkit-scrollbar {
            width: 6px;
        }
        .md\:sticky-sidebar::-webkit-scrollbar-thumb {
            background: #ccc;
            border-radius: 10px;
        }
    </style>

    <%
        if (session.getAttribute("fullname") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
</head>

<body>
<header class="bg-indigo-600 shadow-lg sticky top-0 z-10">
    <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
        <div class="text-2xl font-bold text-white">
            <a href="HomeController">SkillUp Easy 🎓</a>
        </div>

        <nav class="space-x-4 flex items-center">
            
            <a href="MyCoursesController" class="text-white hover:text-indigo-200 font-medium">Khóa Học Của Tôi</a>

            <!-- Giỏ hàng -->
            <a href="${pageContext.request.contextPath}/CartController" class="relative text-white hover:text-indigo-200">
                <i class="fa-solid fa-cart-shopping text-2xl"></i>
                <c:if test="${not empty sessionScope.cart}">
                    <span class="absolute -top-2 -right-3 bg-red-500 text-white text-xs rounded-full px-2 py-0.5">
                        ${fn:length(sessionScope.cart)}
                    </span>
                </c:if>
            </a>
<!--                <a class="text-white font-medium">${sessionScope.fullname}</a>-->
            <form action="LogoutController" method="GET">
                <button type="submit"
                        class="bg-white text-red-600 py-1 px-3 rounded-md font-semibold hover:bg-gray-100 transition">
                   ${sessionScope.fullname}
                </button>
            </form>
        </nav>
    </div>
</header>

<main>
    <div class="max-w-7xl mx-auto px-4 pt-8">
        <p class="text-sm text-gray-500">
            <a href="HomeController" class="hover:underline">Trang Chủ</a> /
            <span class="font-semibold text-indigo-600">Khám Phá Khóa Học</span>
        </p>
    </div>

    <section class="py-12">
        <div class="max-w-7xl mx-auto px-4">
            <div class="flex flex-col md:flex-row justify-between md:items-center gap-4 mb-8">
                <h2 class="text-4xl font-extrabold text-gray-900">Khám Phá Các Khóa Học 📚</h2>

                <div class="relative w-full md:w-72">
                    <input type="text" placeholder="Tên khóa học..."
                           class="w-full p-2 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
                           id="search-input">
                    <button class="absolute right-0 top-0 mt-2 mr-2 text-gray-500 hover:text-indigo-600" id="search-button">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </div>

            <div class="md:grid md:grid-cols-4 md:gap-8">
                <!-- SIDEBAR -->
                <div class="md:col-span-1 mb-8 md:mb-0 p-6 bg-gray-50 rounded-xl shadow-lg md:sticky-sidebar border border-gray-100">
                    <h3 class="text-xl font-bold text-indigo-700 mb-4 border-b pb-2">Chọn Ngành Học</h3>
                    <ul id="industry-filters" class="space-y-2 text-md">
                        <li><a href="#" class="filter-item block p-2 rounded-lg filter-active" data-filter="all" data-filter-type="industry">Tất Cả</a></li>
                        <li><a href="#" class="filter-item block p-2 rounded-lg hover:bg-indigo-100" data-filter="se" data-filter-type="industry">Software Engineering</a></li>
                        <li><a href="#" class="filter-item block p-2 rounded-lg hover:bg-indigo-100" data-filter="hs" data-filter-type="industry">Marketing</a></li>
                        <li><a href="#" class="filter-item block p-2 rounded-lg hover:bg-indigo-100" data-filter="ln" data-filter-type="industry">Language Industry</a></li>
                    </ul>

                    <h3 class="text-xl font-bold text-indigo-700 mt-6 mb-4 border-b pb-2">Chọn Kỳ Học</h3>
                    <ul id="semester-filters" class="space-y-2 text-md">
                        <li><a href="#" class="filter-item block p-2 rounded-lg filter-active" data-filter="all" data-filter-type="semester">Tất Cả</a></li>
                        <c:forEach var="i" begin="1" end="5">
                            <li><a href="#" class="filter-item block p-2 rounded-lg hover:bg-indigo-100" data-filter="${i}" data-filter-type="semester">Kỳ ${i}</a></li>
                        </c:forEach>
                    </ul>
                </div>

                <!-- COURSE LIST -->
                <div class="md:col-span-3">
                    <div id="course-list" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                        <c:forEach var="course" items="${courseList}">
                            <c:choose>
                                <c:when test="${not empty course.categoryName}">
                                    <c:set var="parts" value="${fn:split(course.categoryName, ' ')}" />
                                    <c:set var="semester" value="${parts[1]}" />
                                    <c:set var="industry" value="${parts[fn:length(parts)-1]}" />
                                </c:when>
                                <c:otherwise>
                                    <c:set var="semester" value="1" />
                                    <c:set var="industry" value="se" />
                                </c:otherwise>
                            </c:choose>

                            <div class="course-card bg-white p-4 rounded-xl shadow-lg border border-gray-100 flex flex-col justify-between"
                                 data-industry="${fn:toLowerCase(industry)}"
                                 data-semester="${semester}"
                                 data-title="${fn:toLowerCase(course.title)}">

                                <div>
                                    <div class="h-32 bg-indigo-100 mb-4 flex items-center justify-center rounded-lg overflow-hidden">
                                        <img src="${pageContext.request.contextPath}/${course.thumbnailURL}" alt="${course.title}" />
                                    </div>

                                    <h3 class="text-xl font-bold text-gray-900 mb-1">${course.title}</h3>
                                    <p class="text-gray-600 text-sm mb-3">${course.description}</p>
                                </div>

                                <div class="flex justify-between items-center pt-2 border-t border-gray-100 mt-2">
                                    <span class="text-xl font-bold ${course.price == 0 ? 'text-green-600' : 'text-red-600'}">
                                        <c:choose>
                                            <c:when test="${course.price == 0}">Miễn Phí</c:when>
                                            <c:otherwise>${course.price} VNĐ</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <a href="DetailCourseController?id=${course.courseID}"
                                       class="text-sm font-semibold text-indigo-600 hover:text-indigo-800">
                                        Chi Tiết →
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div id="no-results" class="col-span-3 text-center text-gray-500 py-10 hidden">
                        <h3 class="text-2xl font-bold mb-2">Không tìm thấy kết quả</h3>
                        <p>Vui lòng thử điều chỉnh bộ lọc hoặc từ khóa tìm kiếm của bạn.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>


<footer class="bg-gray-900 text-white py-6 mt-12">
    <div class="max-w-7xl mx-auto px-4 text-center">
        <p class="text-sm">&copy; 2025 SkillUp Easy Admin Panel.</p>
    </div>
</footer>

<!-- JS lọc + tìm kiếm -->
<script>
    let currentFilters = {industry: 'all', semester: 'all', search: ''};
    const courseCards = document.querySelectorAll('.course-card');
    const filterItems = document.querySelectorAll('.filter-item');
    const searchInput = document.getElementById('search-input');
    const noResultsMessage = document.getElementById('no-results');

    function applyFiltersAndSearch() {
        let visibleCount = 0;
        const searchTerm = currentFilters.search.toLowerCase();

        courseCards.forEach(card => {
            const cardIndustry = card.getAttribute('data-industry').toLowerCase();
            const cardSemester = card.getAttribute('data-semester');
            const cardTitle = card.getAttribute('data-title').toLowerCase();

            const industryMatch = currentFilters.industry === 'all' || cardIndustry === currentFilters.industry;
            const semesterMatch = currentFilters.semester === 'all' || currentFilters.semester === cardSemester;
            const searchMatch = cardTitle.includes(searchTerm);

            if (industryMatch && semesterMatch && searchMatch) {
                card.style.display = 'flex';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        noResultsMessage.style.display = visibleCount === 0 ? 'block' : 'none';
    }

    function handleFilterClick(e) {
        e.preventDefault();
        const el = e.currentTarget;
        const val = el.getAttribute('data-filter');
        const type = el.getAttribute('data-filter-type');
        const parent = document.getElementById(type + '-filters');

        currentFilters[type] = val;
        parent.querySelectorAll('.filter-item').forEach(i => i.classList.remove('filter-active'));
        el.classList.add('filter-active');
        applyFiltersAndSearch();
    }

    filterItems.forEach(i => i.addEventListener('click', handleFilterClick));
    searchInput.addEventListener('input', () => {
        currentFilters.search = searchInput.value.trim();
        applyFiltersAndSearch();
    });
    window.onload = applyFiltersAndSearch;
</script>




</body>
</html>
