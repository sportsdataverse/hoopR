# **Get Home Court Arenas**

**Get Home Court Arenas**

## Usage

``` r
kp_arenas(year = most_recent_mbb_season())
```

## Arguments

- year:

  Year of data to pull

## Value

A data frame with the following columns:

|           |           |                                     |
|-----------|-----------|-------------------------------------|
| col_name  | types     | description                         |
| rk        | numeric   | Rk.                                 |
| team      | character | Team-side label or team identifier. |
| conf      | character | character.                          |
| arena     | character | Arena.                              |
| alternate | character | Alternate.                          |
| year      | numeric   | 4-digit year.                       |

## See also

Other KP Misc. Functions:
[`kp_fanmatch()`](https://hoopR.sportsdataverse.org/reference/kp_fanmatch.md),
[`kp_game_attrs()`](https://hoopR.sportsdataverse.org/reference/kp_game_attrs.md),
[`kp_hca()`](https://hoopR.sportsdataverse.org/reference/kp_hca.md),
[`kp_officials()`](https://hoopR.sportsdataverse.org/reference/kp_officials.md),
[`kp_referee()`](https://hoopR.sportsdataverse.org/reference/kp_referee.md),
[`kp_trends()`](https://hoopR.sportsdataverse.org/reference/kp_trends.md)

## Examples

``` r
# \donttest{
try(kp_arenas(year = 2021))
#>      rk                   team conf
#> 1     1               Syracuse  ACC
#> 2     2             Louisville  ACC
#> 3     3         North Carolina  ACC
#> 4     4              Tennessee  SEC
#> 5     5               Kentucky  SEC
#> 6     6             N.C. State  ACC
#> 7     7               Arkansas  SEC
#> 8     8               Ohio St.  B10
#> 9     9                    BYU  WCC
#> 10   10                Memphis Amer
#> 11   11             Bellarmine ASun
#> 12   12         South Carolina  SEC
#> 13   12                   UNLV  MWC
#> 14   14               Maryland  B10
#> 15   15              Marquette   BE
#> 16   16                Indiana  B10
#> 17   17              Creighton   BE
#> 18   18              Wisconsin  B10
#> 19   19                  Texas  B12
#> 20   20                 Kansas  B12
#> 21   21             Fresno St.  MWC
#> 22   22               Illinois  B10
#> 23   23             New Mexico  MWC
#> 24   24               Penn St.  B10
#> 25   25             Texas Tech  B12
#> 26   26               Missouri  SEC
#> 27   27                   Iowa  B10
#> 28   28               Nebraska  B10
#> 29   28                   Utah  P12
#> 30   30                 Purdue  B10
#> 31   31           Michigan St.  B10
#> 32   32            Wake Forest  ACC
#> 33   33                Arizona  P12
#> 34   34              Minnesota  B10
#> 35   35               Virginia  ACC
#> 36   36                Alabama  SEC
#> 37   37               Iowa St.  B12
#> 38   38             Vanderbilt  SEC
#> 39   39          West Virginia  B12
#> 40   40                   UCLA  P12
#> 41   41           Oklahoma St.  B12
#> 42   42                 Dayton  A10
#> 43   43                    LSU  SEC
#> 44   44                   Ohio  MAC
#> 45   45              Texas A&M  SEC
#> 46   46               Michigan  B10
#> 47   47                 Oregon  P12
#> 48   48             Kansas St.  B12
#> 49   49             Pittsburgh  ACC
#> 50   50         New Mexico St.  WAC
#> 51   51              Boise St.  MWC
#> 52   52          San Diego St.  MWC
#> 53   53             Providence   BE
#> 54   54              Louisiana   SB
#> 55   55            Florida St.  ACC
#> 56   56             Cincinnati Amer
#> 57   57                   UTEP CUSA
#> 58   58             California  P12
#> 59   59         Washington St.  P12
#> 60   60               Oklahoma  B12
#> 61   61                 Nevada  MWC
#> 62   62       Middle Tennessee CUSA
#> 63   63               Ball St.  MAC
#> 64   63              Weber St. BSky
#> 65   65                Wyoming  MWC
#> 66   66               Colorado  P12
#> 67   67                Bradley  MVC
#> 68   68           Missouri St.  MVC
#> 69   69            Chattanooga   SC
#> 70   70              Milwaukee Horz
#> 71   71            Arizona St.  P12
#> 72   72            Saint Louis  A10
#> 73   73        Mississippi St.  SEC
#> 74   73           Oral Roberts  Sum
#> 75   75                Georgia  SEC
#> 76   76            Wichita St. Amer
#> 77   77            North Texas CUSA
#> 78   77          Tennessee St.  OVC
#> 79   79             Seton Hall   BE
#> 80   80             Wright St. Horz
#> 81   81          South Florida Amer
#> 82   82                 DePaul   BE
#> 83   83                 Hawaii   BW
#> 84   84                 Baylor  B12
#> 85   85               Utah St.  MWC
#> 86   86                    USC  P12
#> 87   87                 Xavier   BE
#> 88   88                 Temple Amer
#> 89   89           Illinois St.  MVC
#> 90   89            Indiana St.  MVC
#> 91   91            Connecticut   BE
#> 92   92                Florida  SEC
#> 93   93                  Lamar Slnd
#> 94   94           Arkansas St.   SB
#> 95   95          South Alabama   SB
#> 96   95                    UCF Amer
#> 97   97              Green Bay Horz
#> 98   98             Oregon St.  P12
#> 99   99            Mississippi  SEC
#> 100 100          Massachusetts  A10
#> 101 101      Northern Kentucky Horz
#> 102 102                   Duke  ACC
#> 103 103             Washington  P12
#> 104 104             Notre Dame  ACC
#> 105 105                 Auburn  SEC
#> 106 106              Charlotte CUSA
#> 107 107                 Butler   BE
#> 108 107      Northern Illinois  MAC
#> 109 109               Marshall CUSA
#> 110 110                Clemson  ACC
#> 111 110            Florida A&M MEAC
#> 112 112             Evansville  MVC
#> 113 113          Virginia Tech  ACC
#> 114 114            New Orleans Slnd
#> 115 115       Eastern Michigan  MAC
#> 116 116                   Penn  Ivy
#> 117 117         Boston College  ACC
#> 118 118           Georgia Tech  ACC
#> 119 118             Murray St.  OVC
#> 120 118         William & Mary  CAA
#> 121 121          Cleveland St. Horz
#> 122 121          James Madison  CAA
#> 123 121 Texas A&M Corpus Chris Slnd
#> 124 121                    UAB CUSA
#> 125 125           Old Dominion CUSA
#> 126 126                  Tulsa Amer
#> 127 127      Southern Illinois  MVC
#> 128 128        Appalachian St.   SB
#> 129 129                Detroit Horz
#> 130 130         Texas Southern SWAC
#> 131 131          Southern Miss CUSA
#> 132 132           Colorado St.  MWC
#> 133 133          East Carolina Amer
#> 134 133       Illinois Chicago Horz
#> 135 133            Jackson St. SWAC
#> 136 133         Louisiana Tech CUSA
#> 137 133                Rutgers  B10
#> 138 138               Miami FL  ACC
#> 139 139         Nebraska Omaha  Sum
#> 140 140           George Mason  A10
#> 141 141       Western Carolina   SC
#> 142 142           Rhode Island  A10
#> 143 143                    VCU  A10
#> 144 144         UNC Greensboro   SC
#> 145 145       Western Kentucky CUSA
#> 146 146 Southeastern Louisiana Slnd
#> 147 146               Southern SWAC
#> 148 146         Tennessee Tech  OVC
#> 149 146            Utah Valley  WAC
#> 150 150            Alabama St. SWAC
#> 151 151               Stanford  P12
#> 152 152                Montana BSky
#> 153 153                 Toledo  MAC
#> 154 154          Northern Iowa  MVC
#> 155 155            Austin Peay  OVC
#> 156 156      Stephen F. Austin Slnd
#> 157 157               Richmond  A10
#> 158 158                Hampton BSth
#> 159 158              Texas St.   SB
#> 160 160                  Drake  MVC
#> 161 161               UC Davis   BW
#> 162 162           Northwestern  B10
#> 163 163                Houston Amer
#> 164 164             Alcorn St. SWAC
#> 165 164           Grand Canyon  WAC
#> 166 164                  Idaho BSky
#> 167 164       Louisiana Monroe   SB
#> 168 164                    SMU Amer
#> 169 164 Southeast Missouri St.  OVC
#> 170 164           UT Arlington   SB
#> 171 171              Princeton  Ivy
#> 172 172                  IUPUI Horz
#> 173 172                    TCU  B12
#> 174 174            Montana St. BSky
#> 175 175     North Carolina A&T MEAC
#> 176 176     East Tennessee St.   SC
#> 177 176       Eastern Kentucky  OVC
#> 178 176           Morehead St.  OVC
#> 179 176              Villanova   BE
#> 180 180               Miami OH  MAC
#> 181 180         Youngstown St. Horz
#> 182 182               Kent St.  MAC
#> 183 183            Norfolk St. MEAC
#> 184 184                Pacific  WCC
#> 185 185        Sam Houston St. Slnd
#> 186 186                Buffalo  MAC
#> 187 186         UNC Wilmington  CAA
#> 188 186               Winthrop BSth
#> 189 189       South Dakota St.  Sum
#> 190 190            Alabama A&M SWAC
#> 191 190                Gonzaga  WCC
#> 192 190           South Dakota  Sum
#> 193 190            The Citadel   SC
#> 194 190       UC Santa Barbara   BW
#> 195 195              Air Force  MWC
#> 196 196                  Maine   AE
#> 197 196          North Florida ASun
#> 198 198                   Navy  Pat
#> 199 199       North Dakota St.  Sum
#> 200 200             St. John's   BE
#> 201 201                 Lehigh  Pat
#> 202 201            Little Rock   SB
#> 203 203                  Akron  MAC
#> 204 203       Central Arkansas Slnd
#> 205 203 Maryland Eastern Shore MEAC
#> 206 203                   Troy   SB
#> 207 207        St. Bonaventure  A10
#> 208 208       Western Michigan  MAC
#> 209 209       Central Michigan  MAC
#> 210 209       Eastern Illinois  OVC
#> 211 209          Southern Utah BSky
#> 212 212               Davidson  A10
#> 213 213                   Rice CUSA
#> 214 214                 Towson  CAA
#> 215 215             Binghamton   AE
#> 216 216       Western Illinois  Sum
#> 217 217             Charleston  CAA
#> 218 217                   Elon  CAA
#> 219 217              San Diego  WCC
#> 220 220           Northeastern  CAA
#> 221 221            Cal Baptist  WAC
#> 222 222                Hofstra  CAA
#> 223 223                   Army  Pat
#> 224 224                    VMI   SC
#> 225 225               Lipscomb ASun
#> 226 226                Belmont  OVC
#> 227 226            Chicago St.  WAC
#> 228 226               Delaware  CAA
#> 229 226     Eastern Washington BSky
#> 230 226                    FIU CUSA
#> 231 226                 Furman   SC
#> 232 226                Samford   SC
#> 233 226           San Jose St.  MWC
#> 234 226              UC Irvine   BW
#> 235 226             Valparaiso  MVC
#> 236 236               Portland  WCC
#> 237 237              Dixie St.  WAC
#> 238 238                   UMBC   AE
#> 239 239           Kennesaw St. ASun
#> 240 240                 Albany   AE
#> 241 241    Arkansas Pine Bluff SWAC
#> 242 241     Florida Gulf Coast ASun
#> 243 241             Morgan St. MEAC
#> 244 241            Santa Clara  WCC
#> 245 245         Loyola Chicago  MVC
#> 246 246                Cornell  Ivy
#> 247 247       Georgia Southern   SB
#> 248 248          Bowling Green  MAC
#> 249 249      George Washington  A10
#> 250 250       Tennessee Martin  OVC
#> 251 251         Long Beach St.   BW
#> 252 251            McNeese St. Slnd
#> 253 251         Saint Joseph's  A10
#> 254 251          San Francisco  WCC
#> 255 255       Loyola Marymount  WCC
#> 256 256             Coppin St. MEAC
#> 257 256               Monmouth MAAC
#> 258 258                   UTSA CUSA
#> 259 259            Stony Brook   AE
#> 260 260               Bucknell  Pat
#> 261 260      Cal St. Fullerton   BW
#> 262 260                Liberty ASun
#> 263 260          North Alabama ASun
#> 264 260                Oakland Horz
#> 265 260          Robert Morris Horz
#> 266 260       SIU Edwardsville  OVC
#> 267 260                Stetson ASun
#> 268 260           UC San Diego   BW
#> 269 260   UT Rio Grande Valley  WAC
#> 270 270    Cal St. Bakersfield   BW
#> 271 271           Nicholls St. Slnd
#> 272 272       Coastal Carolina   SB
#> 273 272             Holy Cross  Pat
#> 274 272       Northwestern St. Slnd
#> 275 272                 Tulane Amer
#> 276 276               Hartford   AE
#> 277 277               Duquesne  A10
#> 278 277           Gardner Webb BSth
#> 279 277       Jacksonville St.  OVC
#> 280 277                   NJIT   AE
#> 281 277       Prairie View A&M SWAC
#> 282 277           Saint Mary's  WCC
#> 283 277         St. Francis PA  NEC
#> 284 284            Georgia St.   SB
#> 285 284               La Salle  A10
#> 286 284                Wofford   SC
#> 287 287                Vermont   AE
#> 288 288             Quinnipiac MAAC
#> 289 289    Central Connecticut  NEC
#> 290 289                Fordham  A10
#> 291 289                 Marist MAAC
#> 292 289                 Mercer   SC
#> 293 289                Radford BSth
#> 294 289          Saint Peter's MAAC
#> 295 289     South Carolina St. MEAC
#> 296 289          UNC Asheville BSth
#> 297 297       Mount St. Mary's  NEC
#> 298 298 North Carolina Central MEAC
#> 299 299             Pepperdine  WCC
#> 300 300               Campbell BSth
#> 301 301           Portland St. BSky
#> 302 302           North Dakota  Sum
#> 303 303              Idaho St. BSky
#> 304 304               Cal Poly   BW
#> 305 305        Bethune Cookman MEAC
#> 306 305          Grambling St. SWAC
#> 307 305          New Hampshire   AE
#> 308 305           Tarleton St.  WAC
#> 309 309      Northern Colorado BSky
#> 310 310               American  Pat
#> 311 311                  Brown  Ivy
#> 312 312           UC Riverside   BW
#> 313 313               Columbia  Ivy
#> 314 313                 Howard MEAC
#> 315 313 Mississippi Valley St. SWAC
#> 316 316              Lafayette  Pat
#> 317 317                   Iona MAAC
#> 318 318                 Bryant  NEC
#> 319 319                 Drexel  CAA
#> 320 319                   Yale  Ivy
#> 321 321                 Denver  Sum
#> 322 321       Florida Atlantic CUSA
#> 323 321             Georgetown   BE
#> 324 321              Manhattan MAAC
#> 325 325              Fairfield MAAC
#> 326 326                Niagara MAAC
#> 327 327           Presbyterian BSth
#> 328 328     Cal St. Northridge   BW
#> 329 329                Harvard  Ivy
#> 330 330               Canisius MAAC
#> 331 331                  Siena MAAC
#> 332 332              Dartmouth  Ivy
#> 333 332              Loyola MD  Pat
#> 334 332           Sacred Heart  NEC
#> 335 332           UMass Lowell   AE
#> 336 332                 Wagner  NEC
#> 337 337           Delaware St. MEAC
#> 338 337    Fairleigh Dickinson  NEC
#> 339 337         Incarnate Word Slnd
#> 340 337                    LIU  NEC
#> 341 341               Longwood BSth
#> 342 342      Boston University  Pat
#> 343 342      Purdue Fort Wayne Horz
#> 344 344                Colgate  Pat
#> 345 345             High Point BSth
#> 346 346                  Rider MAAC
#> 347 347                   UMKC  Sum
#> 348 348           Jacksonville ASun
#> 349 349       Northern Arizona BSky
#> 350 350              Merrimack  NEC
#> 351 350         St. Francis NY  NEC
#> 352 352         Sacramento St. BSky
#> 353 353      Abilene Christian Slnd
#> 354 353        Houston Baptist Slnd
#> 355 355                Seattle  WAC
#> 356 356    Charleston Southern BSth
#> 357 357            USC Upstate BSth
#>                                              arena
#> 1                            Carrier Dome (35,642)
#> 2                         KFC Yum! Center (22,090)
#> 3                    Dean E. Smith Center (21,750)
#> 4                   Thompson Boling Arena (21,678)
#> 5                              Rupp Arena (20,500)
#> 6                               PNC Arena (19,700)
#> 7                        Bud Walton Arena (19,200)
#> 8                        Value City Arena (19,049)
#> 9                         Marriott Center (18,987)
#> 10                             FedExForum (18,400)
#> 11                           Freedom Hall (18,252)
#> 12                    Colonial Life Arena (18,000)
#> 13                   Thomas & Mack Center (18,000)
#> 14                         Xfinity Center (17,950)
#> 15                           Fiserv Forum (17,600)
#> 16                          Assembly Hall (17,472)
#> 17                CHI Health Center Omaha (17,352)
#> 18                            Kohl Center (17,287)
#> 19                           Erwin Center (16,540)
#> 20                       Allen Fieldhouse (16,300)
#> 21                       Save Mart Center (15,596)
#> 22                      State Farm Center (15,544)
#> 23                       Dreamstyle Arena (15,411)
#> 24                    Bryce Jordan Center (15,261)
#> 25              United Supermarkets Arena (15,098)
#> 26                           Mizzou Arena (15,061)
#> 27                   Carver Hawkeye Arena (15,056)
#> 28                    Pinnacle Bank Arena (15,000)
#> 29                        Huntsman Center (15,000)
#> 30                           Mackey Arena (14,804)
#> 31                         Breslin Center (14,797)
#> 32                          Joel Coliseum (14,665)
#> 33                 McKale Memorial Center (14,644)
#> 34                         Williams Arena (14,625)
#> 35                  John Paul Jones Arena (14,623)
#> 36                       Coleman Coliseum (14,474)
#> 37                        Hilton Coliseum (14,384)
#> 38                           Memorial Gym (14,316)
#> 39                           WVU Coliseum (14,000)
#> 40                        Pauley Pavilion (13,800)
#> 41                    Gallagher Iba Arena (13,611)
#> 42             University of Dayton Arena (13,455)
#> 43               Maravich Assembly Center (13,215)
#> 44                     Convocation Center (13,080)
#> 45                             Reed Arena (12,989)
#> 46                         Crisler Center (12,707)
#> 47                           Knight Arena (12,541)
#> 48                      Bramlage Coliseum (12,528)
#> 49                 Petersen Events Center (12,508)
#> 50                    Pan American Center (12,482)
#> 51                        ExtraMile Arena (12,480)
#> 52                           Viejas Arena (12,414)
#> 53                  Dunkin' Donuts Center (12,410)
#> 54                              Cajundome (12,362)
#> 55                Donald L. Tucker Center (12,100)
#> 56                      Fifth Third Arena (12,012)
#> 57                     Don Haskins Center (11,892)
#> 58                          Haas Pavilion (11,877)
#> 59                       Beasley Coliseum (11,671)
#> 60                     Lloyd Noble Center (11,562)
#> 61                   Lawlor Events Center (11,536)
#> 62                          Murphy Center (11,520)
#> 63                          Worthen Arena (11,500)
#> 64                      Dee Events Center (11,500)
#> 65                       Arena Auditorium (11,445)
#> 66                       CU Events Center (11,064)
#> 67                           Carver Arena (11,060)
#> 68                              JQH Arena (11,000)
#> 69                         McKenzie Arena (10,995)
#> 70                      UWM Panther Arena (10,783)
#> 71                 Desert Financial Arena (10,754)
#> 72                         Chaifetz Arena (10,600)
#> 73                      Humphrey Coliseum (10,575)
#> 74                           Mabee Center (10,575)
#> 75                      Stegeman Coliseum (10,523)
#> 76                     Charles Koch Arena (10,506)
#> 77                          The Super Pit (10,500)
#> 78                          Gentry Center (10,500)
#> 79                      Prudential Center (10,481)
#> 80                          Nutter Center (10,449)
#> 81                       Yuengling Center (10,411)
#> 82                         Wintrust Arena (10,387)
#> 83                    Stan Sheriff Center (10,300)
#> 84                         Ferrell Center (10,284)
#> 85                Dee Glen Smith Spectrum (10,270)
#> 86                           Galen Center (10,258)
#> 87                          Cintas Center (10,224)
#> 88                   The Liacouras Center (10,206)
#> 89                          Redbird Arena (10,200)
#> 90                          Hulman Center (10,200)
#> 91                        Gampel Pavilion (10,167)
#> 92                         Exactech Arena (10,151)
#> 93                        Montagne Center (10,080)
#> 94              First National Bank Arena (10,038)
#> 95                        Mitchell Center (10,000)
#> 96               Addition Financial Arena (10,000)
#> 97                            Resch Center (9,729)
#> 98                           Gill Coliseum (9,604)
#> 99                The Pavilion at Ole Miss (9,500)
#> 100                         Mullins Center (9,493)
#> 101                             BB&T Arena (9,400)
#> 102                 Cameron Indoor Stadium (9,314)
#> 103                  Alaska Airlines Arena (9,268)
#> 104                           Joyce Center (9,149)
#> 105                           Auburn Arena (9,121)
#> 106                           Halton Arena (9,105)
#> 107                      Hinkle Fieldhouse (9,100)
#> 108                     Convocation Center (9,100)
#> 109                       Henderson Center (9,043)
#> 110                    Littlejohn Coliseum (9,000)
#> 111                          Lawson Center (9,000)
#> 112                            Ford Center (8,930)
#> 113                       Cassell Coliseum (8,925)
#> 114                        Lakefront Arena (8,785)
#> 115                     Convocation Center (8,754)
#> 116                           The Palestra (8,722)
#> 117                            Conte Forum (8,606)
#> 118                      McCamish Pavilion (8,600)
#> 119                            CFSB Center (8,600)
#> 120                           Kaplan Arena (8,600)
#> 121                        Wolstein Center (8,500)
#> 122             Atlantic Union Bank Center (8,500)
#> 123                   American Bank Center (8,500)
#> 124                           Bartow Arena (8,500)
#> 125            Constant Convocation Center (8,472)
#> 126                        Reynolds Center (8,355)
#> 127                        Banterra Center (8,339)
#> 128                          Holmes Center (8,325)
#> 129                           Calihan Hall (8,295)
#> 130                      Health & PE Arena (8,100)
#> 131                    Reed Green Coliseum (8,095)
#> 132                             Moby Arena (8,083)
#> 133      Williams Arena at Minges Coliseum (8,000)
#> 134                   Credit Union 1 Arena (8,000)
#> 135                        Williams Center (8,000)
#> 136                 Thomas Assembly Center (8,000)
#> 137                Rutgers Athletic Center (8,000)
#> 138                          Watsco Center (7,972)
#> 139                           Baxter Arena (7,898)
#> 140                        EagleBank Arena (7,860)
#> 141                          Ramsey Center (7,826)
#> 142                            Ryan Center (7,657)
#> 143                          Siegel Center (7,637)
#> 144                    Greensboro Coliseum (7,617)
#> 145                      E.A. Diddle Arena (7,523)
#> 146                      University Center (7,500)
#> 147                  Clark Activity Center (7,500)
#> 148                           Eblen Center (7,500)
#> 149                            UCCU Center (7,500)
#> 150                    Dunn-Oliver Acadome (7,400)
#> 151                        Maples Pavilion (7,329)
#> 152                         Dahlberg Arena (7,322)
#> 153                           Savage Arena (7,300)
#> 154                          McLeod Center (7,293)
#> 155                   Winfield Dunn Center (7,275)
#> 156                       Johnson Coliseum (7,203)
#> 157                          Robins Center (7,201)
#> 158             Hampton Convocation Center (7,200)
#> 159                       Strahan Coliseum (7,200)
#> 160                           Knapp Center (7,152)
#> 161                           The Pavilion (7,100)
#> 162                       Welsh-Ryan Arena (7,039)
#> 163                        Fertitta Center (7,035)
#> 164                        Whitney Complex (7,000)
#> 165                              GCU Arena (7,000)
#> 166                         Cowan Spectrum (7,000)
#> 167                    Fant-Ewing Coliseum (7,000)
#> 168                         Moody Coliseum (7,000)
#> 169                         Show Me Center (7,000)
#> 170                    College Park Center (7,000)
#> 171                       Jadwin Gymnasium (6,854)
#> 172               Indiana Farmers Coliseum (6,800)
#> 173                      Schollmaier Arena (6,800)
#> 174                      Worthington Arena (6,772)
#> 175                  Corbett Sports Center (6,700)
#> 176              Freedom Hall Civic Center (6,500)
#> 177                         McBrayer Arena (6,500)
#> 178                          Johnson Arena (6,500)
#> 179                      Finneran Pavilion (6,500)
#> 180                           Millett Hall (6,400)
#> 181                         Beeghly Center (6,400)
#> 182 Memorial Athletic & Convocation Center (6,327)
#> 183                            Echols Hall (6,191)
#> 184                          Spanos Center (6,150)
#> 185                       Johnson Coliseum (6,110)
#> 186                           Alumni Arena (6,100)
#> 187                         Trask Coliseum (6,100)
#> 188                      Winthrop Coliseum (6,100)
#> 189                            Frost Arena (6,063)
#> 190                       Elmore Gymnasium (6,000)
#> 191              McCarthey Athletic Center (6,000)
#> 192           Sanford Coyote Sports Center (6,000)
#> 193                  McAlister Field House (6,000)
#> 194                            Thunderdome (6,000)
#> 195                            Clune Arena (5,843)
#> 196                 Cross Insurance Center (5,800)
#> 197                              UNF Arena (5,800)
#> 198                            Alumni Hall (5,710)
#> 199                         Scheels Center (5,644)
#> 200                       Carnesecca Arena (5,602)
#> 201                          Stabler Arena (5,600)
#> 202                        Stephens Center (5,600)
#> 203                           Rhodes Arena (5,500)
#> 204                          Farris Center (5,500)
#> 205                 Hytche Athletic Center (5,500)
#> 206                           Trojan Arena (5,500)
#> 207                          Reilly Center (5,480)
#> 208                       University Arena (5,421)
#> 209                          McGuirk Arena (5,300)
#> 210                            Lantz Arena (5,300)
#> 211             America First Event Center (5,300)
#> 212                             Belk Arena (5,223)
#> 213                       Tudor Fieldhouse (5,208)
#> 214                             SECU Arena (5,200)
#> 215                          Events Center (5,142)
#> 216                           Western Hall (5,139)
#> 217                               TD Arena (5,100)
#> 218                           Schar Center (5,100)
#> 219                   Jenny Craig Pavilion (5,100)
#> 220                         Matthews Arena (5,066)
#> 221                      CBU Events Center (5,050)
#> 222                    Mack Sports Complex (5,045)
#> 223                          Christl Arena (5,043)
#> 224                           Cameron Hall (5,029)
#> 225                            Allen Arena (5,028)
#> 226                      Curb Event Center (5,000)
#> 227               Jones Convocation Center (5,000)
#> 228                   Bob Carpenter Center (5,000)
#> 229                            Reese Court (5,000)
#> 230          Ocean Bank Convocation Center (5,000)
#> 231                          Timmons Arena (5,000)
#> 232                           Hanna Center (5,000)
#> 233    Provident Credit Union Event Center (5,000)
#> 234                     Bren Events Center (5,000)
#> 235            Athletics Recreation Center (5,000)
#> 236                          Chiles Center (4,854)
#> 237                            Burns Arena (4,779)
#> 238                      UMBC Event Center (4,753)
#> 239                 KSU Convocation Center (4,600)
#> 240                            SEFCU Arena (4,538)
#> 241                         Clemmons Arena (4,500)
#> 242                            Alico Arena (4,500)
#> 243                       Hill Field House (4,500)
#> 244                          Leavey Center (4,500)
#> 245                          Gentile Arena (4,486)
#> 246                           Newman Arena (4,473)
#> 247                      Hanner Fieldhouse (4,358)
#> 248                           Stroh Center (4,347)
#> 249                Charles E. Smith Center (4,338)
#> 250                            Elam Center (4,300)
#> 251                     The Walter Pyramid (4,200)
#> 252                           H&HP Complex (4,200)
#> 253                            Hagan Arena (4,200)
#> 254     War Memorial at the Sobrato Center (4,200)
#> 255                       Gersten Pavilion (4,156)
#> 256             Physical Education Complex (4,100)
#> 257                 OceanFirst Bank Center (4,100)
#> 258                UTSA Convocation Center (4,080)
#> 259                   Island Federal Arena (4,009)
#> 260                         Sojka Pavilion (4,000)
#> 261                              Titan Gym (4,000)
#> 262                          Liberty Arena (4,000)
#> 263                           Flowers Hall (4,000)
#> 264                Athletics Center O'Rena (4,000)
#> 265                     UPMC Events Center (4,000)
#> 266                  First Community Arena (4,000)
#> 267                         Edmunds Center (4,000)
#> 268                            Rimac Arena (4,000)
#> 269                       UTRGV Fieldhouse (4,000)
#> 270                          Icardo Center (3,880)
#> 271                            Stopher Gym (3,800)
#> 272                             HTC Center (3,600)
#> 273                            Hart Center (3,600)
#> 274                       Prather Coliseum (3,600)
#> 275                         Fogelman Arena (3,600)
#> 276                            Chase Arena (3,508)
#> 277                 UPMC Cooper Fieldhouse (3,500)
#> 278                      Paul Porter Arena (3,500)
#> 279                       Mathews Coliseum (3,500)
#> 280             Wellness and Events Center (3,500)
#> 281                 William Nicks Building (3,500)
#> 282       University Credit Union Pavilion (3,500)
#> 283                            DeGol Arena (3,500)
#> 284                       GSU Sports Arena (3,400)
#> 285                         Tom Gola Arena (3,400)
#> 286              Richardson Indoor Stadium (3,400)
#> 287                      Patrick Gymnasium (3,266)
#> 288                 People's United Center (3,254)
#> 289                      Detrick Gymnasium (3,200)
#> 290                          Rose Hill Gym (3,200)
#> 291                          McCann Center (3,200)
#> 292                          Hawkins Arena (3,200)
#> 293                          Dedmon Center (3,200)
#> 294                       Yanitelli Center (3,200)
#> 295         Smith Hammond Middleton Center (3,200)
#> 296                           Kimmel Arena (3,200)
#> 297                            Knott Arena (3,121)
#> 298           McLendon-McDougald Gymnasium (3,116)
#> 299                   Firestone Fieldhouse (3,104)
#> 300                Pope Convocation Center (3,095)
#> 301                        Viking Pavilion (3,094)
#> 302           Betty Engelstad Sioux Center (3,064)
#> 303                               Reed Gym (3,040)
#> 304                  Mott Athletics Center (3,032)
#> 305                              Moore Gym (3,000)
#> 306                        Assembly Center (3,000)
#> 307                     Lundholm Gymnasium (3,000)
#> 308                       Wisdom Gymnasium (3,000)
#> 309                 Bank of Colorado Arena (2,977)
#> 310                           Bender Arena (2,930)
#> 311                Pizzitola Sports Center (2,800)
#> 312                              SRC Arena (2,750)
#> 313                       Levien Gymnasium (2,700)
#> 314                             Burr Arena (2,700)
#> 315                       Harrison Complex (2,700)
#> 316                    Kirby Sports Center (2,644)
#> 317                 Hynes Athletics Center (2,611)
#> 318                  Chace Athletic Center (2,600)
#> 319             Daskalakis Athletic Center (2,532)
#> 320                       Lee Amphitheater (2,532)
#> 321                     Hamilton Gymnasium (2,500)
#> 322                              FAU Arena (2,500)
#> 323                        McDonough Arena (2,500)
#> 324                       Draddy Gymnasium (2,500)
#> 325                            Alumni Hall (2,479)
#> 326                       Gallagher Center (2,400)
#> 327                  Templeton P.E. Center (2,300)
#> 328                               Matadome (2,200)
#> 329                      Lavietes Pavilion (2,195)
#> 330               Koessler Athletic Center (2,176)
#> 331                             UHY Center (2,148)
#> 332                            Leede Arena (2,100)
#> 333                            Reitz Arena (2,100)
#> 334                            Pitt Center (2,100)
#> 335               Costello Athletic Center (2,100)
#> 336                    Spiro Sports Center (2,100)
#> 337                          Memorial Hall (2,000)
#> 338                         Rothman Center (2,000)
#> 339           McDermott Convocation Center (2,000)
#> 340              Steinberg Wellness Center (2,000)
#> 341                           Willett Hall (1,807)
#> 342                               Case Gym (1,800)
#> 343                    Gates Sports Center (1,800)
#> 344                        Cotterell Court (1,782)
#> 345 Millis Athletic and Convocation Center (1,750)
#> 346                       Alumni Gymnasium (1,650)
#> 347              Swinney Recreation Center (1,600)
#> 348                      Swisher Gymnasium (1,500)
#> 349                 Rolle Activity Center  (1,210)
#> 350                           Hammel Court (1,200)
#> 351                       Pope P.E. Center (1,200)
#> 352                               The Nest (1,012)
#> 353           Teague Special Events Center (1,000)
#> 354                              Sharp Gym (1,000)
#> 355                           Redhawk Center (999)
#> 356                    Buccaneer Field House (881)
#> 357                             Hodge Center (837)
#>                          alternate year
#> 1                                  2021
#> 2                                  2021
#> 3                                  2021
#> 4                                  2021
#> 5                                  2021
#> 6                                  2021
#> 7                                  2021
#> 8                                  2021
#> 9                                  2021
#> 10                                 2021
#> 11                                 2021
#> 12                                 2021
#> 13                                 2021
#> 14                                 2021
#> 15                                 2021
#> 16                                 2021
#> 17                                 2021
#> 18                                 2021
#> 19                                 2021
#> 20                                 2021
#> 21                                 2021
#> 22                                 2021
#> 23                                 2021
#> 24                                 2021
#> 25                                 2021
#> 26                                 2021
#> 27                                 2021
#> 28                                 2021
#> 29                                 2021
#> 30                                 2021
#> 31                                 2021
#> 32                                 2021
#> 33                                 2021
#> 34                                 2021
#> 35                                 2021
#> 36                                 2021
#> 37                                 2021
#> 38                                 2021
#> 39                                 2021
#> 40                                 2021
#> 41                                 2021
#> 42                                 2021
#> 43                                 2021
#> 44                                 2021
#> 45                                 2021
#> 46                                 2021
#> 47                                 2021
#> 48                                 2021
#> 49                                 2021
#> 50                                 2021
#> 51                                 2021
#> 52                                 2021
#> 53                                 2021
#> 54                                 2021
#> 55                                 2021
#> 56                                 2021
#> 57                                 2021
#> 58                                 2021
#> 59                                 2021
#> 60                                 2021
#> 61                                 2021
#> 62                                 2021
#> 63                                 2021
#> 64                                 2021
#> 65                                 2021
#> 66                                 2021
#> 67                                 2021
#> 68                                 2021
#> 69                                 2021
#> 70                                 2021
#> 71                                 2021
#> 72                                 2021
#> 73                                 2021
#> 74                                 2021
#> 75                                 2021
#> 76                                 2021
#> 77                                 2021
#> 78                                 2021
#> 79                                 2021
#> 80                                 2021
#> 81                                 2021
#> 82                                 2021
#> 83                                 2021
#> 84                                 2021
#> 85                                 2021
#> 86                                 2021
#> 87                                 2021
#> 88                                 2021
#> 89                                 2021
#> 90                                 2021
#> 91              XL Center (15,564) 2021
#> 92                                 2021
#> 93                                 2021
#> 94                                 2021
#> 95                                 2021
#> 96                                 2021
#> 97     Kress Events Center (4,018) 2021
#> 98                                 2021
#> 99                                 2021
#> 100                                2021
#> 101                                2021
#> 102                                2021
#> 103                                2021
#> 104                                2021
#> 105                                2021
#> 106                                2021
#> 107                                2021
#> 108                                2021
#> 109                                2021
#> 110                                2021
#> 111                                2021
#> 112                                2021
#> 113                                2021
#> 114                                2021
#> 115                                2021
#> 116                                2021
#> 117                                2021
#> 118                                2021
#> 119                                2021
#> 120                                2021
#> 121                                2021
#> 122                                2021
#> 123                                2021
#> 124                                2021
#> 125                                2021
#> 126                                2021
#> 127                                2021
#> 128                                2021
#> 129                                2021
#> 130                                2021
#> 131                                2021
#> 132                                2021
#> 133                                2021
#> 134                                2021
#> 135                                2021
#> 136                                2021
#> 137                                2021
#> 138                                2021
#> 139                                2021
#> 140                                2021
#> 141                                2021
#> 142                                2021
#> 143                                2021
#> 144      Fleming Gymnasium (2,320) 2021
#> 145                                2021
#> 146                                2021
#> 147                                2021
#> 148                                2021
#> 149                                2021
#> 150                                2021
#> 151                                2021
#> 152                                2021
#> 153                                2021
#> 154                                2021
#> 155                                2021
#> 156                                2021
#> 157                                2021
#> 158                                2021
#> 159                                2021
#> 160                                2021
#> 161                                2021
#> 162                                2021
#> 163                                2021
#> 164                                2021
#> 165                                2021
#> 166                                2021
#> 167                                2021
#> 168                                2021
#> 169                                2021
#> 170                                2021
#> 171                                2021
#> 172                                2021
#> 173                                2021
#> 174                                2021
#> 175                                2021
#> 176                                2021
#> 177                                2021
#> 178                                2021
#> 179    Wells Fargo Center (20,478) 2021
#> 180                                2021
#> 181                                2021
#> 182                                2021
#> 183                                2021
#> 184                                2021
#> 185                                2021
#> 186                                2021
#> 187                                2021
#> 188                                2021
#> 189                                2021
#> 190                                2021
#> 191                                2021
#> 192                                2021
#> 193                                2021
#> 194                                2021
#> 195                                2021
#> 196                                2021
#> 197                                2021
#> 198                                2021
#> 199                                2021
#> 200 Madison Square Garden (19,786) 2021
#> 201                                2021
#> 202                                2021
#> 203                                2021
#> 204                                2021
#> 205                                2021
#> 206                                2021
#> 207                                2021
#> 208                                2021
#> 209                                2021
#> 210                                2021
#> 211                                2021
#> 212                                2021
#> 213                                2021
#> 214                                2021
#> 215                                2021
#> 216                                2021
#> 217                                2021
#> 218                                2021
#> 219                                2021
#> 220                                2021
#> 221                                2021
#> 222                                2021
#> 223                                2021
#> 224                                2021
#> 225                                2021
#> 226                                2021
#> 227                                2021
#> 228                                2021
#> 229                                2021
#> 230                                2021
#> 231                                2021
#> 232                                2021
#> 233                                2021
#> 234                                2021
#> 235                                2021
#> 236                                2021
#> 237                                2021
#> 238                                2021
#> 239                                2021
#> 240                                2021
#> 241                                2021
#> 242                                2021
#> 243                                2021
#> 244                                2021
#> 245                                2021
#> 246                                2021
#> 247                                2021
#> 248                                2021
#> 249                                2021
#> 250                                2021
#> 251                                2021
#> 252                                2021
#> 253                                2021
#> 254                                2021
#> 255                                2021
#> 256                                2021
#> 257                                2021
#> 258                                2021
#> 259                                2021
#> 260                                2021
#> 261                                2021
#> 262                                2021
#> 263                                2021
#> 264                                2021
#> 265                                2021
#> 266                                2021
#> 267                                2021
#> 268                                2021
#> 269                                2021
#> 270                                2021
#> 271                                2021
#> 272                                2021
#> 273                                2021
#> 274                                2021
#> 275                                2021
#> 276                                2021
#> 277                                2021
#> 278                                2021
#> 279                                2021
#> 280                                2021
#> 281                                2021
#> 282                                2021
#> 283                                2021
#> 284                                2021
#> 285                                2021
#> 286                                2021
#> 287                                2021
#> 288                                2021
#> 289                                2021
#> 290                                2021
#> 291                                2021
#> 292                                2021
#> 293                                2021
#> 294                                2021
#> 295                                2021
#> 296                                2021
#> 297                                2021
#> 298                                2021
#> 299                                2021
#> 300                                2021
#> 301                                2021
#> 302                                2021
#> 303                                2021
#> 304                                2021
#> 305                                2021
#> 306                                2021
#> 307                                2021
#> 308                                2021
#> 309                                2021
#> 310                                2021
#> 311                                2021
#> 312                                2021
#> 313                                2021
#> 314                                2021
#> 315                                2021
#> 316                                2021
#> 317                                2021
#> 318                                2021
#> 319                                2021
#> 320                                2021
#> 321                                2021
#> 322                                2021
#> 323                                2021
#> 324                                2021
#> 325    Webster Bank Arena (10,000) 2021
#> 326                                2021
#> 327                                2021
#> 328                                2021
#> 329                                2021
#> 330                                2021
#> 331                                2021
#> 332                                2021
#> 333                                2021
#> 334                                2021
#> 335         Tsongas Center (6,111) 2021
#> 336                                2021
#> 337                                2021
#> 338                                2021
#> 339                                2021
#> 340                                2021
#> 341                                2021
#> 342                                2021
#> 343                                2021
#> 344                                2021
#> 345                                2021
#> 346                                2021
#> 347                                2021
#> 348                                2021
#> 349                                2021
#> 350                                2021
#> 351                                2021
#> 352                                2021
#> 353                                2021
#> 354                                2021
#> 355                                2021
#> 356                                2021
#> 357                                2021
# }
```
