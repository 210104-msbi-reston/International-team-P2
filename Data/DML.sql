ALTER TABLE State
ADD UNIQUE (StateCode)

ALTER TABLE City
ADD CONSTRAINT FK_State
FOREIGN KEY (StateCode) REFERENCES [State](StateCode);



SELECT statecode,len(StateCode)FROM [STATE]

select * from City


INSERT INTO City([Name],StateCode)  
VALUES 
('Vincent','AL'),
('Delta','AL'),
('Hydaburg','AK'),
('Nome','AK'),
('Ambler','AK'),
('Mayer','AZ'),
('El Mirage','AZ'),
('Kofa','AZ'),
('Carefree','AZ'),
('Pearce','AZ'),
('Goodwin','AR'),
('Arkinda','AR'),
('Little Flock','AR'),
('Elm Spring','AR'),
('Peel','AR'),
('Adelanto','CA'),
('Agoura Hills','CA'),
('Alameda','CA'),
('Albany','CA'),
('Alhambra','CA'),
('Rush','CO'),
('Gilcrest','CO'),
('Flen Haven','CO'),
('Mesita','CO'),
('Pitkin','CO'),
('Canton','CT'),
('Wallongford','CT'),
('Niantic','CT'),
('Stonington','CT'),
('Hatrtford','CT'),
('Bethal','DE'),
('Clayton','DE'),
('Slaughter Beach','DE'),
('Bowers','DE'),
('Georgetown','DE'),
('Apopka','FL'),
('Arcadia','FL'),
('Archer','FL'),
('Astatula','FL'),
('Atlantic Beach','FL'),
('Atlanta','GA'),
('Augusta','GA'),
('Columbus','GA'),
('Savannah','GA'),
('Athens','GA'),
('Wahiawa','HI'),
('Kekaha','HI'),
('Hilo','HI'),
('Burley','ID'),
('Lorenzo','ID'),
('Fairfield','ID'),
('Myrtle','ID'),
('Inkom','ID'),
('Bruneau','ID'),
('Dixie','ID'),
('Aurora','IL'),
('Rockford','IL'),
('Joliet','IL'),
('Naperville','IL'),
('Springfield','IL'),
('Anderson','IN'),
('Angola','IN'),
('Attica','IN'),
('Auburn','IN'),
('Aurora','IN'),
('Nemaha','IA'),
('Corwith','IA'),
('Rock Falls','IA'),
('Salix','IA'),
('AnkenyKirkman','IA'),
('Piedmoind','KS'),
('Franklin','KS'),
('chapman','KS'),
('Elmo','KS'),
('New Albany','KS'),
('Springlee','KY'),
('Nina','KY'),
('Wolf Creek','KY'),
('Ritchie','KY'),
('Cayce','KY'),
('Addis','LA'),
('Albany','LA'),
('Alexandria','LA'),
('Ama','LA'),
('Amelia','LA'),
('Corinna','ME'),
('Chesterville','ME'),
('Pittsfield','ME'),
('South Paris','ME'),
('Brunswick','MD'),
('Cambridge','MD'),
('College Park','MD'),
('Crisfield','MD'),
('Cumberland','MD'),
('Hampden','MA'),
('Fayville','MA'),
('Taunton','MA'),
('Rowe','MA'),
('Princeton','MA'),
('Lupton','MI'),
('Engadine','MI'),
('Gladstone','MI'),
('Pellston','MI'),
('Oden','MI'),
('Clearbrook','MN'),
('Elizabeth','MN'),
('Minnetona','MN'),
('Le Sueur','MN'),
('Medford','MN'),
('Blaine','MS'),
('Gatesville','MS'),
('Sunflower','MS'),
('Union','MS'),
('New Houlka','MS'),
('Cedar City','MO'),
('Lakeshire','MO'),
('Jane','MO'),
('Deerfield','MO'),
('Fagus','MO'),
('Muddy','MT'),
('Logan','MT'),
('Anceney','MT'),
('Rapelje','MT'),
('Harrison','MT'),
('Verdi','NE'),
('goodsprings','NE'),
('Austin','NE'),
('Carlin','NE'),
('Lane City','NE'),
('Harney','NV'),
('Silver Peak','NV'),
('Tippett','NV'),
('Yerington','NV'),
('Glenbrook','NV'),
('Claremont','NH'),
('Milford','NH'),
('Nottingham',' NH'),
('Malborough','NH'),
('Brookfield','NH'),
('Columbus','NJ'),
('Dayton','NJ'),
('Oakland','NJ'),
('Stockholm','NJ'),
('Ridgewood','NJ'),
('Upham','NM'),
('Dora','NM'),
('Duran','NM'),
('Chimayo','NM'),
('Artesia','NM'),
('Bethel','NY'),
('Dresden','NY'),
('Westerlo','NY'),
('Newfane','NY'),
('Clinton','NY'),
('Havelock','NC'),
('Ledger','NC'),
('Fallston','NC'),
('Franklinton','NC'),
('Bennett','NC'),
('Cashel','ND'),
('Center','ND'),
('Coulee','ND'),
('Bonetraill','ND'),
('Crystal','ND'),
('Mendon','OH'),
('Gilboa','OH'),
('Kings Mills','OH'),
('Lakeview','OH'),
('Tippecanoe','OH'),
('Mayfield','OK'),
('Burbank','OK'),
('Olustee','OK'),
('Etowah','OK'),
('Yewed','OK'),
('Silvies','OR'),
('Applegate','OR'),
('Hines','OR'),
('Grizzly','OR'),
('Summerville','OR'),
('Hershey','PA'),
('Courtney','PA'),
('Duncansville','PA'),
('Morris','PA'),
('Dry run','PA'),
('Melville','RI'),
('Warwick','RI'),
('Ashaway','RI'),
('Peace Dale','RI'),
('Providence','RI'),
('Verdery','SC'),
('New Zion','SC'),
('Effingham','SC'),
('Wagener','SC'),
('Cokesbury','SC'),
('Zell','SD'),
('Stickney','SD'),
('Warner','SD'),
('Vetal','SD'),
('Oglala','SD'),
('Dunlap','TN'),
('Shouns','TN'),
('Nunnelly','TN'),
('Boma','TN'),
('Clifton','TN'),
('Houston','TX'),
('Dallas','TX'),
('Austin','TX'),
('Huntsville','TX'),
('Denton','TX'),
('Stockton','UT'),
('Castle Dale','UT'),
('Logan','UT'),
('Fillmore','UT'),
('Enoch','UT'),
('Ripton','VT'),
('Jamaica','VT'),
('Duffield','VA'),
('Volens','VA'),
('Chatmoss','VA'),
('Deerfield','VA'),
('Lakeside','VA'),
('Mohler','WA'),
('Freeland','WA'),
('Scandia','WA'),
('Lacey','WA'),
('Alger','WA'),
('Nitro','WV'),
('Slanesville','WV'),
('Glen Ferris','WV'),
('Ellamore','WV'),
('Abbott','WV'),
('Loyal','WI'),
('Delafield','WI'),
('Waukesha','WI'),
('Deerdield','WI'),
('Glendale','WI'),
('Orin','WY'),
('Meriden','WY'),
('Encampment','WY'),
('Baggs','WY'),
('Calpet','WY')