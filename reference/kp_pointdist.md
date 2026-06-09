# **Get Team Points Distribution**

**Get Team Points Distribution**

## Usage

``` r
kp_pointdist(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of team points distributions

|                 |           |                                             |
|-----------------|-----------|---------------------------------------------|
| col_name        | types     | description                                 |
| team            | character | Team-side label or team identifier.         |
| conf            | character | character.                                  |
| off_ft_pct      | numeric   | Off free throws percentage (0-1 decimal).   |
| off_ft_pct_rk   | numeric   | Off ft pct rk.                              |
| off_fg_2_pct    | numeric   | Off field goals 2 percentage (0-1 decimal). |
| off_fg_2_pct_rk | numeric   | Off fg 2 pct rk.                            |
| off_fg_3_pct    | numeric   | Off field goals 3 percentage (0-1 decimal). |
| off_fg_3_pct_rk | numeric   | Off fg 3 pct rk.                            |
| def_ft_pct      | numeric   | Def free throws percentage (0-1 decimal).   |
| def_ft_pct_rk   | numeric   | Def ft pct rk.                              |
| def_fg_2_pct    | numeric   | Def field goals 2 percentage (0-1 decimal). |
| def_fg_2_pct_rk | numeric   | Def fg 2 pct rk.                            |
| def_fg_3_pct    | numeric   | Def field goals 3 percentage (0-1 decimal). |
| def_fg_3_pct_rk | numeric   | Def fg 3 pct rk.                            |
| ncaa_seed       | numeric   | Ncaa seed.                                  |
| year            | numeric   | 4-digit year.                               |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_pointdist(min_year = 2020, max_year = 2021))
#> ✖ 2026-06-09 18:18:07.845903: Invalid arguments or no point distribution data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: subscript out of bounds
#>                       Team Conf Off.FT.Pct Off.FT.Pct.Rk Off.FG_2.Pct
#> 1             Arkansas St.   SB       26.2             1         48.9
#> 2              Chicago St.  WAC       25.2             2         47.8
#> 3                 Kentucky  SEC       24.3             3         55.3
#> 4           Texas Southern SWAC       24.2             4         54.2
#> 5       South Carolina St. MEAC       24.2             5         55.3
#> 6              Wake Forest  ACC       23.8             6         49.3
#> 7              New Orleans Slnd       23.6             7         55.7
#> 8               Morgan St. MEAC       23.6             8         54.8
#> 9               High Point BSth       23.5             9         48.4
#> 10       Abilene Christian Slnd       23.5            10         49.8
#> 11                Arkansas  SEC       23.4            11         46.6
#> 12             Little Rock   SB       23.3            12         51.3
#> 13        Prairie View A&M SWAC       23.3            13         57.1
#> 14        Western Kentucky CUSA       23.3            14         49.3
#> 15               Texas A&M  SEC       23.1            15         47.0
#> 16           Saint Peter's MAAC       23.0            16         49.1
#> 17                Missouri  SEC       22.9            17         47.6
#> 18                 Seattle  WAC       22.9            18         47.0
#> 19        Central Arkansas Slnd       22.9            19         46.9
#> 20                  Auburn  SEC       22.8            20         46.0
#> 21           Cleveland St. Horz       22.5            21         60.9
#> 22            Kennesaw St. ASun       22.5            22         54.8
#> 23             Montana St. BSky       22.5            23         53.2
#> 24                Maryland  B10       22.5            24         45.5
#> 25               Fairfield MAAC       22.5            25         55.3
#> 26         Mississippi St.  SEC       22.4            26         56.4
#> 27           South Alabama   SB       22.4            27         55.5
#> 28              Vanderbilt  SEC       22.4            28         43.4
#> 29       Stephen F. Austin Slnd       22.3            29         55.0
#> 30           North Alabama ASun       22.3            30         48.2
#> 31        Eastern Michigan  MAC       22.3            31         52.0
#> 32               Tennessee  SEC       22.2            32         50.8
#> 33                 Hampton BSth       22.2            33         54.3
#> 34         Appalachian St.   SB       22.2            34         49.7
#> 35           East Carolina Amer       22.1            35         54.9
#> 36                   Tulsa Amer       22.1            36         51.9
#> 37              California  P12       22.1            37         54.2
#> 38               Marquette   BE       22.0            38         39.3
#> 39              Oregon St.  P12       22.0            39         52.3
#> 40         Houston Baptist Slnd       22.0            40         50.1
#> 41         Bethune Cookman MEAC       22.0            41         52.7
#> 42            South Dakota  Sum       21.9            42         50.7
#> 43           West Virginia  B12       21.8            43         56.8
#> 44                    UCLA  P12       21.8            44         52.0
#> 45                  Towson  CAA       21.8            45         50.0
#> 46              Pittsburgh  ACC       21.7            46         53.9
#> 47             Mississippi  SEC       21.6            47         52.3
#> 48            North Dakota  Sum       21.6            48         47.7
#> 49           Grambling St. SWAC       21.6            49         57.9
#> 50            Grand Canyon  WAC       21.6            50         52.3
#> 51    UT Rio Grande Valley  WAC       21.5            51         54.3
#> 52             Cal Baptist  WAC       21.5            52         42.1
#> 53                 Memphis Amer       21.4            53         51.2
#> 54        UC Santa Barbara   BW       21.4            54         50.7
#> 55              Washington  P12       21.4            55         49.4
#> 56                Monmouth MAAC       21.4            56         47.8
#> 57                 Samford   SC       21.4            57         51.5
#> 58                 Detroit Horz       21.3            58         42.4
#> 59               Louisiana   SB       21.3            59         46.4
#> 60             Florida A&M MEAC       21.3            60         61.1
#> 61            San Jose St.  MWC       21.3            61         42.9
#> 62               Texas St.   SB       21.3            62         56.9
#> 63                   Rider MAAC       21.3            63         53.1
#> 64            Oklahoma St.  B12       21.3            64         52.5
#> 65                 Indiana  B10       21.3            65         55.6
#> 66                  Toledo  MAC       21.2            66         43.1
#> 67             Connecticut Amer       21.2            67         50.1
#> 68                 Oakland Horz       21.2            68         51.3
#> 69                Utah St.  MWC       21.1            69         50.2
#> 70      North Carolina A&T MEAC       21.1            70         55.0
#> 71              Murray St.  OVC       21.1            71         52.7
#> 72            Rhode Island  A10       21.1            72         55.7
#> 73              Georgetown   BE       21.1            73         53.1
#> 74                   Brown  Ivy       21.0            74         48.4
#> 75              Cincinnati Amer       21.0            75         51.9
#> 76        Central Michigan  MAC       21.0            76         49.6
#> 77           Southern Utah BSky       21.0            77         54.8
#> 78                 Arizona  P12       20.9            78         50.5
#> 79               Boise St.  MWC       20.9            79         46.3
#> 80                   Akron  MAC       20.9            80         42.3
#> 81                Ohio St.  B10       20.9            81         44.0
#> 82                Colorado  P12       20.9            82         47.3
#> 83             Jackson St. SWAC       20.8            83         59.3
#> 84              Providence   BE       20.8            84         48.7
#> 85                    UTEP CUSA       20.8            85         48.6
#> 86                 Stetson ASun       20.8            86         53.9
#> 87        Western Michigan  MAC       20.8            87         48.4
#> 88            UMass Lowell   AE       20.8            88         51.6
#> 89       Cal St. Fullerton   BW       20.8            89         52.2
#> 90           South Florida Amer       20.7            90         49.0
#> 91                Syracuse  ACC       20.7            91         46.6
#> 92              Pepperdine  WCC       20.7            92         47.9
#> 93                   Lamar Slnd       20.7            93         53.9
#> 94                 Hofstra  CAA       20.7            94         46.6
#> 95            Sacred Heart  NEC       20.6            95         48.5
#> 96             Austin Peay  OVC       20.6            96         52.0
#> 97               Charlotte CUSA       20.6            97         50.6
#> 98             Alabama A&M SWAC       20.5            98         54.4
#> 99                     LSU  SEC       20.5            99         54.1
#> 100 Southeast Missouri St.  OVC       20.4           100         51.3
#> 101              Loyola MD  Pat       20.4           101         52.5
#> 102             New Mexico  MWC       20.4           102         52.2
#> 103         Sacramento St. BSky       20.4           103         56.1
#> 104                 Denver  Sum       20.4           104         56.8
#> 105           Presbyterian BSth       20.3           105         51.7
#> 106                   Iona MAAC       20.3           106         46.6
#> 107                 Tulane Amer       20.3           107         46.0
#> 108       North Dakota St.  Sum       20.3           108         42.2
#> 109                   Utah  P12       20.3           109         49.8
#> 110            Norfolk St. MEAC       20.3           110         46.5
#> 111    Arkansas Pine Bluff SWAC       20.3           111         58.7
#> 112            Santa Clara  WCC       20.2           112         51.0
#> 113         UNC Wilmington  CAA       20.2           113         53.0
#> 114       Eastern Kentucky  OVC       20.2           114         48.3
#> 115            Stony Brook   AE       20.1           115         43.9
#> 116         Incarnate Word Slnd       20.1           116         51.8
#> 117             Texas Tech  B12       20.1           117         49.8
#> 118          James Madison  CAA       20.1           118         47.5
#> 119                    UAB CUSA       20.1           119         57.4
#> 120                Houston Amer       20.0           120         51.0
#> 121                 Albany   AE       20.0           121         44.1
#> 122                   Iowa  B10       20.0           122         49.6
#> 123            Wichita St. Amer       20.0           123         47.1
#> 124       Western Carolina   SC       20.0           124         43.2
#> 125           George Mason  A10       20.0           125         53.6
#> 126         Washington St.  P12       20.0           126         48.2
#> 127       Northwestern St. Slnd       19.9           127         48.8
#> 128             Wright St. Horz       19.9           128         51.9
#> 129            Alabama St. SWAC       19.9           129         48.3
#> 130               Oklahoma  B12       19.9           130         49.2
#> 131                 Temple Amer       19.9           131         50.6
#> 132      Southern Illinois  MVC       19.9           132         46.0
#> 133            Utah Valley  WAC       19.9           133         52.6
#> 134       Coastal Carolina   SB       19.9           134         52.0
#> 135            USC Upstate BSth       19.8           135         50.3
#> 136                  Siena MAAC       19.8           136         52.8
#> 137           Colorado St.  MWC       19.8           137         48.1
#> 138             Alcorn St. SWAC       19.7           138         46.8
#> 139         North Carolina  ACC       19.7           139         57.4
#> 140                Alabama  SEC       19.7           140         40.9
#> 141           Delaware St. MEAC       19.6           141         49.2
#> 142       Mount St. Mary's  NEC       19.6           142         49.1
#> 143       Georgia Southern   SB       19.6           143         49.8
#> 144               Southern SWAC       19.6           144         56.9
#> 145                   Duke  ACC       19.6           145         55.0
#> 146             Evansville  MVC       19.5           146         46.7
#> 147               Illinois  B10       19.5           147         57.3
#> 148             Seton Hall   BE       19.5           148         48.6
#> 149               Cal Poly   BW       19.5           149         51.4
#> 150     East Tennessee St.   SC       19.5           150         50.5
#> 151                   Rice CUSA       19.5           151         40.1
#> 152             Charleston  CAA       19.4           152         47.4
#> 153             Kansas St.  B12       19.4           153         49.5
#> 154       Tennessee Martin  OVC       19.4           154         50.4
#> 155                   Navy  Pat       19.4           155         50.6
#> 156              Air Force  MWC       19.3           156         45.0
#> 157               Longwood BSth       19.3           157         38.5
#> 158                 Howard MEAC       19.3           158         48.2
#> 159                Bradley  MVC       19.3           159         52.1
#> 160               UC Davis   BW       19.3           160         46.9
#> 161         St. Francis PA  NEC       19.2           161         55.4
#> 162         Long Beach St.   BW       19.2           162         54.5
#> 163         South Carolina  SEC       19.2           163         57.8
#> 164              Green Bay Horz       19.2           164         52.2
#> 165                   UNLV  MWC       19.2           165         49.5
#> 166              Idaho St. BSky       19.2           166         53.1
#> 167      Northern Kentucky Horz       19.1           167         46.8
#> 168                    USC  P12       19.1           168         53.3
#> 169                Florida  SEC       19.1           169         51.2
#> 170           Georgia Tech  ACC       19.0           170         58.5
#> 171        Sam Houston St. Slnd       19.0           171         51.5
#> 172               Portland  WCC       19.0           172         50.4
#> 173            McNeese St. Slnd       19.0           173         51.4
#> 174                 Hawaii   BW       19.0           174         49.8
#> 175      George Washington  A10       18.9           175         47.3
#> 176                   NJIT ASun       18.9           176         54.2
#> 177       Loyola Marymount  WCC       18.9           177         56.4
#> 178                 Wagner  NEC       18.8           178         51.6
#> 179                    SMU Amer       18.8           179         48.8
#> 180                Georgia  SEC       18.8           180         53.3
#> 181                Gonzaga  WCC       18.8           181         55.6
#> 182              Manhattan MAAC       18.8           182         48.4
#> 183                Wyoming  MWC       18.8           183         43.8
#> 184 North Carolina Central MEAC       18.8           184         54.0
#> 185                    LIU  NEC       18.8           185         44.4
#> 186                    VCU  A10       18.8           186         49.6
#> 187           Gardner Webb BSth       18.8           187         47.9
#> 188              San Diego  WCC       18.8           188         53.3
#> 189            Georgia St.   SB       18.8           189         48.5
#> 190           UT Arlington   SB       18.8           190         48.5
#> 191            Arizona St.  P12       18.8           191         51.5
#> 192         Loyola Chicago  MVC       18.7           192         56.4
#> 193              Milwaukee Horz       18.7           193         48.8
#> 194                Pacific  WCC       18.7           194         57.8
#> 195             St. John's   BE       18.6           195         54.7
#> 196       Louisiana Monroe   SB       18.6           196         51.4
#> 197                 DePaul   BE       18.6           197         57.3
#> 198 Texas A&M Corpus Chris Slnd       18.5           198         46.9
#> 199               La Salle  A10       18.5           199         46.2
#> 200            Saint Louis  A10       18.5           200         58.9
#> 201             Coppin St. MEAC       18.5           201         46.4
#> 202 Southeastern Louisiana Slnd       18.4           202         53.5
#> 203               Duquesne  A10       18.4           203         48.7
#> 204               Delaware  CAA       18.4           204         51.3
#> 205           Portland St. BSky       18.3           205         56.2
#> 206             Louisville  ACC       18.3           206         48.3
#> 207               Davidson  A10       18.3           207         44.3
#> 208                 Kansas  B12       18.3           208         56.4
#> 209       Northern Arizona BSky       18.2           209         52.2
#> 210                Harvard  Ivy       18.2           210         51.9
#> 211            Indiana St.  MVC       18.2           211         51.4
#> 212                    UCF Amer       18.2           212         50.9
#> 213    Central Connecticut  NEC       18.2           213         51.7
#> 214                   UMBC   AE       18.2           214         52.2
#> 215          UNC Asheville BSth       18.2           215         51.2
#> 216          Bowling Green  MAC       18.1           216         49.4
#> 217    Cal St. Bakersfield  WAC       18.1           217         59.4
#> 218         Saint Joseph's  A10       18.1           218         42.9
#> 219               Hartford   AE       18.1           219         46.7
#> 220         Youngstown St. Horz       18.0           220         51.7
#> 221           Michigan St.  B10       18.0           221         51.5
#> 222           Old Dominion CUSA       18.0           222         55.7
#> 223       SIU Edwardsville  OVC       18.0           223         56.7
#> 224               Miami FL  ACC       17.9           224         52.3
#> 225                 Bryant  NEC       17.9           225         46.6
#> 226            Florida St.  ACC       17.9           226         52.6
#> 227                  IUPUI Horz       17.9           227         48.5
#> 228                Vermont   AE       17.9           228         47.9
#> 229               Winthrop BSth       17.8           229         47.3
#> 230               Canisius MAAC       17.8           230         55.8
#> 231               Penn St.  B10       17.8           231         50.1
#> 232           Missouri St.  MVC       17.8           232         52.6
#> 233         New Mexico St.  WAC       17.7           233         44.5
#> 234                 Baylor  B12       17.7           234         50.0
#> 235       Middle Tennessee CUSA       17.7           235         46.0
#> 236           Saint Mary's  WCC       17.7           236         50.7
#> 237               Ball St.  MAC       17.6           237         43.0
#> 238     Cal St. Northridge   BW       17.6           238         52.1
#> 239                  Idaho BSky       17.6           239         60.3
#> 240         St. Francis NY  NEC       17.6           240         55.3
#> 241            The Citadel   SC       17.6           241         43.9
#> 242               Iowa St.  B12       17.6           242         52.9
#> 243                   UTSA CUSA       17.6           243         44.6
#> 244         William & Mary  CAA       17.6           244         50.8
#> 245          Massachusetts  A10       17.6           245         49.2
#> 246           Morehead St.  OVC       17.5           246         57.9
#> 247             Fresno St.  MWC       17.5           247         41.4
#> 248                   Troy   SB       17.5           248         44.7
#> 249           Oral Roberts  Sum       17.4           249         52.7
#> 250             Quinnipiac MAAC       17.4           250         38.0
#> 251    Fairleigh Dickinson  NEC       17.4           251         51.4
#> 252                 Marist MAAC       17.3           252         45.8
#> 253                Liberty ASun       17.3           253         50.8
#> 254                  Drake  MVC       17.3           254         50.4
#> 255           Jacksonville ASun       17.3           255         54.1
#> 256                   Yale  Ivy       17.2           256         47.0
#> 257       Jacksonville St.  OVC       17.2           257         54.0
#> 258                   Elon  CAA       17.2           258         39.3
#> 259                 Xavier   BE       17.2           259         55.4
#> 260                  Maine   AE       17.1           260         50.2
#> 261         Boston College  ACC       17.1           261         49.5
#> 262                   UMKC  WAC       17.1           262         52.3
#> 263       South Dakota St.  Sum       17.0           263         54.3
#> 264                 Butler   BE       17.0           264         53.1
#> 265                 Dayton  A10       17.0           265         52.9
#> 266          San Francisco  WCC       17.0           266         47.9
#> 267            North Texas CUSA       17.0           267         48.5
#> 268              Wisconsin  B10       17.0           268         44.3
#> 269        St. Bonaventure  A10       16.9           269         54.1
#> 270               Stanford  P12       16.9           270         52.5
#> 271                 Furman   SC       16.9           271         46.3
#> 272               Virginia  ACC       16.9           272         53.3
#> 273               Richmond  A10       16.8           273         51.2
#> 274                 Drexel  CAA       16.8           274         50.9
#> 275               Kent St.  MAC       16.8           275         50.8
#> 276           Northwestern  B10       16.7           276         55.1
#> 277                 Nevada  MWC       16.7           277         44.4
#> 278               Miami OH  MAC       16.7           278         47.3
#> 279          North Florida ASun       16.7           279         38.2
#> 280 Maryland Eastern Shore MEAC       16.7           280         52.7
#> 281          San Diego St.  MWC       16.7           281         46.7
#> 282                Radford BSth       16.6           282         51.1
#> 283             N.C. State  ACC       16.6           283         55.5
#> 284                Fordham  A10       16.6           284         46.6
#> 285              UC Irvine   BW       16.6           285         57.6
#> 286                   Ohio  MAC       16.6           286         47.7
#> 287               Lipscomb ASun       16.5           287         53.8
#> 288                Clemson  ACC       16.5           288         46.9
#> 289    Charleston Southern BSth       16.5           289         47.4
#> 290               Bucknell  Pat       16.5           290         47.1
#> 291         Nebraska Omaha  Sum       16.5           291         57.7
#> 292              Weber St. BSky       16.5           292         55.9
#> 293          Tennessee St.  OVC       16.5           293         52.2
#> 294            Chattanooga   SC       16.4           294         48.1
#> 295      Northern Illinois  MAC       16.4           295         50.6
#> 296       Illinois Chicago Horz       16.4           296         52.0
#> 297     Eastern Washington BSky       16.4           297         48.4
#> 298              Creighton   BE       16.3           298         46.0
#> 299               American  Pat       16.3           299         54.9
#> 300       Florida Atlantic CUSA       16.3           300         49.0
#> 301              Villanova   BE       16.2           301         43.2
#> 302           Nicholls St. Slnd       16.2           302         52.7
#> 303              Minnesota  B10       16.1           303         48.9
#> 304                Buffalo  MAC       16.1           304         53.3
#> 305                Rutgers  B10       16.1           305         60.5
#> 306           UC Riverside   BW       16.1           306         46.8
#> 307                 Lehigh  Pat       16.1           307         58.5
#> 308       Eastern Illinois  OVC       16.0           308         56.5
#> 309              Princeton  Ivy       16.0           309         47.1
#> 310          Northern Iowa  MVC       16.0           310         47.3
#> 311               Marshall CUSA       16.0           311         53.4
#> 312                Cornell  Ivy       16.0           312         51.8
#> 313             Valparaiso  MVC       15.9           313         49.9
#> 314                 Mercer   SC       15.8           314         51.9
#> 315               Nebraska  B10       15.7           315         50.3
#> 316                 Oregon  P12       15.7           316         50.0
#> 317              Dartmouth  Ivy       15.7           317         52.7
#> 318                 Purdue  B10       15.7           318         52.7
#> 319           Northeastern  CAA       15.6           319         50.0
#> 320                Niagara MAAC       15.6           320         49.8
#> 321          New Hampshire   AE       15.5           321         46.6
#> 322                    FIU CUSA       15.5           322         49.9
#> 323         Louisiana Tech CUSA       15.4           323         51.2
#> 324             Notre Dame  ACC       15.4           324         45.5
#> 325               Michigan  B10       15.3           325         52.8
#> 326              Merrimack  NEC       15.3           326         47.7
#> 327                Montana BSky       15.2           327         60.3
#> 328               Columbia  Ivy       15.1           328         55.1
#> 329       Western Illinois  Sum       15.1           329         49.0
#> 330          Southern Miss CUSA       15.1           330         61.0
#> 331           Illinois St.  MVC       15.0           331         46.2
#> 332                Colgate  Pat       15.0           332         45.4
#> 333               Campbell BSth       14.9           333         51.1
#> 334                    TCU  B12       14.8           334         45.8
#> 335 Mississippi Valley St. SWAC       14.7           335         49.2
#> 336                Wofford   SC       14.6           336         46.2
#> 337      Boston University  Pat       14.6           337         57.9
#> 338          Robert Morris  NEC       14.6           338         49.8
#> 339             Binghamton   AE       14.5           339         43.6
#> 340     Florida Gulf Coast ASun       14.5           340         50.6
#> 341             Holy Cross  Pat       14.4           341         53.8
#> 342              Lafayette  Pat       14.4           342         49.7
#> 343      Purdue Fort Wayne  Sum       14.3           343         49.0
#> 344          Virginia Tech  ACC       13.9           344         43.0
#> 345         UNC Greensboro   SC       13.7           345         50.4
#> 346                   Penn  Ivy       13.5           346         51.0
#> 347      Northern Colorado BSky       13.5           347         46.5
#> 348         Tennessee Tech  OVC       13.5           348         48.4
#> 349                    VMI   SC       13.2           349         41.4
#> 350                  Texas  B12       13.1           350         49.5
#> 351                   Army  Pat       13.0           351         57.5
#> 352                Belmont  OVC       12.9           352         50.9
#> 353                    BYU  WCC       12.3           353         48.5
#>     Off.FG_2.Pct.Rk Off.FG_3.Pct Off.FG_3.Pct.Rk Def.FT.Pct Def.FT.Pct.Rk
#> 1               230         24.8             307       23.1            26
#> 2               263         27.0             269       21.4            68
#> 3                51         20.4             349       19.6           131
#> 4                69         21.6             342       19.7           124
#> 5                50         20.5             347       19.8           118
#> 6               218         26.9             272       19.9           113
#> 7                40         20.7             346       20.5            88
#> 8                61         21.6             341       27.1             4
#> 9               245         28.0             241       18.3           202
#> 10              204         26.7             275       26.3             7
#> 11              299         30.0             189       23.2            24
#> 12              152         25.3             302       19.6           130
#> 13               25         19.6             351       26.4             6
#> 14              219         27.4             260       13.4           346
#> 15              281         29.9             193       16.6           272
#> 16              224         27.9             246       24.1            18
#> 17              268         29.6             210       27.3             2
#> 18              280         30.1             188       23.9            20
#> 19              283         30.2             184       19.2           147
#> 20              313         31.3             152       20.5            91
#> 21                3         16.6             353       22.2            48
#> 22               60         22.7             331       15.4           323
#> 23               90         24.3             312       18.3           197
#> 24              316         32.1             131       15.5           318
#> 25               52         22.3             337       18.7           176
#> 26               35         21.2             344       19.4           138
#> 27               46         22.1             339       15.4           321
#> 28              333         34.2              87       20.5            90
#> 29               55         22.6             332       24.6            15
#> 30              256         29.5             211       22.1            52
#> 31              129         25.8             290       18.0           216
#> 32              171         27.0             270       21.4            69
#> 33               66         23.5             321       20.1           109
#> 34              207         28.1             238       16.5           279
#> 35               59         23.0             327       21.2            75
#> 36              131         26.0             286       17.8           224
#> 37               71         23.7             318       21.4            67
#> 38              350         38.7              23       19.8           119
#> 39              114         25.7             291       18.6           177
#> 40              192         27.9             245       18.9           162
#> 41              103         25.3             300       21.1            77
#> 42              173         27.3             263       18.5           185
#> 43               28         21.3             343       22.9            33
#> 44              126         26.1             284       20.0           110
#> 45              194         28.2             235       19.1           153
#> 46               79         24.4             311       15.7           311
#> 47              117         26.1             285       24.0            19
#> 48              266         30.7             164       17.5           245
#> 49               15         20.5             348       20.4            99
#> 50              116         26.1             283       17.5           238
#> 51               67         24.2             313       23.2            25
#> 52              344         36.4              48       18.2           207
#> 53              160         27.4             261       22.6            38
#> 54              174         27.9             244       17.4           252
#> 55              217         29.2             218       20.4           100
#> 56              264         30.8             162       23.0            31
#> 57              143         27.1             265       13.1           350
#> 58              341         36.3              51       17.8           223
#> 59              303         32.3             126       19.0           158
#> 60                1         17.6             352       21.3            70
#> 61              339         35.7              62       18.1           210
#> 62               26         21.8             340       23.0            30
#> 63               93         25.7             292       17.4           251
#> 64              111         26.2             282       20.4            94
#> 65               43         23.1             326       18.8           168
#> 66              336         35.7              64       16.1           297
#> 67              191         28.7             227       21.6            63
#> 68              154         27.6             253       15.1           327
#> 69              189         28.6             228       16.9           264
#> 70               56         23.9             317       21.9            57
#> 71              106         26.2             281       19.4           139
#> 72               41         23.2             325       17.5           246
#> 73               92         25.9             287       16.1           295
#> 74              247         30.5             174       17.5           237
#> 75              134         27.1             266       18.9           163
#> 76              211         29.4             217       16.0           300
#> 77               62         24.2             314       22.2            46
#> 78              182         28.6             231       22.2            51
#> 79              305         32.8             110       17.4           250
#> 80              342         36.8              40       17.4           253
#> 81              328         35.0              75       18.0           214
#> 82              275         31.9             134       16.5           276
#> 83                8         19.8             350       24.3            17
#> 84              236         30.5             175       21.8            60
#> 85              238         30.6             169       19.8           122
#> 86               78         25.3             304       17.4           249
#> 87              250         30.8             163       17.9           218
#> 88              141         27.7             250       16.2           292
#> 89              119         27.0             267       20.7            85
#> 90              229         30.3             181       18.8           170
#> 91              296         32.7             116       18.6           181
#> 92              260         31.3             149       19.0           156
#> 93               77         25.4             299       15.8           307
#> 94              295         32.7             114       12.7           352
#> 95              243         30.9             159       14.5           332
#> 96              130         27.4             257       17.7           227
#> 97              180         28.9             222       15.6           313
#> 98               65         25.0             305       18.5           189
#> 99               72         25.4             297       15.5           319
#> 100             155         28.3             233       18.0           212
#> 101             110         27.0             268       18.8           171
#> 102             123         27.4             259       13.8           341
#> 103              37         23.5             320       22.1            53
#> 104              29         22.8             329       21.8            58
#> 105             138         27.9             243       19.7           123
#> 106             294         33.1             106       18.3           196
#> 107             309         33.7              96       16.3           288
#> 108             343         37.5              31       16.3           287
#> 109             200         29.9             195       14.4           336
#> 110             300         33.2             104       22.6            39
#> 111              10         21.0             345       24.3            16
#> 112             165         28.8             224       22.0            55
#> 113              95         26.8             274       18.2           208
#> 114             253         31.5             147       20.4            97
#> 115             330         36.0              55       17.0           261
#> 116             137         28.1             239       20.5            89
#> 117             203         30.1             186       21.0            78
#> 118             269         32.5             119       16.9           266
#> 119              22         22.5             334       16.2           293
#> 120             163         28.9             221       24.7            14
#> 121             327         35.9              60       16.6           274
#> 122             209         30.4             178       16.4           281
#> 123             277         32.9             108       23.1            27
#> 124             334         36.8              42       18.4           194
#> 125              82         26.4             277       17.0           263
#> 126             254         31.8             138       18.2           206
#> 127             234         31.3             151       21.6            65
#> 128             133         28.2             236       17.2           256
#> 129             251         31.8             140       19.7           127
#> 130             221         30.9             161       13.1           349
#> 131             176         29.5             214       18.5           186
#> 132             311         34.1              89       15.2           326
#> 133             108         27.5             254       21.3            71
#> 134             128         28.1             237       24.9            11
#> 135             187         29.8             198       21.0            79
#> 136              99         27.4             262       17.1           257
#> 137             257         32.1             132       14.5           333
#> 138             289         33.5              98       18.6           178
#> 139              21         22.8             330       18.3           198
#> 140             347         39.4              13       21.7            61
#> 141             223         31.2             156       22.4            42
#> 142             225         31.2             153       17.5           242
#> 143             202         30.6             170       16.5           277
#> 144              27         23.5             319       25.5             9
#> 145              57         25.4             294       18.5           191
#> 146             292         33.8              95       19.1           154
#> 147              23         23.2             324       15.5           317
#> 148             237         31.9             135       19.9           114
#> 149             150         29.1             219       23.1            28
#> 150             181         30.0             190       18.9           166
#> 151             348         40.5              10       16.2           294
#> 152             270         33.1             105       19.8           121
#> 153             215         31.1             158       21.5            66
#> 154             186         30.2             183       14.4           335
#> 155             178         30.0             191       16.8           268
#> 156             319         35.6              66       16.0           301
#> 157             351         42.2               6       18.8           167
#> 158             255         32.5             117       18.2           205
#> 159             125         28.6             229       20.1           107
#> 160             285         33.8              93       19.2           145
#> 161              47         25.3             301       16.4           286
#> 162              64         26.3             280       17.0           262
#> 163              16         22.9             328       30.0             1
#> 164             121         28.6             230       19.5           134
#> 165             213         31.3             150       22.9            34
#> 166              94         27.8             249       15.6           315
#> 167             287         34.0              91       18.4           195
#> 168              86         27.5             255       18.0           215
#> 169             159         29.8             203       20.4            95
#> 170              11         22.5             336       22.2            45
#> 171             144         29.5             215       24.7            13
#> 172             185         30.6             172       16.7           271
#> 173             149         29.6             206       17.8           225
#> 174             201         31.2             155       19.3           140
#> 175             274         33.8              94       17.6           235
#> 176              70         26.9             273       19.3           142
#> 177              34         24.7             308       21.2            73
#> 178             142         29.6             208       23.1            29
#> 179             232         32.4             122       17.5           243
#> 180              87         27.9             248       17.1           259
#> 181              44         25.6             293       13.8           342
#> 182             246         32.7             112       24.9            12
#> 183             331         37.4              32       20.3           103
#> 184              75         27.2             264       19.7           125
#> 185             324         36.8              41       16.9           265
#> 186             210         31.6             144       20.8            81
#> 187             261         33.3             101       18.5           190
#> 188              89         27.9             242       18.5           187
#> 189             239         32.7             115       26.6             5
#> 190             240         32.7             113       20.7            84
#> 191             146         29.8             202       19.2           149
#> 192              33         24.9             306       13.1           348
#> 193             233         32.5             118       23.7            21
#> 194              17         23.5             322       23.5            23
#> 195              63         26.6             276       20.4            98
#> 196             148         30.0             192       20.1           108
#> 197              24         24.1             315       21.3            72
#> 198             286         34.6              81       23.6            22
#> 199             308         35.3              70       22.8            36
#> 200               9         22.6             333       21.6            64
#> 201             302         35.1              73       17.5           239
#> 202              83         28.0             240       22.9            35
#> 203             235         32.9             109       16.7           270
#> 204             153         30.3             179       18.2           203
#> 205              36         25.4             295       17.8           220
#> 206             252         33.3             102       19.0           159
#> 207             326         37.4              34       19.0           157
#> 208              32         25.3             303       15.1           328
#> 209             118         29.5             213       16.1           296
#> 210             132         29.9             197       18.9           165
#> 211             151         30.5             177       18.8           169
#> 212             167         30.9             160       18.7           175
#> 213             139         30.2             185       17.8           221
#> 214             120         29.6             204       20.2           105
#> 215             158         30.7             165       18.2           204
#> 216             216         32.4             121       19.1           155
#> 217               7         22.5             335       26.1             8
#> 218             340         39.0              19       18.0           211
#> 219             290         35.2              72       18.3           199
#> 220             140         30.3             180       17.7           232
#> 221             145         30.5             176       19.2           146
#> 222              42         26.3             279       20.2           104
#> 223              30         25.4             298       22.5            40
#> 224             114         29.8             201       14.0           340
#> 225             297         35.5              68       17.8           226
#> 226             109         29.5             212       21.2            76
#> 227             242         33.7              97       16.4           282
#> 228             262         34.3              86       20.0           112
#> 229             276         34.9              77       21.7            62
#> 230              39         26.4             278       19.6           132
#> 231             193         32.1             130       19.0           160
#> 232             107         29.6             207       19.2           148
#> 233             322         37.8              29       19.1           152
#> 234             197         32.3             125       19.0           161
#> 235             312         36.3              50       20.4            96
#> 236             175         31.7             141       16.5           278
#> 237             337         39.3              15       17.7           229
#> 238             124         30.3             182       16.1           298
#> 239               6         22.1             338       16.4           280
#> 240              49         27.0             271       20.8            83
#> 241             329         38.5              24       15.4           322
#> 242              97         29.6             209       15.8           309
#> 243             321         37.8              28       20.6            87
#> 244             172         31.7             142       16.0           299
#> 245             220         33.2             103       18.6           182
#> 246              13         24.6             309       17.2           255
#> 247             346         41.1               8       17.7           231
#> 248             320         37.8              27       20.2           106
#> 249             104         29.9             196       18.5           192
#> 250             353         44.5               3       14.1           338
#> 251             147         31.2             154       17.5           240
#> 252             314         36.8              38       22.4            41
#> 253             169         31.8             137       17.9           219
#> 254             184         32.2             128       18.4           193
#> 255              73         28.6             232       18.0           213
#> 256             282         35.8              61       16.8           267
#> 257              76         28.8             223       15.9           305
#> 258             349         43.5               4       22.9            32
#> 259              48         27.5             256       18.5           188
#> 260             190         32.7             111       19.9           115
#> 261             212         33.4              99       17.5           244
#> 262             113         30.6             166       27.2             3
#> 263              68         28.7             226       15.5           316
#> 264              91         29.9             194       19.5           135
#> 265              96         30.1             187       17.6           234
#> 266             259         35.1              74       18.6           184
#> 267             244         34.6              83       21.2            74
#> 268             325         38.8              21       15.8           306
#> 269              74         29.0             220       18.7           172
#> 270             112         30.6             167       19.6           133
#> 271             304         36.8              43       16.0           302
#> 272              88         29.8             200       14.7           330
#> 273             156         32.0             133       17.7           230
#> 274             168         32.4             123       18.3           201
#> 275             170         32.4             120       20.7            86
#> 276              54         28.2             234       17.0           260
#> 277             323         38.8              20       21.8            59
#> 278             272         35.9              57       19.7           129
#> 279             352         45.1               2       16.4           284
#> 280             101         30.6             171       20.0           111
#> 281             291         36.6              46       19.7           126
#> 282             161         32.2             127       18.7           173
#> 283              45         27.9             246       20.3           101
#> 284             298         36.8              38       19.3           141
#> 285              19         25.8             288       22.2            49
#> 286             265         35.7              63       20.9            80
#> 287              81         29.6             205       15.3           324
#> 288             284         36.5              47       17.5           241
#> 289             271         36.1              53       16.4           285
#> 290             279         36.4              49       20.5            93
#> 291              18         25.8             289       17.1           258
#> 292              38         27.6             251       13.5           345
#> 293             122         31.4             148       22.7            37
#> 294             258         35.5              67       15.8           308
#> 295             177         33.0             107       19.8           120
#> 296             127         31.6             145       20.8            82
#> 297             248         35.2              71       19.4           136
#> 298             310         37.6              30       14.5           334
#> 299              58         28.8             225       20.5            92
#> 300             226         34.7              79       16.8           269
#> 301             335         40.6               9       14.7           331
#> 302             105         31.1             157       22.4            43
#> 303             231         35.0              76       17.8           222
#> 304              85         30.5             173       18.6           183
#> 305               4         23.4             323       17.9           217
#> 306             288         37.1              35       19.3           143
#> 307              12         25.4             296       18.3           200
#> 308              31         27.4             258       20.3           102
#> 309             278         36.9              37       16.2           290
#> 310             273         36.7              44       15.4           320
#> 311              84         30.6             168       22.0            54
#> 312             136         32.2             129       17.6           236
#> 313             199         34.2              88       17.4           248
#> 314             135         32.3             124       19.2           151
#> 315             188         34.0              92       12.4           353
#> 316             196         34.3              85       18.6           180
#> 317             100         31.6             145       16.2           291
#> 318             102         31.6             143       19.4           137
#> 319             195         34.4              84       17.7           233
#> 320             205         34.7              80       15.6           312
#> 321             293         37.8              26       22.2            47
#> 322             198         34.6              82       18.9           164
#> 323             157         33.4             100       19.7           128
#> 324             317         39.1              18       13.0           351
#> 325              98         31.9             136       16.3           289
#> 326             267         37.1              36       21.9            56
#> 327               5         24.5             310       25.5            10
#> 328              53         29.8             199       14.2           337
#> 329             227         35.9              58       19.2           144
#> 330               2         24.0             316       19.2           150
#> 331             306         38.8              22       17.7           228
#> 332             318         39.6              12       13.5           344
#> 333             162         34.1              90       22.4            44
#> 334             315         39.4              14       17.3           254
#> 335             222         36.0              54       18.6           179
#> 336             307         39.2              16       18.1           209
#> 337              14         27.6             252       14.9           329
#> 338             206         35.7              65       18.7           174
#> 339             332         41.9               7       15.8           310
#> 340             179         34.9              78       17.4           247
#> 341              80         31.8             139       16.5           275
#> 342             208         35.9              56       13.3           347
#> 343             228         36.7              45       16.4           283
#> 344             338         43.1               5       15.6           314
#> 345             183         35.9              59       19.8           117
#> 346             164         35.5              69       15.9           303
#> 347             301         40.0              11       15.3           325
#> 348             249         38.1              25       15.9           304
#> 349             345         45.4               1       22.2            50
#> 350             214         37.4              33       19.9           116
#> 351              20         29.4             216       13.7           343
#> 352             166         36.2              52       14.1           339
#> 353             241         39.2              17       16.6           273
#>     Def.FG_2.Pct Def.FG_2.Pct.Rk Def.FG_3.Pct Def.FG_3.Pct.Rk NCAA_Seed Year
#> 1           51.1             151         25.7             310        NA 2020
#> 2           45.0             326         33.6              85        NA 2020
#> 3           49.1             218         31.3             153         4 2020
#> 4           51.1             152         29.2             228        NA 2020
#> 5           53.5              77         26.7             295        NA 2020
#> 6           51.6             132         28.4             255        NA 2020
#> 7           53.3              87         26.2             300        NA 2020
#> 8           44.4             332         28.5             251        NA 2020
#> 9           41.7             349         40.0               6        NA 2020
#> 10          51.6             134         22.1             348        NA 2020
#> 11          54.7              51         22.1             349        NA 2020
#> 12          47.7             266         32.7             105        15 2020
#> 13          48.9             227         24.8             324        16 2020
#> 14          56.8              20         29.8             199        NA 2020
#> 15          41.5             352         41.9               1        NA 2020
#> 16          47.3             278         28.5             250        NA 2020
#> 17          47.0             289         25.7             314        NA 2020
#> 18          50.9             157         25.2             319        NA 2020
#> 19          48.5             237         32.3             122        NA 2020
#> 20          49.7             201         29.8             198         5 2020
#> 21          47.3             277         30.5             177        NA 2020
#> 22          52.5             109         32.2             127        NA 2020
#> 23          48.6             233         33.0              99        NA 2020
#> 24          50.4             173         34.1              72         3 2020
#> 25          48.8             229         32.5             113        NA 2020
#> 26          52.2             117         28.4             257        NA 2020
#> 27          43.7             338         40.9               3        NA 2020
#> 28          52.6             105         26.9             288        NA 2020
#> 29          45.7             312         29.7             201        12 2020
#> 30          50.9             158         27.0             284        NA 2020
#> 31          42.2             348         39.8               7        NA 2020
#> 32          49.2             214         29.4             214        NA 2020
#> 33          48.5             238         31.4             148        NA 2020
#> 34          51.8             124         31.7             139        NA 2020
#> 35          44.8             329         34.0              73        NA 2020
#> 36          45.8             310         36.4              26        NA 2020
#> 37          46.0             309         32.6             109        NA 2020
#> 38          51.3             146         28.9             242         9 2020
#> 39          50.2             187         31.2             156        NA 2020
#> 40          54.1              67         27.0             285        NA 2020
#> 41          55.2              38         23.7             340        NA 2020
#> 42          52.1             118         29.3             218        NA 2020
#> 43          49.0             221         28.1             266         6 2020
#> 44          45.7             311         34.3              66        11 2020
#> 45          45.3             318         35.6              42        NA 2020
#> 46          50.2             188         34.2              70        NA 2020
#> 47          51.8             125         24.2             335        NA 2020
#> 48          55.3              37         27.2             282        NA 2020
#> 49          48.3             246         31.3             152        NA 2020
#> 50          48.5             240         34.0              75        NA 2020
#> 51          47.2             284         29.5             208        NA 2020
#> 52          57.5              14         24.4             333        NA 2020
#> 53          48.6             234         28.8             245        NA 2020
#> 54          52.6             104         30.0             194        NA 2020
#> 55          47.3             279         32.3             118        NA 2020
#> 56          44.5             330         32.5             114        NA 2020
#> 57          46.7             296         40.3               4        NA 2020
#> 58          49.1             217         33.1              97        NA 2020
#> 59          51.6             135         29.4             213        NA 2020
#> 60          54.0              68         24.6             328        NA 2020
#> 61          53.3              83         28.5             254        NA 2020
#> 62          48.7             231         28.3             260        NA 2020
#> 63          46.7             294         35.9              36        NA 2020
#> 64          45.7             314         33.9              78        NA 2020
#> 65          49.6             205         31.6             142        10 2020
#> 66          50.6             166         33.4              91        NA 2020
#> 67          53.4              81         25.0             321        NA 2020
#> 68          48.8             230         36.1              32        NA 2020
#> 69          46.7             295         36.4              27        11 2020
#> 70          50.4             170         27.7             276        NA 2020
#> 71          51.3             144         29.3             220        NA 2020
#> 72          53.3              84         29.2             229        NA 2020
#> 73          46.2             307         37.7              13        NA 2020
#> 74          51.6             131         30.8             167        NA 2020
#> 75          50.0             195         31.1             160        12 2020
#> 76          48.9             225         35.1              48        NA 2020
#> 77          50.4             175         27.4             280        NA 2020
#> 78          47.6             271         30.3             186         7 2020
#> 79          54.2              65         28.4             256        NA 2020
#> 80          53.7              74         29.0             238        13 2020
#> 81          47.6             270         34.4              61         5 2020
#> 82          54.2              66         29.3             219         8 2020
#> 83          50.4             176         25.3             318        NA 2020
#> 84          49.8             197         28.4             258         8 2020
#> 85          52.6             106         27.7             275        NA 2020
#> 86          42.4             345         40.2               5        NA 2020
#> 87          51.3             147         30.8             166        NA 2020
#> 88          54.5              57         29.3             222        NA 2020
#> 89          53.2              91         26.2             301        NA 2020
#> 90          49.3             212         31.9             134        NA 2020
#> 91          42.4             344         39.0               9        NA 2020
#> 92          49.0             222         32.0             132        NA 2020
#> 93          51.6             133         32.6             107        NA 2020
#> 94          58.0               8         29.2             227        14 2020
#> 95          54.7              49         30.8             168        NA 2020
#> 96          53.3              85         28.9             240        NA 2020
#> 97          52.4             111         32.0             133        NA 2020
#> 98          54.5              58         27.0             286        NA 2020
#> 99          47.9             259         36.6              22         8 2020
#> 100         51.0             156         31.0             162        NA 2020
#> 101         50.1             190         31.2             159        NA 2020
#> 102         49.8             200         36.4              25        NA 2020
#> 103         54.3              62         23.6             342        NA 2020
#> 104         47.2             285         31.0             164        NA 2020
#> 105         44.1             337         36.2              30        NA 2020
#> 106         46.3             304         35.3              45        NA 2020
#> 107         48.6             235         35.1              47        NA 2020
#> 108         58.1               7         25.6             315        15 2020
#> 109         53.9              69         31.8             138        NA 2020
#> 110         46.5             302         31.0             163        NA 2020
#> 111         49.0             219         26.6             297        NA 2020
#> 112         51.1             153         27.0             287        NA 2020
#> 113         51.7             127         30.1             192        NA 2020
#> 114         53.7              76         25.9             308        NA 2020
#> 115         45.2             322         37.8              12        NA 2020
#> 116         52.8             101         26.7             293        NA 2020
#> 117         50.7             164         28.3             259        10 2020
#> 118         47.5             272         35.6              40        NA 2020
#> 119         47.7             268         36.1              31        NA 2020
#> 120         46.2             306         29.1             232         7 2020
#> 121         48.9             224         34.5              60        NA 2020
#> 122         51.0             155         32.5             112         6 2020
#> 123         49.3             213         27.6             277        11 2020
#> 124         50.4             177         31.3             155        NA 2020
#> 125         52.9              99         30.2             191        NA 2020
#> 126         57.1              17         24.8             325        NA 2020
#> 127         48.2             250         30.3             188        NA 2020
#> 128         57.1              16         25.7             313        NA 2020
#> 129         53.7              75         26.7             294        NA 2020
#> 130         49.3             210         37.6              14        10 2020
#> 131         47.2             282         34.2              67        NA 2020
#> 132         55.5              35         29.3             215        NA 2020
#> 133         54.6              53         24.1             338        NA 2020
#> 134         41.5             353         33.6              84        NA 2020
#> 135         47.7             267         31.4             150        NA 2020
#> 136         54.4              61         28.5             252        16 2020
#> 137         49.2             216         36.3              28        NA 2020
#> 138         55.6              31         25.7             312        NA 2020
#> 139         47.1             287         34.6              57        NA 2020
#> 140         51.7             129         26.6             298        NA 2020
#> 141         46.9             291         30.7             172        NA 2020
#> 142         50.2             180         32.3             121        NA 2020
#> 143         54.8              45         28.7             247        NA 2020
#> 144         51.3             143         23.1             345        NA 2020
#> 145         60.2               4         21.4             350         3 2020
#> 146         56.8              21         24.2             337        NA 2020
#> 147         55.5              33         28.9             239         7 2020
#> 148         51.1             154         29.0             235         3 2020
#> 149         47.9             260         29.0             236        NA 2020
#> 150         51.5             137         29.6             207        11 2020
#> 151         52.5             110         31.4             149        NA 2020
#> 152         49.6             203         30.6             175        NA 2020
#> 153         47.0             288         31.5             147        NA 2020
#> 154         49.8             198         35.8              38        NA 2020
#> 155         48.8             228         34.4              62        NA 2020
#> 156         42.9             341         41.1               2        NA 2020
#> 157         45.1             323         36.0              34        NA 2020
#> 158         52.1             121         29.7             203        NA 2020
#> 159         44.3             333         35.6              41        14 2020
#> 160         50.8             160         30.0             195        NA 2020
#> 161         51.3             148         32.4             116        NA 2020
#> 162         48.3             245         34.7              54        NA 2020
#> 163         42.6             343         27.4             278        NA 2020
#> 164         48.3             247         32.2             126        NA 2020
#> 165         43.4             339         33.7              82        NA 2020
#> 166         63.2               3         21.2             351        NA 2020
#> 167         55.1              40         26.5             299        15 2020
#> 168         48.0             257         34.0              74         9 2020
#> 169         50.7             162         28.9             243         9 2020
#> 170         53.4              82         24.4             332        NA 2020
#> 171         45.0             327         30.3             184        NA 2020
#> 172         49.8             199         33.5              86        NA 2020
#> 173         47.4             276         34.8              51        NA 2020
#> 174         57.7              11         22.9             346        NA 2020
#> 175         57.7              12         24.7             326        NA 2020
#> 176         52.1             120         28.6             249        NA 2020
#> 177         44.4             331         34.3              64        NA 2020
#> 178         42.4             346         34.6              58        NA 2020
#> 179         45.3             319         37.2              16        NA 2020
#> 180         55.6              32         27.3             281        NA 2020
#> 181         56.6              23         29.6             206         1 2020
#> 182         48.0             256         27.1             283        NA 2020
#> 183         46.6             297         33.1              96        NA 2020
#> 184         50.8             159         29.5             209        16 2020
#> 185         53.5              78         29.6             205        NA 2020
#> 186         50.2             184         29.0             237        NA 2020
#> 187         46.9             290         34.6              58        NA 2020
#> 188         56.8              19         24.6             329        NA 2020
#> 189         48.4             241         25.0             323        NA 2020
#> 190         53.2              89         26.1             304        NA 2020
#> 191         49.6             204         31.2             157        10 2020
#> 192         47.4             274         39.4               8        NA 2020
#> 193         48.1             254         28.2             262        NA 2020
#> 194         47.7             264         28.8             246        NA 2020
#> 195         46.5             303         33.1              94        NA 2020
#> 196         50.4             171         29.5             210        NA 2020
#> 197         45.3             317         33.4              89        NA 2020
#> 198         50.7             163         25.7             311        NA 2020
#> 199         50.4             172         26.7             291        NA 2020
#> 200         45.5             316         32.9             102        NA 2020
#> 201         47.9             262         34.6              56        NA 2020
#> 202         51.6             130         25.5             316        NA 2020
#> 203         54.4              60         28.9             241        NA 2020
#> 204         48.4             242         33.4              88        NA 2020
#> 205         57.9              10         24.3             334        NA 2020
#> 206         47.7             263         33.3              92         4 2020
#> 207         50.8             161         30.2             190        NA 2020
#> 208         48.3             248         36.6              21         1 2020
#> 209         52.3             114         31.6             143        NA 2020
#> 210         50.5             168         30.6             173        NA 2020
#> 211         53.1              96         28.2             265        NA 2020
#> 212         51.5             136         29.7             200        NA 2020
#> 213         48.4             243         33.8              80        NA 2020
#> 214         44.2             334         35.6              43        NA 2020
#> 215         56.5              25         25.4             317        NA 2020
#> 216         49.2             215         31.7             140        NA 2020
#> 217         41.6             351         32.2             124        NA 2020
#> 218         53.2              92         28.8             244        NA 2020
#> 219         53.8              72         27.9             272        NA 2020
#> 220         53.8              71         28.5             253        NA 2020
#> 221         50.4             174         30.3             181         3 2020
#> 222         41.7             350         38.0              11        NA 2020
#> 223         46.8             292         30.7             170        NA 2020
#> 224         55.8              30         30.3             187        NA 2020
#> 225         53.2              93         29.1             234        NA 2020
#> 226         46.7             293         32.1             128         2 2020
#> 227         49.7             202         33.9              77        NA 2020
#> 228         45.0             325         35.0              49        13 2020
#> 229         50.2             181         28.0             267        16 2020
#> 230         51.3             145         29.1             231        NA 2020
#> 231         53.1              95         28.0             271         6 2020
#> 232         48.9             226         31.9             135        NA 2020
#> 233         51.1             150         29.7             202        13 2020
#> 234         51.8             126         29.3             223         1 2020
#> 235         51.4             141         28.2             264        NA 2020
#> 236         56.8              22         26.8             290         8 2020
#> 237         54.2              63         28.0             269        NA 2020
#> 238         47.6             269         36.3              29        NA 2020
#> 239         52.7             102         30.9             165        NA 2020
#> 240         51.3             142         27.9             273        NA 2020
#> 241         50.3             178         34.3              63        NA 2020
#> 242         52.0             122         32.2             123        NA 2020
#> 243         47.4             275         32.0             131        NA 2020
#> 244         51.9             123         32.1             129        NA 2020
#> 245         56.3              28         25.1             320        NA 2020
#> 246         52.4             112         30.4             178        NA 2020
#> 247         45.0             324         37.3              15        NA 2020
#> 248         48.7             232         31.2             158        NA 2020
#> 249         50.2             185         31.3             151        NA 2020
#> 250         52.5             107         33.4              90        NA 2020
#> 251         49.9             196         32.6             111        NA 2020
#> 252         42.8             342         34.7              53        NA 2020
#> 253         50.2             182         31.9             136        12 2020
#> 254         45.6             315         36.0              35        NA 2020
#> 255         50.2             186         31.8             137        NA 2020
#> 256         50.2             179         32.9             101        12 2020
#> 257         53.8              70         30.3             183        NA 2020
#> 258         43.3             340         33.8              81        NA 2020
#> 259         52.4             113         29.1             230        NA 2020
#> 260         45.0             328         35.1              46        NA 2020
#> 261         52.1             119         30.4             179        NA 2020
#> 262         50.2             183         22.6             347        NA 2020
#> 263         54.5              55         29.9             196        NA 2020
#> 264         47.5             273         33.0             100         5 2020
#> 265         53.3              86         29.1             233         1 2020
#> 266         54.7              50         26.7             292        NA 2020
#> 267         48.1             253         30.7             171        13 2020
#> 268         54.9              42         29.3             223         4 2020
#> 269         44.2             335         37.1              17        NA 2020
#> 270         51.2             149         29.2             225        NA 2020
#> 271         51.4             140         32.6             108        NA 2020
#> 272         48.2             249         37.0              18         7 2020
#> 273         50.0             194         32.3             117        11 2020
#> 274         58.1               6         23.6             341        NA 2020
#> 275         49.0             223         30.4             180        NA 2020
#> 276         46.5             301         36.5              24        NA 2020
#> 277         45.2             321         32.9             104        NA 2020
#> 278         47.3             280         33.1              98        NA 2020
#> 279         64.3               2         19.3             352        NA 2020
#> 280         49.3             209         30.7             169        NA 2020
#> 281         46.3             305         34.0              76         2 2020
#> 282         45.2             320         36.1              33        NA 2020
#> 283         53.7              73         26.0             306        11 2020
#> 284         44.1             336         36.5              23        NA 2020
#> 285         47.3             281         30.6             176        14 2020
#> 286         46.6             299         32.6             110        NA 2020
#> 287         50.0             193         34.7              52        NA 2020
#> 288         45.7             313         36.8              20        NA 2020
#> 289         54.2              64         29.4             212        NA 2020
#> 290         54.6              54         25.0             322        NA 2020
#> 291         49.0             220         33.9              79        NA 2020
#> 292         56.3              29         30.3             189        NA 2020
#> 293         48.0             258         29.3             217        NA 2020
#> 294         54.9              43         29.3             216        NA 2020
#> 295         46.1             308         34.2              71        NA 2020
#> 296         50.5             167         28.7             248        NA 2020
#> 297         54.5              55         26.0             305        15 2020
#> 298         53.2              88         32.3             119         2 2020
#> 299         55.3              36         24.2             336        NA 2020
#> 300         51.7             128         31.5             144        NA 2020
#> 301         57.9               9         27.4             279         2 2020
#> 302         52.9              98         24.7             327        NA 2020
#> 303         56.4              27         25.8             309        NA 2020
#> 304         54.7              52         26.8             289        NA 2020
#> 305         46.6             298         35.5              44         9 2020
#> 306         50.1             189         30.6             174        NA 2020
#> 307         48.5             239         33.3              93        NA 2020
#> 308         51.5             139         28.2             263        NA 2020
#> 309         57.6              13         26.1             302        NA 2020
#> 310         52.2             116         32.4             115        NA 2020
#> 311         50.0             192         28.0             267        NA 2020
#> 312         48.2             252         34.3              65        NA 2020
#> 313         52.2             115         30.3             182        NA 2020
#> 314         49.6             206         31.3             154        NA 2020
#> 315         54.5              59         33.1              95        NA 2020
#> 316         47.2             286         34.2              68         4 2020
#> 317         47.9             261         35.9              37        NA 2020
#> 318         47.7             265         32.9             103        NA 2020
#> 319         52.5             108         29.8             197        NA 2020
#> 320         49.4             208         35.0              50        NA 2020
#> 321         48.3             244         29.5             211        NA 2020
#> 322         55.1              39         26.0             307        NA 2020
#> 323         48.0             255         32.3             120        NA 2020
#> 324         53.4              80         33.5              87        NA 2020
#> 325         59.2               5         24.5             330         6 2020
#> 326         54.8              46         23.2             344        NA 2020
#> 327         50.7             165         23.9             339        NA 2020
#> 328         53.2              90         32.6             106        NA 2020
#> 329         51.5             138         29.2             225        NA 2020
#> 330         42.3             347         38.6              10        NA 2020
#> 331         50.0             191         32.2             125        NA 2020
#> 332         54.8              44         31.7             141        NA 2020
#> 333         53.1              94         24.5             331        NA 2020
#> 334         53.4              79         29.3             221        NA 2020
#> 335         54.7              48         26.7             296        NA 2020
#> 336         47.2             283         34.6              55        NA 2020
#> 337         54.8              47         30.3             185        16 2020
#> 338         53.0              97         28.3             261        16 2020
#> 339         52.8             100         31.5             146        NA 2020
#> 340         50.5             169         32.1             130        NA 2020
#> 341         55.5              34         28.0             270        NA 2020
#> 342         56.6              24         30.0             193        NA 2020
#> 343         49.4             207         34.2              69        NA 2020
#> 344         48.6             235         35.8              39        NA 2020
#> 345         46.5             300         33.6              83        NA 2020
#> 346         56.4              26         27.7             274        NA 2020
#> 347         67.1               1         17.6             353        NA 2020
#> 348         52.6             103         31.5             145        NA 2020
#> 349         48.2             251         29.7             204        NA 2020
#> 350         56.9              18         23.2             343        NA 2020
#> 351         49.3             211         37.0              19        NA 2020
#> 352         54.9              41         31.0             161        14 2020
#> 353         57.3              15         26.1             303         5 2020
# }
```
