       IDENTIFICATION DIVISION.
       PROGRAM-ID. TOP-SELLING-BOOKS.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT BOOKSALES ASSIGN TO 'BOOKSALES.DAT'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FILE-STATUS-CODE.

       DATA DIVISION.
       FILE SECTION.
       FD BOOKSALES.
       01 BOOK-RECORD.
           05 BOOK-NUMBER        PIC X(5).
           05 BOOK-NAME          PIC X(20).
           05 COPIES-SOLD        PIC 9(4).D
           05 SALE-STATUS        PIC X.

       WORKING-STORAGE SECTION.
       01 FILE-STATUS-CODE       PIC XX.
       01 EOF-FLAG               PIC X VALUE 'N'.
           88 END-OF-FILE        VALUE 'Y'.

       01 BOOK-TABLE.
           05 BOOK-ENTRY OCCURS 100 TIMES INDEXED BY IDX.
               10 ENTRY-BOOK-NUMBER   PIC X(5).
               10 ENTRY-BOOK-NAME     PIC X(20).
               10 ENTRY-COPIES        PIC 9(5).

       01 MATCHED-FLAG           PIC X VALUE 'N'.
           88 MATCHED             VALUE 'Y'.
           88 NOT-MATCHED         VALUE 'N'.

       01 I                      PIC 9(3).
       01 J                      PIC 9(3).
       01 START-J                PIC 9(3).

       01 TEMP-BOOK-NUMBER       PIC X(5).
       01 TEMP-BOOK-NAME         PIC X(20).
       01 TEMP-COPIES            PIC 9(5).

       PROCEDURE DIVISION.
       MAIN-PARA.
           OPEN INPUT BOOKSALES
           PERFORM UNTIL END-OF-FILE
               READ BOOKSALES
                   AT END
                       SET END-OF-FILE TO TRUE
                   NOT AT END
                       IF SALE-STATUS = 'N'
                           PERFORM ADD-TO-TABLE
                       END-IF
               END-READ
           END-PERFORM

           PERFORM SORT-TABLE

           DISPLAY "TOP 10 BESTSELLING BOOKS:"
           DISPLAY "----------------------------------------"
           PERFORM DISPLAY-TOP-10

           CLOSE BOOKSALES
           STOP RUN.

       ADD-TO-TABLE.
           SET NOT-MATCHED TO TRUE
           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 100
               IF ENTRY-BOOK-NUMBER(IDX) = BOOK-NUMBER
                   ADD COPIES-SOLD TO ENTRY-COPIES(IDX)
                   SET MATCHED TO TRUE
                   EXIT PERFORM
               END-IF
           END-PERFORM
           IF NOT MATCHED
               PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 100
                   IF ENTRY-BOOK-NUMBER(IDX) = SPACES
                       MOVE BOOK-NUMBER TO ENTRY-BOOK-NUMBER(IDX)
                       MOVE BOOK-NAME TO ENTRY-BOOK-NAME(IDX)
                       MOVE COPIES-SOLD TO ENTRY-COPIES(IDX)
                       EXIT PERFORM
                   END-IF
               END-PERFORM
           END-IF.

       SORT-TABLE.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 99
               COMPUTE START-J = I + 1
               PERFORM VARYING J FROM START-J BY 1 UNTIL J > 100
                   IF ENTRY-COPIES(J) > ENTRY-COPIES(I)
                       MOVE ENTRY-BOOK-NUMBER(I) TO TEMP-BOOK-NUMBER
                       MOVE ENTRY-BOOK-NAME(I) TO TEMP-BOOK-NAME
                       MOVE ENTRY-COPIES(I) TO TEMP-COPIES

                       MOVE ENTRY-BOOK-NUMBER(J) TO ENTRY-BOOK-NUMBER(I)
                       MOVE ENTRY-BOOK-NAME(J) TO ENTRY-BOOK-NAME(I)
                       MOVE ENTRY-COPIES(J) TO ENTRY-COPIES(I)

                       MOVE TEMP-BOOK-NUMBER TO ENTRY-BOOK-NUMBER(J)
                       MOVE TEMP-BOOK-NAME TO ENTRY-BOOK-NAME(J)
                       MOVE TEMP-COPIES TO ENTRY-COPIES(J)
                   END-IF
               END-PERFORM
           END-PERFORM.

       DISPLAY-TOP-10.
           PERFORM VARYING IDX FROM 1 BY 1 UNTIL IDX > 10
               IF ENTRY-BOOK-NUMBER(IDX) NOT = SPACES
                   DISPLAY ENTRY-BOOK-NUMBER(IDX) " | "
                           FUNCTION TRIM(ENTRY-BOOK-NAME(IDX)) " | "
                           "Copies Sold: " ENTRY-COPIES(IDX)
               END-IF
           END-PERFORM.
