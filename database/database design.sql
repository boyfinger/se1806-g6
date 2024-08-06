-- Create the database
CREATE DATABASE `KMS-G6-SE1808`;
USE `KMS-G6-SE1808`;

create table `role`
(
    id   int(1) primary key,
    name varchar(7)
);
-- Create the 'user' table
CREATE TABLE user
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(50),
    email        VARCHAR(35) UNIQUE,
    avt          VARCHAR(100) default 'assets/img/default_avt.jpg',
    password     VARCHAR(60),
    role         INT(1),
    status       int(1),
    date_created date         default (curdate()),

    foreign key (role) references `role` (id)
);

CREATE TABLE contact
(
    email   VARCHAR(35),
    name    VARCHAR(255),
    subject VARCHAR(255),
    message TEXT
);

-- Create the 'subject' table
CREATE TABLE subject
(
    id                   INT AUTO_INCREMENT PRIMARY KEY,
    code                 VARCHAR(7) UNIQUE,
    name                 VARCHAR(255),
    status               BIT DEFAULT 0,
    exam_no_of_questions tinyint
);

-- Create the 'subject_in_charged' table
CREATE TABLE subject_in_charged
(
    user_id    INT,
    subject_id INT,
    PRIMARY KEY (user_id, subject_id),
    FOREIGN KEY (user_id) REFERENCES user (id),
    FOREIGN KEY (subject_id) REFERENCES subject (id)
);

-- Create the 'class' table
CREATE TABLE class
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(40) UNIQUE
);

-- Create the 'group' table
CREATE TABLE `group`
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    class_id      INT,
    subject_id    INT,
    instructor_id INT,
    FOREIGN KEY (class_id) REFERENCES class (id),
    FOREIGN KEY (subject_id) REFERENCES subject (id),
    FOREIGN KEY (instructor_id) REFERENCES user (id)
);

-- Create the 'student_group' table
CREATE TABLE student_group
(
    student_id INT,
    group_id   INT,
    PRIMARY KEY (student_id, group_id),
    FOREIGN KEY (student_id) REFERENCES user (id),
    FOREIGN KEY (group_id) REFERENCES `group` (id)
);

-- Create the 'group_announcement' table
CREATE TABLE group_announcement
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    group_id     INT,
    announcement TEXT,
    FOREIGN KEY (group_id) REFERENCES `group` (id)
);

-- Create the 'flashcard_set' table
CREATE TABLE flashcard_set
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(255),
    subject_id INT,
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES user (id),
    FOREIGN KEY (subject_id) REFERENCES subject (id)
);

-- Create the 'flashcard_question' table
CREATE TABLE flashcard_question
(
    id               INT AUTO_INCREMENT PRIMARY KEY,
    term             text,
    definition       text,
    flashcard_set_id INT,
    FOREIGN KEY (flashcard_set_id) REFERENCES flashcard_set (id)
);

-- Create the 'lesson' table
create table lesson
(
    id         int auto_increment primary key,
    name       varchar(100),
    `order`    int,
    subject_id int,
    status		bit default 1,

    foreign key (subject_id) references subject (id)
);

create table material
(
    id  int auto_increment primary key,
    uri varchar(100)
);

create table material_lesson
(
    material_id int,
    lesson_id   int,

    primary key (material_id, lesson_id),
    foreign key (material_id) references material (id),
    foreign key (lesson_id) references lesson (id)
);

create table question
(
    id        int auto_increment primary key,
    content   varchar(255),
    lesson_id int,
    status    bit,
    
    foreign key (lesson_id) references lesson(id)
);

create table answer
(
    id          int auto_increment primary key,
    content     varchar(255),
    is_correct  bit,
    question_id int,

    foreign key (question_id) references question (id)
);

create table test(
	id				int primary key,
    name			varchar(255),
	no_of_question 	smallint
);

