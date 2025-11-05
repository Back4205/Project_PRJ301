

-- ============================
-- USERS (ADMIN + USER)
-- ============================
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role TINYINT CHECK (Role IN (1, 3)) NOT NULL DEFAULT 1,  -- 1=User, 3=Admin
    RegisterDate DATETIME DEFAULT GETDATE()
);
GO

-- ============================
-- CATEGORIES
-- ============================
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) UNIQUE NOT NULL,
    Description NVARCHAR(MAX)
);
GO

-- ============================
-- COURSES
-- ============================
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(150) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(10,2) CHECK (Price >= 0) DEFAULT 0,
    AdminID INT NOT NULL,  -- chính là UserID có role = 3
    CategoryID INT NULL,
    ThumbnailURL NVARCHAR(255),
    CreateDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AdminID) REFERENCES Users(UserID) ON DELETE NO ACTION,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE SET NULL
);
GO

-- ============================
-- LESSONS
-- ============================
CREATE TABLE Lessons (
    LessonID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL,
    Title NVARCHAR(150) NOT NULL,
    VideoURL NVARCHAR(255),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);
GO

-- ============================
-- ENROLLMENTS
-- ============================
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollDate DATETIME DEFAULT GETDATE(),
    Progress DECIMAL(5,2) DEFAULT 0 CHECK (Progress BETWEEN 0 AND 100),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
    UNIQUE (UserID, CourseID)
);
GO

-- ============================
-- PAYMENTS
-- ============================
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(50)
        CHECK (PaymentMethod IN ('Credit Card', 'Bank Transfer', 'Momo', 'ZaloPay')),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);
GO

-- ============================
-- REVIEWS
-- ============================
CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);
GO




INSERT INTO Categories (CategoryName, Description)
VALUES 
('Semester 1 SE', 'The course deals with basic programming knowledge and familiarization with computer structure and hardware.'),
('Semester 2 SE', 'Basic course in object-oriented programming. Focus on teamwork.'),
('Semester 3 SE', 'The introductory practical courses are the foundation for later programming.'),
('Semester 4 SE', 'The course deals with web application development, embedded programming, and statistical probability.'),
('Semester 5 SE', 'Practice and build mini projects to develop applications using C#.'),
('Semester 1 HS', 'Introduction to Microeconomics: Understanding supply, demand, and market structures.'),
('Semester 2 HS', 'Macroeconomics: National income, inflation, and unemployment analysis.'),
('Semester 3 HS', 'Financial Accounting: Basics of financial reporting and analysis.'),
('Semester 4 HS', 'Marketing Principles: Consumer behavior and marketing strategies.'),
('Semester 5 HS', 'Business Strategy: Strategic planning and competitive analysis.'),
('Semester 1 LN', 'Basic English: Foundation in grammar, vocabulary, and simple conversation.'),
('Semester 2 LN', 'Intermediate English: Focus on reading comprehension and writing skills.'),
('Semester 3 LN', 'Advanced English: Professional communication and critical thinking skills.'),
('Semester 4 LN', 'Business English: Formal writing, emails, and presentation skills for the workplace.'),
('Semester 5 LN', 'Introduction to Japanese: Hiragana, Katakana, and basic conversation.');




INSERT INTO Courses (Title, Description, Price, ThumbnailURL, CategoryID, CreateDate, AdminID)
VALUES
('JPN101', 'Introduction to Japanese', 600.00, 'images/jpn101.png', 15, '2025-10-10', 1),
('CEA201', 'Computer Organization and Architecture.', 700.00, 'images/cea201.png', 1,'2025-10-10', 1),
('CSD201', 'Data Structures and Algorithms', 400.00, 'images/csd201.png', 3, '2025-10-10', 1),
('CSI104', 'Introduction to Computer Science.', 600.00, 'images/csi104.png', 1,'2025-10-10', 1),
('DBI202', 'Introduction to Databases', 600.00, 'images/dbi202.png', 3, '2025-10-10', 1),
('MCI101', 'Introduction to Microeconomics', 400.00, 'images/mci101.png', 6, '2025-10-10', 1),
('BUS102', 'Introduction to Business', 450.00, 'images/bus102.png', 6, '2025-10-10', 1),
('MKT201', 'Marketing Basics', 500.00, 'images/mkt201.png', 7,'2025-10-10', 1),
('ACC101', 'Fundamentals of Accounting', 480.00, 'images/acc101.png', 8, '2025-10-10',1),
('FIN202', 'Financial Management', 600.00, 'images/fin202.png', 9, '2025-10-10', 1),
('STR301', 'Strategic Management', 700.00, 'images/str301.png', 10, '2025-10-10', 1),
('ANG101', 'Basic English', 300.00, 'images/ang101.png', 11, '2025-10-10', 1),
('ENG201', 'Intermediate English', 350.00, 'images/eng201.png', 12, '2025-10-10', 1),
('ENG301', 'Advanced English', 400.00, 'images/eng301.png', 13, '2025-10-10', 1),
('ENG401', 'Business English', 500.00, 'images/ang401.png', 14, '2025-10-10', 1),

