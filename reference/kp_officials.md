# **Get officials rankings**

**Get officials rankings**

## Usage

``` r
kp_officials(year = most_recent_mbb_season())
```

## Arguments

- year:

  Year of data to pull

## Value

A data frame with the following columns:

|               |           |
|---------------|-----------|
| col_name      | types     |
| rk            | integer   |
| official_name | character |
| ref_rating    | numeric   |
| gms           | numeric   |
| last_game     | character |
| last_game_1   | character |
| year          | numeric   |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_officials(year = 2021))
#>      rk         official_name ref_rating gms last_game
#> 1     1            Bo Boroski      70.73  61   Mon 4/5
#> 2     2       D.J. Carstensen      70.66  58  Sun 3/28
#> 3     3            Paul Szelc      65.98  57  Mon 3/29
#> 4     4          Keith Kimble      65.08  74   Mon 4/5
#> 5     5        Larry Scirotto      64.73  56  Sat 3/27
#> 6     6           Ron Groover      64.01  69   Sat 4/3
#> 7     7           Roger Ayers      61.71  73  Sun 3/14
#> 8     8            Doug Shows      60.78  64  Tue 3/30
#> 9     9        Kipp Kissinger      60.67  72  Thu 3/11
#> 10   10            Bert Smith      60.52  71  Tue 3/30
#> 11   11         Kelly Pfeifer      59.56  53  Sun 3/28
#> 12   12        Courtney Green      59.13  50  Sat 3/27
#> 13   13          Pat Driscoll      58.70  58  Sun 3/28
#> 14   14          Doug Sirmons      57.92  69   Sat 4/3
#> 15   15          John Higgins      57.87  67  Sat 3/13
#> 16   16          Robert Riley      57.44  50  Mon 3/22
#> 17   17         Brent Hampton      56.99  57  Sat 3/27
#> 18   18         Terry Oglesby      56.71  74  Mon 3/29
#> 19   19           Lee Cassell      56.11  57  Tue 3/30
#> 20   20       Chris Rastatter      55.91  71   Sat 4/3
#> 21   21         Ted Valentine      55.89  59  Sat 3/13
#> 22   22             Pat Adams      55.01  54   Sat 4/3
#> 23   23       Brian O'Connell      54.82  54  Sun 3/28
#> 24   24          Brooks Wells      54.65  63  Sun 3/28
#> 25   25             Don Daily      53.92  55  Sun 3/28
#> 26   26          Brian Dorsey      53.45  54  Sun 3/28
#> 27   27        James Breeding      53.32  59   Sat 4/3
#> 28   28          Tony Padilla      52.55  68  Sun 3/28
#> 29   29           Terry Wymer      52.32  54  Sun 3/21
#> 30   30         Gerry Pollard      51.70  71  Sat 3/27
#> 31   31    Michael Greenstein      51.54  58  Sun 3/28
#> 32   32      Jeffrey Anderson      50.51  49   Sat 4/3
#> 33   33          Randy McCall      50.47  70   Mon 4/5
#> 34   34          Jamie Luckie      50.22  53  Thu 3/11
#> 35   35          John Gaffney      50.20  50  Fri 3/12
#> 36   36    Clarence Armstrong      50.06  54  Sat 3/20
#> 37   37            Ray Natili      49.77  56  Fri 3/12
#> 38   38            Jeff Clark      49.75  54  Mon 3/29
#> 39   39          Verne Harris      49.53  71  Tue 3/30
#> 40   40         Byron Jarrett      48.94  55  Sat 3/27
#> 41   NA              Name FAA         NA  NA Last Game
#> 42   41          Jeb Hartness      47.86  68  Sat 3/27
#> 43   42          Mike Roberts      47.53  45  Sat 3/13
#> 44   43          Gary Maxwell      47.10  61  Sat 3/13
#> 45   44         Donnie Eppley      46.97  43  Sun 3/21
#> 46   45         Lamar Simpson      46.78  42  Sun 3/21
#> 47   46            Eric Curry      46.41  52  Sat 3/13
#> 48   47             Mike Reed      46.30  59  Sun 3/21
#> 49   48      Michael Stephens      45.99  50   Sat 3/6
#> 50   49            David Hall      45.78  61  Sat 3/13
#> 51   50           Tony Greene      44.08  45  Sat 3/20
#> 52   51           Joe Lindsay      43.90  45  Sat 3/27
#> 53   52         Patrick Evans      43.36  43  Sat 3/13
#> 54   53        Anthony Jordan      43.35  48  Sat 3/13
#> 55   54        Michael Irving      42.94  57  Sun 3/28
#> 56   55           Earl Walton      42.44  53  Wed 3/24
#> 57   56          Rob Kueneman      42.42  42  Fri 3/12
#> 58   57        Tony Henderson      41.93  51  Sun 3/28
#> 59   58           Matt Potter      41.15  51  Fri 3/19
#> 60   59           Todd Austin      41.09  52  Sat 3/20
#> 61   60            Bret Smith      40.30  58  Sun 3/21
#> 62   61       Larry Spaulding      39.82  53  Sun 3/28
#> 63   62    Bill Covington Jr.      39.16  47  Mon 3/22
#> 64   63 Vladimir Voyard-Tadal      39.02  46  Sat 3/20
#> 65   64          Tony Chiazza      38.77  42  Sun 3/21
#> 66   65            Bart Lenox      38.31  51  Fri 3/19
#> 67   66         Olandis Poole      37.43  49  Fri 3/12
#> 68   67          Jerry Heater      37.25  50  Sun 3/28
#> 69   68     Marques Pettigrew      37.11  52  Sun 3/28
#> 70   69        Tim Clougherty      37.04  41  Sun 3/21
#> 71   70        Steve Anderson      36.94  43  Mon 3/22
#> 72   71           Owen Shortt      36.92  47  Sat 3/20
#> 73   72         Mike Scyphers      36.41  48  Sat 3/13
#> 74   73            John Floyd      36.20  51  Sun 3/28
#> 75   74           Chuck Jones      35.74  40  Sat 3/13
#> 76   75           Will Howard      35.47  46  Fri 3/12
#> 77   76            Mike Nance      35.28  44  Sat 3/13
#> 78   77            A.J. Desai      35.03  44  Sat 3/27
#> 79   78           Edwin Young      34.81  33  Sun 3/28
#> 80   79               Bill Ek      34.81  47  Mon 3/22
#> 81   80       Tommy Morrissey      34.58  44  Sun 3/28
#> 82   NA              Name FAA         NA  NA Last Game
#> 83   81        Lewis Garrison      34.48  30  Sat 3/13
#> 84   82           Kevin Brill      34.14  45  Sun 3/21
#> 85   83           Nate Harris      34.02  46  Fri 3/12
#> 86   84       Steve McJunkins      33.91  31  Sat 3/20
#> 87   85            Amy Bonner      33.84  61  Thu 3/18
#> 88   86         Antinio Petty      33.75  51  Sat 3/20
#> 89   87           Deron White      33.49  45  Sat 3/13
#> 90   88         Gregory Nixon      33.11  45  Sat 3/20
#> 91   89         Darron George      31.68  51  Thu 3/25
#> 92   90           Jason Baker      31.35  43  Fri 3/12
#> 93   91            Kelly Self      31.13  46  Fri 3/12
#> 94   92           Tommy Nunez      30.97  46  Sat 3/13
#> 95   93          K.B. Burdett      30.65  45  Fri 3/12
#> 96   94          Chance Moore      30.47  46  Thu 3/25
#> 97   95         Rick Crawford      30.07  42  Wed 3/24
#> 98   96           Deldre Carr      30.06  41  Sun 3/21
#> 99   97           Mark Schnur      29.02  44  Wed 3/10
#> 100  98             Les Jones      28.99  42  Thu 3/11
#> 101  99             Tim Comer      28.09  48  Sun 3/14
#> 102 100             Rob Rorke      28.02  36  Fri 3/12
#> 103 101       Randy Heimerman      27.57  37  Sat 3/20
#> 104 102         Steve Honacki      26.35  43   Mon 3/8
#> 105 103           D.G. Nelson      25.93  41  Sat 3/13
#> 106 104           Chad Barlow      25.27  37  Fri 3/12
#> 107 105        Evon Burroughs      24.88  31  Sun 3/14
#> 108 106           Tim Stewart      24.09  34  Sat 3/13
#> 109 107           Bob Staffen      23.68  41  Fri 3/12
#> 110 108          Brandon Cruz      23.19  42  Sat 3/13
#> 111 109          Andy O'Brien      23.18  40  Thu 3/18
#> 112 110          Kevin Mathis      22.78  34  Thu 3/11
#> 113 111            Chase Shaw      22.74  46   Sat 3/6
#> 114 112         Rodrick Dixon      22.27  37  Thu 3/25
#> 115 113     Michael Kitts Jr.      22.15  40  Wed 3/24
#> 116 114         Wally Rutecki      22.10  31  Thu 3/11
#> 117 115          Frank Harvey      22.06  31  Thu 3/11
#> 118 116          Brian McNutt      21.76  35  Thu 3/18
#> 119 117          Shawn Lehigh      21.66  39  Fri 3/12
#> 120 118          Ron Tyburski      21.50  37  Fri 3/12
#> 121 119         Anthony Eades      21.31  46   Sat 3/6
#> 122 120          John Hampton      21.26  31   Sat 3/6
#> 123  NA              Name FAA         NA  NA Last Game
#> 124 121          Craig Murley      21.13  38  Thu 3/11
#> 125 122    Justin Porterfield      20.88  33  Wed 3/10
#> 126 123       Gerald Williams      20.61  30  Thu 3/25
#> 127 124             Tim Smith      20.46  36   Sat 3/6
#> 128 125           Nathan Hall      20.36  36  Wed 3/10
#> 129 126        Raymond Styons      19.96  33  Tue 2/23
#> 130 127          Jim Schipper      18.48  28  Thu 3/11
#> 131 128          Jon Campbell      18.33  30   Tue 3/9
#> 132 129          Alfred Smith      18.24  30  Fri 3/12
#> 133 130       Bryan Anslinger      18.00  30  Thu 3/11
#> 134 131       Casey McClellan      17.83  27  Fri 3/12
#> 135 132           Scott Brown      17.82  27  Fri 3/12
#> 136 133             Sean Hull      17.76  29  Sun 3/14
#> 137 134          Kerby Sitton      17.76  36  Thu 3/25
#> 138 135         Robert Felder      17.70  31  Fri 3/12
#> 139 136      Adam Vandenburgh      17.63  31  Sat 3/13
#> 140 137       Garrick Shannon      17.54  36  Thu 3/11
#> 141 138        Stephen Divine      17.40  27  Thu 3/11
#> 142 139          Rick Batsell      17.28  35  Fri 3/12
#> 143 140             Tim Kelly      17.23  29   Sun 3/7
#> 144 141          Ryan Corbett      17.12  29  Fri 3/12
#> 145 142         Jeremy Mosier      17.09  29   Mon 3/1
#> 146 143         Bill Vinovich      17.04  27  Fri 3/12
#> 147 144           Ed Phillips      16.95  31  Thu 3/11
#> 148 145        Phil Sallustio      16.65  28   Sat 3/6
#> 149 146      Randy Richardson      16.64  26  Thu 3/18
#> 150 147        Keith Fogleman      15.88  29   Sun 3/7
#> 151 148      Mick Fieldbinder      15.83  36  Thu 3/11
#> 152 149         Peter Juzenas      15.81  21  Thu 3/11
#> 153 150         Glen Mayberry      15.60  26  Fri 3/12
#> 154 151            Greg Evans      15.54  24   Sat 3/6
#> 155 152           Matt Palumb      15.32  29  Thu 3/11
#> 156 153            Brian Shey      15.32  25   Sat 3/6
#> 157 154              Jeff Pon      15.32  27  Tue 3/23
#> 158 155         Andrew Walton      15.28  26   Fri 3/5
#> 159 156         Michael Palau      15.22  27   Tue 3/9
#> 160 157          Kerry Sitton      15.18  29  Fri 3/12
#> 161 158           Jeff Malham      15.18  29   Tue 3/9
#> 162 159           Trey Styons      15.08  28  Sat 2/27
#> 163 160           Jeff Ketchu      15.04  26  Fri 3/12
#> 164  NA              Name FAA         NA  NA Last Game
#> 165 161            Tony Crisp      14.90  21  Wed 3/10
#> 166 162          Shane Staggs      14.89  32  Wed 3/10
#> 167 163      Michael Griffith      14.86  28   Mon 3/8
#> 168 164         Lionel Butler      14.81  30  Sat 3/13
#> 169 165           Brent Meaux      14.78  32  Fri 3/12
#> 170 166          Jabir Walker      14.75  29  Thu 3/11
#> 171 167           Tariq Lucas      14.75  27   Tue 3/2
#> 172 168          Luke Schumer      14.67  26   Mon 3/8
#> 173 169           Tyler Kumpf      14.43  26  Wed 3/10
#> 174 170            Ed Corliss      14.27  27  Wed 3/10
#> 175 171          Matt Morales      14.23  24   Tue 3/2
#> 176 172         Daryl Gelinas      14.14  27  Fri 3/12
#> 177 173        King Whetstone      14.07  28  Sat 3/13
#> 178 174         Bill Jacobson      14.02  20  Thu 3/11
#> 179 175          Chris Beaver      13.97  18  Wed 1/27
#> 180 176       Matthew Rukasin      13.82  27   Sat 3/6
#> 181 177        Dwayne Gladden      13.55  25  Sat 3/13
#> 182 178             Tom Nally      13.41  24  Thu 3/11
#> 183 179           Kurt Walker      13.41  21   Sat 3/6
#> 184 180         Gene Grimshaw      13.41  23   Fri 3/5
#> 185 181       Todd Von Sossan      13.37  22  Sun 2/28
#> 186 182          Bret Wegenke      13.33  21   Tue 3/2
#> 187 183          Jourdan Love      13.15  25   Tue 3/2
#> 188 184        Mike McCloskey      13.12  22  Wed 3/10
#> 189 185         Ryan McDaniel      13.11  23  Thu 3/11
#> 190 186       Doran Gotschall      12.97  25  Thu 3/11
#> 191 187           Brad Ferrie      12.88  27  Fri 3/12
#> 192 188  Christopher Slattery      12.82  23  Sat 3/13
#> 193 189          Billy Dunlap      12.72  19   Sun 3/7
#> 194 190          Zelton Steed      12.68  20   Sat 3/6
#> 195 191              JW Lucas      12.58  24   Mon 3/1
#> 196 192            Dan Dorian      12.55  21   Fri 3/5
#> 197 193       Ed Corbett, Jr.      12.52  22  Sun 2/28
#> 198 194       Keith Patterson      12.46  24   Fri 3/5
#> 199 195          Rick O'Neill      12.45  22  Fri 3/12
#> 200 196         Jeff Spedoske      12.38  20   Fri 3/5
#> 201 197            Tony Meeks      12.32  23  Thu 3/11
#> 202 198          Jose Carrion      12.21  24   Sat 3/6
#> 203 199          Hunter Allen      12.20  25   Fri 3/5
#> 204 200      Anthony Franklin      12.19  23   Mon 3/1
#>                                                              last_game_1 year
#> 1                           2 Baylor 86, 1 Gonzaga 70 (Indianapolis, IN) 2021
#> 2                    4 Michigan 76, 12 Florida St. 58 (Indianapolis, IN) 2021
#> 3                         2 Baylor 81, 18 Arkansas 72 (Indianapolis, IN) 2021
#> 4                           2 Baylor 86, 1 Gonzaga 70 (Indianapolis, IN) 2021
#> 5                 15 Arkansas 72, 128 Oral Roberts 70 (Indianapolis, IN) 2021
#> 6                       1 Gonzaga 93, 15 UCLA 90 (OT) (Indianapolis, IN) 2021
#> 7                          28 St. Bonaventure 74, 43 VCU 65 (Dayton, OH) 2021
#> 8                              1 Gonzaga 85, 6 USC 66 (Indianapolis, IN) 2021
#> 9              37 Oklahoma St. 72, 25 West Virginia 69 (Kansas City, MO) 2021
#> 10                             1 Gonzaga 85, 6 USC 66 (Indianapolis, IN) 2021
#> 11                             6 USC 82, 15 Oregon 68 (Indianapolis, IN) 2021
#> 12              48 Oregon St. 65, 9 Loyola Chicago 58 (Indianapolis, IN) 2021
#> 13                      21 UCLA 88, 8 Alabama 78 (OT) (Indianapolis, IN) 2021
#> 14                          2 Baylor 78, 3 Houston 59 (Indianapolis, IN) 2021
#> 15                     25 Texas 91, 30 Oklahoma St. 86 (Kansas City, MO) 2021
#> 16                           3 Michigan 86, 23 LSU 78 (Indianapolis, IN) 2021
#> 17                       4 Houston 62, 37 Syracuse 46 (Indianapolis, IN) 2021
#> 18                        2 Baylor 81, 18 Arkansas 72 (Indianapolis, IN) 2021
#> 19                          16 UCLA 51, 3 Michigan 49 (Indianapolis, IN) 2021
#> 20                          2 Baylor 78, 3 Houston 59 (Indianapolis, IN) 2021
#> 21                35 Georgia Tech 80, 13 Florida St. 75 (Greensboro, NC) 2021
#> 22                          2 Baylor 78, 3 Houston 59 (Indianapolis, IN) 2021
#> 23                             6 USC 82, 15 Oregon 68 (Indianapolis, IN) 2021
#> 24                 83 Louisiana Tech 76, 75 Colorado St. 74 (Frisco, TX) 2021
#> 25                      21 UCLA 88, 8 Alabama 78 (OT) (Indianapolis, IN) 2021
#> 26                   4 Michigan 76, 12 Florida St. 58 (Indianapolis, IN) 2021
#> 27                      1 Gonzaga 93, 15 UCLA 90 (OT) (Indianapolis, IN) 2021
#> 28                   4 Michigan 76, 12 Florida St. 58 (Indianapolis, IN) 2021
#> 29                 9 Loyola Chicago 71, 2 Illinois 58 (Indianapolis, IN) 2021
#> 30                       2 Baylor 62, 11 Villanova 51 (Indianapolis, IN) 2021
#> 31                      1 Gonzaga 83, 20 Creighton 65 (Indianapolis, IN) 2021
#> 32                      1 Gonzaga 93, 15 UCLA 90 (OT) (Indianapolis, IN) 2021
#> 33                          2 Baylor 86, 1 Gonzaga 70 (Indianapolis, IN) 2021
#> 34                       12 Virginia 72, 44 Syracuse 69 (Greensboro, NC) 2021
#> 35                     73 Georgetown 66, 49 Seton Hall 58 (New York, NY) 2021
#> 36                   1 Gonzaga 98, 203 Norfolk St. 55 (Indianapolis, IN) 2021
#> 37                     37 Oklahoma St. 83, 3 Baylor 74 (Kansas City, MO) 2021
#> 38                        2 Baylor 81, 18 Arkansas 72 (Indianapolis, IN) 2021
#> 39                          16 UCLA 51, 3 Michigan 49 (Indianapolis, IN) 2021
#> 40                       2 Baylor 62, 11 Villanova 51 (Indianapolis, IN) 2021
#> 41                                                             Last Game 2021
#> 42              48 Oregon St. 65, 9 Loyola Chicago 58 (Indianapolis, IN) 2021
#> 43                      68 Georgetown 73, 10 Creighton 48 (New York, NY) 2021
#> 44           73 North Texas 61, 92 Western Kentucky 57 (OT) (Frisco, TX) 2021
#> 45                 135 Oral Roberts 81, 37 Florida 78 (Indianapolis, IN) 2021
#> 46                 15 Villanova 84, 57 North Texas 61 (Indianapolis, IN) 2021
#> 47                   24 San Diego St. 68, 38 Utah St. 57 (Las Vegas, NV) 2021
#> 48                 15 Villanova 84, 57 North Texas 61 (Indianapolis, IN) 2021
#> 49                      26 Connecticut 98, 85 Georgetown 82 (Storrs, CT) 2021
#> 50                   24 San Diego St. 68, 38 Utah St. 57 (Las Vegas, NV) 2021
#> 51           18 Florida St. 64, 100 UNC Greensboro 54 (Indianapolis, IN) 2021
#> 52                15 Arkansas 72, 128 Oral Roberts 70 (Indianapolis, IN) 2021
#> 53                             29 LSU 78, 19 Arkansas 71 (Nashville, TN) 2021
#> 54                 112 Cincinnati 60, 70 Wichita St. 59 (Fort Worth, TX) 2021
#> 55                      21 UCLA 88, 8 Alabama 78 (OT) (Indianapolis, IN) 2021
#> 56        105 Pepperdine 84, 160 Coastal Carolina 61 (Daytona Beach, FL) 2021
#> 57                   7 Ohio St. 87, 12 Purdue 78 (OT) (Indianapolis, IN) 2021
#> 58                             6 USC 82, 15 Oregon 68 (Indianapolis, IN) 2021
#> 59                       4 Baylor 79, 192 Hartford 55 (Indianapolis, IN) 2021
#> 60                          7 Alabama 68, 183 Iona 55 (Indianapolis, IN) 2021
#> 61                 9 Loyola Chicago 71, 2 Illinois 58 (Indianapolis, IN) 2021
#> 62                 83 Louisiana Tech 76, 75 Colorado St. 74 (Frisco, TX) 2021
#> 63                  16 Florida St. 71, 10 Colorado 53 (Indianapolis, IN) 2021
#> 64                 79 Mississippi St. 74, 46 Saint Louis 68 (Frisco, TX) 2021
#> 65                   13 Arkansas 68, 14 Texas Tech 66 (Indianapolis, IN) 2021
#> 66          151 Oral Roberts 75, 7 Ohio St. 72 (OT) (West Lafayette, IN) 2021
#> 67              69 Wichita St. 68, 180 South Florida 67 (Fort Worth, TX) 2021
#> 68                 83 Louisiana Tech 76, 75 Colorado St. 74 (Frisco, TX) 2021
#> 69                      1 Gonzaga 83, 20 Creighton 65 (Indianapolis, IN) 2021
#> 70               63 Oregon St. 80, 29 Oklahoma St. 70 (Indianapolis, IN) 2021
#> 71                             9 USC 85, 18 Kansas 51 (Indianapolis, IN) 2021
#> 72                 79 Mississippi St. 74, 46 Saint Louis 68 (Frisco, TX) 2021
#> 73              74 UC Santa Barbara 79, 106 UC Irvine 63 (Las Vegas, NV) 2021
#> 74                     32 Memphis 77, 62 Mississippi St. 64 (Frisco, TX) 2021
#> 75                         8 Alabama 73, 20 Tennessee 68 (Nashville, TN) 2021
#> 76                         112 Cincinnati 74, 54 SMU 71 (Fort Worth, TX) 2021
#> 77                          6 Houston 76, 40 Memphis 74 (Fort Worth, TX) 2021
#> 78                       4 Houston 62, 37 Syracuse 46 (Indianapolis, IN) 2021
#> 79                     32 Memphis 77, 62 Mississippi St. 64 (Frisco, TX) 2021
#> 80                        20 Creighton 72, 76 Ohio 58 (Indianapolis, IN) 2021
#> 81                     32 Memphis 77, 62 Mississippi St. 64 (Frisco, TX) 2021
#> 82                                                             Last Game 2021
#> 83                           3 Illinois 82, 4 Iowa 71 (Indianapolis, IN) 2021
#> 84                        5 Houston 63, 34 Rutgers 60 (Indianapolis, IN) 2021
#> 85             229 Montana St. 80, 138 Southern Utah 77 (OT) (Boise, ID) 2021
#> 86                          82 Ohio 62, 13 Virginia 58 (Bloomington, IN) 2021
#> 87                         72 N.C. State 75, 55 Davidson 61 (Denton, TX) 2021
#> 88                              40 Memphis 71, 83 Dayton 60 (Denton, TX) 2021
#> 89              74 UC Santa Barbara 79, 106 UC Irvine 63 (Las Vegas, NV) 2021
#> 90            20 Creighton 63, 71 UC Santa Barbara 62 (Indianapolis, IN) 2021
#> 91             78 Louisiana Tech 72, 92 Western Kentucky 65 (Frisco, TX) 2021
#> 92                             40 Memphis 70, 99 UCF 62 (Fort Worth, TX) 2021
#> 93                  77 North Texas 54, 81 Louisiana Tech 48 (Frisco, TX) 2021
#> 94              74 UC Santa Barbara 79, 106 UC Irvine 63 (Las Vegas, NV) 2021
#> 95                   8 Alabama 85, 68 Mississippi St. 48 (Nashville, TN) 2021
#> 96                    76 Mississippi St. 68, 63 Richmond 67 (Denton, TX) 2021
#> 97        105 Pepperdine 84, 160 Coastal Carolina 61 (Daytona Beach, FL) 2021
#> 98                 135 Oral Roberts 81, 37 Florida 78 (Indianapolis, IN) 2021
#> 99                     53 Syracuse 89, 65 N.C. State 68 (Greensboro, NC) 2021
#> 100                     98 Western Kentucky 80, 160 UTSA 67 (Frisco, TX) 2021
#> 101                       86 Colgate 85, 210 Loyola MD 72 (Hamilton, NY) 2021
#> 102             69 Wichita St. 68, 180 South Florida 67 (Fort Worth, TX) 2021
#> 103                             40 Memphis 71, 83 Dayton 60 (Denton, TX) 2021
#> 104          211 Oakland 69, 188 Northern Kentucky 58 (Indianapolis, IN) 2021
#> 105            110 Eastern Washington 65, 223 Montana St. 55 (Boise, ID) 2021
#> 106                     63 Buffalo 81, 101 Akron 74 (OT) (Cleveland, OH) 2021
#> 107                       86 Colgate 85, 210 Loyola MD 72 (Hamilton, NY) 2021
#> 108                            83 Ohio 84, 59 Buffalo 69 (Cleveland, OH) 2021
#> 109                   39 Utah St. 62, 59 Colorado St. 50 (Las Vegas, NV) 2021
#> 110                    185 Iona 60, 308 Fairfield 51 (Atlantic City, NJ) 2021
#> 111         200 Norfolk St. 54, 208 Appalachian St. 53 (Bloomington, IN) 2021
#> 112                  76 North Texas 61, 153 Old Dominion 55 (Frisco, TX) 2021
#> 113                        136 Mercer 62, 125 Wofford 61 (Asheville, NC) 2021
#> 114                          39 Memphis 59, 59 Boise St. 56 (Denton, TX) 2021
#> 115       105 Pepperdine 84, 160 Coastal Carolina 61 (Daytona Beach, FL) 2021
#> 116                        17 Creighton 87, 108 Butler 56 (New York, NY) 2021
#> 117                          16 USC 91, 75 Utah 85 (2OT) (Las Vegas, NV) 2021
#> 118                  53 Drake 53, 74 Wichita St. 52 (West Lafayette, IN) 2021
#> 119            155 New Mexico St. 78, 205 Utah Valley 62 (Las Vegas, NV) 2021
#> 120           312 Fairfield 52, 208 Saint Peter's 47 (Atlantic City, NJ) 2021
#> 121                        149 VMI 91, 87 Furman 90 (OT) (Asheville, NC) 2021
#> 122        128 East Tennessee St. 63, 152 Chattanooga 53 (Asheville, NC) 2021
#> 123                                                            Last Game 2021
#> 124           77 Louisiana Tech 75, 183 Florida Atlantic 69 (Frisco, TX) 2021
#> 125             31 North Carolina 101, 68 Notre Dame 59 (Greensboro, NC) 2021
#> 126                    66 Colorado St. 65, 68 N.C. State 61 (Frisco, TX) 2021
#> 127                  184 Bryant 85, 311 Sacred Heart 55 (Smithfield, RI) 2021
#> 128                       220 Loyola MD 67, 188 Army 63 (West Point, NY) 2021
#> 129                  59 Richmond 79, 111 Massachusetts 65 (Richmond, VA) 2021
#> 130                   238 Seattle 83, 230 Cal Baptist 66 (Las Vegas, NV) 2021
#> 131              157 Cleveland St. 80, 201 Oakland 69 (Indianapolis, IN) 2021
#> 132                             87 Ohio 87, 60 Toledo 80 (Cleveland, OH) 2021
#> 133                       67 Buffalo 74, 142 Miami OH 63 (Cleveland, OH) 2021
#> 134                121 Eastern Washington 78, 192 Montana 50 (Boise, ID) 2021
#> 135            229 Montana St. 80, 138 Southern Utah 77 (OT) (Boise, ID) 2021
#> 136                       86 Colgate 85, 210 Loyola MD 72 (Hamilton, NY) 2021
#> 137                   76 Mississippi St. 68, 63 Richmond 67 (Denton, TX) 2021
#> 138                         6 Houston 77, 143 Tulane 52 (Fort Worth, TX) 2021
#> 139                    185 Iona 60, 308 Fairfield 51 (Atlantic City, NJ) 2021
#> 140                         149 Tulane 77, 119 Tulsa 70 (Fort Worth, TX) 2021
#> 141                                  96 UAB 73, 186 Rice 60 (Frisco, TX) 2021
#> 142                121 Eastern Washington 78, 192 Montana 50 (Boise, ID) 2021
#> 143        168 Northeastern 63, 291 William & Mary 47 (Harrisonburg, VA) 2021
#> 144           312 Fairfield 52, 208 Saint Peter's 47 (Atlantic City, NJ) 2021
#> 145                253 Longwood 77, 214 UNC Asheville 61 (Asheville, NC) 2021
#> 146              76 UC Santa Barbara 71, 216 UC Davis 55 (Las Vegas, NV) 2021
#> 147                   105 Akron 74, 121 Bowling Green 67 (Cleveland, OH) 2021
#> 148                        222 Loyola MD 76, 145 Navy 68 (Annapolis, MD) 2021
#> 149                              61 Boise St. 85, 59 SMU 84 (Frisco, TX) 2021
#> 150                 219 Elon 72, 174 James Madison 71 (Harrisonburg, VA) 2021
#> 151                  76 North Texas 61, 153 Old Dominion 55 (Frisco, TX) 2021
#> 152                   59 Toledo 91, 144 Ball St. 89 (OT) (Cleveland, OH) 2021
#> 153                109 UC Irvine 78, 104 UC Riverside 61 (Las Vegas, NV) 2021
#> 154                             50 VCU 64, 56 Davidson 52 (Richmond, VA) 2021
#> 155               216 Saint Peter's 75, 313 Rider 60 (Atlantic City, NJ) 2021
#> 156              140 Georgia St. 71, 258 Arkansas St. 68 (Pensacola, FL) 2021
#> 157     163 Coastal Carolina 77, 231 Stetson 72 (OT) (Daytona Beach, FL) 2021
#> 158              86 Belmont 72, 155 Jacksonville St. 69 (Evansville, IN) 2021
#> 159           227 Mount St. Mary's 73, 167 Bryant 68 (Staten Island, NY) 2021
#> 160                     98 Abilene Christian 93, 308 Lamar 71 (Katy, TX) 2021
#> 161             345 Houston Baptist 80, 340 Incarnate Word 68 (Katy, TX) 2021
#> 162                    324 Hampton 67, 329 Presbyterian 65 (Hampton, VA) 2021
#> 163              76 UC Santa Barbara 71, 216 UC Davis 55 (Las Vegas, NV) 2021
#> 164                                                            Last Game 2021
#> 165                       220 Loyola MD 67, 188 Army 63 (West Point, NY) 2021
#> 166              80 North Texas 76, 305 Middle Tennessee 56 (Frisco, TX) 2021
#> 167          211 Oakland 69, 188 Northern Kentucky 58 (Indianapolis, IN) 2021
#> 168                  211 Norfolk St. 71, 224 Morgan St. 63 (Norfolk, VA) 2021
#> 169                     98 Abilene Christian 93, 308 Lamar 71 (Katy, TX) 2021
#> 170                       67 Buffalo 74, 142 Miami OH 63 (Cleveland, OH) 2021
#> 171       268 Western Michigan 73, 331 Northern Illinois 63 (DeKalb, IL) 2021
#> 172       145 North Dakota St. 79, 172 South Dakota 75 (Sioux Falls, SD) 2021
#> 173              80 North Texas 76, 305 Middle Tennessee 56 (Frisco, TX) 2021
#> 174                       89 Colgate 105, 266 Bucknell 75 (Hamilton, NY) 2021
#> 175             207 Oakland 87, 226 Youngstown St. 83 (OT) (Oakland, MI) 2021
#> 176                109 UC Irvine 78, 104 UC Riverside 61 (Las Vegas, NV) 2021
#> 177             199 Hartford 64, 222 UMass Lowell 50 (West Hartford, CT) 2021
#> 178                     99 UCF 72, 157 East Carolina 62 (Fort Worth, TX) 2021
#> 179                        12 Ohio St. 83, 46 Penn St. 79 (Columbus, OH) 2021
#> 180        244 UC San Diego 85, 253 Cal St. Fullerton 78 (San Diego, CA) 2021
#> 181                  211 Norfolk St. 71, 224 Morgan St. 63 (Norfolk, VA) 2021
#> 182        72 UC Santa Barbara 95, 256 Long Beach St. 87 (Las Vegas, NV) 2021
#> 183                           224 UC Davis 74, 193 Hawaii 66 (Davis, CA) 2021
#> 184       12 Loyola Chicago 73, 191 Southern Illinois 49 (St. Louis, MO) 2021
#> 185        159 North Dakota St. 89, 171 South Dakota 77 (Vermillion, SD) 2021
#> 186               151 Ball St. 100, 262 Eastern Michigan 65 (Muncie, IN) 2021
#> 187      187 Northern Kentucky 70, 141 Detroit 69 (Highland Heights, KY) 2021
#> 188                       89 Colgate 105, 266 Bucknell 75 (Hamilton, NY) 2021
#> 189                          48 Utah St. 74, 164 UNLV 53 (Las Vegas, NV) 2021
#> 190       122 Eastern Washington 66, 331 Northern Arizona 60 (Boise, ID) 2021
#> 191                  130 Grand Canyon 81, 223 Seattle 47 (Las Vegas, NV) 2021
#> 192             199 Hartford 64, 222 UMass Lowell 50 (West Hartford, CT) 2021
#> 193     108 UNC Greensboro 77, 124 East Tennessee St. 65 (Asheville, NC) 2021
#> 194        128 East Tennessee St. 63, 152 Chattanooga 53 (Asheville, NC) 2021
#> 195                         225 Radford 67, 325 Hampton 52 (Radford, VA) 2021
#> 196                          73 Buffalo 81, 88 Kent St. 67 (Buffalo, NY) 2021
#> 197               199 Army 57, 265 Boston University 55 (West Point, NY) 2021
#> 198   299 North Alabama 96, 276 Florida Gulf Coast 81 (Jacksonville, FL) 2021
#> 199            155 New Mexico St. 78, 205 Utah Valley 62 (Las Vegas, NV) 2021
#> 200 336 Northern Illinois 79, 263 Central Michigan 74 (Mt. Pleasant, MI) 2021
#> 201               216 Saint Peter's 75, 313 Rider 60 (Atlantic City, NJ) 2021
#> 202        219 Appalachian St. 76, 182 Texas St. 73 (OT) (Pensacola, FL) 2021
#> 203                     310 Troy 91, 242 UT Arlington 86 (Pensacola, FL) 2021
#> 204               221 Campbell 63, 174 Gardner Webb 57 (Buies Creek, NC) 2021
# }
```
