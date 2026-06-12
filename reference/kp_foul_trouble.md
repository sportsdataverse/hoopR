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
#> ✖ 2026-06-12 14:42:29.991601: Invalid arguments or no foul trouble data for 2020 - 2026 available!
#> ✖ Args: min_year = 2020, max_year = 2026
#> ✖ Error: subscript out of bounds
#>                        Team Conf TwoFoulParticpation.Pct
#> 1              Georgia Tech  ACC                    68.7
#> 2                  Ball St.  MAC                    61.2
#> 3                  Delaware  CAA                    57.3
#> 4               Little Rock   SB                    56.4
#> 5                   Oakland Horz                    55.8
#> 6                  Syracuse  ACC                    54.0
#> 7                 Merrimack  NEC                    53.6
#> 8          Eastern Michigan  MAC                    52.7
#> 9                      Army  Pat                    52.3
#> 10       Eastern Washington BSky                    52.1
#> 11               Binghamton   AE                    51.3
#> 12            Southern Miss CUSA                    50.9
#> 13               Washington  P12                    49.7
#> 14               Coppin St. MEAC                    49.6
#> 15              McNeese St. Slnd                    48.8
#> 16            San Francisco  WCC                    48.3
#> 17            North Florida ASun                    48.1
#> 18                    IUPUI Horz                    48.0
#> 19                Minnesota  B10                    47.7
#> 20              Florida A&M MEAC                    47.3
#> 21        Northern Kentucky Horz                    46.8
#> 22         Central Michigan  MAC                    45.6
#> 23           Washington St.  P12                    45.0
#> 24                  Fordham  A10                    44.7
#> 25                Louisiana   SB                    44.1
#> 26               New Mexico  MWC                    43.8
#> 27                    Brown  Ivy                    43.7
#> 28                  Detroit Horz                    43.5
#> 29             South Dakota  Sum                    43.2
#> 30           Incarnate Word Slnd                    42.6
#> 31                      FIU CUSA                    42.2
#> 32           Sacramento St. BSky                    42.2
#> 33                   Toledo  MAC                    42.1
#> 34                     Penn  Ivy                    41.8
#> 35         Tennessee Martin  OVC                    41.8
#> 36             Colorado St.  MWC                    41.4
#> 37          Bethune Cookman MEAC                    41.2
#> 38                  Alabama  SEC                    40.7
#> 39      Cal St. Bakersfield  WAC                    40.6
#> 40              The Citadel   SC                    40.4
#> 41               Texas Tech  B12                    38.5
#> 42              Mississippi  SEC                    38.3
#> 43            North Alabama ASun                    38.2
#> 44                  Hampton BSth                    37.9
#> 45                  Seattle  WAC                    37.7
#> 46                   Howard MEAC                    37.4
#> 47                      LIU  NEC                    36.9
#> 48       Cal St. Northridge   BW                    36.6
#> 49                   Tulane Amer                    36.4
#> 50               Pepperdine  WCC                    35.9
#> 51             Rhode Island  A10                    35.7
#> 52                  Cornell  Ivy                    35.5
#> 53                   Furman   SC                    35.4
#> 54                  Georgia  SEC                    35.3
#> 55   North Carolina Central MEAC                    35.3
#> 56         Central Arkansas Slnd                    34.3
#> 57                     NJIT ASun                    34.1
#> 58              Santa Clara  WCC                    34.1
#> 59                   Kansas  B12                    34.0
#> 60                     UTSA CUSA                    33.8
#> 61         Prairie View A&M SWAC                    33.3
#> 62   Mississippi Valley St. SWAC                    33.0
#> 63             North Dakota  Sum                    32.9
#> 64                   Bryant  NEC                    32.9
#> 65            Grambling St. SWAC                    32.7
#> 66           Tennessee Tech  OVC                    32.3
#> 67         Western Carolina   SC                    32.2
#> 68                    Akron  MAC                    32.0
#> 69             Sacred Heart  NEC                    31.6
#> 70                 Duquesne  A10                    31.4
#> 71           North Carolina  ACC                    31.4
#> 72                      LSU  SEC                    31.1
#> 73      Arkansas Pine Bluff SWAC                    30.9
#> 74                 Lipscomb ASun                    30.8
#> 75                    Maine   AE                    30.3
#> 76                 Portland  WCC                    30.1
#> 77              Chicago St.  WAC                    30.0
#> 78               Notre Dame  ACC                    30.0
#> 79             Northeastern  CAA                    30.0
#> 80                     UMBC   AE                    29.6
#> 81           Saint Joseph's  A10                    29.6
#> 82                     UNLV  MWC                    29.5
#> 83             Kennesaw St. ASun                    29.5
#> 84      Fairleigh Dickinson  NEC                    29.4
#> 85           St. Francis PA  NEC                    29.4
#> 86            UNC Asheville BSth                    29.3
#> 87                San Diego  WCC                    29.2
#> 88         Northwestern St. Slnd                    29.2
#> 89             Grand Canyon  WAC                    29.1
#> 90                 Utah St.  MWC                    29.1
#> 91             UMass Lowell   AE                    29.0
#> 92                Boise St.  MWC                    28.9
#> 93                   Wagner  NEC                    28.9
#> 94         Northern Arizona BSky                    28.8
#> 95              Alabama A&M SWAC                    28.7
#> 96                   Auburn  SEC                    28.4
#> 97         Georgia Southern   SB                    28.2
#> 98                 Canisius MAAC                    28.2
#> 99               Holy Cross  Pat                    28.0
#> 100                   Texas  B12                    28.0
#> 101                    Ohio  MAC                    28.0
#> 102              Fresno St.  MWC                    27.7
#> 103        Louisiana Monroe   SB                    27.7
#> 104           Robert Morris  NEC                    27.7
#> 105       George Washington  A10                    27.5
#> 106                American  Pat                    27.4
#> 107            Presbyterian BSth                    27.4
#> 108               Green Bay Horz                    27.3
#> 109                  Xavier   BE                    27.2
#> 110                  Baylor  B12                    27.1
#> 111              Murray St.  OVC                    27.0
#> 112                 Montana BSky                    26.8
#> 113  Southeastern Louisiana Slnd                    26.8
#> 114                Iowa St.  B12                    26.5
#> 115               Creighton   BE                    26.3
#> 116             New Orleans Slnd                    26.3
#> 117                UC Davis   BW                    26.1
#> 118              Pittsburgh  ACC                    26.0
#> 119             Saint Louis  A10                    26.0
#> 120               Tennessee  SEC                    25.9
#> 121            Saint Mary's  WCC                    25.6
#> 122              Quinnipiac MAAC                    25.5
#> 123                 Colgate  Pat                    25.5
#> 124          Boston College  ACC                    25.4
#> 125       Cal St. Fullerton   BW                    25.4
#> 126           Cleveland St. Horz                    25.3
#> 127             Cal Baptist  WAC                    25.2
#> 128                  Butler   BE                    25.2
#> 129                Miami FL  ACC                    25.2
#> 130  Texas A&M Corpus Chris Slnd                    25.2
#> 131                 Harvard  Ivy                    25.1
#> 132             Jackson St. SWAC                    25.1
#> 133                  Nevada  MWC                    25.1
#> 134           South Alabama   SB                    24.9
#> 135                   Lamar Slnd                    24.8
#> 136                Southern SWAC                    24.8
#> 137        Mount St. Mary's  NEC                    24.7
#> 138        Coastal Carolina   SB                    24.5
#> 139           New Hampshire   AE                    24.4
#> 140  Maryland Eastern Shore MEAC                    24.2
#> 141           Virginia Tech  ACC                    23.8
#> 142                Nebraska  B10                    23.7
#> 143            Portland St. BSky                    23.6
#> 144                Arkansas  SEC                    23.3
#> 145           Tennessee St.  OVC                    23.1
#> 146              Georgetown   BE                    23.1
#> 147              Evansville  MVC                    22.9
#> 148              California  P12                    22.9
#> 149          Long Beach St.   BW                    22.8
#> 150               Villanova   BE                    22.8
#> 151     Charleston Southern BSth                    22.8
#> 152            Oral Roberts  Sum                    22.5
#> 153                   Drake  MVC                    22.4
#> 154            San Jose St.  MWC                    22.4
#> 155          Youngstown St. Horz                    22.3
#> 156               Manhattan MAAC                    22.2
#> 157             Chattanooga   SC                    22.1
#> 158                    Troy   SB                    21.9
#> 159                Monmouth MAAC                    21.9
#> 160              Seton Hall   BE                    21.9
#> 161                Ohio St.  B10                    21.9
#> 162      East Tennessee St.   SC                    21.8
#> 163                    Duke  ACC                    21.6
#> 164              Providence   BE                    21.6
#> 165                    Elon  CAA                    21.5
#> 166              Kansas St.  B12                    21.4
#> 167              Morgan St. MEAC                    21.4
#> 168             North Texas CUSA                    21.3
#> 169                 Gonzaga  WCC                    21.2
#> 170               Loyola MD  Pat                    21.1
#> 171              Charleston  CAA                    21.0
#> 172            Missouri St.  MVC                    20.9
#> 173                Missouri  SEC                    20.8
#> 174                 Vermont   AE                    20.8
#> 175        Western Kentucky CUSA                    20.6
#> 176                Winthrop BSth                    20.6
#> 177             Connecticut Amer                    20.4
#> 178             Arizona St.  P12                    20.3
#> 179                   Rider MAAC                    20.0
#> 180                 Arizona  P12                    20.0
#> 181                  Temple Amer                    20.0
#> 182            Delaware St. MEAC                    19.9
#> 183       Boston University  Pat                    19.9
#> 184               Texas A&M  SEC                    19.8
#> 185                 Samford   SC                    19.8
#> 186       Northern Colorado BSky                    19.8
#> 187       Southern Illinois  MVC                    19.8
#> 188                Hartford   AE                    19.6
#> 189                     VMI   SC                    19.4
#> 190               Wisconsin  B10                    19.4
#> 191                    Utah  P12                    19.4
#> 192                 Buffalo  MAC                    19.0
#> 193        Western Michigan  MAC                    18.6
#> 194       Abilene Christian Slnd                    18.6
#> 195        Middle Tennessee CUSA                    18.4
#> 196                  Mercer   SC                    18.3
#> 197                  DePaul   BE                    18.3
#> 198         Mississippi St.  SEC                    18.2
#> 199                  Dayton  A10                    18.2
#> 200                 Wyoming  MWC                    18.1
#> 201                Penn St.  B10                    17.8
#> 202            Northwestern  B10                    17.6
#> 203                  Towson  CAA                    17.6
#> 204     Central Connecticut  NEC                    17.6
#> 205                 Wofford   SC                    17.5
#> 206                   Idaho BSky                    17.5
#> 207                  Denver  Sum                    17.5
#> 208            Morehead St.  OVC                    17.1
#> 209                 Pacific  WCC                    17.1
#> 210       Northern Illinois  MAC                    17.0
#> 211               Princeton  Ivy                    17.0
#> 212            Jacksonville ASun                    16.8
#> 213               Milwaukee Horz                    16.6
#> 214                 Bradley  MVC                    16.6
#> 215                Stanford  P12                    16.6
#> 216                Kentucky  SEC                    16.5
#> 217            Arkansas St.   SB                    16.5
#> 218          UNC Wilmington  CAA                    16.5
#> 219                    Iona MAAC                    16.4
#> 220           James Madison  CAA                    16.3
#> 221                Kent St.  MAC                    16.3
#> 222                  Purdue  B10                    16.2
#> 223             Stony Brook   AE                    16.0
#> 224                Columbia  Ivy                    16.0
#> 225                 Hofstra  CAA                    16.0
#> 226          UNC Greensboro   SC                    15.6
#> 227            Old Dominion CUSA                    15.6
#> 228                  Hawaii   BW                    15.6
#> 229            Gardner Webb BSth                    15.2
#> 230             Austin Peay  OVC                    15.2
#> 231                     UAB CUSA                    15.1
#> 232             Wake Forest  ACC                    15.0
#> 233                 Clemson  ACC                    15.0
#> 234               Lafayette  Pat                    14.9
#> 235            Illinois St.  MVC                    14.9
#> 236          Loyola Chicago  MVC                    14.9
#> 237              N.C. State  ACC                    14.7
#> 238         St. Bonaventure  A10                    14.6
#> 239                     BYU  WCC                    14.6
#> 240           Southern Utah BSky                    14.5
#> 241                Longwood BSth                    14.5
#> 242              Valparaiso  MVC                    14.4
#> 243                  Drexel  CAA                    14.2
#> 244              Vanderbilt  SEC                    14.2
#> 245                     TCU  B12                    14.2
#> 246              Cincinnati Amer                    14.0
#> 247         Sam Houston St. Slnd                    14.0
#> 248          Nebraska Omaha  Sum                    14.0
#> 249                  Lehigh  Pat                    13.9
#> 250               Weber St. BSky                    13.8
#> 251                Oklahoma  B12                    13.7
#> 252                    UMKC  WAC                    13.5
#> 253                Bucknell  Pat                    13.4
#> 254            UT Arlington   SB                    13.4
#> 255          Texas Southern SWAC                    13.4
#> 256                  Oregon  P12                    13.3
#> 257                    UCLA  P12                    13.3
#> 258       Stephen F. Austin Slnd                    13.2
#> 259        Eastern Kentucky  OVC                    13.1
#> 260             USC Upstate BSth                    12.9
#> 261                     SMU Amer                    12.8
#> 262                Marshall CUSA                    12.8
#> 263              St. John's   BE                    12.8
#> 264                 Stetson ASun                    12.8
#> 265              Wright St. Horz                    12.7
#> 266                     USC  P12                    12.6
#> 267                Miami OH  MAC                    12.6
#> 268            Nicholls St. Slnd                    12.4
#> 269                Maryland  B10                    12.4
#> 270         Appalachian St.   SB                    12.4
#> 271             Georgia St.   SB                    12.3
#> 272             Indiana St.  MVC                    12.2
#> 273            George Mason  A10                    12.2
#> 274           Northern Iowa  MVC                    12.1
#> 275          William & Mary  CAA                    12.1
#> 276               Texas St.   SB                    12.0
#> 277            Oklahoma St.  B12                    12.0
#> 278                Cal Poly   BW                    11.7
#> 279               Idaho St. BSky                    11.7
#> 280              Louisville  ACC                    11.7
#> 281        Loyola Marymount  WCC                    11.7
#> 282                    Yale  Ivy                    11.6
#> 283                   Siena MAAC                    11.6
#> 284        Florida Atlantic CUSA                    11.4
#> 285    UT Rio Grande Valley  WAC                    11.4
#> 286      South Carolina St. MEAC                    11.3
#> 287           San Diego St.  MWC                    11.1
#> 288                 Indiana  B10                    11.0
#> 289                 Rutgers  B10                    10.9
#> 290               Air Force  MWC                    10.9
#> 291             Utah Valley  WAC                    10.9
#> 292           West Virginia  B12                    10.8
#> 293                  Albany   AE                    10.7
#> 294                    Rice CUSA                    10.7
#> 295      North Carolina A&T MEAC                    10.5
#> 296              Alcorn St. SWAC                    10.3
#> 297                     VCU  A10                    10.1
#> 298                   Tulsa Amer                     9.9
#> 299          Louisiana Tech CUSA                     9.8
#> 300                    Iowa  B10                     9.4
#> 301             Alabama St. SWAC                     9.2
#> 302         Houston Baptist Slnd                     9.1
#> 303          St. Francis NY  NEC                     9.0
#> 304        UC Santa Barbara   BW                     9.0
#> 305                    UTEP CUSA                     8.7
#> 306                 Niagara MAAC                     8.5
#> 307                  Marist MAAC                     8.4
#> 308            UC Riverside   BW                     8.3
#> 309        South Dakota St.  Sum                     8.3
#> 310        SIU Edwardsville  OVC                     8.3
#> 311        Jacksonville St.  OVC                     8.2
#> 312                 Radford BSth                     8.2
#> 313        Illinois Chicago Horz                     8.0
#> 314               UC Irvine   BW                     8.0
#> 315               Marquette   BE                     7.9
#> 316          South Carolina  SEC                     7.8
#> 317           Massachusetts  A10                     7.8
#> 318                 Liberty ASun                     7.6
#> 319                Colorado  P12                     7.5
#> 320  Southeast Missouri St.  OVC                     7.2
#> 321              Oregon St.  P12                     7.0
#> 322             Norfolk St. MEAC                     6.4
#> 323       Purdue Fort Wayne  Sum                     6.2
#> 324           Saint Peter's MAAC                     6.2
#> 325              High Point BSth                     6.1
#> 326               Dartmouth  Ivy                     6.1
#> 327                Virginia  ACC                     6.0
#> 328             Montana St. BSky                     6.0
#> 329                Illinois  B10                     6.0
#> 330                La Salle  A10                     5.9
#> 331                 Houston Amer                     5.8
#> 332                 Memphis Amer                     5.7
#> 333               Charlotte CUSA                     5.7
#> 334               Fairfield MAAC                     5.7
#> 335          New Mexico St.  WAC                     5.6
#> 336                 Florida  SEC                     5.3
#> 337        North Dakota St.  Sum                     5.3
#> 338                Richmond  A10                     4.9
#> 339                Michigan  B10                     4.9
#> 340      Florida Gulf Coast ASun                     4.9
#> 341             Florida St.  ACC                     4.4
#> 342                 Belmont  OVC                     4.3
#> 343           Bowling Green  MAC                     4.2
#> 344                    Navy  Pat                     4.2
#> 345                Davidson  A10                     4.0
#> 346        Eastern Illinois  OVC                     4.0
#> 347                     UCF Amer                     3.6
#> 348           South Florida Amer                     3.2
#> 349           East Carolina Amer                     3.1
#> 350             Wichita St. Amer                     2.6
#> 351                Campbell BSth                     2.5
#> 352            Michigan St.  B10                     2.1
#> 353        Western Illinois  Sum                     1.7
#> 354             Alabama A&M SWAC                    85.0
#> 355         Bethune Cookman MEAC                     0.0
#> 356                   Brown  Ivy                     0.0
#> 357                Columbia  Ivy                     0.0
#> 358                 Cornell  Ivy                     0.0
#> 359               Dartmouth  Ivy                     0.0
#> 360                 Harvard  Ivy                     0.0
#> 361  Maryland Eastern Shore MEAC                     0.0
#> 362                    Penn  Ivy                     0.0
#> 363               Princeton  Ivy                     0.0
#> 364                    Yale  Ivy                     0.0
#> 365                  Howard MEAC                    69.8
#> 366            Georgia Tech  ACC                    66.7
#> 367             Little Rock   SB                    66.3
#> 368                 Fordham  A10                    62.9
#> 369               Air Force  MWC                    59.6
#> 370                 Detroit Horz                    58.2
#> 371           North Florida ASun                    58.1
#> 372           San Francisco  WCC                    58.0
#> 373                Syracuse  ACC                    56.6
#> 374       Northern Kentucky Horz                    54.8
#> 375                Delaware  CAA                    53.4
#> 376                 Oakland Horz                    53.3
#> 377            Oral Roberts  Sum                    53.1
#> 378                  Bryant  NEC                    52.4
#> 379              Alcorn St. SWAC                    51.4
#> 380  Mississippi Valley St. SWAC                    50.3
#> 381        Eastern Michigan  MAC                    50.2
#> 382             Cal Baptist  WAC                    49.0
#> 383                 Pacific  WCC                    48.0
#> 384             Florida A&M MEAC                    47.9
#> 385              Coppin St. MEAC                    47.8
#> 386               Merrimack  NEC                    46.9
#> 387             Chicago St.  WAC                    46.6
#> 388                   IUPUI Horz                    46.5
#> 389                  Toledo  MAC                    46.1
#> 390                Ball St.  MAC                    46.1
#> 391        Prairie View A&M SWAC                    46.0
#> 392          St. Francis PA  NEC                    45.3
#> 393      Cal St. Northridge   BW                    44.7
#> 394            Grand Canyon  WAC                    44.1
#> 395            Colorado St.  MWC                    43.8
#> 396                 Georgia  SEC                    43.7
#> 397                  Tulane Amer                    43.5
#> 398           Southern Miss CUSA                    42.8
#> 399          Sacramento St. BSky                    42.4
#> 400                Portland  WCC                    42.2
#> 401        Mount St. Mary's  NEC                    41.9
#> 402     Fairleigh Dickinson  NEC                    41.9
#> 403                 Samford   SC                    41.9
#> 404            Tarleton St.  WAC                    41.6
#> 405                Iowa St.  B12                    41.4
#> 406            Saint Mary's  WCC                    41.0
#> 407              Notre Dame  ACC                    40.9
#> 408                 Hofstra  CAA                    40.9
#> 409       Northern Illinois  MAC                    40.7
#> 410                 Wofford   SC                    40.1
#> 411        Central Arkansas Slnd                    39.8
#> 412                    NJIT   AE                    39.2
#> 413  North Carolina Central MEAC                    39.0
#> 414                  Furman   SC                    38.8
#> 415               Manhattan MAAC                    38.6
#> 416             McNeese St. Slnd                    38.0
#> 417              Washington  P12                    38.0
#> 418                 Buffalo  MAC                    37.8
#> 419  Southeastern Louisiana Slnd                    37.3
#> 420                 Wyoming  MWC                    37.2
#> 421                 Seattle  WAC                    36.8
#> 422              Fresno St.  MWC                    36.8
#> 423             Chattanooga   SC                    36.7
#> 424          Youngstown St. Horz                    36.3
#> 425                    Elon  CAA                    36.2
#> 426     Arkansas Pine Bluff SWAC                    36.0
#> 427       Abilene Christian Slnd                    35.9
#> 428              Pepperdine  WCC                    35.9
#> 429             The Citadel   SC                    35.8
#> 430                    UTSA CUSA                    35.6
#> 431         St. Bonaventure  A10                    35.5
#> 432                  Xavier   BE                    35.5
#> 433            UC San Diego   BW                    35.2
#> 434             North Texas CUSA                    35.1
#> 435                American  Pat                    34.9
#> 436                  Wagner  NEC                    34.5
#> 437               Lafayette  Pat                    34.4
#> 438           Robert Morris Horz                    34.2
#> 439              Providence   BE                    34.1
#> 440              Louisville  ACC                    34.1
#> 441                    Army  Pat                    34.1
#> 442        Central Michigan  MAC                    33.9
#> 443           South Alabama   SB                    33.9
#> 444               San Diego  WCC                    33.8
#> 445                     LIU  NEC                    33.5
#> 446            South Dakota  Sum                    33.2
#> 447              Texas Tech  B12                    33.1
#> 448        Loyola Marymount  WCC                    33.1
#> 449                    UNLV  MWC                    33.0
#> 450          Incarnate Word Slnd                    32.9
#> 451              Binghamton   AE                    32.1
#> 452                  Kansas  B12                    32.0
#> 453                    Ohio  MAC                    31.8
#> 454            Northeastern  CAA                    31.8
#> 455                Kent St.  MAC                    31.1
#> 456                Longwood BSth                    30.8
#> 457        Northern Arizona BSky                    30.5
#> 458          UNC Wilmington  CAA                    30.4
#> 459        Western Carolina   SC                    30.3
#> 460                     LSU  SEC                    30.2
#> 461                     VMI   SC                    29.9
#> 462                  Towson  CAA                    29.8
#> 463          Washington St.  P12                    29.7
#> 464              New Mexico  MWC                    29.4
#> 465            Rhode Island  A10                    29.3
#> 466          Boston College  ACC                    29.3
#> 467                  Baylor  B12                    29.2
#> 468       Stephen F. Austin Slnd                    29.2
#> 469          William & Mary  CAA                    29.1
#> 470                   Lamar Slnd                    29.0
#> 471             Arizona St.  P12                    28.2
#> 472                Hartford   AE                    28.0
#> 473               Minnesota  B10                    28.0
#> 474                 Rutgers  B10                    27.9
#> 475                   Siena MAAC                    27.8
#> 476           North Alabama ASun                    27.7
#> 477                 Arizona  P12                    27.5
#> 478    UT Rio Grande Valley  WAC                    27.5
#> 479                 Alabama  SEC                    27.4
#> 480       Boston University  Pat                    27.4
#> 481                  Auburn  SEC                    27.4
#> 482                    UMKC  Sum                    27.3
#> 483                 Niagara MAAC                    27.3
#> 484              Morgan St. MEAC                    27.2
#> 485        Middle Tennessee CUSA                    27.2
#> 486             Santa Clara  WCC                    26.8
#> 487               Boise St.  MWC                    26.6
#> 488        Illinois Chicago Horz                    26.2
#> 489       George Washington  A10                    26.1
#> 490                    Duke  ACC                    25.7
#> 491            Missouri St.  MVC                    25.7
#> 492     Charleston Southern BSth                    25.3
#> 493                  Drexel  CAA                    25.3
#> 494           James Madison  CAA                    25.2
#> 495                     FIU CUSA                    25.2
#> 496            Presbyterian BSth                    25.1
#> 497                   Maine   AE                    25.1
#> 498          UNC Greensboro   SC                    25.0
#> 499          Tennessee Tech  OVC                    24.9
#> 500            San Jose St.  MWC                    24.8
#> 501           Grambling St. SWAC                    24.6
#> 502            Kennesaw St. ASun                    24.5
#> 503              Seton Hall   BE                    24.4
#> 504            Oklahoma St.  B12                    24.3
#> 505              Evansville  MVC                    24.2
#> 506            Morehead St.  OVC                    24.1
#> 507            UMass Lowell   AE                    24.1
#> 508              California  P12                    24.1
#> 509                Oklahoma  B12                    24.0
#> 510                   Akron  MAC                    23.9
#> 511                Southern SWAC                    23.9
#> 512                 Hampton BSth                    23.8
#> 513          North Carolina  ACC                    23.7
#> 514                     TCU  B12                    23.6
#> 515                 Vermont   AE                    23.5
#> 516             Alabama St. SWAC                    23.3
#> 517        Louisiana Monroe   SB                    23.2
#> 518         Mississippi St.  SEC                    22.9
#> 519                Duquesne  A10                    22.9
#> 520           Virginia Tech  ACC                    22.8
#> 521          Long Beach St.   BW                    22.8
#> 522                  Oregon  P12                    22.8
#> 523                Nebraska  B10                    22.8
#> 524                Winthrop BSth                    22.8
#> 525        Florida Atlantic CUSA                    22.7
#> 526                   Rider MAAC                    22.7
#> 527            Illinois St.  MVC                    22.6
#> 528             Georgia St.   SB                    22.4
#> 529     Central Connecticut  NEC                    22.2
#> 530              Charleston  CAA                    22.1
#> 531               Charlotte CUSA                    22.0
#> 532      Eastern Washington BSky                    21.9
#> 533          Saint Joseph's  A10                    21.7
#> 534               Idaho St. BSky                    21.5
#> 535          Nebraska Omaha  Sum                    21.5
#> 536                   Drake  MVC                    21.2
#> 537               Marquette   BE                    21.0
#> 538                  Butler   BE                    20.9
#> 539                  Purdue  B10                    20.9
#> 540                Ohio St.  B10                    20.6
#> 541                UC Davis   BW                    20.3
#> 542             Mississippi  SEC                    20.2
#> 543                  Dayton  A10                    20.1
#> 544             Montana St. BSky                    19.8
#> 545                    UTEP CUSA                    19.6
#> 546            Old Dominion CUSA                    19.6
#> 547                Utah St.  MWC                    19.5
#> 548                Cal Poly   BW                    19.5
#> 549              Georgetown   BE                    19.5
#> 550                Richmond  A10                    19.4
#> 551                  Hawaii   BW                    19.3
#> 552             Jackson St. SWAC                    18.9
#> 553  Texas A&M Corpus Chris Slnd                    18.9
#> 554                     UCF Amer                    18.6
#> 555                  DePaul   BE                    18.5
#> 556              Pittsburgh  ACC                    18.4
#> 557           Tennessee St.  OVC                    18.4
#> 558                 Gonzaga  WCC                    18.3
#> 559                  Denver  Sum                    18.2
#> 560          Louisiana Tech CUSA                    18.1
#> 561                   Idaho BSky                    17.9
#> 562            Jacksonville ASun                    17.8
#> 563              Valparaiso  MVC                    17.7
#> 564                Monmouth MAAC                    17.6
#> 565         Sam Houston St. Slnd                    17.6
#> 566                Marshall CUSA                    17.5
#> 567        North Dakota St.  Sum                    17.5
#> 568              N.C. State  ACC                    17.5
#> 569                   Texas  B12                    17.4
#> 570            North Dakota  Sum                    17.4
#> 571              Cincinnati Amer                    17.4
#> 572        UC Santa Barbara   BW                    17.3
#> 573        Eastern Illinois  OVC                    17.3
#> 574               Loyola MD  Pat                    17.3
#> 575           New Hampshire   AE                    17.2
#> 576               Dixie St.  WAC                    17.2
#> 577                 Montana BSky                    17.1
#> 578          Texas Southern SWAC                    17.1
#> 579              Quinnipiac MAAC                    16.9
#> 580                Arkansas  SEC                    16.9
#> 581                Missouri  SEC                    16.9
#> 582               Texas St.   SB                    16.6
#> 583                  Nevada  MWC                    16.6
#> 584                   Tulsa Amer                    16.5
#> 585             Saint Louis  A10                    16.4
#> 586                 Memphis Amer                    16.2
#> 587               Milwaukee Horz                    16.1
#> 588            Nicholls St. Slnd                    15.9
#> 589            Arkansas St.   SB                    15.8
#> 590            Sacred Heart  NEC                    15.4
#> 591        Coastal Carolina   SB                    15.2
#> 592            Delaware St. MEAC                    15.2
#> 593           Northern Iowa  MVC                    15.1
#> 594              Murray St.  OVC                    14.7
#> 595      South Carolina St. MEAC                    14.7
#> 596               Louisiana   SB                    14.7
#> 597                    Troy   SB                    14.7
#> 598       Southern Illinois  MVC                    14.7
#> 599             Austin Peay  OVC                    14.6
#> 600           West Virginia  B12                    14.4
#> 601                 Bradley  MVC                    14.1
#> 602     Cal St. Bakersfield   BW                    14.1
#> 603              Bellarmine ASun                    14.0
#> 604           UNC Asheville BSth                    13.9
#> 605                Kentucky  SEC                    13.7
#> 606       Cal St. Fullerton   BW                    13.7
#> 607       Northern Colorado BSky                    13.7
#> 608                Maryland  B10                    13.5
#> 609                Lipscomb ASun                    13.2
#> 610               Green Bay Horz                    13.2
#> 611            Portland St. BSky                    13.2
#> 612        Georgia Southern   SB                    13.2
#> 613             New Orleans Slnd                    13.1
#> 614                 Indiana  B10                    13.0
#> 615        SIU Edwardsville  OVC                    12.7
#> 616                Stanford  P12                    12.6
#> 617              Holy Cross  Pat                    12.4
#> 618            Northwestern  B10                    12.4
#> 619              Wright St. Horz                    12.3
#> 620              St. John's   BE                    12.3
#> 621           Saint Peter's MAAC                    12.2
#> 622        Northwestern St. Slnd                    12.1
#> 623             USC Upstate BSth                    12.0
#> 624            UC Riverside   BW                    11.9
#> 625                     BYU  WCC                    11.8
#> 626                Bucknell  Pat                    11.8
#> 627              Vanderbilt  SEC                    11.8
#> 628            George Mason  A10                    11.7
#> 629                  Temple Amer                    11.7
#> 630                 Clemson  ACC                    11.5
#> 631        South Dakota St.  Sum                    11.4
#> 632                    Rice CUSA                    11.3
#> 633             Stony Brook   AE                    11.3
#> 634                Colorado  P12                    11.0
#> 635             Utah Valley  WAC                    10.9
#> 636                Campbell BSth                    10.6
#> 637                Illinois  B10                    10.5
#> 638                La Salle  A10                    10.5
#> 639         Houston Baptist Slnd                    10.5
#> 640            UT Arlington   SB                    10.3
#> 641            Gardner Webb BSth                    10.3
#> 642           San Diego St.  MWC                    10.2
#> 643                Michigan  B10                    10.1
#> 644                     USC  P12                    10.1
#> 645                 Belmont  OVC                    10.0
#> 646               Villanova   BE                    10.0
#> 647                  Marist MAAC                     9.9
#> 648               Texas A&M  SEC                     9.7
#> 649                 Colgate  Pat                     9.6
#> 650       Purdue Fort Wayne Horz                     9.5
#> 651                Canisius MAAC                     9.2
#> 652                    UMBC   AE                     9.1
#> 653      East Tennessee St.   SC                     9.0
#> 654               Wisconsin  B10                     9.0
#> 655          St. Francis NY  NEC                     8.9
#> 656  Southeast Missouri St.  OVC                     8.9
#> 657                     VCU  A10                     8.7
#> 658      Florida Gulf Coast ASun                     8.6
#> 659                  Mercer   SC                     8.6
#> 660             Connecticut   BE                     8.5
#> 661                Miami OH  MAC                     8.5
#> 662               Fairfield MAAC                     8.3
#> 663               Creighton   BE                     8.2
#> 664                Miami FL  ACC                     7.8
#> 665        Western Illinois  Sum                     7.7
#> 666           Southern Utah BSky                     7.7
#> 667            Michigan St.  B10                     7.4
#> 668         Appalachian St.   SB                     7.3
#> 669                 Houston Amer                     7.1
#> 670                    Iona MAAC                     7.1
#> 671             Wake Forest  ACC                     7.0
#> 672               Tennessee  SEC                     6.9
#> 673                 Radford BSth                     6.7
#> 674             Norfolk St. MEAC                     6.6
#> 675        Jacksonville St.  OVC                     6.6
#> 676              Kansas St.  B12                     6.6
#> 677                Penn St.  B10                     6.4
#> 678           Cleveland St. Horz                     6.4
#> 679                     SMU Amer                     6.2
#> 680                     UAB CUSA                     5.5
#> 681        Western Kentucky CUSA                     5.5
#> 682        Eastern Kentucky  OVC                     5.5
#> 683      North Carolina A&T MEAC                     5.5
#> 684        Tennessee Martin  OVC                     5.3
#> 685                    UCLA  P12                     5.2
#> 686                Virginia  ACC                     5.2
#> 687          Loyola Chicago  MVC                     5.1
#> 688           Bowling Green  MAC                     5.0
#> 689             Indiana St.  MVC                     5.0
#> 690                    Navy  Pat                     4.9
#> 691           Massachusetts  A10                     4.7
#> 692                    Utah  P12                     4.2
#> 693                 Liberty ASun                     4.0
#> 694          New Mexico St.  WAC                     4.0
#> 695               UC Irvine   BW                     4.0
#> 696                  Albany   AE                     3.9
#> 697        Western Michigan  MAC                     3.8
#> 698              High Point BSth                     3.7
#> 699              Oregon St.  P12                     3.6
#> 700           East Carolina Amer                     3.4
#> 701           South Florida Amer                     3.2
#> 702                 Stetson ASun                     3.0
#> 703               Weber St. BSky                     2.6
#> 704                  Lehigh  Pat                     2.6
#> 705                Davidson  A10                     2.4
#> 706          South Carolina  SEC                     1.9
#> 707                    Iowa  B10                     1.6
#> 708             Florida St.  ACC                     1.1
#> 709             Wichita St. Amer                     0.8
#> 710                 Florida  SEC                     0.7
#> 711             Little Rock   SB                    65.3
#> 712                Portland  WCC                    63.7
#> 713             Florida A&M SWAC                    61.1
#> 714                   IUPUI Horz                    60.8
#> 715                 Oakland Horz                    58.7
#> 716            Georgia Tech  ACC                    57.9
#> 717                  Bryant  NEC                    54.9
#> 718             Chicago St.  WAC                    53.8
#> 719           North Florida ASun                    52.0
#> 720               Merrimack  NEC                    51.0
#> 721               Air Force  MWC                    50.5
#> 722       Northern Kentucky Horz                    49.5
#> 723                    Army  Pat                    48.7
#> 724        Central Arkansas ASun                    48.5
#> 725         St. Bonaventure  A10                    47.4
#> 726        Louisiana Monroe   SB                    45.9
#> 727     Arkansas Pine Bluff SWAC                    45.5
#> 728           Southern Miss CUSA                    45.1
#> 729            Tarleton St.  WAC                    45.0
#> 730               Princeton  Ivy                    44.8
#> 731             Alabama A&M SWAC                    44.5
#> 732          Incarnate Word Slnd                    44.4
#> 733           San Francisco  WCC                    43.8
#> 734                    NJIT   AE                    43.0
#> 735  Mississippi Valley St. SWAC                    42.6
#> 736             Cal Baptist  WAC                    42.5
#> 737            Delaware St. MEAC                    42.1
#> 738        Prairie View A&M SWAC                    42.1
#> 739            George Mason  A10                    41.1
#> 740                American  Pat                    41.1
#> 741           Robert Morris Horz                    41.0
#> 742                Ball St.  MAC                    40.7
#> 743                  Toledo  MAC                    39.9
#> 744                Duquesne  A10                    39.4
#> 745        Northern Arizona BSky                    39.2
#> 746                   Brown  Ivy                    38.7
#> 747                     LIU  NEC                    38.5
#> 748           South Alabama   SB                    38.4
#> 749               San Diego  WCC                    38.2
#> 750        Western Kentucky CUSA                    38.0
#> 751            San Jose St.  MWC                    37.9
#> 752              Alcorn St. SWAC                    36.9
#> 753             Indiana St.  MVC                    36.9
#> 754              Texas Tech  B12                    36.8
#> 755            Grand Canyon  WAC                    36.4
#> 756       Stephen F. Austin  WAC                    35.8
#> 757                   Siena MAAC                    35.5
#> 758              Fresno St.  MWC                    35.3
#> 759                 Harvard  Ivy                    35.1
#> 760                  Furman   SC                    35.1
#> 761            North Dakota  Sum                    34.2
#> 762                Delaware  CAA                    34.2
#> 763                  Baylor  B12                    34.0
#> 764            Northeastern  CAA                    34.0
#> 765              Seton Hall   BE                    33.7
#> 766       Northern Illinois  MAC                    33.7
#> 767                 Samford   SC                    33.6
#> 768              Notre Dame  ACC                    33.2
#> 769            UC San Diego   BW                    33.1
#> 770                 Hampton BSth                    32.6
#> 771                 Alabama  SEC                    32.5
#> 772                     LSU  SEC                    32.4
#> 773             Chattanooga   SC                    32.4
#> 774  Southeastern Louisiana Slnd                    32.2
#> 775                  Howard MEAC                    32.0
#> 776                Syracuse  ACC                    31.8
#> 777                  Tulane Amer                    31.7
#> 778            Saint Mary's  WCC                    31.3
#> 779        Illinois Chicago Horz                    31.1
#> 780                    Penn  Ivy                    31.1
#> 781              Charleston  CAA                    30.9
#> 782                Maryland  B10                    30.9
#> 783           Grambling St. SWAC                    30.8
#> 784                 Georgia  SEC                    30.8
#> 785            Colorado St.  MWC                    30.6
#> 786          Sacramento St. BSky                    30.5
#> 787                  Oregon  P12                    30.3
#> 788               Lafayette  Pat                    30.2
#> 789                    UTSA CUSA                    29.9
#> 790                  DePaul   BE                    29.9
#> 791              Coppin St. MEAC                    29.9
#> 792          St. Francis PA  NEC                    29.8
#> 793          Boston College  ACC                    29.7
#> 794                  Xavier   BE                    29.6
#> 795                Utah St.  MWC                    29.4
#> 796                 Rutgers  B10                    29.3
#> 797            South Dakota  Sum                    29.1
#> 798           UNC Asheville BSth                    29.0
#> 799              Oregon St.  P12                    29.0
#> 800                Ohio St.  B10                    28.9
#> 801          North Carolina  ACC                    28.7
#> 802             North Texas CUSA                    28.7
#> 803          Youngstown St. Horz                    28.7
#> 804      East Tennessee St.   SC                    28.6
#> 805                 Buffalo  MAC                    28.4
#> 806        Loyola Marymount  WCC                    28.1
#> 807           James Madison  CAA                    28.1
#> 808                  Auburn  SEC                    28.1
#> 809                    Ohio  MAC                    28.0
#> 810         Bethune Cookman SWAC                    27.9
#> 811              Morgan St. MEAC                    27.9
#> 812                    UTEP CUSA                    27.8
#> 813            Oral Roberts  Sum                    27.8
#> 814             Santa Clara  WCC                    27.5
#> 815              Cincinnati Amer                    27.4
#> 816                 Colgate  Pat                    27.3
#> 817            Old Dominion CUSA                    27.2
#> 818                 Seattle  WAC                    27.2
#> 819             Stony Brook   AE                    27.1
#> 820         Mississippi St.  SEC                    27.1
#> 821              Valparaiso  MVC                    27.0
#> 822              St. Thomas  Sum                    27.0
#> 823                   Tulsa Amer                    26.9
#> 824              Providence   BE                    26.6
#> 825     Fairleigh Dickinson  NEC                    26.4
#> 826        Tennessee Martin  OVC                    26.4
#> 827                     VCU  A10                    26.1
#> 828             Wake Forest  ACC                    26.0
#> 829                 Houston Amer                    25.7
#> 830        Mount St. Mary's  NEC                    25.6
#> 831              Pepperdine  WCC                    25.6
#> 832                Iowa St.  B12                    25.5
#> 833             The Citadel   SC                    25.5
#> 834         Appalachian St.   SB                    25.4
#> 835                   Drake  MVC                    25.0
#> 836           Detroit Mercy Horz                    25.0
#> 837                Monmouth MAAC                    24.9
#> 838           Cleveland St. Horz                    24.7
#> 839              Holy Cross  Pat                    24.5
#> 840                UC Davis   BW                    24.4
#> 841              New Mexico  MWC                    24.4
#> 842                Missouri  SEC                    24.4
#> 843                Marshall CUSA                    24.3
#> 844       Boston University  Pat                    24.2
#> 845                  Butler   BE                    24.2
#> 846        Eastern Illinois  OVC                    24.2
#> 847                   Idaho BSky                    24.0
#> 848                    UNLV  MWC                    23.9
#> 849                  Nevada  MWC                    23.9
#> 850            UMass Lowell   AE                    23.9
#> 851            Presbyterian BSth                    23.9
#> 852              High Point BSth                    23.4
#> 853             Mississippi  SEC                    23.4
#> 854                    Elon  CAA                    23.0
#> 855        Western Carolina   SC                    22.8
#> 856       Cal St. Fullerton   BW                    22.7
#> 857        Central Michigan  MAC                    22.7
#> 858               Minnesota  B10                    22.6
#> 859                  Wagner  NEC                    22.6
#> 860     Cal St. Bakersfield   BW                    22.5
#> 861      South Carolina St. MEAC                    22.4
#> 862             McNeese St. Slnd                    22.4
#> 863              Bellarmine ASun                    22.3
#> 864             Utah Valley  WAC                    22.1
#> 865                   Rider MAAC                    22.1
#> 866                Cal Poly   BW                    21.8
#> 867                Kent St.  MAC                    21.7
#> 868            Arkansas St.   SB                    21.6
#> 869                Nebraska  B10                    21.5
#> 870                 Bradley  MVC                    21.5
#> 871                    Utah  P12                    21.4
#> 872             Saint Louis  A10                    21.4
#> 873              Wright St. Horz                    21.4
#> 874           North Alabama ASun                    21.3
#> 875                  Albany   AE                    21.2
#> 876              Evansville  MVC                    21.2
#> 877          William & Mary  CAA                    21.1
#> 878    UT Rio Grande Valley  WAC                    20.9
#> 879                 Wofford   SC                    20.9
#> 880               Boise St.  MWC                    20.8
#> 881             USC Upstate BSth                    20.7
#> 882               Loyola MD  Pat                    20.4
#> 883               Weber St. BSky                    19.9
#> 884             Georgia St.   SB                    19.9
#> 885                Longwood BSth                    19.7
#> 886               Creighton   BE                    19.7
#> 887  North Carolina Central MEAC                    19.4
#> 888                 Vermont   AE                    19.4
#> 889                  Temple Amer                    19.3
#> 890               Manhattan MAAC                    19.3
#> 891                  Mercer   SC                    19.1
#> 892            Illinois St.  MVC                    19.0
#> 893                Southern SWAC                    18.8
#> 894     Charleston Southern BSth                    18.6
#> 895        North Dakota St.  Sum                    18.6
#> 896            UC Riverside   BW                    18.5
#> 897           East Carolina Amer                    18.5
#> 898                   Maine   AE                    18.4
#> 899          Nebraska Omaha  Sum                    18.4
#> 900          Tennessee Tech  OVC                    18.4
#> 901                Penn St.  B10                    18.4
#> 902      Florida Gulf Coast ASun                    18.1
#> 903                 Arizona  P12                    18.1
#> 904                Hartford   AE                    18.1
#> 905            Kennesaw St. ASun                    18.1
#> 906               Louisiana   SB                    17.5
#> 907              N.C. State  ACC                    17.4
#> 908          Washington St.  P12                    17.4
#> 909                 Memphis Amer                    17.4
#> 910            Morehead St.  OVC                    17.3
#> 911              Vanderbilt  SEC                    17.2
#> 912                 Niagara MAAC                    17.0
#> 913                Columbia  Ivy                    16.9
#> 914            Portland St. BSky                    16.9
#> 915              Washington  P12                    16.8
#> 916            Nicholls St. Slnd                    16.5
#> 917        Georgia Southern   SB                    16.5
#> 918           Tennessee St.  OVC                    16.4
#> 919                     VMI   SC                    16.4
#> 920                 Belmont  OVC                    16.3
#> 921       Northern Colorado BSky                    15.9
#> 922              Quinnipiac MAAC                    15.9
#> 923           Northern Iowa  MVC                    15.9
#> 924       Abilene Christian  WAC                    15.8
#> 925              California  P12                    15.8
#> 926                  Towson  CAA                    15.7
#> 927            Rhode Island  A10                    15.6
#> 928             Alabama St. SWAC                    15.5
#> 929               Charlotte CUSA                    15.3
#> 930                   Texas  B12                    15.2
#> 931                     TCU  B12                    15.2
#> 932             New Orleans Slnd                    15.1
#> 933        Northwestern St. Slnd                    15.0
#> 934                     USC  P12                    14.9
#> 935      Eastern Washington BSky                    14.7
#> 936                    Rice CUSA                    14.7
#> 937             Austin Peay  OVC                    14.7
#> 938            UT Arlington   SB                    14.6
#> 939          Saint Joseph's  A10                    14.6
#> 940               Marquette   BE                    14.5
#> 941                   Akron  MAC                    14.5
#> 942                     FIU CUSA                    14.4
#> 943                    Duke  ACC                    14.4
#> 944            Sacred Heart  NEC                    14.4
#> 945                  Denver  Sum                    14.3
#> 946           Massachusetts  A10                    14.3
#> 947                 Cornell  Ivy                    14.2
#> 948         Houston Baptist Slnd                    13.9
#> 949                    Navy  Pat                    13.8
#> 950                    UMKC  Sum                    13.8
#> 951      North Carolina A&T BSth                    13.7
#> 952  Maryland Eastern Shore MEAC                    13.7
#> 953              Louisville  ACC                    13.5
#> 954                  Hawaii   BW                    13.3
#> 955           Virginia Tech  ACC                    13.2
#> 956        Coastal Carolina   SB                    13.2
#> 957                  Kansas  B12                    13.2
#> 958          Long Beach St.   BW                    13.1
#> 959                    UCLA  P12                    13.0
#> 960       George Washington  A10                    13.0
#> 961               Dixie St.  WAC                    12.6
#> 962                Colorado  P12                    12.5
#> 963       Southern Illinois  MVC                    12.3
#> 964                Winthrop BSth                    12.3
#> 965                La Salle  A10                    12.2
#> 966            Missouri St.  MVC                    12.1
#> 967                 Hofstra  CAA                    12.0
#> 968                   Lamar  WAC                    11.9
#> 969        SIU Edwardsville  OVC                    11.8
#> 970                     BYU  WCC                    11.8
#> 971      Cal St. Northridge   BW                    11.7
#> 972             Jackson St. SWAC                    11.7
#> 973          Louisiana Tech CUSA                    11.4
#> 974              Binghamton   AE                    11.4
#> 975                Stanford  P12                    11.4
#> 976                 Fordham  A10                    11.3
#> 977        Florida Atlantic CUSA                    11.2
#> 978                Illinois  B10                    11.2
#> 979                 Wyoming  MWC                    11.0
#> 980              Murray St.  OVC                    10.7
#> 981                  Dayton  A10                    10.7
#> 982              Pittsburgh  ACC                    10.7
#> 983        UC Santa Barbara   BW                    10.6
#> 984                Oklahoma  B12                    10.5
#> 985               Tennessee  SEC                    10.5
#> 986                Arkansas  SEC                    10.4
#> 987            Northwestern  B10                    10.4
#> 988  Southeast Missouri St.  OVC                    10.4
#> 989            Oklahoma St.  B12                    10.4
#> 990          Texas Southern SWAC                    10.3
#> 991                Lipscomb ASun                    10.3
#> 992          Loyola Chicago  MVC                    10.1
#> 993             Arizona St.  P12                    10.0
#> 994              St. John's   BE                    10.0
#> 995              Georgetown   BE                     9.8
#> 996     Central Connecticut  NEC                     9.7
#> 997               Idaho St. BSky                     9.6
#> 998           New Hampshire   AE                     9.4
#> 999                 Pacific  WCC                     9.4
#> 1000             Kansas St.  B12                     9.2
#> 1001           Gardner Webb BSth                     9.2
#> 1002         St. Francis NY  NEC                     9.0
#> 1003               Canisius MAAC                     9.0
#> 1004       Western Illinois  Sum                     8.9
#> 1005              Texas St.   SB                     8.7
#> 1006          San Diego St.  MWC                     8.6
#> 1007        Sam Houston St.  WAC                     8.4
#> 1008                    SMU Amer                     8.4
#> 1009              Wisconsin  B10                     8.3
#> 1010              UC Irvine   BW                     8.2
#> 1011                   Yale  Ivy                     8.2
#> 1012              Green Bay Horz                     7.9
#> 1013              Villanova   BE                     7.9
#> 1014                Gonzaga  WCC                     7.8
#> 1015       Eastern Michigan  MAC                     7.7
#> 1016                 Marist MAAC                     7.7
#> 1017                Radford BSth                     7.7
#> 1018              Dartmouth  Ivy                     7.6
#> 1019            Connecticut   BE                     7.5
#> 1020           Michigan St.  B10                     7.4
#> 1021                    UCF Amer                     7.4
#> 1022       Eastern Kentucky ASun                     7.3
#> 1023                Montana BSky                     7.3
#> 1024       Western Michigan  MAC                     7.1
#> 1025          South Florida Amer                     7.0
#> 1026       South Dakota St.  Sum                     6.8
#> 1027               Miami OH  MAC                     6.8
#> 1028 Texas A&M Corpus Chris Slnd                     6.6
#> 1029          West Virginia  B12                     6.6
#> 1030               Virginia  ACC                     6.5
#> 1031         UNC Wilmington  CAA                     6.1
#> 1032               Miami FL  ACC                     6.0
#> 1033          Southern Utah BSky                     5.9
#> 1034              Milwaukee Horz                     5.7
#> 1035              Texas A&M  SEC                     5.5
#> 1036       Middle Tennessee CUSA                     5.3
#> 1037               Richmond  A10                     5.2
#> 1038                 Purdue  B10                     5.1
#> 1039               Kentucky  SEC                     5.1
#> 1040                Florida  SEC                     5.0
#> 1041                   Iowa  B10                     5.0
#> 1042               Bucknell  Pat                     5.0
#> 1043                Liberty ASun                     5.0
#> 1044                    UAB CUSA                     5.0
#> 1045            Montana St. BSky                     4.6
#> 1046                   UMBC   AE                     4.6
#> 1047              Fairfield MAAC                     4.5
#> 1048               Michigan  B10                     4.5
#> 1049            Wichita St. Amer                     4.3
#> 1050                Clemson  ACC                     3.8
#> 1051                Indiana  B10                     3.6
#> 1052            Norfolk St. MEAC                     3.6
#> 1053           Jacksonville ASun                     3.5
#> 1054               Campbell BSth                     3.5
#> 1055                 Drexel  CAA                     3.3
#> 1056      Purdue Fort Wayne Horz                     3.2
#> 1057          Bowling Green  MAC                     2.8
#> 1058                   Iona MAAC                     2.3
#> 1059            Florida St.  ACC                     2.3
#> 1060         South Carolina  SEC                     2.2
#> 1061         New Mexico St.  WAC                     2.0
#> 1062         UNC Greensboro   SC                     2.0
#> 1063       Jacksonville St. ASun                     1.9
#> 1064          Saint Peter's MAAC                     1.6
#> 1065                 Lehigh  Pat                     1.6
#> 1066               Davidson  A10                     1.1
#> 1067                   Troy   SB                     0.6
#> 1068                Stetson ASun                     0.0
#> 1069            Little Rock  OVC                    63.2
#> 1070           Georgia Tech  ACC                    60.7
#> 1071               Delaware  CAA                    59.3
#> 1072                Oakland Horz                    59.2
#> 1073       Louisiana Monroe   SB                    55.2
#> 1074                 Bryant   AE                    54.2
#> 1075          North Florida ASun                    52.4
#> 1076                 Queens ASun                    51.4
#> 1077      Northern Kentucky Horz                    51.2
#> 1078            Chicago St.  ind                    50.9
#> 1079               Winthrop BSth                    49.1
#> 1080               American  Pat                    48.8
#> 1081               Portland  WCC                    47.5
#> 1082    Fairleigh Dickinson  NEC                    47.1
#> 1083       Central Arkansas ASun                    46.9
#> 1084                  Brown  Ivy                    45.9
#> 1085             Evansville  MVC                    45.5
#> 1086            Florida A&M SWAC                    45.5
#> 1087                Florida  SEC                    45.2
#> 1088                   Army  Pat                    44.9
#> 1089           Grand Canyon  WAC                    44.8
#> 1090 Mississippi Valley St. SWAC                    44.0
#> 1091                 Howard MEAC                    44.0
#> 1092                   Penn  Ivy                    43.9
#> 1093       Northern Arizona BSky                    43.4
#> 1094             Coppin St. MEAC                    43.3
#> 1095             Notre Dame  ACC                    43.2
#> 1096                   NJIT   AE                    42.7
#> 1097          Detroit Mercy Horz                    42.7
#> 1098             Washington  P12                    42.7
#> 1099                Buffalo  MAC                    42.7
#> 1100           Saint Mary's  WCC                    42.4
#> 1101              Merrimack  NEC                    42.4
#> 1102         Washington St.  P12                    42.2
#> 1103    Cal St. Bakersfield   BW                    41.5
#> 1104               Miami OH  MAC                    41.4
#> 1105                 DePaul   BE                    41.3
#> 1106                 Tulane Amer                    40.8
#> 1107                    VMI   SC                    40.7
#> 1108       Illinois Chicago  MVC                    40.0
#> 1109                  IUPUI Horz                    40.0
#> 1110               Iowa St.  B12                    39.8
#> 1111    Arkansas Pine Bluff SWAC                    39.5
#> 1112               Maryland  B10                    39.4
#> 1113         Incarnate Word Slnd                    38.0
#> 1114              San Diego  WCC                    37.5
#> 1115                 Xavier   BE                    37.5
#> 1116                 Baylor  B12                    37.5
#> 1117           Gardner Webb BSth                    37.3
#> 1118              Boise St.  MWC                    37.0
#> 1119              Minnesota  B10                    36.6
#> 1120         South Carolina  SEC                    36.5
#> 1121       Prairie View A&M SWAC                    36.5
#> 1122              Air Force  MWC                    35.7
#> 1123           Oral Roberts  Sum                    35.6
#> 1124             Holy Cross  Pat                    35.5
#> 1125                 Albany   AE                    35.4
#> 1126            The Citadel   SC                    35.4
#> 1127                 Toledo  MAC                    35.1
#> 1128          South Alabama   SB                    35.1
#> 1129                   Utah  P12                    35.0
#> 1130      Southern Illinois  MVC                    34.9
#> 1131           Delaware St. MEAC                    34.9
#> 1132           UC San Diego   BW                    34.7
#> 1133            Jackson St. SWAC                    34.3
#> 1134                Vermont   AE                    34.2
#> 1135             Texas Tech  B12                    33.7
#> 1136         Boston College  ACC                    33.6
#> 1137                 Furman   SC                    33.1
#> 1138                Niagara MAAC                    33.1
#> 1139           George Mason  A10                    32.8
#> 1140      Stephen F. Austin  WAC                    32.8
#> 1141               Syracuse  ACC                    32.4
#> 1142            Alabama St. SWAC                    32.3
#> 1143                   UTSA CUSA                    32.0
#> 1144            Wichita St. Amer                    31.9
#> 1145                  Akron  MAC                    31.9
#> 1146          Virginia Tech  ACC                    31.8
#> 1147                  Siena MAAC                    31.8
#> 1148       Central Michigan  MAC                    31.7
#> 1149      Northern Illinois  MAC                    31.6
#> 1150                    FIU CUSA                    31.5
#> 1151            McNeese St. Slnd                    31.2
#> 1152             St. Thomas  Sum                    31.2
#> 1153                Harvard  Ivy                    30.9
#> 1154             Providence   BE                    30.9
#> 1155        St. Bonaventure  A10                    30.7
#> 1156       Tennessee Martin  OVC                    30.7
#> 1157                 Auburn  SEC                    30.5
#> 1158             Fresno St.  MWC                    30.4
#> 1159              Milwaukee Horz                    30.4
#> 1160          Robert Morris Horz                    29.9
#> 1161                Wofford   SC                    29.8
#> 1162            Stony Brook  CAA                    29.7
#> 1163            Chattanooga   SC                    29.5
#> 1164                Seattle  WAC                    29.3
#> 1165     Texas A&M Commerce Slnd                    29.3
#> 1166            Wake Forest  ACC                    29.2
#> 1167          Grambling St. SWAC                    29.1
#> 1168          UNC Asheville BSth                    28.9
#> 1169               Kent St.  MAC                    28.7
#> 1170                Memphis Amer                    28.6
#> 1171       Northwestern St. Slnd                    28.6
#> 1172               Ohio St.  B10                    28.6
#> 1173         Saint Joseph's  A10                    28.4
#> 1174           Arkansas St.   SB                    28.3
#> 1175               Michigan  B10                    28.2
#> 1176                Indiana  B10                    28.2
#> 1177             Oregon St.  P12                    28.1
#> 1178                    LIU  NEC                    27.8
#> 1179             New Mexico  MWC                    27.6
#> 1180           Illinois St.  MVC                    27.6
#> 1181       Loyola Marymount  WCC                    27.6
#> 1182             Morgan St. MEAC                    27.6
#> 1183 Southeast Missouri St.  OVC                    27.4
#> 1184       Coastal Carolina   SB                    27.4
#> 1185           UC Riverside   BW                    27.3
#> 1186             Georgetown   BE                    27.2
#> 1187                   Duke  ACC                    27.1
#> 1188                Alabama  SEC                    27.1
#> 1189                    TCU  B12                    27.0
#> 1190       Mount St. Mary's MAAC                    26.9
#> 1191          San Francisco  WCC                    26.9
#> 1192             Lindenwood  OVC                    26.8
#> 1193                Montana BSky                    26.8
#> 1194                Samford   SC                    26.4
#> 1195          Northern Iowa  MVC                    26.2
#> 1196             Charleston  CAA                    26.1
#> 1197           Colorado St.  MWC                    25.8
#> 1198              Louisiana   SB                    25.7
#> 1199           Tarleton St.  WAC                    25.6
#> 1200               Utah St.  MWC                    25.5
#> 1201       Eastern Michigan  MAC                    25.5
#> 1202                Wyoming  MWC                    25.5
#> 1203             Valparaiso  MVC                    25.4
#> 1204          Tennessee St.  OVC                    25.4
#> 1205               Southern SWAC                    25.1
#> 1206        Bethune Cookman SWAC                    25.1
#> 1207                Hampton  CAA                    25.0
#> 1208              Princeton  Ivy                    24.9
#> 1209                Arizona  P12                    24.7
#> 1210                 Kansas  B12                    24.6
#> 1211           Northwestern  B10                    24.6
#> 1212              Utah Tech  WAC                    24.5
#> 1213       UC Santa Barbara   BW                    24.5
#> 1214           Northeastern  CAA                    24.4
#> 1215                Bradley  MVC                    24.4
#> 1216       Georgia Southern   SB                    24.3
#> 1217           Sacred Heart  NEC                    24.0
#> 1218               Monmouth  CAA                    23.8
#> 1219               Missouri  SEC                    23.6
#> 1220         North Carolina  ACC                    23.6
#> 1221                    USC  P12                    23.6
#> 1222      Cal St. Fullerton   BW                    23.4
#> 1223                 Oregon  P12                    23.2
#> 1224              Marquette   BE                    23.2
#> 1225               Hartford  ind                    23.0
#> 1226               Ball St.  MAC                    23.0
#> 1227                Colgate  Pat                    22.8
#> 1228           Missouri St.  MVC                    22.8
#> 1229             St. John's   BE                    22.6
#> 1230                 Dayton  A10                    22.6
#> 1231            Mississippi  SEC                    22.6
#> 1232         St. Francis PA  NEC                    22.5
#> 1233           Morehead St.  OVC                    22.5
#> 1234              Manhattan MAAC                    22.3
#> 1235                   Rice CUSA                    22.3
#> 1236               Campbell BSth                    22.1
#> 1237                   Ohio  MAC                    22.1
#> 1238              Lafayette  Pat                    21.8
#> 1239          New Hampshire   AE                    21.5
#> 1240                 Nevada  MWC                    21.4
#> 1241             Cincinnati Amer                    21.4
#> 1242         Loyola Chicago  A10                    21.4
#> 1243         Tennessee Tech  OVC                    21.4
#> 1244      Purdue Fort Wayne Horz                    21.3
#> 1245   UT Rio Grande Valley  WAC                    21.2
#> 1246      Boston University  Pat                    21.1
#> 1247               Columbia  Ivy                    21.1
#> 1248                 Marist MAAC                    21.0
#> 1249            Indiana St.  MVC                    21.0
#> 1250      Northern Colorado BSky                    20.9
#> 1251             Bellarmine ASun                    20.7
#> 1252           Rhode Island  A10                    20.6
#> 1253               UC Davis   BW                    20.5
#> 1254             Kansas St.  B12                    20.4
#> 1255                   UTEP CUSA                    20.4
#> 1256                    LSU  SEC                    20.4
#> 1257      Houston Christian Slnd                    20.1
#> 1258          Southern Miss   SB                    20.0
#> 1259            North Texas CUSA                    20.0
#> 1260                   UNLV  MWC                    19.9
#> 1261                  Maine   AE                    19.9
#> 1262              Green Bay Horz                    19.8
#> 1263             California  P12                    19.7
#> 1264             Pepperdine  WCC                    19.6
#> 1265            Georgia St.   SB                    19.4
#> 1266     South Carolina St. MEAC                    19.4
#> 1267               Oklahoma  B12                    19.2
#> 1268                Houston Amer                    19.1
#> 1269            New Orleans Slnd                    19.1
#> 1270       South Dakota St.  Sum                    19.0
#> 1271                    BYU  WCC                    19.0
#> 1272          East Carolina Amer                    19.0
#> 1273             Alcorn St. SWAC                    18.9
#> 1274               Marshall   SB                    18.8
#> 1275             Pittsburgh  ACC                    18.7
#> 1276              Texas St.   SB                    18.7
#> 1277                 Temple Amer                    18.5
#> 1278                  Idaho BSky                    18.2
#> 1279                Gonzaga  WCC                    18.1
#> 1280                 Denver  Sum                    18.1
#> 1281               Lipscomb ASun                    18.0
#> 1282         Youngstown St. Horz                    17.8
#> 1283       Eastern Illinois  OVC                    17.7
#> 1284               Davidson  A10                    17.7
#> 1285             Quinnipiac MAAC                    17.4
#> 1286               Penn St.  B10                    17.4
#> 1287            Utah Valley  WAC                    17.4
#> 1288            Santa Clara  WCC                    17.3
#> 1289       Middle Tennessee CUSA                    17.2
#> 1290                Georgia  SEC                    17.1
#> 1291           Nicholls St. Slnd                    17.0
#> 1292      Abilene Christian  WAC                    16.9
#> 1293            Arizona St.  P12                    16.9
#> 1294         William & Mary  CAA                    16.8
#> 1295       Western Carolina   SC                    16.5
#> 1296           UT Arlington  WAC                    16.4
#> 1297             Louisville  ACC                    16.4
#> 1298    Charleston Southern BSth                    16.2
#> 1299            USC Upstate BSth                    16.1
#> 1300         New Mexico St.  WAC                    16.1
#> 1301                 Butler   BE                    16.0
#> 1302                Belmont  MVC                    16.0
#> 1303                Rutgers  B10                    16.0
#> 1304               Cal Poly   BW                    16.0
#> 1305          North Alabama ASun                    15.8
#> 1306     East Tennessee St.   SC                    15.8
#> 1307           Old Dominion   SB                    15.6
#> 1308               Arkansas  SEC                    15.5
#> 1309        Appalachian St.   SB                    15.4
#> 1310               Duquesne  A10                    15.3
#> 1311                    SMU Amer                    15.3
#> 1312             Seton Hall   BE                    15.2
#> 1313          West Virginia  B12                    15.2
#> 1314         Sacramento St. BSky                    15.1
#> 1315              Loyola MD  Pat                    15.0
#> 1316                   Yale  Ivy                    15.0
#> 1317       Western Michigan  MAC                    14.9
#> 1318           Presbyterian BSth                    14.7
#> 1319          Cleveland St. Horz                    14.7
#> 1320                    UAB CUSA                    14.6
#> 1321                   Elon  CAA                    14.6
#> 1322             Murray St.  MVC                    14.6
#> 1323          Saint Peter's MAAC                    14.5
#> 1324                   UMKC  Sum                    14.4
#> 1325         Louisiana Tech CUSA                    14.2
#> 1326           North Dakota  Sum                    14.2
#> 1327       Eastern Kentucky ASun                    14.1
#> 1328       Western Kentucky CUSA                    14.1
#> 1329             Binghamton   AE                    13.8
#> 1330         Long Beach St.   BW                    13.8
#> 1331          James Madison   SB                    13.8
#> 1332                 Towson  CAA                    13.7
#> 1333           Oklahoma St.  B12                    13.6
#> 1334         Nebraska Omaha  Sum                    13.6
#> 1335             Vanderbilt  SEC                    13.6
#> 1336           South Dakota  Sum                    13.5
#> 1337                  Drake  MVC                    13.4
#> 1338                  Texas  B12                    13.2
#> 1339 North Carolina Central MEAC                    13.0
#> 1340            Austin Peay ASun                    13.0
#> 1341                    UCF Amer                    13.0
#> 1342                   Troy   SB                    13.0
#> 1343             High Point BSth                    12.9
#> 1344               Nebraska  B10                    12.8
#> 1345         St. Francis NY  NEC                    12.8
#> 1346                 Purdue  B10                    12.6
#> 1347     North Carolina A&T  CAA                    12.4
#> 1348               Stanford  P12                    12.4
#> 1349                 Wagner  NEC                    12.4
#> 1350       SIU Edwardsville  OVC                    12.4
#> 1351              Texas A&M  SEC                    12.3
#> 1352              Dartmouth  Ivy                    12.3
#> 1353              Creighton   BE                    12.1
#> 1354              Weber St. BSky                    12.0
#> 1355     Florida Gulf Coast ASun                    11.8
#> 1356               Colorado  P12                    11.7
#> 1357               Longwood BSth                    11.5
#> 1358              Tennessee  SEC                    11.5
#> 1359                  Rider MAAC                    11.4
#> 1360       Florida Atlantic CUSA                    11.4
#> 1361           San Jose St.  MWC                    11.3
#> 1362                Hofstra  CAA                    11.2
#> 1363      George Washington  A10                    11.2
#> 1364       Jacksonville St. ASun                    11.1
#> 1365           Kennesaw St. ASun                    11.1
#> 1366         Texas Southern SWAC                    11.0
#> 1367 Southeastern Louisiana Slnd                    10.8
#> 1368            Cal Baptist  WAC                    10.7
#> 1369             N.C. State  ACC                    10.7
#> 1370                 Hawaii   BW                    10.6
#> 1371           Portland St. BSky                    10.5
#> 1372                Cornell  Ivy                    10.4
#> 1373            Alabama A&M SWAC                    10.2
#> 1374                Radford BSth                    10.2
#> 1375              Wisconsin  B10                    10.1
#> 1376              Villanova   BE                    10.1
#> 1377       North Dakota St.  Sum                    10.0
#> 1378            Florida St.  ACC                    10.0
#> 1379           UMass Lowell   AE                     9.6
#> 1380                   UMBC   AE                     9.5
#> 1381                 Drexel  CAA                     9.4
#> 1382                  Tulsa Amer                     9.3
#> 1383               Illinois  B10                     9.1
#> 1384                 Lehigh  Pat                     9.1
#> 1385          Bowling Green  MAC                     9.1
#> 1386                    VCU  A10                     9.1
#> 1387          Massachusetts  A10                     9.0
#> 1388     Cal St. Northridge   BW                     9.0
#> 1389              Fairfield MAAC                     8.9
#> 1390 Texas A&M Corpus Chris Slnd                     8.7
#> 1391              Charlotte CUSA                     8.6
#> 1392     Eastern Washington BSky                     8.3
#> 1393               Richmond  A10                     8.2
#> 1394                Pacific  WCC                     8.2
#> 1395                 Mercer   SC                     8.0
#> 1396 Maryland Eastern Shore MEAC                     8.0
#> 1397        Sam Houston St.  WAC                     7.9
#> 1398          San Diego St.  MWC                     7.6
#> 1399          Southern Utah  WAC                     7.5
#> 1400            Montana St. BSky                     7.5
#> 1401                  Lamar Slnd                     7.3
#> 1402            Norfolk St. MEAC                     7.2
#> 1403               Miami FL  ACC                     7.1
#> 1404               La Salle  A10                     6.9
#> 1405                Clemson  ACC                     6.9
#> 1406           Jacksonville ASun                     6.9
#> 1407         UNC Greensboro   SC                     6.9
#> 1408               Bucknell  Pat                     6.8
#> 1409              Stonehill  NEC                     6.6
#> 1410              Idaho St. BSky                     6.5
#> 1411             Wright St. Horz                     6.3
#> 1412               Canisius MAAC                     6.2
#> 1413                Liberty ASun                     6.2
#> 1414       Western Illinois  Sum                     6.0
#> 1415          South Florida Amer                     6.0
#> 1416              UC Irvine   BW                     5.9
#> 1417            Saint Louis  A10                     5.6
#> 1418       Southern Indiana  OVC                     5.0
#> 1419               Kentucky  SEC                     4.7
#> 1420        Mississippi St.  SEC                     4.4
#> 1421         UNC Wilmington  CAA                     4.3
#> 1422                Stetson ASun                     4.1
#> 1423               Virginia  ACC                     3.6
#> 1424            Connecticut   BE                     3.5
#> 1425                   Navy  Pat                     3.4
#> 1426                Fordham  A10                     3.3
#> 1427           Michigan St.  B10                     2.2
#> 1428    Central Connecticut  NEC                     2.2
#> 1429                   Iona MAAC                     1.7
#> 1430                   UCLA  P12                     1.6
#> 1431                   Iowa  B10                     0.1
#> 1432            Little Rock  OVC                    61.5
#> 1433                  Brown  Ivy                    60.1
#> 1434       Prairie View A&M SWAC                    57.1
#> 1435          North Florida ASun                    56.7
#> 1436                 Bryant   AE                    55.6
#> 1437    Fairleigh Dickinson  NEC                    55.2
#> 1438      Northern Kentucky Horz                    54.9
#> 1439            Austin Peay ASun                    54.7
#> 1440              Air Force  MWC                    54.3
#> 1441    Charleston Southern BSth                    54.1
#> 1442    Arkansas Pine Bluff SWAC                    51.7
#> 1443      Southern Illinois  MVC                    50.8
#> 1444             Fresno St.  MWC                    49.7
#> 1445            Jackson St. SWAC                    49.2
#> 1446                 Tulane Amer                    48.7
#> 1447            Cal Baptist  WAC                    48.0
#> 1448               Portland  WCC                    47.5
#> 1449             California  P12                    47.4
#> 1450       Louisiana Monroe   SB                    46.8
#> 1451 Mississippi Valley St. SWAC                    46.1
#> 1452     Texas A&M Commerce Slnd                    45.0
#> 1453               Missouri  SEC                    44.6
#> 1454               Ball St.  MAC                    44.5
#> 1455         South Carolina  SEC                    44.2
#> 1456     East Tennessee St.   SC                    43.5
#> 1457       Central Michigan  MAC                    43.0
#> 1458                 Baylor  B12                    42.7
#> 1459                 Howard MEAC                    42.2
#> 1460                Oakland Horz                    41.2
#> 1461     Cal St. Northridge   BW                    41.0
#> 1462            Florida A&M SWAC                    40.8
#> 1463                   Penn  Ivy                    40.4
#> 1464                Florida  SEC                    40.2
#> 1465                Wofford   SC                    39.3
#> 1466                Wyoming  MWC                    39.1
#> 1467     North Carolina A&T  CAA                    39.0
#> 1468           Grand Canyon  WAC                    38.5
#> 1469              Merrimack  NEC                    38.3
#> 1470           North Dakota  Sum                    38.1
#> 1471              Louisiana   SB                    38.1
#> 1472                    VMI   SC                    37.7
#> 1473           Missouri St.  MVC                    37.6
#> 1474          Robert Morris Horz                    37.4
#> 1475             Pepperdine  WCC                    36.9
#> 1476            McNeese St. Slnd                    36.8
#> 1477       Central Arkansas ASun                    36.7
#> 1478             Vanderbilt  SEC                    36.7
#> 1479             Kansas St.  B12                    36.7
#> 1480               Miami OH  MAC                    36.5
#> 1481             St. Thomas  Sum                    36.5
#> 1482           UC San Diego   BW                    36.5
#> 1483              Milwaukee Horz                    36.4
#> 1484               Monmouth  CAA                    36.4
#> 1485              Princeton  Ivy                    35.9
#> 1486            Wake Forest  ACC                    35.5
#> 1487                 Auburn  SEC                    35.4
#> 1488                 Queens ASun                    35.3
#> 1489     Eastern Washington BSky                    35.2
#> 1490           Gardner Webb BSth                    35.0
#> 1491                 Furman   SC                    35.0
#> 1492                Harvard  Ivy                    34.8
#> 1493                  Siena MAAC                    34.6
#> 1494                   NJIT   AE                    34.3
#> 1495             Alcorn St. SWAC                    34.1
#> 1496                   Iona MAAC                    34.0
#> 1497            Alabama St. SWAC                    33.9
#> 1498         William & Mary  CAA                    33.9
#> 1499       Tennessee Martin  OVC                    33.6
#> 1500         Nebraska Omaha  Sum                    33.4
#> 1501              Manhattan MAAC                    33.4
#> 1502                Alabama  SEC                    33.1
#> 1503                 Kansas  B12                    33.0
#> 1504               Duquesne  A10                    32.7
#> 1505       Eastern Kentucky ASun                    32.7
#> 1506               Maryland  B10                    32.6
#> 1507              San Diego  WCC                    32.6
#> 1508            North Texas Amer                    32.5
#> 1509       Northern Arizona BSky                    32.5
#> 1510             Notre Dame  ACC                    32.4
#> 1511            Montana St. BSky                    32.4
#> 1512             Providence   BE                    32.1
#> 1513             Washington  P12                    32.1
#> 1514      Northern Illinois  MAC                    32.0
#> 1515                Arizona  P12                    32.0
#> 1516       Loyola Marymount  WCC                    32.0
#> 1517           Northeastern  CAA                    31.9
#> 1518          UNC Asheville BSth                    31.8
#> 1519                  IUPUI Horz                    31.4
#> 1520                 Toledo  MAC                    31.3
#> 1521                 Xavier   BE                    31.3
#> 1522           UMass Lowell   AE                    31.1
#> 1523         Boston College  ACC                    31.1
#> 1524          South Alabama   SB                    30.9
#> 1525           Saint Mary's  WCC                    30.9
#> 1526            Chicago St.  ind                    30.9
#> 1527                  Idaho BSky                    30.9
#> 1528             Georgetown   BE                    30.7
#> 1529                Bradley  MVC                    30.6
#> 1530           Delaware St. MEAC                    30.5
#> 1531            Stony Brook  CAA                    30.3
#> 1532             Texas Tech  B12                    30.2
#> 1533              Lafayette  Pat                    30.1
#> 1534           Kennesaw St. ASun                    29.8
#> 1535               American  Pat                    29.6
#> 1536               Lipscomb ASun                    29.6
#> 1537           Sacred Heart  NEC                    29.4
#> 1538          Saint Francis  NEC                    29.3
#> 1539                  Rider MAAC                    29.1
#> 1540             Coppin St. MEAC                    28.9
#> 1541   UT Rio Grande Valley  WAC                    28.7
#> 1542         Tennessee Tech  OVC                    28.6
#> 1543             Bellarmine ASun                    28.5
#> 1544       Illinois Chicago  MVC                    28.5
#> 1545            Chattanooga   SC                    28.4
#> 1546            Indiana St.  MVC                    28.4
#> 1547          Southern Miss   SB                    28.3
#> 1548              Dartmouth  Ivy                    28.3
#> 1549             Charleston  CAA                    28.1
#> 1550                   Utah  P12                    27.9
#> 1551                Vermont   AE                    27.8
#> 1552                  Akron  MAC                    27.6
#> 1553       UC Santa Barbara   BW                    27.5
#> 1554               Bucknell  Pat                    27.4
#> 1555           Tarleton St.  WAC                    27.0
#> 1556      George Washington  A10                    26.9
#> 1557                 DePaul   BE                    26.8
#> 1558            Wichita St. Amer                    26.4
#> 1559          Grambling St. SWAC                    26.4
#> 1560          West Virginia  B12                    26.2
#> 1561                   Duke  ACC                    26.2
#> 1562             Binghamton   AE                    25.9
#> 1563               Syracuse  ACC                    25.8
#> 1564                 Albany   AE                    25.5
#> 1565 North Carolina Central MEAC                    25.5
#> 1566             New Mexico  MWC                    25.2
#> 1567                Gonzaga  WCC                    25.0
#> 1568          San Francisco  WCC                    24.9
#> 1569          James Madison   SB                    24.8
#> 1570       South Dakota St.  Sum                    24.7
#> 1571           Nicholls St. Slnd                    24.6
#> 1572                 Oregon  P12                    24.5
#> 1573                    FIU CUSA                    24.4
#> 1574       Eastern Illinois  OVC                    24.4
#> 1575           George Mason  A10                    24.3
#> 1576                Belmont  MVC                    24.2
#> 1577           San Jose St.  MWC                    24.2
#> 1578        Sam Houston St. CUSA                    24.1
#> 1579          North Alabama ASun                    24.1
#> 1580               Michigan  B10                    24.0
#> 1581               Colorado  P12                    23.5
#> 1582       North Dakota St.  Sum                    23.4
#> 1583            The Citadel   SC                    23.4
#> 1584           Georgia Tech  ACC                    23.4
#> 1585           Presbyterian BSth                    23.3
#> 1586              Boise St.  MWC                    23.2
#> 1587              Marquette   BE                    23.2
#> 1588                 Dayton  A10                    23.1
#> 1589                   UTEP CUSA                    23.0
#> 1590          Southern Utah  WAC                    23.0
#> 1591                 Wagner  NEC                    23.0
#> 1592                    BYU  B12                    22.8
#> 1593               Delaware  CAA                    22.6
#> 1594             Wright St. Horz                    22.5
#> 1595           Morehead St.  OVC                    22.5
#> 1596               Iowa St.  B12                    22.5
#> 1597             Louisville  ACC                    22.4
#> 1598           Arkansas St.   SB                    22.4
#> 1599              Minnesota  B10                    21.9
#> 1600                 Butler   BE                    21.9
#> 1601      Stephen F. Austin  WAC                    21.7
#> 1602                Colgate  Pat                    21.6
#> 1603         Youngstown St. Horz                    21.5
#> 1604       Northwestern St. Slnd                    21.4
#> 1605                  Drake  MVC                    21.3
#> 1606 Texas A&M Corpus Chris Slnd                    21.3
#> 1607               Le Moyne  NEC                    21.1
#> 1608              Utah Tech  WAC                    21.0
#> 1609               Kent St.  MAC                    20.9
#> 1610           Oklahoma St.  B12                    20.8
#> 1611          Virginia Tech  ACC                    20.6
#> 1612             Valparaiso  MVC                    20.6
#> 1613                 Purdue  B10                    20.6
#> 1614            Arizona St.  P12                    20.5
#> 1615    Cal St. Bakersfield   BW                    20.5
#> 1616               UC Davis   BW                    20.5
#> 1617              Texas A&M  SEC                    20.4
#> 1618              Texas St.   SB                    20.2
#> 1619                 Denver  Sum                    20.1
#> 1620                    LIU  NEC                    20.1
#> 1621       Western Michigan  MAC                    20.0
#> 1622      Purdue Fort Wayne Horz                    19.7
#> 1623       Georgia Southern   SB                    19.7
#> 1624                 Mercer   SC                    19.6
#> 1625                   Yale  Ivy                    19.6
#> 1626             Oregon St.  P12                    19.5
#> 1627              Stonehill  NEC                    19.3
#> 1628          East Carolina Amer                    19.3
#> 1629              Creighton   BE                    19.2
#> 1630         North Carolina  ACC                    19.0
#> 1631                   Ohio  MAC                    19.0
#> 1632                Seattle  WAC                    19.0
#> 1633                   Navy  Pat                    18.9
#> 1634                Indiana  B10                    18.5
#> 1635           Illinois St.  MVC                    18.5
#> 1636        Appalachian St.   SB                    18.4
#> 1637         Sacramento St. BSky                    18.1
#> 1638             Evansville  MVC                    18.0
#> 1639                   Rice Amer                    17.9
#> 1640             Cincinnati  B12                    17.9
#> 1641          Saint Peter's MAAC                    17.9
#> 1642            Saint Louis  A10                    17.7
#> 1643              Idaho St. BSky                    17.5
#> 1644           Jacksonville ASun                    17.4
#> 1645                Rutgers  B10                    17.4
#> 1646           Oral Roberts  Sum                    17.4
#> 1647       SIU Edwardsville  OVC                    17.4
#> 1648             Holy Cross  Pat                    17.4
#> 1649          Northern Iowa  MVC                    17.3
#> 1650                  Tulsa Amer                    17.1
#> 1651                   Army  Pat                    17.0
#> 1652             Lindenwood  OVC                    16.9
#> 1653          New Hampshire   AE                    16.9
#> 1654               Winthrop BSth                    16.7
#> 1655         Washington St.  P12                    16.7
#> 1656                    USC  P12                    16.5
#> 1657           UC Riverside   BW                    16.4
#> 1658             Quinnipiac MAAC                    16.3
#> 1659             Morgan St. MEAC                    16.3
#> 1660         Incarnate Word Slnd                    16.2
#> 1661                Cornell  Ivy                    16.2
#> 1662         Loyola Chicago  A10                    16.1
#> 1663                    UAB Amer                    16.1
#> 1664       Mount St. Mary's MAAC                    16.1
#> 1665           UT Arlington  WAC                    16.0
#> 1666              Weber St. BSky                    16.0
#> 1667               Stanford  P12                    15.9
#> 1668                Pacific  WCC                    15.8
#> 1669             Seton Hall   BE                    15.8
#> 1670     Florida Gulf Coast ASun                    15.7
#> 1671                   UTSA Amer                    15.7
#> 1672         New Mexico St. CUSA                    15.7
#> 1673               Marshall   SB                    15.5
#> 1674          Detroit Mercy Horz                    15.4
#> 1675     South Carolina St. MEAC                    15.3
#> 1676               Campbell  CAA                    15.2
#> 1677       Florida Atlantic Amer                    14.9
#> 1678        Bethune Cookman SWAC                    14.9
#> 1679            New Orleans Slnd                    14.8
#> 1680      Abilene Christian  WAC                    14.6
#> 1681    Central Connecticut  NEC                    14.4
#> 1682       Coastal Carolina   SB                    14.4
#> 1683                    TCU  B12                    14.3
#> 1684              Loyola MD  Pat                    14.2
#> 1685                    VCU  A10                    14.2
#> 1686           Northwestern  B10                    14.1
#> 1687             Murray St.  MVC                    14.0
#> 1688           Colorado St.  MWC                    13.9
#> 1689       Eastern Michigan  MAC                    13.9
#> 1690         Saint Joseph's  A10                    13.9
#> 1691          Massachusetts  A10                    13.7
#> 1692      Northern Colorado BSky                    13.5
#> 1693               Miami FL  ACC                    13.4
#> 1694               Penn St.  B10                    13.3
#> 1695          Bowling Green  MAC                    13.3
#> 1696        St. Bonaventure  A10                    13.2
#> 1697                    SMU Amer                    13.2
#> 1698      Cal St. Fullerton   BW                    13.1
#> 1699                Niagara MAAC                    13.1
#> 1700               Canisius MAAC                    13.0
#> 1701                Montana BSky                    13.0
#> 1702      Houston Christian Slnd                    12.9
#> 1703                Liberty CUSA                    12.9
#> 1704        Mississippi St.  SEC                    12.8
#> 1705          Tennessee St.  OVC                    12.8
#> 1706               Longwood BSth                    12.8
#> 1707           South Dakota  Sum                    12.8
#> 1708 Southeastern Louisiana Slnd                    12.6
#> 1709                   UMBC   AE                    12.3
#> 1710               La Salle  A10                    12.1
#> 1711            Georgia St.   SB                    12.0
#> 1712           Portland St. BSky                    11.9
#> 1713       Middle Tennessee CUSA                    11.9
#> 1714               Arkansas  SEC                    11.8
#> 1715         UNC Greensboro   SC                    11.8
#> 1716         Long Beach St.   BW                    11.7
#> 1717              Tennessee  SEC                    11.7
#> 1718           Old Dominion   SB                    11.4
#> 1719             Pittsburgh  ACC                    11.4
#> 1720                Samford   SC                    11.3
#> 1721          Cleveland St. Horz                    11.2
#> 1722                   UCLA  P12                    11.2
#> 1723 Southeast Missouri St.  OVC                    11.2
#> 1724            Connecticut   BE                    11.2
#> 1725               Oklahoma  B12                    11.1
#> 1726                   UNLV  MWC                    11.1
#> 1727               Columbia  Ivy                    11.1
#> 1728 Maryland Eastern Shore MEAC                    11.1
#> 1729                Georgia  SEC                    11.0
#> 1730               Cal Poly   BW                    11.0
#> 1731       Southern Indiana  OVC                    10.6
#> 1732          San Diego St.  MWC                    10.6
#> 1733                  Texas  B12                    10.6
#> 1734      Boston University  Pat                    10.5
#> 1735                 Nevada  MWC                    10.5
#> 1736          South Florida Amer                    10.3
#> 1737             N.C. State  ACC                    10.1
#> 1738               Southern SWAC                     9.9
#> 1739               Ohio St.  B10                     9.8
#> 1740                 Drexel  CAA                     9.7
#> 1741                Houston  B12                     9.6
#> 1742                 Towson  CAA                     9.5
#> 1743                   Troy   SB                     9.3
#> 1744               Utah St.  MWC                     9.2
#> 1745           Rhode Island  A10                     9.2
#> 1746            Santa Clara  WCC                     9.0
#> 1747             High Point BSth                     9.0
#> 1748         Texas Southern SWAC                     9.0
#> 1749                    LSU  SEC                     8.9
#> 1750            Florida St.  ACC                     8.7
#> 1751                  Maine   AE                     8.7
#> 1752                   Elon  CAA                     8.2
#> 1753            Mississippi  SEC                     8.0
#> 1754            Utah Valley  WAC                     8.0
#> 1755            Alabama A&M SWAC                     7.9
#> 1756                 Temple Amer                     7.8
#> 1757                Fordham  A10                     7.8
#> 1758                Memphis Amer                     7.8
#> 1759               Illinois  B10                     7.6
#> 1760                Buffalo  MAC                     7.6
#> 1761               Richmond  A10                     7.5
#> 1762                Radford BSth                     7.5
#> 1763         Louisiana Tech CUSA                     7.4
#> 1764                   UMKC  Sum                     7.2
#> 1765              Green Bay Horz                     7.2
#> 1766                 Lehigh  Pat                     7.2
#> 1767           Michigan St.  B10                     7.1
#> 1768               Virginia  ACC                     6.9
#> 1769                  Lamar Slnd                     6.8
#> 1770              Charlotte Amer                     6.7
#> 1771                 Hawaii   BW                     6.1
#> 1772                Stetson ASun                     6.0
#> 1773         UNC Wilmington  CAA                     5.9
#> 1774                    UCF  B12                     5.8
#> 1775              Fairfield MAAC                     5.6
#> 1776                 Marist MAAC                     5.6
#> 1777            Norfolk St. MEAC                     5.5
#> 1778                Hampton  CAA                     5.3
#> 1779       Western Illinois  OVC                     4.8
#> 1780               Kentucky  SEC                     4.4
#> 1781            USC Upstate BSth                     4.2
#> 1782                Clemson  ACC                     4.0
#> 1783               Nebraska  B10                     3.6
#> 1784       Western Carolina   SC                     3.3
#> 1785               Davidson  A10                     3.3
#> 1786                   Iowa  B10                     2.4
#> 1787              Villanova   BE                     2.2
#> 1788              Wisconsin  B10                     2.1
#> 1789       Jacksonville St. CUSA                     1.9
#> 1790                Hofstra  CAA                     1.1
#> 1791              UC Irvine   BW                     1.1
#> 1792       Western Kentucky CUSA                     1.0
#> 1793             St. John's   BE                     0.6
#>      TwoFoulParticpation.Pct.Rk Adj2FP Adj2FP.Rk TwoFoulTotalTime
#> 1                             1   45.2         1           334:36
#> 2                             2   39.0         2           173:06
#> 3                             3   33.6         4           269:13
#> 4                             4   32.0         7           395:19
#> 5                             5   32.4         6           276:14
#> 6                             6   34.1         3           342:08
#> 7                             7   32.6         5           275:21
#> 8                             8   29.7        10           225:56
#> 9                             9   30.0         8           160:07
#> 10                           10   30.0         9           261:18
#> 11                           11   28.7        11           160:45
#> 12                           12   28.6        12           164:15
#> 13                           13   25.9        16           340:00
#> 14                           14   28.2        13           297:24
#> 15                           15   25.1        18           266:50
#> 16                           16   26.4        14           263:50
#> 17                           17   25.3        17           318:53
#> 18                           18   26.1        15           375:07
#> 19                           19   22.1        22           277:50
#> 20                           20   24.8        19           308:27
#> 21                           21   23.2        20           354:41
#> 22                           22   23.0        21           161:17
#> 23                           23   20.3        26           285:39
#> 24                           24   21.1        25           269:16
#> 25                           25   21.9        23           471:23
#> 26                           26   21.6        24           215:57
#> 27                           27   19.4        29           123:25
#> 28                           28   19.6        28           243:49
#> 29                           29   19.1        33           265:36
#> 30                           30   19.3        31           282:29
#> 31                           31   15.8        42           177:27
#> 32                           32   19.3        30           280:25
#> 33                           33   19.2        32           141:25
#> 34                           34   15.5        43           145:34
#> 35                           35   19.1        34           210:25
#> 36                           36   18.2        35           184:14
#> 37                           37   17.9        37           244:42
#> 38                           38   17.3        38           275:04
#> 39                           39   18.1        36           225:09
#> 40                           40   19.8        27           197:31
#> 41                           41   16.2        41           301:01
#> 42                           42   16.3        40           447:05
#> 43                           43   14.0        49           228:31
#> 44                           44   12.9        54           298:21
#> 45                           45   15.2        45           321:42
#> 46                           46   16.4        39           204:23
#> 47                           47   13.4        50           281:35
#> 48                           48   15.3        44           272:52
#> 49                           49   13.2        51           225:53
#> 50                           50   13.0        53           380:20
#> 51                           51   12.3        55           331:25
#> 52                           52   15.0        46           216:30
#> 53                           53   14.3        48           362:33
#> 54                           54   14.7        47           354:30
#> 55                           55   13.1        52           323:55
#> 56                           56   10.6        62           335:12
#> 57                           57   11.0        59           226:06
#> 58                           58   10.8        60           352:31
#> 59                           59    8.8        70           205:32
#> 60                           60   10.1        65           277:27
#> 61                           61   11.1        57           303:26
#> 62                           62   11.6        56           279:23
#> 63                           63    8.4        71           268:47
#> 64                           64   11.0        58           242:43
#> 65                           65   10.8        61           219:00
#> 66                           66    7.7        74           169:37
#> 67                           67    6.2        86           216:18
#> 68                           68    9.5        66           234:16
#> 69                           69    9.0        69           283:37
#> 70                           70   10.1        64           204:51
#> 71                           71    9.4        67           316:51
#> 72                           72    6.4        85           238:19
#> 73                           73    9.1        68           340:33
#> 74                           74   10.3        63           183:07
#> 75                           75    6.9        79           254:39
#> 76                           76    7.2        77           320:57
#> 77                           77    8.2        72           311:49
#> 78                           78    7.6        75           146:02
#> 79                           79    5.9        93           271:43
#> 80                           80    6.6        81           229:56
#> 81                           81    4.8       104           154:13
#> 82                           82    7.8        73           372:09
#> 83                           83    5.6        96           247:02
#> 84                           84    5.6        97           187:42
#> 85                           85    6.0        88           230:31
#> 86                           86    5.0       101           395:35
#> 87                           87    6.7        80           217:35
#> 88                           88    7.0        78           228:52
#> 89                           89    5.6        95           203:50
#> 90                           90    6.2        87           228:26
#> 91                           91    5.9        92           232:57
#> 92                           92    7.5        76           208:32
#> 93                           93    6.0        89           250:56
#> 94                           94    4.9       103           137:06
#> 95                           95    4.2       110           107:14
#> 96                           96    5.5        98           258:53
#> 97                           97    4.8       105           223:29
#> 98                           98    4.5       107           307:57
#> 99                           99    6.6        82           408:27
#> 100                         100    6.4        84           325:32
#> 101                         101    6.5        83           242:35
#> 102                         102    3.2       114           279:32
#> 103                         103    6.0        90           174:32
#> 104                         104    4.5       108           263:14
#> 105                         105    5.9        91           186:26
#> 106                         106    5.1       100           215:52
#> 107                         107    5.3        99           232:44
#> 108                         108    4.2       109           311:39
#> 109                         109    2.9       119           244:20
#> 110                         110    1.8       126           259:02
#> 111                         111    2.2       122           190:31
#> 112                         112    4.7       106           327:18
#> 113                         113    2.7       120           313:41
#> 114                         114    3.0       118           204:17
#> 115                         115    5.8        94           128:32
#> 116                         116    3.3       111           246:43
#> 117                         117    4.9       102           208:34
#> 118                         118    1.1       131           274:14
#> 119                         119    3.0       116           289:12
#> 120                         120    1.0       134           303:15
#> 121                         121    3.2       112           289:25
#> 122                         122    0.3       143           127:02
#> 123                         123    3.2       113           187:12
#> 124                         124   -0.1       145           243:31
#> 125                         125    1.0       133           234:51
#> 126                         126   -1.0       157           314:51
#> 127                         127    2.2       121           233:29
#> 128                         128    1.1       132           215:21
#> 129                         129    3.0       117            93:42
#> 130                         130    1.9       124           325:58
#> 131                         131   -0.2       146           190:11
#> 132                         132   -0.4       152           289:40
#> 133                         133    3.2       115           276:24
#> 134                         134    0.8       135           288:16
#> 135                         135    0.5       138           314:35
#> 136                         136    0.8       136           408:54
#> 137                         137    1.3       130           220:18
#> 138                         138    1.8       125           403:55
#> 139                         139    0.4       141           352:24
#> 140                         140    1.9       123           168:45
#> 141                         141   -0.3       149           164:30
#> 142                         142    0.1       144           196:27
#> 143                         143   -0.9       156           289:42
#> 144                         144   -1.2       160           305:15
#> 145                         145    1.6       129           329:25
#> 146                         146    0.4       140           282:00
#> 147                         147   -0.2       148           239:53
#> 148                         148    1.7       127           363:32
#> 149                         149   -2.0       171           366:29
#> 150                         150   -0.4       153           208:49
#> 151                         151    0.5       139           232:34
#> 152                         152   -1.7       167           208:16
#> 153                         153   -0.4       151           234:00
#> 154                         154   -0.8       155           209:53
#> 155                         155    0.6       137           228:11
#> 156                         156   -2.1       172           310:43
#> 157                         157    1.6       128           158:57
#> 158                         158   -3.0       181           207:39
#> 159                         159   -2.9       179           259:35
#> 160                         160   -0.2       147           219:39
#> 161                         161   -1.6       165           268:02
#> 162                         162   -1.4       161           368:33
#> 163                         163   -2.5       176           251:20
#> 164                         164   -1.1       158           294:26
#> 165                         165   -0.3       150           376:12
#> 166                         166   -1.2       159           382:18
#> 167                         167    0.4       142           265:42
#> 168                         168   -1.8       168           194:28
#> 169                         169   -4.9       200           165:29
#> 170                         170   -1.5       163           214:21
#> 171                         171   -3.5       185           135:39
#> 172                         172   -3.1       182           320:44
#> 173                         173   -0.6       154           352:29
#> 174                         174   -1.9       169           315:37
#> 175                         175   -3.6       186           152:03
#> 176                         176   -4.0       189           255:25
#> 177                         177   -1.6       166           310:46
#> 178                         178   -6.0       209           179:00
#> 179                         179   -2.1       173           267:39
#> 180                         180   -5.3       203           212:19
#> 181                         181   -1.5       164           190:38
#> 182                         182   -1.4       162           297:50
#> 183                         183   -4.4       194           100:13
#> 184                         184   -3.1       183           140:05
#> 185                         185   -3.0       180           299:18
#> 186                         186   -2.5       177           193:42
#> 187                         187   -3.8       187           216:06
#> 188                         188   -4.8       198           404:54
#> 189                         189   -4.4       192           160:12
#> 190                         190   -2.4       175           173:28
#> 191                         191   -3.3       184           148:33
#> 192                         192   -4.3       190           261:28
#> 193                         193   -3.8       188           308:33
#> 194                         194   -7.1       223           270:49
#> 195                         195   -5.3       204           279:20
#> 196                         196   -5.7       208           245:40
#> 197                         197   -6.3       213           294:04
#> 198                         198   -4.4       193           243:31
#> 199                         199   -7.0       220           217:47
#> 200                         200   -4.7       197           368:55
#> 201                         201   -7.2       224           280:30
#> 202                         202   -5.5       205           231:53
#> 203                         203   -4.9       201           251:17
#> 204                         204   -6.0       210           303:01
#> 205                         205   -2.3       174           192:04
#> 206                         206   -2.7       178           260:02
#> 207                         207   -4.6       195           287:24
#> 208                         208   -7.1       221           196:08
#> 209                         209   -2.0       170           206:50
#> 210                         210   -6.3       214           165:44
#> 211                         211   -8.1       234           133:04
#> 212                         212   -7.7       230           123:00
#> 213                         213   -7.7       229           230:33
#> 214                         214  -10.1       261           238:37
#> 215                         215   -8.5       240           190:46
#> 216                         216   -6.5       216           323:31
#> 217                         217   -5.3       202           450:15
#> 218                         218   -6.7       219           279:43
#> 219                         219   -6.5       217           330:45
#> 220                         220   -6.7       218           242:00
#> 221                         221   -8.0       233           241:33
#> 222                         222   -6.1       211           200:47
#> 223                         223   -4.6       196           192:10
#> 224                         224   -4.3       191           218:31
#> 225                         225   -4.9       199           221:43
#> 226                         226   -7.8       231           183:01
#> 227                         227   -9.1       248           250:57
#> 228                         228   -5.6       206           215:42
#> 229                         229  -11.2       275           188:34
#> 230                         230  -10.0       259           281:40
#> 231                         231   -8.8       245           146:24
#> 232                         232   -8.5       239           239:57
#> 233                         233   -9.4       250           168:26
#> 234                         234   -8.6       244           111:35
#> 235                         235   -8.3       235           208:16
#> 236                         236  -13.4       298           144:32
#> 237                         237   -8.4       236           278:21
#> 238                         238   -6.2       212           226:44
#> 239                         239   -9.7       254           156:23
#> 240                         240   -7.1       222           297:59
#> 241                         241   -7.4       226           186:52
#> 242                         242   -9.2       249           292:49
#> 243                         243   -9.6       253           183:33
#> 244                         244   -8.6       243           408:16
#> 245                         245  -10.0       260           164:08
#> 246                         246   -8.6       242           211:41
#> 247                         247   -7.6       227           365:33
#> 248                         248   -6.5       215           311:52
#> 249                         249   -8.9       247           186:08
#> 250                         250   -9.4       251           191:54
#> 251                         251  -13.5       300            83:38
#> 252                         252   -9.9       257           312:42
#> 253                         253   -8.4       237           356:48
#> 254                         254  -11.7       279           211:34
#> 255                         255  -10.8       268           216:23
#> 256                         256   -8.4       238           211:32
#> 257                         257  -10.3       263           292:00
#> 258                         258   -9.5       252           223:37
#> 259                         259  -10.8       270           337:40
#> 260                         260   -9.8       255           258:48
#> 261                         261  -12.3       284           196:12
#> 262                         262   -5.6       207           198:35
#> 263                         263  -12.0       281           293:10
#> 264                         264   -7.8       232           180:33
#> 265                         265  -12.1       283           200:40
#> 266                         266  -11.3       276           234:29
#> 267                         267  -10.2       262           243:14
#> 268                         268   -8.8       246           361:26
#> 269                         269   -7.7       228           177:17
#> 270                         270  -12.5       286           172:15
#> 271                         271   -8.5       241           261:08
#> 272                         272  -11.0       272           226:26
#> 273                         273  -10.9       271           293:49
#> 274                         274  -12.6       287           150:27
#> 275                         275  -13.3       295           193:54
#> 276                         276  -10.4       265           236:33
#> 277                         277  -10.0       258           264:19
#> 278                         278   -9.9       256           279:03
#> 279                         279  -15.1       307           142:37
#> 280                         280  -12.9       293           145:04
#> 281                         281  -11.7       278           234:49
#> 282                         282  -15.6       313           120:30
#> 283                         283  -10.8       269           253:04
#> 284                         284  -10.4       266           110:33
#> 285                         285  -13.6       302           183:02
#> 286                         286  -12.4       285           109:34
#> 287                         287  -13.3       294           287:34
#> 288                         288  -13.4       299           233:52
#> 289                         289   -7.3       225           170:30
#> 290                         290  -11.1       274           240:28
#> 291                         291  -11.8       280           233:23
#> 292                         292  -10.6       267           260:51
#> 293                         293  -11.3       277           209:17
#> 294                         294  -15.7       315           158:14
#> 295                         295  -12.7       290           306:00
#> 296                         296  -11.1       273           229:50
#> 297                         297  -14.2       304           196:33
#> 298                         298  -17.2       332           171:00
#> 299                         299  -12.9       292           203:56
#> 300                         300  -15.7       316           152:31
#> 301                         301  -12.1       282           337:03
#> 302                         302  -12.6       288           285:17
#> 303                         303  -16.3       322           263:59
#> 304                         304  -12.7       289           213:33
#> 305                         305  -14.9       306           238:51
#> 306                         306  -12.8       291           184:27
#> 307                         307  -13.4       296           256:33
#> 308                         308  -15.9       317           174:33
#> 309                         309  -16.3       324           244:01
#> 310                         310  -14.1       303           235:48
#> 311                         311  -10.3       264           104:33
#> 312                         312  -13.6       301           117:36
#> 313                         313  -15.5       311           301:57
#> 314                         314  -16.5       326           248:34
#> 315                         315  -16.5       327           271:57
#> 316                         316  -15.5       310           304:11
#> 317                         317  -16.2       321           246:58
#> 318                         318  -15.6       312           149:36
#> 319                         319  -13.4       297           189:46
#> 320                         320  -15.2       308           311:47
#> 321                         321  -17.6       335           199:29
#> 322                         322  -16.7       328           153:21
#> 323                         323  -17.9       337           170:24
#> 324                         324  -14.3       305           267:50
#> 325                         325  -17.5       334           274:20
#> 326                         326  -19.0       343           142:57
#> 327                         327  -15.7       314           142:54
#> 328                         328  -16.1       320           222:52
#> 329                         329  -16.9       331           241:52
#> 330                         330  -15.3       309           268:03
#> 331                         331  -16.7       329           329:50
#> 332                         332  -18.6       341           344:23
#> 333                         333  -19.1       344           104:53
#> 334                         334  -18.0       338           185:33
#> 335                         335  -16.4       325           206:06
#> 336                         336  -16.3       323           327:17
#> 337                         337  -17.3       333           211:45
#> 338                         338  -18.3       340           113:44
#> 339                         339  -19.4       347           178:12
#> 340                         340  -16.7       330           185:31
#> 341                         341  -18.7       342           208:34
#> 342                         342  -22.2       352           143:04
#> 343                         343  -16.1       319           241:38
#> 344                         344  -18.2       339           146:07
#> 345                         345  -21.3       350           156:33
#> 346                         346  -17.7       336           216:32
#> 347                         347  -15.9       318           312:37
#> 348                         348  -21.2       349           271:52
#> 349                         349  -19.1       345           301:02
#> 350                         350  -20.3       348           236:19
#> 351                         351  -24.8       353           109:59
#> 352                         352  -22.0       351           205:31
#> 353                         353  -19.4       346           195:34
#> 354                           1   52.8         1             6:08
#> 355                           1    0.0         1             0:00
#> 356                           1    0.0         1             0:00
#> 357                           1    0.0         1             0:00
#> 358                           1    0.0         1             0:00
#> 359                           1    0.0         1             0:00
#> 360                           1    0.0         1             0:00
#> 361                           1    0.0         1             0:00
#> 362                           1    0.0         1             0:00
#> 363                           1    0.0         1             0:00
#> 364                           1    0.0         1             0:00
#> 365                           2   38.5         5            17:40
#> 366                           3   43.4         3           184:29
#> 367                           4   45.0         2           220:08
#> 368                           5   40.2         4           151:07
#> 369                           6   36.6         6           240:37
#> 370                           7   34.9         8           103:28
#> 371                           8   33.3        10           115:42
#> 372                           9   33.5         9           200:21
#> 373                          10   36.1         7           159:53
#> 374                          11   32.3        11           156:34
#> 375                          12   28.3        16           140:30
#> 376                          13   26.3        19           179:33
#> 377                          14   29.8        13           221:18
#> 378                          15   30.0        12           246:06
#> 379                          16   29.5        14           191:39
#> 380                          17   27.6        17           310:27
#> 381                          18   25.0        21           134:58
#> 382                          19   27.1        18           312:56
#> 383                          20   25.1        20           145:05
#> 384                          21   23.2        26           214:39
#> 385                          22   28.7        15           258:36
#> 386                          23   24.5        22           154:51
#> 387                          24   20.3        34           108:26
#> 388                          25   22.5        28           154:42
#> 389                          26   20.7        32           172:51
#> 390                          27   23.0        27           189:45
#> 391                          28   23.2        25           198:25
#> 392                          29   20.0        36           123:14
#> 393                          30   23.9        23           215:02
#> 394                          31   21.2        30           179:38
#> 395                          32   20.6        33           202:23
#> 396                          33   23.7        24           205:23
#> 397                          34   21.2        29           139:29
#> 398                          35   21.0        31           156:33
#> 399                          36   20.1        35           149:35
#> 400                          37   19.0        37           175:29
#> 401                          38   18.7        38           193:23
#> 402                          39   18.0        41           205:07
#> 403                          40   17.9        42           176:27
#> 404                          41   17.2        45           218:25
#> 405                          42   18.1        40           316:05
#> 406                          43   17.0        47           230:20
#> 407                          44   18.3        39           177:01
#> 408                          45   14.7        56           189:17
#> 409                          46   14.8        55           151:40
#> 410                          47   15.8        50           171:03
#> 411                          48   14.5        57           218:11
#> 412                          49   17.5        43           238:11
#> 413                          50   17.5        44           189:58
#> 414                          51   15.1        52           206:06
#> 415                          52   14.4        58           227:46
#> 416                          53   16.3        49           249:49
#> 417                          54   17.1        46           374:51
#> 418                          55   13.6        60           182:34
#> 419                          56   15.0        54           285:24
#> 420                          57   15.7        51           314:54
#> 421                          58   13.8        59           190:57
#> 422                          59   11.3        70           131:08
#> 423                          60   12.3        64           166:17
#> 424                          61   12.1        65           160:14
#> 425                          62    9.5        83           150:34
#> 426                          63   16.5        48           206:03
#> 427                          64    8.2        89           218:49
#> 428                          65   11.4        69           286:49
#> 429                          66   12.3        63           194:18
#> 430                          67    9.7        80           227:43
#> 431                          68   11.4        67           212:53
#> 432                          69   11.4        68           125:47
#> 433                          70   15.1        53            65:11
#> 434                          71   10.5        73           228:25
#> 435                          72    9.7        81            74:48
#> 436                          73   12.3        62           263:15
#> 437                          74    9.3        85           109:17
#> 438                          75   10.0        78           201:55
#> 439                          76    9.1        87           192:10
#> 440                          77   11.5        66           171:53
#> 441                          78   10.2        76           170:12
#> 442                          79   12.9        61           135:01
#> 443                          80    9.8        79           145:23
#> 444                          81    5.3       108            80:40
#> 445                          82    9.6        82           167:43
#> 446                          83    7.8        90           202:41
#> 447                          84   10.5        74           223:23
#> 448                          85   10.5        72           218:55
#> 449                          86    8.6        88           256:10
#> 450                          87   11.3        71           168:09
#> 451                          88   10.4        75           106:25
#> 452                          89    9.1        86           188:32
#> 453                          90    5.1       109           157:52
#> 454                          91    6.2       100           145:29
#> 455                          92    5.0       111           236:48
#> 456                          93    9.3        84           187:58
#> 457                          94    5.8       103           181:13
#> 458                          95    3.8       121           292:40
#> 459                          96    6.2       101           233:37
#> 460                          97    7.2        95           198:32
#> 461                          98    3.8       120           103:54
#> 462                          99    5.7       104           121:05
#> 463                         100    7.0        96           220:00
#> 464                         101    7.3        93            67:45
#> 465                         102   10.2        77           246:09
#> 466                         103    2.4       129           146:14
#> 467                         104    7.7        91           303:04
#> 468                         105    7.2        94           214:50
#> 469                         106    4.3       118           127:35
#> 470                         107    5.9       102           253:31
#> 471                         108    6.3        98           302:51
#> 472                         109    3.1       125           303:52
#> 473                         110    7.6        92           283:49
#> 474                         111    4.8       113           200:19
#> 475                         112    5.7       105           100:49
#> 476                         113    4.3       117           218:07
#> 477                         114    6.2        99           276:16
#> 478                         115    4.8       112           135:42
#> 479                         116    4.1       119           301:20
#> 480                         117    2.5       127            79:29
#> 481                         118    5.7       106           226:30
#> 482                         119    5.3       107           381:27
#> 483                         120   -1.3       162            86:51
#> 484                         121    6.5        97           236:59
#> 485                         122    2.6       126            85:30
#> 486                         123    4.4       116           202:33
#> 487                         124    1.2       138           247:01
#> 488                         125    4.5       114           241:30
#> 489                         126    3.1       124            94:26
#> 490                         127    2.1       133           249:29
#> 491                         128    0.5       144           190:37
#> 492                         129    1.2       139           177:32
#> 493                         130    0.4       146           133:12
#> 494                         131    0.2       150           132:42
#> 495                         132    2.1       134           130:16
#> 496                         133    1.5       136           225:14
#> 497                         134    2.5       128           126:47
#> 498                         135    3.6       123           307:55
#> 499                         136    3.6       122           212:49
#> 500                         137    5.0       110           207:33
#> 501                         138   -0.5       156           168:34
#> 502                         139    1.4       137           171:28
#> 503                         140    1.1       140           181:41
#> 504                         141    2.4       130           298:50
#> 505                         142   -1.7       166           153:04
#> 506                         143    0.7       143           170:59
#> 507                         144    0.3       148           208:24
#> 508                         145   -1.3       161           198:55
#> 509                         146   -3.0       174           174:57
#> 510                         147    4.4       115           139:25
#> 511                         148    0.1       151           215:32
#> 512                         149   -0.3       154           287:29
#> 513                         150    0.3       147           149:51
#> 514                         151   -3.0       176           149:50
#> 515                         152    0.9       141            81:41
#> 516                         153    0.5       145           154:58
#> 517                         154    0.9       142           176:49
#> 518                         155   -2.3       170           236:46
#> 519                         156   -1.2       160           133:29
#> 520                         157   -4.7       187           125:43
#> 521                         158    0.2       149           233:55
#> 522                         159   -1.6       163           183:48
#> 523                         160    2.1       131           254:59
#> 524                         161   -1.2       159           167:13
#> 525                         162   -0.4       155           158:52
#> 526                         163    1.9       135           205:38
#> 527                         164   -4.3       184           121:55
#> 528                         165   -0.9       157           148:54
#> 529                         166   -4.2       183           202:08
#> 530                         167    2.1       132            70:32
#> 531                         168   -2.5       171           135:14
#> 532                         169   -0.1       153           207:16
#> 533                         170   -4.7       188           108:44
#> 534                         171   -2.3       169           161:32
#> 535                         172   -1.7       164           225:29
#> 536                         173   -1.9       167           230:18
#> 537                         174   -3.4       178           238:53
#> 538                         175   -4.6       185           178:15
#> 539                         176   -1.0       158           224:38
#> 540                         177   -3.7       180           208:31
#> 541                         178   -1.7       165           161:30
#> 542                         179   -3.0       175           269:41
#> 543                         180    0.1       152           192:29
#> 544                         181   -4.9       194           192:56
#> 545                         182   -2.2       168           182:44
#> 546                         183   -2.8       172           293:58
#> 547                         184   -7.2       219           150:23
#> 548                         185   -5.1       197           248:14
#> 549                         186   -3.0       173           180:27
#> 550                         187   -6.5       205           142:29
#> 551                         188   -4.7       190            75:43
#> 552                         189   -7.2       218           144:56
#> 553                         190   -5.0       195           184:47
#> 554                         191   -3.6       179           191:57
#> 555                         192   -5.7       202           178:40
#> 556                         193   -6.8       210           224:28
#> 557                         194   -3.1       177           215:05
#> 558                         195   -8.7       233           211:02
#> 559                         196   -4.9       193           272:35
#> 560                         197   -4.6       186           178:31
#> 561                         198   -4.0       181           227:46
#> 562                         199   -4.9       192           208:41
#> 563                         200   -5.3       199           176:24
#> 564                         201   -6.5       206           202:08
#> 565                         202   -4.2       182           294:08
#> 566                         203   -5.4       200           190:03
#> 567                         204   -7.9       225           134:00
#> 568                         205   -4.7       189           206:20
#> 569                         206   -6.2       204           320:52
#> 570                         207   -8.2       228           206:44
#> 571                         208   -5.1       198           236:28
#> 572                         209   -7.9       224           105:55
#> 573                         210   -6.5       207           176:07
#> 574                         211   -7.1       216           119:23
#> 575                         212   -9.1       239           155:15
#> 576                         213   -4.7       191           211:48
#> 577                         214   -5.7       201           269:33
#> 578                         215   -6.9       211           190:51
#> 579                         216   -6.9       212           188:32
#> 580                         217  -10.2       249           257:20
#> 581                         218   -6.8       209           286:26
#> 582                         219   -5.1       196           216:20
#> 583                         220   -6.6       208           238:41
#> 584                         221   -7.2       217           176:24
#> 585                         222   -7.0       213           125:18
#> 586                         223   -7.0       214           305:22
#> 587                         224   -8.6       232           140:20
#> 588                         225   -7.5       221           248:24
#> 589                         226   -8.0       226           135:49
#> 590                         227   -8.3       229           130:48
#> 591                         228   -8.5       231           138:32
#> 592                         229   -8.2       227           258:16
#> 593                         230   -9.6       242           102:00
#> 594                         231   -7.7       222           199:35
#> 595                         232   -7.1       215           124:06
#> 596                         233   -9.2       240           253:57
#> 597                         234   -6.1       203           192:50
#> 598                         235   -7.3       220           189:33
#> 599                         236  -10.6       256           128:58
#> 600                         237   -8.7       234           232:54
#> 601                         238  -10.9       258           180:26
#> 602                         239   -8.9       237           203:28
#> 603                         240  -11.1       259           115:20
#> 604                         241  -12.3       269           123:47
#> 605                         242   -9.6       243           258:51
#> 606                         243  -12.0       267           100:41
#> 607                         244   -8.8       235           112:36
#> 608                         245   -9.7       244           171:37
#> 609                         246  -10.3       251            92:59
#> 610                         247  -10.5       255           167:17
#> 611                         248   -9.2       241           236:58
#> 612                         249   -9.9       246            70:45
#> 613                         250  -10.0       247           302:07
#> 614                         251  -12.9       273           170:35
#> 615                         252   -8.3       230           342:18
#> 616                         253  -11.1       260           225:52
#> 617                         254  -10.2       248           130:24
#> 618                         255  -11.5       261           202:40
#> 619                         256  -16.0       305           130:28
#> 620                         257   -9.9       245           212:46
#> 621                         258  -11.5       262           199:46
#> 622                         259   -7.8       223           188:00
#> 623                         260  -11.8       265           149:16
#> 624                         261  -12.6       270           257:12
#> 625                         262  -12.8       272           152:12
#> 626                         263  -10.8       257           111:31
#> 627                         264  -10.5       254           195:08
#> 628                         265  -12.3       268           154:16
#> 629                         266   -9.0       238           164:59
#> 630                         267  -10.3       252           135:36
#> 631                         268  -11.7       264           138:09
#> 632                         269  -14.1       284            91:04
#> 633                         270  -13.8       281           190:42
#> 634                         271  -13.8       280           228:29
#> 635                         272  -13.7       279           220:42
#> 636                         273  -12.9       275           173:52
#> 637                         274  -14.8       291           165:06
#> 638                         275  -12.9       274           233:08
#> 639                         276  -10.4       253           212:27
#> 640                         277  -10.3       250           171:28
#> 641                         278  -14.1       285           158:20
#> 642                         279  -14.3       286           210:04
#> 643                         280  -13.4       277           110:27
#> 644                         281  -15.9       304           118:21
#> 645                         282  -14.7       290           142:20
#> 646                         283  -14.8       292           141:46
#> 647                         284  -13.6       278           230:08
#> 648                         285  -11.6       263           111:12
#> 649                         286   -8.8       236            83:02
#> 650                         287  -15.5       300           135:24
#> 651                         288  -11.8       266           156:05
#> 652                         289  -16.5       311            90:37
#> 653                         290  -15.8       303           220:44
#> 654                         291  -13.8       282           187:22
#> 655                         292  -14.5       289           150:57
#> 656                         293  -14.4       287           173:26
#> 657                         294  -15.3       298           251:44
#> 658                         295  -15.7       302           133:51
#> 659                         296  -15.5       301           225:41
#> 660                         297  -13.1       276           267:59
#> 661                         298  -14.0       283           188:34
#> 662                         299  -15.2       297           205:05
#> 663                         300  -14.9       293           144:25
#> 664                         301  -15.3       299           114:26
#> 665                         302  -18.2       317           282:01
#> 666                         303  -16.2       308           173:23
#> 667                         304  -14.9       294           330:00
#> 668                         305  -18.7       322            92:52
#> 669                         306  -18.0       316           284:29
#> 670                         307  -15.1       296           228:46
#> 671                         308  -12.7       271           194:31
#> 672                         309  -16.1       306           211:08
#> 673                         310  -17.4       315           125:52
#> 674                         311  -14.4       288           249:18
#> 675                         312  -18.2       318           153:20
#> 676                         313  -16.2       309           255:07
#> 677                         314  -18.7       321           192:56
#> 678                         315  -19.3       326           221:26
#> 679                         316  -17.0       314            84:28
#> 680                         317  -16.1       307           198:14
#> 681                         318  -18.5       319           163:52
#> 682                         319  -19.8       329           227:59
#> 683                         320  -19.3       325           130:25
#> 684                         321  -20.0       332           173:17
#> 685                         322  -16.5       312           245:37
#> 686                         323  -20.0       331            69:24
#> 687                         324  -22.6       344           134:40
#> 688                         325  -15.0       295           243:48
#> 689                         326  -16.2       310           188:03
#> 690                         327  -18.5       320           116:12
#> 691                         328  -19.9       330            98:48
#> 692                         329  -18.9       323           218:51
#> 693                         330  -20.4       337           127:37
#> 694                         331  -21.0       340            68:18
#> 695                         332  -17.0       313           152:07
#> 696                         333  -20.7       338           131:07
#> 697                         334  -19.5       327           114:32
#> 698                         335  -20.1       334           133:12
#> 699                         336  -19.1       324           269:54
#> 700                         337  -20.1       336           135:15
#> 701                         338  -22.2       343            89:25
#> 702                         339  -19.6       328           133:58
#> 703                         340  -20.1       333           188:19
#> 704                         341  -20.1       335           105:58
#> 705                         342  -22.1       342            79:13
#> 706                         343  -20.8       339           212:38
#> 707                         344  -23.6       347           160:27
#> 708                         345  -22.7       345           187:14
#> 709                         346  -21.6       341           104:15
#> 710                         347  -23.6       346           175:14
#> 711                           1   44.1         1           218:50
#> 712                           2   39.8         2           291:46
#> 713                           3   38.9         5           217:57
#> 714                           4   39.7         3           305:22
#> 715                           5   34.6         6           206:41
#> 716                           6   39.0         4           265:32
#> 717                           7   33.5         7           221:23
#> 718                           8   33.4         8           440:51
#> 719                           9   30.7        10           195:40
#> 720                          10   31.5         9           224:02
#> 721                          11   30.2        11           315:06
#> 722                          12   27.9        12           195:12
#> 723                          13   26.5        14           158:39
#> 724                          14   26.5        13           254:36
#> 725                          15   26.1        15           136:56
#> 726                          16   23.7        19           287:51
#> 727                          17   24.8        16           243:02
#> 728                          18   24.7        17           258:42
#> 729                          19   23.9        18           409:58
#> 730                          20   20.2        27           177:23
#> 731                          21   21.7        24           114:04
#> 732                          22   23.5        20           277:19
#> 733                          23   22.1        22           306:53
#> 734                          24   21.8        23           291:50
#> 735                          25   22.1        21           256:41
#> 736                          26   20.1        28           286:18
#> 737                          27   21.0        25           323:13
#> 738                          28   20.6        26           277:41
#> 739                          29   19.5        29           251:53
#> 740                          30   18.7        31           175:41
#> 741                          31   18.1        35           218:11
#> 742                          32   18.2        34           251:31
#> 743                          33   18.3        32           197:28
#> 744                          34   18.7        30           145:43
#> 745                          35   18.2        33           254:03
#> 746                          36   15.8        38           193:27
#> 747                          37   14.6        42           184:15
#> 748                          38   14.3        45           247:50
#> 749                          39   15.4        41           178:28
#> 750                          40   17.2        36           127:38
#> 751                          41   15.8        39           264:24
#> 752                          42   16.5        37           237:11
#> 753                          43   13.8        48           265:43
#> 754                          44   12.6        55           224:11
#> 755                          45   12.1        58           201:13
#> 756                          46   14.2        46           296:48
#> 757                          47   14.6        43           196:03
#> 758                          48   13.6        49           220:34
#> 759                          49   13.0        52           157:56
#> 760                          50   14.4        44           178:35
#> 761                          51   13.0        51           185:19
#> 762                          52   12.4        57           216:15
#> 763                          53   14.0        47           304:24
#> 764                          54   12.8        54           200:32
#> 765                          55   10.1        67           191:37
#> 766                          56   11.8        60           309:39
#> 767                          57   13.2        50           253:01
#> 768                          58   10.4        66           178:16
#> 769                          59   15.5        40           212:59
#> 770                          60   10.4        65           337:05
#> 771                          61   11.0        62           322:48
#> 772                          62   12.8        53           414:22
#> 773                          63   11.9        59           234:22
#> 774                          64    8.4        75           288:31
#> 775                          65    9.3        68           192:11
#> 776                          66   12.6        56           184:40
#> 777                          67   11.2        61           222:53
#> 778                          68   10.5        63           245:02
#> 779                          69    8.1        80           296:12
#> 780                          70   10.4        64           210:28
#> 781                          71    7.4        89           160:52
#> 782                          72    8.8        70           161:41
#> 783                          73    9.3        69           376:54
#> 784                          74    7.9        81           273:11
#> 785                          75    7.4        88           118:10
#> 786                          76    7.8        83           189:03
#> 787                          77    7.4        87           225:13
#> 788                          78    5.9       103           122:10
#> 789                          79    8.3        77           253:01
#> 790                          80    8.7        72           318:30
#> 791                          81    8.2        78           218:21
#> 792                          82    7.8        84           116:59
#> 793                          83    6.0       101           244:05
#> 794                          84    6.1        98           222:50
#> 795                          85    6.2        97           264:37
#> 796                          86    7.3        90           279:02
#> 797                          87    8.1        79           317:09
#> 798                          88    5.0       113           210:16
#> 799                          89    8.4        76           328:11
#> 800                          90    7.0        91           266:39
#> 801                          91    6.4        95           242:36
#> 802                          92    8.4        74           191:34
#> 803                          93    3.0       127           186:12
#> 804                          94    7.7        85           175:18
#> 805                          95    8.8        71           214:37
#> 806                          96    7.8        82           231:10
#> 807                          97    6.0        99           192:44
#> 808                          98    5.7       107           163:04
#> 809                          99    5.3       110           145:18
#> 810                         100    6.8        92           208:16
#> 811                         101    6.6        94           195:05
#> 812                         102    5.9       104           183:49
#> 813                         103    8.7        73           175:32
#> 814                         104    6.8        93           189:57
#> 815                         105    7.6        86           235:35
#> 816                         106    5.8       106           120:30
#> 817                         107    5.9       102           258:39
#> 818                         108    3.9       122           342:41
#> 819                         109    3.3       124           182:09
#> 820                         110    5.1       112           231:08
#> 821                         111    6.4        96           142:35
#> 822                         112    5.4       109           161:06
#> 823                         113    5.8       105           188:57
#> 824                         114    2.3       132           178:26
#> 825                         115    5.6       108           238:06
#> 826                         116    4.2       117           345:59
#> 827                         117    4.1       120           265:49
#> 828                         118    4.4       116           248:33
#> 829                         119    5.2       111           357:27
#> 830                         120    2.6       130           260:01
#> 831                         121    4.1       119           324:42
#> 832                         122    4.6       114           446:09
#> 833                         123    6.0       100           216:52
#> 834                         124    1.9       138           136:44
#> 835                         125    2.7       129           279:03
#> 836                         126    2.4       131           173:22
#> 837                         127    3.1       126           300:25
#> 838                         128    0.6       153           209:05
#> 839                         129    1.4       146           262:20
#> 840                         130    4.5       115           259:04
#> 841                         131    4.0       121           309:04
#> 842                         132    3.2       125           293:29
#> 843                         133    2.3       133           149:28
#> 844                         134   -0.7       165            95:14
#> 845                         135    1.7       142           194:10
#> 846                         136    2.8       128           280:11
#> 847                         137    2.3       134           226:20
#> 848                         138    3.7       123           273:17
#> 849                         139    0.7       151           263:18
#> 850                         140    4.2       118           198:27
#> 851                         141    1.5       145           324:01
#> 852                         142    1.8       139           269:59
#> 853                         143   -0.5       161           193:15
#> 854                         144    1.9       137           398:17
#> 855                         145   -1.2       167           252:36
#> 856                         146    0.3       157           236:16
#> 857                         147    1.8       140           337:43
#> 858                         148   -0.2       160            66:37
#> 859                         149    0.0       159           197:40
#> 860                         150    1.4       147           252:25
#> 861                         151    1.6       144           262:29
#> 862                         152    1.6       143           382:49
#> 863                         153    1.7       141           185:05
#> 864                         154    0.8       150           195:02
#> 865                         155    0.4       155           306:30
#> 866                         156    0.6       152           319:06
#> 867                         157   -1.4       169           315:24
#> 868                         158    2.1       136           264:14
#> 869                         159    1.3       148           196:33
#> 870                         160   -2.5       178           200:54
#> 871                         161   -4.7       195           103:56
#> 872                         162   -0.8       166           290:14
#> 873                         163   -1.8       173           223:25
#> 874                         164    2.3       135           208:54
#> 875                         165    0.4       156           258:11
#> 876                         166   -2.1       176           205:08
#> 877                         167    0.0       158           343:24
#> 878                         168   -0.7       163           393:21
#> 879                         169   -1.7       172           210:34
#> 880                         170   -2.0       175           239:02
#> 881                         171    0.4       154           265:43
#> 882                         172    0.9       149           139:08
#> 883                         173   -2.7       179           262:38
#> 884                         174   -1.9       174           188:51
#> 885                         175   -2.5       177           116:53
#> 886                         176   -4.9       201           176:11
#> 887                         177   -0.6       162           394:21
#> 888                         178   -3.3       185           112:51
#> 889                         179   -1.3       168           327:45
#> 890                         180   -4.3       190           164:33
#> 891                         181   -3.0       182           213:56
#> 892                         182   -0.7       164           281:30
#> 893                         183   -4.9       200           321:21
#> 894                         184   -4.5       194           228:15
#> 895                         185   -2.9       181           151:41
#> 896                         186   -4.4       192           141:25
#> 897                         187   -3.1       183           214:59
#> 898                         188   -1.6       171           245:34
#> 899                         189   -4.7       196           271:42
#> 900                         190   -1.4       170           119:27
#> 901                         191   -5.7       207           106:45
#> 902                         192   -4.2       189           146:03
#> 903                         193   -4.7       197           304:42
#> 904                         194   -4.0       188           243:26
#> 905                         195   -5.8       210           156:45
#> 906                         196   -5.8       209           213:49
#> 907                         197   -3.6       186           291:35
#> 908                         198   -5.8       208           344:34
#> 909                         199   -3.8       187           454:03
#> 910                         200   -6.7       218           120:24
#> 911                         201   -5.0       202           225:39
#> 912                         202   -3.2       184           139:50
#> 913                         203   -6.1       214           243:18
#> 914                         204   -7.2       225           300:37
#> 915                         205   -4.4       191           245:08
#> 916                         206   -4.9       199           322:55
#> 917                         207   -7.2       226           144:56
#> 918                         208   -6.5       216           271:12
#> 919                         209   -8.7       246           171:28
#> 920                         210   -7.5       231           127:25
#> 921                         211   -5.3       203           247:29
#> 922                         212   -9.2       250           157:09
#> 923                         213   -7.4       229           100:40
#> 924                         214   -4.8       198           455:58
#> 925                         215   -7.3       228           171:32
#> 926                         216   -7.1       223           236:45
#> 927                         217   -5.3       204           285:42
#> 928                         218   -6.8       221           178:35
#> 929                         219   -2.9       180           183:28
#> 930                         220   -8.3       239           249:42
#> 931                         221   -6.3       215           162:29
#> 932                         222   -6.1       213           234:01
#> 933                         223   -5.9       212           268:28
#> 934                         224   -8.4       241           218:55
#> 935                         225   -8.7       244           360:59
#> 936                         226  -10.7       266           109:58
#> 937                         227   -5.3       205           236:40
#> 938                         228   -4.4       193           126:19
#> 939                         229   -8.1       236           199:37
#> 940                         230   -7.2       227           178:10
#> 941                         231   -7.8       232           159:19
#> 942                         232   -8.5       243            96:19
#> 943                         233   -6.7       219           196:55
#> 944                         234   -8.1       235           198:16
#> 945                         235   -7.1       224           205:43
#> 946                         236   -8.5       242           227:32
#> 947                         237   -6.9       222           209:55
#> 948                         238   -5.9       211           238:12
#> 949                         239   -9.6       253           167:21
#> 950                         240   -6.7       220           375:36
#> 951                         241   -5.5       206           307:30
#> 952                         242   -7.4       230            78:55
#> 953                         243   -8.1       234           214:11
#> 954                         244  -11.6       279           130:08
#> 955                         245  -10.6       264           191:17
#> 956                         246  -10.4       261           146:54
#> 957                         247   -7.9       233           221:42
#> 958                         248   -6.6       217           288:53
#> 959                         249   -9.3       252           198:57
#> 960                         250   -8.7       245           255:37
#> 961                         251   -8.8       247           233:55
#> 962                         252   -9.3       251           316:07
#> 963                         253  -11.6       278            88:17
#> 964                         254   -8.3       238           199:42
#> 965                         255  -11.5       276           204:54
#> 966                         256  -12.1       282           168:27
#> 967                         257   -9.8       256           191:16
#> 968                         258  -10.0       257           298:34
#> 969                         259   -8.2       237           339:39
#> 970                         260  -11.1       274           261:25
#> 971                         261   -8.3       240           319:01
#> 972                         262  -10.9       271           148:53
#> 973                         263   -9.7       254           134:16
#> 974                         264   -8.8       249           222:04
#> 975                         265  -12.4       284           248:48
#> 976                         266  -10.2       259           244:37
#> 977                         267   -8.8       248           203:10
#> 978                         268  -11.5       277           224:20
#> 979                         269   -9.8       255           166:50
#> 980                         270  -11.0       272           175:14
#> 981                         271  -12.8       287           191:32
#> 982                         272  -10.9       270           332:55
#> 983                         273  -13.2       291           188:27
#> 984                         274  -13.7       297           162:55
#> 985                         275  -13.8       298           210:44
#> 986                         276  -14.0       299           293:34
#> 987                         277  -12.4       283           209:51
#> 988                         278  -12.0       281           246:24
#> 989                         279  -13.2       292           191:27
#> 990                         280  -10.6       265           159:15
#> 991                         281  -10.4       262           141:04
#> 992                         282  -10.5       263           207:48
#> 993                         283  -11.4       275           241:48
#> 994                         284  -10.4       260           204:23
#> 995                         285  -10.1       258           218:21
#> 996                         286  -12.9       288           306:22
#> 997                         287  -12.9       289           172:41
#> 998                         288  -14.6       308           139:49
#> 999                         289  -14.5       306           180:50
#> 1000                        290  -10.8       267           224:25
#> 1001                        291  -13.3       295           362:12
#> 1002                        292  -11.6       280           186:07
#> 1003                        293  -10.8       269           268:04
#> 1004                        294  -13.2       294           295:21
#> 1005                        295  -10.8       268           210:50
#> 1006                        296  -13.4       296           272:03
#> 1007                        297  -14.2       301           235:29
#> 1008                        298  -14.0       300           163:54
#> 1009                        299  -13.2       293           181:25
#> 1010                        300  -15.7       317           124:36
#> 1011                        301  -16.4       324           228:42
#> 1012                        302  -16.3       323           159:07
#> 1013                        303  -15.8       318           203:50
#> 1014                        304  -15.5       313           156:31
#> 1015                        305  -12.5       285           255:22
#> 1016                        306  -13.0       290           121:58
#> 1017                        307  -16.4       326           159:38
#> 1018                        308  -11.0       273           152:29
#> 1019                        309  -12.6       286           228:44
#> 1020                        310  -15.8       319           137:09
#> 1021                        311  -15.3       311           232:50
#> 1022                        312  -14.4       304           186:39
#> 1023                        313  -14.4       305           323:50
#> 1024                        314  -14.5       307           209:31
#> 1025                        315  -14.7       309           260:33
#> 1026                        316  -14.3       302           229:26
#> 1027                        317  -15.3       312           174:51
#> 1028                        318  -18.0       339           291:23
#> 1029                        319  -15.8       320           228:26
#> 1030                        320  -14.3       303           179:55
#> 1031                        321  -16.4       325           334:14
#> 1032                        322  -17.6       336           207:53
#> 1033                        323  -17.5       334           268:09
#> 1034                        324  -15.6       316           217:12
#> 1035                        325  -16.8       328           256:26
#> 1036                        326  -17.4       331           187:44
#> 1037                        327  -19.2       347           183:43
#> 1038                        328  -16.1       322           171:27
#> 1039                        329  -16.9       329           237:52
#> 1040                        330  -19.6       348           228:19
#> 1041                        331  -15.6       314           198:31
#> 1042                        332  -18.3       341           111:44
#> 1043                        333  -15.6       315           171:20
#> 1044                        334  -14.9       310           265:15
#> 1045                        335  -17.5       333           191:34
#> 1046                        336  -16.7       327           195:52
#> 1047                        337  -17.5       335            98:56
#> 1048                        338  -18.1       340           183:56
#> 1049                        339  -17.7       338           126:19
#> 1050                        340  -19.9       351           194:33
#> 1051                        341  -20.7       355           260:32
#> 1052                        342  -17.6       337           255:04
#> 1053                        343  -16.1       321           155:12
#> 1054                        344  -17.4       332           108:50
#> 1055                        345  -20.5       353           139:49
#> 1056                        346  -18.8       344           174:00
#> 1057                        347  -18.6       343           221:57
#> 1058                        348  -21.1       356           303:54
#> 1059                        349  -19.9       349           217:06
#> 1060                        350  -18.4       342           259:56
#> 1061                        351  -19.9       350           272:56
#> 1062                        352  -17.1       330           158:57
#> 1063                        353  -18.8       345           177:27
#> 1064                        354  -20.6       354           320:58
#> 1065                        355  -21.3       357           191:42
#> 1066                        356  -20.0       352           137:03
#> 1067                        357  -22.9       358           168:35
#> 1068                        358  -19.1       346            85:22
#> 1069                          1   41.4         1           286:22
#> 1070                          2   39.0         2           288:37
#> 1071                          3   33.6         4           182:45
#> 1072                          4   36.6         3           198:47
#> 1073                          5   29.4         7           287:10
#> 1074                          6   31.9         5           331:06
#> 1075                          7   30.4         6           151:16
#> 1076                          8   26.6        10           232:48
#> 1077                          9   28.3         8           280:37
#> 1078                         10   27.1         9           266:57
#> 1079                         11   24.8        12           275:01
#> 1080                         12   24.9        11           153:43
#> 1081                         13   22.9        16           222:24
#> 1082                         14   21.7        20           245:27
#> 1083                         15   23.2        14           237:42
#> 1084                         16   23.6        13           245:01
#> 1085                         17   22.2        18           228:33
#> 1086                         18   23.0        15           214:40
#> 1087                         19   21.2        22           279:25
#> 1088                         20   20.0        30           147:05
#> 1089                         21   22.2        19           314:27
#> 1090                         22   21.0        23           273:45
#> 1091                         23   21.4        21           184:09
#> 1092                         24   22.6        17           267:23
#> 1093                         25   18.5        38           327:41
#> 1094                         26   20.6        28           204:31
#> 1095                         27   18.9        36           119:03
#> 1096                         28   18.6        37           215:18
#> 1097                         29   20.7        27           220:27
#> 1098                         30   20.9        25           293:58
#> 1099                         31   19.8        33           330:19
#> 1100                         32   20.0        31           352:09
#> 1101                         33   20.9        24           225:20
#> 1102                         34   20.0        29           222:07
#> 1103                         35   19.1        35           340:40
#> 1104                         36   19.4        34           248:17
#> 1105                         37   19.9        32           278:12
#> 1106                         38   18.4        39           182:18
#> 1107                         39   15.8        44           248:56
#> 1108                         40   14.6        49           278:32
#> 1109                         41   16.6        41           413:43
#> 1110                         42   16.4        43           376:15
#> 1111                         43   17.4        40           353:24
#> 1112                         44   20.9        26           242:15
#> 1113                         45   14.7        48           284:42
#> 1114                         46   15.7        45           269:53
#> 1115                         47   12.9        54           272:11
#> 1116                         48   16.4        42           300:56
#> 1117                         49   14.7        47           248:41
#> 1118                         50   12.7        55           213:20
#> 1119                         51   13.3        53           259:13
#> 1120                         52   15.3        46           218:55
#> 1121                         53   14.2        50           321:32
#> 1122                         54   11.3        61           199:09
#> 1123                         55   11.5        59            75:06
#> 1124                         56   10.5        69           234:56
#> 1125                         57   10.7        66           215:38
#> 1126                         58   10.8        65           251:28
#> 1127                         59   12.3        56           127:46
#> 1128                         60   10.7        67           242:39
#> 1129                         61    9.9        73           155:19
#> 1130                         62    8.3        82           167:06
#> 1131                         63   14.2        51           259:42
#> 1132                         64   14.2        52           218:18
#> 1133                         65   11.9        58           280:09
#> 1134                         66   11.2        63           209:37
#> 1135                         67   11.4        60           194:49
#> 1136                         68    8.6        79           214:30
#> 1137                         69   10.1        70           231:25
#> 1138                         70    7.3        90           175:09
#> 1139                         71   10.0        72           230:45
#> 1140                         72   10.1        71           300:43
#> 1141                         73   12.0        57           109:28
#> 1142                         74   11.0        64           370:26
#> 1143                         75    8.6        78           182:23
#> 1144                         76    8.3        81           215:53
#> 1145                         77    8.8        76           198:40
#> 1146                         78    7.3        89           233:59
#> 1147                         79    9.8        74           259:46
#> 1148                         80   10.6        68           334:33
#> 1149                         81   11.3        62           365:39
#> 1150                         82    6.4        96           184:50
#> 1151                         83    7.8        85           291:36
#> 1152                         84    8.5        80           140:37
#> 1153                         85    7.0        91           122:21
#> 1154                         86    6.4        95           181:31
#> 1155                         87    7.5        87           313:29
#> 1156                         88    9.7        75           340:27
#> 1157                         89    7.9        83           244:06
#> 1158                         90    8.7        77           241:51
#> 1159                         91    7.8        84           257:16
#> 1160                         92    7.4        88           172:52
#> 1161                         93    7.6        86           220:49
#> 1162                         94    5.7       101           171:03
#> 1163                         95    6.0        99           205:59
#> 1164                         96    5.5       104           329:18
#> 1165                         97    5.3       106           254:05
#> 1166                         98    6.9        93           267:20
#> 1167                         99    6.9        92           408:07
#> 1168                        100    4.5       113           195:38
#> 1169                        101    5.7       100           335:23
#> 1170                        102    6.6        94           273:03
#> 1171                        103    4.3       116           293:17
#> 1172                        104    5.5       103           262:17
#> 1173                        105    3.8       121           313:15
#> 1174                        106    5.6       102           288:16
#> 1175                        107    3.0       126           146:00
#> 1176                        108    1.3       143           229:37
#> 1177                        109    6.1        98           246:04
#> 1178                        110    4.4       114           349:13
#> 1179                        111    5.2       107           305:28
#> 1180                        112    5.1       109           367:22
#> 1181                        113    5.0       110           314:44
#> 1182                        114    3.8       122           232:38
#> 1183                        115    2.9       128           428:32
#> 1184                        116    2.0       136           146:27
#> 1185                        117    3.2       125           297:54
#> 1186                        118    4.3       115           202:46
#> 1187                        119    4.0       118           230:30
#> 1188                        120    5.2       108           358:01
#> 1189                        121    3.8       120           228:13
#> 1190                        122    4.6       112           201:33
#> 1191                        123    4.1       117           312:36
#> 1192                        124    1.7       138           221:02
#> 1193                        125    2.9       129           240:40
#> 1194                        126    5.4       105           221:37
#> 1195                        127    2.2       133           176:40
#> 1196                        128    1.5       141           165:01
#> 1197                        129    4.7       111           164:01
#> 1198                        130    3.6       123           151:03
#> 1199                        131    1.1       145           380:29
#> 1200                        132    1.5       140           234:32
#> 1201                        133    2.3       131           303:08
#> 1202                        134    0.4       147           203:15
#> 1203                        135    2.6       130           172:18
#> 1204                        136    3.0       127           335:25
#> 1205                        137    6.2        97           259:24
#> 1206                        138    2.2       132           268:10
#> 1207                        139    3.4       124           245:47
#> 1208                        140    2.0       135           155:35
#> 1209                        141   -1.8       166           256:36
#> 1210                        142    0.1       151           259:12
#> 1211                        143   -0.7       157           223:49
#> 1212                        144    1.6       139           374:27
#> 1213                        145    1.2       144           236:31
#> 1214                        146    1.7       137           143:40
#> 1215                        147    0.4       148           256:44
#> 1216                        148    2.1       134           201:33
#> 1217                        149   -1.8       168           173:27
#> 1218                        150    0.4       149           388:39
#> 1219                        151    3.8       119           235:26
#> 1220                        152   -0.6       155           217:38
#> 1221                        153   -0.2       153           219:38
#> 1222                        154   -1.8       167           268:07
#> 1223                        155   -0.7       158           256:52
#> 1224                        156    0.3       150           223:20
#> 1225                        157    0.0       152           160:23
#> 1226                        158   -1.2       160           278:58
#> 1227                        159   -0.6       156           145:57
#> 1228                        160   -1.4       164           219:04
#> 1229                        161   -2.2       173           235:14
#> 1230                        162   -2.1       172           254:46
#> 1231                        163   -4.5       209           181:42
#> 1232                        164   -1.7       165           144:06
#> 1233                        165   -1.3       161           169:28
#> 1234                        166   -3.6       194           188:28
#> 1235                        167   -3.4       190           230:12
#> 1236                        168   -0.4       154           205:39
#> 1237                        169   -3.7       197           208:06
#> 1238                        170   -1.9       169           173:14
#> 1239                        171   -6.4       229           249:35
#> 1240                        172   -3.8       199           331:26
#> 1241                        173    0.7       146           207:15
#> 1242                        174   -1.4       163           295:10
#> 1243                        175    1.4       142           162:45
#> 1244                        176   -4.8       213           159:41
#> 1245                        177   -2.9       183           289:53
#> 1246                        178   -2.6       180           171:23
#> 1247                        179   -2.2       174           233:44
#> 1248                        180   -5.0       217           136:38
#> 1249                        181   -3.7       195           244:43
#> 1250                        182   -2.0       170           259:08
#> 1251                        183   -3.5       191           317:35
#> 1252                        184   -3.0       184           204:30
#> 1253                        185   -2.3       175           274:24
#> 1254                        186   -1.4       162           329:06
#> 1255                        187   -4.7       211           187:51
#> 1256                        188   -3.0       186           250:14
#> 1257                        189   -2.7       182           265:42
#> 1258                        190   -2.5       179           198:53
#> 1259                        191   -1.2       159           298:18
#> 1260                        192   -4.9       214           230:37
#> 1261                        193   -5.0       218           157:33
#> 1262                        194   -3.3       189           304:06
#> 1263                        195   -4.2       203           256:19
#> 1264                        196   -4.4       207           226:45
#> 1265                        197   -2.3       176           327:50
#> 1266                        198   -2.4       177           133:56
#> 1267                        199   -2.0       171           201:11
#> 1268                        200   -3.7       198           256:06
#> 1269                        201   -3.6       192           271:50
#> 1270                        202   -4.0       201           203:18
#> 1271                        203   -3.2       188           284:29
#> 1272                        204   -3.0       185           343:05
#> 1273                        205   -4.9       216           175:47
#> 1274                        206   -2.7       181           305:09
#> 1275                        207   -4.0       200           340:25
#> 1276                        208   -5.8       222           203:01
#> 1277                        209   -3.7       196           221:15
#> 1278                        210   -3.6       193           262:17
#> 1279                        211   -8.4       249           244:26
#> 1280                        212   -3.0       187           285:58
#> 1281                        213   -2.5       178           111:22
#> 1282                        214   -5.3       219           217:05
#> 1283                        215   -4.1       202           260:13
#> 1284                        216   -8.1       244           176:26
#> 1285                        217   -4.4       206           113:07
#> 1286                        218   -4.4       208           150:13
#> 1287                        219   -5.9       225           343:34
#> 1288                        220   -4.2       204           166:51
#> 1289                        221   -8.9       256           170:31
#> 1290                        222   -7.6       241           220:57
#> 1291                        223   -4.2       205           260:24
#> 1292                        224   -6.8       231           300:12
#> 1293                        225   -7.8       243           272:52
#> 1294                        226   -4.5       210           222:19
#> 1295                        227   -6.4       230           215:10
#> 1296                        228   -6.1       227           289:15
#> 1297                        229   -6.0       226           230:05
#> 1298                        230   -7.5       239           220:39
#> 1299                        231   -6.9       232           253:45
#> 1300                        232   -7.5       238           239:51
#> 1301                        233   -4.7       212           241:31
#> 1302                        234   -7.6       240           258:33
#> 1303                        235   -5.8       223           228:11
#> 1304                        236   -8.1       246           351:58
#> 1305                        237   -5.6       221           228:31
#> 1306                        238   -4.9       215           186:29
#> 1307                        239   -5.4       220           296:25
#> 1308                        240   -5.9       224           412:39
#> 1309                        241  -10.3       276           150:27
#> 1310                        242   -8.8       255           265:43
#> 1311                        243   -8.4       248           237:44
#> 1312                        244  -10.4       277           271:57
#> 1313                        245   -9.4       265           320:16
#> 1314                        246   -9.8       268           195:18
#> 1315                        247   -8.5       251           196:58
#> 1316                        248   -8.8       254           214:10
#> 1317                        249   -6.2       228           239:45
#> 1318                        250  -10.0       271           357:25
#> 1319                        251  -11.3       286           235:24
#> 1320                        252   -9.6       266           329:31
#> 1321                        253   -9.9       270           176:58
#> 1322                        254   -7.3       237           133:31
#> 1323                        255   -7.0       235           384:59
#> 1324                        256   -6.9       233           331:49
#> 1325                        257   -8.7       252           213:04
#> 1326                        258   -9.3       264           192:02
#> 1327                        259  -11.3       284           232:48
#> 1328                        260   -7.2       236           202:18
#> 1329                        261   -9.1       259           256:50
#> 1330                        262   -6.9       234           250:16
#> 1331                        263   -9.8       269           248:50
#> 1332                        264   -8.8       253           211:40
#> 1333                        265   -9.2       261           376:09
#> 1334                        266   -8.4       247           301:03
#> 1335                        267   -9.7       267           139:19
#> 1336                        268  -12.1       294           228:20
#> 1337                        269  -10.1       273           188:34
#> 1338                        270   -9.0       258           232:10
#> 1339                        271   -8.9       257           345:05
#> 1340                        272  -10.8       280           226:38
#> 1341                        273  -10.9       281           126:16
#> 1342                        274  -10.2       274           236:01
#> 1343                        275  -11.2       283           242:42
#> 1344                        276  -10.2       275           149:11
#> 1345                        277  -12.2       295           223:17
#> 1346                        278  -11.4       288           153:46
#> 1347                        279   -8.1       245           194:38
#> 1348                        280  -10.5       278           205:35
#> 1349                        281  -11.7       291           205:56
#> 1350                        282  -10.8       279           322:11
#> 1351                        283  -12.7       299           229:21
#> 1352                        284  -12.3       297           202:03
#> 1353                        285  -12.2       296           150:50
#> 1354                        286   -9.3       263           215:26
#> 1355                        287   -8.4       250           228:03
#> 1356                        288   -9.3       262           274:17
#> 1357                        289  -13.7       311           169:13
#> 1358                        290  -12.8       300           315:16
#> 1359                        291  -11.1       282           215:12
#> 1360                        292  -12.0       293           220:01
#> 1361                        293  -11.3       285           281:55
#> 1362                        294  -11.4       287           167:47
#> 1363                        295   -7.8       242           227:44
#> 1364                        296  -11.5       289           194:12
#> 1365                        297  -12.7       298           259:18
#> 1366                        298   -9.2       260           274:44
#> 1367                        299  -14.1       321            87:39
#> 1368                        300  -13.2       304           190:09
#> 1369                        301  -12.9       301           296:46
#> 1370                        302  -13.8       313           251:36
#> 1371                        303  -10.1       272           422:07
#> 1372                        304  -16.8       340           125:41
#> 1373                        305  -13.4       306           120:14
#> 1374                        306  -14.6       325           261:42
#> 1375                        307  -14.1       320           255:11
#> 1376                        308  -15.5       327           233:21
#> 1377                        309  -12.9       302           271:25
#> 1378                        310  -14.3       322           257:09
#> 1379                        311  -13.4       307           293:53
#> 1380                        312  -14.1       318           132:54
#> 1381                        313  -17.4       346           115:08
#> 1382                        314  -15.0       326           158:04
#> 1383                        315  -14.0       317           310:48
#> 1384                        316  -11.7       292           269:36
#> 1385                        317  -11.5       290           169:12
#> 1386                        318  -13.6       309           238:15
#> 1387                        319  -13.7       310           217:38
#> 1388                        320  -13.6       308           193:51
#> 1389                        321  -13.9       315           210:01
#> 1390                        322  -16.2       332           230:05
#> 1391                        323  -16.8       342           104:20
#> 1392                        324  -16.5       335           181:01
#> 1393                        325  -16.5       336           164:50
#> 1394                        326  -13.2       305           266:58
#> 1395                        327  -14.1       319           219:22
#> 1396                        328  -13.7       312           179:02
#> 1397                        329  -13.9       314           222:52
#> 1398                        330  -16.4       334           267:32
#> 1399                        331  -16.9       343           366:55
#> 1400                        332  -17.3       345           222:30
#> 1401                        333  -16.7       339           192:23
#> 1402                        334  -15.6       328           227:17
#> 1403                        335  -16.8       341           220:25
#> 1404                        336  -13.0       303           255:27
#> 1405                        337  -19.5       351           174:06
#> 1406                        338  -17.2       344           165:02
#> 1407                        339  -13.9       316           199:05
#> 1408                        340  -14.3       323           211:02
#> 1409                        341  -14.6       324           141:43
#> 1410                        342  -16.0       329           231:40
#> 1411                        343  -19.6       353           181:27
#> 1412                        344  -16.1       330           140:45
#> 1413                        345  -19.6       352           165:20
#> 1414                        346  -16.1       331           193:21
#> 1415                        347  -17.5       347           209:10
#> 1416                        348  -16.6       337           140:13
#> 1417                        349  -16.3       333           154:19
#> 1418                        350  -21.1       359           161:10
#> 1419                        351  -21.3       360           169:45
#> 1420                        352  -20.8       356           193:41
#> 1421                        353  -20.7       355           350:57
#> 1422                        354  -16.7       338           129:36
#> 1423                        355  -19.0       350           128:38
#> 1424                        356  -21.0       358           293:39
#> 1425                        357  -20.8       357           143:08
#> 1426                        358  -18.4       349           274:53
#> 1427                        359  -22.3       361           174:02
#> 1428                        360  -18.1       348           103:12
#> 1429                        361  -22.5       362           284:34
#> 1430                        362  -19.7       354           311:35
#> 1431                        363  -23.1       363           104:32
#> 1432                          1   38.9         1           310:49
#> 1433                          2   37.6         2           163:08
#> 1434                          3   35.7         3           448:36
#> 1435                          4   31.2         7           170:03
#> 1436                          5   32.1         5           344:57
#> 1437                          6   30.0         9           198:57
#> 1438                          7   33.1         4           230:04
#> 1439                          8   30.4         8           321:21
#> 1440                          9   31.5         6           335:46
#> 1441                         10   29.6        10           205:46
#> 1442                         11   27.8        12           286:15
#> 1443                         12   28.4        11           351:07
#> 1444                         13   26.9        13           219:15
#> 1445                         14   25.7        14           198:41
#> 1446                         15   24.5        15           299:12
#> 1447                         16   22.3        20           244:31
#> 1448                         17   23.4        16           208:32
#> 1449                         18   22.2        21           198:31
#> 1450                         19   23.2        17           277:59
#> 1451                         20   23.1        18           142:35
#> 1452                         21   19.0        28           157:31
#> 1453                         22   23.1        19           287:44
#> 1454                         23   20.1        23           233:21
#> 1455                         24   19.9        24           213:49
#> 1456                         25   19.9        25           365:40
#> 1457                         26   20.4        22           188:30
#> 1458                         27   17.3        35           178:06
#> 1459                         28   18.6        29           297:40
#> 1460                         29   17.4        33           167:28
#> 1461                         30   19.2        27           438:24
#> 1462                         31   15.9        41           181:51
#> 1463                         32   16.7        36           120:03
#> 1464                         33   16.6        37           209:45
#> 1465                         34   17.6        31           154:15
#> 1466                         35   19.3        26           292:20
#> 1467                         36   18.1        30           181:41
#> 1468                         37   13.8        46           305:16
#> 1469                         38   16.6        38           285:40
#> 1470                         39   12.7        53           153:21
#> 1471                         40   17.4        34           288:41
#> 1472                         41   17.5        32           242:13
#> 1473                         42   16.3        39           230:36
#> 1474                         43   16.2        40           268:32
#> 1475                         44   13.6        49           298:38
#> 1476                         45   13.2        50           314:16
#> 1477                         46   15.0        43           347:59
#> 1478                         47   12.2        58           210:25
#> 1479                         48   12.8        52           270:01
#> 1480                         49   12.4        56           203:35
#> 1481                         50    7.8        87            66:56
#> 1482                         51   15.6        42           203:22
#> 1483                         52   12.1        59           293:33
#> 1484                         53   15.0        44           170:37
#> 1485                         54   11.7        63            91:32
#> 1486                         55   14.1        45           242:06
#> 1487                         56    9.6        75           139:34
#> 1488                         57   13.1        51           308:12
#> 1489                         58   11.5        64           257:08
#> 1490                         59   12.3        57           241:47
#> 1491                         60   10.7        71           119:14
#> 1492                         61   13.7        48           193:24
#> 1493                         62   13.7        47           252:00
#> 1494                         63   12.0        61           286:51
#> 1495                         64   11.2        68           225:06
#> 1496                         65    9.8        74           287:23
#> 1497                         66   12.1        60           321:27
#> 1498                         67   12.7        54           186:44
#> 1499                         68   11.2        69           122:55
#> 1500                         69    9.9        73           202:51
#> 1501                         70   11.7        62           109:02
#> 1502                         71   11.4        67           323:45
#> 1503                         72    7.3        93           192:06
#> 1504                         73    9.0        76           273:56
#> 1505                         74    6.5       100           237:44
#> 1506                         75    7.9        84           261:50
#> 1507                         76   12.6        55           297:22
#> 1508                         77    7.6        90           273:19
#> 1509                         78   10.7        70           326:41
#> 1510                         79    7.7        89           248:52
#> 1511                         80    7.9        85           326:40
#> 1512                         81   10.0        72           269:32
#> 1513                         82    7.5        91           263:54
#> 1514                         83   11.5        65           276:42
#> 1515                         84    7.4        92           169:26
#> 1516                         85    8.3        81           216:40
#> 1517                         86    7.7        88           183:18
#> 1518                         87    6.5       101           237:08
#> 1519                         88   11.4        66           195:34
#> 1520                         89    7.2        95           101:11
#> 1521                         90    7.8        86           233:03
#> 1522                         91    8.3        80           200:07
#> 1523                         92    9.0        77           207:12
#> 1524                         93    8.1        82           260:45
#> 1525                         94    6.5       102           296:36
#> 1526                         95    7.1        96           260:14
#> 1527                         96    6.7        99           261:50
#> 1528                         97    8.6        79           280:15
#> 1529                         98    6.1       107           237:39
#> 1530                         99    6.7        98           282:42
#> 1531                        100    6.1       108           178:58
#> 1532                        101    8.0        83           255:14
#> 1533                        102    5.1       111           146:23
#> 1534                        103    6.4       103           340:24
#> 1535                        104    4.2       120           181:31
#> 1536                        105    7.0        97           128:38
#> 1537                        106    6.2       106           218:17
#> 1538                        107    8.7        78           285:12
#> 1539                        108    6.2       105           273:31
#> 1540                        109    6.3       104           249:46
#> 1541                        110    6.1       109           213:56
#> 1542                        111    1.3       144           179:48
#> 1543                        112    3.5       123           197:35
#> 1544                        113    4.6       118           194:57
#> 1545                        114    1.6       143           154:59
#> 1546                        115    5.0       114           293:01
#> 1547                        116    4.7       117           270:59
#> 1548                        117    5.7       110           166:12
#> 1549                        118    3.8       121           159:27
#> 1550                        119    5.0       113           217:35
#> 1551                        120    7.2        94           209:45
#> 1552                        121    2.1       136           244:13
#> 1553                        122    4.8       115           179:55
#> 1554                        123    3.7       122           200:16
#> 1555                        124    3.4       124           227:11
#> 1556                        125    4.3       119           233:22
#> 1557                        126    4.7       116           244:02
#> 1558                        127    2.9       131           222:01
#> 1559                        128    5.1       112           236:27
#> 1560                        129    2.3       134           176:27
#> 1561                        130    2.1       137           250:23
#> 1562                        131    3.2       129           281:51
#> 1563                        132    2.4       132           154:49
#> 1564                        133    1.1       146           314:28
#> 1565                        134    2.3       133           277:36
#> 1566                        135    1.8       141           310:43
#> 1567                        136    3.3       126           300:23
#> 1568                        137    1.2       145           297:26
#> 1569                        138    1.7       142           188:44
#> 1570                        139    0.2       157           152:27
#> 1571                        140    3.4       125           300:13
#> 1572                        141    3.0       130           337:42
#> 1573                        142    2.2       135           391:47
#> 1574                        143    2.0       140           247:05
#> 1575                        144    3.2       128           260:32
#> 1576                        145    1.0       147           315:18
#> 1577                        146    3.3       127           300:42
#> 1578                        147    0.2       155           256:14
#> 1579                        148    2.0       139           172:55
#> 1580                        149    1.0       148           225:51
#> 1581                        150   -1.4       172           183:44
#> 1582                        151    0.1       158           182:23
#> 1583                        152   -0.9       166           212:16
#> 1584                        153    0.1       159           194:15
#> 1585                        154    0.9       150           240:03
#> 1586                        155   -1.2       171           148:44
#> 1587                        156    0.0       160           186:17
#> 1588                        157    0.7       152           132:04
#> 1589                        158   -1.1       169           317:45
#> 1590                        159   -0.7       164           298:34
#> 1591                        160    0.6       153           226:49
#> 1592                        161   -4.4       201           207:22
#> 1593                        162   -4.5       204           178:42
#> 1594                        163   -1.7       176           251:51
#> 1595                        164    2.0       138           261:57
#> 1596                        165   -2.3       186           319:09
#> 1597                        166   -0.3       162           203:34
#> 1598                        167   -0.2       161           410:29
#> 1599                        168   -1.2       170           232:35
#> 1600                        169    0.8       151           211:09
#> 1601                        170   -0.8       165           223:37
#> 1602                        171    0.9       149           113:59
#> 1603                        172   -1.0       168           186:30
#> 1604                        173   -1.4       174           240:58
#> 1605                        174   -2.1       182           233:20
#> 1606                        175    0.5       154           258:58
#> 1607                        176   -1.9       178           247:31
#> 1608                        177   -0.5       163           386:28
#> 1609                        178    0.2       156           274:20
#> 1610                        179   -2.8       189           170:35
#> 1611                        180   -3.8       196           206:45
#> 1612                        181   -1.0       167           238:25
#> 1613                        182   -3.2       191           217:29
#> 1614                        183   -2.2       184           226:30
#> 1615                        184   -1.6       175           226:56
#> 1616                        185   -2.0       180           278:11
#> 1617                        186   -4.3       199           249:36
#> 1618                        187   -2.1       183           229:35
#> 1619                        188   -3.2       190           171:51
#> 1620                        189   -1.9       179           370:03
#> 1621                        190   -2.2       185           210:54
#> 1622                        191   -5.6       217           220:30
#> 1623                        192   -2.4       187           361:45
#> 1624                        193   -3.3       192           208:05
#> 1625                        194   -5.2       209           190:04
#> 1626                        195   -1.4       173           357:27
#> 1627                        196   -1.8       177           200:49
#> 1628                        197   -2.4       188           237:25
#> 1629                        198   -6.9       235            95:27
#> 1630                        199   -5.7       219           186:53
#> 1631                        200   -3.7       195           195:24
#> 1632                        201   -2.1       181           378:16
#> 1633                        202   -4.3       200           234:54
#> 1634                        203   -5.2       210           323:50
#> 1635                        204   -3.6       194           180:11
#> 1636                        205   -8.1       249           146:16
#> 1637                        206   -5.3       213           189:18
#> 1638                        207   -5.0       207           174:57
#> 1639                        208   -6.3       228           117:15
#> 1640                        209   -4.7       205           190:32
#> 1641                        210   -6.1       224           306:25
#> 1642                        211   -7.3       239           263:01
#> 1643                        212   -6.8       233           241:16
#> 1644                        213   -5.7       218           343:08
#> 1645                        214   -4.8       206           240:12
#> 1646                        215   -4.2       198           185:31
#> 1647                        216   -4.1       197           276:46
#> 1648                        217   -6.6       229           251:37
#> 1649                        218   -7.1       237           168:40
#> 1650                        219   -4.5       203           242:47
#> 1651                        220   -7.7       245            93:47
#> 1652                        221   -7.4       240           279:52
#> 1653                        222   -9.1       265           116:46
#> 1654                        223   -5.9       222           218:17
#> 1655                        224   -5.5       216           222:15
#> 1656                        225   -6.2       226           248:51
#> 1657                        226   -7.3       238           168:58
#> 1658                        227   -5.3       212           344:11
#> 1659                        228   -5.9       220           290:47
#> 1660                        229   -5.5       214           348:36
#> 1661                        230  -10.3       275           189:22
#> 1662                        231   -6.3       227           312:46
#> 1663                        232   -3.5       193           268:02
#> 1664                        233   -5.1       208           167:22
#> 1665                        234   -9.0       263           324:11
#> 1666                        235   -4.5       202           157:05
#> 1667                        236   -8.1       251           122:32
#> 1668                        237   -5.5       215           350:31
#> 1669                        238   -6.7       232           229:03
#> 1670                        239   -8.2       252           174:03
#> 1671                        240   -6.2       225           356:36
#> 1672                        241   -7.5       241           355:43
#> 1673                        242   -5.2       211           237:37
#> 1674                        243   -7.6       242           231:22
#> 1675                        244   -7.0       236           223:45
#> 1676                        245   -7.6       244           196:56
#> 1677                        246   -8.9       259           142:01
#> 1678                        247   -5.9       221           307:37
#> 1679                        248   -6.9       234           345:29
#> 1680                        249   -6.6       230           335:23
#> 1681                        250   -8.1       250           193:32
#> 1682                        251   -6.6       231           224:01
#> 1683                        252   -8.7       255           296:22
#> 1684                        253   -9.1       264           271:09
#> 1685                        254   -9.0       261           239:42
#> 1686                        255   -9.6       269           252:54
#> 1687                        256   -8.7       256           177:45
#> 1688                        257   -8.8       258           143:09
#> 1689                        258   -6.1       223           295:26
#> 1690                        259  -10.0       274           231:02
#> 1691                        260   -9.9       272           267:48
#> 1692                        261   -8.6       254           179:38
#> 1693                        262   -8.0       248           195:10
#> 1694                        263  -13.1       308           166:36
#> 1695                        264   -9.9       271           289:43
#> 1696                        265   -9.0       262           263:03
#> 1697                        266   -7.6       243           105:51
#> 1698                        267   -9.3       268           228:00
#> 1699                        268  -11.2       284           187:44
#> 1700                        269   -9.9       273           198:51
#> 1701                        270  -11.9       296           222:10
#> 1702                        271   -8.6       253           264:35
#> 1703                        272   -9.3       267           148:43
#> 1704                        273  -11.6       292           255:56
#> 1705                        274  -11.3       287           272:17
#> 1706                        275  -10.9       280           167:16
#> 1707                        276  -11.6       290           219:40
#> 1708                        277   -7.8       246           165:34
#> 1709                        278   -9.1       266           200:55
#> 1710                        279  -11.8       294           241:59
#> 1711                        280  -12.9       302           204:13
#> 1712                        281  -12.9       301           258:26
#> 1713                        282  -13.1       306           184:27
#> 1714                        283   -9.7       270           277:33
#> 1715                        284   -8.8       257           237:24
#> 1716                        285  -11.6       291           268:17
#> 1717                        286  -13.3       309           255:15
#> 1718                        287  -11.2       286           237:29
#> 1719                        288  -11.4       288           195:27
#> 1720                        289   -7.9       247           344:00
#> 1721                        290  -10.7       277           274:42
#> 1722                        291  -11.9       295           345:23
#> 1723                        292  -13.8       314           319:40
#> 1724                        293  -10.8       279           278:45
#> 1725                        294  -10.8       278           211:31
#> 1726                        295  -13.1       307           197:28
#> 1727                        296  -11.1       282           205:14
#> 1728                        297  -12.0       297           171:51
#> 1729                        298   -9.0       260           194:15
#> 1730                        299  -10.5       276           314:45
#> 1731                        300  -13.0       303           295:14
#> 1732                        301  -13.7       313           272:07
#> 1733                        302  -13.9       315           211:18
#> 1734                        303  -11.2       285           321:10
#> 1735                        304  -11.0       281           311:13
#> 1736                        305  -13.6       311           253:49
#> 1737                        306  -14.6       318           267:23
#> 1738                        307  -11.1       283           273:26
#> 1739                        308  -15.2       329           189:38
#> 1740                        309  -14.7       321           112:27
#> 1741                        310  -13.0       305           319:02
#> 1742                        311  -15.9       335           213:01
#> 1743                        312  -13.7       312           253:05
#> 1744                        313  -12.5       299           363:35
#> 1745                        314  -12.4       298           279:40
#> 1746                        315  -11.5       289           260:16
#> 1747                        316  -14.4       317           281:10
#> 1748                        317  -13.0       304           201:22
#> 1749                        318  -15.7       332           218:36
#> 1750                        319  -16.3       337           278:24
#> 1751                        320  -15.8       334           187:20
#> 1752                        321  -11.8       293           189:45
#> 1753                        322  -14.0       316           208:02
#> 1754                        323  -13.3       310           204:35
#> 1755                        324  -15.1       327           312:48
#> 1756                        325  -14.8       322           202:10
#> 1757                        326  -15.0       323           367:11
#> 1758                        327  -12.6       300           157:54
#> 1759                        328  -17.2       345           227:49
#> 1760                        329  -15.3       330           211:39
#> 1761                        330  -17.0       343           143:04
#> 1762                        331  -18.1       350           196:12
#> 1763                        332  -16.8       341           213:49
#> 1764                        333  -16.7       340           252:58
#> 1765                        334  -17.6       346           155:42
#> 1766                        335  -14.7       320           136:44
#> 1767                        336  -15.1       326           240:49
#> 1768                        337  -14.6       319           112:40
#> 1769                        338  -15.6       331           179:28
#> 1770                        339  -15.7       333           213:18
#> 1771                        340  -15.0       324           153:25
#> 1772                        341  -17.0       344           135:21
#> 1773                        342  -17.9       349           217:15
#> 1774                        343  -16.4       338           322:27
#> 1775                        344  -15.0       325           212:11
#> 1776                        345  -15.1       328           163:37
#> 1777                        346  -16.5       339           266:47
#> 1778                        347  -16.9       342           243:25
#> 1779                        348  -17.8       348           201:49
#> 1780                        349  -20.6       355           166:27
#> 1781                        350  -18.8       351           265:49
#> 1782                        351  -15.9       336           121:14
#> 1783                        352  -21.1       357           176:42
#> 1784                        353  -17.6       347           154:55
#> 1785                        354  -19.0       352           156:08
#> 1786                        355  -19.6       353           221:28
#> 1787                        356  -26.3       362           120:08
#> 1788                        357  -21.4       358           233:10
#> 1789                        358  -20.1       354           188:07
#> 1790                        359  -21.0       356           183:59
#> 1791                        360  -21.8       360           151:18
#> 1792                        361  -21.6       359           270:49
#> 1793                        362  -24.8       361           228:23
#>      TwoFoulTotalTime.Rk TwoFoulTimeOn TwoFoulTimeOn.Rk Bench.Pct Bench.Pct.Rk
#> 1                     36        229:52                1      26.5          267
#> 2                    294        105:56               40      27.2          254
#> 3                    123        154:20                9      17.8          350
#> 4                     10        223:04                2      26.2          272
#> 5                    112        154:13               10      30.1          174
#> 6                     30        184:45                4      18.0          349
#> 7                    113        147:33               13      28.2          229
#> 8                    203        119:04               27      30.9          155
#> 9                    310         83:47               65      17.2          352
#> 10                   137        136:13               16      26.8          262
#> 11                   308         82:29               69      22.1          327
#> 12                   305         83:36               67      20.4          340
#> 13                    32        169:05                7      28.4          222
#> 14                    80        147:40               12      27.6          249
#> 15                   129        130:20               18      26.4          268
#> 16                   134        127:23               21      30.4          167
#> 17                    50        153:27               11      26.4          269
#> 18                    14        180:02                5      18.2          348
#> 19                   109        132:34               17      21.9          330
#> 20                    65        145:49               14      29.4          197
#> 21                    24        165:55                8      31.0          151
#> 22                   307         73:34               95      28.6          216
#> 23                    94        128:25               19      32.9          110
#> 24                   122        120:25               24      41.6           10
#> 25                     1        207:43                3      26.8          263
#> 26                   221         94:38               50      32.8          114
#> 27                   339         53:59              155      29.7          187
#> 28                   161        106:04               39      35.2           77
#> 29                   131        114:46               33      21.1          336
#> 30                    97        120:21               25      31.6          139
#> 31                   289         74:57               90      33.1          106
#> 32                   102        118:20               28      28.9          210
#> 33                   332         59:30              134      18.8          347
#> 34                   325         60:53              131      23.8          308
#> 35                   232         88:00               58      22.9          316
#> 36                   281         76:21               87      28.7          215
#> 37                   158        100:53               45      29.0          206
#> 38                   114        111:59               37      28.7          212
#> 39                   205         91:27               54      38.3           28
#> 40                   255         79:44               78      29.9          182
#> 41                    75        116:01               30      27.3          253
#> 42                     3        171:21                6      25.5          287
#> 43                   197         87:20               60      27.6          248
#> 44                    77        113:00               36      22.3          326
#> 45                    47        121:20               23      27.7          246
#> 46                   247         76:22               86      31.8          136
#> 47                   100        103:57               42      23.9          306
#> 48                   117         99:55               46      29.6          191
#> 49                   204         82:18               70      23.9          304
#> 50                    12        136:37               15      24.2          299
#> 51                    37        118:13               29      23.8          307
#> 52                   217         76:52               85      34.4           88
#> 53                    21        128:10               20      20.8          339
#> 54                    25        125:12               22      33.8           95
#> 55                    45        114:14               35      35.6           73
#> 56                    35        115:05               32      30.8          156
#> 57                   202         77:01               84      22.1          328
#> 58                    26        120:03               26      32.5          121
#> 59                   244         69:59              107      23.6          312
#> 60                   110         93:47               51      31.0          154
#> 61                    70        101:07               44      42.8            4
#> 62                   105         92:14               53      37.0           44
#> 63                   124         88:27               57      17.7          351
#> 64                   165         79:48               76      33.6           99
#> 65                   212         71:41              103      37.5           34
#> 66                   299         54:50              148      37.9           31
#> 67                   219         69:44              108      25.1          291
#> 68                   183         74:52               91      23.9          305
#> 69                    96         89:31               56      25.4          289
#> 70                   246         64:24              124      28.0          236
#> 71                    51         99:34               47      31.5          140
#> 72                   176         74:01               94      22.6          321
#> 73                    31        105:24               41      38.7           23
#> 74                   283         56:19              145      29.6          188
#> 75                   147         77:11               83      32.6          118
#> 76                    48         96:38               49      36.1           63
#> 77                    59         93:34               52      40.3           13
#> 78                   324         43:48              191      21.8          333
#> 79                   120         81:24               73      23.8          309
#> 80                   194         68:01              112      30.1          177
#> 81                   315         45:34              183      32.8          115
#> 82                    15        109:46               38      35.1           79
#> 83                   154         72:47               99      37.5           33
#> 84                   273         55:08              146      24.0          302
#> 85                   193         67:39              114      31.3          143
#> 86                     9        115:57               31      21.1          338
#> 87                   215         63:34              127      28.4          223
#> 88                   196         66:47              117      39.1           19
#> 89                   250         59:23              136      21.9          331
#> 90                   198         66:33              120      27.6          247
#> 91                   188         67:31              115      22.7          318
#> 92                   238         60:20              132      30.2          171
#> 93                   152         72:36              101      29.3          200
#> 94                   334         39:25              207      25.6          283
#> 95                   348         30:46              243      30.1          173
#> 96                   143         73:33               96      29.4          199
#> 97                   207         63:08              129      27.1          255
#> 98                    66         86:46               61      26.1          273
#> 99                     5        114:29               34      28.8          211
#> 100                   44         91:11               55      32.8          113
#> 101                  166         67:49              113      22.8          317
#> 102                  104         77:31               82      31.2          148
#> 103                  292         48:21              172      36.1           61
#> 104                  135         72:49               98      27.7          245
#> 105                  276         51:13              166      28.1          234
#> 106                  222         59:12              138      28.1          233
#> 107                  189         63:44              125      36.8           51
#> 108                   61         85:12               63      29.8          184
#> 109                  159         66:34              119      25.2          290
#> 110                  142         70:19              106      26.1          274
#> 111                  269         51:31              163      24.1          301
#> 112                   41         87:51               59      24.3          298
#> 113                   55         84:03               64      34.6           82
#> 114                  248         54:10              153      34.9           80
#> 115                  337         33:51              223      19.4          343
#> 116                  156         64:58              123      31.1          150
#> 117                  237         54:26              149      36.2           58
#> 118                  116         71:12              104      24.0          303
#> 119                   90         75:05               89      24.9          294
#> 120                   71         78:42               80      25.7          280
#> 121                   89         74:11               93      23.8          310
#> 122                  338         32:22              232      30.2          169
#> 123                  274         47:40              176      20.2          341
#> 124                  163         61:45              130      33.9           94
#> 125                  180         59:32              133      28.6          218
#> 126                   53         79:47               77      35.1           78
#> 127                  186         58:51              139      30.7          161
#> 128                  224         54:15              152      27.4          252
#> 129                  352         23:36              278      32.4          123
#> 130                   43         82:01               71      36.9           45
#> 131                  270         47:49              175      36.6           53
#> 132                   88         72:44              100      31.3          144
#> 133                  111         69:24              109      30.7          160
#> 134                   91         71:49              102      21.1          337
#> 135                   54         78:01               81      22.6          319
#> 136                    4        101:12               43      39.0           20
#> 137                  210         54:24              151      21.1          335
#> 138                    8         99:02               48      39.2           18
#> 139                   28         85:51               62      21.9          329
#> 140                  300         40:54              202      42.8            6
#> 141                  304         39:05              209      30.8          158
#> 142                  257         46:38              180      30.1          178
#> 143                   87         68:25              111      34.5           84
#> 144                   68         71:10              105      23.7          311
#> 145                   40         76:06               88      31.7          138
#> 146                   98         65:05              122      21.4          334
#> 147                  173         54:57              147      37.7           32
#> 148                   20         83:10               68      26.6          265
#> 149                   18         83:36               66      36.1           62
#> 150                  235         47:38              177      18.9          345
#> 151                  190         52:59              160      28.2          228
#> 152                  240         46:56              179      29.8          183
#> 153                  184         52:29              162      26.1          275
#> 154                  233         47:01              178      36.0           65
#> 155                  199         50:53              167      29.7          186
#> 156                   63         68:56              110      34.7           81
#> 157                  311         35:07              221      28.3          225
#> 158                  241         45:35              182      41.8            9
#> 159                  141         56:53              144      37.2           41
#> 160                  211         48:04              173      33.0          107
#> 161                  126         58:37              140      30.5          163
#> 162                   17         80:15               75      29.6          190
#> 163                  149         54:24              150      35.6           75
#> 164                   81         63:42              126      30.7          159
#> 165                   13         81:03               74      30.1          172
#> 166                   11         81:59               72      33.1          105
#> 167                  130         56:54              143      29.3          201
#> 168                  261         41:27              199      28.5          221
#> 169                  303         35:09              220      23.6          313
#> 170                  225         45:14              185      32.8          116
#> 171                  335         28:32              253      27.5          251
#> 172                   49         66:56              116      38.9           21
#> 173                   27         73:18               97      36.4           57
#> 174                   52         65:29              121      34.6           83
#> 175                  318         31:22              238      19.2          344
#> 176                  146         52:32              161      36.7           52
#> 177                   62         63:15              128      38.5           25
#> 178                  287         36:23              215      34.0           92
#> 179                  128         53:33              157      27.9          241
#> 180                  227         42:26              196      31.0          153
#> 181                  268         38:05              213      29.6          189
#> 182                   79         59:23              135      27.0          258
#> 183                  351         19:57              297      33.5          100
#> 184                  333         27:46              259      32.5          120
#> 185                   76         59:16              137      29.0          207
#> 186                  263         38:19              212      26.1          276
#> 187                  220         42:41              195      28.5          219
#> 188                    7         79:18               79      25.7          279
#> 189                  309         31:10              239      31.4          142
#> 190                  293         33:36              225      28.9          209
#> 191                  321         28:45              250      29.5          194
#> 192                  136         49:43              171      25.4          288
#> 193                   64         57:32              142      33.3          102
#> 194                  121         50:24              168      38.3           27
#> 195                  106         51:21              164      30.1          175
#> 196                  157         44:53              187      33.1          104
#> 197                   82         53:42              156      22.4          324
#> 198                  162         44:19              189      22.6          320
#> 199                  214         39:33              204      25.9          278
#> 200                   16         66:40              118      30.6          162
#> 201                  101         49:54              170      34.4           89
#> 202                  191         40:56              200      32.2          127
#> 203                  150         44:15              190      33.6           98
#> 204                   72         53:10              159      42.7            7
#> 205                  265         33:39              224      34.5           85
#> 206                  140         45:26              184      40.6           12
#> 207                   93         50:12              169      27.9          239
#> 208                  259         33:28              227      32.4          124
#> 209                  242         35:17              219      47.0            2
#> 210                  302         28:13              256      28.3          226
#> 211                  336         22:38              283      30.4          166
#> 212                  340         20:41              294      33.6           97
#> 213                  192         38:19              211      28.1          232
#> 214                  175         39:39              203      29.6          192
#> 215                  267         31:38              236      25.0          293
#> 216                   46         53:30              158      25.7          281
#> 217                    2         74:27               92      32.6          119
#> 218                  103         46:03              181      32.9          112
#> 219                   38         54:09              154      25.1          292
#> 220                  167         39:32              205      27.1          257
#> 221                  170         39:27              206      26.4          270
#> 222                  251         32:35              231      35.7           72
#> 223                  264         30:46              242      27.9          240
#> 224                  213         34:58              222      25.5          286
#> 225                  209         35:26              218      14.2          353
#> 226                  285         28:36              252      36.6           54
#> 227                  151         39:05              208      32.2          128
#> 228                  223         33:35              226      22.4          325
#> 229                  272         28:36              251      27.1          256
#> 230                   99         42:41              194      23.1          315
#> 231                  322         22:04              286      32.6          117
#> 232                  172         36:02              216      35.7           71
#> 233                  301         25:13              273      29.5          195
#> 234                  344         16:41              312      34.5           86
#> 235                  239         31:02              240      35.9           66
#> 236                  327         21:29              290      29.0          205
#> 237                  108         40:54              201      27.0          259
#> 238                  200         33:11              229      28.1          235
#> 239                  314         22:45              282      27.7          244
#> 240                   78         43:10              193      32.5          122
#> 241                  275         27:04              262      38.8           22
#> 242                   85         42:10              198      35.6           74
#> 243                  282         26:07              265      26.3          271
#> 244                    6         58:01              141      31.5          141
#> 245                  306         23:19              280      31.2          149
#> 246                  229         29:41              245      29.2          203
#> 247                   19         51:15              165      36.2           59
#> 248                   58         43:43              192      26.7          264
#> 249                  277         25:57              267      30.1          176
#> 250                  266         26:25              263      26.5          266
#> 251                  353         11:27              327      22.5          323
#> 252                   56         42:20              197      37.3           38
#> 253                   23         47:54              174      30.1          179
#> 254                  230         28:21              254      37.1           43
#> 255                  218         28:56              249      39.6           16
#> 256                  231         28:11              257      31.2          146
#> 257                   86         38:46              210      35.8           68
#> 258                  206         29:31              247      37.3           39
#> 259                   33         44:23              188      30.8          157
#> 260                  144         33:20              228      32.3          126
#> 261                  258         25:13              272      27.8          242
#> 262                  254         25:30              269      29.5          193
#> 263                   84         37:30              214      36.9           46
#> 264                  286         23:03              281      28.3          227
#> 265                  252         25:26              270      27.9          237
#> 266                  182         29:33              246      32.1          129
#> 267                  164         30:37              244      40.8           11
#> 268                   22         45:00              186      31.0          152
#> 269                  290         22:02              287      18.8          346
#> 270                  295         21:24              291      25.9          277
#> 271                  138         32:03              234      30.5          164
#> 272                  201         27:43              260      28.3          224
#> 273                   83         35:52              217      25.5          285
#> 274                  319         18:11              306      19.9          342
#> 275                  262         23:26              279      29.4          196
#> 276                  177         28:21              255      34.0           91
#> 277                  132         31:37              237      32.3          125
#> 278                  107         32:44              230      42.6            8
#> 279                  331         16:41              311      27.0          260
#> 280                  326         16:58              308      32.9          111
#> 281                  181         27:24              261      34.4           87
#> 282                  341         14:01              321      21.8          332
#> 283                  148         29:14              248      25.6          282
#> 284                  345         12:38              324      36.5           56
#> 285                  284         20:54              292      39.6           14
#> 286                  347         12:24              325      35.8           69
#> 287                   92         31:58              235      24.7          296
#> 288                  185         25:45              268      37.1           42
#> 289                  297         18:38              305      36.5           55
#> 290                  171         26:14              264      28.5          220
#> 291                  187         25:23              271      33.3          101
#> 292                  139         28:04              258      42.8            5
#> 293                  234         22:25              284      30.2          170
#> 294                  312         16:53              309      31.9          135
#> 295                   67         32:09              233      33.6           96
#> 296                  195         23:36              277      29.2          202
#> 297                  256         19:51              298      38.2           29
#> 298                  296         16:52              310      33.2          103
#> 299                  249         20:00              296      32.0          131
#> 300                  317         14:23              319      29.0          204
#> 301                   34         30:50              241      38.1           30
#> 302                   95         26:03              266      37.4           37
#> 303                  133         23:51              276      28.6          217
#> 304                  226         19:12              304      27.8          243
#> 305                  174         20:43              293      30.5          165
#> 306                  280         15:41              316      36.0           64
#> 307                  145         21:33              289      31.9          134
#> 308                  291         14:33              317      43.2            3
#> 309                  160         20:18              295      28.9          208
#> 310                  179         19:35              301      36.8           49
#> 311                  350          8:33              344      39.6           15
#> 312                  342          9:37              335      30.0          180
#> 313                   73         24:04              274      33.9           93
#> 314                  153         19:45              299      37.5           35
#> 315                  118         21:35              288      31.2          145
#> 316                   69         23:53              275      35.8           67
#> 317                  155         19:12              303      27.6          250
#> 318                  320         11:22              328      23.5          314
#> 319                  271         14:15              320      31.2          147
#> 320                   60         22:23              285      33.0          109
#> 321                  253         14:00              322      24.7          295
#> 322                  316          9:46              334      34.1           90
#> 323                  298         10:38              331      31.7          137
#> 324                  127         16:37              314      49.1            1
#> 325                  115         16:40              313      36.8           50
#> 326                  329          8:40              341      28.2          230
#> 327                  330          8:36              343      22.5          322
#> 328                  208         13:20              323      28.2          231
#> 329                  168         14:23              318      26.9          261
#> 330                  125         15:44              315      39.5           17
#> 331                   39         19:16              302      36.9           47
#> 332                   29         19:42              300      37.3           40
#> 333                  349          5:59              349      25.6          284
#> 334                  278         10:31              332      33.0          108
#> 335                  243         11:33              326      36.9           48
#> 336                   42         17:24              307      24.2          300
#> 337                  228         11:12              330      32.1          130
#> 338                  343          5:37              350      29.4          198
#> 339                  288          8:44              340      30.0          181
#> 340                  279          9:01              338      35.7           70
#> 341                  236          9:08              337      38.5           24
#> 342                  328          6:12              347      29.7          185
#> 343                  169         10:16              333      35.6           76
#> 344                  323          6:11              348      28.7          214
#> 345                  313          6:20              345      27.9          238
#> 346                  216          8:38              342      30.2          168
#> 347                   57         11:20              329      37.5           36
#> 348                  119          8:49              339      28.7          213
#> 349                   74          9:25              336      31.9          133
#> 350                  178          6:13              346      38.4           26
#> 351                  346          2:45              353      36.2           60
#> 352                  245          4:17              351      32.0          132
#> 353                  260          3:15              352      24.5          297
#> 354                  347          5:13              328      34.7           85
#> 355                    1          0:00                1       0.0          348
#> 356                    1          0:00                1       0.0          348
#> 357                    1          0:00                1       0.0          348
#> 358                    1          0:00                1       0.0          348
#> 359                    1          0:00                1       0.0          348
#> 360                    1          0:00                1       0.0          348
#> 361                    1          0:00                1       0.0          348
#> 362                    1          0:00                1       0.0          348
#> 363                    1          0:00                1       0.0          348
#> 364                    1          0:00                1       0.0          348
#> 365                  346         12:20              302      34.7           86
#> 366                  174        123:08                9      20.1          336
#> 367                   92        145:51                3      28.5          235
#> 368                  240         95:00               21      18.9          340
#> 369                   57        143:19                4      28.0          255
#> 370                  319         60:11               93      27.8          261
#> 371                  303         67:12               77      35.5           74
#> 372                  136        116:18               12      26.5          275
#> 373                  223         90:30               27      19.1          339
#> 374                  227         85:50               36      27.2          269
#> 375                  258         75:00               53      28.1          250
#> 376                  183         95:41               19      20.4          333
#> 377                   89        117:26               10      22.3          321
#> 378                   53        128:57                7      23.2          318
#> 379                  154         98:28               17      47.5            1
#> 380                    9        156:13                1      36.3           58
#> 381                  271         67:47               75      30.1          196
#> 382                    8        153:17                2      17.6          345
#> 383                  252         69:35               70      27.2          268
#> 384                  105        102:42               16      24.6          308
#> 385                   36        123:32                8      26.5          274
#> 386                  232         72:38               62      20.0          338
#> 387                  313         50:31              117      39.9           20
#> 388                  233         71:55               66      21.8          325
#> 389                  201         79:43               45      20.9          331
#> 390                  161         87:29               33      35.8           65
#> 391                  142         91:20               24      32.6          134
#> 392                  297         55:50              104      36.6           52
#> 393                  103         96:02               18      36.6           53
#> 394                  182         79:11               47      26.4          276
#> 395                  132         88:43               30      27.2          270
#> 396                  125         89:47               28      25.8          289
#> 397                  260         60:40               90      28.2          247
#> 398                  228         66:59               78      32.1          143
#> 399                  246         63:24               84      25.9          288
#> 400                  194         74:06               55      34.4           97
#> 401                  147         81:03               41      21.0          330
#> 402                  126         85:58               35      29.9          199
#> 403                  190         73:57               58      45.1            3
#> 404                   97         90:56               25      23.8          315
#> 405                    6        130:51                6      31.7          159
#> 406                   70         94:25               22      28.1          253
#> 407                  188         72:25               64      20.2          334
#> 408                  163         77:25               49      18.6          342
#> 409                  239         61:43               88      36.5           54
#> 410                  206         68:32               74      29.9          202
#> 411                   98         86:44               34      32.6          133
#> 412                   60         93:22               23      30.1          195
#> 413                  160         74:01               57      39.5           23
#> 414                  122         79:55               44      24.0          314
#> 415                   78         87:58               32      32.9          125
#> 416                   46         95:02               20      33.0          123
#> 417                    2        142:31                5      33.2          122
#> 418                  177         69:03               71      25.7          291
#> 419                   24        106:27               13      35.6           72
#> 420                    7        117:04               11      30.9          170
#> 421                  155         70:21               68      22.6          319
#> 422                  280         48:18              128      30.5          185
#> 423                  215         60:58               89      25.4          298
#> 424                  222         58:13               96      28.0          254
#> 425                  242         54:31              108      29.0          224
#> 426                  123         74:08               54      31.6          161
#> 427                   96         78:37               48      36.5           56
#> 428                   22        103:00               15      27.6          263
#> 429                  146         69:35               69      21.2          326
#> 430                   79         80:59               42      32.8          127
#> 431                  106         75:33               52       9.8          347
#> 432                  292         44:38              139      32.1          146
#> 433                  345         22:58              237      29.2          217
#> 434                   75         80:05               43      25.9          287
#> 435                  339         26:08              222      32.0          150
#> 436                   34         90:48               26      22.0          323
#> 437                  311         37:37              163      25.9          285
#> 438                  135         69:00               72      36.0           61
#> 439                  152         65:37               80      28.4          240
#> 440                  202         58:35               95      21.1          328
#> 441                  209         57:58               98      28.2          248
#> 442                  270         45:49              135      33.3          119
#> 443                  251         49:13              123      18.6          343
#> 444                  335         27:18              219      37.4           43
#> 445                  212         56:10              102      25.5          296
#> 446                  129         67:17               76      29.1          219
#> 447                   87         74:03               56      32.4          140
#> 448                   94         72:32               63      29.1          218
#> 449                   40         84:40               39      26.1          282
#> 450                  211         55:18              107      30.6          181
#> 451                  314         34:13              186      28.2          244
#> 452                  166         60:17               92      25.5          295
#> 453                  226         50:11              120      24.6          307
#> 454                  250         46:13              133      29.4          212
#> 455                   63         73:31               60      30.7          178
#> 456                  170         57:55               99      32.8          129
#> 457                  179         55:21              106      35.1           80
#> 458                   20         88:55               29      26.3          278
#> 459                   67         70:52               67      28.8          228
#> 460                  141         59:57               94      26.3          277
#> 461                  318         31:03              202      16.0          346
#> 462                  299         36:04              173      36.0           60
#> 463                   93         65:19               81      39.4           24
#> 464                  344         19:53              257      38.4           34
#> 465                   52         72:05               65      38.7           30
#> 466                  249         42:47              144      33.9          107
#> 467                   13         88:39               31      28.6          234
#> 468                  104         62:49               86      29.9          201
#> 469                  289         37:09              168      27.9          257
#> 470                   44         73:36               59      28.1          251
#> 471                   14         85:22               37      34.6           87
#> 472                   12         85:09               38      25.5          297
#> 473                   26         79:29               46      35.8           66
#> 474                  137         55:58              103      26.2          279
#> 475                  321         28:02              214      22.3          322
#> 476                   99         60:21               91      35.2           78
#> 477                   28         76:01               51      33.4          118
#> 478                  265         37:17              165      43.4           10
#> 479                   16         82:39               40      33.0          124
#> 480                  336         21:47              246      35.1           79
#> 481                   80         62:01               87      33.5          116
#> 482                    1        104:16               14      28.4          239
#> 483                  330         23:43              231      33.2          121
#> 484                   61         64:28               82      27.1          271
#> 485                  331         23:15              234      39.2           25
#> 486                  131         54:15              110      30.7          177
#> 487                   51         65:40               79      29.6          205
#> 488                   56         63:13               85      30.2          192
#> 489                  324         24:39              226      36.0           63
#> 490                   47         64:13               83      24.7          306
#> 491                  158         48:58              124      21.9          324
#> 492                  187         44:54              138      34.4           94
#> 493                  278         33:40              187      27.9          258
#> 494                  279         33:25              189      35.3           77
#> 495                  286         32:47              195      44.0            9
#> 496                   84         56:37              101      27.0          272
#> 497                  290         31:52              199      37.4           42
#> 498                   10         76:57               50      36.2           59
#> 499                  107         52:58              113      32.4          138
#> 500                  118         51:23              116      32.4          137
#> 501                  210         41:29              148      37.5           41
#> 502                  205         41:57              146      27.4          264
#> 503                  178         44:19              140      24.2          312
#> 504                   17         72:44               61      34.2           99
#> 505                  236         36:59              169      21.1          327
#> 506                  207         41:15              150      25.8          290
#> 507                  117         50:11              119      32.9          126
#> 508                  140         47:50              130      34.5           90
#> 509                  196         42:00              145      31.8          157
#> 510                  261         33:20              192      33.6          110
#> 511                  101         51:24              115      44.2            7
#> 512                   21         68:33               73      18.7          341
#> 513                  244         35:32              181      34.8           84
#> 514                  245         35:19              182      33.7          109
#> 515                  334         19:12              260      31.9          156
#> 516                  231         36:06              171      33.5          115
#> 517                  189         41:01              152      31.3          165
#> 518                   64         54:11              111      28.8          231
#> 519                  276         30:31              205      36.5           55
#> 520                  293         28:42              210      28.5          236
#> 521                   66         53:23              112      36.6           51
#> 522                  175         41:52              147      28.5          237
#> 523                   42         58:04               97      35.7           69
#> 524                  214         38:03              162      42.0           14
#> 525                  224         36:05              172      33.9          108
#> 526                  124         46:39              132      32.8          130
#> 527                  298         27:32              217      32.6          135
#> 528                  248         33:23              190      26.9          273
#> 529                  134         44:57              137      42.8           11
#> 530                  341         15:34              283      30.6          182
#> 531                  269         29:44              206      24.9          304
#> 532                  119         45:21              136      34.6           88
#> 533                  312         23:35              232      34.6           89
#> 534                  219         34:44              185      25.0          301
#> 535                   83         48:26              127      40.9           16
#> 536                   71         48:47              125      32.0          152
#> 537                   58         50:14              118      25.4          299
#> 538                  186         37:12              166      28.9          227
#> 539                   85         46:52              131      38.7           31
#> 540                  116         43:03              143      29.6          207
#> 541                  220         32:47              194      29.0          221
#> 542                   31         54:24              109      29.3          214
#> 543                  151         38:47              159      32.1          145
#> 544                  149         38:14              161      34.1          103
#> 545                  176         35:53              177      18.4          344
#> 546                   19         57:39              100      32.1          147
#> 547                  243         29:22              207      28.3          241
#> 548                   50         48:28              126      39.0           28
#> 549                  180         35:09              183      21.0          329
#> 550                  255         27:38              216      20.5          332
#> 551                  338         14:38              287      34.0          104
#> 552                  253         27:27              218      27.3          266
#> 553                  173         34:57              184      34.3           98
#> 554                  153         35:37              178      30.5          183
#> 555                  184         33:03              193      37.1           45
#> 556                   86         41:15              149      33.5          113
#> 557                  102         39:30              157      39.6           22
#> 558                  113         38:38              160      24.3          311
#> 559                   29         49:45              121      37.6           39
#> 560                  185         32:14              197      30.4          187
#> 561                   77         40:45              153      38.4           33
#> 562                  115         37:10              167      25.9          286
#> 563                  192         31:17              200      31.4          163
#> 564                  133         35:34              180      34.0          105
#> 565                   18         51:40              114      30.4          189
#> 566                  159         33:20              191      25.6          294
#> 567                  273         23:29              233      26.0          284
#> 568                  121         36:01              174      35.6           73
#> 569                    5         55:45              105      27.8          259
#> 570                  120         35:54              176      32.0          151
#> 571                   65         41:01              151      34.4           95
#> 572                  316         18:22              263      29.0          220
#> 573                  193         30:31              204      44.7            5
#> 574                  300         20:36              252      32.7          131
#> 575                  230         26:41              220      30.9          171
#> 576                  111         36:23              170      35.8           64
#> 577                   32         46:08              134      33.2          120
#> 578                  156         32:33              196      32.7          132
#> 579                  165         31:55              198      34.9           83
#> 580                   38         43:25              141      29.9          200
#> 581                   23         48:16              129      32.4          139
#> 582                  100         35:59              175      27.9          256
#> 583                   59         39:39              155      30.1          193
#> 584                  191         29:08              209      29.0          222
#> 585                  294         20:36              253      30.6          180
#> 586                   11         49:24              122      37.2           44
#> 587                  259         22:39              241      34.1          101
#> 588                   49         39:37              156      28.2          242
#> 589                  264         21:29              248      34.4           96
#> 590                  282         20:10              255      31.4          164
#> 591                  262         21:07              251      28.8          229
#> 592                   37         39:08              158      36.7           50
#> 593                  320         15:26              284      25.6          293
#> 594                  139         29:20              208      30.8          176
#> 595                  295         18:14              264      44.1            8
#> 596                   43         37:18              164      30.1          194
#> 597                  150         28:16              213      31.6          162
#> 598                  162         27:46              215      30.2          191
#> 599                  287         18:53              261      32.1          144
#> 600                   69         33:26              188      29.8          203
#> 601                  181         25:31              223      39.0           29
#> 602                  128         28:40              211      40.1           19
#> 603                  304         16:07              278      24.7          305
#> 604                  296         17:13              270      33.5          114
#> 605                   35         35:34              179      31.7          158
#> 606                  322         13:48              293      32.5          136
#> 607                  307         15:24              286      26.2          280
#> 608                  203         23:14              235      22.4          320
#> 609                  325         12:18              303      27.8          260
#> 610                  213         22:07              244      31.9          154
#> 611                   62         31:16              201      39.1           27
#> 612                  340          9:20              315      40.5           18
#> 613                   15         39:39              154      28.2          245
#> 614                  208         22:14              243      29.4          211
#> 615                    3         43:24              142      33.4          117
#> 616                   81         28:32              212      38.0           37
#> 617                  285         16:11              277      25.3          300
#> 618                  130         25:04              225      32.2          142
#> 619                  283         16:04              279      20.2          335
#> 620                  108         26:11              221      35.3           76
#> 621                  138         24:16              229      30.4          186
#> 622                  169         22:45              239      45.1            4
#> 623                  247         17:51              267      29.6          208
#> 624                   39         30:42              203      31.6          160
#> 625                  237         18:02              266      36.5           57
#> 626                  308         13:10              297      35.7           67
#> 627                  144         23:00              236      39.9           21
#> 628                  234         18:05              265      33.6          111
#> 629                  217         19:13              259      31.9          155
#> 630                  266         15:35              282      37.6           38
#> 631                  263         15:44              281      30.5          184
#> 632                  327         10:19              311      32.8          128
#> 633                  157         21:28              249      32.4          141
#> 634                   74         25:12              224      30.4          188
#> 635                   91         24:01              230      28.9          226
#> 636                  197         18:30              262      26.0          283
#> 637                  216         17:21              269      28.1          249
#> 638                   68         24:29              228      37.1           46
#> 639                  110         22:17              242      44.5            6
#> 640                  204         17:44              268      37.5           40
#> 641                  225         16:17              275      35.0           81
#> 642                  114         21:23              250      35.0           82
#> 643                  310         11:08              308      25.0          303
#> 644                  301         11:54              305      28.7          232
#> 645                  256         14:16              290      34.1          100
#> 646                  257         14:10              292      25.6          292
#> 647                   72         22:41              240      37.0           47
#> 648                  309         10:45              310      36.9           48
#> 649                  333          8:00              322      33.6          112
#> 650                  267         12:52              299      29.2          216
#> 651                  229         14:17              289      34.5           91
#> 652                  328          8:17              321      24.5          309
#> 653                   90         19:55              256      31.1          168
#> 654                  171         16:52              272      28.8          230
#> 655                  241         13:26              295      29.0          225
#> 656                  198         15:25              285      33.9          106
#> 657                   45         21:50              245      35.4           75
#> 658                  275         11:33              307      34.5           93
#> 659                   82         19:24              258      24.1          313
#> 660                   33         22:51              238      35.6           71
#> 661                  164         16:00              280      31.1          167
#> 662                  127         17:01              271      30.8          174
#> 663                  254         11:49              306      23.4          317
#> 664                  306          8:59              319      30.0          197
#> 665                   27         21:46              247      38.1           36
#> 666                  199         13:17              296      23.6          316
#> 667                    4         24:29              227      38.6           32
#> 668                  326          6:46              325      26.1          281
#> 669                   25         20:18              254      29.5          209
#> 670                   73         16:15              276      24.4          310
#> 671                  145         13:35              294      38.1           35
#> 672                  112         14:36              288      31.9          153
#> 673                  291          8:24              320      35.7           70
#> 674                   48         16:30              274      40.6           17
#> 675                  235         10:05              312      29.9          198
#> 676                   41         16:44              273      29.0          223
#> 677                  148         12:26              301      28.4          238
#> 678                   88         14:12              291      29.2          215
#> 679                  332          5:12              329      32.0          149
#> 680                  143         10:59              309      30.8          172
#> 681                  218          9:04              318      30.6          179
#> 682                   76         12:32              300      30.2          190
#> 683                  284          7:10              323      45.9            2
#> 684                  200          9:08              317      34.5           92
#> 685                   54         12:52              298      27.4          265
#> 686                  342          3:37              339      20.0          337
#> 687                  272          6:51              324      29.5          210
#> 688                   55         12:16              304      28.1          252
#> 689                  168          9:24              314      28.2          246
#> 690                  302          5:42              327      42.2           13
#> 691                  323          4:37              334      30.8          173
#> 692                   95          9:11              316      32.0          148
#> 693                  288          5:07              330      27.2          267
#> 694                  343          2:44              342      31.2          166
#> 695                  238          6:04              326      42.3           12
#> 696                  281          5:04              331      30.9          169
#> 697                  305          4:23              336      41.2           15
#> 698                  277          4:53              333      36.0           62
#> 699                   30          9:40              313      29.6          206
#> 700                  268          4:34              335      27.8          262
#> 701                  329          2:52              340      36.7           49
#> 702                  274          3:59              338      29.4          213
#> 703                  167          4:57              332      28.2          243
#> 704                  315          2:45              341      34.1          102
#> 705                  337          1:56              345      28.6          233
#> 706                  109          4:05              337      35.7           68
#> 707                  221          2:39              343      30.8          175
#> 708                  172          2:07              344      39.2           26
#> 709                  317          0:48              347      25.0          302
#> 710                  195          1:13              346      29.8          204
#> 711                  176        143:01                7      41.8           11
#> 712                   61        185:51                2      23.1          317
#> 713                  180        133:05               11      21.5          337
#> 714                   48        185:47                3      31.5          156
#> 715                  204        121:19               18      13.7          357
#> 716                   90        153:51                6      28.4          239
#> 717                  173        121:34               17      26.9          267
#> 718                    4        237:19                1      35.2           78
#> 719                  226        101:50               33      38.3           36
#> 720                  166        114:22               22      25.4          293
#> 721                   41        159:16                5      30.1          196
#> 722                  227         96:31               37      28.2          242
#> 723                  303         77:16               63      29.5          212
#> 724                  113        123:28               14      31.0          171
#> 725                  327         64:54              101       8.8          358
#> 726                   67        132:11               12      26.1          282
#> 727                  134        110:39               24      36.5           63
#> 728                  105        116:37               20      35.0           82
#> 729                    6        184:31                4      19.8          349
#> 730                  272         79:24               57      20.0          346
#> 731                  344         50:45              151      27.3          257
#> 732                   75        123:03               15      30.6          180
#> 733                   45        134:17               10      30.4          186
#> 734                   60        125:22               13      30.9          173
#> 735                  108        109:22               26      37.4           47
#> 736                   68        121:40               16      26.3          276
#> 737                   30        136:08                8      38.7           33
#> 738                   74        116:48               19      29.4          215
#> 739                  119        103:35               30      19.4          351
#> 740                  274         72:13               78      30.2          192
#> 741                  179         89:34               48      30.2          191
#> 742                  120        102:24               32      26.4          274
#> 743                  221         78:47               59      17.8          355
#> 744                  315         57:24              126      32.2          146
#> 745                  114         99:29               35      29.7          209
#> 746                  232         74:55               71      34.5           97
#> 747                  256         71:02               80      22.0          332
#> 748                  124         95:09               39      28.5          238
#> 749                  267         68:14               90      39.2           27
#> 750                  331         48:30              159      20.3          345
#> 751                   93        100:19               34      30.1          198
#> 752                  141         87:32               49      40.3           21
#> 753                   89         97:58               36      31.0          167
#> 754                  165         82:30               54      36.4           64
#> 755                  211         73:20               74      32.3          142
#> 756                   55        106:14               27      28.8          232
#> 757                  224         69:31               86      27.4          255
#> 758                  174         77:57               60      27.4          254
#> 759                  304         55:28              129      35.4           77
#> 760                  266         62:37              113      24.2          305
#> 761                  253         63:23              106      36.5           62
#> 762                  184         73:55               73      24.3          304
#> 763                   50        103:26               31      33.6          115
#> 764                  213         68:07               92      29.8          202
#> 765                  237         64:34              103      33.8          111
#> 766                   42        104:16               29      30.8          178
#> 767                  116         84:54               51      36.0           68
#> 768                  269         59:11              120      22.9          319
#> 769                  190         70:36               82      26.7          269
#> 770                   22        110:04               25      31.9          151
#> 771                   32        104:46               28      29.7          210
#> 772                    5        134:19                9      31.2          160
#> 773                  147         75:55               68      26.2          278
#> 774                   66         93:03               42      28.8          231
#> 775                  235         61:25              115      25.2          295
#> 776                  255         58:38              122      19.8          347
#> 777                  168         70:45               81      28.2          241
#> 778                  129         76:38               66      22.8          323
#> 779                   56         92:00               44      32.3          143
#> 780                  194         65:21               98      36.9           55
#> 781                  297         49:47              155      38.3           37
#> 782                  295         50:01              154      24.2          306
#> 783                   11        116:07               21      35.5           76
#> 784                   77         84:08               52      31.1          165
#> 785                  341         36:11              201      31.7          155
#> 786                  245         57:39              124      22.7          325
#> 787                  162         68:09               91      28.3          240
#> 788                  336         36:53              199      22.5          327
#> 789                  115         75:46               69      42.2            8
#> 790                   37         95:17               38      30.5          184
#> 791                  178         65:17               99      37.3           48
#> 792                  342         34:48              205      37.7           43
#> 793                  131         72:27               75      26.2          277
#> 794                  169         65:53               96      31.2          163
#> 795                   92         77:55               61      28.9          228
#> 796                   73         81:45               56      20.8          342
#> 797                   38         92:27               43      27.2          259
#> 798                  195         60:55              117      27.0          265
#> 799                   25         95:03               40      34.6           92
#> 800                   86         77:04               64      34.7           89
#> 801                  135         69:44               85      19.8          348
#> 802                  239         54:58              133      20.7          343
#> 803                  251         53:25              140      30.1          193
#> 804                  276         50:07              153      22.2          330
#> 805                  186         61:04              116      25.7          290
#> 806                  151         65:05              100      27.7          248
#> 807                  234         54:15              137      35.5           74
#> 808                  292         45:46              164      34.9           84
#> 809                  316         40:41              185      23.0          318
#> 810                  201         58:13              123      33.5          120
#> 811                  228         54:29              135      39.9           25
#> 812                  258         51:09              147      33.2          126
#> 813                  275         48:46              158      29.5          213
#> 814                  244         52:18              144      21.5          338
#> 815                  145         64:32              104      35.6           71
#> 816                  338         32:51              212      23.9          309
#> 817                  106         70:25               83      22.8          322
#> 818                   19         93:04               41      33.1          128
#> 819                  261         49:27              157      33.2          125
#> 820                  152         62:39              112      31.3          159
#> 821                  318         38:29              192      33.4          121
#> 822                  296         43:27              173      30.4          185
#> 823                  246         50:52              148      30.0          200
#> 824                  268         47:33              161      24.7          302
#> 825                  139         62:57              110      40.9           15
#> 826                   16         91:21               47      33.6          116
#> 827                   87         69:24               88      33.7          113
#> 828                  123         64:44              102      25.2          298
#> 829                   15         91:51               45      26.5          271
#> 830                  102         66:36               95      30.9          175
#> 831                   27         83:09               53      35.1           80
#> 832                    3        113:54               23      27.2          258
#> 833                  183         55:16              130      22.4          329
#> 834                  328         34:44              207      21.1          341
#> 835                   72         69:52               84      32.2          145
#> 836                  280         43:16              175      30.9          174
#> 837                   53         74:45               72      23.6          313
#> 838                  199         51:38              146      26.4          275
#> 839                   98         64:11              105      32.5          138
#> 840                  104         63:15              109      26.1          280
#> 841                   43         75:25               70      27.1          260
#> 842                   59         71:27               79      27.7          247
#> 843                  311         36:19              200      30.5          183
#> 844                  354         23:05              257      29.8          208
#> 845                  231         46:55              163      33.0          132
#> 846                   71         67:42               93      39.2           28
#> 847                  160         54:16              136      33.3          122
#> 848                   76         65:27               97      35.5           73
#> 849                   95         62:55              111      26.5          272
#> 850                  218         47:25              162      30.5          182
#> 851                   28         77:24               62      34.6           96
#> 852                   82         63:19              108      25.2          296
#> 853                  233         45:08              166      32.8          135
#> 854                    7         91:37               46      34.6           94
#> 855                  117         57:29              125      32.2          147
#> 856                  144         53:44              138      27.1          261
#> 857                   21         76:47               65      24.1          308
#> 858                  358         15:05              303      18.5          353
#> 859                  220         44:43              167      33.1          130
#> 860                  118         56:54              128      40.6           16
#> 861                   97         58:55              121      36.6           60
#> 862                   10         85:43               50      39.0           30
#> 863                  254         41:20              181      22.5          328
#> 864                  229         43:10              176      29.4          216
#> 865                   46         67:37               94      24.1          307
#> 866                   35         69:29               87      29.3          219
#> 867                   40         68:31               89      28.5          237
#> 868                   94         57:03              127      27.4          253
#> 869                  223         42:13              179      32.4          141
#> 870                  212         43:07              177      33.1          129
#> 871                  350         22:13              261      37.7           42
#> 872                   64         61:58              114      25.6          291
#> 873                  167         47:42              160      17.0          356
#> 874                  200         44:32              170      38.9           32
#> 875                  107         54:43              134      34.9           86
#> 876                  206         43:26              174      34.8           88
#> 877                   18         72:22               76      30.1          195
#> 878                    9         82:13               55      30.1          197
#> 879                  193         43:57              172      26.0          284
#> 880                  137         49:40              156      27.0          263
#> 881                   88         55:02              132      29.8          205
#> 882                  324         28:26              226      25.8          287
#> 883                   96         52:19              143      21.8          335
#> 884                  247         37:37              195      32.7          136
#> 885                  343         23:04              258      35.1           79
#> 886                  273         34:45              206      23.7          312
#> 887                    8         76:26               67      33.7          112
#> 888                  345         21:51              265      33.0          133
#> 889                   26         63:20              107      38.2           38
#> 890                  290         31:47              215      34.4          100
#> 891                  188         40:48              184      25.2          297
#> 892                   70         53:35              139      29.0          225
#> 893                   33         60:24              118      31.0          169
#> 894                  158         42:29              178      31.8          152
#> 895                  310         28:11              230      30.7          179
#> 896                  319         26:11              238      22.6          326
#> 897                  185         39:42              188      32.5          139
#> 898                  127         45:19              165      40.4           18
#> 899                   80         50:08              152      36.9           56
#> 900                  340         22:02              263      34.2          102
#> 901                  349         19:40              279      23.9          310
#> 902                  314         26:28              236      28.7          233
#> 903                   49         55:12              131      29.2          220
#> 904                  132         44:05              171      29.8          206
#> 905                  306         28:18              228      31.8          153
#> 906                  189         37:30              196      42.5            7
#> 907                   62         50:51              149      26.1          279
#> 908                   17         59:58              119      34.3          101
#> 909                    2         78:55               58      42.0            9
#> 910                  339         20:49              268      26.6          270
#> 911                  161         38:54              191      33.3          123
#> 912                  321         23:44              252      27.6          250
#> 913                  133         41:11              182      41.3           12
#> 914                   52         50:50              150      35.6           70
#> 915                  128         41:05              183      28.1          243
#> 916                   31         53:17              141      30.8          176
#> 917                  317         23:54              251      40.4           19
#> 918                   81         44:34              169      28.6          235
#> 919                  283         28:02              231      20.4          344
#> 920                  332         20:46              270      27.8          246
#> 921                  125         39:23              190      21.8          334
#> 922                  305         25:00              246      28.8          229
#> 923                  351         15:59              299      27.0          262
#> 924                    1         72:15               77      33.8          110
#> 925                  282         27:06              235      31.1          164
#> 926                  142         37:07              198      29.5          214
#> 927                   69         44:37              168      34.6           93
#> 928                  265         27:41              233      37.2           50
#> 929                  260         28:01              232      25.1          299
#> 930                  121         38:02              193      31.0          170
#> 931                  294         24:37              247      33.3          124
#> 932                  148         35:13              204      28.9          227
#> 933                   83         40:10              186      42.9            6
#> 934                  175         32:42              213      29.8          203
#> 935                   14         53:04              142      21.1          340
#> 936                  347         16:08              297      29.1          222
#> 937                  143         34:42              208      37.5           46
#> 938                  334         18:26              284      38.1           39
#> 939                  215         29:07              223      19.1          352
#> 940                  270         25:50              240      34.6           95
#> 941                  299         23:05              256      26.0          283
#> 942                  353         13:55              309      36.7           58
#> 943                  222         28:25              227      23.2          314
#> 944                  219         28:30              225      28.6          234
#> 945                  205         29:30              220      36.2           66
#> 946                  159         32:28              214      29.8          204
#> 947                  196         29:49              218      45.5            4
#> 948                  138         33:09              210      29.0          224
#> 949                  288         23:10              255      39.1           29
#> 950                   12         51:55              145      36.3           65
#> 951                   44         42:09              180      37.1           52
#> 952                  357         10:49              325      37.9           40
#> 953                  187         28:50              224      42.0           10
#> 954                  330         17:21              288      30.2          189
#> 955                  242         25:21              242      22.1          331
#> 956                  313         19:22              280      23.9          311
#> 957                  172         29:12              222      24.8          301
#> 958                   65         37:53              194      29.1          223
#> 959                  216         25:54              239      31.9          150
#> 960                  110         33:15              209      26.4          273
#> 961                  149         29:25              221      34.0          104
#> 962                   39         39:29              189      33.9          108
#> 963                  355         10:51              324      27.0          266
#> 964                  214         24:29              248      37.6           45
#> 965                  207         25:00              245      29.9          201
#> 966                  287         20:23              272      25.4          292
#> 967                  243         22:57              259      28.0          244
#> 968                   54         35:36              203      45.8            3
#> 969                   20         40:04              187      27.6          249
#> 970                   99         30:46              216      34.0          106
#> 971                   36         37:22              197      39.5           26
#> 972                  312         17:21              289      33.5          117
#> 973                  329         15:21              302      25.9          286
#> 974                  170         25:14              243      37.0           54
#> 975                  122         28:16              229      36.9           57
#> 976                  130         27:39              234      27.0          264
#> 977                  210         22:43              260      32.6          137
#> 978                  164         25:04              244      28.6          236
#> 979                  289         18:18              286      21.1          339
#> 980                  277         18:49              282      25.7          289
#> 981                  240         20:34              271      31.0          172
#> 982                   24         35:36              202      27.9          245
#> 983                  248         20:01              275      30.1          194
#> 984                  293         17:10              291      29.3          218
#> 985                  192         22:11              262      33.5          118
#> 986                   58         30:37              217      22.7          324
#> 987                  197         21:52              264      38.9           31
#> 988                  126         25:32              241      35.6           72
#> 989                  241         19:50              276      37.1           53
#> 990                  300         16:28              296      46.5            1
#> 991                  320         14:32              307      33.6          114
#> 992                  203         20:55              267      32.5          140
#> 993                  136         24:09              249      33.2          127
#> 994                  208         20:22              273      34.0          105
#> 995                  177         21:22              266      27.3          256
#> 996                   47         29:43              219      36.6           61
#> 997                  281         16:29              295      37.3           49
#> 998                  323         13:10              313      22.8          321
#> 999                  263         16:56              293      34.9           87
#> 1000                 163         20:46              269      28.9          226
#> 1001                  13         33:08              211      29.3          217
#> 1002                 252         16:50              294      30.4          187
#> 1003                  85         24:04              250      32.3          144
#> 1004                  57         26:14              237      21.8          333
#> 1005                 191         18:19              285      31.2          162
#> 1006                  79         23:29              254      34.5           98
#> 1007                 146         19:44              277      32.1          148
#> 1008                 291         13:44              310      29.2          221
#> 1009                 262         15:02              305      23.2          315
#> 1010                 335         10:13              326      39.9           24
#> 1011                 155         18:38              283      33.9          107
#> 1012                 301         12:35              314      35.5           75
#> 1013                 209         16:05              298      22.8          320
#> 1014                 307         12:09              318      25.7          288
#> 1015                 111         19:40              278      35.0           83
#> 1016                 337          9:22              331      40.2           22
#> 1017                 298         12:14              317      41.1           13
#> 1018                 309         11:33              322      31.2          161
#> 1019                 154         17:06              292      27.6          251
#> 1020                 325         10:12              327      35.1           81
#> 1021                 150         17:11              290      33.0          131
#> 1022                 250         13:40              311      31.4          157
#> 1023                  29         23:41              253      29.6          211
#> 1024                 198         14:50              306      38.6           34
#> 1025                 100         18:14              287      37.7           44
#> 1026                 153         15:43              301      29.8          207
#> 1027                 278         11:54              320      33.5          119
#> 1028                  63         19:14              281      33.9          109
#> 1029                 156         15:03              304      34.2          103
#> 1030                 264         11:36              321      19.6          350
#> 1031                  23         20:16              274      25.9          285
#> 1032                 202         12:34              315      18.1          354
#> 1033                  84         15:47              300      30.6          181
#> 1034                 181         12:20              316      36.7           59
#> 1035                 109         14:04              308      40.1           23
#> 1036                 249          9:57              328      37.2           51
#> 1037                 259          9:39              330      26.1          281
#> 1038                 284          8:43              336      36.1           67
#> 1039                 140         12:04              319      27.5          252
#> 1040                 157         11:30              323      34.7           91
#> 1041                 217          9:57              329      38.4           35
#> 1042                 346          5:36              343      28.8          230
#> 1043                 285          8:34              337      25.0          300
#> 1044                  91         13:11              312      30.2          190
#> 1045                 238          8:49              335      30.8          177
#> 1046                 225          8:59              334      30.0          199
#> 1047                 352          4:26              351      31.4          158
#> 1048                 257          8:11              338      23.1          316
#> 1049                 333          5:25              347      32.0          149
#> 1050                 230          7:18              339      34.9           85
#> 1051                 101          9:21              332      31.0          168
#> 1052                 112          9:07              333      31.8          154
#> 1053                 308          5:30              346      32.9          134
#> 1054                 348          3:50              352      21.7          336
#> 1055                 322          4:35              350      35.9           69
#> 1056                 279          5:33              345      25.3          294
#> 1057                 171          6:09              341      40.5           17
#> 1058                  51          6:58              340      30.4          188
#> 1059                 182          4:56              349      44.7            5
#> 1060                 103          5:45              342      41.0           14
#> 1061                  78          5:33              344      31.0          166
#> 1062                 302          3:11              354      34.5           99
#> 1063                 271          3:18              353      26.9          268
#> 1064                  34          5:07              348      40.3           20
#> 1065                 236          3:03              355      37.8           41
#> 1066                 326          1:29              356      24.6          303
#> 1067                 286          1:05              357      46.3            2
#> 1068                 356          0:01              358      34.7           90
#> 1069                  76        181:03                1      29.2          222
#> 1070                  73        175:13                3      29.1          226
#> 1071                 280        108:26               33      27.4          261
#> 1072                 260        117:39               22      18.6          357
#> 1073                  75        158:30                5      19.1          355
#> 1074                  34        179:30                2      28.6          233
#> 1075                 325         79:12               79      27.8          249
#> 1076                 175        119:37               20      24.7          311
#> 1077                  82        143:45                8      26.1          287
#> 1078                 108        135:44               14      20.5          349
#> 1079                  88        135:02               15      24.4          320
#> 1080                 324         75:01               89      31.8          153
#> 1081                 204        105:43               36      34.2           88
#> 1082                 148        115:39               26      32.9          118
#> 1083                 163        111:25               31      30.9          179
#> 1084                 149        112:31               30      32.1          147
#> 1085                 188        104:04               38      29.4          218
#> 1086                 230         97:42               45      35.8           57
#> 1087                  84        126:24               16      34.2           87
#> 1088                 331         66:01              104      30.1          194
#> 1089                  47        141:00               11      32.1          143
#> 1090                  93        120:33               18      35.5           66
#> 1091                 279         80:56               77      36.3           53
#> 1092                 105        117:28               24      31.6          159
#> 1093                  40        142:04                9      27.9          246
#> 1094                 246         88:33               66      29.3          220
#> 1095                 354         51:29              164      19.5          352
#> 1096                 227         91:56               60      34.3           86
#> 1097                 213         94:07               56      33.1          113
#> 1098                  66        125:29               17      27.2          266
#> 1099                  35        140:59               12      26.8          274
#> 1100                  19        149:28                7      18.6          358
#> 1101                 198         95:30               53      29.6          211
#> 1102                 206         93:50               57      27.4          263
#> 1103                  26        141:22               10      32.7          123
#> 1104                 145        102:41               39      29.9          203
#> 1105                  87        114:48               28      29.4          217
#> 1106                 282         74:17               94      24.5          316
#> 1107                 142        101:18               43      25.2          303
#> 1108                  86        111:18               32      28.4          238
#> 1109                   3        165:16                4      37.4           33
#> 1110                   9        149:33                6      31.4          171
#> 1111                  18        139:36               13      33.3          111
#> 1112                 155         95:28               54      24.7          312
#> 1113                  78        108:11               34      31.5          163
#> 1114                 100        101:20               42      32.9          119
#> 1115                  96        102:05               40      24.6          314
#> 1116                  58        112:51               29      30.8          181
#> 1117                 144         92:43               58      33.7          101
#> 1118                 233         78:53               80      20.2          350
#> 1119                 120         94:54               55      31.5          162
#> 1120                 219         79:55               78      25.5          300
#> 1121                  42        117:14               25      45.0            2
#> 1122                 257         71:09               98      34.3           85
#> 1123                 363         26:43              280      22.4          341
#> 1124                 169         83:19               73      19.3          353
#> 1125                 225         76:17               86      31.4          168
#> 1126                 138         88:54               65      22.2          342
#> 1127                 349         44:53              190      21.1          347
#> 1128                 154         85:07               68      22.6          339
#> 1129                 321         54:24              150      28.2          242
#> 1130                 307         58:21              136      31.8          154
#> 1131                 117         90:41               63      36.8           42
#> 1132                 220         75:41               88      23.5          334
#> 1133                  83         96:12               51      29.9          204
#> 1134                 238         71:37               97      33.5          106
#> 1135                 265         65:44              107      35.4           68
#> 1136                 231         72:02               96      38.8           13
#> 1137                 179         76:41               85      26.2          284
#> 1138                 292         57:57              139      28.4          239
#> 1139                 180         75:44               87      33.5          107
#> 1140                  59         98:34               44      37.9           28
#> 1141                 358         35:29              238      28.8          231
#> 1142                  12        119:42               19      31.6          158
#> 1143                 281         58:27              135      35.6           62
#> 1144                 224         68:59              101      29.7          207
#> 1145                 261         63:21              119      26.1          288
#> 1146                 171         74:30               91      24.4          319
#> 1147                 116         82:41               74      31.5          164
#> 1148                  31        105:55               35      36.0           55
#> 1149                  15        115:38               27      29.8          206
#> 1150                 278         58:09              137      38.4           17
#> 1151                  70         91:08               62      28.0          245
#> 1152                 340         43:56              196      27.6          255
#> 1153                 352         37:50              224      29.4          216
#> 1154                 284         56:05              145      27.4          260
#> 1155                  48         96:16               50      21.9          343
#> 1156                  27        104:25               37      34.0           95
#> 1157                 152         74:29               93      34.4           84
#> 1158                 156         73:38               95      32.3          135
#> 1159                 124         78:13               81      34.4           83
#> 1160                 297         51:42              163      23.8          329
#> 1161                 211         65:50              105      32.2          138
#> 1162                 300         50:47              171      26.0          289
#> 1163                 242         60:50              127      34.6           81
#> 1164                  37         96:33               49      31.4          169
#> 1165                 135         74:29               92      37.7           29
#> 1166                 106         78:09               83      27.1          268
#> 1167                   5        118:47               21      35.2           72
#> 1168                 263         56:37              142      26.8          273
#> 1169                  30         96:08               52      28.3          240
#> 1170                  94         78:09               82      36.4           51
#> 1171                  69         83:49               72      23.7          330
#> 1172                 112         74:55               90      33.3          112
#> 1173                  49         88:57               64      26.7          276
#> 1174                  74         81:29               75      24.2          323
#> 1175                 333         41:11              205      25.5          301
#> 1176                 186         64:44              110      29.0          227
#> 1177                 146         69:09              100      33.5          105
#> 1178                  22         97:06               47      34.7           76
#> 1179                  53         84:23               70      21.0          348
#> 1180                  13        101:28               41      25.8          297
#> 1181                  46         86:55               67      33.0          117
#> 1182                 176         64:06              113      37.4           35
#> 1183                   1        117:33               23      34.0           94
#> 1184                 332         40:06              211      39.7           11
#> 1185                  62         81:26               76      32.7          124
#> 1186                 251         55:12              148      28.5          235
#> 1187                 182         62:35              122      31.4          170
#> 1188                  16         96:50               48      36.3           52
#> 1189                 191         61:31              125      38.2           24
#> 1190                 255         54:19              151      32.8          120
#> 1191                  50         84:08               71      29.8          205
#> 1192                 209         59:14              133      27.3          264
#> 1193                 158         64:24              111      23.5          332
#> 1194                 207         58:30              134      36.6           46
#> 1195                 289         46:16              182      23.7          331
#> 1196                 311         43:09              198      38.2           22
#> 1197                 313         42:19              199      32.5          130
#> 1198                 326         38:52              214      28.7          232
#> 1199                   8         97:20               46      32.5          128
#> 1200                 170         59:51              129      23.0          336
#> 1201                  56         77:16               84      32.4          132
#> 1202                 249         51:48              161      35.7           60
#> 1203                 298         43:47              197      26.7          277
#> 1204                  29         85:04               69      31.0          178
#> 1205                 118         65:09              108      33.7          102
#> 1206                 102         67:21              102      30.5          190
#> 1207                 147         61:21              126      21.2          346
#> 1208                 320         38:43              216      24.1          324
#> 1209                 129         63:25              118      25.8          293
#> 1210                 121         63:51              114      18.0          361
#> 1211                 199         54:59              149      26.1          286
#> 1212                  11         91:53               61      29.9          202
#> 1213                 164         57:59              138      21.9          344
#> 1214                 336         35:05              240      44.0            5
#> 1215                 128         62:33              123      32.1          141
#> 1216                 254         49:00              175      32.6          127
#> 1217                 295         41:38              202      27.7          250
#> 1218                   6         92:19               59      35.5           65
#> 1219                 166         55:37              147      32.2          136
#> 1220                 222         51:23              165      18.3          360
#> 1221                 216         51:50              158      24.5          317
#> 1222                 103         62:50              121      27.6          256
#> 1223                 126         59:43              131      35.5           64
#> 1224                 200         51:49              160      27.2          267
#> 1225                 316         36:55              229      27.6          258
#> 1226                  85         64:09              112      24.3          322
#> 1227                 334         33:20              246      24.8          309
#> 1228                 218         49:59              173      37.3           37
#> 1229                 168         53:12              156      34.2           89
#> 1230                 134         57:32              140      30.7          185
#> 1231                 283         41:00              208      37.3           36
#> 1232                 335         32:26              249      33.9           97
#> 1233                 303         38:06              222      25.1          304
#> 1234                 275         42:05              201      25.9          292
#> 1235                 183         51:22              166      16.3          362
#> 1236                 244         45:22              188      29.4          215
#> 1237                 240         45:53              187      37.3           38
#> 1238                 296         37:41              227      26.6          278
#> 1239                 141         53:35              154      26.3          283
#> 1240                  33         71:04               99      22.6          338
#> 1241                 241         44:24              191      28.8          230
#> 1242                  65         63:11              120      31.7          157
#> 1243                 314         34:50              241      32.0          149
#> 1244                 317         34:03              245      24.8          310
#> 1245                  71         61:36              124      29.9          200
#> 1246                 299         36:15              232      35.3           70
#> 1247                 172         49:22              174      36.6           48
#> 1248                 343         28:42              270      31.1          177
#> 1249                 150         51:21              167      33.5          104
#> 1250                 122         54:10              152      26.8          275
#> 1251                  44         65:45              106      24.6          313
#> 1252                 247         42:08              200      34.1           92
#> 1253                  91         56:15              144      29.0          228
#> 1254                  38         67:07              103      24.0          325
#> 1255                 276         38:18              221      32.4          134
#> 1256                 140         50:58              169      34.7           75
#> 1257                 110         53:17              155      25.6          299
#> 1258                 259         39:46              213      27.6          254
#> 1259                  61         59:33              132      29.2          223
#> 1260                 181         45:56              186      36.0           56
#> 1261                 319         31:22              255      22.6          340
#> 1262                  55         60:19              128      37.5           31
#> 1263                 130         50:28              172      34.7           77
#> 1264                 196         44:20              193      24.4          318
#> 1265                  39         63:43              116      31.2          175
#> 1266                 344         25:55              284      42.5            7
#> 1267                 256         38:40              219      29.4          214
#> 1268                 131         48:52              176      26.9          272
#> 1269                  98         51:49              159      38.6           14
#> 1270                 248         38:42              218      25.0          305
#> 1271                  80         54:07              153      36.9           41
#> 1272                  25         65:06              109      31.9          151
#> 1273                 291         33:09              247      38.3           20
#> 1274                  54         57:25              141      15.9          363
#> 1275                  28         63:35              117      25.8          295
#> 1276                 250         37:53              223      39.4           12
#> 1277                 208         41:01              207      26.1          285
#> 1278                 111         47:41              180      23.9          326
#> 1279                 151         44:16              195      24.8          308
#> 1280                  77         51:45              162      28.5          236
#> 1281                 357         20:05              305      34.5           82
#> 1282                 223         38:43              215      24.3          321
#> 1283                 115         46:08              185      38.1           25
#> 1284                 290         31:09              256      26.4          282
#> 1285                 356         19:44              307      34.6           80
#> 1286                 329         26:10              283      24.5          315
#> 1287                  24         59:47              130      26.6          279
#> 1288                 308         28:51              268      23.4          335
#> 1289                 301         29:24              266      30.6          187
#> 1290                 210         37:46              225      44.4            3
#> 1291                 114         44:22              192      36.6           47
#> 1292                  60         50:52              170      35.8           58
#> 1293                  95         46:11              183      31.6          161
#> 1294                 205         37:24              228      35.5           63
#> 1295                 229         35:27              239      22.8          337
#> 1296                  72         47:29              181      37.2           39
#> 1297                 185         37:44              226      28.1          243
#> 1298                 212         35:47              236      32.0          148
#> 1299                 136         40:58              209      34.8           73
#> 1300                 159         38:30              220      31.8          152
#> 1301                 157         38:42              217      25.0          307
#> 1302                 123         41:24              203      30.3          192
#> 1303                 192         36:31              230      29.6          210
#> 1304                  20         56:18              143      32.2          137
#> 1305                 189         36:11              233      30.7          182
#> 1306                 277         29:26              264      31.6          160
#> 1307                  64         46:11              184      33.5          108
#> 1308                   4         63:48              115      25.9          291
#> 1309                 328         23:14              299      32.4          133
#> 1310                 109         40:46              210      37.2           40
#> 1311                 162         36:19              231      27.6          253
#> 1312                  97         41:21              204      33.9           98
#> 1313                  43         48:35              177      30.7          184
#> 1314                 264         29:25              265      27.4          259
#> 1315                 262         29:38              262      31.9          150
#> 1316                 232         32:05              251      31.2          174
#> 1317                 160         35:51              235      31.2          176
#> 1318                  17         52:31              157      30.1          196
#> 1319                 167         34:31              242      25.0          306
#> 1320                  36         48:05              178      34.7           74
#> 1321                 288         25:49              286      29.3          221
#> 1322                 345         19:28              309      25.3          302
#> 1323                   7         55:56              146      39.8           10
#> 1324                  32         47:53              179      32.8          121
#> 1325                 234         30:18              261      34.6           79
#> 1326                 272         27:16              277      31.2          172
#> 1327                 174         32:53              248      29.6          208
#> 1328                 252         28:32              272      32.1          146
#> 1329                 127         35:33              237      26.5          280
#> 1330                 139         34:26              243      34.1           93
#> 1331                 143         34:13              244      38.6           15
#> 1332                 235         29:01              267      27.2          265
#> 1333                  10         51:19              168      35.8           59
#> 1334                  57         41:04              206      36.5           50
#> 1335                 342         18:56              313      36.1           54
#> 1336                 190         30:49              257      25.7          298
#> 1337                 274         25:19              292      27.6          257
#> 1338                 177         30:46              258      32.6          126
#> 1339                  23         44:58              189      29.9          201
#> 1340                 197         29:29              263      38.2           21
#> 1341                 350         16:24              323      30.7          183
#> 1342                 165         30:37              259      30.2          193
#> 1343                 153         31:23              254      33.8          100
#> 1344                 330         19:10              312      35.6           61
#> 1345                 201         28:39              271      36.8           43
#> 1346                 323         19:19              311      31.7          155
#> 1347                 266         24:14              297      29.1          225
#> 1348                 245         25:33              289      30.4          191
#> 1349                 243         25:31              290      33.1          115
#> 1350                  41         39:50              212      28.0          244
#> 1351                 187         28:20              274      30.6          188
#> 1352                 253         24:57              294      44.3            4
#> 1353                 327         18:17              316      19.7          351
#> 1354                 226         25:46              287      30.9          180
#> 1355                 193         26:57              279      28.3          241
#> 1356                  92         32:07              250      38.2           23
#> 1357                 304         19:25              310      34.0           96
#> 1358                  45         36:09              234      37.9           27
#> 1359                 228         24:38              295      30.0          198
#> 1360                 215         25:06              293      38.4           16
#> 1361                  81         31:55              252      23.9          327
#> 1362                 306         18:46              314      25.8          294
#> 1363                 194         25:26              291      18.6          359
#> 1364                 267         21:36              302      33.6          103
#> 1365                 119         28:45              269      29.6          209
#> 1366                  90         30:18              260      36.7           45
#> 1367                 362          9:28              346      31.2          173
#> 1368                 273         20:22              303      36.5           49
#> 1369                  63         31:37              253      26.9          271
#> 1370                 137         26:34              282      21.4          345
#> 1371                   2         44:17              194      31.7          156
#> 1372                 351         13:04              335      40.0            9
#> 1373                 353         12:16              338      38.3           18
#> 1374                 113         26:35              281      37.5           30
#> 1375                 133         25:51              285      23.5          333
#> 1376                 173         23:38              298      30.6          186
#> 1377                  99         27:11              278      35.2           71
#> 1378                 125         25:36              288      25.9          290
#> 1379                  67         28:04              275      37.9           26
#> 1380                 346         12:34              336      33.1          114
#> 1381                 355         10:52              343      31.4          167
#> 1382                 318         14:44              329      35.3           69
#> 1383                  52         28:22              273      33.1          116
#> 1384                 101         24:34              296      33.9           99
#> 1385                 305         15:25              325      32.2          139
#> 1386                 161         21:40              301      31.5          165
#> 1387                 221         19:36              308      46.0            1
#> 1388                 268         17:25              320      32.1          145
#> 1389                 237         18:38              315      29.4          219
#> 1390                 184         19:56              306      32.5          129
#> 1391                 360          8:58              349      27.0          270
#> 1392                 286         14:57              328      29.5          213
#> 1393                 312         13:36              334      30.1          197
#> 1394                 107         22:00              300      43.0            6
#> 1395                 217         17:32              319      37.4           32
#> 1396                 287         14:18              330      36.7           44
#> 1397                 202         17:34              318      38.3           19
#> 1398                 104         20:13              304      37.4           34
#> 1399                  14         27:41              276      18.8          356
#> 1400                 203         16:37              321      32.8          122
#> 1401                 271         14:07              332      33.4          109
#> 1402                 195         16:27              322      34.1           91
#> 1403                 214         15:40              324      23.9          328
#> 1404                 132         17:43              317      32.1          144
#> 1405                 293         12:02              339      32.7          125
#> 1406                 310         11:22              342      27.1          269
#> 1407                 258         13:41              333      32.4          131
#> 1408                 236         14:16              331      34.1           90
#> 1409                 338          9:21              347      27.4          262
#> 1410                 178         15:08              326      33.4          110
#> 1411                 285         11:30              341      29.5          212
#> 1412                 339          8:47              350      34.6           78
#> 1413                 309         10:18              344      31.4          166
#> 1414                 270         11:33              340      19.2          354
#> 1415                 239         12:28              337      30.1          195
#> 1416                 341          8:20              353      40.2            8
#> 1417                 322          8:35              351      32.2          140
#> 1418                 315          8:08              354      26.4          281
#> 1419                 302          8:03              355      27.8          248
#> 1420                 269          8:31              352      30.6          189
#> 1421                  21         15:02              327      29.1          224
#> 1422                 347          5:20              356      35.4           67
#> 1423                 348          4:40              360      27.7          251
#> 1424                  68         10:14              345      29.0          229
#> 1425                 337          4:48              358      32.1          142
#> 1426                  89          9:01              348      28.5          234
#> 1427                 294          3:53              361      27.7          252
#> 1428                 361          2:15              362      29.9          199
#> 1429                  79          4:44              359      25.8          296
#> 1430                  51          4:54              357      28.4          237
#> 1431                 359          0:03              363      27.9          247
#> 1432                  49        191:05                3      28.1          241
#> 1433                 317         98:04               38      25.7          287
#> 1434                   1        256:05                1      35.0           93
#> 1435                 305         96:22               42      35.5           81
#> 1436                  21        191:47                2      23.7          320
#> 1437                 245        109:53               23      31.4          160
#> 1438                 180        126:12               14      23.6          322
#> 1439                  36        175:43                7      24.4          304
#> 1440                  27        182:27                4      21.5          342
#> 1441                 230        111:16               20      25.0          295
#> 1442                  77        147:54                9      25.0          296
#> 1443                  15        178:11                6      26.7          272
#> 1444                 201        109:01               26      29.1          224
#> 1445                 247         97:40               39      28.8          229
#> 1446                  58        145:40               10      18.4          357
#> 1447                 146        117:21               17      28.4          234
#> 1448                 224         99:00               36      23.5          324
#> 1449                 248         94:04               45      23.8          318
#> 1450                  89        130:09               11      35.4           86
#> 1451                 338         65:47              109      29.3          219
#> 1452                 320         70:56               99      40.4           18
#> 1453                  74        128:29               12      32.7          132
#> 1454                 172        103:54               32      17.3          359
#> 1455                 211         94:26               44      34.0          114
#> 1456                   9        159:09                8      26.4          276
#> 1457                 270         81:00               67      33.3          129
#> 1458                 294         76:02               81      24.4          303
#> 1459                  61        125:36               15      30.6          185
#> 1460                 309         68:59              104      27.0          265
#> 1461                   2        179:39                5      29.4          218
#> 1462                 284         74:10               87      38.9           34
#> 1463                 349         48:32              169      31.2          170
#> 1464                 223         84:19               62      30.5          189
#> 1465                 327         60:39              126      36.2           70
#> 1466                  70        114:25               19      24.3          305
#> 1467                 285         70:53              100      34.5          102
#> 1468                  54        117:39               16      25.2          292
#> 1469                  78        109:25               24      27.6          249
#> 1470                 329         58:28              133      27.4          255
#> 1471                  73        109:57               22      24.8          298
#> 1472                 151         91:21               48      37.6           49
#> 1473                 179         86:43               54      31.2          171
#> 1474                 107        100:31               34      29.0          225
#> 1475                  59        110:14               21      30.0          195
#> 1476                  45        115:45               18      26.7          273
#> 1477                  18        127:46               13      33.8          117
#> 1478                 221         77:14               76      40.2           19
#> 1479                 105         99:06               35      23.6          321
#> 1480                 234         74:25               85      38.0           45
#> 1481                 362         24:27              292      26.4          277
#> 1482                 236         74:08               88      21.9          337
#> 1483                  68        106:54               29      35.2           90
#> 1484                 303         62:01              120      20.3          352
#> 1485                 361         32:52              247      13.8          362
#> 1486                 152         85:56               58      20.4          351
#> 1487                 340         49:20              165      43.3            7
#> 1488                  51        108:52               27      28.3          239
#> 1489                 127         90:26               49      29.6          210
#> 1490                 154         84:44               60      32.2          145
#> 1491                 350         41:43              203      36.1           71
#> 1492                 261         67:21              108      29.7          204
#> 1493                 136         87:07               53      43.3            8
#> 1494                  76         98:17               37      30.8          181
#> 1495                 191         76:49               78      40.0           21
#> 1496                  75         97:39               40      35.0           92
#> 1497                  35        109:03               25      35.2           91
#> 1498                 275         63:13              116      30.7          183
#> 1499                 345         41:21              205      29.2          223
#> 1500                 237         67:43              106      27.0          267
#> 1501                 356         36:22              225      29.7          203
#> 1502                  33        107:07               28      32.3          140
#> 1503                 262         63:27              114      24.1          310
#> 1504                  96         89:37               50      34.3          107
#> 1505                 162         77:44               75      24.3          306
#> 1506                 120         85:20               59      24.7          300
#> 1507                  63         96:52               41      36.8           59
#> 1508                  99         88:55               51      32.3          141
#> 1509                  29        106:14               30      24.8          297
#> 1510                 142         80:40               69      34.5          101
#> 1511                  30        105:47               31      25.4          291
#> 1512                 106         86:38               55      27.2          264
#> 1513                 115         84:39               61      27.4          258
#> 1514                  93         88:38               52      38.0           44
#> 1515                 306         54:13              151      26.2          279
#> 1516                 208         69:15              103      34.6          100
#> 1517                 282         58:31              132      31.8          153
#> 1518                 168         75:25               82      29.7          206
#> 1519                 253         61:23              123      35.4           87
#> 1520                 358         31:39              252      22.9          330
#> 1521                 175         72:52               92      29.6          209
#> 1522                 244         62:11              119      20.4          350
#> 1523                 228         64:23              112      24.8          299
#> 1524                 121         80:40               70      34.3          105
#> 1525                  64         91:42               47      27.5          250
#> 1526                 124         80:22               71      24.0          314
#> 1527                 119         80:46               68      36.4           65
#> 1528                  83         86:02               57      29.0          226
#> 1529                 163         72:42               94      21.1          346
#> 1530                  80         86:06               56      22.0          335
#> 1531                 292         54:18              149      29.9          196
#> 1532                 131         77:01               77      25.0          294
#> 1533                 334         44:02              189      33.3          126
#> 1534                  25        101:24               33      31.4          162
#> 1535                 286         53:47              152      29.5          211
#> 1536                 344         38:04              217      30.5          187
#> 1537                 204         64:11              113      35.4           85
#> 1538                  79         83:34               63      34.8           96
#> 1539                  97         79:42               73      20.5          349
#> 1540                 140         72:10               95      39.8           23
#> 1541                 209         61:24              122      36.3           67
#> 1542                 289         51:30              157      31.7          155
#> 1543                 249         56:24              139      27.6          246
#> 1544                 257         55:37              144      23.8          317
#> 1545                 324         44:00              190      36.0           73
#> 1546                  69         83:07               64      16.9          360
#> 1547                 103         76:43               79      31.1          172
#> 1548                 314         47:01              174      41.0           15
#> 1549                 318         44:49              186      39.8           24
#> 1550                 205         60:43              125      32.4          137
#> 1551                 222         58:19              134      37.0           57
#> 1552                 147         67:23              107      31.2          167
#> 1553                 288         49:27              164      27.8          244
#> 1554                 243         54:49              147      29.4          215
#> 1555                 186         61:16              124      19.6          354
#> 1556                 171         62:48              117      27.3          263
#> 1557                 148         65:29              111      33.6          120
#> 1558                 197         58:40              131      29.4          216
#> 1559                 169         62:21              118      34.6           99
#> 1560                 297         46:15              180      41.1           14
#> 1561                 139         65:35              110      25.8          285
#> 1562                  81         72:55               91      28.2          240
#> 1563                 326         39:58              211      24.1          312
#> 1564                  44         80:15               72      29.8          200
#> 1565                  90         70:40              101      34.3          108
#> 1566                  50         78:25               74      32.2          146
#> 1567                  56         75:11               83      21.4          343
#> 1568                  62         74:13               86      31.8          154
#> 1569                 269         46:44              175      33.4          125
#> 1570                 330         37:41              218      24.3          307
#> 1571                  57         73:51               89      30.1          193
#> 1572                  26         82:49               65      30.7          182
#> 1573                   4         95:48               43      44.8            3
#> 1574                 145         60:10              127      33.6          122
#> 1575                 122         63:19              115      31.2          168
#> 1576                  42         76:26               80      29.0          227
#> 1577                  55         72:45               93      27.5          252
#> 1578                 128         61:51              121      35.5           82
#> 1579                 300         41:44              202      34.4          104
#> 1580                 190         54:17              150      24.1          311
#> 1581                 281         43:11              194      24.0          313
#> 1582                 283         42:43              196      27.6          247
#> 1583                 214         49:41              163      16.7          361
#> 1584                 259         45:25              185      31.9          151
#> 1585                 159         56:00              142      33.4          124
#> 1586                 332         34:28              236      23.9          316
#> 1587                 277         43:09              195      29.9          197
#> 1588                 343         30:29              261      21.2          345
#> 1589                  41         73:10               90      31.1          174
#> 1590                  60         68:37              105      26.9          269
#> 1591                 188         52:05              154      23.5          325
#> 1592                 227         47:19              172      33.7          118
#> 1593                 293         40:21              209      24.1          309
#> 1594                 137         56:44              137      19.8          353
#> 1595                 118         58:57              130      21.0          347
#> 1596                  39         71:48               96      27.0          266
#> 1597                 235         45:35              184      27.4          259
#> 1598                   3         91:55               46      32.3          143
#> 1599                 176         50:57              160      27.8          245
#> 1600                 219         46:12              181      23.7          319
#> 1601                 194         48:37              168      44.2            6
#> 1602                 353         24:35              289      36.8           58
#> 1603                 276         40:01              210      28.4          235
#> 1604                 156         51:41              156      32.6          134
#> 1605                 173         49:46              162      27.5          253
#> 1606                 125         55:06              146      39.6           30
#> 1607                 144         52:21              153      32.3          142
#> 1608                   5         81:09               66      31.1          173
#> 1609                  95         57:24              135      29.6          208
#> 1610                 304         35:31              230      36.1           72
#> 1611                 229         42:37              197      30.5          186
#> 1612                 161         49:06              166      32.2          144
#> 1613                 206         44:45              187      27.3          261
#> 1614                 189         46:29              178      27.4          256
#> 1615                 187         46:31              176      39.7           27
#> 1616                  88         56:59              136      28.6          232
#> 1617                 141         51:01              159      31.4          163
#> 1618                 181         46:28              179      38.4           38
#> 1619                 302         34:34              234      28.7          230
#> 1620                   7         74:25               84      32.1          148
#> 1621                 220         42:06              200      32.4          139
#> 1622                 199         43:32              192      22.8          331
#> 1623                  11         71:25               98      41.6           12
#> 1624                 225         40:50              208      42.0           10
#> 1625                 264         37:14              219      23.1          328
#> 1626                  12         69:50              102      29.5          213
#> 1627                 242         38:49              214      34.9           95
#> 1628                 166         45:45              183      26.0          282
#> 1629                 359         18:19              319      19.4          355
#> 1630                 274         35:30              231      22.6          332
#> 1631                 255         37:03              221      33.3          127
#> 1632                   6         71:43               97      33.8          116
#> 1633                 170         44:20              188      36.5           63
#> 1634                  32         59:59              128      31.0          177
#> 1635                 287         33:19              244      32.4          138
#> 1636                 335         26:56              278      32.6          135
#> 1637                 268         34:16              238      38.4           39
#> 1638                 298         31:31              253      37.9           47
#> 1639                 351         20:59              307      25.1          293
#> 1640                 263         34:04              240      35.7           79
#> 1641                  53         54:45              148      37.2           54
#> 1642                 117         46:29              177      34.4          103
#> 1643                 155         42:08              199      21.3          344
#> 1644                  24         59:50              129      35.4           84
#> 1645                 158         41:52              201      38.3           40
#> 1646                 278         32:15              250      20.8          348
#> 1647                  92         48:03              170      21.9          338
#> 1648                 138         43:41              191      32.1          149
#> 1649                 308         29:12              266      30.2          192
#> 1650                 150         41:28              204      28.3          237
#> 1651                 360         15:57              327      35.6           80
#> 1652                  84         47:18              173      33.4          123
#> 1653                 352         19:42              311      27.4          260
#> 1654                 203         36:24              224      32.8          131
#> 1655                 195         37:03              220      26.7          271
#> 1656                 143         40:57              207      36.3           68
#> 1657                 307         27:38              273      36.4           66
#> 1658                  22         56:11              140      24.3          308
#> 1659                  71         47:26              171      32.7          133
#> 1660                  17         56:37              138      35.9           76
#> 1661                 267         30:37              259      42.6            9
#> 1662                  47         50:31              161      38.2           43
#> 1663                 109         43:15              193      26.8          270
#> 1664                 310         26:58              276      31.4          161
#> 1665                  31         51:55              155      34.2          109
#> 1666                 321         25:05              285      21.7          341
#> 1667                 346         19:31              313      33.3          128
#> 1668                  16         55:29              145      39.7           26
#> 1669                 182         36:06              226      19.2          356
#> 1670                 299         27:22              274      31.2          166
#> 1671                  13         56:03              141      38.3           41
#> 1672                  14         55:52              143      31.6          157
#> 1673                 164         36:45              223      21.8          340
#> 1674                 177         35:44              228      30.8          179
#> 1675                 193         34:18              237      50.0            1
#> 1676                 251         30:00              262      29.2          221
#> 1677                 339         21:11              306      32.1          150
#> 1678                  52         45:49              182      30.4          190
#> 1679                  19         51:14              158      30.6          184
#> 1680                  28         49:03              167      31.5          159
#> 1681                 260         27:58              272      27.3          262
#> 1682                 192         32:22              249      30.0          194
#> 1683                  65         42:15              198      33.7          119
#> 1684                 102         38:36              215      35.8           77
#> 1685                 160         34:02              241      38.5           35
#> 1686                 135         35:33              229      24.7          301
#> 1687                 295         24:53              286      27.4          257
#> 1688                 336         19:57              310      29.4          217
#> 1689                  66         41:03              206      35.5           83
#> 1690                 178         32:01              251      23.0          329
#> 1691                 110         36:47              222      29.8          199
#> 1692                 290         24:13              293      28.5          233
#> 1693                 256         26:11              280      26.4          275
#> 1694                 312         22:08              301      33.1          130
#> 1695                  72         38:28              216      27.0          268
#> 1696                 116         34:52              232      30.9          178
#> 1697                 357         13:56              334      38.4           37
#> 1698                 184         29:48              264      39.1           33
#> 1699                 272         24:30              291      34.2          110
#> 1700                 246         25:50              282      30.8          180
#> 1701                 196         28:51              267      27.5          251
#> 1702                 114         34:08              239      29.8          201
#> 1703                 333         19:08              314      21.9          339
#> 1704                 129         32:54              245      34.1          113
#> 1705                 100         34:49              233      37.4           52
#> 1706                 311         21:22              304      29.4          214
#> 1707                 200         28:01              270      29.5          212
#> 1708                 315         20:55              308      18.1          358
#> 1709                 241         24:43              288      37.5           51
#> 1710                 153         29:19              265      24.0          315
#> 1711                 233         24:32              290      24.5          302
#> 1712                 126         30:42              258      37.4           53
#> 1713                 279         21:53              303      22.2          334
#> 1714                  91         32:54              246      39.3           32
#> 1715                 167         27:58              271      29.7          205
#> 1716                 108         31:28              254      26.2          280
#> 1717                 130         29:56              263      25.8          284
#> 1718                 165         27:09              275      36.7           60
#> 1719                 254         22:18              300      27.5          254
#> 1720                  23         38:52              213      44.4            5
#> 1721                  94         30:55              257      29.8          198
#> 1722                  20         38:52              212      28.0          243
#> 1723                  38         35:57              227      44.7            4
#> 1724                  86         31:09              256      28.1          242
#> 1725                 217         23:34              295      31.0          175
#> 1726                 250         22:00              302      32.5          136
#> 1727                 231         22:50              298      34.1          112
#> 1728                 301         18:59              315      40.5           17
#> 1729                 258         21:19              305      36.5           64
#> 1730                  43         34:30              235      35.4           88
#> 1731                  67         31:13              255      31.3          164
#> 1732                 101         28:45              268      29.6          207
#> 1733                 218         22:18              299      30.3          191
#> 1734                  37         33:39              242      37.5           50
#> 1735                  48         32:34              248      25.4          290
#> 1736                 132         26:04              281      31.8          152
#> 1737                 111         26:55              279      25.6          289
#> 1738                  98         26:57              277      41.0           16
#> 1739                 266         18:40              317      29.2          220
#> 1740                 355         10:52              342      39.8           25
#> 1741                  40         30:32              260      29.8          202
#> 1742                 213         20:12              309      34.9           94
#> 1743                 133         23:27              297      37.7           48
#> 1744                  10         33:32              243      23.4          326
#> 1745                  85         25:45              283      36.6           62
#> 1746                 123         23:29              296      38.3           42
#> 1747                  82         25:16              284      26.6          274
#> 1748                 240         18:05              320      41.9           11
#> 1749                 202         19:33              312      39.7           28
#> 1750                  87         24:11              294      36.0           74
#> 1751                 273         16:12              325      25.8          286
#> 1752                 265         15:33              330      39.4           31
#> 1753                 226         16:43              323      25.9          283
#> 1754                 232         16:19              324      33.6          121
#> 1755                  46         24:46              287      49.5            2
#> 1756                 238         15:45              329      28.9          228
#> 1757                   8         28:32              269      37.1           56
#> 1758                 319         12:15              337      31.5          158
#> 1759                 185         17:16              321      28.3          238
#> 1760                 216         16:02              326      31.6          156
#> 1761                 337         10:44              343      28.4          236
#> 1762                 252         14:43              332      23.6          323
#> 1763                 210         15:51              328      31.2          165
#> 1764                 134         18:20              318      34.7           97
#> 1765                 323         11:13              340      41.3           13
#> 1766                 341          9:50              344      38.5           36
#> 1767                 157         17:01              322      31.0          176
#> 1768                 354          7:47              349      32.2          147
#> 1769                 291         12:10              338      36.3           69
#> 1770                 212         14:21              333      26.4          278
#> 1771                 328          9:24              346      34.0          115
#> 1772                 342          8:07              348      22.0          336
#> 1773                 207         12:46              336      36.7           61
#> 1774                  34         18:42              316      34.3          106
#> 1775                 215         11:52              339      29.2          222
#> 1776                 316          9:08              347      37.9           46
#> 1777                 112         14:49              331      40.2           20
#> 1778                 149         12:53              335      37.2           55
#> 1779                 239          9:41              345      23.2          327
#> 1780                 313          7:20              350      35.3           89
#> 1781                 113         11:06              341      35.8           78
#> 1782                 347          4:54              356      28.7          231
#> 1783                 296          6:23              351      34.7           98
#> 1784                 325          5:06              353      25.6          288
#> 1785                 322          5:05              354      27.6          248
#> 1786                 198          5:20              352      30.5          188
#> 1787                 348          2:36              359      34.1          111
#> 1788                 174          5:00              355      26.1          281
#> 1789                 271          3:38              357      31.2          169
#> 1790                 280          2:06              360      22.3          333
#> 1791                 331          1:35              361      40.0           22
#> 1792                 104          2:44              358      39.6           29
#> 1793                 183          1:24              362      36.0           75
#>      NCAA_Seed Year
#> 1           NA 2020
#> 2           NA 2020
#> 3           NA 2020
#> 4           15 2020
#> 5           NA 2020
#> 6           NA 2020
#> 7           NA 2020
#> 8           NA 2020
#> 9           NA 2020
#> 10          15 2020
#> 11          NA 2020
#> 12          NA 2020
#> 13          NA 2020
#> 14          NA 2020
#> 15          NA 2020
#> 16          NA 2020
#> 17          NA 2020
#> 18          NA 2020
#> 19          NA 2020
#> 20          NA 2020
#> 21          15 2020
#> 22          NA 2020
#> 23          NA 2020
#> 24          NA 2020
#> 25          NA 2020
#> 26          NA 2020
#> 27          NA 2020
#> 28          NA 2020
#> 29          NA 2020
#> 30          NA 2020
#> 31          NA 2020
#> 32          NA 2020
#> 33          NA 2020
#> 34          NA 2020
#> 35          NA 2020
#> 36          NA 2020
#> 37          NA 2020
#> 38          NA 2020
#> 39          NA 2020
#> 40          NA 2020
#> 41          10 2020
#> 42          NA 2020
#> 43          NA 2020
#> 44          NA 2020
#> 45          NA 2020
#> 46          NA 2020
#> 47          NA 2020
#> 48          NA 2020
#> 49          NA 2020
#> 50          NA 2020
#> 51          NA 2020
#> 52          NA 2020
#> 53          NA 2020
#> 54          NA 2020
#> 55          16 2020
#> 56          NA 2020
#> 57          NA 2020
#> 58          NA 2020
#> 59           1 2020
#> 60          NA 2020
#> 61          16 2020
#> 62          NA 2020
#> 63          NA 2020
#> 64          NA 2020
#> 65          NA 2020
#> 66          NA 2020
#> 67          NA 2020
#> 68          13 2020
#> 69          NA 2020
#> 70          NA 2020
#> 71          NA 2020
#> 72           8 2020
#> 73          NA 2020
#> 74          NA 2020
#> 75          NA 2020
#> 76          NA 2020
#> 77          NA 2020
#> 78          NA 2020
#> 79          NA 2020
#> 80          NA 2020
#> 81          NA 2020
#> 82          NA 2020
#> 83          NA 2020
#> 84          NA 2020
#> 85          NA 2020
#> 86          NA 2020
#> 87          NA 2020
#> 88          NA 2020
#> 89          NA 2020
#> 90          11 2020
#> 91          NA 2020
#> 92          NA 2020
#> 93          NA 2020
#> 94          NA 2020
#> 95          NA 2020
#> 96           5 2020
#> 97          NA 2020
#> 98          NA 2020
#> 99          NA 2020
#> 100         NA 2020
#> 101         NA 2020
#> 102         NA 2020
#> 103         NA 2020
#> 104         16 2020
#> 105         NA 2020
#> 106         NA 2020
#> 107         NA 2020
#> 108         NA 2020
#> 109         NA 2020
#> 110          1 2020
#> 111         NA 2020
#> 112         NA 2020
#> 113         NA 2020
#> 114         NA 2020
#> 115          2 2020
#> 116         NA 2020
#> 117         NA 2020
#> 118         NA 2020
#> 119         NA 2020
#> 120         NA 2020
#> 121          8 2020
#> 122         NA 2020
#> 123         NA 2020
#> 124         NA 2020
#> 125         NA 2020
#> 126         NA 2020
#> 127         NA 2020
#> 128          5 2020
#> 129         NA 2020
#> 130         NA 2020
#> 131         NA 2020
#> 132         NA 2020
#> 133         NA 2020
#> 134         NA 2020
#> 135         NA 2020
#> 136         NA 2020
#> 137         NA 2020
#> 138         NA 2020
#> 139         NA 2020
#> 140         NA 2020
#> 141         NA 2020
#> 142         NA 2020
#> 143         NA 2020
#> 144         NA 2020
#> 145         NA 2020
#> 146         NA 2020
#> 147         NA 2020
#> 148         NA 2020
#> 149         NA 2020
#> 150          2 2020
#> 151         NA 2020
#> 152         NA 2020
#> 153         NA 2020
#> 154         NA 2020
#> 155         NA 2020
#> 156         NA 2020
#> 157         NA 2020
#> 158         NA 2020
#> 159         NA 2020
#> 160          3 2020
#> 161          5 2020
#> 162         11 2020
#> 163          3 2020
#> 164          8 2020
#> 165         NA 2020
#> 166         NA 2020
#> 167         NA 2020
#> 168         13 2020
#> 169          1 2020
#> 170         NA 2020
#> 171         NA 2020
#> 172         NA 2020
#> 173         NA 2020
#> 174         13 2020
#> 175         NA 2020
#> 176         16 2020
#> 177         NA 2020
#> 178         10 2020
#> 179         NA 2020
#> 180          7 2020
#> 181         NA 2020
#> 182         NA 2020
#> 183         16 2020
#> 184         NA 2020
#> 185         NA 2020
#> 186         NA 2020
#> 187         NA 2020
#> 188         NA 2020
#> 189         NA 2020
#> 190          4 2020
#> 191         NA 2020
#> 192         NA 2020
#> 193         NA 2020
#> 194         NA 2020
#> 195         NA 2020
#> 196         NA 2020
#> 197         NA 2020
#> 198         NA 2020
#> 199          1 2020
#> 200         NA 2020
#> 201          6 2020
#> 202         NA 2020
#> 203         NA 2020
#> 204         NA 2020
#> 205         NA 2020
#> 206         NA 2020
#> 207         NA 2020
#> 208         NA 2020
#> 209         NA 2020
#> 210         NA 2020
#> 211         NA 2020
#> 212         NA 2020
#> 213         NA 2020
#> 214         14 2020
#> 215         NA 2020
#> 216          4 2020
#> 217         NA 2020
#> 218         NA 2020
#> 219         NA 2020
#> 220         NA 2020
#> 221         NA 2020
#> 222         NA 2020
#> 223         NA 2020
#> 224         NA 2020
#> 225         14 2020
#> 226         NA 2020
#> 227         NA 2020
#> 228         NA 2020
#> 229         NA 2020
#> 230         NA 2020
#> 231         NA 2020
#> 232         NA 2020
#> 233         NA 2020
#> 234         NA 2020
#> 235         NA 2020
#> 236         NA 2020
#> 237         11 2020
#> 238         NA 2020
#> 239          5 2020
#> 240         NA 2020
#> 241         NA 2020
#> 242         NA 2020
#> 243         NA 2020
#> 244         NA 2020
#> 245         NA 2020
#> 246         12 2020
#> 247         NA 2020
#> 248         NA 2020
#> 249         NA 2020
#> 250         NA 2020
#> 251         10 2020
#> 252         NA 2020
#> 253         NA 2020
#> 254         NA 2020
#> 255         NA 2020
#> 256          4 2020
#> 257         11 2020
#> 258         12 2020
#> 259         NA 2020
#> 260         NA 2020
#> 261         NA 2020
#> 262         NA 2020
#> 263         NA 2020
#> 264         NA 2020
#> 265         NA 2020
#> 266          9 2020
#> 267         NA 2020
#> 268         NA 2020
#> 269          3 2020
#> 270         NA 2020
#> 271         NA 2020
#> 272         NA 2020
#> 273         NA 2020
#> 274         NA 2020
#> 275         NA 2020
#> 276         NA 2020
#> 277         NA 2020
#> 278         NA 2020
#> 279         NA 2020
#> 280          4 2020
#> 281         NA 2020
#> 282         12 2020
#> 283         16 2020
#> 284         NA 2020
#> 285         NA 2020
#> 286         NA 2020
#> 287          2 2020
#> 288         10 2020
#> 289          9 2020
#> 290         NA 2020
#> 291         NA 2020
#> 292          6 2020
#> 293         NA 2020
#> 294         NA 2020
#> 295         NA 2020
#> 296         NA 2020
#> 297         NA 2020
#> 298         NA 2020
#> 299         NA 2020
#> 300          6 2020
#> 301         NA 2020
#> 302         NA 2020
#> 303         NA 2020
#> 304         NA 2020
#> 305         NA 2020
#> 306         NA 2020
#> 307         NA 2020
#> 308         NA 2020
#> 309         NA 2020
#> 310         NA 2020
#> 311         NA 2020
#> 312         NA 2020
#> 313         NA 2020
#> 314         14 2020
#> 315          9 2020
#> 316         NA 2020
#> 317         NA 2020
#> 318         12 2020
#> 319          8 2020
#> 320         NA 2020
#> 321         NA 2020
#> 322         NA 2020
#> 323         NA 2020
#> 324         NA 2020
#> 325         NA 2020
#> 326         NA 2020
#> 327          7 2020
#> 328         NA 2020
#> 329          7 2020
#> 330         NA 2020
#> 331          7 2020
#> 332         NA 2020
#> 333         NA 2020
#> 334         NA 2020
#> 335         13 2020
#> 336          9 2020
#> 337         15 2020
#> 338         11 2020
#> 339          6 2020
#> 340         NA 2020
#> 341          2 2020
#> 342         14 2020
#> 343         NA 2020
#> 344         NA 2020
#> 345         NA 2020
#> 346         NA 2020
#> 347         NA 2020
#> 348         NA 2020
#> 349         NA 2020
#> 350         11 2020
#> 351         NA 2020
#> 352          3 2020
#> 353         NA 2020
#> 354         NA 2021
#> 355         NA 2021
#> 356         NA 2021
#> 357         NA 2021
#> 358         NA 2021
#> 359         NA 2021
#> 360         NA 2021
#> 361         NA 2021
#> 362         NA 2021
#> 363         NA 2021
#> 364         NA 2021
#> 365         NA 2021
#> 366          9 2021
#> 367         NA 2021
#> 368         NA 2021
#> 369         NA 2021
#> 370         NA 2021
#> 371         NA 2021
#> 372         NA 2021
#> 373         11 2021
#> 374         NA 2021
#> 375         NA 2021
#> 376         NA 2021
#> 377         15 2021
#> 378         NA 2021
#> 379         NA 2021
#> 380         NA 2021
#> 381         NA 2021
#> 382         NA 2021
#> 383         NA 2021
#> 384         NA 2021
#> 385         NA 2021
#> 386         NA 2021
#> 387         NA 2021
#> 388         NA 2021
#> 389         NA 2021
#> 390         NA 2021
#> 391         NA 2021
#> 392         NA 2021
#> 393         NA 2021
#> 394         15 2021
#> 395         NA 2021
#> 396         NA 2021
#> 397         NA 2021
#> 398         NA 2021
#> 399         NA 2021
#> 400         NA 2021
#> 401         16 2021
#> 402         NA 2021
#> 403         NA 2021
#> 404         NA 2021
#> 405         NA 2021
#> 406         NA 2021
#> 407         NA 2021
#> 408         NA 2021
#> 409         NA 2021
#> 410         NA 2021
#> 411         NA 2021
#> 412         NA 2021
#> 413         NA 2021
#> 414         NA 2021
#> 415         NA 2021
#> 416         NA 2021
#> 417         NA 2021
#> 418         NA 2021
#> 419         NA 2021
#> 420         NA 2021
#> 421         NA 2021
#> 422         NA 2021
#> 423         NA 2021
#> 424         NA 2021
#> 425         NA 2021
#> 426         NA 2021
#> 427         14 2021
#> 428         NA 2021
#> 429         NA 2021
#> 430         NA 2021
#> 431          9 2021
#> 432         NA 2021
#> 433         NA 2021
#> 434         13 2021
#> 435         NA 2021
#> 436         NA 2021
#> 437         NA 2021
#> 438         NA 2021
#> 439         NA 2021
#> 440         NA 2021
#> 441         NA 2021
#> 442         NA 2021
#> 443         NA 2021
#> 444         NA 2021
#> 445         NA 2021
#> 446         NA 2021
#> 447          6 2021
#> 448         NA 2021
#> 449         NA 2021
#> 450         NA 2021
#> 451         NA 2021
#> 452          3 2021
#> 453         13 2021
#> 454         NA 2021
#> 455         NA 2021
#> 456         NA 2021
#> 457         NA 2021
#> 458         NA 2021
#> 459         NA 2021
#> 460          8 2021
#> 461         NA 2021
#> 462         NA 2021
#> 463         NA 2021
#> 464         NA 2021
#> 465         NA 2021
#> 466         NA 2021
#> 467          1 2021
#> 468         NA 2021
#> 469         NA 2021
#> 470         NA 2021
#> 471         NA 2021
#> 472         16 2021
#> 473         NA 2021
#> 474         10 2021
#> 475         NA 2021
#> 476         NA 2021
#> 477         NA 2021
#> 478         NA 2021
#> 479          2 2021
#> 480         NA 2021
#> 481         NA 2021
#> 482         NA 2021
#> 483         NA 2021
#> 484         NA 2021
#> 485         NA 2021
#> 486         NA 2021
#> 487         NA 2021
#> 488         NA 2021
#> 489         NA 2021
#> 490         NA 2021
#> 491         NA 2021
#> 492         NA 2021
#> 493         16 2021
#> 494         NA 2021
#> 495         NA 2021
#> 496         NA 2021
#> 497         NA 2021
#> 498         13 2021
#> 499         NA 2021
#> 500         NA 2021
#> 501         NA 2021
#> 502         NA 2021
#> 503         NA 2021
#> 504          4 2021
#> 505         NA 2021
#> 506         14 2021
#> 507         NA 2021
#> 508         NA 2021
#> 509          8 2021
#> 510         NA 2021
#> 511         NA 2021
#> 512         NA 2021
#> 513          8 2021
#> 514         NA 2021
#> 515         NA 2021
#> 516         NA 2021
#> 517         NA 2021
#> 518         NA 2021
#> 519         NA 2021
#> 520         10 2021
#> 521         NA 2021
#> 522          7 2021
#> 523         NA 2021
#> 524         12 2021
#> 525         NA 2021
#> 526         NA 2021
#> 527         NA 2021
#> 528         NA 2021
#> 529         NA 2021
#> 530         NA 2021
#> 531         NA 2021
#> 532         14 2021
#> 533         NA 2021
#> 534         NA 2021
#> 535         NA 2021
#> 536         11 2021
#> 537         NA 2021
#> 538         NA 2021
#> 539          4 2021
#> 540          2 2021
#> 541         NA 2021
#> 542         NA 2021
#> 543         NA 2021
#> 544         NA 2021
#> 545         NA 2021
#> 546         NA 2021
#> 547         11 2021
#> 548         NA 2021
#> 549         12 2021
#> 550         NA 2021
#> 551         NA 2021
#> 552         NA 2021
#> 553         NA 2021
#> 554         NA 2021
#> 555         NA 2021
#> 556         NA 2021
#> 557         NA 2021
#> 558          1 2021
#> 559         NA 2021
#> 560         NA 2021
#> 561         NA 2021
#> 562         NA 2021
#> 563         NA 2021
#> 564         NA 2021
#> 565         NA 2021
#> 566         NA 2021
#> 567         NA 2021
#> 568         NA 2021
#> 569          3 2021
#> 570         NA 2021
#> 571         NA 2021
#> 572         12 2021
#> 573         NA 2021
#> 574         NA 2021
#> 575         NA 2021
#> 576         NA 2021
#> 577         NA 2021
#> 578         16 2021
#> 579         NA 2021
#> 580          3 2021
#> 581          9 2021
#> 582         NA 2021
#> 583         NA 2021
#> 584         NA 2021
#> 585         NA 2021
#> 586         NA 2021
#> 587         NA 2021
#> 588         NA 2021
#> 589         NA 2021
#> 590         NA 2021
#> 591         NA 2021
#> 592         NA 2021
#> 593         NA 2021
#> 594         NA 2021
#> 595         NA 2021
#> 596         NA 2021
#> 597         NA 2021
#> 598         NA 2021
#> 599         NA 2021
#> 600          3 2021
#> 601         NA 2021
#> 602         NA 2021
#> 603         NA 2021
#> 604         NA 2021
#> 605         NA 2021
#> 606         NA 2021
#> 607         NA 2021
#> 608         10 2021
#> 609         NA 2021
#> 610         NA 2021
#> 611         NA 2021
#> 612         NA 2021
#> 613         NA 2021
#> 614         NA 2021
#> 615         NA 2021
#> 616         NA 2021
#> 617         NA 2021
#> 618         NA 2021
#> 619         NA 2021
#> 620         NA 2021
#> 621         NA 2021
#> 622         NA 2021
#> 623         NA 2021
#> 624         NA 2021
#> 625          6 2021
#> 626         NA 2021
#> 627         NA 2021
#> 628         NA 2021
#> 629         NA 2021
#> 630          7 2021
#> 631         NA 2021
#> 632         NA 2021
#> 633         NA 2021
#> 634          5 2021
#> 635         NA 2021
#> 636         NA 2021
#> 637          1 2021
#> 638         NA 2021
#> 639         NA 2021
#> 640         NA 2021
#> 641         NA 2021
#> 642          6 2021
#> 643          1 2021
#> 644          6 2021
#> 645         NA 2021
#> 646          5 2021
#> 647         NA 2021
#> 648         NA 2021
#> 649         14 2021
#> 650         NA 2021
#> 651         NA 2021
#> 652         NA 2021
#> 653         NA 2021
#> 654          9 2021
#> 655         NA 2021
#> 656         NA 2021
#> 657         10 2021
#> 658         NA 2021
#> 659         NA 2021
#> 660          7 2021
#> 661         NA 2021
#> 662         NA 2021
#> 663          5 2021
#> 664         NA 2021
#> 665         NA 2021
#> 666         NA 2021
#> 667         11 2021
#> 668         16 2021
#> 669          2 2021
#> 670         15 2021
#> 671         NA 2021
#> 672          5 2021
#> 673         NA 2021
#> 674         16 2021
#> 675         NA 2021
#> 676         NA 2021
#> 677         NA 2021
#> 678         15 2021
#> 679         NA 2021
#> 680         NA 2021
#> 681         NA 2021
#> 682         NA 2021
#> 683         NA 2021
#> 684         NA 2021
#> 685         11 2021
#> 686          4 2021
#> 687          8 2021
#> 688         NA 2021
#> 689         NA 2021
#> 690         NA 2021
#> 691         NA 2021
#> 692         NA 2021
#> 693         13 2021
#> 694         NA 2021
#> 695         NA 2021
#> 696         NA 2021
#> 697         NA 2021
#> 698         NA 2021
#> 699         12 2021
#> 700         NA 2021
#> 701         NA 2021
#> 702         NA 2021
#> 703         NA 2021
#> 704         NA 2021
#> 705         NA 2021
#> 706         NA 2021
#> 707          2 2021
#> 708          4 2021
#> 709         11 2021
#> 710          7 2021
#> 711         NA 2022
#> 712         NA 2022
#> 713         NA 2022
#> 714         NA 2022
#> 715         NA 2022
#> 716         NA 2022
#> 717         16 2022
#> 718         NA 2022
#> 719         NA 2022
#> 720         NA 2022
#> 721         NA 2022
#> 722         NA 2022
#> 723         NA 2022
#> 724         NA 2022
#> 725         NA 2022
#> 726         NA 2022
#> 727         NA 2022
#> 728         NA 2022
#> 729         NA 2022
#> 730         NA 2022
#> 731         NA 2022
#> 732         NA 2022
#> 733         10 2022
#> 734         NA 2022
#> 735         NA 2022
#> 736         NA 2022
#> 737         NA 2022
#> 738         NA 2022
#> 739         NA 2022
#> 740         NA 2022
#> 741         NA 2022
#> 742         NA 2022
#> 743         NA 2022
#> 744         NA 2022
#> 745         NA 2022
#> 746         NA 2022
#> 747         NA 2022
#> 748         NA 2022
#> 749         NA 2022
#> 750         NA 2022
#> 751         NA 2022
#> 752         NA 2022
#> 753         NA 2022
#> 754          3 2022
#> 755         NA 2022
#> 756         NA 2022
#> 757         NA 2022
#> 758         NA 2022
#> 759         NA 2022
#> 760         NA 2022
#> 761         NA 2022
#> 762         15 2022
#> 763          1 2022
#> 764         NA 2022
#> 765          8 2022
#> 766         NA 2022
#> 767         NA 2022
#> 768         11 2022
#> 769         NA 2022
#> 770         NA 2022
#> 771          6 2022
#> 772          6 2022
#> 773         13 2022
#> 774         NA 2022
#> 775         NA 2022
#> 776         NA 2022
#> 777         NA 2022
#> 778          5 2022
#> 779         NA 2022
#> 780         NA 2022
#> 781         NA 2022
#> 782         NA 2022
#> 783         NA 2022
#> 784         NA 2022
#> 785          6 2022
#> 786         NA 2022
#> 787         NA 2022
#> 788         NA 2022
#> 789         NA 2022
#> 790         NA 2022
#> 791         NA 2022
#> 792         NA 2022
#> 793         NA 2022
#> 794         NA 2022
#> 795         NA 2022
#> 796         11 2022
#> 797         NA 2022
#> 798         NA 2022
#> 799         NA 2022
#> 800          7 2022
#> 801          8 2022
#> 802         NA 2022
#> 803         NA 2022
#> 804         NA 2022
#> 805         NA 2022
#> 806         NA 2022
#> 807         NA 2022
#> 808          2 2022
#> 809         NA 2022
#> 810         NA 2022
#> 811         NA 2022
#> 812         NA 2022
#> 813         NA 2022
#> 814         NA 2022
#> 815         NA 2022
#> 816         14 2022
#> 817         NA 2022
#> 818         NA 2022
#> 819         NA 2022
#> 820         NA 2022
#> 821         NA 2022
#> 822         NA 2022
#> 823         NA 2022
#> 824          4 2022
#> 825         NA 2022
#> 826         NA 2022
#> 827         NA 2022
#> 828         NA 2022
#> 829          5 2022
#> 830         NA 2022
#> 831         NA 2022
#> 832         11 2022
#> 833         NA 2022
#> 834         NA 2022
#> 835         NA 2022
#> 836         NA 2022
#> 837         NA 2022
#> 838         NA 2022
#> 839         NA 2022
#> 840         NA 2022
#> 841         NA 2022
#> 842         NA 2022
#> 843         NA 2022
#> 844         NA 2022
#> 845         NA 2022
#> 846         NA 2022
#> 847         NA 2022
#> 848         NA 2022
#> 849         NA 2022
#> 850         NA 2022
#> 851         NA 2022
#> 852         NA 2022
#> 853         NA 2022
#> 854         NA 2022
#> 855         NA 2022
#> 856         15 2022
#> 857         NA 2022
#> 858         NA 2022
#> 859         NA 2022
#> 860         NA 2022
#> 861         NA 2022
#> 862         NA 2022
#> 863         NA 2022
#> 864         NA 2022
#> 865         NA 2022
#> 866         NA 2022
#> 867         NA 2022
#> 868         NA 2022
#> 869         NA 2022
#> 870         NA 2022
#> 871         NA 2022
#> 872         NA 2022
#> 873         16 2022
#> 874         NA 2022
#> 875         NA 2022
#> 876         NA 2022
#> 877         NA 2022
#> 878         NA 2022
#> 879         NA 2022
#> 880          8 2022
#> 881         NA 2022
#> 882         NA 2022
#> 883         NA 2022
#> 884         16 2022
#> 885         14 2022
#> 886          9 2022
#> 887         NA 2022
#> 888         13 2022
#> 889         NA 2022
#> 890         NA 2022
#> 891         NA 2022
#> 892         NA 2022
#> 893         NA 2022
#> 894         NA 2022
#> 895         NA 2022
#> 896         NA 2022
#> 897         NA 2022
#> 898         NA 2022
#> 899         NA 2022
#> 900         NA 2022
#> 901         NA 2022
#> 902         NA 2022
#> 903          1 2022
#> 904         NA 2022
#> 905         NA 2022
#> 906         NA 2022
#> 907         NA 2022
#> 908         NA 2022
#> 909          9 2022
#> 910         NA 2022
#> 911         NA 2022
#> 912         NA 2022
#> 913         NA 2022
#> 914         NA 2022
#> 915         NA 2022
#> 916         NA 2022
#> 917         NA 2022
#> 918         NA 2022
#> 919         NA 2022
#> 920         NA 2022
#> 921         NA 2022
#> 922         NA 2022
#> 923         NA 2022
#> 924         NA 2022
#> 925         NA 2022
#> 926         NA 2022
#> 927         NA 2022
#> 928         NA 2022
#> 929         NA 2022
#> 930          6 2022
#> 931          9 2022
#> 932         NA 2022
#> 933         NA 2022
#> 934          7 2022
#> 935         NA 2022
#> 936         NA 2022
#> 937         NA 2022
#> 938         NA 2022
#> 939         NA 2022
#> 940          9 2022
#> 941         13 2022
#> 942         NA 2022
#> 943          2 2022
#> 944         NA 2022
#> 945         NA 2022
#> 946         NA 2022
#> 947         NA 2022
#> 948         NA 2022
#> 949         NA 2022
#> 950         NA 2022
#> 951         NA 2022
#> 952         NA 2022
#> 953         NA 2022
#> 954         NA 2022
#> 955         11 2022
#> 956         NA 2022
#> 957          1 2022
#> 958         NA 2022
#> 959          4 2022
#> 960         NA 2022
#> 961         NA 2022
#> 962         NA 2022
#> 963         NA 2022
#> 964         NA 2022
#> 965         NA 2022
#> 966         NA 2022
#> 967         NA 2022
#> 968         NA 2022
#> 969         NA 2022
#> 970         NA 2022
#> 971         NA 2022
#> 972         NA 2022
#> 973         NA 2022
#> 974         NA 2022
#> 975         NA 2022
#> 976         NA 2022
#> 977         NA 2022
#> 978          4 2022
#> 979         12 2022
#> 980          7 2022
#> 981         NA 2022
#> 982         NA 2022
#> 983         NA 2022
#> 984         NA 2022
#> 985          3 2022
#> 986          4 2022
#> 987         NA 2022
#> 988         NA 2022
#> 989         NA 2022
#> 990         16 2022
#> 991         NA 2022
#> 992         10 2022
#> 993         NA 2022
#> 994         NA 2022
#> 995         NA 2022
#> 996         NA 2022
#> 997         NA 2022
#> 998         NA 2022
#> 999         NA 2022
#> 1000        NA 2022
#> 1001        NA 2022
#> 1002        NA 2022
#> 1003        NA 2022
#> 1004        NA 2022
#> 1005        NA 2022
#> 1006         8 2022
#> 1007        NA 2022
#> 1008        NA 2022
#> 1009         3 2022
#> 1010        NA 2022
#> 1011        14 2022
#> 1012        NA 2022
#> 1013         2 2022
#> 1014         1 2022
#> 1015        NA 2022
#> 1016        NA 2022
#> 1017        NA 2022
#> 1018        NA 2022
#> 1019         5 2022
#> 1020         7 2022
#> 1021        NA 2022
#> 1022        NA 2022
#> 1023        NA 2022
#> 1024        NA 2022
#> 1025        NA 2022
#> 1026        13 2022
#> 1027        NA 2022
#> 1028        16 2022
#> 1029        NA 2022
#> 1030        NA 2022
#> 1031        NA 2022
#> 1032        10 2022
#> 1033        NA 2022
#> 1034        NA 2022
#> 1035        NA 2022
#> 1036        NA 2022
#> 1037        12 2022
#> 1038         3 2022
#> 1039         2 2022
#> 1040        NA 2022
#> 1041         5 2022
#> 1042        NA 2022
#> 1043        NA 2022
#> 1044        12 2022
#> 1045        14 2022
#> 1046        NA 2022
#> 1047        NA 2022
#> 1048        11 2022
#> 1049        NA 2022
#> 1050        NA 2022
#> 1051        12 2022
#> 1052        16 2022
#> 1053        NA 2022
#> 1054        NA 2022
#> 1055        NA 2022
#> 1056        NA 2022
#> 1057        NA 2022
#> 1058        NA 2022
#> 1059        NA 2022
#> 1060        NA 2022
#> 1061        12 2022
#> 1062        NA 2022
#> 1063        15 2022
#> 1064        15 2022
#> 1065        NA 2022
#> 1066        10 2022
#> 1067        NA 2022
#> 1068        NA 2022
#> 1069        NA 2023
#> 1070        NA 2023
#> 1071        NA 2023
#> 1072        NA 2023
#> 1073        NA 2023
#> 1074        NA 2023
#> 1075        NA 2023
#> 1076        NA 2023
#> 1077        16 2023
#> 1078        NA 2023
#> 1079        NA 2023
#> 1080        NA 2023
#> 1081        NA 2023
#> 1082        16 2023
#> 1083        NA 2023
#> 1084        NA 2023
#> 1085        NA 2023
#> 1086        NA 2023
#> 1087        NA 2023
#> 1088        NA 2023
#> 1089        14 2023
#> 1090        NA 2023
#> 1091        16 2023
#> 1092        NA 2023
#> 1093        NA 2023
#> 1094        NA 2023
#> 1095        NA 2023
#> 1096        NA 2023
#> 1097        NA 2023
#> 1098        NA 2023
#> 1099        NA 2023
#> 1100         5 2023
#> 1101        NA 2023
#> 1102        NA 2023
#> 1103        NA 2023
#> 1104        NA 2023
#> 1105        NA 2023
#> 1106        NA 2023
#> 1107        NA 2023
#> 1108        NA 2023
#> 1109        NA 2023
#> 1110         6 2023
#> 1111        NA 2023
#> 1112         8 2023
#> 1113        NA 2023
#> 1114        NA 2023
#> 1115         3 2023
#> 1116         3 2023
#> 1117        NA 2023
#> 1118        10 2023
#> 1119        NA 2023
#> 1120        NA 2023
#> 1121        NA 2023
#> 1122        NA 2023
#> 1123        12 2023
#> 1124        NA 2023
#> 1125        NA 2023
#> 1126        NA 2023
#> 1127        NA 2023
#> 1128        NA 2023
#> 1129        NA 2023
#> 1130        NA 2023
#> 1131        NA 2023
#> 1132        NA 2023
#> 1133        NA 2023
#> 1134        15 2023
#> 1135        NA 2023
#> 1136        NA 2023
#> 1137        13 2023
#> 1138        NA 2023
#> 1139        NA 2023
#> 1140        NA 2023
#> 1141        NA 2023
#> 1142        NA 2023
#> 1143        NA 2023
#> 1144        NA 2023
#> 1145        NA 2023
#> 1146        NA 2023
#> 1147        NA 2023
#> 1148        NA 2023
#> 1149        NA 2023
#> 1150        NA 2023
#> 1151        NA 2023
#> 1152        NA 2023
#> 1153        NA 2023
#> 1154        11 2023
#> 1155        NA 2023
#> 1156        NA 2023
#> 1157         9 2023
#> 1158        NA 2023
#> 1159        NA 2023
#> 1160        NA 2023
#> 1161        NA 2023
#> 1162        NA 2023
#> 1163        NA 2023
#> 1164        NA 2023
#> 1165        NA 2023
#> 1166        NA 2023
#> 1167        NA 2023
#> 1168        15 2023
#> 1169        13 2023
#> 1170         8 2023
#> 1171        NA 2023
#> 1172        NA 2023
#> 1173        NA 2023
#> 1174        NA 2023
#> 1175        NA 2023
#> 1176         4 2023
#> 1177        NA 2023
#> 1178        NA 2023
#> 1179        NA 2023
#> 1180        NA 2023
#> 1181        NA 2023
#> 1182        NA 2023
#> 1183        16 2023
#> 1184        NA 2023
#> 1185        NA 2023
#> 1186        NA 2023
#> 1187         5 2023
#> 1188         1 2023
#> 1189         6 2023
#> 1190        NA 2023
#> 1191        NA 2023
#> 1192        NA 2023
#> 1193        NA 2023
#> 1194        NA 2023
#> 1195        NA 2023
#> 1196        12 2023
#> 1197        NA 2023
#> 1198        13 2023
#> 1199        NA 2023
#> 1200        10 2023
#> 1201        NA 2023
#> 1202        NA 2023
#> 1203        NA 2023
#> 1204        NA 2023
#> 1205        NA 2023
#> 1206        NA 2023
#> 1207        NA 2023
#> 1208        15 2023
#> 1209         2 2023
#> 1210         1 2023
#> 1211         7 2023
#> 1212        NA 2023
#> 1213        14 2023
#> 1214        NA 2023
#> 1215        NA 2023
#> 1216        NA 2023
#> 1217        NA 2023
#> 1218        NA 2023
#> 1219         7 2023
#> 1220        NA 2023
#> 1221        10 2023
#> 1222        NA 2023
#> 1223        NA 2023
#> 1224         2 2023
#> 1225        NA 2023
#> 1226        NA 2023
#> 1227        15 2023
#> 1228        NA 2023
#> 1229        NA 2023
#> 1230        NA 2023
#> 1231        NA 2023
#> 1232        NA 2023
#> 1233        NA 2023
#> 1234        NA 2023
#> 1235        NA 2023
#> 1236        NA 2023
#> 1237        NA 2023
#> 1238        NA 2023
#> 1239        NA 2023
#> 1240        11 2023
#> 1241        NA 2023
#> 1242        NA 2023
#> 1243        NA 2023
#> 1244        NA 2023
#> 1245        NA 2023
#> 1246        NA 2023
#> 1247        NA 2023
#> 1248        NA 2023
#> 1249        NA 2023
#> 1250        NA 2023
#> 1251        NA 2023
#> 1252        NA 2023
#> 1253        NA 2023
#> 1254         3 2023
#> 1255        NA 2023
#> 1256        NA 2023
#> 1257        NA 2023
#> 1258        NA 2023
#> 1259        NA 2023
#> 1260        NA 2023
#> 1261        NA 2023
#> 1262        NA 2023
#> 1263        NA 2023
#> 1264        NA 2023
#> 1265        NA 2023
#> 1266        NA 2023
#> 1267        NA 2023
#> 1268         1 2023
#> 1269        NA 2023
#> 1270        NA 2023
#> 1271        NA 2023
#> 1272        NA 2023
#> 1273        NA 2023
#> 1274        NA 2023
#> 1275        11 2023
#> 1276        NA 2023
#> 1277        NA 2023
#> 1278        NA 2023
#> 1279         3 2023
#> 1280        NA 2023
#> 1281        NA 2023
#> 1282        NA 2023
#> 1283        NA 2023
#> 1284        NA 2023
#> 1285        NA 2023
#> 1286        10 2023
#> 1287        NA 2023
#> 1288        NA 2023
#> 1289        NA 2023
#> 1290        NA 2023
#> 1291        NA 2023
#> 1292        NA 2023
#> 1293        11 2023
#> 1294        NA 2023
#> 1295        NA 2023
#> 1296        NA 2023
#> 1297        NA 2023
#> 1298        NA 2023
#> 1299        NA 2023
#> 1300        NA 2023
#> 1301        NA 2023
#> 1302        NA 2023
#> 1303        NA 2023
#> 1304        NA 2023
#> 1305        NA 2023
#> 1306        NA 2023
#> 1307        NA 2023
#> 1308         8 2023
#> 1309        NA 2023
#> 1310        NA 2023
#> 1311        NA 2023
#> 1312        NA 2023
#> 1313         9 2023
#> 1314        NA 2023
#> 1315        NA 2023
#> 1316        NA 2023
#> 1317        NA 2023
#> 1318        NA 2023
#> 1319        NA 2023
#> 1320        NA 2023
#> 1321        NA 2023
#> 1322        NA 2023
#> 1323        NA 2023
#> 1324        NA 2023
#> 1325        NA 2023
#> 1326        NA 2023
#> 1327        NA 2023
#> 1328        NA 2023
#> 1329        NA 2023
#> 1330        NA 2023
#> 1331        NA 2023
#> 1332        NA 2023
#> 1333        NA 2023
#> 1334        NA 2023
#> 1335        NA 2023
#> 1336        NA 2023
#> 1337        12 2023
#> 1338         2 2023
#> 1339        NA 2023
#> 1340        NA 2023
#> 1341        NA 2023
#> 1342        NA 2023
#> 1343        NA 2023
#> 1344        NA 2023
#> 1345        NA 2023
#> 1346         1 2023
#> 1347        NA 2023
#> 1348        NA 2023
#> 1349        NA 2023
#> 1350        NA 2023
#> 1351         7 2023
#> 1352        NA 2023
#> 1353         6 2023
#> 1354        NA 2023
#> 1355        NA 2023
#> 1356        NA 2023
#> 1357        NA 2023
#> 1358         4 2023
#> 1359        NA 2023
#> 1360         9 2023
#> 1361        NA 2023
#> 1362        NA 2023
#> 1363        NA 2023
#> 1364        NA 2023
#> 1365        14 2023
#> 1366        16 2023
#> 1367        NA 2023
#> 1368        NA 2023
#> 1369        11 2023
#> 1370        NA 2023
#> 1371        NA 2023
#> 1372        NA 2023
#> 1373        NA 2023
#> 1374        NA 2023
#> 1375        NA 2023
#> 1376        NA 2023
#> 1377        NA 2023
#> 1378        NA 2023
#> 1379        NA 2023
#> 1380        NA 2023
#> 1381        NA 2023
#> 1382        NA 2023
#> 1383         9 2023
#> 1384        NA 2023
#> 1385        NA 2023
#> 1386        12 2023
#> 1387        NA 2023
#> 1388        NA 2023
#> 1389        NA 2023
#> 1390        16 2023
#> 1391        NA 2023
#> 1392        NA 2023
#> 1393        NA 2023
#> 1394        NA 2023
#> 1395        NA 2023
#> 1396        NA 2023
#> 1397        NA 2023
#> 1398         5 2023
#> 1399        NA 2023
#> 1400        14 2023
#> 1401        NA 2023
#> 1402        NA 2023
#> 1403         5 2023
#> 1404        NA 2023
#> 1405        NA 2023
#> 1406        NA 2023
#> 1407        NA 2023
#> 1408        NA 2023
#> 1409        NA 2023
#> 1410        NA 2023
#> 1411        NA 2023
#> 1412        NA 2023
#> 1413        NA 2023
#> 1414        NA 2023
#> 1415        NA 2023
#> 1416        NA 2023
#> 1417        NA 2023
#> 1418        NA 2023
#> 1419         6 2023
#> 1420        11 2023
#> 1421        NA 2023
#> 1422        NA 2023
#> 1423         4 2023
#> 1424         4 2023
#> 1425        NA 2023
#> 1426        NA 2023
#> 1427         7 2023
#> 1428        NA 2023
#> 1429        13 2023
#> 1430         2 2023
#> 1431         8 2023
#> 1432        NA 2024
#> 1433        NA 2024
#> 1434        NA 2024
#> 1435        NA 2024
#> 1436        NA 2024
#> 1437        NA 2024
#> 1438        NA 2024
#> 1439        NA 2024
#> 1440        NA 2024
#> 1441        NA 2024
#> 1442        NA 2024
#> 1443        NA 2024
#> 1444        NA 2024
#> 1445        NA 2024
#> 1446        NA 2024
#> 1447        NA 2024
#> 1448        NA 2024
#> 1449        NA 2024
#> 1450        NA 2024
#> 1451        NA 2024
#> 1452        NA 2024
#> 1453        NA 2024
#> 1454        NA 2024
#> 1455         6 2024
#> 1456        NA 2024
#> 1457        NA 2024
#> 1458         3 2024
#> 1459        16 2024
#> 1460        14 2024
#> 1461        NA 2024
#> 1462        NA 2024
#> 1463        NA 2024
#> 1464         7 2024
#> 1465        NA 2024
#> 1466        NA 2024
#> 1467        NA 2024
#> 1468        12 2024
#> 1469        NA 2024
#> 1470        NA 2024
#> 1471        NA 2024
#> 1472        NA 2024
#> 1473        NA 2024
#> 1474        NA 2024
#> 1475        NA 2024
#> 1476        12 2024
#> 1477        NA 2024
#> 1478        NA 2024
#> 1479        NA 2024
#> 1480        NA 2024
#> 1481        NA 2024
#> 1482        NA 2024
#> 1483        NA 2024
#> 1484        NA 2024
#> 1485        NA 2024
#> 1486        NA 2024
#> 1487         4 2024
#> 1488        NA 2024
#> 1489        NA 2024
#> 1490        NA 2024
#> 1491        NA 2024
#> 1492        NA 2024
#> 1493        NA 2024
#> 1494        NA 2024
#> 1495        NA 2024
#> 1496        NA 2024
#> 1497        NA 2024
#> 1498        NA 2024
#> 1499        NA 2024
#> 1500        NA 2024
#> 1501        NA 2024
#> 1502         4 2024
#> 1503         4 2024
#> 1504        11 2024
#> 1505        NA 2024
#> 1506        NA 2024
#> 1507        NA 2024
#> 1508        NA 2024
#> 1509        NA 2024
#> 1510        NA 2024
#> 1511        16 2024
#> 1512        NA 2024
#> 1513        NA 2024
#> 1514        NA 2024
#> 1515         2 2024
#> 1516        NA 2024
#> 1517        NA 2024
#> 1518        NA 2024
#> 1519        NA 2024
#> 1520        NA 2024
#> 1521        NA 2024
#> 1522        NA 2024
#> 1523        NA 2024
#> 1524        NA 2024
#> 1525         5 2024
#> 1526        NA 2024
#> 1527        NA 2024
#> 1528        NA 2024
#> 1529        NA 2024
#> 1530        NA 2024
#> 1531        NA 2024
#> 1532         6 2024
#> 1533        NA 2024
#> 1534        NA 2024
#> 1535        NA 2024
#> 1536        NA 2024
#> 1537        NA 2024
#> 1538        NA 2024
#> 1539        NA 2024
#> 1540        NA 2024
#> 1541        NA 2024
#> 1542        NA 2024
#> 1543        NA 2024
#> 1544        NA 2024
#> 1545        NA 2024
#> 1546        NA 2024
#> 1547        NA 2024
#> 1548        NA 2024
#> 1549        13 2024
#> 1550        NA 2024
#> 1551        13 2024
#> 1552        14 2024
#> 1553        NA 2024
#> 1554        NA 2024
#> 1555        NA 2024
#> 1556        NA 2024
#> 1557        NA 2024
#> 1558        NA 2024
#> 1559        16 2024
#> 1560        NA 2024
#> 1561         4 2024
#> 1562        NA 2024
#> 1563        NA 2024
#> 1564        NA 2024
#> 1565        NA 2024
#> 1566        11 2024
#> 1567         5 2024
#> 1568        NA 2024
#> 1569        12 2024
#> 1570        15 2024
#> 1571        NA 2024
#> 1572        11 2024
#> 1573        NA 2024
#> 1574        NA 2024
#> 1575        NA 2024
#> 1576        NA 2024
#> 1577        NA 2024
#> 1578        NA 2024
#> 1579        NA 2024
#> 1580        NA 2024
#> 1581        10 2024
#> 1582        NA 2024
#> 1583        NA 2024
#> 1584        NA 2024
#> 1585        NA 2024
#> 1586        10 2024
#> 1587         2 2024
#> 1588         7 2024
#> 1589        NA 2024
#> 1590        NA 2024
#> 1591        16 2024
#> 1592         6 2024
#> 1593        NA 2024
#> 1594        NA 2024
#> 1595        14 2024
#> 1596         2 2024
#> 1597        NA 2024
#> 1598        NA 2024
#> 1599        NA 2024
#> 1600        NA 2024
#> 1601        NA 2024
#> 1602        14 2024
#> 1603        NA 2024
#> 1604        NA 2024
#> 1605        10 2024
#> 1606        NA 2024
#> 1607        NA 2024
#> 1608        NA 2024
#> 1609        NA 2024
#> 1610        NA 2024
#> 1611        NA 2024
#> 1612        NA 2024
#> 1613         1 2024
#> 1614        NA 2024
#> 1615        NA 2024
#> 1616        NA 2024
#> 1617         9 2024
#> 1618        NA 2024
#> 1619        NA 2024
#> 1620        NA 2024
#> 1621        NA 2024
#> 1622        NA 2024
#> 1623        NA 2024
#> 1624        NA 2024
#> 1625        13 2024
#> 1626        NA 2024
#> 1627        NA 2024
#> 1628        NA 2024
#> 1629         3 2024
#> 1630         1 2024
#> 1631        NA 2024
#> 1632        NA 2024
#> 1633        NA 2024
#> 1634        NA 2024
#> 1635        NA 2024
#> 1636        NA 2024
#> 1637        NA 2024
#> 1638        NA 2024
#> 1639        NA 2024
#> 1640        NA 2024
#> 1641        15 2024
#> 1642        NA 2024
#> 1643        NA 2024
#> 1644        NA 2024
#> 1645        NA 2024
#> 1646        NA 2024
#> 1647        NA 2024
#> 1648        NA 2024
#> 1649        NA 2024
#> 1650        NA 2024
#> 1651        NA 2024
#> 1652        NA 2024
#> 1653        NA 2024
#> 1654        NA 2024
#> 1655         7 2024
#> 1656        NA 2024
#> 1657        NA 2024
#> 1658        NA 2024
#> 1659        NA 2024
#> 1660        NA 2024
#> 1661        NA 2024
#> 1662        NA 2024
#> 1663        12 2024
#> 1664        NA 2024
#> 1665        NA 2024
#> 1666        NA 2024
#> 1667        NA 2024
#> 1668        NA 2024
#> 1669        NA 2024
#> 1670        NA 2024
#> 1671        NA 2024
#> 1672        NA 2024
#> 1673        NA 2024
#> 1674        NA 2024
#> 1675        NA 2024
#> 1676        NA 2024
#> 1677         8 2024
#> 1678        NA 2024
#> 1679        NA 2024
#> 1680        NA 2024
#> 1681        NA 2024
#> 1682        NA 2024
#> 1683         9 2024
#> 1684        NA 2024
#> 1685        NA 2024
#> 1686         9 2024
#> 1687        NA 2024
#> 1688        10 2024
#> 1689        NA 2024
#> 1690        NA 2024
#> 1691        NA 2024
#> 1692        NA 2024
#> 1693        NA 2024
#> 1694        NA 2024
#> 1695        NA 2024
#> 1696        NA 2024
#> 1697        NA 2024
#> 1698        NA 2024
#> 1699        NA 2024
#> 1700        NA 2024
#> 1701        NA 2024
#> 1702        NA 2024
#> 1703        NA 2024
#> 1704         8 2024
#> 1705        NA 2024
#> 1706        16 2024
#> 1707        NA 2024
#> 1708        NA 2024
#> 1709        NA 2024
#> 1710        NA 2024
#> 1711        NA 2024
#> 1712        NA 2024
#> 1713        NA 2024
#> 1714        NA 2024
#> 1715        NA 2024
#> 1716        15 2024
#> 1717         2 2024
#> 1718        NA 2024
#> 1719        NA 2024
#> 1720        13 2024
#> 1721        NA 2024
#> 1722        NA 2024
#> 1723        NA 2024
#> 1724         1 2024
#> 1725        NA 2024
#> 1726        NA 2024
#> 1727        NA 2024
#> 1728        NA 2024
#> 1729        NA 2024
#> 1730        NA 2024
#> 1731        NA 2024
#> 1732         5 2024
#> 1733         7 2024
#> 1734        NA 2024
#> 1735        10 2024
#> 1736        NA 2024
#> 1737        11 2024
#> 1738        NA 2024
#> 1739        NA 2024
#> 1740        NA 2024
#> 1741         1 2024
#> 1742        NA 2024
#> 1743        NA 2024
#> 1744         8 2024
#> 1745        NA 2024
#> 1746        NA 2024
#> 1747        NA 2024
#> 1748        NA 2024
#> 1749        NA 2024
#> 1750        NA 2024
#> 1751        NA 2024
#> 1752        NA 2024
#> 1753        NA 2024
#> 1754        NA 2024
#> 1755        NA 2024
#> 1756        NA 2024
#> 1757        NA 2024
#> 1758        NA 2024
#> 1759         3 2024
#> 1760        NA 2024
#> 1761        NA 2024
#> 1762        NA 2024
#> 1763        NA 2024
#> 1764        NA 2024
#> 1765        NA 2024
#> 1766        NA 2024
#> 1767         9 2024
#> 1768        10 2024
#> 1769        NA 2024
#> 1770        NA 2024
#> 1771        NA 2024
#> 1772        16 2024
#> 1773        NA 2024
#> 1774        NA 2024
#> 1775        NA 2024
#> 1776        NA 2024
#> 1777        NA 2024
#> 1778        NA 2024
#> 1779        NA 2024
#> 1780         3 2024
#> 1781        NA 2024
#> 1782         6 2024
#> 1783         8 2024
#> 1784        NA 2024
#> 1785        NA 2024
#> 1786        NA 2024
#> 1787        NA 2024
#> 1788         5 2024
#> 1789        NA 2024
#> 1790        NA 2024
#> 1791        NA 2024
#> 1792        15 2024
#> 1793        NA 2024
# }
```
