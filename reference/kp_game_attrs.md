# **Get Game Attributes**

**Get Game Attributes**

## Usage

``` r
kp_game_attrs(year = most_recent_mbb_season(), attr = "Excitement")
```

## Arguments

- year:

  Year of data to pull

- attr:

  Game Attribute, valid values include:  
  'Excitement', 'Tension','Dominance','MinWp','FanMatch',  
  'Upsets','Busts','Comeback','Window'

## Value

Returns a tibble with game attributes

|            |           |               |
|------------|-----------|---------------|
| col_name   | types     | description   |
| rk         | integer   | Rk.           |
| data       | character | Data.         |
| game       | character | Game.         |
| location   | character | Location.     |
| conf       | character | character.    |
| excitement | numeric   | Excitement.   |
| year       | numeric   | 4-digit year. |

## See also

Other KP Misc. Functions:
[`kp_arenas()`](https://hoopR.sportsdataverse.org/reference/kp_arenas.md),
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_game_attrs(year = 2021, attr = "Excitement"))
#>      rk       data                                                         game
#> 1     1 Wed Nov 25               108 Georgia St. 123, 72 Georgia Tech 120 (4OT)
#> 2     2  Sun Dec 6          184 Western Carolina 76, 321 Tennessee Tech 75 (OT)
#> 3     3 Sun Dec 27                         63 Providence 95, 86 DePaul 90 (2OT)
#> 4     4  Sat Jan 2                   25 Arizona 86, 132 Washington St. 82 (2OT)
#> 5     5  Mon Feb 8                          157 Mercer 89, 251 Samford 82 (2OT)
#> 6     6 Sat Feb 27                 328 Lamar 88, 153 Stephen F. Austin 83 (2OT)
#> 7     7 Fri Nov 27                          109 Santa Clara 66, 205 UC Davis 63
#> 8     8 Sun Dec 13                      96 Georgetown 97, 86 St. John's 94 (OT)
#> 9     9 Sat Feb 20                       231 Milwaukee 89, 214 Oakland 87 (2OT)
#> 10   10 Fri Nov 27                                30 Syracuse 85, 312 Bryant 84
#> 11   11 Wed Feb 24                       134 Mercer 81, 152 Chattanooga 77 (OT)
#> 12   12 Sat Feb 27                      40 Oklahoma St. 94, 31 Oklahoma 90 (OT)
#> 13   13  Tue Mar 2                        3 Baylor 94, 19 West Virginia 89 (OT)
#> 14   14 Fri Nov 27                         40 UCLA 107, 100 Pepperdine 98 (3OT)
#> 15   15  Sat Jan 9                                  25 Alabama 94, 81 Auburn 90
#> 16   16  Sat Feb 6                        38 Oklahoma St. 75, 12 Texas 67 (2OT)
#> 17   17 Sat Feb 13                    23 Oklahoma 91, 16 West Virginia 90 (2OT)
#> 18   18  Sun Jan 3               75 Rhode Island 85, 178 Saint Joseph's 77 (OT)
#> 19   19 Sat Jan 16        177 Eastern Kentucky 93, 226 Eastern Illinois 85 (OT)
#> 20   20 Sat Feb 20                  102 Washington St. 85, 57 Stanford 76 (3OT)
#> 21   21 Sat Jan 30                 86 UC Santa Barbara 89, 214 UC Davis 86 (OT)
#> 22   22 Fri Jan 15                      259 Utah Valley 93, 282 Seattle 92 (OT)
#> 23   23  Fri Jan 1       253 Long Beach St. 90, 159 Cal St. Bakersfield 89 (OT)
#> 24   24  Sat Jan 2                            175 Wyoming 78, 180 Fresno St. 74
#> 25   25  Fri Jan 8                        274 Green Bay 84, 270 Oakland 81 (OT)
#> 26   26  Wed Jan 6                                26 LSU 94, 91 Georgia 92 (OT)
#> 27   27  Sat Feb 6                       217 Charleston 90, 272 Towson 88 (2OT)
#> 28   28 Sat Jan 30                            80 Wichita St. 93, 96 UCF 88 (OT)
#> 29   29 Sat Dec 12                    62 Dayton 85, 79 Mississippi St. 82 (2OT)
#> 30   30 Wed Dec 30              139 George Mason 93, 120 Massachusetts 92 (2OT)
#> 31   31 Sat Feb 13                     225 Lafayette 97, 251 Loyola MD 94 (3OT)
#> 32   32  Sat Jan 2                         292 Lehigh 90, 230 Lafayette 89 (OT)
#> 33   33 Fri Mar 12               250 Texas Southern 84, 275 Jackson St. 81 (OT)
#> 34   34  Tue Mar 2       153 Cleveland St. 108, 277 Purdue Fort Wayne 104 (3OT)
#> 35   35 Fri Feb 26                     251 UT Arlington 73, 252 Arkansas St. 71
#> 36   36 Sun Jan 17                         335 Coppin St. 89, 266 Morgan St. 79
#> 37   37 Thu Feb 25             288 Purdue Fort Wayne 89, 236 Green Bay 84 (2OT)
#> 38   38 Fri Jan 22               221 Illinois Chicago 67, 261 Youngstown St. 66
#> 39   39 Thu Nov 26                     66 Auburn 96, 164 Saint Joseph's 91 (OT)
#> 40   40 Fri Nov 27                                  16 Illinois 77, 128 Ohio 75
#> 41   41  Fri Mar 5               108 UC Riverside 72, 284 Cal St. Northridge 68
#> 42   42  Sat Feb 6                    35 Virginia Tech 80, 118 Miami FL 76 (OT)
#> 43   43 Thu Jan 28                    181 Fresno St. 64, 281 New Mexico 62 (OT)
#> 44   44  Fri Mar 5                 112 UC Irvine 71, 278 Long Beach St. 68 (OT)
#> 45   45 Fri Mar 12                229 Montana St. 80, 138 Southern Utah 77 (OT)
#> 46   46 Sat Feb 27               201 Nicholls St. 105, 300 New Orleans 101 (OT)
#> 47   47  Thu Jan 7        176 Eastern Kentucky 69, 230 Jacksonville St. 66 (OT)
#> 48   48  Fri Jan 1                                     256 Rice 95, 174 UTSA 86
#> 49   49  Sat Jan 9                 168 UT Arlington 75, 295 Louisiana Monroe 74
#> 50   50 Wed Nov 25                146 Loyola Marymount 85, 187 Southern Utah 83
#> 51   51 Sun Jan 24                      255 American 81, 247 Loyola MD 79 (3OT)
#> 52   52 Sun Dec 20                      63 Providence 80, 46 Seton Hall 77 (OT)
#> 53   53 Wed Nov 25                       71 St. John's 76, 186 Saint Peter's 75
#> 54   54  Sun Mar 7         222 Appalachian St. 64, 166 Coastal Carolina 61 (OT)
#> 55   55  Mon Mar 8                            20 BYU 82, 116 Pepperdine 77 (OT)
#> 56   56 Wed Mar 10                    115 Arizona St. 64, 107 Washington St. 59
#> 57   57 Sat Jan 16                              145 Akron 95, 68 Toledo 94 (OT)
#> 58   58 Wed Feb 24                              105 Cincinnati 70, 111 Tulsa 69
#> 59   59  Fri Jan 8                           212 Lipscomb 77, 263 Bellarmine 72
#> 60   60 Sat Feb 13      199 Nicholls St. 86, 330 Southeastern Louisiana 84 (OT)
#> 61   61 Thu Feb 18                  326 Tennessee St. 91, 325 Tennessee Tech 86
#> 62   62 Sat Feb 20                               239 The Citadel 75, 151 VMI 74
#> 63   63 Sun Jan 17                 234 Norfolk St. 83, 352 Delaware St. 79 (OT)
#> 64   64 Sat Feb 27              169 Northern Iowa 94, 193 Illinois St. 87 (2OT)
#> 65   65  Tue Mar 2                   147 Miami OH 84, 115 Bowling Green 79 (OT)
#> 66   66 Wed Feb 24               270 Western Carolina 81, 106 UNC Greensboro 80
#> 67   67 Wed Jan 13                                   134 Wofford 80, 244 VMI 78
#> 68   68  Sat Apr 3                                1 Gonzaga 93, 15 UCLA 90 (OT)
#> 69   69 Sat Dec 12                         105 South Florida 58, 135 Wofford 56
#> 70   70 Thu Dec 10                      281 Portland 87, 122 Oregon St. 86 (OT)
#> 71   71 Mon Feb 22 328 Southeastern Louisiana 78, 337 Texas A&M Corpus Chris 75
#> 72   72  Sat Jan 2                         63 Boise St. 87, 314 San Jose St. 86
#> 73   73  Tue Dec 8                   44 Minnesota 85, 85 Boston College 80 (OT)
#> 74   74 Sat Jan 30                    307 Fairleigh Dickinson 81, 178 Bryant 79
#> 75   75 Sat Feb 20                  213 Saint Joseph's 91, 186 La Salle 82 (OT)
#> 76   76 Sat Feb 27                  232 Prairie View A&M 55, 347 Alabama A&M 54
#> 77   77 Sat Feb 13                  212 UC Davis 78, 275 Long Beach St. 76 (OT)
#> 78   78 Sat Nov 28             141 Washington St. 71, 143 Eastern Washington 68
#> 79   79 Sun Mar 14                                      8 Alabama 80, 29 LSU 79
#> 80   80 Sat Jan 30                           32 Oklahoma St. 81, 34 Arkansas 77
#> 81   81 Sat Dec 12                   211 South Alabama 76, 307 Southern Miss 75
#> 82   82  Sat Dec 5              157 Eastern Illinois 93, 278 Green Bay 91 (2OT)
#> 83   83  Fri Feb 5                      315 North Dakota 85, 340 Denver 82 (OT)
#> 84   84 Sun Nov 29                           343 Alabama A&M 78, 309 Samford 76
#> 85   85 Sun Jan 24                                137 Washington 83, 72 Utah 79
#> 86   86 Sat Feb 13                          25 Arkansas 86, 38 Missouri 81 (OT)
#> 87   87  Sat Jan 2                                     5 Iowa 77, 19 Rutgers 75
#> 88   88 Sat Feb 27                         316 Nebraska Omaha 80, 345 Denver 76
#> 89   89 Thu Jan 21                             30 Arizona 84, 73 Arizona St. 82
#> 90   90 Mon Dec 14                              126 Nevada 79, 158 San Diego 72
#> 91   91  Fri Feb 5             253 Youngstown St. 84, 268 Robert Morris 78 (OT)
#> 92   92  Sat Mar 6       285 New Orleans 81, 336 Southeastern Louisiana 76 (OT)
#> 93   93  Sat Jan 2                   324 Northern Arizona 83, 342 Idaho 78 (OT)
#> 94   94 Mon Nov 30                   63 Xavier 99, 204 Eastern Kentucky 96 (OT)
#> 95   95  Mon Feb 1                  232 Western Carolina 76, 290 The Citadel 75
#> 96   96 Sat Jan 30                              47 BYU 95, 132 Pacific 87 (2OT)
#> 97   97  Sat Feb 6                      342 Denver 85, 314 North Dakota 81 (OT)
#> 98   98 Tue Dec 15            304 St. Francis NY 91, 338 Central Connecticut 86
#> 99   99  Tue Jan 5                         32 North Carolina 67, 65 Miami FL 65
#> 100 100 Sun Dec 20                      14 Creighton 76, 45 Connecticut 74 (OT)
#>                                               location   conf excitement year
#> 1                      Atlanta, GA (McCamish Pavilion)              4.74 2021
#> 2                        Cullowhee, NC (Ramsey Center)              3.84 2021
#> 3                         Providence, RI (Alumni Hall)     BE       3.67 2021
#> 4                       Pullman, WA (Beasley Coliseum)    P12       3.65 2021
#> 5                            Macon, GA (Hawkins Arena)     SC       3.63 2021
#> 6                       Beaumont, TX (Montagne Center)   Slnd       3.59 2021
#> 7                      Santa Clara, CA (Leavey Center)              3.58 2021
#> 8                     Washington, DC (McDonough Arena)     BE       3.53 2021
#> 9                    Milwaukee, WI (UWM Panther Arena)   Horz       3.49 2021
#> 10                         Syracuse, NY (Carrier Dome)              3.46 2021
#> 11                           Macon, GA (Hawkins Arena)     SC       3.44 2021
#> 12                     Norman, OK (Lloyd Noble Center)    B12       3.44 2021
#> 13                       Morgantown, WV (WVU Coliseum)    B12       3.44 2021
#> 14                        San Diego, CA (Viejas Arena)              3.42 2021
#> 15                           Auburn, AL (Auburn Arena)    SEC       3.41 2021
#> 16                Stillwater, OK (Gallagher-Iba Arena)    B12       3.41 2021
#> 17                       Morgantown, WV (WVU Coliseum)    B12       3.40 2021
#> 18                          Kingston, RI (Ryan Center)    A10       3.39 2021
#> 19                        Charleston, IL (Lantz Arena)    OVC       3.39 2021
#> 20                      Pullman, WA (Beasley Coliseum)    P12       3.36 2021
#> 21                            Davis, CA (The Pavilion)     BW       3.36 2021
#> 22                        Seattle, WA (Redhawk Center)    WAC       3.35 2021
#> 23                 Long Beach, CA (The Walter Pyramid)     BW       3.33 2021
#> 24                       Fresno, CA (Save Mart Center)    MWC       3.32 2021
#> 25                        Green Bay, WI (Resch Center)   Horz       3.32 2021
#> 26          Baton Rouge, LA (Maravich Assembly Center)    SEC       3.31 2021
#> 27                           Charleston, SC (TD Arena)    CAA       3.29 2021
#> 28                    Wichita, KS (Charles Koch Arena)   Amer       3.28 2021
#> 29                      Atlanta, GA (State Farm Arena)              3.26 2021
#> 30                        Amherst, MA (Mullins Center)    A10       3.25 2021
#> 31                    Easton, PA (Kirby Sports Center)    Pat       3.24 2021
#> 32                       Bethlehem, PA (Stabler Arena)    Pat       3.23 2021
#> 33                       Birmingham, AL (Bartow Arena) SWAC-T       3.23 2021
#> 34                     Cleveland, OH (Wolstein Center) Horz-T       3.23 2021
#> 35                 Arlington, TX (College Park Center)     SB       3.23 2021
#> 36                    Baltimore, MD (Hill Field House)   MEAC       3.19 2021
#> 37                        Green Bay, WI (Resch Center) Horz-T       3.19 2021
#> 38  Youngstown, OH (Beeghly Physical Education Center)   Horz       3.18 2021
#> 39        Fort Myers, FL (Suncoast Credit Union Arena)              3.18 2021
#> 40                   Champaign, IL (State Farm Center)              3.16 2021
#> 41                           Northridge, CA (Matadome)     BW       3.16 2021
#> 42                    Coral Gables, FL (Watsco Center)    ACC       3.16 2021
#> 43                       Fresno, CA (Save Mart Center)    MWC       3.15 2021
#> 44                 Long Beach, CA (The Walter Pyramid)     BW       3.15 2021
#> 45                     Boise, ID (Idaho Central Arena) BSky-T       3.15 2021
#> 46                   New Orleans, LA (Lakefront Arena)   Slnd       3.15 2021
#> 47                       Richmond, KY (McBrayer Arena)    OVC       3.14 2021
#> 48                      Houston, TX (Tudor Fieldhouse)   CUSA       3.14 2021
#> 49                    Monroe, LA (Fant-Ewing Coliseum)     SB       3.13 2021
#> 50                  Los Angeles, CA (Gersten Pavilion)              3.12 2021
#> 51                         Baltimore, MD (Reitz Arena)    Pat       3.12 2021
#> 52                      Newark, NJ (Prudential Center)     BE       3.11 2021
#> 53                      Jamaica, NY (Carnesecca Arena)              3.11 2021
#> 54                Pensacola, FL (Pensacola Bay Center)   SB-T       3.11 2021
#> 55                       Las Vegas, NV (Orleans Arena)  WCC-T       3.10 2021
#> 56                      Las Vegas, NV (T-Mobile Arena)  P12-T       3.10 2021
#> 57                            Akron, OH (Rhodes Arena)    MAC       3.09 2021
#> 58                         Tulsa, OK (Reynolds Center)   Amer       3.09 2021
#> 59                       Louisville, KY (Freedom Hall)   ASun       3.09 2021
#> 60                     Hammond, LA (University Center)   Slnd       3.09 2021
#> 61                       Nashville, TN (Gentry Center)    OVC       3.09 2021
#> 62              Charleston, SC (McAlister Field House)     SC       3.05 2021
#> 63                           Dover, DE (Memorial Hall)   MEAC       3.05 2021
#> 64                          Normal, IL (Redbird Arena)    MVC       3.04 2021
#> 65                    Bowling Green, OH (Stroh Center)    MAC       3.04 2021
#> 66                Greensboro, NC (Greensboro Coliseum)     SC       3.03 2021
#> 67                        Lexington, VA (Cameron Hall)     SC       3.03 2021
#> 68                Indianapolis, IN (Lucas Oil Stadium)   NCAA       3.02 2021
#> 69                      Atlanta, GA (State Farm Arena)              3.02 2021
#> 70                       Corvallis, OR (Gill Coliseum)              3.01 2021
#> 71           Corpus Christi, TX (American Bank Center)   Slnd       2.98 2021
#> 72                             Phoeniz, AZ (GCU Arena)    MWC       2.98 2021
#> 73                    Minneapolis, MN (Williams Arena)              2.97 2021
#> 74                        Teaneck, NJ (Rothman Center)    NEC       2.95 2021
#> 75       Philadelphia, PA (Michael J. Hagan '85 Arena)    A10       2.95 2021
#> 76                       Normal, AL (Elmore Gymnasium)   SWAC       2.94 2021
#> 77                            Davis, CA (The Pavilion)     BW       2.94 2021
#> 78                      Pullman, WA (Beasley Coliseum)              2.94 2021
#> 79                   Nashville, TN (Bridgestone Arena)  SEC-T       2.94 2021
#> 80                Stillwater, OK (Gallagher-Iba Arena)              2.94 2021
#> 81               Hattiesburg, MS (Reed Green Coliseum)              2.94 2021
#> 82                        Green Bay, WI (Resch Center)              2.94 2021
#> 83                     Denver, CO (Hamilton Gymnasium)    Sum       2.94 2021
#> 84                         Homewood, AL (Hanna Center)              2.94 2021
#> 85                 Seattle, WA (Alaska Airlines Arena)    P12       2.93 2021
#> 86                         Columbia, MO (Mizzou Arena)    SEC       2.93 2021
#> 87            Piscataway, NJ (Rutgers Athletic Center)    B10       2.93 2021
#> 88                     Denver, CO (Hamilton Gymnasium)    Sum       2.92 2021
#> 89                  Tempe, AZ (Desert Financial Arena)    P12       2.91 2021
#> 90                San Diego, CA (Jenny Craig Pavilion)              2.90 2021
#> 91              Moon Township, PA (UPMC Events Center)   Horz       2.90 2021
#> 92                   New Orleans, LA (Lakefront Arena)   Slnd       2.90 2021
#> 93                           Moscow, ID (Memorial Gym)   BSky       2.90 2021
#> 94                      Cincinnati, OH (Cintas Center)              2.90 2021
#> 95                       Cullowhee, NC (Ramsey Center)     SC       2.89 2021
#> 96                         Provo, UT (Marriott Center)    WCC       2.89 2021
#> 97                     Denver, CO (Hamilton Gymnasium)    Sum       2.88 2021
#> 98                 New Britain, CT (Detrick Gymnasium)    NEC       2.88 2021
#> 99                    Coral Gables, FL (Watsco Center)    ACC       2.88 2021
#> 100                       Storrs, CT (Gampel Pavilion)     BE       2.88 2021
# }
```