('IOT102', 'Internet of Things', 600.00, 'images/iot102.png', 4, '2025-10-10', 1),
('ITE302C', 'Ethics in IT', 600.00, 'images/ite302c.png', 5, '2025-10-10', 1),
('JPD113', 'Elementary Japanese 1-A1.1', 500.00, 'images/jpd113.png', 3, '2025-10-10', 1),
('JPD123', 'Elementary Japanese 1-A1.2', 400.00, 'images/jpd123.png', 4, '2025-10-10', 1),
('LAB211', 'OOP with Java Lab', 700.00, 'images/lab211.png', 3,'2025-10-10', 1),
('MAD101', 'Discrete Mathematics', 400.00, 'images/mad101.png', 2, '2025-10-10', 1),
('MAE101', 'Mathematics for Engineering.', 400.00, 'images/mae101.png', 1, '2025-10-10', 1),
('MAS291', 'Statistics and Probability', 500.00, 'images/mas291.png', 4,'2025-10-10', 1),
('NWC204', 'Computer Networking', 300.00, 'images/nwc204.png', 2, '2025-10-10', 1),
('OSG202', 'Operating Systems', 600.00, 'images/osg202.png', 2, '2025-10-10', 1),
('PRF192', 'Programming Fundamentals.', 500.00, 'images/prf192.png', 1, '2025-10-10', 1),
('PRJ301', 'Java Web Application Development', 700.00, 'images/prj301.png', 4, '2025-10-10', 1),
('PRO192', 'Object-Oriented Programming', 500.00, 'images/pro192.png', 2, '2025-10-10', 1),
('SE-0001', 'Elective 1', 400.00, 'images/se-0001.png', 5,'2025-10-10', 1),
('SSG104', 'Communication and In-Group Working Skills', 700.00, 'images/ssg104.png', 2, '2025-10-10', 1),
('SSL101C', 'Academic Skills for University Success.', 300.00, 'images/ssl101c.png', 1, '2025-10-10', 1),
('SWE201C', 'Introduction to Software Engineering', 300.00, 'images/swe201c.png', 4, '2025-10-10', 1),
('SWP391', 'Application Development Project', 500.00, 'images/swp391.png', 5, '2025-10-10', 1),
('SWR302', 'Software Requirement', 700.00, 'images/swr302.png', 5, '2025-10-10', 1),
('SWT301', 'Software Testing', 300.00, 'images/swt301.png', 5,'2025-10-10', 1),
('WED201C', 'Web Design', 300.00, 'images/wed201c.png', 3, '2025-10-10', 1);


