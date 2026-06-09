# **Get 2-Foul Participation Stats**

**Get 2-Foul Participation Stats**

## Usage

``` r
kp_foul_trouble(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of foul participation stats

|  |  |  |
|----|----|----|
| col_name | types | description |
| team | character | Team-side label or team identifier. |
| conf | character | character. |
| two_foul_particpation_pct | numeric | Two foul particpation percentage (0-1 decimal). |
| two_foul_particpation_pct_rk | numeric | Two foul particpation pct rk. |
| adj2fp | numeric | Adj2fp. |
| adj2fp_rk | numeric | Adj2fp rk. |
| two_foul_total_time | character | Time / clock value. |
| two_foul_total_time_rk | character | Two foul total time rk. |
| two_foul_time_on | character | Two foul time on. |
| two_foul_time_on_rk | character | Two foul time on rk. |
| bench_pct | numeric | Bench percentage (0-1 decimal). |
| bench_pct_rk | numeric | Bench pct rk. |
| ncaa_seed | numeric | Ncaa seed. |
| year | integer | 4-digit year. |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_foul_trouble(min_year = 2020, max_year = most_recent_mbb_season()))
#> ✖ 2026-06-09 20:01:45.49498: Invalid arguments or no foul trouble data for 2020 - 2026 available!
#> ✖ Args: min_year = 2020, max_year = 2026
#> ✖ Error: subscript out of bounds
#>                       Team Conf TwoFoulParticpation.Pct
#> 1             Georgia Tech  ACC                    68.7
#> 2                 Ball St.  MAC                    61.2
#> 3                 Delaware  CAA                    57.3
#> 4              Little Rock   SB                    56.4
#> 5                  Oakland Horz                    55.8
#> 6                 Syracuse  ACC                    54.0
#> 7                Merrimack  NEC                    53.6
#> 8         Eastern Michigan  MAC                    52.7
#> 9                     Army  Pat                    52.3
#> 10      Eastern Washington BSky                    52.1
#> 11              Binghamton   AE                    51.3
#> 12           Southern Miss CUSA                    50.9
#> 13              Washington  P12                    49.7
#> 14              Coppin St. MEAC                    49.6
#> 15             McNeese St. Slnd                    48.8
#> 16           San Francisco  WCC                    48.3
#> 17           North Florida ASun                    48.1
#> 18                   IUPUI Horz                    48.0
#> 19               Minnesota  B10                    47.7
#> 20             Florida A&M MEAC                    47.3
#> 21       Northern Kentucky Horz                    46.8
#> 22        Central Michigan  MAC                    45.6
#> 23          Washington St.  P12                    45.0
#> 24                 Fordham  A10                    44.7
#> 25               Louisiana   SB                    44.1
#> 26              New Mexico  MWC                    43.8
#> 27                   Brown  Ivy                    43.7
#> 28                 Detroit Horz                    43.5
#> 29            South Dakota  Sum                    43.2
#> 30          Incarnate Word Slnd                    42.6
#> 31                     FIU CUSA                    42.2
#> 32          Sacramento St. BSky                    42.2
#> 33                  Toledo  MAC                    42.1
#> 34                    Penn  Ivy                    41.8
#> 35        Tennessee Martin  OVC                    41.8
#> 36            Colorado St.  MWC                    41.4
#> 37         Bethune Cookman MEAC                    41.2
#> 38                 Alabama  SEC                    40.7
#> 39     Cal St. Bakersfield  WAC                    40.6
#> 40             The Citadel   SC                    40.4
#> 41              Texas Tech  B12                    38.5
#> 42             Mississippi  SEC                    38.3
#> 43           North Alabama ASun                    38.2
#> 44                 Hampton BSth                    37.9
#> 45                 Seattle  WAC                    37.7
#> 46                  Howard MEAC                    37.4
#> 47                     LIU  NEC                    36.9
#> 48      Cal St. Northridge   BW                    36.6
#> 49                  Tulane Amer                    36.4
#> 50              Pepperdine  WCC                    35.9
#> 51            Rhode Island  A10                    35.7
#> 52                 Cornell  Ivy                    35.5
#> 53                  Furman   SC                    35.4
#> 54                 Georgia  SEC                    35.3
#> 55  North Carolina Central MEAC                    35.3
#> 56        Central Arkansas Slnd                    34.3
#> 57                    NJIT ASun                    34.1
#> 58             Santa Clara  WCC                    34.1
#> 59                  Kansas  B12                    34.0
#> 60                    UTSA CUSA                    33.8
#> 61        Prairie View A&M SWAC                    33.3
#> 62  Mississippi Valley St. SWAC                    33.0
#> 63            North Dakota  Sum                    32.9
#> 64                  Bryant  NEC                    32.9
#> 65           Grambling St. SWAC                    32.7
#> 66          Tennessee Tech  OVC                    32.3
#> 67        Western Carolina   SC                    32.2
#> 68                   Akron  MAC                    32.0
#> 69            Sacred Heart  NEC                    31.6
#> 70                Duquesne  A10                    31.4
#> 71          North Carolina  ACC                    31.4
#> 72                     LSU  SEC                    31.1
#> 73     Arkansas Pine Bluff SWAC                    30.9
#> 74                Lipscomb ASun                    30.8
#> 75                   Maine   AE                    30.3
#> 76                Portland  WCC                    30.1
#> 77             Chicago St.  WAC                    30.0
#> 78              Notre Dame  ACC                    30.0
#> 79            Northeastern  CAA                    30.0
#> 80                    UMBC   AE                    29.6
#> 81          Saint Joseph's  A10                    29.6
#> 82                    UNLV  MWC                    29.5
#> 83            Kennesaw St. ASun                    29.5
#> 84     Fairleigh Dickinson  NEC                    29.4
#> 85          St. Francis PA  NEC                    29.4
#> 86           UNC Asheville BSth                    29.3
#> 87               San Diego  WCC                    29.2
#> 88        Northwestern St. Slnd                    29.2
#> 89            Grand Canyon  WAC                    29.1
#> 90                Utah St.  MWC                    29.1
#> 91            UMass Lowell   AE                    29.0
#> 92               Boise St.  MWC                    28.9
#> 93                  Wagner  NEC                    28.9
#> 94        Northern Arizona BSky                    28.8
#> 95             Alabama A&M SWAC                    28.7
#> 96                  Auburn  SEC                    28.4
#> 97        Georgia Southern   SB                    28.2
#> 98                Canisius MAAC                    28.2
#> 99              Holy Cross  Pat                    28.0
#> 100                  Texas  B12                    28.0
#> 101                   Ohio  MAC                    28.0
#> 102             Fresno St.  MWC                    27.7
#> 103       Louisiana Monroe   SB                    27.7
#> 104          Robert Morris  NEC                    27.7
#> 105      George Washington  A10                    27.5
#> 106               American  Pat                    27.4
#> 107           Presbyterian BSth                    27.4
#> 108              Green Bay Horz                    27.3
#> 109                 Xavier   BE                    27.2
#> 110                 Baylor  B12                    27.1
#> 111             Murray St.  OVC                    27.0
#> 112                Montana BSky                    26.8
#> 113 Southeastern Louisiana Slnd                    26.8
#> 114               Iowa St.  B12                    26.5
#> 115              Creighton   BE                    26.3
#> 116            New Orleans Slnd                    26.3
#> 117               UC Davis   BW                    26.1
#> 118             Pittsburgh  ACC                    26.0
#> 119            Saint Louis  A10                    26.0
#> 120              Tennessee  SEC                    25.9
#> 121           Saint Mary's  WCC                    25.6
#> 122             Quinnipiac MAAC                    25.5
#> 123                Colgate  Pat                    25.5
#> 124         Boston College  ACC                    25.4
#> 125      Cal St. Fullerton   BW                    25.4
#> 126          Cleveland St. Horz                    25.3
#> 127            Cal Baptist  WAC                    25.2
#> 128                 Butler   BE                    25.2
#> 129               Miami FL  ACC                    25.2
#> 130 Texas A&M Corpus Chris Slnd                    25.2
#> 131                Harvard  Ivy                    25.1
#> 132            Jackson St. SWAC                    25.1
#> 133                 Nevada  MWC                    25.1
#> 134          South Alabama   SB                    24.9
#> 135                  Lamar Slnd                    24.8
#> 136               Southern SWAC                    24.8
#> 137       Mount St. Mary's  NEC                    24.7
#> 138       Coastal Carolina   SB                    24.5
#> 139          New Hampshire   AE                    24.4
#> 140 Maryland Eastern Shore MEAC                    24.2
#> 141          Virginia Tech  ACC                    23.8
#> 142               Nebraska  B10                    23.7
#> 143           Portland St. BSky                    23.6
#> 144               Arkansas  SEC                    23.3
#> 145          Tennessee St.  OVC                    23.1
#> 146             Georgetown   BE                    23.1
#> 147             Evansville  MVC                    22.9
#> 148             California  P12                    22.9
#> 149         Long Beach St.   BW                    22.8
#> 150              Villanova   BE                    22.8
#> 151    Charleston Southern BSth                    22.8
#> 152           Oral Roberts  Sum                    22.5
#> 153                  Drake  MVC                    22.4
#> 154           San Jose St.  MWC                    22.4
#> 155         Youngstown St. Horz                    22.3
#> 156              Manhattan MAAC                    22.2
#> 157            Chattanooga   SC                    22.1
#> 158                   Troy   SB                    21.9
#> 159               Monmouth MAAC                    21.9
#> 160             Seton Hall   BE                    21.9
#> 161               Ohio St.  B10                    21.9
#> 162     East Tennessee St.   SC                    21.8
#> 163                   Duke  ACC                    21.6
#> 164             Providence   BE                    21.6
#> 165                   Elon  CAA                    21.5
#> 166             Kansas St.  B12                    21.4
#> 167             Morgan St. MEAC                    21.4
#> 168            North Texas CUSA                    21.3
#> 169                Gonzaga  WCC                    21.2
#> 170              Loyola MD  Pat                    21.1
#> 171             Charleston  CAA                    21.0
#> 172           Missouri St.  MVC                    20.9
#> 173               Missouri  SEC                    20.8
#> 174                Vermont   AE                    20.8
#> 175       Western Kentucky CUSA                    20.6
#> 176               Winthrop BSth                    20.6
#> 177            Connecticut Amer                    20.4
#> 178            Arizona St.  P12                    20.3
#> 179                  Rider MAAC                    20.0
#> 180                Arizona  P12                    20.0
#> 181                 Temple Amer                    20.0
#> 182           Delaware St. MEAC                    19.9
#> 183      Boston University  Pat                    19.9
#> 184              Texas A&M  SEC                    19.8
#> 185                Samford   SC                    19.8
#> 186      Northern Colorado BSky                    19.8
#> 187      Southern Illinois  MVC                    19.8
#> 188               Hartford   AE                    19.6
#> 189                    VMI   SC                    19.4
#> 190              Wisconsin  B10                    19.4
#> 191                   Utah  P12                    19.4
#> 192                Buffalo  MAC                    19.0
#> 193       Western Michigan  MAC                    18.6
#> 194      Abilene Christian Slnd                    18.6
#> 195       Middle Tennessee CUSA                    18.4
#> 196                 Mercer   SC                    18.3
#> 197                 DePaul   BE                    18.3
#> 198        Mississippi St.  SEC                    18.2
#> 199                 Dayton  A10                    18.2
#> 200                Wyoming  MWC                    18.1
#> 201               Penn St.  B10                    17.8
#> 202           Northwestern  B10                    17.6
#> 203                 Towson  CAA                    17.6
#> 204    Central Connecticut  NEC                    17.6
#> 205                Wofford   SC                    17.5
#> 206                  Idaho BSky                    17.5
#> 207                 Denver  Sum                    17.5
#> 208           Morehead St.  OVC                    17.1
#> 209                Pacific  WCC                    17.1
#> 210      Northern Illinois  MAC                    17.0
#> 211              Princeton  Ivy                    17.0
#> 212           Jacksonville ASun                    16.8
#> 213              Milwaukee Horz                    16.6
#> 214                Bradley  MVC                    16.6
#> 215               Stanford  P12                    16.6
#> 216               Kentucky  SEC                    16.5
#> 217           Arkansas St.   SB                    16.5
#> 218         UNC Wilmington  CAA                    16.5
#> 219                   Iona MAAC                    16.4
#> 220          James Madison  CAA                    16.3
#> 221               Kent St.  MAC                    16.3
#> 222                 Purdue  B10                    16.2
#> 223            Stony Brook   AE                    16.0
#> 224               Columbia  Ivy                    16.0
#> 225                Hofstra  CAA                    16.0
#> 226         UNC Greensboro   SC                    15.6
#> 227           Old Dominion CUSA                    15.6
#> 228                 Hawaii   BW                    15.6
#> 229           Gardner Webb BSth                    15.2
#> 230            Austin Peay  OVC                    15.2
#> 231                    UAB CUSA                    15.1
#> 232            Wake Forest  ACC                    15.0
#> 233                Clemson  ACC                    15.0
#> 234              Lafayette  Pat                    14.9
#> 235           Illinois St.  MVC                    14.9
#> 236         Loyola Chicago  MVC                    14.9
#> 237             N.C. State  ACC                    14.7
#> 238        St. Bonaventure  A10                    14.6
#> 239                    BYU  WCC                    14.6
#> 240          Southern Utah BSky                    14.5
#> 241               Longwood BSth                    14.5
#> 242             Valparaiso  MVC                    14.4
#> 243                 Drexel  CAA                    14.2
#> 244             Vanderbilt  SEC                    14.2
#> 245                    TCU  B12                    14.2
#> 246             Cincinnati Amer                    14.0
#> 247        Sam Houston St. Slnd                    14.0
#> 248         Nebraska Omaha  Sum                    14.0
#> 249                 Lehigh  Pat                    13.9
#> 250              Weber St. BSky                    13.8
#> 251               Oklahoma  B12                    13.7
#> 252                   UMKC  WAC                    13.5
#> 253               Bucknell  Pat                    13.4
#> 254           UT Arlington   SB                    13.4
#> 255         Texas Southern SWAC                    13.4
#> 256                 Oregon  P12                    13.3
#> 257                   UCLA  P12                    13.3
#> 258      Stephen F. Austin Slnd                    13.2
#> 259       Eastern Kentucky  OVC                    13.1
#> 260            USC Upstate BSth                    12.9
#> 261                    SMU Amer                    12.8
#> 262               Marshall CUSA                    12.8
#> 263             St. John's   BE                    12.8
#> 264                Stetson ASun                    12.8
#> 265             Wright St. Horz                    12.7
#> 266                    USC  P12                    12.6
#> 267               Miami OH  MAC                    12.6
#> 268           Nicholls St. Slnd                    12.4
#> 269               Maryland  B10                    12.4
#> 270        Appalachian St.   SB                    12.4
#> 271            Georgia St.   SB                    12.3
#> 272            Indiana St.  MVC                    12.2
#> 273           George Mason  A10                    12.2
#> 274          Northern Iowa  MVC                    12.1
#> 275         William & Mary  CAA                    12.1
#> 276              Texas St.   SB                    12.0
#> 277           Oklahoma St.  B12                    12.0
#> 278               Cal Poly   BW                    11.7
#> 279              Idaho St. BSky                    11.7
#> 280             Louisville  ACC                    11.7
#> 281       Loyola Marymount  WCC                    11.7
#> 282                   Yale  Ivy                    11.6
#> 283                  Siena MAAC                    11.6
#> 284       Florida Atlantic CUSA                    11.4
#> 285   UT Rio Grande Valley  WAC                    11.4
#> 286     South Carolina St. MEAC                    11.3
#> 287          San Diego St.  MWC                    11.1
#> 288                Indiana  B10                    11.0
#> 289                Rutgers  B10                    10.9
#> 290              Air Force  MWC                    10.9
#> 291            Utah Valley  WAC                    10.9
#> 292          West Virginia  B12                    10.8
#> 293                 Albany   AE                    10.7
#> 294                   Rice CUSA                    10.7
#> 295     North Carolina A&T MEAC                    10.5
#> 296             Alcorn St. SWAC                    10.3
#> 297                    VCU  A10                    10.1
#> 298                  Tulsa Amer                     9.9
#> 299         Louisiana Tech CUSA                     9.8
#> 300                   Iowa  B10                     9.4
#> 301            Alabama St. SWAC                     9.2
#> 302        Houston Baptist Slnd                     9.1
#> 303         St. Francis NY  NEC                     9.0
#> 304       UC Santa Barbara   BW                     9.0
#> 305                   UTEP CUSA                     8.7
#> 306                Niagara MAAC                     8.5
#> 307                 Marist MAAC                     8.4
#> 308           UC Riverside   BW                     8.3
#> 309       South Dakota St.  Sum                     8.3
#> 310       SIU Edwardsville  OVC                     8.3
#> 311       Jacksonville St.  OVC                     8.2
#> 312                Radford BSth                     8.2
#> 313       Illinois Chicago Horz                     8.0
#> 314              UC Irvine   BW                     8.0
#> 315              Marquette   BE                     7.9
#> 316         South Carolina  SEC                     7.8
#> 317          Massachusetts  A10                     7.8
#> 318                Liberty ASun                     7.6
#> 319               Colorado  P12                     7.5
#> 320 Southeast Missouri St.  OVC                     7.2
#> 321             Oregon St.  P12                     7.0
#> 322            Norfolk St. MEAC                     6.4
#> 323      Purdue Fort Wayne  Sum                     6.2
#> 324          Saint Peter's MAAC                     6.2
#> 325             High Point BSth                     6.1
#> 326              Dartmouth  Ivy                     6.1
#> 327               Virginia  ACC                     6.0
#> 328            Montana St. BSky                     6.0
#> 329               Illinois  B10                     6.0
#> 330               La Salle  A10                     5.9
#> 331                Houston Amer                     5.8
#> 332                Memphis Amer                     5.7
#> 333              Charlotte CUSA                     5.7
#> 334              Fairfield MAAC                     5.7
#> 335         New Mexico St.  WAC                     5.6
#> 336                Florida  SEC                     5.3
#> 337       North Dakota St.  Sum                     5.3
#> 338               Richmond  A10                     4.9
#> 339               Michigan  B10                     4.9
#> 340     Florida Gulf Coast ASun                     4.9
#> 341            Florida St.  ACC                     4.4
#> 342                Belmont  OVC                     4.3
#> 343          Bowling Green  MAC                     4.2
#> 344                   Navy  Pat                     4.2
#> 345               Davidson  A10                     4.0
#> 346       Eastern Illinois  OVC                     4.0
#> 347                    UCF Amer                     3.6
#> 348          South Florida Amer                     3.2
#> 349          East Carolina Amer                     3.1
#> 350            Wichita St. Amer                     2.6
#> 351               Campbell BSth                     2.5
#> 352           Michigan St.  B10                     2.1
#> 353       Western Illinois  Sum                     1.7
#> 354            Alabama A&M SWAC                    85.0
#> 355        Bethune Cookman MEAC                     0.0
#> 356                  Brown  Ivy                     0.0
#> 357               Columbia  Ivy                     0.0
#> 358                Cornell  Ivy                     0.0
#> 359              Dartmouth  Ivy                     0.0
#> 360                Harvard  Ivy                     0.0
#> 361 Maryland Eastern Shore MEAC                     0.0
#> 362                   Penn  Ivy                     0.0
#> 363              Princeton  Ivy                     0.0
#> 364                   Yale  Ivy                     0.0
#> 365                 Howard MEAC                    69.8
#> 366           Georgia Tech  ACC                    66.7
#> 367            Little Rock   SB                    66.3
#> 368                Fordham  A10                    62.9
#> 369              Air Force  MWC                    59.6
#> 370                Detroit Horz                    58.2
#> 371          North Florida ASun                    58.1
#> 372          San Francisco  WCC                    58.0
#> 373               Syracuse  ACC                    56.6
#> 374      Northern Kentucky Horz                    54.8
#> 375               Delaware  CAA                    53.4
#> 376                Oakland Horz                    53.3
#> 377           Oral Roberts  Sum                    53.1
#> 378                 Bryant  NEC                    52.4
#> 379             Alcorn St. SWAC                    51.4
#> 380 Mississippi Valley St. SWAC                    50.3
#> 381       Eastern Michigan  MAC                    50.2
#> 382            Cal Baptist  WAC                    49.0
#> 383                Pacific  WCC                    48.0
#> 384            Florida A&M MEAC                    47.9
#> 385             Coppin St. MEAC                    47.8
#> 386              Merrimack  NEC                    46.9
#> 387            Chicago St.  WAC                    46.6
#> 388                  IUPUI Horz                    46.5
#> 389                 Toledo  MAC                    46.1
#> 390               Ball St.  MAC                    46.1
#> 391       Prairie View A&M SWAC                    46.0
#> 392         St. Francis PA  NEC                    45.3
#> 393     Cal St. Northridge   BW                    44.7
#> 394           Grand Canyon  WAC                    44.1
#> 395           Colorado St.  MWC                    43.8
#> 396                Georgia  SEC                    43.7
#> 397                 Tulane Amer                    43.5
#> 398          Southern Miss CUSA                    42.8
#> 399         Sacramento St. BSky                    42.4
#> 400               Portland  WCC                    42.2
#> 401       Mount St. Mary's  NEC                    41.9
#> 402    Fairleigh Dickinson  NEC                    41.9
#> 403                Samford   SC                    41.9
#> 404           Tarleton St.  WAC                    41.6
#> 405               Iowa St.  B12                    41.4
#> 406           Saint Mary's  WCC                    41.0
#> 407             Notre Dame  ACC                    40.9
#> 408                Hofstra  CAA                    40.9
#> 409      Northern Illinois  MAC                    40.7
#> 410                Wofford   SC                    40.1
#> 411       Central Arkansas Slnd                    39.8
#> 412                   NJIT   AE                    39.2
#> 413 North Carolina Central MEAC                    39.0
#> 414                 Furman   SC                    38.8
#> 415              Manhattan MAAC                    38.6
#> 416            McNeese St. Slnd                    38.0
#> 417             Washington  P12                    38.0
#> 418                Buffalo  MAC                    37.8
#> 419 Southeastern Louisiana Slnd                    37.3
#> 420                Wyoming  MWC                    37.2
#> 421                Seattle  WAC                    36.8
#> 422             Fresno St.  MWC                    36.8
#> 423            Chattanooga   SC                    36.7
#> 424         Youngstown St. Horz                    36.3
#> 425                   Elon  CAA                    36.2
#> 426    Arkansas Pine Bluff SWAC                    36.0
#> 427      Abilene Christian Slnd                    35.9
#> 428             Pepperdine  WCC                    35.9
#> 429            The Citadel   SC                    35.8
#> 430                   UTSA CUSA                    35.6
#> 431        St. Bonaventure  A10                    35.5
#> 432                 Xavier   BE                    35.5
#> 433           UC San Diego   BW                    35.2
#> 434            North Texas CUSA                    35.1
#> 435               American  Pat                    34.9
#> 436                 Wagner  NEC                    34.5
#> 437              Lafayette  Pat                    34.4
#> 438          Robert Morris Horz                    34.2
#> 439             Providence   BE                    34.1
#> 440             Louisville  ACC                    34.1
#> 441                   Army  Pat                    34.1
#> 442       Central Michigan  MAC                    33.9
#> 443          South Alabama   SB                    33.9
#> 444              San Diego  WCC                    33.8
#> 445                    LIU  NEC                    33.5
#> 446           South Dakota  Sum                    33.2
#> 447             Texas Tech  B12                    33.1
#> 448       Loyola Marymount  WCC                    33.1
#> 449                   UNLV  MWC                    33.0
#> 450         Incarnate Word Slnd                    32.9
#> 451             Binghamton   AE                    32.1
#> 452                 Kansas  B12                    32.0
#> 453                   Ohio  MAC                    31.8
#> 454           Northeastern  CAA                    31.8
#> 455               Kent St.  MAC                    31.1
#> 456               Longwood BSth                    30.8
#> 457       Northern Arizona BSky                    30.5
#> 458         UNC Wilmington  CAA                    30.4
#> 459       Western Carolina   SC                    30.3
#> 460                    LSU  SEC                    30.2
#> 461                    VMI   SC                    29.9
#> 462                 Towson  CAA                    29.8
#> 463         Washington St.  P12                    29.7
#> 464             New Mexico  MWC                    29.4
#> 465           Rhode Island  A10                    29.3
#> 466         Boston College  ACC                    29.3
#> 467                 Baylor  B12                    29.2
#> 468      Stephen F. Austin Slnd                    29.2
#> 469         William & Mary  CAA                    29.1
#> 470                  Lamar Slnd                    29.0
#> 471            Arizona St.  P12                    28.2
#> 472               Hartford   AE                    28.0
#> 473              Minnesota  B10                    28.0
#> 474                Rutgers  B10                    27.9
#> 475                  Siena MAAC                    27.8
#> 476          North Alabama ASun                    27.7
#> 477                Arizona  P12                    27.5
#> 478   UT Rio Grande Valley  WAC                    27.5
#> 479                Alabama  SEC                    27.4
#> 480      Boston University  Pat                    27.4
#> 481                 Auburn  SEC                    27.4
#> 482                   UMKC  Sum                    27.3
#> 483                Niagara MAAC                    27.3
#> 484             Morgan St. MEAC                    27.2
#> 485       Middle Tennessee CUSA                    27.2
#> 486            Santa Clara  WCC                    26.8
#> 487              Boise St.  MWC                    26.6
#> 488       Illinois Chicago Horz                    26.2
#> 489      George Washington  A10                    26.1
#> 490                   Duke  ACC                    25.7
#> 491           Missouri St.  MVC                    25.7
#> 492    Charleston Southern BSth                    25.3
#> 493                 Drexel  CAA                    25.3
#> 494          James Madison  CAA                    25.2
#> 495                    FIU CUSA                    25.2
#> 496           Presbyterian BSth                    25.1
#> 497                  Maine   AE                    25.1
#> 498         UNC Greensboro   SC                    25.0
#> 499         Tennessee Tech  OVC                    24.9
#> 500           San Jose St.  MWC                    24.8
#> 501          Grambling St. SWAC                    24.6
#> 502           Kennesaw St. ASun                    24.5
#> 503             Seton Hall   BE                    24.4
#> 504           Oklahoma St.  B12                    24.3
#> 505             Evansville  MVC                    24.2
#> 506           Morehead St.  OVC                    24.1
#> 507           UMass Lowell   AE                    24.1
#> 508             California  P12                    24.1
#> 509               Oklahoma  B12                    24.0
#> 510                  Akron  MAC                    23.9
#> 511               Southern SWAC                    23.9
#> 512                Hampton BSth                    23.8
#> 513         North Carolina  ACC                    23.7
#> 514                    TCU  B12                    23.6
#> 515                Vermont   AE                    23.5
#> 516            Alabama St. SWAC                    23.3
#> 517       Louisiana Monroe   SB                    23.2
#> 518        Mississippi St.  SEC                    22.9
#> 519               Duquesne  A10                    22.9
#> 520          Virginia Tech  ACC                    22.8
#> 521         Long Beach St.   BW                    22.8
#> 522                 Oregon  P12                    22.8
#> 523               Nebraska  B10                    22.8
#> 524               Winthrop BSth                    22.8
#> 525       Florida Atlantic CUSA                    22.7
#> 526                  Rider MAAC                    22.7
#> 527           Illinois St.  MVC                    22.6
#> 528            Georgia St.   SB                    22.4
#> 529    Central Connecticut  NEC                    22.2
#> 530             Charleston  CAA                    22.1
#> 531              Charlotte CUSA                    22.0
#> 532     Eastern Washington BSky                    21.9
#> 533         Saint Joseph's  A10                    21.7
#> 534              Idaho St. BSky                    21.5
#> 535         Nebraska Omaha  Sum                    21.5
#> 536                  Drake  MVC                    21.2
#> 537              Marquette   BE                    21.0
#> 538                 Butler   BE                    20.9
#> 539                 Purdue  B10                    20.9
#> 540               Ohio St.  B10                    20.6
#> 541               UC Davis   BW                    20.3
#> 542            Mississippi  SEC                    20.2
#> 543                 Dayton  A10                    20.1
#> 544            Montana St. BSky                    19.8
#> 545                   UTEP CUSA                    19.6
#> 546           Old Dominion CUSA                    19.6
#> 547               Utah St.  MWC                    19.5
#> 548               Cal Poly   BW                    19.5
#> 549             Georgetown   BE                    19.5
#> 550               Richmond  A10                    19.4
#> 551                 Hawaii   BW                    19.3
#> 552            Jackson St. SWAC                    18.9
#> 553 Texas A&M Corpus Chris Slnd                    18.9
#> 554                    UCF Amer                    18.6
#> 555                 DePaul   BE                    18.5
#> 556             Pittsburgh  ACC                    18.4
#> 557          Tennessee St.  OVC                    18.4
#> 558                Gonzaga  WCC                    18.3
#> 559                 Denver  Sum                    18.2
#> 560         Louisiana Tech CUSA                    18.1
#> 561                  Idaho BSky                    17.9
#> 562           Jacksonville ASun                    17.8
#> 563             Valparaiso  MVC                    17.7
#> 564               Monmouth MAAC                    17.6
#> 565        Sam Houston St. Slnd                    17.6
#> 566               Marshall CUSA                    17.5
#> 567       North Dakota St.  Sum                    17.5
#> 568             N.C. State  ACC                    17.5
#> 569                  Texas  B12                    17.4
#> 570           North Dakota  Sum                    17.4
#> 571             Cincinnati Amer                    17.4
#> 572       UC Santa Barbara   BW                    17.3
#> 573       Eastern Illinois  OVC                    17.3
#> 574              Loyola MD  Pat                    17.3
#> 575          New Hampshire   AE                    17.2
#> 576              Dixie St.  WAC                    17.2
#> 577                Montana BSky                    17.1
#> 578         Texas Southern SWAC                    17.1
#> 579             Quinnipiac MAAC                    16.9
#> 580               Arkansas  SEC                    16.9
#> 581               Missouri  SEC                    16.9
#> 582              Texas St.   SB                    16.6
#> 583                 Nevada  MWC                    16.6
#> 584                  Tulsa Amer                    16.5
#> 585            Saint Louis  A10                    16.4
#> 586                Memphis Amer                    16.2
#> 587              Milwaukee Horz                    16.1
#> 588           Nicholls St. Slnd                    15.9
#> 589           Arkansas St.   SB                    15.8
#> 590           Sacred Heart  NEC                    15.4
#> 591       Coastal Carolina   SB                    15.2
#> 592           Delaware St. MEAC                    15.2
#> 593          Northern Iowa  MVC                    15.1
#> 594             Murray St.  OVC                    14.7
#> 595     South Carolina St. MEAC                    14.7
#> 596              Louisiana   SB                    14.7
#> 597                   Troy   SB                    14.7
#> 598      Southern Illinois  MVC                    14.7
#> 599            Austin Peay  OVC                    14.6
#> 600          West Virginia  B12                    14.4
#> 601                Bradley  MVC                    14.1
#> 602    Cal St. Bakersfield   BW                    14.1
#> 603             Bellarmine ASun                    14.0
#> 604          UNC Asheville BSth                    13.9
#> 605               Kentucky  SEC                    13.7
#> 606      Cal St. Fullerton   BW                    13.7
#> 607      Northern Colorado BSky                    13.7
#> 608               Maryland  B10                    13.5
#> 609               Lipscomb ASun                    13.2
#> 610              Green Bay Horz                    13.2
#> 611           Portland St. BSky                    13.2
#> 612       Georgia Southern   SB                    13.2
#> 613            New Orleans Slnd                    13.1
#> 614                Indiana  B10                    13.0
#> 615       SIU Edwardsville  OVC                    12.7
#> 616               Stanford  P12                    12.6
#> 617             Holy Cross  Pat                    12.4
#> 618           Northwestern  B10                    12.4
#> 619             Wright St. Horz                    12.3
#> 620             St. John's   BE                    12.3
#> 621          Saint Peter's MAAC                    12.2
#> 622       Northwestern St. Slnd                    12.1
#> 623            USC Upstate BSth                    12.0
#> 624           UC Riverside   BW                    11.9
#> 625                    BYU  WCC                    11.8
#> 626               Bucknell  Pat                    11.8
#> 627             Vanderbilt  SEC                    11.8
#> 628           George Mason  A10                    11.7
#> 629                 Temple Amer                    11.7
#> 630                Clemson  ACC                    11.5
#> 631       South Dakota St.  Sum                    11.4
#> 632                   Rice CUSA                    11.3
#> 633            Stony Brook   AE                    11.3
#> 634               Colorado  P12                    11.0
#> 635            Utah Valley  WAC                    10.9
#> 636               Campbell BSth                    10.6
#> 637               Illinois  B10                    10.5
#> 638               La Salle  A10                    10.5
#> 639        Houston Baptist Slnd                    10.5
#> 640           UT Arlington   SB                    10.3
#> 641           Gardner Webb BSth                    10.3
#> 642          San Diego St.  MWC                    10.2
#> 643               Michigan  B10                    10.1
#> 644                    USC  P12                    10.1
#> 645                Belmont  OVC                    10.0
#> 646              Villanova   BE                    10.0
#> 647                 Marist MAAC                     9.9
#> 648              Texas A&M  SEC                     9.7
#> 649                Colgate  Pat                     9.6
#> 650      Purdue Fort Wayne Horz                     9.5
#> 651               Canisius MAAC                     9.2
#> 652                   UMBC   AE                     9.1
#> 653     East Tennessee St.   SC                     9.0
#> 654              Wisconsin  B10                     9.0
#> 655         St. Francis NY  NEC                     8.9
#> 656 Southeast Missouri St.  OVC                     8.9
#> 657                    VCU  A10                     8.7
#> 658     Florida Gulf Coast ASun                     8.6
#> 659                 Mercer   SC                     8.6
#> 660            Connecticut   BE                     8.5
#> 661               Miami OH  MAC                     8.5
#> 662              Fairfield MAAC                     8.3
#> 663              Creighton   BE                     8.2
#> 664               Miami FL  ACC                     7.8
#> 665       Western Illinois  Sum                     7.7
#> 666          Southern Utah BSky                     7.7
#> 667           Michigan St.  B10                     7.4
#> 668        Appalachian St.   SB                     7.3
#> 669                Houston Amer                     7.1
#> 670                   Iona MAAC                     7.1
#> 671            Wake Forest  ACC                     7.0
#> 672              Tennessee  SEC                     6.9
#> 673                Radford BSth                     6.7
#> 674            Norfolk St. MEAC                     6.6
#> 675       Jacksonville St.  OVC                     6.6
#> 676             Kansas St.  B12                     6.6
#> 677               Penn St.  B10                     6.4
#> 678          Cleveland St. Horz                     6.4
#> 679                    SMU Amer                     6.2
#> 680                    UAB CUSA                     5.5
#> 681       Western Kentucky CUSA                     5.5
#> 682       Eastern Kentucky  OVC                     5.5
#> 683     North Carolina A&T MEAC                     5.5
#> 684       Tennessee Martin  OVC                     5.3
#> 685                   UCLA  P12                     5.2
#> 686               Virginia  ACC                     5.2
#> 687         Loyola Chicago  MVC                     5.1
#> 688          Bowling Green  MAC                     5.0
#> 689            Indiana St.  MVC                     5.0
#> 690                   Navy  Pat                     4.9
#> 691          Massachusetts  A10                     4.7
#> 692                   Utah  P12                     4.2
#> 693                Liberty ASun                     4.0
#> 694         New Mexico St.  WAC                     4.0
#> 695              UC Irvine   BW                     4.0
#> 696                 Albany   AE                     3.9
#> 697       Western Michigan  MAC                     3.8
#> 698             High Point BSth                     3.7
#> 699             Oregon St.  P12                     3.6
#> 700          East Carolina Amer                     3.4
#> 701          South Florida Amer                     3.2
#> 702                Stetson ASun                     3.0
#> 703              Weber St. BSky                     2.6
#> 704                 Lehigh  Pat                     2.6
#> 705               Davidson  A10                     2.4
#> 706         South Carolina  SEC                     1.9
#> 707                   Iowa  B10                     1.6
#> 708            Florida St.  ACC                     1.1
#> 709            Wichita St. Amer                     0.8
#> 710                Florida  SEC                     0.7
#>     TwoFoulParticpation.Pct.Rk Adj2FP Adj2FP.Rk TwoFoulTotalTime
#> 1                            1   45.2         1           334:36
#> 2                            2   39.0         2           173:06
#> 3                            3   33.6         4           269:13
#> 4                            4   32.0         7           395:19
#> 5                            5   32.4         6           276:14
#> 6                            6   34.1         3           342:08
#> 7                            7   32.6         5           275:21
#> 8                            8   29.7        10           225:56
#> 9                            9   30.0         8           160:07
#> 10                          10   30.0         9           261:18
#> 11                          11   28.7        11           160:45
#> 12                          12   28.6        12           164:15
#> 13                          13   25.9        16           340:00
#> 14                          14   28.2        13           297:24
#> 15                          15   25.1        18           266:50
#> 16                          16   26.4        14           263:50
#> 17                          17   25.3        17           318:53
#> 18                          18   26.1        15           375:07
#> 19                          19   22.1        22           277:50
#> 20                          20   24.8        19           308:27
#> 21                          21   23.2        20           354:41
#> 22                          22   23.0        21           161:17
#> 23                          23   20.3        26           285:39
#> 24                          24   21.1        25           269:16
#> 25                          25   21.9        23           471:23
#> 26                          26   21.6        24           215:57
#> 27                          27   19.4        29           123:25
#> 28                          28   19.6        28           243:49
#> 29                          29   19.1        33           265:36
#> 30                          30   19.3        31           282:29
#> 31                          31   15.8        42           177:27
#> 32                          32   19.3        30           280:25
#> 33                          33   19.2        32           141:25
#> 34                          34   15.5        43           145:34
#> 35                          35   19.1        34           210:25
#> 36                          36   18.2        35           184:14
#> 37                          37   17.9        37           244:42
#> 38                          38   17.3        38           275:04
#> 39                          39   18.1        36           225:09
#> 40                          40   19.8        27           197:31
#> 41                          41   16.2        41           301:01
#> 42                          42   16.3        40           447:05
#> 43                          43   14.0        49           228:31
#> 44                          44   12.9        54           298:21
#> 45                          45   15.2        45           321:42
#> 46                          46   16.4        39           204:23
#> 47                          47   13.4        50           281:35
#> 48                          48   15.3        44           272:52
#> 49                          49   13.2        51           225:53
#> 50                          50   13.0        53           380:20
#> 51                          51   12.3        55           331:25
#> 52                          52   15.0        46           216:30
#> 53                          53   14.3        48           362:33
#> 54                          54   14.7        47           354:30
#> 55                          55   13.1        52           323:55
#> 56                          56   10.6        62           335:12
#> 57                          57   11.0        59           226:06
#> 58                          58   10.8        60           352:31
#> 59                          59    8.8        70           205:32
#> 60                          60   10.1        65           277:27
#> 61                          61   11.1        57           303:26
#> 62                          62   11.6        56           279:23
#> 63                          63    8.4        71           268:47
#> 64                          64   11.0        58           242:43
#> 65                          65   10.8        61           219:00
#> 66                          66    7.7        74           169:37
#> 67                          67    6.2        86           216:18
#> 68                          68    9.5        66           234:16
#> 69                          69    9.0        69           283:37
#> 70                          70   10.1        64           204:51
#> 71                          71    9.4        67           316:51
#> 72                          72    6.4        85           238:19
#> 73                          73    9.1        68           340:33
#> 74                          74   10.3        63           183:07
#> 75                          75    6.9        79           254:39
#> 76                          76    7.2        77           320:57
#> 77                          77    8.2        72           311:49
#> 78                          78    7.6        75           146:02
#> 79                          79    5.9        93           271:43
#> 80                          80    6.6        81           229:56
#> 81                          81    4.8       104           154:13
#> 82                          82    7.8        73           372:09
#> 83                          83    5.6        96           247:02
#> 84                          84    5.6        97           187:42
#> 85                          85    6.0        88           230:31
#> 86                          86    5.0       101           395:35
#> 87                          87    6.7        80           217:35
#> 88                          88    7.0        78           228:52
#> 89                          89    5.6        95           203:50
#> 90                          90    6.2        87           228:26
#> 91                          91    5.9        92           232:57
#> 92                          92    7.5        76           208:32
#> 93                          93    6.0        89           250:56
#> 94                          94    4.9       103           137:06
#> 95                          95    4.2       110           107:14
#> 96                          96    5.5        98           258:53
#> 97                          97    4.8       105           223:29
#> 98                          98    4.5       107           307:57
#> 99                          99    6.6        82           408:27
#> 100                        100    6.4        84           325:32
#> 101                        101    6.5        83           242:35
#> 102                        102    3.2       114           279:32
#> 103                        103    6.0        90           174:32
#> 104                        104    4.5       108           263:14
#> 105                        105    5.9        91           186:26
#> 106                        106    5.1       100           215:52
#> 107                        107    5.3        99           232:44
#> 108                        108    4.2       109           311:39
#> 109                        109    2.9       119           244:20
#> 110                        110    1.8       126           259:02
#> 111                        111    2.2       122           190:31
#> 112                        112    4.7       106           327:18
#> 113                        113    2.7       120           313:41
#> 114                        114    3.0       118           204:17
#> 115                        115    5.8        94           128:32
#> 116                        116    3.3       111           246:43
#> 117                        117    4.9       102           208:34
#> 118                        118    1.1       131           274:14
#> 119                        119    3.0       116           289:12
#> 120                        120    1.0       134           303:15
#> 121                        121    3.2       112           289:25
#> 122                        122    0.3       143           127:02
#> 123                        123    3.2       113           187:12
#> 124                        124   -0.1       145           243:31
#> 125                        125    1.0       133           234:51
#> 126                        126   -1.0       157           314:51
#> 127                        127    2.2       121           233:29
#> 128                        128    1.1       132           215:21
#> 129                        129    3.0       117            93:42
#> 130                        130    1.9       124           325:58
#> 131                        131   -0.2       146           190:11
#> 132                        132   -0.4       152           289:40
#> 133                        133    3.2       115           276:24
#> 134                        134    0.8       135           288:16
#> 135                        135    0.5       138           314:35
#> 136                        136    0.8       136           408:54
#> 137                        137    1.3       130           220:18
#> 138                        138    1.8       125           403:55
#> 139                        139    0.4       141           352:24
#> 140                        140    1.9       123           168:45
#> 141                        141   -0.3       149           164:30
#> 142                        142    0.1       144           196:27
#> 143                        143   -0.9       156           289:42
#> 144                        144   -1.2       160           305:15
#> 145                        145    1.6       129           329:25
#> 146                        146    0.4       140           282:00
#> 147                        147   -0.2       148           239:53
#> 148                        148    1.7       127           363:32
#> 149                        149   -2.0       171           366:29
#> 150                        150   -0.4       153           208:49
#> 151                        151    0.5       139           232:34
#> 152                        152   -1.7       167           208:16
#> 153                        153   -0.4       151           234:00
#> 154                        154   -0.8       155           209:53
#> 155                        155    0.6       137           228:11
#> 156                        156   -2.1       172           310:43
#> 157                        157    1.6       128           158:57
#> 158                        158   -3.0       181           207:39
#> 159                        159   -2.9       179           259:35
#> 160                        160   -0.2       147           219:39
#> 161                        161   -1.6       165           268:02
#> 162                        162   -1.4       161           368:33
#> 163                        163   -2.5       176           251:20
#> 164                        164   -1.1       158           294:26
#> 165                        165   -0.3       150           376:12
#> 166                        166   -1.2       159           382:18
#> 167                        167    0.4       142           265:42
#> 168                        168   -1.8       168           194:28
#> 169                        169   -4.9       200           165:29
#> 170                        170   -1.5       163           214:21
#> 171                        171   -3.5       185           135:39
#> 172                        172   -3.1       182           320:44
#> 173                        173   -0.6       154           352:29
#> 174                        174   -1.9       169           315:37
#> 175                        175   -3.6       186           152:03
#> 176                        176   -4.0       189           255:25
#> 177                        177   -1.6       166           310:46
#> 178                        178   -6.0       209           179:00
#> 179                        179   -2.1       173           267:39
#> 180                        180   -5.3       203           212:19
#> 181                        181   -1.5       164           190:38
#> 182                        182   -1.4       162           297:50
#> 183                        183   -4.4       194           100:13
#> 184                        184   -3.1       183           140:05
#> 185                        185   -3.0       180           299:18
#> 186                        186   -2.5       177           193:42
#> 187                        187   -3.8       187           216:06
#> 188                        188   -4.8       198           404:54
#> 189                        189   -4.4       192           160:12
#> 190                        190   -2.4       175           173:28
#> 191                        191   -3.3       184           148:33
#> 192                        192   -4.3       190           261:28
#> 193                        193   -3.8       188           308:33
#> 194                        194   -7.1       223           270:49
#> 195                        195   -5.3       204           279:20
#> 196                        196   -5.7       208           245:40
#> 197                        197   -6.3       213           294:04
#> 198                        198   -4.4       193           243:31
#> 199                        199   -7.0       220           217:47
#> 200                        200   -4.7       197           368:55
#> 201                        201   -7.2       224           280:30
#> 202                        202   -5.5       205           231:53
#> 203                        203   -4.9       201           251:17
#> 204                        204   -6.0       210           303:01
#> 205                        205   -2.3       174           192:04
#> 206                        206   -2.7       178           260:02
#> 207                        207   -4.6       195           287:24
#> 208                        208   -7.1       221           196:08
#> 209                        209   -2.0       170           206:50
#> 210                        210   -6.3       214           165:44
#> 211                        211   -8.1       234           133:04
#> 212                        212   -7.7       230           123:00
#> 213                        213   -7.7       229           230:33
#> 214                        214  -10.1       261           238:37
#> 215                        215   -8.5       240           190:46
#> 216                        216   -6.5       216           323:31
#> 217                        217   -5.3       202           450:15
#> 218                        218   -6.7       219           279:43
#> 219                        219   -6.5       217           330:45
#> 220                        220   -6.7       218           242:00
#> 221                        221   -8.0       233           241:33
#> 222                        222   -6.1       211           200:47
#> 223                        223   -4.6       196           192:10
#> 224                        224   -4.3       191           218:31
#> 225                        225   -4.9       199           221:43
#> 226                        226   -7.8       231           183:01
#> 227                        227   -9.1       248           250:57
#> 228                        228   -5.6       206           215:42
#> 229                        229  -11.2       275           188:34
#> 230                        230  -10.0       259           281:40
#> 231                        231   -8.8       245           146:24
#> 232                        232   -8.5       239           239:57
#> 233                        233   -9.4       250           168:26
#> 234                        234   -8.6       244           111:35
#> 235                        235   -8.3       235           208:16
#> 236                        236  -13.4       298           144:32
#> 237                        237   -8.4       236           278:21
#> 238                        238   -6.2       212           226:44
#> 239                        239   -9.7       254           156:23
#> 240                        240   -7.1       222           297:59
#> 241                        241   -7.4       226           186:52
#> 242                        242   -9.2       249           292:49
#> 243                        243   -9.6       253           183:33
#> 244                        244   -8.6       243           408:16
#> 245                        245  -10.0       260           164:08
#> 246                        246   -8.6       242           211:41
#> 247                        247   -7.6       227           365:33
#> 248                        248   -6.5       215           311:52
#> 249                        249   -8.9       247           186:08
#> 250                        250   -9.4       251           191:54
#> 251                        251  -13.5       300            83:38
#> 252                        252   -9.9       257           312:42
#> 253                        253   -8.4       237           356:48
#> 254                        254  -11.7       279           211:34
#> 255                        255  -10.8       268           216:23
#> 256                        256   -8.4       238           211:32
#> 257                        257  -10.3       263           292:00
#> 258                        258   -9.5       252           223:37
#> 259                        259  -10.8       270           337:40
#> 260                        260   -9.8       255           258:48
#> 261                        261  -12.3       284           196:12
#> 262                        262   -5.6       207           198:35
#> 263                        263  -12.0       281           293:10
#> 264                        264   -7.8       232           180:33
#> 265                        265  -12.1       283           200:40
#> 266                        266  -11.3       276           234:29
#> 267                        267  -10.2       262           243:14
#> 268                        268   -8.8       246           361:26
#> 269                        269   -7.7       228           177:17
#> 270                        270  -12.5       286           172:15
#> 271                        271   -8.5       241           261:08
#> 272                        272  -11.0       272           226:26
#> 273                        273  -10.9       271           293:49
#> 274                        274  -12.6       287           150:27
#> 275                        275  -13.3       295           193:54
#> 276                        276  -10.4       265           236:33
#> 277                        277  -10.0       258           264:19
#> 278                        278   -9.9       256           279:03
#> 279                        279  -15.1       307           142:37
#> 280                        280  -12.9       293           145:04
#> 281                        281  -11.7       278           234:49
#> 282                        282  -15.6       313           120:30
#> 283                        283  -10.8       269           253:04
#> 284                        284  -10.4       266           110:33
#> 285                        285  -13.6       302           183:02
#> 286                        286  -12.4       285           109:34
#> 287                        287  -13.3       294           287:34
#> 288                        288  -13.4       299           233:52
#> 289                        289   -7.3       225           170:30
#> 290                        290  -11.1       274           240:28
#> 291                        291  -11.8       280           233:23
#> 292                        292  -10.6       267           260:51
#> 293                        293  -11.3       277           209:17
#> 294                        294  -15.7       315           158:14
#> 295                        295  -12.7       290           306:00
#> 296                        296  -11.1       273           229:50
#> 297                        297  -14.2       304           196:33
#> 298                        298  -17.2       332           171:00
#> 299                        299  -12.9       292           203:56
#> 300                        300  -15.7       316           152:31
#> 301                        301  -12.1       282           337:03
#> 302                        302  -12.6       288           285:17
#> 303                        303  -16.3       322           263:59
#> 304                        304  -12.7       289           213:33
#> 305                        305  -14.9       306           238:51
#> 306                        306  -12.8       291           184:27
#> 307                        307  -13.4       296           256:33
#> 308                        308  -15.9       317           174:33
#> 309                        309  -16.3       324           244:01
#> 310                        310  -14.1       303           235:48
#> 311                        311  -10.3       264           104:33
#> 312                        312  -13.6       301           117:36
#> 313                        313  -15.5       311           301:57
#> 314                        314  -16.5       326           248:34
#> 315                        315  -16.5       327           271:57
#> 316                        316  -15.5       310           304:11
#> 317                        317  -16.2       321           246:58
#> 318                        318  -15.6       312           149:36
#> 319                        319  -13.4       297           189:46
#> 320                        320  -15.2       308           311:47
#> 321                        321  -17.6       335           199:29
#> 322                        322  -16.7       328           153:21
#> 323                        323  -17.9       337           170:24
#> 324                        324  -14.3       305           267:50
#> 325                        325  -17.5       334           274:20
#> 326                        326  -19.0       343           142:57
#> 327                        327  -15.7       314           142:54
#> 328                        328  -16.1       320           222:52
#> 329                        329  -16.9       331           241:52
#> 330                        330  -15.3       309           268:03
#> 331                        331  -16.7       329           329:50
#> 332                        332  -18.6       341           344:23
#> 333                        333  -19.1       344           104:53
#> 334                        334  -18.0       338           185:33
#> 335                        335  -16.4       325           206:06
#> 336                        336  -16.3       323           327:17
#> 337                        337  -17.3       333           211:45
#> 338                        338  -18.3       340           113:44
#> 339                        339  -19.4       347           178:12
#> 340                        340  -16.7       330           185:31
#> 341                        341  -18.7       342           208:34
#> 342                        342  -22.2       352           143:04
#> 343                        343  -16.1       319           241:38
#> 344                        344  -18.2       339           146:07
#> 345                        345  -21.3       350           156:33
#> 346                        346  -17.7       336           216:32
#> 347                        347  -15.9       318           312:37
#> 348                        348  -21.2       349           271:52
#> 349                        349  -19.1       345           301:02
#> 350                        350  -20.3       348           236:19
#> 351                        351  -24.8       353           109:59
#> 352                        352  -22.0       351           205:31
#> 353                        353  -19.4       346           195:34
#> 354                          1   52.8         1             6:08
#> 355                          1    0.0         1             0:00
#> 356                          1    0.0         1             0:00
#> 357                          1    0.0         1             0:00
#> 358                          1    0.0         1             0:00
#> 359                          1    0.0         1             0:00
#> 360                          1    0.0         1             0:00
#> 361                          1    0.0         1             0:00
#> 362                          1    0.0         1             0:00
#> 363                          1    0.0         1             0:00
#> 364                          1    0.0         1             0:00
#> 365                          2   38.5         5            17:40
#> 366                          3   43.4         3           184:29
#> 367                          4   45.0         2           220:08
#> 368                          5   40.2         4           151:07
#> 369                          6   36.6         6           240:37
#> 370                          7   34.9         8           103:28
#> 371                          8   33.3        10           115:42
#> 372                          9   33.5         9           200:21
#> 373                         10   36.1         7           159:53
#> 374                         11   32.3        11           156:34
#> 375                         12   28.3        16           140:30
#> 376                         13   26.3        19           179:33
#> 377                         14   29.8        13           221:18
#> 378                         15   30.0        12           246:06
#> 379                         16   29.5        14           191:39
#> 380                         17   27.6        17           310:27
#> 381                         18   25.0        21           134:58
#> 382                         19   27.1        18           312:56
#> 383                         20   25.1        20           145:05
#> 384                         21   23.2        26           214:39
#> 385                         22   28.7        15           258:36
#> 386                         23   24.5        22           154:51
#> 387                         24   20.3        34           108:26
#> 388                         25   22.5        28           154:42
#> 389                         26   20.7        32           172:51
#> 390                         27   23.0        27           189:45
#> 391                         28   23.2        25           198:25
#> 392                         29   20.0        36           123:14
#> 393                         30   23.9        23           215:02
#> 394                         31   21.2        30           179:38
#> 395                         32   20.6        33           202:23
#> 396                         33   23.7        24           205:23
#> 397                         34   21.2        29           139:29
#> 398                         35   21.0        31           156:33
#> 399                         36   20.1        35           149:35
#> 400                         37   19.0        37           175:29
#> 401                         38   18.7        38           193:23
#> 402                         39   18.0        41           205:07
#> 403                         40   17.9        42           176:27
#> 404                         41   17.2        45           218:25
#> 405                         42   18.1        40           316:05
#> 406                         43   17.0        47           230:20
#> 407                         44   18.3        39           177:01
#> 408                         45   14.7        56           189:17
#> 409                         46   14.8        55           151:40
#> 410                         47   15.8        50           171:03
#> 411                         48   14.5        57           218:11
#> 412                         49   17.5        43           238:11
#> 413                         50   17.5        44           189:58
#> 414                         51   15.1        52           206:06
#> 415                         52   14.4        58           227:46
#> 416                         53   16.3        49           249:49
#> 417                         54   17.1        46           374:51
#> 418                         55   13.6        60           182:34
#> 419                         56   15.0        54           285:24
#> 420                         57   15.7        51           314:54
#> 421                         58   13.8        59           190:57
#> 422                         59   11.3        70           131:08
#> 423                         60   12.3        64           166:17
#> 424                         61   12.1        65           160:14
#> 425                         62    9.5        83           150:34
#> 426                         63   16.5        48           206:03
#> 427                         64    8.2        89           218:49
#> 428                         65   11.4        69           286:49
#> 429                         66   12.3        63           194:18
#> 430                         67    9.7        80           227:43
#> 431                         68   11.4        67           212:53
#> 432                         69   11.4        68           125:47
#> 433                         70   15.1        53            65:11
#> 434                         71   10.5        73           228:25
#> 435                         72    9.7        81            74:48
#> 436                         73   12.3        62           263:15
#> 437                         74    9.3        85           109:17
#> 438                         75   10.0        78           201:55
#> 439                         76    9.1        87           192:10
#> 440                         77   11.5        66           171:53
#> 441                         78   10.2        76           170:12
#> 442                         79   12.9        61           135:01
#> 443                         80    9.8        79           145:23
#> 444                         81    5.3       108            80:40
#> 445                         82    9.6        82           167:43
#> 446                         83    7.8        90           202:41
#> 447                         84   10.5        74           223:23
#> 448                         85   10.5        72           218:55
#> 449                         86    8.6        88           256:10
#> 450                         87   11.3        71           168:09
#> 451                         88   10.4        75           106:25
#> 452                         89    9.1        86           188:32
#> 453                         90    5.1       109           157:52
#> 454                         91    6.2       100           145:29
#> 455                         92    5.0       111           236:48
#> 456                         93    9.3        84           187:58
#> 457                         94    5.8       103           181:13
#> 458                         95    3.8       121           292:40
#> 459                         96    6.2       101           233:37
#> 460                         97    7.2        95           198:32
#> 461                         98    3.8       120           103:54
#> 462                         99    5.7       104           121:05
#> 463                        100    7.0        96           220:00
#> 464                        101    7.3        93            67:45
#> 465                        102   10.2        77           246:09
#> 466                        103    2.4       129           146:14
#> 467                        104    7.7        91           303:04
#> 468                        105    7.2        94           214:50
#> 469                        106    4.3       118           127:35
#> 470                        107    5.9       102           253:31
#> 471                        108    6.3        98           302:51
#> 472                        109    3.1       125           303:52
#> 473                        110    7.6        92           283:49
#> 474                        111    4.8       113           200:19
#> 475                        112    5.7       105           100:49
#> 476                        113    4.3       117           218:07
#> 477                        114    6.2        99           276:16
#> 478                        115    4.8       112           135:42
#> 479                        116    4.1       119           301:20
#> 480                        117    2.5       127            79:29
#> 481                        118    5.7       106           226:30
#> 482                        119    5.3       107           381:27
#> 483                        120   -1.3       162            86:51
#> 484                        121    6.5        97           236:59
#> 485                        122    2.6       126            85:30
#> 486                        123    4.4       116           202:33
#> 487                        124    1.2       138           247:01
#> 488                        125    4.5       114           241:30
#> 489                        126    3.1       124            94:26
#> 490                        127    2.1       133           249:29
#> 491                        128    0.5       144           190:37
#> 492                        129    1.2       139           177:32
#> 493                        130    0.4       146           133:12
#> 494                        131    0.2       150           132:42
#> 495                        132    2.1       134           130:16
#> 496                        133    1.5       136           225:14
#> 497                        134    2.5       128           126:47
#> 498                        135    3.6       123           307:55
#> 499                        136    3.6       122           212:49
#> 500                        137    5.0       110           207:33
#> 501                        138   -0.5       156           168:34
#> 502                        139    1.4       137           171:28
#> 503                        140    1.1       140           181:41
#> 504                        141    2.4       130           298:50
#> 505                        142   -1.7       166           153:04
#> 506                        143    0.7       143           170:59
#> 507                        144    0.3       148           208:24
#> 508                        145   -1.3       161           198:55
#> 509                        146   -3.0       174           174:57
#> 510                        147    4.4       115           139:25
#> 511                        148    0.1       151           215:32
#> 512                        149   -0.3       154           287:29
#> 513                        150    0.3       147           149:51
#> 514                        151   -3.0       176           149:50
#> 515                        152    0.9       141            81:41
#> 516                        153    0.5       145           154:58
#> 517                        154    0.9       142           176:49
#> 518                        155   -2.3       170           236:46
#> 519                        156   -1.2       160           133:29
#> 520                        157   -4.7       187           125:43
#> 521                        158    0.2       149           233:55
#> 522                        159   -1.6       163           183:48
#> 523                        160    2.1       131           254:59
#> 524                        161   -1.2       159           167:13
#> 525                        162   -0.4       155           158:52
#> 526                        163    1.9       135           205:38
#> 527                        164   -4.3       184           121:55
#> 528                        165   -0.9       157           148:54
#> 529                        166   -4.2       183           202:08
#> 530                        167    2.1       132            70:32
#> 531                        168   -2.5       171           135:14
#> 532                        169   -0.1       153           207:16
#> 533                        170   -4.7       188           108:44
#> 534                        171   -2.3       169           161:32
#> 535                        172   -1.7       164           225:29
#> 536                        173   -1.9       167           230:18
#> 537                        174   -3.4       178           238:53
#> 538                        175   -4.6       185           178:15
#> 539                        176   -1.0       158           224:38
#> 540                        177   -3.7       180           208:31
#> 541                        178   -1.7       165           161:30
#> 542                        179   -3.0       175           269:41
#> 543                        180    0.1       152           192:29
#> 544                        181   -4.9       194           192:56
#> 545                        182   -2.2       168           182:44
#> 546                        183   -2.8       172           293:58
#> 547                        184   -7.2       219           150:23
#> 548                        185   -5.1       197           248:14
#> 549                        186   -3.0       173           180:27
#> 550                        187   -6.5       205           142:29
#> 551                        188   -4.7       190            75:43
#> 552                        189   -7.2       218           144:56
#> 553                        190   -5.0       195           184:47
#> 554                        191   -3.6       179           191:57
#> 555                        192   -5.7       202           178:40
#> 556                        193   -6.8       210           224:28
#> 557                        194   -3.1       177           215:05
#> 558                        195   -8.7       233           211:02
#> 559                        196   -4.9       193           272:35
#> 560                        197   -4.6       186           178:31
#> 561                        198   -4.0       181           227:46
#> 562                        199   -4.9       192           208:41
#> 563                        200   -5.3       199           176:24
#> 564                        201   -6.5       206           202:08
#> 565                        202   -4.2       182           294:08
#> 566                        203   -5.4       200           190:03
#> 567                        204   -7.9       225           134:00
#> 568                        205   -4.7       189           206:20
#> 569                        206   -6.2       204           320:52
#> 570                        207   -8.2       228           206:44
#> 571                        208   -5.1       198           236:28
#> 572                        209   -7.9       224           105:55
#> 573                        210   -6.5       207           176:07
#> 574                        211   -7.1       216           119:23
#> 575                        212   -9.1       239           155:15
#> 576                        213   -4.7       191           211:48
#> 577                        214   -5.7       201           269:33
#> 578                        215   -6.9       211           190:51
#> 579                        216   -6.9       212           188:32
#> 580                        217  -10.2       249           257:20
#> 581                        218   -6.8       209           286:26
#> 582                        219   -5.1       196           216:20
#> 583                        220   -6.6       208           238:41
#> 584                        221   -7.2       217           176:24
#> 585                        222   -7.0       213           125:18
#> 586                        223   -7.0       214           305:22
#> 587                        224   -8.6       232           140:20
#> 588                        225   -7.5       221           248:24
#> 589                        226   -8.0       226           135:49
#> 590                        227   -8.3       229           130:48
#> 591                        228   -8.5       231           138:32
#> 592                        229   -8.2       227           258:16
#> 593                        230   -9.6       242           102:00
#> 594                        231   -7.7       222           199:35
#> 595                        232   -7.1       215           124:06
#> 596                        233   -9.2       240           253:57
#> 597                        234   -6.1       203           192:50
#> 598                        235   -7.3       220           189:33
#> 599                        236  -10.6       256           128:58
#> 600                        237   -8.7       234           232:54
#> 601                        238  -10.9       258           180:26
#> 602                        239   -8.9       237           203:28
#> 603                        240  -11.1       259           115:20
#> 604                        241  -12.3       269           123:47
#> 605                        242   -9.6       243           258:51
#> 606                        243  -12.0       267           100:41
#> 607                        244   -8.8       235           112:36
#> 608                        245   -9.7       244           171:37
#> 609                        246  -10.3       251            92:59
#> 610                        247  -10.5       255           167:17
#> 611                        248   -9.2       241           236:58
#> 612                        249   -9.9       246            70:45
#> 613                        250  -10.0       247           302:07
#> 614                        251  -12.9       273           170:35
#> 615                        252   -8.3       230           342:18
#> 616                        253  -11.1       260           225:52
#> 617                        254  -10.2       248           130:24
#> 618                        255  -11.5       261           202:40
#> 619                        256  -16.0       305           130:28
#> 620                        257   -9.9       245           212:46
#> 621                        258  -11.5       262           199:46
#> 622                        259   -7.8       223           188:00
#> 623                        260  -11.8       265           149:16
#> 624                        261  -12.6       270           257:12
#> 625                        262  -12.8       272           152:12
#> 626                        263  -10.8       257           111:31
#> 627                        264  -10.5       254           195:08
#> 628                        265  -12.3       268           154:16
#> 629                        266   -9.0       238           164:59
#> 630                        267  -10.3       252           135:36
#> 631                        268  -11.7       264           138:09
#> 632                        269  -14.1       284            91:04
#> 633                        270  -13.8       281           190:42
#> 634                        271  -13.8       280           228:29
#> 635                        272  -13.7       279           220:42
#> 636                        273  -12.9       275           173:52
#> 637                        274  -14.8       291           165:06
#> 638                        275  -12.9       274           233:08
#> 639                        276  -10.4       253           212:27
#> 640                        277  -10.3       250           171:28
#> 641                        278  -14.1       285           158:20
#> 642                        279  -14.3       286           210:04
#> 643                        280  -13.4       277           110:27
#> 644                        281  -15.9       304           118:21
#> 645                        282  -14.7       290           142:20
#> 646                        283  -14.8       292           141:46
#> 647                        284  -13.6       278           230:08
#> 648                        285  -11.6       263           111:12
#> 649                        286   -8.8       236            83:02
#> 650                        287  -15.5       300           135:24
#> 651                        288  -11.8       266           156:05
#> 652                        289  -16.5       311            90:37
#> 653                        290  -15.8       303           220:44
#> 654                        291  -13.8       282           187:22
#> 655                        292  -14.5       289           150:57
#> 656                        293  -14.4       287           173:26
#> 657                        294  -15.3       298           251:44
#> 658                        295  -15.7       302           133:51
#> 659                        296  -15.5       301           225:41
#> 660                        297  -13.1       276           267:59
#> 661                        298  -14.0       283           188:34
#> 662                        299  -15.2       297           205:05
#> 663                        300  -14.9       293           144:25
#> 664                        301  -15.3       299           114:26
#> 665                        302  -18.2       317           282:01
#> 666                        303  -16.2       308           173:23
#> 667                        304  -14.9       294           330:00
#> 668                        305  -18.7       322            92:52
#> 669                        306  -18.0       316           284:29
#> 670                        307  -15.1       296           228:46
#> 671                        308  -12.7       271           194:31
#> 672                        309  -16.1       306           211:08
#> 673                        310  -17.4       315           125:52
#> 674                        311  -14.4       288           249:18
#> 675                        312  -18.2       318           153:20
#> 676                        313  -16.2       309           255:07
#> 677                        314  -18.7       321           192:56
#> 678                        315  -19.3       326           221:26
#> 679                        316  -17.0       314            84:28
#> 680                        317  -16.1       307           198:14
#> 681                        318  -18.5       319           163:52
#> 682                        319  -19.8       329           227:59
#> 683                        320  -19.3       325           130:25
#> 684                        321  -20.0       332           173:17
#> 685                        322  -16.5       312           245:37
#> 686                        323  -20.0       331            69:24
#> 687                        324  -22.6       344           134:40
#> 688                        325  -15.0       295           243:48
#> 689                        326  -16.2       310           188:03
#> 690                        327  -18.5       320           116:12
#> 691                        328  -19.9       330            98:48
#> 692                        329  -18.9       323           218:51
#> 693                        330  -20.4       337           127:37
#> 694                        331  -21.0       340            68:18
#> 695                        332  -17.0       313           152:07
#> 696                        333  -20.7       338           131:07
#> 697                        334  -19.5       327           114:32
#> 698                        335  -20.1       334           133:12
#> 699                        336  -19.1       324           269:54
#> 700                        337  -20.1       336           135:15
#> 701                        338  -22.2       343            89:25
#> 702                        339  -19.6       328           133:58
#> 703                        340  -20.1       333           188:19
#> 704                        341  -20.1       335           105:58
#> 705                        342  -22.1       342            79:13
#> 706                        343  -20.8       339           212:38
#> 707                        344  -23.6       347           160:27
#> 708                        345  -22.7       345           187:14
#> 709                        346  -21.6       341           104:15
#> 710                        347  -23.6       346           175:14
#>     TwoFoulTotalTime.Rk TwoFoulTimeOn TwoFoulTimeOn.Rk Bench.Pct Bench.Pct.Rk
#> 1                    36        229:52                1      26.5          267
#> 2                   294        105:56               40      27.2          254
#> 3                   123        154:20                9      17.8          350
#> 4                    10        223:04                2      26.2          272
#> 5                   112        154:13               10      30.1          174
#> 6                    30        184:45                4      18.0          349
#> 7                   113        147:33               13      28.2          229
#> 8                   203        119:04               27      30.9          155
#> 9                   310         83:47               65      17.2          352
#> 10                  137        136:13               16      26.8          262
#> 11                  308         82:29               69      22.1          327
#> 12                  305         83:36               67      20.4          340
#> 13                   32        169:05                7      28.4          222
#> 14                   80        147:40               12      27.6          249
#> 15                  129        130:20               18      26.4          268
#> 16                  134        127:23               21      30.4          167
#> 17                   50        153:27               11      26.4          269
#> 18                   14        180:02                5      18.2          348
#> 19                  109        132:34               17      21.9          330
#> 20                   65        145:49               14      29.4          197
#> 21                   24        165:55                8      31.0          151
#> 22                  307         73:34               95      28.6          216
#> 23                   94        128:25               19      32.9          110
#> 24                  122        120:25               24      41.6           10
#> 25                    1        207:43                3      26.8          263
#> 26                  221         94:38               50      32.8          114
#> 27                  339         53:59              155      29.7          187
#> 28                  161        106:04               39      35.2           77
#> 29                  131        114:46               33      21.1          336
#> 30                   97        120:21               25      31.6          139
#> 31                  289         74:57               90      33.1          106
#> 32                  102        118:20               28      28.9          210
#> 33                  332         59:30              134      18.8          347
#> 34                  325         60:53              131      23.8          308
#> 35                  232         88:00               58      22.9          316
#> 36                  281         76:21               87      28.7          215
#> 37                  158        100:53               45      29.0          206
#> 38                  114        111:59               37      28.7          212
#> 39                  205         91:27               54      38.3           28
#> 40                  255         79:44               78      29.9          182
#> 41                   75        116:01               30      27.3          253
#> 42                    3        171:21                6      25.5          287
#> 43                  197         87:20               60      27.6          248
#> 44                   77        113:00               36      22.3          326
#> 45                   47        121:20               23      27.7          246
#> 46                  247         76:22               86      31.8          136
#> 47                  100        103:57               42      23.9          306
#> 48                  117         99:55               46      29.6          191
#> 49                  204         82:18               70      23.9          304
#> 50                   12        136:37               15      24.2          299
#> 51                   37        118:13               29      23.8          307
#> 52                  217         76:52               85      34.4           88
#> 53                   21        128:10               20      20.8          339
#> 54                   25        125:12               22      33.8           95
#> 55                   45        114:14               35      35.6           73
#> 56                   35        115:05               32      30.8          156
#> 57                  202         77:01               84      22.1          328
#> 58                   26        120:03               26      32.5          121
#> 59                  244         69:59              107      23.6          312
#> 60                  110         93:47               51      31.0          154
#> 61                   70        101:07               44      42.8            4
#> 62                  105         92:14               53      37.0           44
#> 63                  124         88:27               57      17.7          351
#> 64                  165         79:48               76      33.6           99
#> 65                  212         71:41              103      37.5           34
#> 66                  299         54:50              148      37.9           31
#> 67                  219         69:44              108      25.1          291
#> 68                  183         74:52               91      23.9          305
#> 69                   96         89:31               56      25.4          289
#> 70                  246         64:24              124      28.0          236
#> 71                   51         99:34               47      31.5          140
#> 72                  176         74:01               94      22.6          321
#> 73                   31        105:24               41      38.7           23
#> 74                  283         56:19              145      29.6          188
#> 75                  147         77:11               83      32.6          118
#> 76                   48         96:38               49      36.1           63
#> 77                   59         93:34               52      40.3           13
#> 78                  324         43:48              191      21.8          333
#> 79                  120         81:24               73      23.8          309
#> 80                  194         68:01              112      30.1          177
#> 81                  315         45:34              183      32.8          115
#> 82                   15        109:46               38      35.1           79
#> 83                  154         72:47               99      37.5           33
#> 84                  273         55:08              146      24.0          302
#> 85                  193         67:39              114      31.3          143
#> 86                    9        115:57               31      21.1          338
#> 87                  215         63:34              127      28.4          223
#> 88                  196         66:47              117      39.1           19
#> 89                  250         59:23              136      21.9          331
#> 90                  198         66:33              120      27.6          247
#> 91                  188         67:31              115      22.7          318
#> 92                  238         60:20              132      30.2          171
#> 93                  152         72:36              101      29.3          200
#> 94                  334         39:25              207      25.6          283
#> 95                  348         30:46              243      30.1          173
#> 96                  143         73:33               96      29.4          199
#> 97                  207         63:08              129      27.1          255
#> 98                   66         86:46               61      26.1          273
#> 99                    5        114:29               34      28.8          211
#> 100                  44         91:11               55      32.8          113
#> 101                 166         67:49              113      22.8          317
#> 102                 104         77:31               82      31.2          148
#> 103                 292         48:21              172      36.1           61
#> 104                 135         72:49               98      27.7          245
#> 105                 276         51:13              166      28.1          234
#> 106                 222         59:12              138      28.1          233
#> 107                 189         63:44              125      36.8           51
#> 108                  61         85:12               63      29.8          184
#> 109                 159         66:34              119      25.2          290
#> 110                 142         70:19              106      26.1          274
#> 111                 269         51:31              163      24.1          301
#> 112                  41         87:51               59      24.3          298
#> 113                  55         84:03               64      34.6           82
#> 114                 248         54:10              153      34.9           80
#> 115                 337         33:51              223      19.4          343
#> 116                 156         64:58              123      31.1          150
#> 117                 237         54:26              149      36.2           58
#> 118                 116         71:12              104      24.0          303
#> 119                  90         75:05               89      24.9          294
#> 120                  71         78:42               80      25.7          280
#> 121                  89         74:11               93      23.8          310
#> 122                 338         32:22              232      30.2          169
#> 123                 274         47:40              176      20.2          341
#> 124                 163         61:45              130      33.9           94
#> 125                 180         59:32              133      28.6          218
#> 126                  53         79:47               77      35.1           78
#> 127                 186         58:51              139      30.7          161
#> 128                 224         54:15              152      27.4          252
#> 129                 352         23:36              278      32.4          123
#> 130                  43         82:01               71      36.9           45
#> 131                 270         47:49              175      36.6           53
#> 132                  88         72:44              100      31.3          144
#> 133                 111         69:24              109      30.7          160
#> 134                  91         71:49              102      21.1          337
#> 135                  54         78:01               81      22.6          319
#> 136                   4        101:12               43      39.0           20
#> 137                 210         54:24              151      21.1          335
#> 138                   8         99:02               48      39.2           18
#> 139                  28         85:51               62      21.9          329
#> 140                 300         40:54              202      42.8            6
#> 141                 304         39:05              209      30.8          158
#> 142                 257         46:38              180      30.1          178
#> 143                  87         68:25              111      34.5           84
#> 144                  68         71:10              105      23.7          311
#> 145                  40         76:06               88      31.7          138
#> 146                  98         65:05              122      21.4          334
#> 147                 173         54:57              147      37.7           32
#> 148                  20         83:10               68      26.6          265
#> 149                  18         83:36               66      36.1           62
#> 150                 235         47:38              177      18.9          345
#> 151                 190         52:59              160      28.2          228
#> 152                 240         46:56              179      29.8          183
#> 153                 184         52:29              162      26.1          275
#> 154                 233         47:01              178      36.0           65
#> 155                 199         50:53              167      29.7          186
#> 156                  63         68:56              110      34.7           81
#> 157                 311         35:07              221      28.3          225
#> 158                 241         45:35              182      41.8            9
#> 159                 141         56:53              144      37.2           41
#> 160                 211         48:04              173      33.0          107
#> 161                 126         58:37              140      30.5          163
#> 162                  17         80:15               75      29.6          190
#> 163                 149         54:24              150      35.6           75
#> 164                  81         63:42              126      30.7          159
#> 165                  13         81:03               74      30.1          172
#> 166                  11         81:59               72      33.1          105
#> 167                 130         56:54              143      29.3          201
#> 168                 261         41:27              199      28.5          221
#> 169                 303         35:09              220      23.6          313
#> 170                 225         45:14              185      32.8          116
#> 171                 335         28:32              253      27.5          251
#> 172                  49         66:56              116      38.9           21
#> 173                  27         73:18               97      36.4           57
#> 174                  52         65:29              121      34.6           83
#> 175                 318         31:22              238      19.2          344
#> 176                 146         52:32              161      36.7           52
#> 177                  62         63:15              128      38.5           25
#> 178                 287         36:23              215      34.0           92
#> 179                 128         53:33              157      27.9          241
#> 180                 227         42:26              196      31.0          153
#> 181                 268         38:05              213      29.6          189
#> 182                  79         59:23              135      27.0          258
#> 183                 351         19:57              297      33.5          100
#> 184                 333         27:46              259      32.5          120
#> 185                  76         59:16              137      29.0          207
#> 186                 263         38:19              212      26.1          276
#> 187                 220         42:41              195      28.5          219
#> 188                   7         79:18               79      25.7          279
#> 189                 309         31:10              239      31.4          142
#> 190                 293         33:36              225      28.9          209
#> 191                 321         28:45              250      29.5          194
#> 192                 136         49:43              171      25.4          288
#> 193                  64         57:32              142      33.3          102
#> 194                 121         50:24              168      38.3           27
#> 195                 106         51:21              164      30.1          175
#> 196                 157         44:53              187      33.1          104
#> 197                  82         53:42              156      22.4          324
#> 198                 162         44:19              189      22.6          320
#> 199                 214         39:33              204      25.9          278
#> 200                  16         66:40              118      30.6          162
#> 201                 101         49:54              170      34.4           89
#> 202                 191         40:56              200      32.2          127
#> 203                 150         44:15              190      33.6           98
#> 204                  72         53:10              159      42.7            7
#> 205                 265         33:39              224      34.5           85
#> 206                 140         45:26              184      40.6           12
#> 207                  93         50:12              169      27.9          239
#> 208                 259         33:28              227      32.4          124
#> 209                 242         35:17              219      47.0            2
#> 210                 302         28:13              256      28.3          226
#> 211                 336         22:38              283      30.4          166
#> 212                 340         20:41              294      33.6           97
#> 213                 192         38:19              211      28.1          232
#> 214                 175         39:39              203      29.6          192
#> 215                 267         31:38              236      25.0          293
#> 216                  46         53:30              158      25.7          281
#> 217                   2         74:27               92      32.6          119
#> 218                 103         46:03              181      32.9          112
#> 219                  38         54:09              154      25.1          292
#> 220                 167         39:32              205      27.1          257
#> 221                 170         39:27              206      26.4          270
#> 222                 251         32:35              231      35.7           72
#> 223                 264         30:46              242      27.9          240
#> 224                 213         34:58              222      25.5          286
#> 225                 209         35:26              218      14.2          353
#> 226                 285         28:36              252      36.6           54
#> 227                 151         39:05              208      32.2          128
#> 228                 223         33:35              226      22.4          325
#> 229                 272         28:36              251      27.1          256
#> 230                  99         42:41              194      23.1          315
#> 231                 322         22:04              286      32.6          117
#> 232                 172         36:02              216      35.7           71
#> 233                 301         25:13              273      29.5          195
#> 234                 344         16:41              312      34.5           86
#> 235                 239         31:02              240      35.9           66
#> 236                 327         21:29              290      29.0          205
#> 237                 108         40:54              201      27.0          259
#> 238                 200         33:11              229      28.1          235
#> 239                 314         22:45              282      27.7          244
#> 240                  78         43:10              193      32.5          122
#> 241                 275         27:04              262      38.8           22
#> 242                  85         42:10              198      35.6           74
#> 243                 282         26:07              265      26.3          271
#> 244                   6         58:01              141      31.5          141
#> 245                 306         23:19              280      31.2          149
#> 246                 229         29:41              245      29.2          203
#> 247                  19         51:15              165      36.2           59
#> 248                  58         43:43              192      26.7          264
#> 249                 277         25:57              267      30.1          176
#> 250                 266         26:25              263      26.5          266
#> 251                 353         11:27              327      22.5          323
#> 252                  56         42:20              197      37.3           38
#> 253                  23         47:54              174      30.1          179
#> 254                 230         28:21              254      37.1           43
#> 255                 218         28:56              249      39.6           16
#> 256                 231         28:11              257      31.2          146
#> 257                  86         38:46              210      35.8           68
#> 258                 206         29:31              247      37.3           39
#> 259                  33         44:23              188      30.8          157
#> 260                 144         33:20              228      32.3          126
#> 261                 258         25:13              272      27.8          242
#> 262                 254         25:30              269      29.5          193
#> 263                  84         37:30              214      36.9           46
#> 264                 286         23:03              281      28.3          227
#> 265                 252         25:26              270      27.9          237
#> 266                 182         29:33              246      32.1          129
#> 267                 164         30:37              244      40.8           11
#> 268                  22         45:00              186      31.0          152
#> 269                 290         22:02              287      18.8          346
#> 270                 295         21:24              291      25.9          277
#> 271                 138         32:03              234      30.5          164
#> 272                 201         27:43              260      28.3          224
#> 273                  83         35:52              217      25.5          285
#> 274                 319         18:11              306      19.9          342
#> 275                 262         23:26              279      29.4          196
#> 276                 177         28:21              255      34.0           91
#> 277                 132         31:37              237      32.3          125
#> 278                 107         32:44              230      42.6            8
#> 279                 331         16:41              311      27.0          260
#> 280                 326         16:58              308      32.9          111
#> 281                 181         27:24              261      34.4           87
#> 282                 341         14:01              321      21.8          332
#> 283                 148         29:14              248      25.6          282
#> 284                 345         12:38              324      36.5           56
#> 285                 284         20:54              292      39.6           14
#> 286                 347         12:24              325      35.8           69
#> 287                  92         31:58              235      24.7          296
#> 288                 185         25:45              268      37.1           42
#> 289                 297         18:38              305      36.5           55
#> 290                 171         26:14              264      28.5          220
#> 291                 187         25:23              271      33.3          101
#> 292                 139         28:04              258      42.8            5
#> 293                 234         22:25              284      30.2          170
#> 294                 312         16:53              309      31.9          135
#> 295                  67         32:09              233      33.6           96
#> 296                 195         23:36              277      29.2          202
#> 297                 256         19:51              298      38.2           29
#> 298                 296         16:52              310      33.2          103
#> 299                 249         20:00              296      32.0          131
#> 300                 317         14:23              319      29.0          204
#> 301                  34         30:50              241      38.1           30
#> 302                  95         26:03              266      37.4           37
#> 303                 133         23:51              276      28.6          217
#> 304                 226         19:12              304      27.8          243
#> 305                 174         20:43              293      30.5          165
#> 306                 280         15:41              316      36.0           64
#> 307                 145         21:33              289      31.9          134
#> 308                 291         14:33              317      43.2            3
#> 309                 160         20:18              295      28.9          208
#> 310                 179         19:35              301      36.8           49
#> 311                 350          8:33              344      39.6           15
#> 312                 342          9:37              335      30.0          180
#> 313                  73         24:04              274      33.9           93
#> 314                 153         19:45              299      37.5           35
#> 315                 118         21:35              288      31.2          145
#> 316                  69         23:53              275      35.8           67
#> 317                 155         19:12              303      27.6          250
#> 318                 320         11:22              328      23.5          314
#> 319                 271         14:15              320      31.2          147
#> 320                  60         22:23              285      33.0          109
#> 321                 253         14:00              322      24.7          295
#> 322                 316          9:46              334      34.1           90
#> 323                 298         10:38              331      31.7          137
#> 324                 127         16:37              314      49.1            1
#> 325                 115         16:40              313      36.8           50
#> 326                 329          8:40              341      28.2          230
#> 327                 330          8:36              343      22.5          322
#> 328                 208         13:20              323      28.2          231
#> 329                 168         14:23              318      26.9          261
#> 330                 125         15:44              315      39.5           17
#> 331                  39         19:16              302      36.9           47
#> 332                  29         19:42              300      37.3           40
#> 333                 349          5:59              349      25.6          284
#> 334                 278         10:31              332      33.0          108
#> 335                 243         11:33              326      36.9           48
#> 336                  42         17:24              307      24.2          300
#> 337                 228         11:12              330      32.1          130
#> 338                 343          5:37              350      29.4          198
#> 339                 288          8:44              340      30.0          181
#> 340                 279          9:01              338      35.7           70
#> 341                 236          9:08              337      38.5           24
#> 342                 328          6:12              347      29.7          185
#> 343                 169         10:16              333      35.6           76
#> 344                 323          6:11              348      28.7          214
#> 345                 313          6:20              345      27.9          238
#> 346                 216          8:38              342      30.2          168
#> 347                  57         11:20              329      37.5           36
#> 348                 119          8:49              339      28.7          213
#> 349                  74          9:25              336      31.9          133
#> 350                 178          6:13              346      38.4           26
#> 351                 346          2:45              353      36.2           60
#> 352                 245          4:17              351      32.0          132
#> 353                 260          3:15              352      24.5          297
#> 354                 347          5:13              328      34.7           85
#> 355                   1          0:00                1       0.0          348
#> 356                   1          0:00                1       0.0          348
#> 357                   1          0:00                1       0.0          348
#> 358                   1          0:00                1       0.0          348
#> 359                   1          0:00                1       0.0          348
#> 360                   1          0:00                1       0.0          348
#> 361                   1          0:00                1       0.0          348
#> 362                   1          0:00                1       0.0          348
#> 363                   1          0:00                1       0.0          348
#> 364                   1          0:00                1       0.0          348
#> 365                 346         12:20              302      34.7           86
#> 366                 174        123:08                9      20.1          336
#> 367                  92        145:51                3      28.5          235
#> 368                 240         95:00               21      18.9          340
#> 369                  57        143:19                4      28.0          255
#> 370                 319         60:11               93      27.8          261
#> 371                 303         67:12               77      35.5           74
#> 372                 136        116:18               12      26.5          275
#> 373                 223         90:30               27      19.1          339
#> 374                 227         85:50               36      27.2          269
#> 375                 258         75:00               53      28.1          250
#> 376                 183         95:41               19      20.4          333
#> 377                  89        117:26               10      22.3          321
#> 378                  53        128:57                7      23.2          318
#> 379                 154         98:28               17      47.5            1
#> 380                   9        156:13                1      36.3           58
#> 381                 271         67:47               75      30.1          196
#> 382                   8        153:17                2      17.6          345
#> 383                 252         69:35               70      27.2          268
#> 384                 105        102:42               16      24.6          308
#> 385                  36        123:32                8      26.5          274
#> 386                 232         72:38               62      20.0          338
#> 387                 313         50:31              117      39.9           20
#> 388                 233         71:55               66      21.8          325
#> 389                 201         79:43               45      20.9          331
#> 390                 161         87:29               33      35.8           65
#> 391                 142         91:20               24      32.6          134
#> 392                 297         55:50              104      36.6           52
#> 393                 103         96:02               18      36.6           53
#> 394                 182         79:11               47      26.4          276
#> 395                 132         88:43               30      27.2          270
#> 396                 125         89:47               28      25.8          289
#> 397                 260         60:40               90      28.2          247
#> 398                 228         66:59               78      32.1          143
#> 399                 246         63:24               84      25.9          288
#> 400                 194         74:06               55      34.4           97
#> 401                 147         81:03               41      21.0          330
#> 402                 126         85:58               35      29.9          199
#> 403                 190         73:57               58      45.1            3
#> 404                  97         90:56               25      23.8          315
#> 405                   6        130:51                6      31.7          159
#> 406                  70         94:25               22      28.1          253
#> 407                 188         72:25               64      20.2          334
#> 408                 163         77:25               49      18.6          342
#> 409                 239         61:43               88      36.5           54
#> 410                 206         68:32               74      29.9          202
#> 411                  98         86:44               34      32.6          133
#> 412                  60         93:22               23      30.1          195
#> 413                 160         74:01               57      39.5           23
#> 414                 122         79:55               44      24.0          314
#> 415                  78         87:58               32      32.9          125
#> 416                  46         95:02               20      33.0          123
#> 417                   2        142:31                5      33.2          122
#> 418                 177         69:03               71      25.7          291
#> 419                  24        106:27               13      35.6           72
#> 420                   7        117:04               11      30.9          170
#> 421                 155         70:21               68      22.6          319
#> 422                 280         48:18              128      30.5          185
#> 423                 215         60:58               89      25.4          298
#> 424                 222         58:13               96      28.0          254
#> 425                 242         54:31              108      29.0          224
#> 426                 123         74:08               54      31.6          161
#> 427                  96         78:37               48      36.5           56
#> 428                  22        103:00               15      27.6          263
#> 429                 146         69:35               69      21.2          326
#> 430                  79         80:59               42      32.8          127
#> 431                 106         75:33               52       9.8          347
#> 432                 292         44:38              139      32.1          146
#> 433                 345         22:58              237      29.2          217
#> 434                  75         80:05               43      25.9          287
#> 435                 339         26:08              222      32.0          150
#> 436                  34         90:48               26      22.0          323
#> 437                 311         37:37              163      25.9          285
#> 438                 135         69:00               72      36.0           61
#> 439                 152         65:37               80      28.4          240
#> 440                 202         58:35               95      21.1          328
#> 441                 209         57:58               98      28.2          248
#> 442                 270         45:49              135      33.3          119
#> 443                 251         49:13              123      18.6          343
#> 444                 335         27:18              219      37.4           43
#> 445                 212         56:10              102      25.5          296
#> 446                 129         67:17               76      29.1          219
#> 447                  87         74:03               56      32.4          140
#> 448                  94         72:32               63      29.1          218
#> 449                  40         84:40               39      26.1          282
#> 450                 211         55:18              107      30.6          181
#> 451                 314         34:13              186      28.2          244
#> 452                 166         60:17               92      25.5          295
#> 453                 226         50:11              120      24.6          307
#> 454                 250         46:13              133      29.4          212
#> 455                  63         73:31               60      30.7          178
#> 456                 170         57:55               99      32.8          129
#> 457                 179         55:21              106      35.1           80
#> 458                  20         88:55               29      26.3          278
#> 459                  67         70:52               67      28.8          228
#> 460                 141         59:57               94      26.3          277
#> 461                 318         31:03              202      16.0          346
#> 462                 299         36:04              173      36.0           60
#> 463                  93         65:19               81      39.4           24
#> 464                 344         19:53              257      38.4           34
#> 465                  52         72:05               65      38.7           30
#> 466                 249         42:47              144      33.9          107
#> 467                  13         88:39               31      28.6          234
#> 468                 104         62:49               86      29.9          201
#> 469                 289         37:09              168      27.9          257
#> 470                  44         73:36               59      28.1          251
#> 471                  14         85:22               37      34.6           87
#> 472                  12         85:09               38      25.5          297
#> 473                  26         79:29               46      35.8           66
#> 474                 137         55:58              103      26.2          279
#> 475                 321         28:02              214      22.3          322
#> 476                  99         60:21               91      35.2           78
#> 477                  28         76:01               51      33.4          118
#> 478                 265         37:17              165      43.4           10
#> 479                  16         82:39               40      33.0          124
#> 480                 336         21:47              246      35.1           79
#> 481                  80         62:01               87      33.5          116
#> 482                   1        104:16               14      28.4          239
#> 483                 330         23:43              231      33.2          121
#> 484                  61         64:28               82      27.1          271
#> 485                 331         23:15              234      39.2           25
#> 486                 131         54:15              110      30.7          177
#> 487                  51         65:40               79      29.6          205
#> 488                  56         63:13               85      30.2          192
#> 489                 324         24:39              226      36.0           63
#> 490                  47         64:13               83      24.7          306
#> 491                 158         48:58              124      21.9          324
#> 492                 187         44:54              138      34.4           94
#> 493                 278         33:40              187      27.9          258
#> 494                 279         33:25              189      35.3           77
#> 495                 286         32:47              195      44.0            9
#> 496                  84         56:37              101      27.0          272
#> 497                 290         31:52              199      37.4           42
#> 498                  10         76:57               50      36.2           59
#> 499                 107         52:58              113      32.4          138
#> 500                 118         51:23              116      32.4          137
#> 501                 210         41:29              148      37.5           41
#> 502                 205         41:57              146      27.4          264
#> 503                 178         44:19              140      24.2          312
#> 504                  17         72:44               61      34.2           99
#> 505                 236         36:59              169      21.1          327
#> 506                 207         41:15              150      25.8          290
#> 507                 117         50:11              119      32.9          126
#> 508                 140         47:50              130      34.5           90
#> 509                 196         42:00              145      31.8          157
#> 510                 261         33:20              192      33.6          110
#> 511                 101         51:24              115      44.2            7
#> 512                  21         68:33               73      18.7          341
#> 513                 244         35:32              181      34.8           84
#> 514                 245         35:19              182      33.7          109
#> 515                 334         19:12              260      31.9          156
#> 516                 231         36:06              171      33.5          115
#> 517                 189         41:01              152      31.3          165
#> 518                  64         54:11              111      28.8          231
#> 519                 276         30:31              205      36.5           55
#> 520                 293         28:42              210      28.5          236
#> 521                  66         53:23              112      36.6           51
#> 522                 175         41:52              147      28.5          237
#> 523                  42         58:04               97      35.7           69
#> 524                 214         38:03              162      42.0           14
#> 525                 224         36:05              172      33.9          108
#> 526                 124         46:39              132      32.8          130
#> 527                 298         27:32              217      32.6          135
#> 528                 248         33:23              190      26.9          273
#> 529                 134         44:57              137      42.8           11
#> 530                 341         15:34              283      30.6          182
#> 531                 269         29:44              206      24.9          304
#> 532                 119         45:21              136      34.6           88
#> 533                 312         23:35              232      34.6           89
#> 534                 219         34:44              185      25.0          301
#> 535                  83         48:26              127      40.9           16
#> 536                  71         48:47              125      32.0          152
#> 537                  58         50:14              118      25.4          299
#> 538                 186         37:12              166      28.9          227
#> 539                  85         46:52              131      38.7           31
#> 540                 116         43:03              143      29.6          207
#> 541                 220         32:47              194      29.0          221
#> 542                  31         54:24              109      29.3          214
#> 543                 151         38:47              159      32.1          145
#> 544                 149         38:14              161      34.1          103
#> 545                 176         35:53              177      18.4          344
#> 546                  19         57:39              100      32.1          147
#> 547                 243         29:22              207      28.3          241
#> 548                  50         48:28              126      39.0           28
#> 549                 180         35:09              183      21.0          329
#> 550                 255         27:38              216      20.5          332
#> 551                 338         14:38              287      34.0          104
#> 552                 253         27:27              218      27.3          266
#> 553                 173         34:57              184      34.3           98
#> 554                 153         35:37              178      30.5          183
#> 555                 184         33:03              193      37.1           45
#> 556                  86         41:15              149      33.5          113
#> 557                 102         39:30              157      39.6           22
#> 558                 113         38:38              160      24.3          311
#> 559                  29         49:45              121      37.6           39
#> 560                 185         32:14              197      30.4          187
#> 561                  77         40:45              153      38.4           33
#> 562                 115         37:10              167      25.9          286
#> 563                 192         31:17              200      31.4          163
#> 564                 133         35:34              180      34.0          105
#> 565                  18         51:40              114      30.4          189
#> 566                 159         33:20              191      25.6          294
#> 567                 273         23:29              233      26.0          284
#> 568                 121         36:01              174      35.6           73
#> 569                   5         55:45              105      27.8          259
#> 570                 120         35:54              176      32.0          151
#> 571                  65         41:01              151      34.4           95
#> 572                 316         18:22              263      29.0          220
#> 573                 193         30:31              204      44.7            5
#> 574                 300         20:36              252      32.7          131
#> 575                 230         26:41              220      30.9          171
#> 576                 111         36:23              170      35.8           64
#> 577                  32         46:08              134      33.2          120
#> 578                 156         32:33              196      32.7          132
#> 579                 165         31:55              198      34.9           83
#> 580                  38         43:25              141      29.9          200
#> 581                  23         48:16              129      32.4          139
#> 582                 100         35:59              175      27.9          256
#> 583                  59         39:39              155      30.1          193
#> 584                 191         29:08              209      29.0          222
#> 585                 294         20:36              253      30.6          180
#> 586                  11         49:24              122      37.2           44
#> 587                 259         22:39              241      34.1          101
#> 588                  49         39:37              156      28.2          242
#> 589                 264         21:29              248      34.4           96
#> 590                 282         20:10              255      31.4          164
#> 591                 262         21:07              251      28.8          229
#> 592                  37         39:08              158      36.7           50
#> 593                 320         15:26              284      25.6          293
#> 594                 139         29:20              208      30.8          176
#> 595                 295         18:14              264      44.1            8
#> 596                  43         37:18              164      30.1          194
#> 597                 150         28:16              213      31.6          162
#> 598                 162         27:46              215      30.2          191
#> 599                 287         18:53              261      32.1          144
#> 600                  69         33:26              188      29.8          203
#> 601                 181         25:31              223      39.0           29
#> 602                 128         28:40              211      40.1           19
#> 603                 304         16:07              278      24.7          305
#> 604                 296         17:13              270      33.5          114
#> 605                  35         35:34              179      31.7          158
#> 606                 322         13:48              293      32.5          136
#> 607                 307         15:24              286      26.2          280
#> 608                 203         23:14              235      22.4          320
#> 609                 325         12:18              303      27.8          260
#> 610                 213         22:07              244      31.9          154
#> 611                  62         31:16              201      39.1           27
#> 612                 340          9:20              315      40.5           18
#> 613                  15         39:39              154      28.2          245
#> 614                 208         22:14              243      29.4          211
#> 615                   3         43:24              142      33.4          117
#> 616                  81         28:32              212      38.0           37
#> 617                 285         16:11              277      25.3          300
#> 618                 130         25:04              225      32.2          142
#> 619                 283         16:04              279      20.2          335
#> 620                 108         26:11              221      35.3           76
#> 621                 138         24:16              229      30.4          186
#> 622                 169         22:45              239      45.1            4
#> 623                 247         17:51              267      29.6          208
#> 624                  39         30:42              203      31.6          160
#> 625                 237         18:02              266      36.5           57
#> 626                 308         13:10              297      35.7           67
#> 627                 144         23:00              236      39.9           21
#> 628                 234         18:05              265      33.6          111
#> 629                 217         19:13              259      31.9          155
#> 630                 266         15:35              282      37.6           38
#> 631                 263         15:44              281      30.5          184
#> 632                 327         10:19              311      32.8          128
#> 633                 157         21:28              249      32.4          141
#> 634                  74         25:12              224      30.4          188
#> 635                  91         24:01              230      28.9          226
#> 636                 197         18:30              262      26.0          283
#> 637                 216         17:21              269      28.1          249
#> 638                  68         24:29              228      37.1           46
#> 639                 110         22:17              242      44.5            6
#> 640                 204         17:44              268      37.5           40
#> 641                 225         16:17              275      35.0           81
#> 642                 114         21:23              250      35.0           82
#> 643                 310         11:08              308      25.0          303
#> 644                 301         11:54              305      28.7          232
#> 645                 256         14:16              290      34.1          100
#> 646                 257         14:10              292      25.6          292
#> 647                  72         22:41              240      37.0           47
#> 648                 309         10:45              310      36.9           48
#> 649                 333          8:00              322      33.6          112
#> 650                 267         12:52              299      29.2          216
#> 651                 229         14:17              289      34.5           91
#> 652                 328          8:17              321      24.5          309
#> 653                  90         19:55              256      31.1          168
#> 654                 171         16:52              272      28.8          230
#> 655                 241         13:26              295      29.0          225
#> 656                 198         15:25              285      33.9          106
#> 657                  45         21:50              245      35.4           75
#> 658                 275         11:33              307      34.5           93
#> 659                  82         19:24              258      24.1          313
#> 660                  33         22:51              238      35.6           71
#> 661                 164         16:00              280      31.1          167
#> 662                 127         17:01              271      30.8          174
#> 663                 254         11:49              306      23.4          317
#> 664                 306          8:59              319      30.0          197
#> 665                  27         21:46              247      38.1           36
#> 666                 199         13:17              296      23.6          316
#> 667                   4         24:29              227      38.6           32
#> 668                 326          6:46              325      26.1          281
#> 669                  25         20:18              254      29.5          209
#> 670                  73         16:15              276      24.4          310
#> 671                 145         13:35              294      38.1           35
#> 672                 112         14:36              288      31.9          153
#> 673                 291          8:24              320      35.7           70
#> 674                  48         16:30              274      40.6           17
#> 675                 235         10:05              312      29.9          198
#> 676                  41         16:44              273      29.0          223
#> 677                 148         12:26              301      28.4          238
#> 678                  88         14:12              291      29.2          215
#> 679                 332          5:12              329      32.0          149
#> 680                 143         10:59              309      30.8          172
#> 681                 218          9:04              318      30.6          179
#> 682                  76         12:32              300      30.2          190
#> 683                 284          7:10              323      45.9            2
#> 684                 200          9:08              317      34.5           92
#> 685                  54         12:52              298      27.4          265
#> 686                 342          3:37              339      20.0          337
#> 687                 272          6:51              324      29.5          210
#> 688                  55         12:16              304      28.1          252
#> 689                 168          9:24              314      28.2          246
#> 690                 302          5:42              327      42.2           13
#> 691                 323          4:37              334      30.8          173
#> 692                  95          9:11              316      32.0          148
#> 693                 288          5:07              330      27.2          267
#> 694                 343          2:44              342      31.2          166
#> 695                 238          6:04              326      42.3           12
#> 696                 281          5:04              331      30.9          169
#> 697                 305          4:23              336      41.2           15
#> 698                 277          4:53              333      36.0           62
#> 699                  30          9:40              313      29.6          206
#> 700                 268          4:34              335      27.8          262
#> 701                 329          2:52              340      36.7           49
#> 702                 274          3:59              338      29.4          213
#> 703                 167          4:57              332      28.2          243
#> 704                 315          2:45              341      34.1          102
#> 705                 337          1:56              345      28.6          233
#> 706                 109          4:05              337      35.7           68
#> 707                 221          2:39              343      30.8          175
#> 708                 172          2:07              344      39.2           26
#> 709                 317          0:48              347      25.0          302
#> 710                 195          1:13              346      29.8          204
#>     NCAA_Seed Year
#> 1          NA 2020
#> 2          NA 2020
#> 3          NA 2020
#> 4          15 2020
#> 5          NA 2020
#> 6          NA 2020
#> 7          NA 2020
#> 8          NA 2020
#> 9          NA 2020
#> 10         15 2020
#> 11         NA 2020
#> 12         NA 2020
#> 13         NA 2020
#> 14         NA 2020
#> 15         NA 2020
#> 16         NA 2020
#> 17         NA 2020
#> 18         NA 2020
#> 19         NA 2020
#> 20         NA 2020
#> 21         15 2020
#> 22         NA 2020
#> 23         NA 2020
#> 24         NA 2020
#> 25         NA 2020
#> 26         NA 2020
#> 27         NA 2020
#> 28         NA 2020
#> 29         NA 2020
#> 30         NA 2020
#> 31         NA 2020
#> 32         NA 2020
#> 33         NA 2020
#> 34         NA 2020
#> 35         NA 2020
#> 36         NA 2020
#> 37         NA 2020
#> 38         NA 2020
#> 39         NA 2020
#> 40         NA 2020
#> 41         10 2020
#> 42         NA 2020
#> 43         NA 2020
#> 44         NA 2020
#> 45         NA 2020
#> 46         NA 2020
#> 47         NA 2020
#> 48         NA 2020
#> 49         NA 2020
#> 50         NA 2020
#> 51         NA 2020
#> 52         NA 2020
#> 53         NA 2020
#> 54         NA 2020
#> 55         16 2020
#> 56         NA 2020
#> 57         NA 2020
#> 58         NA 2020
#> 59          1 2020
#> 60         NA 2020
#> 61         16 2020
#> 62         NA 2020
#> 63         NA 2020
#> 64         NA 2020
#> 65         NA 2020
#> 66         NA 2020
#> 67         NA 2020
#> 68         13 2020
#> 69         NA 2020
#> 70         NA 2020
#> 71         NA 2020
#> 72          8 2020
#> 73         NA 2020
#> 74         NA 2020
#> 75         NA 2020
#> 76         NA 2020
#> 77         NA 2020
#> 78         NA 2020
#> 79         NA 2020
#> 80         NA 2020
#> 81         NA 2020
#> 82         NA 2020
#> 83         NA 2020
#> 84         NA 2020
#> 85         NA 2020
#> 86         NA 2020
#> 87         NA 2020
#> 88         NA 2020
#> 89         NA 2020
#> 90         11 2020
#> 91         NA 2020
#> 92         NA 2020
#> 93         NA 2020
#> 94         NA 2020
#> 95         NA 2020
#> 96          5 2020
#> 97         NA 2020
#> 98         NA 2020
#> 99         NA 2020
#> 100        NA 2020
#> 101        NA 2020
#> 102        NA 2020
#> 103        NA 2020
#> 104        16 2020
#> 105        NA 2020
#> 106        NA 2020
#> 107        NA 2020
#> 108        NA 2020
#> 109        NA 2020
#> 110         1 2020
#> 111        NA 2020
#> 112        NA 2020
#> 113        NA 2020
#> 114        NA 2020
#> 115         2 2020
#> 116        NA 2020
#> 117        NA 2020
#> 118        NA 2020
#> 119        NA 2020
#> 120        NA 2020
#> 121         8 2020
#> 122        NA 2020
#> 123        NA 2020
#> 124        NA 2020
#> 125        NA 2020
#> 126        NA 2020
#> 127        NA 2020
#> 128         5 2020
#> 129        NA 2020
#> 130        NA 2020
#> 131        NA 2020
#> 132        NA 2020
#> 133        NA 2020
#> 134        NA 2020
#> 135        NA 2020
#> 136        NA 2020
#> 137        NA 2020
#> 138        NA 2020
#> 139        NA 2020
#> 140        NA 2020
#> 141        NA 2020
#> 142        NA 2020
#> 143        NA 2020
#> 144        NA 2020
#> 145        NA 2020
#> 146        NA 2020
#> 147        NA 2020
#> 148        NA 2020
#> 149        NA 2020
#> 150         2 2020
#> 151        NA 2020
#> 152        NA 2020
#> 153        NA 2020
#> 154        NA 2020
#> 155        NA 2020
#> 156        NA 2020
#> 157        NA 2020
#> 158        NA 2020
#> 159        NA 2020
#> 160         3 2020
#> 161         5 2020
#> 162        11 2020
#> 163         3 2020
#> 164         8 2020
#> 165        NA 2020
#> 166        NA 2020
#> 167        NA 2020
#> 168        13 2020
#> 169         1 2020
#> 170        NA 2020
#> 171        NA 2020
#> 172        NA 2020
#> 173        NA 2020
#> 174        13 2020
#> 175        NA 2020
#> 176        16 2020
#> 177        NA 2020
#> 178        10 2020
#> 179        NA 2020
#> 180         7 2020
#> 181        NA 2020
#> 182        NA 2020
#> 183        16 2020
#> 184        NA 2020
#> 185        NA 2020
#> 186        NA 2020
#> 187        NA 2020
#> 188        NA 2020
#> 189        NA 2020
#> 190         4 2020
#> 191        NA 2020
#> 192        NA 2020
#> 193        NA 2020
#> 194        NA 2020
#> 195        NA 2020
#> 196        NA 2020
#> 197        NA 2020
#> 198        NA 2020
#> 199         1 2020
#> 200        NA 2020
#> 201         6 2020
#> 202        NA 2020
#> 203        NA 2020
#> 204        NA 2020
#> 205        NA 2020
#> 206        NA 2020
#> 207        NA 2020
#> 208        NA 2020
#> 209        NA 2020
#> 210        NA 2020
#> 211        NA 2020
#> 212        NA 2020
#> 213        NA 2020
#> 214        14 2020
#> 215        NA 2020
#> 216         4 2020
#> 217        NA 2020
#> 218        NA 2020
#> 219        NA 2020
#> 220        NA 2020
#> 221        NA 2020
#> 222        NA 2020
#> 223        NA 2020
#> 224        NA 2020
#> 225        14 2020
#> 226        NA 2020
#> 227        NA 2020
#> 228        NA 2020
#> 229        NA 2020
#> 230        NA 2020
#> 231        NA 2020
#> 232        NA 2020
#> 233        NA 2020
#> 234        NA 2020
#> 235        NA 2020
#> 236        NA 2020
#> 237        11 2020
#> 238        NA 2020
#> 239         5 2020
#> 240        NA 2020
#> 241        NA 2020
#> 242        NA 2020
#> 243        NA 2020
#> 244        NA 2020
#> 245        NA 2020
#> 246        12 2020
#> 247        NA 2020
#> 248        NA 2020
#> 249        NA 2020
#> 250        NA 2020
#> 251        10 2020
#> 252        NA 2020
#> 253        NA 2020
#> 254        NA 2020
#> 255        NA 2020
#> 256         4 2020
#> 257        11 2020
#> 258        12 2020
#> 259        NA 2020
#> 260        NA 2020
#> 261        NA 2020
#> 262        NA 2020
#> 263        NA 2020
#> 264        NA 2020
#> 265        NA 2020
#> 266         9 2020
#> 267        NA 2020
#> 268        NA 2020
#> 269         3 2020
#> 270        NA 2020
#> 271        NA 2020
#> 272        NA 2020
#> 273        NA 2020
#> 274        NA 2020
#> 275        NA 2020
#> 276        NA 2020
#> 277        NA 2020
#> 278        NA 2020
#> 279        NA 2020
#> 280         4 2020
#> 281        NA 2020
#> 282        12 2020
#> 283        16 2020
#> 284        NA 2020
#> 285        NA 2020
#> 286        NA 2020
#> 287         2 2020
#> 288        10 2020
#> 289         9 2020
#> 290        NA 2020
#> 291        NA 2020
#> 292         6 2020
#> 293        NA 2020
#> 294        NA 2020
#> 295        NA 2020
#> 296        NA 2020
#> 297        NA 2020
#> 298        NA 2020
#> 299        NA 2020
#> 300         6 2020
#> 301        NA 2020
#> 302        NA 2020
#> 303        NA 2020
#> 304        NA 2020
#> 305        NA 2020
#> 306        NA 2020
#> 307        NA 2020
#> 308        NA 2020
#> 309        NA 2020
#> 310        NA 2020
#> 311        NA 2020
#> 312        NA 2020
#> 313        NA 2020
#> 314        14 2020
#> 315         9 2020
#> 316        NA 2020
#> 317        NA 2020
#> 318        12 2020
#> 319         8 2020
#> 320        NA 2020
#> 321        NA 2020
#> 322        NA 2020
#> 323        NA 2020
#> 324        NA 2020
#> 325        NA 2020
#> 326        NA 2020
#> 327         7 2020
#> 328        NA 2020
#> 329         7 2020
#> 330        NA 2020
#> 331         7 2020
#> 332        NA 2020
#> 333        NA 2020
#> 334        NA 2020
#> 335        13 2020
#> 336         9 2020
#> 337        15 2020
#> 338        11 2020
#> 339         6 2020
#> 340        NA 2020
#> 341         2 2020
#> 342        14 2020
#> 343        NA 2020
#> 344        NA 2020
#> 345        NA 2020
#> 346        NA 2020
#> 347        NA 2020
#> 348        NA 2020
#> 349        NA 2020
#> 350        11 2020
#> 351        NA 2020
#> 352         3 2020
#> 353        NA 2020
#> 354        NA 2021
#> 355        NA 2021
#> 356        NA 2021
#> 357        NA 2021
#> 358        NA 2021
#> 359        NA 2021
#> 360        NA 2021
#> 361        NA 2021
#> 362        NA 2021
#> 363        NA 2021
#> 364        NA 2021
#> 365        NA 2021
#> 366         9 2021
#> 367        NA 2021
#> 368        NA 2021
#> 369        NA 2021
#> 370        NA 2021
#> 371        NA 2021
#> 372        NA 2021
#> 373        11 2021
#> 374        NA 2021
#> 375        NA 2021
#> 376        NA 2021
#> 377        15 2021
#> 378        NA 2021
#> 379        NA 2021
#> 380        NA 2021
#> 381        NA 2021
#> 382        NA 2021
#> 383        NA 2021
#> 384        NA 2021
#> 385        NA 2021
#> 386        NA 2021
#> 387        NA 2021
#> 388        NA 2021
#> 389        NA 2021
#> 390        NA 2021
#> 391        NA 2021
#> 392        NA 2021
#> 393        NA 2021
#> 394        15 2021
#> 395        NA 2021
#> 396        NA 2021
#> 397        NA 2021
#> 398        NA 2021
#> 399        NA 2021
#> 400        NA 2021
#> 401        16 2021
#> 402        NA 2021
#> 403        NA 2021
#> 404        NA 2021
#> 405        NA 2021
#> 406        NA 2021
#> 407        NA 2021
#> 408        NA 2021
#> 409        NA 2021
#> 410        NA 2021
#> 411        NA 2021
#> 412        NA 2021
#> 413        NA 2021
#> 414        NA 2021
#> 415        NA 2021
#> 416        NA 2021
#> 417        NA 2021
#> 418        NA 2021
#> 419        NA 2021
#> 420        NA 2021
#> 421        NA 2021
#> 422        NA 2021
#> 423        NA 2021
#> 424        NA 2021
#> 425        NA 2021
#> 426        NA 2021
#> 427        14 2021
#> 428        NA 2021
#> 429        NA 2021
#> 430        NA 2021
#> 431         9 2021
#> 432        NA 2021
#> 433        NA 2021
#> 434        13 2021
#> 435        NA 2021
#> 436        NA 2021
#> 437        NA 2021
#> 438        NA 2021
#> 439        NA 2021
#> 440        NA 2021
#> 441        NA 2021
#> 442        NA 2021
#> 443        NA 2021
#> 444        NA 2021
#> 445        NA 2021
#> 446        NA 2021
#> 447         6 2021
#> 448        NA 2021
#> 449        NA 2021
#> 450        NA 2021
#> 451        NA 2021
#> 452         3 2021
#> 453        13 2021
#> 454        NA 2021
#> 455        NA 2021
#> 456        NA 2021
#> 457        NA 2021
#> 458        NA 2021
#> 459        NA 2021
#> 460         8 2021
#> 461        NA 2021
#> 462        NA 2021
#> 463        NA 2021
#> 464        NA 2021
#> 465        NA 2021
#> 466        NA 2021
#> 467         1 2021
#> 468        NA 2021
#> 469        NA 2021
#> 470        NA 2021
#> 471        NA 2021
#> 472        16 2021
#> 473        NA 2021
#> 474        10 2021
#> 475        NA 2021
#> 476        NA 2021
#> 477        NA 2021
#> 478        NA 2021
#> 479         2 2021
#> 480        NA 2021
#> 481        NA 2021
#> 482        NA 2021
#> 483        NA 2021
#> 484        NA 2021
#> 485        NA 2021
#> 486        NA 2021
#> 487        NA 2021
#> 488        NA 2021
#> 489        NA 2021
#> 490        NA 2021
#> 491        NA 2021
#> 492        NA 2021
#> 493        16 2021
#> 494        NA 2021
#> 495        NA 2021
#> 496        NA 2021
#> 497        NA 2021
#> 498        13 2021
#> 499        NA 2021
#> 500        NA 2021
#> 501        NA 2021
#> 502        NA 2021
#> 503        NA 2021
#> 504         4 2021
#> 505        NA 2021
#> 506        14 2021
#> 507        NA 2021
#> 508        NA 2021
#> 509         8 2021
#> 510        NA 2021
#> 511        NA 2021
#> 512        NA 2021
#> 513         8 2021
#> 514        NA 2021
#> 515        NA 2021
#> 516        NA 2021
#> 517        NA 2021
#> 518        NA 2021
#> 519        NA 2021
#> 520        10 2021
#> 521        NA 2021
#> 522         7 2021
#> 523        NA 2021
#> 524        12 2021
#> 525        NA 2021
#> 526        NA 2021
#> 527        NA 2021
#> 528        NA 2021
#> 529        NA 2021
#> 530        NA 2021
#> 531        NA 2021
#> 532        14 2021
#> 533        NA 2021
#> 534        NA 2021
#> 535        NA 2021
#> 536        11 2021
#> 537        NA 2021
#> 538        NA 2021
#> 539         4 2021
#> 540         2 2021
#> 541        NA 2021
#> 542        NA 2021
#> 543        NA 2021
#> 544        NA 2021
#> 545        NA 2021
#> 546        NA 2021
#> 547        11 2021
#> 548        NA 2021
#> 549        12 2021
#> 550        NA 2021
#> 551        NA 2021
#> 552        NA 2021
#> 553        NA 2021
#> 554        NA 2021
#> 555        NA 2021
#> 556        NA 2021
#> 557        NA 2021
#> 558         1 2021
#> 559        NA 2021
#> 560        NA 2021
#> 561        NA 2021
#> 562        NA 2021
#> 563        NA 2021
#> 564        NA 2021
#> 565        NA 2021
#> 566        NA 2021
#> 567        NA 2021
#> 568        NA 2021
#> 569         3 2021
#> 570        NA 2021
#> 571        NA 2021
#> 572        12 2021
#> 573        NA 2021
#> 574        NA 2021
#> 575        NA 2021
#> 576        NA 2021
#> 577        NA 2021
#> 578        16 2021
#> 579        NA 2021
#> 580         3 2021
#> 581         9 2021
#> 582        NA 2021
#> 583        NA 2021
#> 584        NA 2021
#> 585        NA 2021
#> 586        NA 2021
#> 587        NA 2021
#> 588        NA 2021
#> 589        NA 2021
#> 590        NA 2021
#> 591        NA 2021
#> 592        NA 2021
#> 593        NA 2021
#> 594        NA 2021
#> 595        NA 2021
#> 596        NA 2021
#> 597        NA 2021
#> 598        NA 2021
#> 599        NA 2021
#> 600         3 2021
#> 601        NA 2021
#> 602        NA 2021
#> 603        NA 2021
#> 604        NA 2021
#> 605        NA 2021
#> 606        NA 2021
#> 607        NA 2021
#> 608        10 2021
#> 609        NA 2021
#> 610        NA 2021
#> 611        NA 2021
#> 612        NA 2021
#> 613        NA 2021
#> 614        NA 2021
#> 615        NA 2021
#> 616        NA 2021
#> 617        NA 2021
#> 618        NA 2021
#> 619        NA 2021
#> 620        NA 2021
#> 621        NA 2021
#> 622        NA 2021
#> 623        NA 2021
#> 624        NA 2021
#> 625         6 2021
#> 626        NA 2021
#> 627        NA 2021
#> 628        NA 2021
#> 629        NA 2021
#> 630         7 2021
#> 631        NA 2021
#> 632        NA 2021
#> 633        NA 2021
#> 634         5 2021
#> 635        NA 2021
#> 636        NA 2021
#> 637         1 2021
#> 638        NA 2021
#> 639        NA 2021
#> 640        NA 2021
#> 641        NA 2021
#> 642         6 2021
#> 643         1 2021
#> 644         6 2021
#> 645        NA 2021
#> 646         5 2021
#> 647        NA 2021
#> 648        NA 2021
#> 649        14 2021
#> 650        NA 2021
#> 651        NA 2021
#> 652        NA 2021
#> 653        NA 2021
#> 654         9 2021
#> 655        NA 2021
#> 656        NA 2021
#> 657        10 2021
#> 658        NA 2021
#> 659        NA 2021
#> 660         7 2021
#> 661        NA 2021
#> 662        NA 2021
#> 663         5 2021
#> 664        NA 2021
#> 665        NA 2021
#> 666        NA 2021
#> 667        11 2021
#> 668        16 2021
#> 669         2 2021
#> 670        15 2021
#> 671        NA 2021
#> 672         5 2021
#> 673        NA 2021
#> 674        16 2021
#> 675        NA 2021
#> 676        NA 2021
#> 677        NA 2021
#> 678        15 2021
#> 679        NA 2021
#> 680        NA 2021
#> 681        NA 2021
#> 682        NA 2021
#> 683        NA 2021
#> 684        NA 2021
#> 685        11 2021
#> 686         4 2021
#> 687         8 2021
#> 688        NA 2021
#> 689        NA 2021
#> 690        NA 2021
#> 691        NA 2021
#> 692        NA 2021
#> 693        13 2021
#> 694        NA 2021
#> 695        NA 2021
#> 696        NA 2021
#> 697        NA 2021
#> 698        NA 2021
#> 699        12 2021
#> 700        NA 2021
#> 701        NA 2021
#> 702        NA 2021
#> 703        NA 2021
#> 704        NA 2021
#> 705        NA 2021
#> 706        NA 2021
#> 707         2 2021
#> 708         4 2021
#> 709        11 2021
#> 710         7 2021
# }
```
