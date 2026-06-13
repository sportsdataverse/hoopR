# **Get referee game log**

**Get referee game log**

## Usage

``` r
kp_referee(referee, year)
```

## Arguments

- referee:

  Referee ID

- year:

  Year of data to pull

## Value

A data frame with the following columns:

|              |           |                             |
|--------------|-----------|-----------------------------|
| col_name     | types     | description                 |
| game_number  | integer   | Game number.                |
| date         | character | Date in YYYY-MM-DD format.  |
| time_et      | character | Time et.                    |
| game         | character | Game.                       |
| location     | character | Location.                   |
| venue        | character | Venue name.                 |
| conference   | character | Conference.                 |
| thrill_score | numeric   | Thrill score.               |
| referee_name | character | Referee name.               |
| ref_rank     | numeric   | League/season rank for ref. |
| year         | numeric   | 4-digit year.               |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_referee(referee = 714363, year = 2021))
#>    game_number       date  time_et
#> 1           74  Mon Apr 5  9:20 PM
#> 2           73 Sat Mar 27  7:25 PM
#> 3           72 Mon Mar 22  8:45 PM
#> 4           71 Sat Mar 20  3:30 PM
#> 5           70 Fri Mar 19  1:15 PM
#> 6           69 Sat Mar 13  6:00 PM
#> 7           68 Thu Mar 11 11:30 AM
#> 8           67 Wed Mar 10  9:30 PM
#> 9           66  Sun Mar 7  4:00 PM
#> 10          65  Sat Mar 6  5:00 PM
#> 11          64  Fri Mar 5  8:00 PM
#> 12          63  Thu Mar 4  7:00 PM
#> 13          62  Wed Mar 3  9:00 PM
#> 14          61  Tue Mar 2  7:00 PM
#> 15          60  Mon Mar 1  9:00 PM
#> 16          59 Sat Feb 27 12:00 PM
#> 17          58 Fri Feb 26  8:00 PM
#> 18          57 Thu Feb 25  8:56 PM
#> 19          56 Wed Feb 24  6:30 PM
#> 20          55 Tue Feb 23  7:00 PM
#> 21          54 Mon Feb 22  7:00 PM
#> 22          53 Sun Feb 21  1:00 PM
#> 23          52 Sat Feb 20 12:00 PM
#> 24          51 Sun Feb 14  1:00 PM
#> 25          50 Sat Feb 13  1:00 PM
#> 26          49 Fri Feb 12  6:00 PM
#> 27          48 Wed Feb 10  9:00 PM
#> 28          47  Tue Feb 9  9:00 PM
#> 29          46  Mon Feb 8  9:00 PM
#> 30          45  Sat Feb 6  3:00 PM
#> 31          44  Tue Feb 2  7:00 PM
#> 32          43  Mon Feb 1  9:00 PM
#> 33          42 Sat Jan 30  2:00 PM
#> 34          41 Thu Jan 28  7:00 PM
#> 35          40 Wed Jan 27  9:00 PM
#> 36          39 Tue Jan 26  9:00 PM
#> 37          38 Mon Jan 25  7:00 PM
#> 38          37 Sat Jan 23 12:00 PM
#> 39          36 Mon Jan 18  7:00 PM
#> 40          35 Sun Jan 17  5:00 PM
#> 41          34 Sat Jan 16  3:00 PM
#> 42          33 Wed Jan 13  9:00 PM
#> 43          32  Sat Jan 9  4:00 PM
#> 44          31  Fri Jan 8  8:00 PM
#> 45          30  Wed Jan 6  9:00 PM
#> 46          29  Tue Jan 5 10:00 PM
#> 47          28  Sun Jan 3  6:00 PM
#> 48          27  Sat Jan 2  4:00 PM
#> 49          26  Fri Jan 1  6:00 PM
#> 50          25 Wed Dec 30  6:30 PM
#> 51          24 Tue Dec 29  9:07 PM
#> 52          23 Mon Dec 28  8:00 PM
#> 53          22 Sat Dec 26  4:00 PM
#> 54          21 Fri Dec 25  2:30 PM
#> 55          20 Wed Dec 23  5:00 PM
#> 56          19 Mon Dec 21  3:00 PM
#> 57          18 Sun Dec 20  4:00 PM
#> 58          17 Sat Dec 19 12:00 PM
#> 59          16 Thu Dec 17  7:00 PM
#> 60          15 Wed Dec 16  8:00 PM
#> 61          14 Tue Dec 15  9:00 PM
#> 62          13 Sun Dec 13 12:00 PM
#> 63          12 Sat Dec 12  3:00 PM
#> 64          11 Fri Dec 11  7:00 PM
#> 65          10  Tue Dec 8 10:00 PM
#> 66           9  Mon Dec 7  7:00 PM
#> 67           8  Thu Dec 3  8:00 PM
#> 68           7  Wed Dec 2 10:00 PM
#> 69           6 Mon Nov 30  8:00 PM
#> 70           5 Sun Nov 29  5:30 PM
#> 71           4 Sat Nov 28  7:30 PM
#> 72           3 Fri Nov 27  8:30 PM
#> 73           2 Thu Nov 26  8:00 PM
#> 74           1 Wed Nov 25  4:00 PM
#>                                                  game            location
#> 1                           2 Baylor 86, 1 Gonzaga 70    Indianapolis, IN
#> 2                 15 Arkansas 72, 128 Oral Roberts 70    Indianapolis, IN
#> 3                        8 Alabama 96, 30 Maryland 77    Indianapolis, IN
#> 4             20 Creighton 63, 71 UC Santa Barbara 62    Indianapolis, IN
#> 5                        3 Illinois 78, 145 Drexel 49    Indianapolis, IN
#> 6                     25 Texas 91, 30 Oklahoma St. 86     Kansas City, MO
#> 7             37 Oklahoma St. 72, 25 West Virginia 69     Kansas City, MO
#> 8                     38 Oklahoma 79, 179 Iowa St. 73     Kansas City, MO
#> 9                       3 Baylor 88, 20 Texas Tech 73            Waco, TX
#> 10                 183 Kansas St. 61, 175 Iowa St. 56       Manhattan, KS
#> 11                      114 UAB 65, 62 North Texas 51          Denton, TX
#> 12                    20 West Virginia 76, 127 TCU 67      Morgantown, WV
#> 13                 72 Northwestern 60, 26 Maryland 55        Evanston, IL
#> 14                       6 Illinois 76, 2 Michigan 53       Ann Arbor, MI
#> 15                 36 Oklahoma St. 79, 33 Oklahoma 75      Stillwater, OK
#> 16                      25 Texas Tech 68, 22 Texas 59         Lubbock, TX
#> 17         173 New Mexico St. 78, 311 Tarleton St. 51    Stephenville, TX
#> 18  245 Texas Southern 79, 351 Arkansas Pine Bluff 65         Houston, TX
#> 19                    71 N.C. State 68, 9 Virginia 61 Charlottesville, VA
#> 20                 51 Louisville 69, 56 Notre Dame 57      Louisville, KY
#> 21                         31 Duke 85, 53 Syracuse 71          Durham, NC
#> 22                       4 Michigan 92, 6 Ohio St. 87        Columbus, OH
#> 23                56 Georgia Tech 87, 129 Miami FL 60    Coral Gables, FL
#> 24                       92 Cincinnati 69, 105 UCF 68      Cincinnati, OH
#> 25          23 Oklahoma 91, 16 West Virginia 90 (2OT)      Morgantown, WV
#> 26           72 Marshall 107, 261 Middle Tennessee 79      Huntington, WV
#> 27              48 Saint Louis 67, 74 Rhode Island 60       St. Louis, MO
#> 28                  20 Creighton 63, 96 Georgetown 48      Washington, DC
#> 29  357 Mississippi Valley St. 68, 352 Alabama St. 65      Montgomery, AL
#> 30              38 Oklahoma St. 75, 12 Texas 67 (2OT)      Stillwater, OK
#> 31                61 Clemson 63, 37 North Carolina 50         Clemson, SC
#> 32                   12 Texas Tech 57, 20 Oklahoma 52         Lubbock, TX
#> 33                 25 Florida 85, 16 West Virginia 80      Morgantown, WV
#> 34                           204 UTSA 86, 171 UTEP 79     San Antonio, TX
#> 35                    50 Clemson 54, 38 Louisville 50         Clemson, SC
#> 36                     34 Duke 75, 58 Georgia Tech 68          Durham, NC
#> 37                      9 Virginia 81, 36 Syracuse 58 Charlottesville, VA
#> 38                       26 Oklahoma 75, 14 Kansas 68          Norman, OK
#> 39                23 Florida St. 78, 31 Louisville 65      Louisville, KY
#> 40               134 Santa Clara 69, 180 San Diego 63       San Diego, CA
#> 41                     14 Colorado 77, 45 Stanford 64         Boulder, CO
#> 42                    62 Boise St. 90, 198 Wyoming 70         Laramie, WY
#> 43                   14 Texas Tech 91, 87 Iowa St. 64            Ames, IA
#> 44      89 Western Kentucky 66, 112 Louisiana Tech 64   Bowling Green, KY
#> 45                        2 Baylor 76, 44 Oklahoma 61            Waco, TX
#> 46                            12 Kansas 93, 63 TCU 64      Fort Worth, TX
#> 47             73 Georgia Tech 70, 117 Wake Forest 54         Atlanta, GA
#> 48             27 North Carolina 66, 92 Notre Dame 65     Chapel Hill, NC
#> 49                295 Troy 69, 197 Appalachian St. 56           Boone, NC
#> 50                    16 Ohio St. 90, 116 Nebraska 54        Columbus, OH
#> 51                      5 Iowa 87, 53 Northwestern 72       Iowa City, IA
#> 52                42 Minnesota 81, 31 Michigan St. 56     Minneapolis, MN
#> 53                       7 Illinois 69, 21 Indiana 60       Champaign, IL
#> 54                       33 Purdue 73, 47 Maryland 70  West Lafayette, IN
#> 55                 7 Tennessee 80, 303 USC Upstate 60       Knoxville, TN
#> 56                    261 Rice 73, 316 New Orleans 62         Houston, TX
#> 57           183 UTSA 102, NR Our Lady of the Lake 70     San Antonio, TX
#> 58                            1 Gonzaga 99, 4 Iowa 88     Sioux Falls, SD
#> 59                       9 Kansas 58, 8 Texas Tech 57         Lubbock, TX
#> 60                 5 Texas 79, 309 Sam Houston St. 63          Austin, TX
#> 61                  155 Kansas St. 74, 78 Iowa St. 65            Ames, IA
#> 62         82 Western Kentucky 68, 73 Rhode Island 65   Bowling Green, KY
#> 63             46 Oklahoma St. 67, 101 Wichita St. 64         Wichita, KS
#> 64                   13 Creighton 98, 111 Nebraska 74           Omaha, NE
#> 65                    68 Saint Mary's 73, 197 UTEP 61          Moraga, CA
#> 66                118 Nevada 86, NR William Jessup 64            Reno, NV
#> 67                 57 TCU 74, 274 Northwestern St. 68      Fort Worth, TX
#> 68                        2 Baylor 82, 22 Illinois 69    Indianapolis, IN
#> 69           58 SMU 91, 315 Texas A&M Corpus Chris 54          Dallas, TX
#> 70                     17 Houston 64, 5 Texas Tech 53      Fort Worth, TX
#> 71                             57 TCU 70, 93 Tulsa 65     Kansas City, MO
#> 72                  58 Colorado 76, 127 Kansas St. 58       Manhattan, KS
#> 73 105 North Texas 116, 357 Mississippi Valley St. 62          Denton, TX
#> 74            34 Oklahoma St. 75, 159 UT Arlington 68       Arlington, TX
#>                               venue conference thrill_score referee_name
#> 1                 Lucas Oil Stadium       NCAA         88.4 Keith Kimble
#> 2           Bankers Life Fieldhouse       NCAA         36.5 Keith Kimble
#> 3           Bankers Life Fieldhouse       NCAA         74.3 Keith Kimble
#> 4                 Lucas Oil Stadium       NCAA         62.0 Keith Kimble
#> 5          Indiana Farmers Coliseum       NCAA         26.4 Keith Kimble
#> 6                   T-Mobile Center      B12-T         79.0 Keith Kimble
#> 7                   T-Mobile Center      B12-T         77.9 Keith Kimble
#> 8                   T-Mobile Center      B12-T         30.6 Keith Kimble
#> 9                    Ferrell Center        B12         65.8 Keith Kimble
#> 10           Fred Bramlage Coliseum        B12         37.7 Keith Kimble
#> 11                    The Super Pit       CUSA         44.3 Keith Kimble
#> 12                     WVU Coliseum        B12         32.5 Keith Kimble
#> 13                 Welsh-Ryan Arena        B10         68.0 Keith Kimble
#> 14                   Crisler Center        B10         76.5 Keith Kimble
#> 15              Gallagher-Iba Arena        B12         73.2 Keith Kimble
#> 16        United Supermarkets Arena        B12         76.3 Keith Kimble
#> 17                 Wisdom Gymnasium        WAC         26.5 Keith Kimble
#> 18               Health & PE Center       SWAC         11.8 Keith Kimble
#> 19            John Paul Jones Arena        ACC         47.9 Keith Kimble
#> 20                  KFC Yum! Center        ACC         66.5 Keith Kimble
#> 21           Cameron Indoor Stadium        ACC         67.6 Keith Kimble
#> 22                 Value City Arena        B10         87.2 Keith Kimble
#> 23                    Watsco Center        ACC         52.8 Keith Kimble
#> 24                Fifth Third Arena       Amer         49.1 Keith Kimble
#> 25                     WVU Coliseum        B12         75.1 Keith Kimble
#> 26                 Henderson Center       CUSA         14.9 Keith Kimble
#> 27                   Chaifetz Arena        A10         57.8 Keith Kimble
#> 28                  McDonough Arena         BE         58.8 Keith Kimble
#> 29              Dunn-Oliver Acadome       SWAC         10.2 Keith Kimble
#> 30              Gallagher-Iba Arena        B12         77.3 Keith Kimble
#> 31              Littlejohn Coliseum        ACC         69.0 Keith Kimble
#> 32        United Supermarkets Arena        B12         74.4 Keith Kimble
#> 33                     WVU Coliseum                    72.7 Keith Kimble
#> 34          UTSA Convocation Center       CUSA         37.5 Keith Kimble
#> 35              Littlejohn Coliseum        ACC         68.5 Keith Kimble
#> 36           Cameron Indoor Stadium        ACC         63.7 Keith Kimble
#> 37            John Paul Jones Arena        ACC         63.8 Keith Kimble
#> 38               Lloyd Noble Center        B12         78.3 Keith Kimble
#> 39                  KFC Yum! Center        ACC         75.0 Keith Kimble
#> 40             Jenny Craig Pavilion        WCC         39.2 Keith Kimble
#> 41                 CU Events Center        P12         63.4 Keith Kimble
#> 42                 Arena-Auditorium        MWC         34.3 Keith Kimble
#> 43                  Hilton Coliseum        B12         60.6 Keith Kimble
#> 44                     Diddle Arena       CUSA         45.9 Keith Kimble
#> 45                   Ferrell Center        B12         53.1 Keith Kimble
#> 46                Schollmaier Arena        B12         67.1 Keith Kimble
#> 47                McCamish Pavilion        ACC         42.1 Keith Kimble
#> 48             Dean E. Smith Center        ACC         45.9 Keith Kimble
#> 49        Holmes Convocation Center         SB         23.6 Keith Kimble
#> 50                 Value City Arena        B10         33.6 Keith Kimble
#> 51             Carver-Hawkeye Arena        B10         59.5 Keith Kimble
#> 52                   Williams Arena        B10         74.7 Keith Kimble
#> 53                State Farm Center        B10         72.6 Keith Kimble
#> 54                     Mackey Arena        B10         66.8 Keith Kimble
#> 55            Thompson-Boling Arena                     9.8 Keith Kimble
#> 56                 Tudor Fieldhouse                    25.4 Keith Kimble
#> 57          UTSA Convocation Center                     0.0 Keith Kimble
#> 58                 Sanford Pentagon                    85.7 Keith Kimble
#> 59        United Supermarkets Arena        B12         77.4 Keith Kimble
#> 60                     Erwin Center                     9.9 Keith Kimble
#> 61                  Hilton Coliseum        B12         32.0 Keith Kimble
#> 62                E.A. Diddle Arena                    59.6 Keith Kimble
#> 63               Charles Koch Arena                    56.3 Keith Kimble
#> 64          CHI Health Center Omaha                    33.8 Keith Kimble
#> 65 University Credit Union Pavilion                    23.0 Keith Kimble
#> 66             Lawlor Events Center                     0.0 Keith Kimble
#> 67                Schollmaier Arena                    12.8 Keith Kimble
#> 68          Bankers Life Fieldhouse                    73.9 Keith Kimble
#> 69                   Moody Coliseum                    10.9 Keith Kimble
#> 70                    Dickies Arena                    78.1 Keith Kimble
#> 71                  T-Mobile Center                    54.0 Keith Kimble
#> 72                Bramlage Coliseum                    49.4 Keith Kimble
#> 73                    The Super Pit                     6.4 Keith Kimble
#> 74              College Park Center                    36.3 Keith Kimble
#>    ref_rank year
#> 1         4 2021
#> 2         4 2021
#> 3         4 2021
#> 4         4 2021
#> 5         4 2021
#> 6         4 2021
#> 7         4 2021
#> 8         4 2021
#> 9         4 2021
#> 10        4 2021
#> 11        4 2021
#> 12        4 2021
#> 13        4 2021
#> 14        4 2021
#> 15        4 2021
#> 16        4 2021
#> 17        4 2021
#> 18        4 2021
#> 19        4 2021
#> 20        4 2021
#> 21        4 2021
#> 22        4 2021
#> 23        4 2021
#> 24        4 2021
#> 25        4 2021
#> 26        4 2021
#> 27        4 2021
#> 28        4 2021
#> 29        4 2021
#> 30        4 2021
#> 31        4 2021
#> 32        4 2021
#> 33        4 2021
#> 34        4 2021
#> 35        4 2021
#> 36        4 2021
#> 37        4 2021
#> 38        4 2021
#> 39        4 2021
#> 40        4 2021
#> 41        4 2021
#> 42        4 2021
#> 43        4 2021
#> 44        4 2021
#> 45        4 2021
#> 46        4 2021
#> 47        4 2021
#> 48        4 2021
#> 49        4 2021
#> 50        4 2021
#> 51        4 2021
#> 52        4 2021
#> 53        4 2021
#> 54        4 2021
#> 55        4 2021
#> 56        4 2021
#> 57        4 2021
#> 58        4 2021
#> 59        4 2021
#> 60        4 2021
#> 61        4 2021
#> 62        4 2021
#> 63        4 2021
#> 64        4 2021
#> 65        4 2021
#> 66        4 2021
#> 67        4 2021
#> 68        4 2021
#> 69        4 2021
#> 70        4 2021
#> 71        4 2021
#> 72        4 2021
#> 73        4 2021
#> 74        4 2021
# }
```
