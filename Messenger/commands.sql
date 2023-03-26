DELETE FROM GroupMessageRead;

DELETE FROM GroupMessage;

DELETE FROM GroupUser ;

DELETE FROM `Group`;

DELETE FROM P2P;

DELETE FROM `User`;


INSERT INTO `User`
(login, password, first_name, last_name, email)
VALUES('Jul', 'Jullet111', 'Julia', 'Lebedeva', 'myaddress@gmail.com');

INSERT INTO `User`
(login, password, first_name, last_name, email)
VALUES('vovan', 'pwd', 'Vladimir', 'Pupkin', 'doshik@gmail.com');

INSERT INTO `User`
(login, password, first_name, last_name, email)
VALUES('flower', 'floddd', 'Rose', 'Ivanova', 'flower@mail.ru');

INSERT INTO `User`
(login, password, first_name, last_name, email)
VALUES('yellowPen', 'error12', 'Andrei', 'Lagoda', 'arrryub@mail.ru');

INSERT INTO `User`
(login, password, first_name, last_name, email)
VALUES('killMe', 'dead', 'Alla', 'Reznik', 'meow@gmail.com');

INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES((select id from `User` where login = 'Jul'), 
	   (select id from `User` where login = 'vovan'), 'Hello! How are you?', NOW(), 0);
	  
INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES((select id from `User` where login = 'killMe'), 
	   (select id from `User` where login = 'flower'), 'I want to sleep...', NOW(), 0);
	  
INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES((select id from `User` where login = 'flower'), 
	   (select id from `User` where login = 'yellowPen'), 'I hate Linux', NOW(), 1);
	  
INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES((select id from `User` where login = 'yellowPen'), 
	   (select id from `User` where login = 'flower'), 'Why?', NOW(), 1);
	  
INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES((select id from `User` where login = 'flower'), 
	   (select id from `User` where login = 'yellowPen'), 
	    'Because Linux is not friendly to user', NOW(), 0);
	   

	   
INSERT INTO `Group`
(name, author_id, create_date, able_write)
VALUES('ChipsLovers', 
       (select id from `User` where login = 'Jul'), NOW(), TRUE);
      
INSERT INTO `Group`
(name, author_id, create_date, able_write)
VALUES('kengaROO', 
       (select id from `User` where login = 'killMe'), NOW(), TRUE);
  
      
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       (select id from `User` where login = 'vovan'), TRUE, 0);
      
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       (select id from `User` where login = 'flower'), 0, 0);
      
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       (select id from `User` where login = 'yellowPen'), 0, 0);
            
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'kengaROO'), 
       (select id from `User` where login = 'flower'), 0, 0);
      
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'kengaROO'), 
       (select id from `User` where login = 'yellowPen'), 0, 0); 
      

INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       (select id from `User` where login = 'Jul'), 
       'I LOVE chip and LOVE sleeping, but as you can see, I have already eaten chips...', NOW());
 
INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       (select id from `User` where login = 'vovan'), 
       'Then eat more chips', NOW()); 
      
INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       (select id from `User` where login = 'Jul'), 
       'I cannot or I became fat...', NOW()); 

INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       (select id from `User` where login = 'flower'), 
       'So sad', NOW()); 
      
INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'kengaROO'), 
       (select id from `User` where login = 'yellowPen'), 
       'Hi everyone! What is the name of this animal?', NOW()); 
      
INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'kengaROO'), 
       (select id from `User` where login = 'killMe'), 
       'kangaroo', NOW()); 

INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'kengaROO'), 
       (select id from `User` where login = 'yellowPen'), 
       'Really? Did you know that in the indian languagee kangaroo means...?', NOW()); 