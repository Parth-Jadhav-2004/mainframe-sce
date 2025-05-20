# Top-Selling Books Analyzer

A COBOL-based application that analyzes book sales data and identifies the top 10 bestselling books from a sales dataset.

## Project Description

The Top-Selling Books Analyzer is designed to process book sales records from a data file and generate a report of the bestselling books. The system reads records containing book information (book number, name), sales quantity, and sale status, then aggregates the data to determine which books have sold the most copies.

## Features

- **Data Processing**: Reads and processes book sales records from a structured data file
- **Sales Aggregation**: Combines multiple sales records for the same book
- **Status Filtering**: Processes only valid sales (marked with 'N' status)
- **Automatic Sorting**: Sorts books by sales volume in descending order
- **Top 10 Display**: Shows the 10 bestselling books with their details

## File Structure

- **booksales.cbl**: Main COBOL program file containing the processing logic
- **BOOKSALES.DAT**: Input data file with book sales records

## Data File Format

Each record in the BOOKSALES.DAT file contains:
- **Book Number** (5 characters)
- **Book Name** (20 characters)
- **Copies Sold** (4 digits)
- **Sale Status** (1 character)
  - 'N' = Normal sale (counted in totals)
  - 'R' = Returned (not counted)
  - 'F' = Free copy (not counted)

Example record: `B001 The Alchemist       0005N`

## Technical Implementation

The program utilizes several key COBOL concepts:
- **File Handling**: Sequential file reading operations
- **Tables/Arrays**: Storage and manipulation of book data
- **Sorting Algorithm**: Bubble sort to arrange books by sales volume
- **Conditional Logic**: Processing only records with specific status codes

## Requirements

- COBOL compiler (such as GnuCOBOL, IBM Enterprise COBOL, or Micro Focus COBOL)
- Mainframe environment or compatible system for execution

## Usage

1. Ensure your BOOKSALES.DAT file is properly formatted with book sales records
2. Compile the COBOL program:
   ```
   cobc -x booksales.cbl
   ```
3. Execute the compiled program:
   ```
   ./booksales
   ```
4. The program will display the top 10 bestselling books on the terminal

## Sample Output

```
TOP 10 BESTSELLING BOOKS:
----------------------------------------
B007 | To Kill a Mocking | Copies Sold: 00011
B005 | 1984 | Copies Sold: 00017
B004 | Think & Grow Rich | Copies Sold: 00006
B010 | The Great Gatsby | Copies Sold: 00006
B001 | The Alchemist | Copies Sold: 00009
B009 | Sapiens | Copies Sold: 00008
B003 | Atomic Habits | Copies Sold: 00004
B008 | Pride and Prejudic | Copies Sold: 00003
B006 | The Hobbit | Copies Sold: 00002
B012 | Meditations | Copies Sold: 00002
```

## Program Flow

1. Opens and reads the sales data file (BOOKSALES.DAT)
2. Processes each record, filtering by sale status ('N')
3. Adds book sales to a table, combining quantities for duplicate books
4. Sorts the table in descending order by copies sold
5. Displays the top 10 bestselling books

## Limitations

- The program can handle up to 100 unique book titles
- Book names are limited to 20 characters
- Sale quantity is limited to 9999 copies per transaction



## Author

Parth Jadhav
