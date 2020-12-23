1.Obtain the average price of each piece (show only the piece code and the average price).
  SELECT Piece, AVG(Price)
    FROM Provides
  GROUP BY Piece;
  
2.Obtain the names of all providers who supply piece 1.

 /* Without subquery */
 SELECT Providers.Name
   FROM Providers INNER JOIN Provides
          ON Providers.Code = Provides.Provider
             AND Provides.Piece = 1;
/* With subquery */
 SELECT Name
   FROM Providers
  WHERE Code IN
   (SELECT Provider FROM Provides WHERE Piece = 1);
   
3.Select the name of pieces provided by provider with code "HAL".

Click to see solution
 /* Without subquery */
 SELECT Pieces.Name
   FROM Pieces INNER JOIN Provides
   ON Pieces.Code = Provides.Piece
     AND Provides.Provider = 'HAL';


 /* With IN subquery */
 SELECT Name
   FROM Pieces
   WHERE Code IN
     (SELECT Piece FROM Provides WHERE Provider = 'HAL');


 /* With EXISTS subquery */
 SELECT Name
   FROM Pieces
   WHERE EXISTS
   (
     SELECT * FROM Provides
       WHERE Provider = 'HAL'
         AND Piece = Pieces.Code
   );
   
4.For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price (note that there could be two providers who supply the same piece at the most expensive price).

 SELECT Pieces.Name, Providers.Name, Price
   FROM Pieces INNER JOIN Provides ON Pieces.Code = Piece
               INNER JOIN Providers ON Providers.Code = Provider
   WHERE Price =
   (
     SELECT MAX(Price) FROM Provides
     WHERE Piece = Pieces.Code
   );
5.Сreate indexes with optimal type for the previous queries
Create index ind_1 on provides(piece)
or 
Create index ind_1 on provides((max(piece))
