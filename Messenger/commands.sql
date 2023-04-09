DELETE FROM GroupMessageRead;

DELETE FROM GroupMessage;

DELETE FROM GroupUser ;

DELETE FROM `Group`;

DELETE FROM P2P;

DELETE FROM `User` -- sharding:0
;

DELETE FROM `User` -- sharding:1
;

INSERT INTO `User`
(id, login, password, first_name, last_name, email)
VALUES(1, 'Jul', 'Jullet111', 'Julia', 'Lebedeva', 'myaddress@gmail.com') -- sharding:0
;

INSERT INTO `User`
(id, login, password, first_name, last_name, email)
VALUES(2, 'vovan', 'pwd', 'Vladimir', 'Pupkin', 'doshik@gmail.com') -- sharding:1
;

INSERT INTO `User`
(id, login, password, first_name, last_name, email)
VALUES(3, 'flower', 'floddd', 'Rose', 'Ivanova', 'flower@mail.ru') -- sharding:0
;

INSERT INTO `User`
(id, login, password, first_name, last_name, email)
VALUES(4, 'yellowPen', 'error12', 'Andrei', 'Lagoda', 'arrryub@mail.ru') -- sharding:1
;

INSERT INTO `User`
(id, login, password, first_name, last_name, email)
VALUES(5, 'killMe', 'dead', 'Alla', 'Reznik', 'meow@gmail.com') -- sharding:1
;

INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES(1, 2, 'Hello! How are you?', NOW(), 0);
	  
INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES(5, 3, 'I want to sleep...', NOW(), 0);
	  
INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES(3, 4, 'I hate Linux', NOW(), 1);
	  
INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES(4, 3, 'Why?', NOW(), 1);
	  
INSERT INTO P2P
(sender_id, receiver_id, `text`, create_date, is_read)
VALUES(3, 4, 'Because Linux is not friendly to user', NOW(), 0);
	   

	   
INSERT INTO `Group`
(name, author_id, create_date, able_write)
VALUES('ChipsLovers', 1, NOW(), TRUE);
      
INSERT INTO `Group`
(name, author_id, create_date, able_write)
VALUES('kengaROO', 5, NOW(), TRUE);
  
      
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       2, TRUE, 0);
      
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       3, 0, 0);
      
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       4, 0, 0);
            
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'kengaROO'), 
       3, 0, 0);
      
INSERT INTO GroupUser
(group_id, user_id, is_moder, is_admin)
VALUES((select id from `Group` where name = 'kengaROO'), 
       4, 0, 0); 
      

INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       1, 'I LOVE chip and LOVE sleeping, but as you can see, I have already eaten chips...', NOW());
 
INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       2, 'Then eat more chips', NOW()); 
      
INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       (select id from `User` where login = 'Jul'), 
       'I cannot or I became fat...', NOW()); 

INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'ChipsLovers'), 
       3, 'So sad', NOW()); 
      
INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'kengaROO'), 
       4, 'Hi everyone! What is the name of this animal?', NOW()); 
      
INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'kengaROO'), 
       5, 'kangaroo', NOW()); 

INSERT INTO GroupMessage
(group_id, sender_id, `text`, create_date)
VALUES((select id from `Group` where name = 'kengaROO'), 
       4, 'Really? Did you know that in the indian languagee kangaroo means...?', NOW()); 