create table test_group(
	test_id		int,
    group_id 	int,
    
    foreign key (test_id) references test(id),
    foreign key (group_id) references `group`(id)
);

create table test_lesson(
	test_id		int,
    lesson_id 	int,
    
    foreign key (test_id) references test(id),
    foreign key (lesson_id) references `lesson`(id)
);

create table result
(
    id              int auto_increment primary key,
    correct_answers int,
    score           tinyint,
    date_taken      date,
    attempt         int,
    user_id         int,
    exam_subject_id int,
    test_id 		int,

    foreign key (user_id) references user (id),
    foreign key (exam_subject_id) references subject (id),
    foreign key (test_id) references test(id)
);

create table result_details
(
    id          int primary key auto_increment,
    result_id   int,
    question_id int,
    is_scored	bit,
    content		varchar(255),

    foreign key (result_id) references result(id)
);

create table result_answer_selected
(
    id                	int auto_increment primary key,
    result_details_id 	int,
    answer_id         	int,
    content				varchar(100),
    is_correct			bit,
    is_selected       	bit,

    foreign key (result_details_id) references result_details(id)
);

insert into role(id, name)
values (0, 'Admin'),
       (1, 'Manager'),
       (2, 'Teacher'),
       (3, 'Student');

-- Insert users
INSERT INTO user (name, email, password, role, status)
VALUES ('ThuyBT02', 'thuybt02@fpt.edu.vn', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 2, 1),
       ('KienNT', 'kiennt@fpt.edu.vn', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 2, 1),
       ('HungNM142', 'hungnm142@fpt.edu.vn', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 2, 1),
       ('LinhDTT43', 'linhdtt43@fpt.edu.vn', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 2, 1),
       ('Hoannn6', 'hoannn6@fpt.edu.vn', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 2, 1),
       ('Doan Binh An', 'ExampleEmail@fpt.edu.vn', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 3, 1),
       ('admin', 'admin1@email.com', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 0, 1),
       ('manager', 'manager1@email.com', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 1, 1),
       ('teacher', 'teacher1@email.com', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 2, 1),
       ('student', 'student1@email.com', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6', 3, 1),
       ('Duong Quan Hao', 'ngunguoi123ys@gmail.com', '$2a$12$lL4NJHo5/Ng0cUmAj3Iig.lOqejnHA4uVnU9A82rDIVq9Lbqxj9m6',
			0, 1);
	
update user set avt = 'assets/img/annandmaryann.png' where email = 'ngunguoi123ys@gmail.com';
update user set avt = 'assets/img/admin1.png' where email = 'admin1@email.com';

-- Insert subjects
INSERT INTO subject (code, name, status, exam_no_of_questions)
VALUES ('PRN212', 'Basis Cross-Platform Application Programming With .NET', 1, 50),
       ('SWP391', 'Application development project', 1, 50),
       ('SWR302', 'Software Requirement', 1, 50),
       ('SWT301', 'Software Testing', 1, 50),
       ('FER202', 'Front-End web development with React', 1, 50);

-- Insert classes
INSERT INTO class (code)
VALUES ('SE1808-NET'),
       ('SE1840-KS'),
       ('SE1827-NJ');

-- Insert groups
INSERT INTO `group` (class_id, subject_id, instructor_id)
VALUES ((SELECT id FROM class WHERE code = 'SE1808-NET'), (SELECT id FROM subject WHERE code = 'PRN212'),
        (SELECT id FROM user WHERE email = 'thuybt02@fpt.edu.vn')),
       ((SELECT id FROM class WHERE code = 'SE1808-NET'), (SELECT id FROM subject WHERE code = 'SWP391'),
        (SELECT id FROM user WHERE email = 'kiennt@fpt.edu.vn')),
       ((SELECT id FROM class WHERE code = 'SE1840-KS'), (SELECT id FROM subject WHERE code = 'SWR302'),
        (SELECT id FROM user WHERE email = 'hungnm142@fpt.edu.vn')),
       ((SELECT id FROM class WHERE code = 'SE1840-KS'), (SELECT id FROM subject WHERE code = 'SWT301'),
        (SELECT id FROM user WHERE email = 'linhdtt43@fpt.edu.vn')),
       ((SELECT id FROM class WHERE code = 'SE1827-NJ'), (SELECT id FROM subject WHERE code = 'FER202'),
        (SELECT id FROM user WHERE email = 'hoannn6@fpt.edu.vn'));

-- Insert student groups without duplicates
INSERT INTO student_group (student_id, group_id)
VALUES ((SELECT id FROM user WHERE email = 'ExampleEmail@fpt.edu.vn'), (SELECT id
                                                                        FROM `group`
                                                                        WHERE class_id = (SELECT id FROM class WHERE code = 'SE1827-NJ')
                                                                          AND subject_id = (SELECT id FROM subject WHERE code = 'FER202'))),
       ((SELECT id FROM user WHERE email = 'ExampleEmail@fpt.edu.vn'), (SELECT id
                                                                        FROM `group`
                                                                        WHERE class_id = (SELECT id FROM class WHERE code = 'SE1808-NET')
                                                                          AND subject_id = (SELECT id FROM subject WHERE code = 'PRN212'))),
       ((SELECT id FROM user WHERE email = 'ExampleEmail@fpt.edu.vn'), (SELECT id
                                                                        FROM `group`
                                                                        WHERE class_id = (SELECT id FROM class WHERE code = 'SE1808-NET')
                                                                          AND subject_id = (SELECT id FROM subject WHERE code = 'SWP391'))),
       ((SELECT id FROM user WHERE email = 'ExampleEmail@fpt.edu.vn'), (SELECT id
                                                                        FROM `group`
                                                                        WHERE class_id = (SELECT id FROM class WHERE code = 'SE1840-KS')
                                                                          AND subject_id = (SELECT id FROM subject WHERE code = 'SWR302'))),
       ((SELECT id FROM user WHERE email = 'ExampleEmail@fpt.edu.vn'), (SELECT id
                                                                        FROM `group`
                                                                        WHERE class_id = (SELECT id FROM class WHERE code = 'SE1840-KS')
                                                                          AND subject_id = (SELECT id FROM subject WHERE code = 'SWT301')));

-- Insert subject in charged
INSERT INTO subject_in_charged (user_id, subject_id)
VALUES ((SELECT id FROM user WHERE email = 'thuybt02@fpt.edu.vn'), (SELECT id FROM subject WHERE code = 'PRN212')),
       ((SELECT id FROM user WHERE email = 'kiennt@fpt.edu.vn'), (SELECT id FROM subject WHERE code = 'SWP391')),
       ((SELECT id FROM user WHERE email = 'hungnm142@fpt.edu.vn'), (SELECT id FROM subject WHERE code = 'SWR302')),
       ((SELECT id FROM user WHERE email = 'linhdtt43@fpt.edu.vn'), (SELECT id FROM subject WHERE code = 'SWT301')),
       ((SELECT id FROM user WHERE email = 'hoannn6@fpt.edu.vn'), (SELECT id FROM subject WHERE code = 'FER202'));

insert into lesson(name, `order`, subject_id)
values ('Introduction to .NET Platform - Visual Studio.NET', 1, (select id from subject where code = 'PRN212')),
       ('C# Programming', 2, (select id from subject where code = 'PRN212')),
       ('Object-Oriented Programming', 3, (select id from subject where code = 'PRN212')),
       ('Collections and Generics', 4, (select id from subject where code = 'PRN212')),
       ('Design Pattern in .NET', 5, (select id from subject where code = 'PRN212')),
       ('Delegate ,Event_LINQ', 6, (select id from subject where code = 'PRN212')),
       ('Building Windows Presentation Foundation (WPF) Application', 7, (select id from subject where code = 'PRN212')),
       ('Working with Databases Using Entity Framework Core', 8, (select id from subject where code = 'PRN212')),
       ('Working with Files and System.IO', 9, (select id from subject where code = 'PRN212')),
       ('Working with XML and JSON Serializing', 10, (select id from subject where code = 'PRN212')),
       ('Concurrency Programming', 11, (select id from subject where code = 'PRN212')),
       ('Introduction to the course', 1, (select id from subject where code = 'SWT301')),
       ('Fundamentals of testing', 2, (select id from subject where code = 'SWT301')),
       ('Testing throughout the software life cycle', 3, (select id from subject where code = 'SWT301')),
       ('Static techniques', 4, (select id from subject where code = 'SWT301')),
       ('Test techniques', 5, (select id from subject where code = 'SWT301')),
       ('Test management', 6, (select id from subject where code = 'SWT301')),
       ('Test management tools', 7,(select id from subject where code = 'SWT301'));

set @lesson_id = (select id from lesson where name = 'Introduction to .NET Platform - Visual Studio.NET'
        and subject_id = (select id from subject where code = 'PRN212'));
INSERT INTO question(content, status, lesson_id)
VALUES ('What is the difference between `String` and `string` in C#?', 1, @lesson_id),
       ('Can ASP.NET Core work with the .NET Framework?', 1, @lesson_id),
       ('What are the components of MVC (Model-View-Controller)?', 1, @lesson_id),
       ('What is inheritance in .NET?', 1, @lesson_id),
       ('What’s the difference between a class and an object?', 1, @lesson_id),
       ('What is managed code in .NET?', 1, @lesson_id);

set @question_id = (select id from question where content = 'What is the difference between `String` and `string` in C#?'
					and lesson_id = @lesson_id);
INSERT INTO answer(content, is_correct, question_id)
VALUES ('`String` is an alias for `System.String`.', 1, @question_id),
       ('`string` is an alias for `System.String`.', 0, @question_id),
       ('There is no difference; they are interchangeable.', 0, @question_id),
       ('`String` is a value type, and `string` is a reference type.', 0, @question_id);

set @question_id = (select id from question where content = 'Can ASP.NET Core work with the .NET Framework?'
					and lesson_id = @lesson_id);
INSERT INTO answer(content, is_correct, question_id)
VALUES ('No, ASP.NET Core only works with .NET Core.', 0, @question_id),
       ('Yes, ASP.NET Core can work with both .NET Core and .NET Framework.', 1, @question_id),
       ('ASP.NET Core is independent of any framework.', 0, @question_id),
       ('ASP.NET Core is deprecated.', 0, @question_id);
       
set @question_id = (select id from question where content = 'What are the components of MVC (Model-View-Controller)?'
					and lesson_id = @lesson_id);       
INSERT INTO answer(content, is_correct, question_id)
VALUES ('Model, View, and Controller', 1, @question_id),
       ('Model, ViewModel, and Controller', 0, @question_id),
       ('Model, View, and Service', 0, @question_id),
       ('Model, View, and Middleware', 0, @question_id);
       
set @question_id = (select id from question where content = 'What is inheritance in .NET?'
					and lesson_id = @lesson_id);           
INSERT INTO answer(content, is_correct, question_id)
VALUES ('It allows a class to inherit properties from an interface.', 0, @question_id),
       ('It promotes code reusability by allowing a class to inherit properties and behaviors from another class.', 1, @question_id),
       ('It is a way to create new classes from existing classes.', 0, @question_id),
       ('It is used to implement multiple inheritance.', 0, @question_id);
       
set @question_id = (select id from question where content = 'What’s the difference between a class and an object?'
					and lesson_id = @lesson_id);      
INSERT INTO answer(content, is_correct, question_id)
VALUES ('A class is an instance of an object.', 0, @question_id),
       ('A class is a blueprint for creating objects.', 1, @question_id),
       ('An object is a blueprint for creating classes.', 0, @question_id),
       ('There is no difference; they are synonyms.', 0, @question_id);
       
set @question_id = (select id from question where content = 'What is managed code in .NET?'
					and lesson_id = @lesson_id);  
INSERT INTO answer(content, is_correct, question_id)
VALUES ('Code that runs outside the .NET runtime environment.', 0, @question_id),
       ('Code that directly interacts with the operating system.', 0, @question_id),
       ('Code that runs within the .NET runtime environment.', 1, @question_id),
       ('Code that is written in unmanaged languages.', 0, @question_id);
       
set @lesson_id = (select id from lesson where name = 'Object-Oriented Programming'
        and subject_id = (select id from subject where code = 'PRN212'));
INSERT INTO question (content, status, lesson_id) VALUES
('What is Object-Oriented Programming (OOP)?', 1, @lesson_id),
('What are the four fundamental principles of OOP?', 1, @lesson_id),
('Explain the concept of a class and an object in C#.', 1, @lesson_id),
('What is encapsulation and how is it implemented in C#?', 1, @lesson_id),
('Describe inheritance and provide an example in C#.', 1, @lesson_id),
('What is polymorphism and how is it achieved in C#?', 1, @lesson_id),
('Explain abstraction with an example in C#.', 1, @lesson_id),
('What are access modifiers in C# and what are their types?', 1, @lesson_id),
('How do you create a constructor in C# and what is its purpose?', 1, @lesson_id),
('What is the difference between a class and an interface in C#?', 1, @lesson_id),
('How can you implement multiple inheritance in C#?', 1, @lesson_id),
('What is method overloading and method overriding in C#?', 1, @lesson_id),
('Explain the concept of properties in C#.', 1, @lesson_id),
('What is the difference between a field and a property in C#?', 1, @lesson_id),
('How do you implement an abstract class in C#?', 1, @lesson_id),
('What is the purpose of the `virtual` keyword in C#?', 1, @lesson_id),
('Explain the use of the `sealed` keyword in C#.', 1, @lesson_id),
('What is the difference between `public`, `private`, `protected`, and `internal` access modifiers?', 1, @lesson_id);

set @question_id = (select id from question where content = 'What is Object-Oriented Programming (OOP)?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A programming paradigm based on functions', 0),
(@question_id, 'A programming paradigm based on objects and classes', 1),
(@question_id, 'A programming paradigm based on data structures', 0),
(@question_id, 'A programming paradigm based on algorithms', 0);

set @question_id = (select id from question where content = 'What are the four fundamental principles of OOP?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) Encapsulation, Inheritance, Polymorphism, Abstraction', 1),
(@question_id, 'B) Encapsulation, Inheritance, Polymorphism, Aggregation', 0),
(@question_id, 'C) Encapsulation, Inheritance, Polymorphism, Composition', 0),
(@question_id, 'D) Encapsulation, Inheritance, Polymorphism, Association', 0);

set @question_id = (select id from question where content = 'Explain the concept of a class and an object in C#.'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) A class is an instance of an object', 0),
(@question_id, 'B) An object is a blueprint of a class', 0),
(@question_id, 'C) A class is a blueprint for creating objects', 1),
(@question_id, 'D) An object is a method in a class', 0);

set @question_id = (select id from question where content = 'What is encapsulation and how is it implemented in C#?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) Encapsulation is the process of inheriting properties', 0),
(@question_id, 'B) Encapsulation is the process of hiding implementation details', 1),
(@question_id, 'C) Encapsulation is the process of overloading methods', 0),
(@question_id, 'D) Encapsulation is the process of overriding methods', 0);

set @question_id = (select id from question where content = 'Describe inheritance and provide an example in C#.'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) Inheritance is when a class contains another class', 0),
(@question_id, 'B) Inheritance is when a class is derived from another class', 1),
(@question_id, 'C) Inheritance is when a class implements an interface', 0),
(@question_id, 'D) Inheritance is when a class has multiple constructors', 0);

set @question_id = (select id from question where content = 'What is polymorphism and how is it achieved in C#?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) Polymorphism is the ability to take multiple forms', 1),
(@question_id, 'B) Polymorphism is the ability to inherit multiple classes', 0),
(@question_id, 'C) Polymorphism is the ability to override methods', 0),
(@question_id, 'D) Polymorphism is the ability to overload methods', 0);

set @question_id = (select id from question where content = 'Explain abstraction with an example in C#.'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) Abstraction is the process of hiding implementation details', 1),
(@question_id, 'B) Abstraction is the process of inheriting properties', 0),
(@question_id, 'C) Abstraction is the process of overloading methods', 0),
(@question_id, 'D) Abstraction is the process of overriding methods', 0);

set @question_id = (select id from question where content = 'What are access modifiers in C# and what are their types?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) Public, Private, Protected, Internal', 1),
(@question_id, 'B) Public, Private, Protected, External', 0),
(@question_id, 'C) Public, Private, Protected, Static', 0),
(@question_id, 'D) Public, Private, Protected, Final', 0);

set @question_id = (select id from question where content = 'How do you create a constructor in C# and what is its purpose?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) A constructor is created using the `new` keyword and initializes objects', 0),
(@question_id, 'B) A constructor is created using the `class` keyword and initializes objects', 0),
(@question_id, 'C) A constructor is created using the `void` keyword and initializes objects', 0),
(@question_id, 'D) A constructor is created using the class name and initializes objects', 1);

set @question_id = (select id from question where content = 'What is the difference between a class and an interface in C#?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) A class can inherit multiple interfaces, but an interface cannot inherit classes', 0),
(@question_id, 'B) A class can have implementations, but an interface cannot', 0),
(@question_id, 'C) A class can be instantiated, but an interface cannot', 0),
(@question_id, 'D) All of the above', 1);

set @question_id = (select id from question where content = 'How can you implement multiple inheritance in C#?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) By using multiple classes', 0),
(@question_id, 'B) By using multiple interfaces', 1),
(@question_id, 'C) By using a single class and multiple interfaces', 0),
(@question_id, 'D) By using multiple classes and interfaces', 0);

set @question_id = (select id from question where content = 'What is method overloading and method overriding in C#?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) Overloading is defining multiple methods with the same name but different parameters; Overriding is redefining a base class method in a derived class', 1),
(@question_id, 'B) Overloading is redefining a base class method in a derived class; Overriding is defining multiple methods with the same name but different parameters', 0),
(@question_id, 'C) Overloading is defining multiple methods with the same name and parameters; Overriding is redefining a base class method in a derived class', 0),
(@question_id, 'D) Overloading is redefining a base class method in a derived class; Overriding is defining multiple methods with the same name and parameters', 0);

set @question_id = (select id from question where content = 'Explain the concept of properties in C#.'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) Properties are methods that provide access to class fields', 0),
(@question_id, 'B) Properties are variables that store data', 0),
(@question_id, 'C) Properties are special methods that provide a flexible mechanism to read, write, or compute the value of a private field', 1),
(@question_id, 'D) Properties are classes that contain methods', 0);

set @question_id = (select id from question where content = 'What is the difference between a field and a property in C#?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) A field is a variable of any type that is declared directly in a class; A property is a member that provides a flexible mechanism to read, write, or compute the value of a private field', 1),
(@question_id, 'B) A field is a method that provides access to class data; A property is a variable that stores data', 0),
(@question_id, 'C) A field is a class that contains methods; A property is a method that provides access to class data', 0),
(@question_id, 'D) A field is a variable that stores data; A property is a method that provides access to class data', 0);

set @question_id = (select id from question where content = 'How do you implement an abstract class in C#?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) By using the `abstract` keyword and providing implementations for all methods', 0),
(@question_id, 'B) By using the `abstract` keyword and providing implementations for some methods', 1),
(@question_id, 'C) By using the `abstract` keyword and not providing implementations for any methods', 0),
(@question_id, 'D) By using the `abstract` keyword and providing implementations for at least one method', 0);

set @question_id = (select id from question where content = 'What is the purpose of the `virtual` keyword in C#?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) To define a method that can be overridden in a derived class', 1),
(@question_id, 'B) To define a method that cannot be overridden in a derived class', 0),
(@question_id, 'C) To define a method that must be overridden in a derived class', 0),
(@question_id, 'D) To define a method that is static', 0);

set @question_id = (select id from question where content = 'Explain the use of the `sealed` keyword in C#.'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) To prevent a class from being inherited', 0),
(@question_id, 'B) To prevent a method from being overridden', 0),
(@question_id, 'C) To prevent a class from being instantiated', 0),
(@question_id, 'D) Both A and B', 1);

set @question_id = (select id from question where content = 'What is the difference between `public`, `private`, `protected`, and `internal` access modifiers?'
					and lesson_id = @lesson_id);
INSERT INTO answer (question_id, content, is_correct) VALUES
(@question_id, 'A) `public` allows access from anywhere; `private` restricts access to the containing class; `protected` allows access within the containing class and derived classes; `internal` allows access within the same assembly', 1),
(@question_id, 'B) `public` allows access from anywhere; `private` restricts access to the containing class; `protected` allows access within the containing class and derived classes; `internal` allows access within the same namespace', 0),
(@question_id, 'C) `public` allows access from anywhere; `private` restricts access to the containing class; `protected` allows access within the containing class and derived classes; `internal` allows access within the same project', 0),
(@question_id, 'D) `public` allows access from anywhere; `private` restricts access to the containing class; `protected` allows access within the containing class and derived classes; `internal` allows access within the same solution', 0);

insert into material(uri)
values ('assets/material/Chapter 01 - Introduction to .NET Platform - Visual Studio.NET.pptx'),
       ('assets/material/Chapter 02 - C# Programming.pptx');

insert into material_lesson (material_id, lesson_id)
values ((select id
         from material
         where uri = 'assets/material/Chapter 01 - Introduction to .NET Platform - Visual Studio.NET.pptx'),
        (SELECT id FROM lesson WHERE name = 'Introduction to .NET Platform - Visual Studio.NET')),

       ((select id from material where uri = 'assets/material/Chapter 02 - C# Programming.pptx'),
        (SELECT id FROM lesson WHERE name = 'C# Programming'));

-- Insert sample flashcard sets with created_by column
INSERT INTO flashcard_set (name, subject_id, created_by)
VALUES ('PRN: OOP Basics', (SELECT id FROM subject WHERE code = 'PRN212'),
        (SELECT id FROM user WHERE email = 'admin1@email.com')),
       ('SWR: Agile Principles', (SELECT id FROM subject WHERE code = 'SWR302'),
        (SELECT id FROM user WHERE email = 'admin1@email.com'));

-- Insert sample flashcard questions
INSERT INTO flashcard_question (term, definition, flashcard_set_id)
VALUES ('Inheritance', 'A mechanism where a new class can inherit properties and methods of an existing class.',
        (SELECT id FROM flashcard_set WHERE name = 'PRN: OOP Basics')),
       ('Encapsulation', 'A principle of wrapping data and code as a single unit.',
        (SELECT id FROM flashcard_set WHERE name = 'PRN: OOP Basics')),
       ('Scrum', 'An agile process framework for managing complex knowledge work.',
        (SELECT id FROM flashcard_set WHERE name = 'SWR: Agile Principles')),
       ('Kanban',
        'A method for managing the creation of products with an emphasis on continual delivery while not overburdening the development team.',
        (SELECT id FROM flashcard_set WHERE name = 'SWR: Agile Principles'));

select *
from flashcard_set;
select *
from subject;