INSERT INTO Lessons (CourseID, Title, VideoURL)
VALUES
(1, 'Introduction to Algorithm Analysis', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(2, 'Introduction to Linked Lists', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(21, 'Introduction to Graph Algorithms', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(2, 'Introduction to Sorting Techniques', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(26, 'Introduction to Variables and Data Types', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(3, 'Software vs Hardware Overview', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(3, 'Introduction to Computational Thinking', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(4, 'Introduction to Relational Databases', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(4, 'Introduction to SQL Queries', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(4, 'Database Normalization Principles', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(4, 'Introduction to Database Transactions', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(5, 'Introduction to Microeconomics', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(6, 'Introduction to Business Concepts', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(7, 'Introduction to Marketing Strategies', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(9, 'Introduction to Financial Management', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(8, 'Basic Accounting Principles', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(10, 'Introduction to Strategic Planning', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(13, 'Critical Reading and Analysis', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(14, 'Effective Email Communication', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(15, 'Common Japanese Greetings', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(18, 'Nouns and Adjectives', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(19, 'Complex Sentence Structures', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(21, 'Set Operations', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(22, 'Limits and Derivatives', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(23, 'Measures of Central Tendency', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(24, 'Cloud Networking Basics', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(25, 'Scheduling Algorithms', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(26, 'Control Flow and Loops', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(27, 'Spring Boot Introduction', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(28, 'Opp Introduction', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(32, 'SDLC Phases Overview', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(33, 'Project Planning Tools', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(34, 'Eliciting Requirements from Stakeholders', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(35, 'Software Testing Principles', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR'),
(36, 'Introduction to HTML and CSS', 'https://www.youtube.com/embed/0npAsij3pBQ?si=VoqMJdiIiLw92-QR');

select * from Reviews


INSERT INTO Reviews (CourseID, UserID, Rating, Comment, ReviewDate)
VALUES
(1, 2, 4, 'Excellent course on computer architecture!', '2025-10-20 09:00:00'),
(2, 2, 4, 'Good introduction to data structures.', '2025-10-20 09:00:00'),
(3, 2, 5, 'Great intro to computer science, very informative.', '2025-10-20 09:00:00'),
(4, 2, 3, 'Decent course on databases.', '2025-10-20 09:00:00'),
(5, 2, 4, 'Clear and concise microeconomics course.', '2025-10-20 09:00:00'),
(6, 2, 4, 'Good introduction to business concepts.', '2025-10-20 09:00:00'),
(7, 2, 3, 'Marketing basics, could be more in-depth.', '2025-10-20 09:00:00'),
(8, 2, 4, 'Solid foundation in accounting.', '2025-10-20 09:00:00'),
(9, 2, 4, 'Comprehensive financial management course.', '2025-10-20 09:00:00'),
(10, 2, 5, 'Strategic management - a must-take!', '2025-10-20 09:00:00'),
(11, 2, 3, 'Basic English, easy to follow.', '2025-10-20 09:00:00'),
(12, 2, 4, 'Good progress with intermediate English.', '2025-10-20 09:00:00'),
(13, 2, 4, 'Advanced English, very challenging.', '2025-10-20 09:00:00'),
(14, 2, 5, 'Business English, practical and useful.', '2025-10-20 09:00:00'),
(15, 2, 3, 'Introduction to Japanese, a bit fast.', '2025-10-20 09:00:00'),
(16, 2, 4, 'Insightful course on the Internet of Things.', '2025-10-20 09:00:00'),
(17, 2, 4, 'Important discussion on ethics in IT.', '2025-10-20 09:00:00'),
(18, 2, 5, 'Excellent for starting Japanese language.', '2025-10-20 09:00:00'),
(19, 2, 3, 'Building upon elementary Japanese, good base.', '2025-10-20 09:00:00'),
(20, 2, 4, 'Very good java lab sessions.', '2025-10-20 09:00:00'),
(21, 2, 4, 'Discrete math review helped.', '2025-10-20 09:00:00'),
(22, 2, 5, 'Easy to understand engineering mathmatics course.', '2025-10-20 09:00:00'),
(23, 2, 3, 'Hard to understand.', '2025-10-20 09:00:00'),
(24, 2, 4, 'Excellent network class.', '2025-10-20 09:00:00'),
(25, 2, 4, 'OS concepts were helpful.', '2025-10-20 09:00:00'),
(26, 2, 5, 'Best progamming fundemnetals class.', '2025-10-20 09:00:00'),
(27, 2, 3, 'Too long for a web apps course.', '2025-10-20 09:00:00'),
(28, 2, 4, 'Decent information.', '2025-10-20 09:00:00'),
(29, 2, 4, 'Good for an elective.', '2025-10-20 09:00:00'),
(30, 2, 5, 'Wonderful comm course!', '2025-10-20 09:00:00'),
(31, 2, 3, 'Academic skills were helpful.', '2025-10-20 09:00:00'),
(32, 2, 4, 'Good software intro.', '2025-10-20 09:00:00'),
(33, 2, 4, 'Amazing project!', '2025-10-20 09:00:00'),
(34, 2, 5, 'Requirement tools helped a lot.', '2025-10-20 09:00:00'),
(35, 2, 3, 'Testing tools helped.', '2025-10-20 09:00:00'),
(36, 2, 4, 'Good to see website design.', '2025-10-20 09:00:00');


--=================================================================
-- CHÈN DỮ LIỆU ENROLLMENTS (Dữ liệu mẫu)
-- Dựa trên các User đã viết Review
--=================================================================
INSERT INTO Enrollments (UserID, CourseID, Progress)
SELECT R.UserID, R.CourseID, 100.0 -- Giả sử ai review là đã học xong
FROM Reviews R
LEFT JOIN Enrollments E ON R.UserID = E.UserID AND R.CourseID = E.CourseID
WHERE E.EnrollmentID IS NULL; -- Chỉ chèn nếu chưa tồn tại
GO

--=================================================================
-- CHÈN DỮ LIỆU PAYMENTS (Dữ liệu mẫu)
-- Dựa trên các User đã đăng ký học (Enrollments)
--=================================================================
INSERT INTO Payments (UserID, CourseID, Amount, PaymentMethod)
SELECT 
    E.UserID, 
    E.CourseID, 
    C.Price, 
    CASE E.UserID % 4  -- Random phương thức thanh toán
        WHEN 0 THEN 'Momo'
        WHEN 1 THEN 'Credit Card'
        WHEN 2 THEN 'ZaloPay'
        ELSE 'Bank Transfer'
    END
FROM Enrollments E
JOIN Courses C ON E.CourseID = C.CourseID
LEFT JOIN Payments P ON E.UserID = P.UserID AND E.CourseID = P.CourseID
WHERE P.PaymentID IS NULL AND C.Price > 0; -- Chỉ chèn nếu chưa có thanh toán và khóa học có phí
GO



select * from Categories