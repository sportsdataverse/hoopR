# **Get Team Stats**

**Get Team Stats**

## Usage

``` r
kp_teamstats(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of team stats

|                    |           |                                              |
|--------------------|-----------|----------------------------------------------|
| col_name           | types     | description                                  |
| team               | character | Team-side label or team identifier.          |
| conf               | character | character.                                   |
| off_fg_3_pct       | numeric   | Off field goals 3 percentage (0-1 decimal).  |
| off_fg_3_pct_rk    | numeric   | Off fg 3 pct rk.                             |
| off_fg_2_pct       | numeric   | Off field goals 2 percentage (0-1 decimal).  |
| off_fg_2_pct_rk    | numeric   | Off fg 2 pct rk.                             |
| off_ft_pct         | numeric   | Off free throws percentage (0-1 decimal).    |
| off_ft_pct_rk      | numeric   | Off ft pct rk.                               |
| off_blk_pct        | numeric   | Off blocks percentage (0-1 decimal).         |
| off_blk_pct_rk     | numeric   | Off blk pct rk.                              |
| off_stl_pct        | numeric   | Off steals percentage (0-1 decimal).         |
| off_stl_pct_rk     | numeric   | Off stl pct rk.                              |
| off_non_stl_pct    | numeric   | Off non steals percentage (0-1 decimal).     |
| off_non_stl_pct_rk | numeric   | Off non stl pct rk.                          |
| off_a_pct          | numeric   | Off a percentage (0-1 decimal).              |
| off_a_pct_rk       | numeric   | Off a pct rk.                                |
| off_fg_3a_pct      | numeric   | Off field goals 3a percentage (0-1 decimal). |
| off_fg_3a_pct_rk   | numeric   | Off fg 3a pct rk.                            |
| adj_o              | numeric   | Adj o.                                       |
| adj_o_rk           | numeric   | Adj o rk.                                    |
| ncaa_seed          | numeric   | Ncaa seed.                                   |
| year               | numeric   | 4-digit year.                                |
| def_fg_3_pct       | numeric   | Def field goals 3 percentage (0-1 decimal).  |
| def_fg_3_pct_rk    | numeric   | Def fg 3 pct rk.                             |
| def_fg_2_pct       | numeric   | Def field goals 2 percentage (0-1 decimal).  |
| def_fg_2_pct_rk    | numeric   | Def fg 2 pct rk.                             |
| def_ft_pct         | numeric   | Def free throws percentage (0-1 decimal).    |
| def_ft_pct_rk      | numeric   | Def ft pct rk.                               |
| def_blk_pct        | numeric   | Def blocks percentage (0-1 decimal).         |
| def_blk_pct_rk     | numeric   | Def blk pct rk.                              |
| def_stl_pct        | numeric   | Def steals percentage (0-1 decimal).         |
| def_stl_pct_rk     | numeric   | Def stl pct rk.                              |
| def_non_stl_pct    | numeric   | Def non steals percentage (0-1 decimal).     |
| def_non_stl_pct_rk | numeric   | Def non stl pct rk.                          |
| def_a_pct          | numeric   | Def a percentage (0-1 decimal).              |
| def_a_pct_rk       | numeric   | Def a pct rk.                                |
| def_fg_3a_pct      | numeric   | Def field goals 3a percentage (0-1 decimal). |
| def_fg_3a_pct_rk   | numeric   | Def fg 3a pct rk.                            |
| adj_d              | numeric   | Adj d.                                       |
| adj_d_rk           | numeric   | Adj d rk.                                    |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md)

## Examples

``` r
# \donttest{
try(kp_teamstats(min_year = 2019, max_year = 2021))
#> ✖ 2026-06-30 19:38:45.513398: Invalid arguments or no team stats data for 2019 - 2021 available!
#> ✖ Args: min_year = 2019, max_year = 2021
#> ✖ Error: subscript out of bounds
#>                       Team Conf Off.FG_3.Pct Off.FG_3.Pct.Rk Off.FG_2.Pct
#> 1                   Lehigh  Pat         42.3               1         51.9
#> 2                  Wofford   SC         41.4               2         53.9
#> 3         South Dakota St.  Sum         41.2               3         56.2
#> 4            Grambling St. SWAC         40.2               4         45.5
#> 5      Fairleigh Dickinson  NEC         40.2               5         51.0
#> 6         Louisiana Monroe   SB         39.7               6         49.6
#> 7                  Colgate  Pat         39.5               7         53.5
#> 8                 Virginia  ACC         39.5               8         52.5
#> 9            Virginia Tech  ACC         39.4               9         52.9
#> 10          Nebraska Omaha  Sum         39.3              10         51.8
#> 11           Southern Miss CUSA         39.1              11         50.0
#> 12               Marquette   BE         38.8              12         50.0
#> 13                 Hofstra  CAA         38.7              13         54.5
#> 14             Utah Valley  WAC         38.4              14         54.2
#> 15               Lafayette  Pat         38.3              15         49.1
#> 16        Western Illinois  Sum         38.2              16         45.9
#> 17                     USC  P12         38.2              17         50.3
#> 18            Northeastern  CAA         38.2              18         55.8
#> 19                Hartford   AE         38.2              19         51.5
#> 20              Fresno St.  MWC         38.2              20         51.9
#> 21                  Auburn  SEC         38.1              21         51.7
#> 22             Georgia St.   SB         38.1              22         51.2
#> 23                  Toledo  MAC         38.0              23         50.2
#> 24                 Radford BSth         38.0              24         50.1
#> 25            Presbyterian BSth         37.9              25         50.2
#> 26              Pepperdine  WCC         37.9              26         48.4
#> 27            UC Riverside   BW         37.9              27         47.2
#> 28                 Oakland Horz         37.9              28         52.2
#> 29               Creighton   BE         37.9              29         55.7
#> 30                Delaware  CAA         37.8              30         50.9
#> 31            Michigan St.  B10         37.8              31         54.3
#> 32            Saint Mary's  WCC         37.8              32         52.3
#> 33            Gardner Webb BSth         37.7              33         53.6
#> 34         Mississippi St.  SEC         37.7              34         53.3
#> 35              Quinnipiac MAAC         37.7              35         48.5
#> 36                 Montana BSky         37.7              36         55.8
#> 37       Abilene Christian Slnd         37.7              37         49.5
#> 38             Montana St. BSky         37.6              38         51.1
#> 39                   Idaho BSky         37.6              39         46.5
#> 40             Austin Peay  OVC         37.5              40         51.1
#> 41                Lipscomb ASun         37.5              41         53.8
#> 42         Sam Houston St. Slnd         37.5              42         48.6
#> 43       Southern Illinois  MVC         37.4              43         51.2
#> 44                  Purdue  B10         37.4              44         51.5
#> 45                 Samford   SC         37.3              45         53.0
#> 46            Oklahoma St.  B12         37.2              46         46.0
#> 47       Purdue Fort Wayne  Sum         37.2              47         55.8
#> 48                 Bradley  MVC         37.0              48         46.5
#> 49           South Alabama   SB         37.0              49         51.1
#> 50            Nicholls St. Slnd         37.0              50         45.5
#> 51             Norfolk St. MEAC         37.0              51         46.1
#> 52        Coastal Carolina   SB         37.0              52         49.5
#> 53                    Utah  P12         37.0              53         54.6
#> 54                 Belmont  OVC         37.0              54         59.3
#> 55        Central Michigan  MAC         36.9              55         48.9
#> 56      Florida Gulf Coast ASun         36.9              56         50.7
#> 57                  Howard MEAC         36.8              57         45.5
#> 58                 Liberty ASun         36.8              58         56.4
#> 59        Western Carolina   SC         36.8              59         52.3
#> 60                 Seattle  WAC         36.8              60         46.1
#> 61          Loyola Chicago  MVC         36.7              61         55.0
#> 62        North Dakota St.  Sum         36.7              62         52.1
#> 63               Tennessee  SEC         36.7              63         55.4
#> 64                Winthrop BSth         36.7              64         53.4
#> 65           James Madison  CAA         36.7              65         47.5
#> 66  Southeast Missouri St.  OVC         36.6              66         47.4
#> 67          South Carolina  SEC         36.5              67         44.9
#> 68           Cleveland St. Horz         36.5              68         48.9
#> 69              Texas Tech  B12         36.5              68         52.8
#> 70       Northern Illinois  MAC         36.5              70         51.6
#> 71                     UCF Amer         36.5              71         52.0
#> 72                    Yale  Ivy         36.5              72         56.0
#> 73                    Iowa  B10         36.4              73         51.4
#> 74            Oral Roberts  Sum         36.4              74         50.7
#> 75             Florida A&M MEAC         36.4              75         46.9
#> 76          Washington St.  P12         36.4              76         51.5
#> 77                 Gonzaga  WCC         36.3              77         61.4
#> 78                Missouri  SEC         36.3              78         47.6
#> 79                  Marist MAAC         36.3              79         50.8
#> 80             Chattanooga   SC         36.3              80         49.3
#> 81                Iowa St.  B12         36.3              81         55.0
#> 82                  Denver  Sum         36.2              82         47.8
#> 83        Eastern Illinois  OVC         36.2              83         46.7
#> 84          North Carolina  ACC         36.2              84         52.1
#> 85             Santa Clara  WCC         36.2              85         49.8
#> 86               Idaho St. BSky         36.2              86         50.4
#> 87                 Harvard  Ivy         36.1              87         52.7
#> 88      Cal St. Northridge   BW         36.1              88         50.3
#> 89                Longwood BSth         36.1              89         50.7
#> 90            North Dakota  Sum         36.0              90         49.6
#> 91       Northern Kentucky Horz         36.0              91         55.0
#> 92                  Furman   SC         36.0              92         56.7
#> 93                 Vermont   AE         35.9              93         51.6
#> 94                 Niagara MAAC         35.9              94         46.1
#> 95      East Tennessee St.   SC         35.9              95         55.0
#> 96               UC Irvine   BW         35.9              96         50.1
#> 97               Wisconsin  B10         35.9              97         49.7
#> 98             Mississippi  SEC         35.8              98         52.7
#> 99           Bowling Green  MAC         35.8              99         48.8
#> 100             St. John's   BE         35.7             100         50.7
#> 101                  Drake  MVC         35.7             101         53.2
#> 102               Utah St.  MWC         35.7             102         54.1
#> 103                Detroit Horz         35.6             103         46.7
#> 104               Davidson  A10         35.6             104         52.8
#> 105              Dartmouth  Ivy         35.6             105         50.6
#> 106          San Diego St.  MWC         35.6             106         47.9
#> 107            Little Rock   SB         35.6             107         54.9
#> 108                Pacific  WCC         35.6             108         44.9
#> 109            Indiana St.  MVC         35.6             109         46.7
#> 110             Georgetown   BE         35.5             110         49.6
#> 111                   UCLA  P12         35.5             111         51.4
#> 112                Houston Amer         35.5             112         51.3
#> 113          San Francisco  WCC         35.4             113         53.8
#> 114               Kentucky  SEC         35.4             114         52.9
#> 115               Columbia  Ivy         35.4             115         50.6
#> 116                    VMI   SC         35.4             116         47.6
#> 117             Holy Cross  Pat         35.4             117         52.5
#> 118                 Butler   BE         35.3             118         51.4
#> 119       Central Arkansas Slnd         35.3             119         46.3
#> 120         St. Francis PA  NEC         35.3             120         46.4
#> 121           Sacred Heart  NEC         35.2             121         51.1
#> 122              Weber St. BSky         35.2             122         53.4
#> 123                   UMKC  WAC         35.2             123         47.8
#> 124             N.C. State  ACC         35.2             124         51.6
#> 125           Colorado St.  MWC         35.2             125         55.5
#> 126              Villanova   BE         35.2             126         53.7
#> 127              Boise St.  MWC         35.2             127         54.7
#> 128                   Iona MAAC         35.1             128         53.2
#> 129               Bucknell  Pat         35.1             129         53.3
#> 130         Incarnate Word Slnd         35.1             130         51.4
#> 131                   Rice CUSA         35.1             131         48.0
#> 132                 Oregon  P12         35.1             132         51.6
#> 133         William & Mary  CAA         35.0             133         55.8
#> 134         UNC Wilmington  CAA         35.0             134         49.3
#> 135              Fairfield MAAC         35.0             135         49.5
#> 136          Northern Iowa  MVC         35.0             135         46.2
#> 137             Washington  P12         35.0             135         51.9
#> 138                 Kansas  B12         35.0             138         52.6
#> 139          Massachusetts  A10         35.0             139         50.2
#> 140             California  P12         35.0             140         46.5
#> 141                 Hawaii   BW         35.0             141         52.2
#> 142             Murray St.  OVC         34.9             142         56.2
#> 143               Maryland  B10         34.9             143         50.8
#> 144           Old Dominion CUSA         34.9             144         44.0
#> 145       Illinois Chicago Horz         34.9             145         54.0
#> 146              San Diego  WCC         34.8             146         52.4
#> 147            Cal Baptist  WAC         34.8             147         50.4
#> 148      Northern Colorado BSky         34.8             148         53.5
#> 149       UC Santa Barbara   BW         34.8             149         49.4
#> 150                  Texas  B12         34.8             150         49.8
#> 151                   NJIT ASun         34.8             151         49.8
#> 152     Eastern Washington BSky         34.8             152         48.9
#> 153                 Albany   AE         34.8             153         46.9
#> 154                 Nevada  MWC         34.7             154         54.8
#> 155                   Penn  Ivy         34.7             155         52.9
#> 156               Richmond  A10         34.7             156         55.5
#> 157                 Drexel  CAA         34.7             157         50.9
#> 158       Northern Arizona BSky         34.6             158         49.2
#> 159                   Elon  CAA         34.6             159         52.2
#> 160             Wright St. Horz         34.6             160         50.5
#> 161                    TCU  B12         34.6             161         52.3
#> 162               Oklahoma  B12         34.6             162         49.7
#> 163                Wyoming  MWC         34.5             163         47.1
#> 164               Arkansas  SEC         34.5             164         50.6
#> 165               Illinois  B10         34.5             164         48.2
#> 166             New Mexico  MWC         34.5             166         47.7
#> 167    Charleston Southern BSth         34.5             167         48.4
#> 168             Cincinnati Amer         34.5             168         47.6
#> 169              Green Bay Horz         34.5             169         51.4
#> 170        Appalachian St.   SB         34.4             170         51.3
#> 171            Connecticut Amer         34.4             171         50.7
#> 172                   UTSA CUSA         34.3             172         48.0
#> 173                 DePaul   BE         34.3             173         53.3
#> 174           UMass Lowell   AE         34.3             174         55.1
#> 175               Marshall CUSA         34.2             175         52.3
#> 176               Michigan  B10         34.2             176         51.8
#> 177             Louisville  ACC         34.2             177         50.6
#> 178         Youngstown St. Horz         34.2             178         48.5
#> 179             Evansville  MVC         34.2             179         47.9
#> 180      Boston University  Pat         34.2             180         54.5
#> 181           LIU Brooklyn  NEC         34.1             181         50.3
#> 182                 Baylor  B12         34.1             182         51.2
#> 183     North Carolina A&T MEAC         34.1             183         51.0
#> 184                Hampton BSth         34.1             184         47.5
#> 185               Ohio St.  B10         34.1             184         49.7
#> 186                  Rider MAAC         34.1             186         50.3
#> 187              Loyola MD  Pat         34.1             187         51.8
#> 188          Robert Morris  NEC         34.1             188         47.3
#> 189                    SMU Amer         34.1             189         51.3
#> 190       Tennessee Martin  OVC         34.1             190         49.9
#> 191                  Tulsa Amer         34.0             191         51.3
#> 192    Arkansas Pine Bluff SWAC         34.0             192         47.0
#> 193                Alabama  SEC         34.0             193         49.9
#> 194              Louisiana   SB         33.9             194         50.7
#> 195             Binghamton   AE         33.9             195         48.4
#> 196                  Siena MAAC         33.9             196         52.0
#> 197          North Florida ASun         33.9             197         53.2
#> 198         New Mexico St.  WAC         33.9             198         56.9
#> 199           Missouri St.  MVC         33.9             199         51.4
#> 200           South Dakota  Sum         33.9             200         49.6
#> 201              Milwaukee Horz         33.8             201         46.5
#> 202                 Mercer   SC         33.8             202         51.2
#> 203         UNC Greensboro   SC         33.8             203         51.4
#> 204         Long Beach St.   BW         33.8             204         46.3
#> 205               Campbell BSth         33.8             205         54.8
#> 206                  Brown  Ivy         33.8             206         50.2
#> 207             Charleston  CAA         33.7             207         56.3
#> 208         Louisiana Tech CUSA         33.7             208         49.3
#> 209                   UNLV  MWC         33.7             209         48.8
#> 210          Southern Utah BSky         33.7             210         50.0
#> 211 Southeastern Louisiana Slnd         33.6             211         50.4
#> 212                  Lamar Slnd         33.6             212         48.8
#> 213                Buffalo  MAC         33.6             213         55.6
#> 214                Arizona  P12         33.6             214         48.1
#> 215            Arizona St.  P12         33.6             215         50.8
#> 216           Morehead St.  OVC         33.6             215         47.1
#> 217         Tennessee Tech  OVC         33.6             217         43.9
#> 218               Kent St.  MAC         33.6             218         49.1
#> 219            The Citadel   SC         33.5             219         54.1
#> 220         St. Francis NY  NEC         33.5             220         47.3
#> 221             Kansas St.  B12         33.4             221         48.8
#> 222        Houston Baptist Slnd         33.4             222         49.3
#> 223               Nebraska  B10         33.4             223         48.6
#> 224                Florida  SEC         33.4             224         49.5
#> 225            New Orleans Slnd         33.3             225         47.2
#> 226               Miami FL  ACC         33.3             226         51.3
#> 227          South Florida Amer         33.3             227         48.5
#> 228      Stephen F. Austin Slnd         33.3             228         47.6
#> 229               Syracuse  ACC         33.3             229         49.3
#> 230                   Troy   SB         33.2             230         51.7
#> 231                 Dayton  A10         33.2             231         59.5
#> 232            Florida St.  ACC         33.2             232         50.9
#> 233              Manhattan MAAC         33.1             233         45.6
#> 234         Sacramento St. BSky         33.1             234         48.3
#> 235           Grand Canyon  WAC         33.1             235         52.5
#> 236                 Xavier   BE         33.1             236         54.7
#> 237             Pittsburgh  ACC         33.1             237         46.9
#> 238               La Salle  A10         33.1             238         45.3
#> 239             Morgan St. MEAC         33.1             239         41.5
#> 240                    BYU  WCC         33.0             240         54.6
#> 241                Fordham  A10         33.0             241         44.7
#> 242                  IUPUI Horz         33.0             242         50.5
#> 243                 Temple Amer         33.0             243         50.1
#> 244           George Mason  A10         33.0             244         50.5
#> 245           San Jose St.  MWC         33.0             245         44.1
#> 246                Cornell  Ivy         32.9             246         52.4
#> 247               Portland  WCC         32.9             247         45.8
#> 248                Clemson  ACC         32.8             248         51.5
#> 249    Central Connecticut  NEC         32.8             249         45.8
#> 250        St. Bonaventure  A10         32.8             250         47.9
#> 251       Western Kentucky CUSA         32.7             251         50.2
#> 252           Illinois St.  MVC         32.7             252         49.1
#> 253                 Towson  CAA         32.7             253         47.6
#> 254               UC Davis   BW         32.7             254         49.0
#> 255       Florida Atlantic CUSA         32.6             255         47.0
#> 256          Tennessee St.  OVC         32.6             256         49.3
#> 257             Providence   BE         32.6             257         47.5
#> 258            Stony Brook   AE         32.6             258         47.7
#> 259               Southern SWAC         32.6             259         48.8
#> 260                    UAB CUSA         32.6             260         51.3
#> 261          New Hampshire   AE         32.6             261         39.4
#> 262               American  Pat         32.5             262         55.6
#> 263       Georgia Southern   SB         32.5             262         56.7
#> 264                 Bryant  NEC         32.5             264         49.2
#> 265              Texas St.   SB         32.5             265         50.8
#> 266          Saint Peter's MAAC         32.5             266         48.8
#> 267     South Carolina St. MEAC         32.4             267         46.5
#> 268             Seton Hall   BE         32.4             268         50.6
#> 269              Air Force  MWC         32.4             269         53.1
#> 270               Canisius MAAC         32.4             270         52.0
#> 271        Bethune Cookman MEAC         32.4             271         48.3
#> 272               Colorado  P12         32.3             272         52.4
#> 273       Prairie View A&M SWAC         32.3             273         49.3
#> 274               Miami OH  MAC         32.3             274         48.7
#> 275       Middle Tennessee CUSA         32.3             275         45.7
#> 276           Arkansas St.   SB         32.3             276         46.5
#> 277 Texas A&M Corpus Chris Slnd         32.3             277         47.6
#> 278               Duquesne  A10         32.2             278         51.2
#> 279         Saint Joseph's  A10         32.2             279         47.8
#> 280               Ball St.  MAC         32.2             280         53.5
#> 281                Memphis Amer         32.2             281         52.6
#> 282                Georgia  SEC         32.2             282         51.1
#> 283         Texas Southern SWAC         32.1             283         52.2
#> 284            Alabama St. SWAC         32.1             284         44.7
#> 285            USC Upstate BSth         32.1             285         46.8
#> 286             Oregon St.  P12         32.1             286         54.5
#> 287               Cal Poly   BW         32.0             287         46.6
#> 288               Penn St.  B10         32.0             288         47.2
#> 289       Eastern Kentucky  OVC         32.0             289         47.7
#> 290                    LSU  SEC         31.9             290         52.9
#> 291                   UTEP CUSA         31.9             291         44.5
#> 292                 Tulane Amer         31.8             292         46.7
#> 293                   Army  Pat         31.8             293         51.0
#> 294         Boston College  ACC         31.7             294         49.1
#> 295            North Texas CUSA         31.7             295         50.5
#> 296                   Navy  Pat         31.7             296         46.4
#> 297               Stanford  P12         31.7             297         53.2
#> 298          UNC Asheville BSth         31.7             298         45.2
#> 299                  Akron  MAC         31.7             299         48.8
#> 300              Minnesota  B10         31.7             300         48.5
#> 301       Loyola Marymount  WCC         31.6             301         50.3
#> 302          West Virginia  B12         31.6             302         47.6
#> 303 North Carolina Central MEAC         31.6             303         51.3
#> 304             Notre Dame  ACC         31.5             304         45.4
#> 305            Alabama A&M SWAC         31.4             305         45.0
#> 306           Kennesaw St. ASun         31.4             306         39.1
#> 307                   UMBC   AE         31.3             307         49.5
#> 308   UT Rio Grande Valley  WAC         31.3             308         46.0
#> 309           Northwestern  B10         31.3             309         46.4
#> 310             Alcorn St. SWAC         31.3             310         45.0
#> 311                Indiana  B10         31.2             311         53.1
#> 312                Rutgers  B10         31.2             312         47.2
#> 313       Mount St. Mary's  NEC         31.2             313         48.7
#> 314           Jacksonville ASun         31.1             314         51.0
#> 315             Vanderbilt  SEC         31.1             315         50.0
#> 316      George Washington  A10         31.1             316         45.3
#> 317              Charlotte CUSA         31.1             317         49.2
#> 318       Jacksonville St.  OVC         31.0             318         52.3
#> 319            Wichita St. Amer         31.0             319         47.1
#> 320    Cal St. Bakersfield  WAC         31.0             320         46.7
#> 321 Mississippi Valley St. SWAC         31.0             321         40.1
#> 322                Stetson ASun         31.0             322         45.0
#> 323            McNeese St. Slnd         31.0             323         51.3
#> 324             Valparaiso  MVC         31.0             324         50.1
#> 325                  Maine   AE         31.0             325         49.9
#> 326      Cal St. Fullerton   BW         30.8             326         50.3
#> 327                   Duke  ACC         30.8             327         58.0
#> 328            Wake Forest  ACC         30.8             328         44.1
#> 329              Texas A&M  SEC         30.8             329         51.0
#> 330           Georgia Tech  ACC         30.7             330         50.7
#> 331       Western Michigan  MAC         30.5             331         49.4
#> 332                    VCU  A10         30.5             332         53.1
#> 333           UT Arlington   SB         30.5             333         47.9
#> 334            Chicago St.  WAC         30.5             334         43.5
#> 335            Saint Louis  A10         30.4             335         47.2
#> 336       SIU Edwardsville  OVC         30.3             336         47.6
#> 337             High Point BSth         30.3             337         51.0
#> 338              Princeton  Ivy         30.3             338         48.1
#> 339                 Wagner  NEC         30.1             339         43.1
#> 340       Eastern Michigan  MAC         29.9             340         50.4
#> 341           Portland St. BSky         29.8             341         48.3
#> 342          North Alabama ASun         29.7             342         44.4
#> 343                   Ohio  MAC         29.7             343         50.7
#> 344               Monmouth MAAC         29.7             344         46.4
#> 345                    FIU CUSA         29.4             345         52.2
#> 346           Savannah St. MEAC         29.2             346         53.7
#> 347           Delaware St. MEAC         29.0             347         37.7
#> 348             Coppin St. MEAC         28.5             348         47.7
#> 349          East Carolina Amer         28.4             349         47.7
#> 350       Northwestern St. Slnd         28.0             350         46.2
#> 351           Rhode Island  A10         28.0             351         50.0
#> 352 Maryland Eastern Shore MEAC         27.9             352         44.5
#> 353            Jackson St. SWAC         27.9             353         45.9
#>     Off.FG_2.Pct.Rk Off.FT.Pct Off.FT.Pct.Rk Off.Blk.Pct Off.Blk.Pct.Rk
#> 1                96       77.4            10        10.3            260
#> 2                43       71.0           165         7.5             44
#> 3                11       77.3            11         8.9            148
#> 4               326       69.3           231         9.3            182
#> 5               141       73.6            81         9.3            176
#> 6               200       78.7             4        11.2            301
#> 7                49       74.4            57         9.7            218
#> 8                75       74.4            54         8.3             93
#> 9                66       76.1            20        10.0            240
#> 10              100       71.6           151         9.0            149
#> 11              190       66.6           315         8.1             75
#> 12              187       75.7            26         8.9            145
#> 13               35       80.6             1         7.3             31
#> 14               39       73.0            97         8.4            104
#> 15              222       74.7            45         6.3              8
#> 16              321       71.7           146         7.7             54
#> 17              175       64.5           335         7.6             50
#> 18               14       75.1            37         7.4             38
#> 19              111       74.2            61        11.4            311
#> 20               98       71.7           144        10.8            289
#> 21              103       71.3           157        12.1            338
#> 22              130       65.9           325         9.9            233
#> 23              179       77.1            12         8.1             76
#> 24              182       70.9           168         9.4            191
#> 25              181       74.9            43         8.8            134
#> 26              244       75.8            25         9.8            227
#> 27              281       68.2           266         7.1             24
#> 28               88       74.4            53         9.5            201
#> 29               17       68.1           273        10.8            285
#> 30              145       72.9            98         9.2            173
#> 31               38       75.3            31         8.4            108
#> 32               84       74.2            63         9.2            171
#> 33               48       71.6           148         8.9            136
#> 34               55       71.7           145        10.1            250
#> 35              243       72.4           113        11.5            320
#> 36               14       69.5           217         8.3             96
#> 37              204       71.9           134         8.0             71
#> 38              132       74.1            69         6.9             18
#> 39              302       72.6           107         8.8            130
#> 40              136       70.8           172         8.3             94
#> 41               44       76.0            22        10.6            277
#> 42              239       76.0            21         8.9            141
#> 43              127       68.5           256         8.6            118
#> 44              108       71.9           137        11.6            322
#> 45               64       72.7           103         7.8             60
#> 46              318       68.9           246        10.4            264
#> 47               13       69.9           198         9.0            151
#> 48              303       69.1           236         7.4             39
#> 49              133       68.2           270        14.3            351
#> 50              327       77.1            13        10.8            287
#> 51              315       71.6           147         9.3            185
#> 52              205       72.0           131         9.7            217
#> 53               34       70.6           177        13.2            348
#> 54                3       73.5            84        10.2            254
#> 55              228       67.1           300        13.2            347
#> 56              155       67.5           292        10.0            236
#> 57              328       73.0            96         6.1              6
#> 58                8       78.2             6         9.3            178
#> 59               85       66.9           304        14.4            352
#> 60              317       71.6           150         7.2             30
#> 61               24       66.7           314        12.8            345
#> 62               91       76.8            15        10.0            237
#> 63               22       75.8            24         6.4             11
#> 64               53       72.3           118        11.7            327
#> 65              276       72.3           122         9.3            179
#> 66              278       69.4           225        10.9            293
#> 67              336       67.4           293        10.4            268
#> 68              226       68.0           280        10.3            261
#> 69               69       73.2            92         7.0             19
#> 70              106       73.3            91         7.8             59
#> 71               94       64.9           330         8.1             77
#> 72               12       73.5            83         7.8             62
#> 73              116       73.9            73         7.9             65
#> 74              157       69.8           207         8.0             73
#> 75              292       60.2           351         8.2             82
#> 76              110       75.5            27         7.9             66
#> 77                1       76.1            19         5.8              2
#> 78              267       70.3           184        11.3            307
#> 79              147       68.5           259        10.2            255
#> 80              216       68.0           282         8.9            138
#> 81               25       73.2            95         7.4             41
#> 82              260       76.3            16         7.2             28
#> 83              297       69.0           240         9.1            162
#> 84               92       74.3            60        11.0            297
#> 85              194       71.2           161         8.4            103
#> 86              169       73.4            88         8.2             81
#> 87               71       72.1           126         8.5            109
#> 88              174       63.7           342         7.0             21
#> 89              154       73.7            78        11.9            334
#> 90              201       68.9           245         6.4             12
#> 91               27       67.1           303        11.6            323
#> 92                7       72.3           121        11.5            319
#> 93              105       74.9            42         8.8            132
#> 94              316       73.6            82         8.6            119
#> 95               26       66.3           322         9.2            163
#> 96              183       70.6           179         7.2             26
#> 97              198       64.8           332        10.8            290
#> 98               72       78.3             5         9.8            224
#> 99              233       67.4           294         7.5             42
#> 100             152       71.9           135         6.4              9
#> 101              59       75.9            23         9.5            200
#> 102              40       75.0            40         9.4            192
#> 103             296       71.8           141        10.1            251
#> 104              70       75.2            34         7.6             47
#> 105             162       71.4           154         9.3            185
#> 106             257       72.0           130         7.3             33
#> 107              28       65.5           327         7.0             22
#> 108             337       74.4            55        11.2            303
#> 109             298       73.3            90         8.4            106
#> 110             203       73.7            79         9.1            160
#> 111             118       63.3           343         8.6            117
#> 112             119       70.3           185         6.4             13
#> 113              45       65.7           326        10.8            291
#> 114              68       73.9            71         7.8             57
#> 115             159       69.4           219         8.7            122
#> 116             269       72.4           114        11.4            316
#> 117              77       66.7           310         7.9             64
#> 118             114       73.8            76        10.7            278
#> 119             312       72.8           101         8.3             99
#> 120             307       71.2           160        11.8            330
#> 121             135       75.5            28        10.3            262
#> 122              52       74.2            67         7.7             55
#> 123             259       69.8           204        10.0            242
#> 124             104       70.8           172        10.1            253
#> 125              21       69.1           238         6.8             15
#> 126              46       72.8           100         8.8            135
#> 127              32       72.7           102         8.0             72
#> 128              57       74.5            48        11.2            303
#> 129              56       74.9            41         9.2            167
#> 130             113       80.5             2        10.0            243
#> 131             254       67.9           284        10.3            263
#> 132             107       72.1           127         8.0             70
#> 133              16       66.7           312         8.3             95
#> 134             211       73.2            94         6.2              7
#> 135             208       69.3           229        10.7            280
#> 136             314       74.2            64         7.6             49
#> 137              97       69.5           215         7.6             46
#> 138              73       70.5           182         8.9            142
#> 139             178       68.1           273        10.4            266
#> 140             301       72.3           120         8.7            127
#> 141              87       69.8           205         7.2             25
#> 142              10       73.4            89         9.5            202
#> 143             146       74.3            59         9.8            228
#> 144             345       66.3           321         6.8             14
#> 145              42       69.4           222         9.4            188
#> 146              78       74.8            44        10.0            241
#> 147             168       77.5             9         7.5             43
#> 148              50       69.8           201        10.5            270
#> 149             210       71.8           140         8.3             91
#> 150             195       69.9           200        10.1            248
#> 151             196       71.8           138        10.3            258
#> 152             227       72.5           112         9.1            155
#> 153             291       74.5            50        12.2            339
#> 154              29       70.8           170         7.4             40
#> 155              65       64.1           337         8.6            116
#> 156              20       66.1           323         9.6            204
#> 157             143       75.3            33         9.6            208
#> 158             220       70.5           181         8.3             98
#> 159              90       69.3           227         7.3             35
#> 160             165       74.0            70        10.4            265
#> 161              83       68.2           271        10.6            271
#> 162             197       69.7           209         9.5            198
#> 163             286       72.1           128         9.4            193
#> 164             160       66.8           308         9.0            152
#> 165             250       70.2           188         9.7            211
#> 166             262       70.0           195         9.7            213
#> 167             245       69.2           233         9.8            223
#> 168             270       70.4           183         9.4            189
#> 169             115       69.8           208         7.7             53
#> 170             123       71.8           142         9.5            203
#> 171             156       68.0           281         8.7            125
#> 172             253       73.7            77         9.3            184
#> 173              54       72.7           105         7.6             51
#> 174              23       71.7           143        10.4            269
#> 175              82       72.2           123         7.3             34
#> 176             101       70.1           190         9.6            205
#> 177             161       77.7             8        10.6            272
#> 178             242       69.7           212         9.4            187
#> 179             255       72.4           117         9.8            229
#> 180              37       68.4           263         8.2             86
#> 181             171       70.2           189        11.4            313
#> 182             131       67.7           288        12.6            341
#> 183             140       66.7           311         9.7            219
#> 184             277       79.6             3         9.0            150
#> 185             199       73.4            87         9.2            174
#> 186             173       61.6           348         9.1            159
#> 187              99       71.0           166        11.5            317
#> 188             280       69.4           223         8.9            146
#> 189             126       71.5           152         7.7             56
#> 190             191       75.4            29         8.3             99
#> 191             122       69.5           216         9.3            175
#> 192             289       67.8           287         9.4            196
#> 193             192       66.6           316        11.7            328
#> 194             153       74.4            51         8.0             69
#> 195             246       63.7           340         9.6            209
#> 196              93       68.0           283         8.2             83
#> 197              60       68.7           251         9.8            230
#> 198               5       67.6           291         6.0              4
#> 199             117       68.8           248         9.2            170
#> 200             202       73.6            80        11.0            298
#> 201             306       74.2            68         9.5            197
#> 202             128       68.6           253        11.4            314
#> 203             112       69.7           210         8.1             74
#> 204             311       69.8           203         8.7            124
#> 205              30       75.4            30         7.0             20
#> 206             180       72.1           129         9.8            221
#> 207               9       76.1            18         8.1             79
#> 208             215       66.0           324        10.2            256
#> 209             235       68.5           261         6.9             17
#> 210             189       71.4           154        10.9            295
#> 211             170       72.3           119        11.9            331
#> 212             231       69.1           237         9.8            222
#> 213              18       68.4           264         8.6            120
#> 214             251       71.9           135        10.6            274
#> 215             149       68.0           279         8.7            123
#> 216             288       70.7           175        13.5            349
#> 217             346       62.5           346         9.7            220
#> 218             221       72.6           108         8.3             99
#> 219              41       73.9            72        11.8            329
#> 220             279       68.5           257        10.8            284
#> 221             230       66.7           313         8.2             84
#> 222             212       67.1           301         9.9            234
#> 223             238       69.4           220         9.8            231
#> 224             205       72.1           125         9.2            165
#> 225             284       69.5           218        10.6            276
#> 226             121       73.5            85         8.7            121
#> 227             240       64.4           336        12.8            346
#> 228             271       68.5           255         8.3             97
#> 229             213       68.5           260         9.9            232
#> 230             102       72.4           115         6.0              5
#> 231               2       69.0           239         8.1             78
#> 232             144       74.4            52         8.4            102
#> 233             325       58.4           353        12.0            336
#> 234             247       70.7           176         9.1            157
#> 235              76       72.9            99         8.1             80
#> 236              31       67.9           285         8.9            144
#> 237             293       69.7           211        15.1            353
#> 238             331       77.0            14         9.7            210
#> 239             349       70.0           196        12.0            335
#> 240              33       72.7           106         7.2             27
#> 241             339       68.9           241         8.9            143
#> 242             163       70.0           194        11.6            324
#> 243             185       72.7           104         6.8             16
#> 244             164       71.6           149        10.8            288
#> 245             343       65.1           329         8.2             88
#> 246              80       71.8           139        11.5            318
#> 247             322       66.3           320        11.3            308
#> 248             109       73.2            93         8.3             92
#> 249             323       78.1             7        10.4            267
#> 250             256       74.2            66         7.6             48
#> 251             177       72.4           116         9.6            206
#> 252             223       72.2           124         7.5             45
#> 253             268       69.9           197         5.8              1
#> 254             225       70.8           171        10.0            244
#> 255             290       76.2            17         7.3             32
#> 256             217       70.1           190        10.8            283
#> 257             275       69.1           235         8.4            105
#> 258             266       72.0           132        10.9            294
#> 259             229       66.8           307         9.2            166
#> 260             125       67.3           295         8.4            107
#> 261             351       61.3           349         9.4            195
#> 262              19       69.8           206         9.2            172
#> 263               6       70.2           186         7.8             58
#> 264             218       71.2           159        11.9            333
#> 265             148       68.2           267        11.2            300
#> 266             234       72.6           109         9.3            181
#> 267             304       74.3            58         8.7            128
#> 268             158       70.6           178        11.7            326
#> 269              61       68.0           277         8.2             87
#> 270              95       69.2           232         9.3            180
#> 271             249       60.9           350        10.6            273
#> 272              79       75.3            32         9.1            156
#> 273             214       68.2           269        11.4            310
#> 274             236       71.0           164        10.7            279
#> 275             324       66.9           305         9.3            177
#> 276             305       73.8            74         9.8            225
#> 277             272       70.2           187         9.8            226
#> 278             129       69.4           224        11.2            302
#> 279             261       75.1            36         7.4             37
#> 280              51       70.1           192         8.8            133
#> 281              74       71.4           156        11.4            312
#> 282             134       70.5           180         9.0            153
#> 283              89       66.8           306         9.3            183
#> 284             338       64.8           331         9.9            235
#> 285             294       71.1           162        10.3            259
#> 286              36       74.2            64         7.7             52
#> 287             300       64.5           334        10.2            257
#> 288             282       69.3           226         9.2            168
#> 289             263       71.0           167         9.1            161
#> 290              67       75.2            35         7.9             67
#> 291             340       67.3           297        10.9            296
#> 292             295       68.9           243         9.7            214
#> 293             137       68.1           276        12.5            340
#> 294             224       69.8           202         8.6            114
#> 295             166       67.1           302        12.6            343
#> 296             308       71.5           153        11.9            332
#> 297              58       67.2           298         8.8            129
#> 298             332       75.1            38        11.4            309
#> 299             232       71.3           158         8.6            115
#> 300             241       68.2           272        10.9            292
#> 301             176       75.0            39         9.4            194
#> 302             274       68.8           249        10.0            239
#> 303             120       70.8           174        10.8            286
#> 304             329       74.4            56         8.6            113
#> 305             333       62.7           345         8.9            139
#> 306             352       69.4           221         8.5            110
#> 307             207       69.6           213         8.8            131
#> 308             319       69.6           214         8.9            147
#> 309             310       73.5            86         9.6            207
#> 310             335       66.5           317         8.3             90
#> 311              63       65.5           328        10.1            252
#> 312             285       63.7           341         8.9            139
#> 313             237       67.6           289         9.7            212
#> 314             138       67.2           299         8.7            126
#> 315             186       67.3           296        11.3            306
#> 316             330       68.5           258         9.1            158
#> 317             219       74.2            62        12.8            344
#> 318              81       74.7            46         5.9              3
#> 319             287       72.5           111        10.6            275
#> 320             299       67.6           290         7.2             29
#> 321             350       66.3           319        10.1            246
#> 322             334       67.8           286         9.2            169
#> 323             124       71.9           133         8.3             89
#> 324             184       69.9           199         8.5            111
#> 325             193       63.9           339         7.3             36
#> 326             172       71.1           163         7.1             23
#> 327               4       68.6           252         8.0             68
#> 328             344       72.5           110        11.7            325
#> 329             139       69.3           230        12.6            342
#> 330             150       68.9           244         9.5            199
#> 331             209       69.3           228        10.1            247
#> 332              62       70.1           193         7.9             63
#> 333             258       73.8            75        11.4            315
#> 334             347       68.9           242         8.2             85
#> 335             283       59.8           352        10.1            249
#> 336             273       69.2           234         7.8             61
#> 337             142       68.8           247        10.7            281
#> 338             252       74.5            49        11.2            305
#> 339             348       74.6            47        10.0            237
#> 340             167       61.9           347         9.2            164
#> 341             248       70.8           169         9.0            154
#> 342             342       68.1           275        13.5            350
#> 343             151       63.1           344         6.4             10
#> 344             309       68.6           254         9.7            215
#> 345              86       64.8           333        12.1            337
#> 346              47       66.8           309        10.8            282
#> 347             353       68.3           265        11.5            321
#> 348             265       66.5           318         8.5            112
#> 349             264       68.2           268         9.7            216
#> 350             313       68.4           262        11.0            299
#> 351             188       68.0           278         8.9            137
#> 352             341       68.8           250         9.4            190
#> 353             320       64.0           338        10.1            245
#>     Off.Stl.Pct Off.Stl.Pct.Rk Off.NonStl.Pct Off.NonStl.Pct.Rk Off.A.Pct
#> 1           9.6            266            8.9               102      55.0
#> 2           8.2             92            7.9                32      49.9
#> 3           7.4             27            8.8                98      50.2
#> 4           9.9            290           12.3               337      50.6
#> 5           9.2            219           10.5               262      52.7
#> 6           8.0             68            8.2                47      54.3
#> 7          10.5            329            8.8                96      57.4
#> 8           8.1             87            6.6                 3      55.9
#> 9           7.8             51            9.6               175      59.5
#> 10          6.6              3            6.9                 6      43.5
#> 11          8.0             72            7.7                21      60.0
#> 12          9.7            278            9.6               185      51.1
#> 13          6.6              7            7.2                12      48.7
#> 14         10.5            328            9.7               190      51.0
#> 15          8.7            163            9.9               215      51.6
#> 16          8.6            150            7.7                22      39.6
#> 17          8.1             80            8.4                62      57.2
#> 18          8.1             78            8.5                72      54.5
#> 19          8.6            153            9.2               127      54.6
#> 20          8.2             96            9.9               213      53.9
#> 21          8.3            102            8.5                70      52.6
#> 22          7.1             16            9.3               144      45.6
#> 23          9.1            210            8.3                49      59.4
#> 24          6.7              8            9.7               186      52.2
#> 25          6.9             11            7.7                24      58.6
#> 26          8.7            167            9.3               143      55.2
#> 27          8.7            168           11.5               321      52.1
#> 28          9.2            212            9.3               146      66.5
#> 29          9.0            195            9.6               183      56.7
#> 30          8.0             71            9.2               133      50.8
#> 31          9.1            208            9.4               156      66.8
#> 32          7.6             40            8.7                87      37.9
#> 33          8.7            166            8.3                54      51.6
#> 34          8.5            128           10.7               280      51.8
#> 35          8.6            151           10.8               284      53.2
#> 36          8.1             82            9.3               147      52.2
#> 37          8.3             98            9.1               118      57.7
#> 38          8.5            136            8.6                75      56.9
#> 39          9.1            209           10.7               279      51.1
#> 40          8.0             67            8.6                84      46.0
#> 41          8.8            171            9.0               110      60.8
#> 42          8.1             85           10.1               231      61.6
#> 43          9.5            248           11.5               319      54.6
#> 44          7.4             30            8.4                60      53.6
#> 45          9.3            233            9.9               217      50.3
#> 46          8.7            161            9.3               145      55.5
#> 47          8.0             73            8.7                93      51.7
#> 48          8.4            110           10.4               255      52.4
#> 49          8.3            103           11.2               311      53.5
#> 50          6.6              5           10.7               271      54.6
#> 51          7.0             12           13.3               345      51.4
#> 52          9.0            202           10.5               260      50.4
#> 53          8.7            159           10.5               263      54.7
#> 54          8.2             94            7.0                 8      61.4
#> 55          6.8              9            9.4               159      47.9
#> 56         10.4            317           10.9               295      55.1
#> 57          7.5             33            9.3               139      47.1
#> 58          8.5            139            8.6                83      54.1
#> 59         12.3            352           12.8               343      49.0
#> 60          8.5            122            9.1               119      45.8
#> 61          9.1            203            9.7               191      55.7
#> 62          7.7             47            8.0                38      45.8
#> 63          8.8            173            7.0                 9      59.5
#> 64          9.5            253           10.7               277      52.4
#> 65          8.6            144           10.2               238      49.7
#> 66          8.5            127           11.7               324      50.5
#> 67          9.6            262            9.6               181      51.2
#> 68          9.6            263            8.9               103      56.7
#> 69          9.2            216            8.5                71      52.3
#> 70          7.3             24            9.8               202      39.1
#> 71          8.6            141            9.1               120      53.6
#> 72          9.6            270            8.1                46      55.9
#> 73          9.3            228            7.9                31      59.3
#> 74         10.1            301           10.3               244      51.7
#> 75         10.4            318           14.3               352      50.1
#> 76         10.2            307            9.0               114      57.4
#> 77          7.6             38            7.3                14      56.2
#> 78          9.1            204           12.0               333      46.7
#> 79          8.6            142           10.4               249      51.0
#> 80          9.8            284            9.3               142      51.0
#> 81          7.6             41            8.6                81      54.1
#> 82          8.5            130           11.2               312      46.5
#> 83          9.8            288            9.0               112      52.1
#> 84          8.9            181            8.3                57      60.6
#> 85          9.6            264           10.9               291      55.9
#> 86          7.8             53            9.8               205      49.1
#> 87         10.8            337           11.8               326      46.6
#> 88          8.3            106            8.3                53      52.4
#> 89          8.5            129           11.9               331      49.6
#> 90         10.0            299            7.9                33      48.2
#> 91          8.5            132            9.3               149      61.7
#> 92         10.4            322            8.0                41      56.0
#> 93          8.4            118            8.4                64      46.1
#> 94          8.0             75            9.3               138      43.1
#> 95          9.3            232           10.7               272      53.6
#> 96          7.7             44            9.8               196      48.3
#> 97          7.8             60            6.8                 5      49.2
#> 98          8.9            178            9.3               141      54.2
#> 99          9.0            198            7.5                18      45.3
#> 100         7.1             15            7.3                13      50.0
#> 101        10.4            320            8.7                88      56.9
#> 102         8.7            155            9.5               168      62.1
#> 103         8.0             76            8.3                51      40.7
#> 104         7.6             39            9.1               124      58.6
#> 105         9.3            231            8.3                50      52.4
#> 106         8.5            134            9.8               193      56.7
#> 107         7.8             58           14.8               353      53.1
#> 108         8.9            183           10.7               274      45.2
#> 109         8.5            121           10.1               229      44.1
#> 110        10.2            306            7.7                23      60.6
#> 111         9.4            240            9.5               171      51.4
#> 112         7.8             61            8.7                86      55.8
#> 113         7.1             17            8.0                37      50.4
#> 114         8.6            146           10.0               222      51.2
#> 115         8.9            190            9.0               117      54.4
#> 116         8.1             77            8.5                68      52.2
#> 117         8.7            158            7.5                17      60.3
#> 118         7.9             62            8.2                48      50.4
#> 119         8.6            149           11.1               304      57.6
#> 120         7.2             22           10.2               239      46.0
#> 121         9.7            280           10.1               230      52.9
#> 122         7.9             65            8.1                45      40.1
#> 123         7.6             37            9.6               176      45.0
#> 124         8.6            152            8.6                85      50.8
#> 125         8.5            135            8.5                67      54.2
#> 126         7.9             66            8.9               108      56.9
#> 127         7.2             19           10.1               224      47.1
#> 128         7.6             34            9.8               194      50.4
#> 129         9.5            256            7.8                25      59.9
#> 130        11.6            350           12.5               339      50.7
#> 131         8.6            148           10.3               245      53.7
#> 132         7.9             64            9.8               207      52.3
#> 133         9.7            271            8.6                74      62.7
#> 134         8.9            179            9.6               180      56.0
#> 135         9.5            258           11.1               307      52.7
#> 136        10.1            300            7.8                26      48.1
#> 137         8.9            189           10.8               289      47.5
#> 138         9.2            220            9.6               177      48.3
#> 139         9.7            273           10.5               258      57.9
#> 140         7.2             20            9.2               132      45.7
#> 141         8.3            107            9.2               136      60.8
#> 142         8.7            160            8.5                69      58.6
#> 143        10.4            325            8.9               104      52.1
#> 144         7.4             26           10.4               253      53.3
#> 145         9.1            205           10.9               292      55.0
#> 146         9.7            276            9.1               123      56.2
#> 147         8.0             74            9.9               216      40.8
#> 148         9.5            259            8.9               100      50.1
#> 149         7.1             14            9.8               195      50.6
#> 150         7.6             36            8.6                77      52.4
#> 151         8.0             70            9.1               122      44.5
#> 152         8.7            156            8.4                65      53.0
#> 153         9.4            244           11.5               318      55.6
#> 154         6.6              6            8.1                43      53.9
#> 155         9.2            213            9.1               125      56.0
#> 156         8.4            112            6.9                 7      61.1
#> 157         8.5            140            8.1                44      51.6
#> 158         7.8             56            9.2               130      48.5
#> 159         9.7            275            8.8                94      56.4
#> 160         8.2             90            9.1               126      54.6
#> 161         8.6            145           10.6               267      60.4
#> 162         9.5            254            7.4                16      48.7
#> 163         9.5            255           10.3               247      47.9
#> 164         8.6            154            9.7               188      60.8
#> 165         8.1             89           10.2               235      51.7
#> 166         9.5            257            9.8               204      53.7
#> 167         9.6            268            8.3                56      52.0
#> 168         5.8              1           10.1               232      53.4
#> 169         9.2            218            8.0                40      51.6
#> 170         9.8            286            8.0                35      45.0
#> 171         8.9            182            9.6               182      48.3
#> 172         7.8             52            8.6                78      47.5
#> 173         9.4            241            9.4               158      50.8
#> 174         9.9            293            9.7               189      56.3
#> 175         8.4            117            7.5                19      50.3
#> 176         6.1              2            7.8                29      54.4
#> 177         8.3            101            9.2               128      53.6
#> 178         8.3            108           10.2               234      50.8
#> 179         7.8             54           10.6               264      52.4
#> 180         8.7            165           10.1               226      48.5
#> 181         9.4            236           10.7               273      51.7
#> 182         8.9            188           10.8               281      54.4
#> 183         8.8            172           10.6               268      54.1
#> 184         6.6              4            8.0                36      49.2
#> 185         9.3            229            9.4               163      58.9
#> 186         8.2             91            9.9               208      53.1
#> 187        10.2            308            9.3               148      53.2
#> 188         9.3            225           11.7               325      54.6
#> 189         7.3             25            9.3               137      52.9
#> 190         9.6            267            9.2               134      51.0
#> 191         9.6            261            8.4                63      55.4
#> 192        11.2            343           10.9               294      49.9
#> 193         9.3            227           10.2               240      48.8
#> 194         8.1             86            9.2               135      53.2
#> 195        10.3            310            8.3                52      40.2
#> 196         7.6             35            8.0                42      53.8
#> 197        12.5            353            9.3               140      58.6
#> 198         7.2             21           10.6               265      53.1
#> 199         8.6            147            9.6               179      45.1
#> 200         7.7             45            8.4                59      52.1
#> 201         8.5            131            9.5               170      45.8
#> 202         9.5            250            9.8               200      48.8
#> 203         8.4            119            8.7                89      44.7
#> 204        10.4            324            8.6                73      43.9
#> 205         8.1             83            6.7                 4      54.4
#> 206         9.5            249           10.8               290      50.8
#> 207         7.7             43            7.9                34      43.3
#> 208         8.3             97            8.7                92      51.7
#> 209         9.1            206            9.5               167      50.7
#> 210         9.2            211            9.8               197      47.2
#> 211        10.4            326           13.7               347      59.5
#> 212         8.9            180           11.1               305      52.9
#> 213         7.0             13            8.8                97      54.8
#> 214         7.8             57            8.9               106      50.1
#> 215         8.8            177            9.8               199      51.1
#> 216         8.3             99            9.0               113      51.7
#> 217        11.6            349           11.2               310      51.3
#> 218         8.4            113            8.0                39      48.5
#> 219         8.9            185            8.4                61      49.4
#> 220         7.5             32           10.1               227      44.4
#> 221         9.6            269            7.8                27      57.6
#> 222        10.1            305            9.4               154      52.6
#> 223         7.2             18            7.2                11      50.8
#> 224         9.4            238            8.5                66      51.0
#> 225        11.4            347           10.4               250      55.0
#> 226         8.3            100            8.6                82      51.3
#> 227         9.9            289           12.8               341      56.9
#> 228         9.7            279           10.8               282      43.3
#> 229         9.8            287            8.7                90      50.5
#> 230         8.8            170           11.1               303      50.1
#> 231         8.0             69           10.8               283      60.0
#> 232         7.8             55           11.1               306      49.5
#> 233        10.0            297           14.1               351      55.3
#> 234         9.8            281            9.4               153      51.4
#> 235         7.6             42            9.6               184      51.0
#> 236        10.1            304            9.4               160      56.3
#> 237         9.5            252           10.1               228      50.3
#> 238         9.2            222           10.9               293      54.4
#> 239         7.7             48           10.1               233      47.3
#> 240         7.9             63            7.4                15      54.9
#> 241         8.6            143            7.8                28      46.9
#> 242         9.9            294            9.8               192      52.2
#> 243         7.7             49            7.9                30      54.5
#> 244         9.9            295            9.0               111      48.4
#> 245        10.8            335           11.1               301      59.0
#> 246         9.0            197           10.0               218      59.2
#> 247         9.7            277           10.2               237      52.4
#> 248         8.3            104           11.4               316      49.2
#> 249         9.8            282           10.0               221      46.4
#> 250         8.7            162            9.9               212      50.8
#> 251         8.5            125           11.2               309      48.9
#> 252         8.5            133            9.9               210      51.0
#> 253         8.5            123           10.3               246      39.0
#> 254         9.5            251           10.4               252      51.3
#> 255        10.8            334            9.8               206      53.1
#> 256         8.9            191           13.7               348      44.3
#> 257         9.8            283            8.9               105      58.8
#> 258         9.0            200           11.6               323      45.5
#> 259         9.3            230           13.9               350      48.6
#> 260         7.5             31            9.3               151      43.2
#> 261         8.2             93           10.3               241      52.7
#> 262         9.3            224            9.4               165      51.5
#> 263         7.8             59           10.8               285      39.8
#> 264         8.5            126            9.9               214      45.0
#> 265         9.3            226           10.4               248      55.4
#> 266        10.9            338           12.4               338      42.6
#> 267         8.1             79           12.8               342      48.0
#> 268         8.1             84            9.4               155      51.7
#> 269        10.4            323            8.9               101      53.7
#> 270         7.8             50           10.8               287      58.4
#> 271         9.4            237           12.1               336      52.6
#> 272        10.1            302            8.9               109      51.7
#> 273         6.9             10           10.5               257      48.6
#> 274         8.8            175            9.9               209      44.6
#> 275        10.9            339           11.9               330      45.4
#> 276         8.3            105           11.0               299      45.1
#> 277        10.3            313           12.0               332      55.4
#> 278         9.6            265           10.2               236      54.6
#> 279         7.3             23            6.1                 1      50.1
#> 280         9.4            235           10.8               286      47.6
#> 281        10.3            316            9.4               161      54.6
#> 282        10.6            333           11.8               328      54.5
#> 283         9.4            239           10.4               251      53.4
#> 284        10.5            327           10.4               254      43.9
#> 285         8.9            186           11.0               297      54.7
#> 286         9.0            193            9.3               150      58.1
#> 287         8.1             88            8.8                99      42.7
#> 288         9.8            285            8.3                55      49.2
#> 289         8.7            157            9.6               174      50.1
#> 290         8.9            187            9.0               115      45.7
#> 291         9.4            242           13.3               346      46.8
#> 292        10.4            321           10.6               269      60.6
#> 293         9.4            243            7.0                10      59.3
#> 294         8.4            114            9.1               121      49.7
#> 295         9.7            274           10.5               256      51.0
#> 296        10.8            336            9.8               203      54.5
#> 297         9.0            192           11.9               329      48.5
#> 298        11.0            340           12.5               340      48.9
#> 299         8.4            109            8.9               107      49.9
#> 300         8.5            138            8.6                76      59.0
#> 301         8.8            176           10.5               261      55.4
#> 302        11.4            348            9.9               211      54.2
#> 303         8.8            174           13.9               349      59.8
#> 304         7.4             29            6.5                 2      54.5
#> 305        11.3            346           11.3               313      52.3
#> 306        10.0            296            9.0               116      48.3
#> 307         8.5            124            9.8               201      53.0
#> 308         8.4            120            9.6               172      56.0
#> 309         8.5            137            7.6                20      61.4
#> 310        12.0            351           12.0               335      52.1
#> 311         8.4            116            9.4               164      51.0
#> 312         9.5            260            9.6               178      50.6
#> 313         9.0            199           10.0               219      48.5
#> 314         9.7            272           10.3               242      50.4
#> 315         9.4            245           11.1               302      50.4
#> 316         9.9            292            8.4                58      50.3
#> 317        10.5            330           11.5               320      48.2
#> 318         9.2            221            9.6               173      46.6
#> 319         7.4             28           10.0               220      53.7
#> 320         7.7             46           11.3               314      41.2
#> 321         8.4            111           10.1               225      49.0
#> 322         8.9            184            8.7                91      52.0
#> 323        10.3            311           11.0               300      55.4
#> 324        10.4            319            9.8               198      53.0
#> 325        11.1            341           11.0               298      63.0
#> 326         8.1             81           11.0               296      45.4
#> 327         8.7            164            8.8                95      52.4
#> 328        10.2            309            9.2               129      46.2
#> 329        10.3            315            9.7               187      46.7
#> 330        10.3            312           10.7               275      57.4
#> 331        11.2            344           10.5               259      48.0
#> 332         9.2            223           10.7               278      54.9
#> 333         9.0            201           11.3               315      54.3
#> 334        10.5            331           12.0               334      50.9
#> 335         9.0            196           10.3               243      53.8
#> 336         9.4            234            9.4               152      48.1
#> 337         8.8            169           11.6               322      51.8
#> 338         9.2            217            8.6                80      41.7
#> 339         9.0            194           11.8               327      52.8
#> 340        10.1            303           10.6               270      43.7
#> 341         8.2             95           11.2               308      50.1
#> 342         9.2            215           10.1               223      44.4
#> 343        10.6            332            9.4               157      56.2
#> 344        10.0            298           10.6               266      47.7
#> 345         9.1            207            8.6                79      49.5
#> 346         9.2            214           10.7               276      55.5
#> 347         9.5            247            9.5               169      47.4
#> 348        10.3            314           12.9               344      45.9
#> 349         9.5            246            9.5               166      51.0
#> 350        11.2            345           11.4               317      46.0
#> 351         8.4            115            9.4               162      48.8
#> 352         9.9            291           10.8               288      52.6
#> 353        11.1            342            9.2               131      49.9
#>     Off.A.Pct.Rk Off.FG_3A.Pct Off.FG_3A.Pct.Rk  AdjO AdjO.Rk NCAA_Seed Year
#> 1             81          38.3              183 108.9      91        NA 2019
#> 2            244          43.9               49 118.1      10         7 2019
#> 3            234          41.3              102 112.7      37        NA 2019
#> 4            221          30.5              336  95.9     318        NA 2019
#> 5            144          35.2              268 106.5     139        16 2019
#> 6            106          44.2               44 112.5      40        NA 2019
#> 7             44          41.4              100 110.5      60        15 2019
#> 8             67          39.5              149 123.4       2         1 2019
#> 9             25          43.7               54 118.1      11         4 2019
#> 10           336          36.3              239 110.2      65        NA 2019
#> 11            19          37.0              220 107.1     121        NA 2019
#> 12           197          41.7               98 113.2      32         5 2019
#> 13           266          38.8              170 116.4      17        NA 2019
#> 14           199          38.3              180 108.5      96        NA 2019
#> 15           186          41.0              112 101.6     231        NA 2019
#> 16           350          34.0              296  97.6     296        NA 2019
#> 17            47          36.0              243 109.8      72        NA 2019
#> 18            96          46.4               20 111.0      58        13 2019
#> 19            92          45.7               30 108.5      95        NA 2019
#> 20           114          47.9               12 108.4     100        NA 2019
#> 21           147          49.6                8 120.9       6         5 2019
#> 22           315          43.5               60 107.7     111        14 2019
#> 23            26          42.8               76 109.8      70        NA 2019
#> 24           162          38.2              184 109.3      79        NA 2019
#> 25            35          47.6               14 109.3      78        NA 2019
#> 26            79          42.2               89 107.0     124        NA 2019
#> 27           169          40.5              128  98.3     289        NA 2019
#> 28             2          43.6               57 107.8     107        NA 2019
#> 29            54          46.7               17 112.0      47        NA 2019
#> 30           216          41.1              109 104.9     165        NA 2019
#> 31             1          37.8              190 121.0       5         2 2019
#> 32           353          35.2              269 114.7      23        11 2019
#> 33           184          37.6              196 107.8     109        16 2019
#> 34           173          39.1              162 117.7      13         5 2019
#> 35           132          53.4                4 105.5     154        NA 2019
#> 36           164          38.3              181 107.4     114        15 2019
#> 37            41          34.5              282 103.4     196        15 2019
#> 38            48          43.8               52 107.8     108        NA 2019
#> 39           196          38.7              173  95.2     324        NA 2019
#> 40           308          34.1              295 111.1      55        NA 2019
#> 41            12          39.2              156 111.7      50        NA 2019
#> 42             7          42.3               87 106.1     145        NA 2019
#> 43            91          33.1              309 104.6     172        NA 2019
#> 44           125          45.5               32 122.5       4         3 2019
#> 45           233          35.1              270 106.6     136        NA 2019
#> 46            71          41.9               95 109.5      75        NA 2019
#> 47           178          45.8               29 106.8     130        NA 2019
#> 48           151          35.3              262 101.5     234        15 2019
#> 49           126          40.5              127 103.1     200        NA 2019
#> 50            95          46.4               22  98.7     281        NA 2019
#> 51           188          37.2              214  98.5     284        NA 2019
#> 52           225          38.7              172 106.8     132        NA 2019
#> 53            88          46.5               19 114.8      22        NA 2019
#> 54             8          43.8               51 115.6      18        11 2019
#> 55           286          37.8              192 110.4      63        NA 2019
#> 56            80          40.5              126 101.6     233        NA 2019
#> 57           295          30.3              338 102.0     221        NA 2019
#> 58           113          42.8               77 111.1      54        12 2019
#> 59           258          45.8               28 101.6     232        NA 2019
#> 60           310          33.3              305 100.8     248        NA 2019
#> 61            69          33.5              302 104.2     180        NA 2019
#> 62           311          48.0               11 107.4     117        16 2019
#> 63            24          32.2              324 122.7       3         2 2019
#> 64           153          52.7                5 107.0     126        NA 2019
#> 65           248          36.5              236 101.1     247        NA 2019
#> 66           222          39.5              151  97.8     294        NA 2019
#> 67           195          34.6              279 108.1     104        NA 2019
#> 68            52          44.4               41 101.9     223        NA 2019
#> 69           159          36.0              246 114.1      25         3 2019
#> 70           351          32.3              323 109.0      86        NA 2019
#> 71           124          35.6              254 112.1      44         9 2019
#> 72            66          35.3              263 111.6      51        14 2019
#> 73            27          39.0              166 117.4      15        10 2019
#> 74           181          38.9              167 103.7     189        NA 2019
#> 75           235          29.4              345  89.4     347        NA 2019
#> 76            45          44.5               40 106.4     140        NA 2019
#> 77            58          35.3              265 124.5       1         1 2019
#> 78           298          41.2              103 107.0     127        NA 2019
#> 79           205          41.0              110 100.2     254        NA 2019
#> 80           201          43.4               64 101.5     237        NA 2019
#> 81           112          39.6              147 118.9       9         6 2019
#> 82           302          36.3              238  99.9     261        NA 2019
#> 83           168          38.7              174 100.0     258        NA 2019
#> 84            14          35.8              253 119.7       8         1 2019
#> 85            65          40.2              136 102.1     217        NA 2019
#> 86           257          42.7               80 102.2     216        NA 2019
#> 87           300          42.1               91 105.7     150        NA 2019
#> 88           154          30.8              333 104.8     170        NA 2019
#> 89           249          50.1                6  99.5     274        NA 2019
#> 90           279          36.9              222  97.6     297        NA 2019
#> 91             6          41.3              101 109.4      76        14 2019
#> 92            64          47.0               16 108.9      89        NA 2019
#> 93           305          41.0              113 108.5      97        13 2019
#> 94           340          39.1              158 101.8     225        NA 2019
#> 95           123          37.2              213 109.9      67        NA 2019
#> 96           276          32.4              320 107.4     118        13 2019
#> 97           255          34.6              281 110.4      62         5 2019
#> 98           108          39.9              145 113.2      33         8 2019
#> 99           319          36.0              244 108.4      99        NA 2019
#> 100          242          38.5              177 108.6      92        11 2019
#> 101           49          39.6              146 106.5     137        NA 2019
#> 102            5          37.9              188 112.6      39         8 2019
#> 103          346          44.0               47 106.5     138        NA 2019
#> 104           36          46.4               21 108.2     102        NA 2019
#> 105          157          40.0              139 103.4     194        NA 2019
#> 106           53          37.2              215 103.9     184        NA 2019
#> 107          136          34.2              292 100.0     260        NA 2019
#> 108          320          33.1              311 100.0     256        NA 2019
#> 109          332          28.6              349 101.4     239        NA 2019
#> 110           15          37.5              201 108.9      90        NA 2019
#> 111          190          35.8              251 109.0      88        NA 2019
#> 112           68          42.6               83 115.3      19         3 2019
#> 113          224          38.9              168 112.0      45        NA 2019
#> 114          194          29.6              341 117.6      14         2 2019
#> 115          101          36.7              227 101.9     222        NA 2019
#> 116          165          46.0               24 102.4     213        NA 2019
#> 117           18          36.5              234 101.2     244        NA 2019
#> 118          228          42.8               79 111.3      53        NA 2019
#> 119           42          42.4               85  99.9     262        NA 2019
#> 120          307          35.9              247 105.5     155        NA 2019
#> 121          142          35.0              271 104.2     179        NA 2019
#> 122          348          35.2              267 101.7     229        NA 2019
#> 123          325          40.3              129 101.1     245        NA 2019
#> 124          214          35.8              252 113.1      34        NA 2019
#> 125          109          39.4              153 107.6     112        NA 2019
#> 126           50          53.5                3 116.5      16         6 2019
#> 127          294          40.0              140 107.4     116        NA 2019
#> 128          226          44.5               39 106.9     129        16 2019
#> 129           21          45.9               26 105.8     149        NA 2019
#> 130          217          34.5              284  97.5     298        NA 2019
#> 131          121          42.6               84 103.2     198        NA 2019
#> 132          161          39.5              152 109.5      74        12 2019
#> 133            4          41.5               99 103.6     190        NA 2019
#> 134           62          37.1              218 105.4     156        NA 2019
#> 135          145          42.2               90  96.0     317        NA 2019
#> 136          281          42.8               74 101.5     235        NA 2019
#> 137          290          39.9              144 107.7     110         9 2019
#> 138          275          34.9              275 113.9      27         4 2019
#> 139           40          40.0              141 102.9     203        NA 2019
#> 140          314          34.1              294 103.5     192        NA 2019
#> 141           13          42.8               75 103.7     188        NA 2019
#> 142           34          36.6              233 112.5      41        12 2019
#> 143          166          37.0              219 113.4      31         6 2019
#> 144          129          37.3              210 101.4     238        14 2019
#> 145           83          45.6               31 100.8     249        NA 2019
#> 146           60          40.2              133 105.9     147        NA 2019
#> 147          345          42.9               73 106.1     144        NA 2019
#> 148          240          45.4               35 102.6     206        NA 2019
#> 149          219          32.7              319 105.3     160        NA 2019
#> 150          152          43.5               59 113.6      29        NA 2019
#> 151          328          37.1              216 101.8     227        NA 2019
#> 152          137          43.4               65 101.3     242        NA 2019
#> 153           70          45.5               33  98.4     285        NA 2019
#> 154          115          42.8               78 114.0      26         7 2019
#> 155           63          44.3               43 104.1     181        NA 2019
#> 156           10          40.2              135 107.0     125        NA 2019
#> 157          183          34.9              276 105.6     151        NA 2019
#> 158          269          41.2              105 100.8     250        NA 2019
#> 159           55          50.0                7  99.0     277        NA 2019
#> 160           90          40.1              138 107.1     122        NA 2019
#> 161           17          37.5              202 110.3      64        NA 2019
#> 162          265          33.1              310 111.1      57         9 2019
#> 163          285          43.3               67  95.1     325        NA 2019
#> 164           11          37.5              204 110.1      66        NA 2019
#> 165          176          37.5              200 109.1      83        NA 2019
#> 166          118          43.7               55 104.1     183        NA 2019
#> 167          171          42.7               81 101.1     246        NA 2019
#> 168          127          33.3              304 112.3      42         7 2019
#> 169          184          36.8              225 104.9     166        NA 2019
#> 170          323          41.9               96 106.2     142        NA 2019
#> 171          278          37.4              208 109.0      85        NA 2019
#> 172          289          41.8               97 105.8     148        NA 2019
#> 173          211          32.8              317 111.7      49        NA 2019
#> 174           57          39.0              165 104.5     174        NA 2019
#> 175          231          44.7               38 106.9     128        NA 2019
#> 176          104          39.9              143 114.5      24         2 2019
#> 177          122          43.7               56 113.7      28         7 2019
#> 178          213          44.0               48 104.3     178        NA 2019
#> 179          155          43.8               50  99.7     268        NA 2019
#> 180          270          33.1              312 104.4     176        NA 2019
#> 181          181          43.0               71  98.3     290        NA 2019
#> 182          101          40.8              116 115.3      20         9 2019
#> 183          111          35.9              248  96.8     305        NA 2019
#> 184          253          38.1              185 107.4     115        NA 2019
#> 185           32          40.1              137 109.1      84        11 2019
#> 186          133          34.4              286 101.5     236        NA 2019
#> 187          131          33.6              301 101.8     226        NA 2019
#> 188           89          38.6              176  96.1     314        NA 2019
#> 189          140          41.0              111 112.7      38        NA 2019
#> 190          203          38.3              182 104.9     167        NA 2019
#> 191           73          37.6              195 105.4     158        NA 2019
#> 192          246          34.3              289  96.6     308        NA 2019
#> 193          263          36.9              223 108.2     103        NA 2019
#> 194          130          40.7              121 106.7     133        NA 2019
#> 195          347          42.9               72  96.1     316        NA 2019
#> 196          117          47.7               13 100.7     251        NA 2019
#> 197           37          45.3               36 104.1     182        NA 2019
#> 198          134          46.5               18 113.0      35        12 2019
#> 199          321          37.2              212 103.1     199        NA 2019
#> 200          167          40.7              122 100.6     253        NA 2019
#> 201          312          37.5              205  98.6     283        NA 2019
#> 202          264          37.9              189 103.4     193        NA 2019
#> 203          326          37.3              211 106.4     141        NA 2019
#> 204          334          30.3              339 101.3     243        NA 2019
#> 205          103          48.3                9 108.3     101        NA 2019
#> 206          212          40.8              118  99.6     269        NA 2019
#> 207          337          36.6              232 108.5      93        NA 2019
#> 208          175          39.5              150 105.0     163        NA 2019
#> 209          218          40.2              132 106.1     146        NA 2019
#> 210          293          39.6              148  96.4     311        NA 2019
#> 211           23          40.9              114  99.5     272        NA 2019
#> 212          141          33.0              314 103.3     197        NA 2019
#> 213           86          44.1               46 115.2      21         6 2019
#> 214          238          37.6              198 105.5     153        NA 2019
#> 215          198          35.5              259 109.7      73        11 2019
#> 216          180          38.7              171 102.7     205        NA 2019
#> 217          192          34.4              285  89.9     345        NA 2019
#> 218          270          39.3              154 109.9      69        NA 2019
#> 219          252          53.6                2 106.7     134        NA 2019
#> 220          329          40.2              134  96.1     315        NA 2019
#> 221           43          38.4              179 108.4      98         4 2019
#> 222          149          31.9              327 103.0     201        NA 2019
#> 223          210          37.5              199 113.5      30        NA 2019
#> 224          207          43.3               66 110.5      61        10 2019
#> 225           82          29.2              347  97.0     302        NA 2019
#> 226          191          43.5               61 109.9      68        NA 2019
#> 227           51          38.7              175 102.6     208        NA 2019
#> 228          338          35.2              266  95.5     320        NA 2019
#> 229          223          43.2               68 110.5      59         8 2019
#> 230          236          40.9              115 102.9     202        NA 2019
#> 231           20          34.5              283 112.1      43        NA 2019
#> 232          251          37.7              193 112.8      36         4 2019
#> 233           78          41.1              108  89.6     346        NA 2019
#> 234          189          29.6              342  96.6     309        NA 2019
#> 235          208          39.0              163 107.6     113        NA 2019
#> 236           56          37.4              207 111.1      56        NA 2019
#> 237          232          36.9              221 104.9     168        NA 2019
#> 238          105          43.5               58 100.0     257        NA 2019
#> 239          292          27.3              351  92.8     337        NA 2019
#> 240           84          36.4              237 112.0      46        NA 2019
#> 241          296          43.5               63  96.7     306        NA 2019
#> 242          163          35.4              260 103.8     186        NA 2019
#> 243           97          37.4              206 109.2      80        11 2019
#> 244          274          34.3              288 104.6     173        NA 2019
#> 245           30          35.8              250  92.0     339        NA 2019
#> 246           29          42.4               86  99.9     264        NA 2019
#> 247          158          40.3              131  94.6     329        NA 2019
#> 248          254          35.6              256 108.0     106        NA 2019
#> 249          303          33.9              297  97.2     301        NA 2019
#> 250          215          33.2              308 102.1     218        NA 2019
#> 251          260          31.8              329 105.1     162        NA 2019
#> 252          203          38.5              178 101.4     240        NA 2019
#> 253          352          29.3              346 100.2     255        NA 2019
#> 254          193          37.7              194  96.5     310        NA 2019
#> 255          135          45.5               34  99.9     263        NA 2019
#> 256          331          40.8              117  98.9     280        NA 2019
#> 257           33          35.0              273 105.0     164        NA 2019
#> 258          316          36.9              224  99.5     271        NA 2019
#> 259          268          31.8              328  94.2     330        NA 2019
#> 260          339          34.4              287 107.1     123        NA 2019
#> 261          146          48.1               10  84.4     353        NA 2019
#> 262          187          35.5              258 102.1     220        NA 2019
#> 263          349          31.2              331 108.5      94        NA 2019
#> 264          324          42.1               92  99.5     273        NA 2019
#> 265           74          38.1              186 102.4     212        NA 2019
#> 266          342          34.6              280  94.7     327        NA 2019
#> 267          284          31.1              332  98.3     287        NA 2019
#> 268          179          36.7              228 109.0      87        10 2019
#> 269          119          40.5              124 100.6     252        NA 2019
#> 270           38          43.1               70 101.6     230        NA 2019
#> 271          150          33.0              313  93.6     332        NA 2019
#> 272          177          34.9              274 106.8     131        NA 2019
#> 273          267          33.9              298 102.1     219        16 2019
#> 274          327          45.9               27 104.8     169        NA 2019
#> 275          318          35.4              261  98.3     288        NA 2019
#> 276          322          37.5              202 102.4     210        NA 2019
#> 277           75          34.1              293  94.6     328        NA 2019
#> 278           94          44.4               42 104.6     171        NA 2019
#> 279          241          44.7               37 105.4     159        NA 2019
#> 280          288          32.9              316 102.5     209        NA 2019
#> 281           93          36.1              242 109.2      81        NA 2019
#> 282           98          37.1              217 106.1     143        NA 2019
#> 283          128          35.6              255 105.2     161        NA 2019
#> 284          333          39.0              164  95.2     323        NA 2019
#> 285           87          44.1               45  93.3     334        NA 2019
#> 286           39          36.6              229 111.7      48        NA 2019
#> 287          341          40.3              130  97.0     303        NA 2019
#> 288          256          36.5              235 109.4      77        NA 2019
#> 289          239          39.2              157  99.8     266        NA 2019
#> 290          313          34.2              291 117.7      12         3 2019
#> 291          297          38.9              169  90.1     343        NA 2019
#> 292           16          37.6              197  97.3     300        NA 2019
#> 293           28          43.5               62  96.3     312        NA 2019
#> 294          247          38.0              187 107.2     119        NA 2019
#> 295          201          43.1               69  99.8     265        NA 2019
#> 296          100          36.7              226  97.3     299        NA 2019
#> 297          273          36.6              230 103.7     187        NA 2019
#> 298          261          42.1               93  93.3     333        NA 2019
#> 299          245          47.6               15 100.0     259        NA 2019
#> 300           31          29.6              343 111.4      52        10 2019
#> 301           77          28.2              350 103.6     191        NA 2019
#> 302          110          39.1              160 109.8      71        NA 2019
#> 303           22          36.6              231  97.8     295        16 2019
#> 304           98          43.7               53 108.0     105        NA 2019
#> 305          160          32.0              326  87.0     350        NA 2019
#> 306          277          22.6              353  92.0     338        NA 2019
#> 307          138          42.0               94  96.2     313        NA 2019
#> 308           61          29.7              340  99.6     270        NA 2019
#> 309            9          40.7              120 102.9     204        NA 2019
#> 310          170          36.2              240  89.3     348        NA 2019
#> 311          200          33.6              299 109.1      82        NA 2019
#> 312          220          33.2              306 105.6     152        NA 2019
#> 313          272          41.1              107  94.8     326        NA 2019
#> 314          229          32.7              318  99.1     276        NA 2019
#> 315          227          42.2               88 102.2     215        NA 2019
#> 316          230          34.3              290  95.4     321        NA 2019
#> 317          280          42.6               82  95.6     319        NA 2019
#> 318          301          30.5              335 105.4     157        NA 2019
#> 319          120          39.1              159 106.6     135        NA 2019
#> 320          344          32.3              322 102.6     207        NA 2019
#> 321          259          28.7              348  89.9     344        NA 2019
#> 322          172          35.0              272  97.9     293        NA 2019
#> 323           76          32.4              321  98.1     292        NA 2019
#> 324          139          33.2              307  98.2     291        NA 2019
#> 325            3          37.8              191  93.3     335        NA 2019
#> 326          317          30.8              334  98.3     286        NA 2019
#> 327          156          37.3              209 120.0       7         1 2019
#> 328          304          35.3              264 104.4     175        NA 2019
#> 329          299          36.0              245 107.2     120        NA 2019
#> 330           46          33.4              303 101.7     228        NA 2019
#> 331          283          39.3              155  99.2     275        NA 2019
#> 332           85          41.2              104 104.3     177         8 2019
#> 333          107          40.6              123 101.3     241        NA 2019
#> 334          209          27.2              352  90.4     340        NA 2019
#> 335          116          32.9              315 102.2     214        13 2019
#> 336          282          35.5              257  96.9     304        NA 2019
#> 337          174          33.6              300  99.7     267        NA 2019
#> 338          343          40.5              125  98.9     279        NA 2019
#> 339          143          45.9               25  93.9     331        NA 2019
#> 340          335          34.9              277 103.4     195        NA 2019
#> 341          237          39.1              161 101.9     224        NA 2019
#> 342          330          40.8              119  95.3     322        NA 2019
#> 343           59          34.6              278  98.9     278        NA 2019
#> 344          287          29.5              344  93.2     336        NA 2019
#> 345          250          41.1              106 102.4     211        NA 2019
#> 346           72          57.7                1  96.6     307        NA 2019
#> 347          291          40.0              142  84.5     352        NA 2019
#> 348          309          46.0               23  88.9     349        NA 2019
#> 349          206          30.4              337  98.7     282        NA 2019
#> 350          306          35.9              249  90.1     342        NA 2019
#> 351          262          32.1              325 103.8     185        NA 2019
#> 352          148          36.2              241  85.4     351        NA 2019
#> 353          243          31.3              330  90.2     341        NA 2019
#>     Def.FG_3.Pct Def.FG_3.Pct.Rk Def.FG_2.Pct Def.FG_2.Pct.Rk Def.FT.Pct
#> 1           33.8             137         49.8             155       73.3
#> 2           32.6              72         50.6             197       70.9
#> 3           34.5             182         48.9             121       68.2
#> 4           30.6              22         44.7              15       68.9
#> 5           35.3             225         51.3             230       70.1
#> 6           35.4             239         52.7             277       72.0
#> 7           33.9             145         50.5             194       71.0
#> 8           28.9               3         45.7              22       66.6
#> 9           32.7              75         49.0             125       72.2
#> 10          36.5             286         55.2             335       74.7
#> 11          34.2             161         47.0              53       65.8
#> 12          32.4              65         45.1              19       67.9
#> 13          35.3             227         51.5             242       70.4
#> 14          34.7             200         47.3              60       71.5
#> 15          38.5             339         52.9             281       71.3
#> 16          38.9             344         48.4              98       67.7
#> 17          33.4             115         48.4              96       68.0
#> 18          33.7             133         53.0             283       73.5
#> 19          34.4             180         53.2             290       72.6
#> 20          30.7              24         50.2             178       70.6
#> 21          34.7             199         51.4             234       71.1
#> 22          32.8              78         51.2             220       70.0
#> 23          31.4              32         46.6              39       67.9
#> 24          34.8             202         51.6             246       73.4
#> 25          35.4             236         53.5             301       71.8
#> 26          34.8             205         54.9             331       70.0
#> 27          37.2             310         53.8             313       68.6
#> 28          35.2             222         53.2             287       72.9
#> 29          35.0             213         52.9             282       68.2
#> 30          38.4             336         49.9             163       73.5
#> 31          31.6              38         41.9               2       67.9
#> 32          32.1              56         49.2             132       73.6
#> 33          33.7             132         50.4             187       72.2
#> 34          35.7             257         48.4              95       71.5
#> 35          34.5             186         50.1             174       65.2
#> 36          34.3             174         49.2             133       74.6
#> 37          33.3             110         49.8             153       72.5
#> 38          37.8             326         57.4             349       70.4
#> 39          34.3             170         55.4             337       71.2
#> 40          33.9             147         53.5             302       69.4
#> 41          32.0              54         48.5             102       75.9
#> 42          34.0             152         51.4             231       71.0
#> 43          35.1             217         47.6              67       69.9
#> 44          34.2             168         47.2              58       73.2
#> 45          35.1             216         47.3              59       70.1
#> 46          35.4             233         48.3              88       74.8
#> 47          38.0             328         52.0             259       70.2
#> 48          32.8              80         46.5              38       72.8
#> 49          35.6             252         51.3             224       68.5
#> 50          30.7              23         53.5             298       70.5
#> 51          33.9             143         48.0              78       67.0
#> 52          32.3              62         53.1             286       71.5
#> 53          35.6             250         51.7             248       72.2
#> 54          34.4             178         47.2              57       69.3
#> 55          29.3              10         53.6             307       68.3
#> 56          36.8             300         49.9             157       70.2
#> 57          35.5             245         50.8             209       71.1
#> 58          33.3             104         48.3              91       67.4
#> 59          34.1             156         57.8             352       67.8
#> 60          33.6             125         44.9              17       72.2
#> 61          36.6             292         48.7             107       70.6
#> 62          37.0             304         52.6             275       74.5
#> 63          35.4             237         44.7              16       65.5
#> 64          33.8             138         51.6             245       71.4
#> 65          35.6             251         52.6             272       72.4
#> 66          32.3              63         55.7             338       72.1
#> 67          34.2             169         48.2              85       74.4
#> 68          32.9              84         53.2             289       72.6
#> 69          29.8              13         41.9               3       69.4
#> 70          36.1             275         50.0             166       68.0
#> 71          31.3              30         44.5              13       65.0
#> 72          31.0              27         47.8              71       73.4
#> 73          32.4              68         53.5             299       69.0
#> 74          39.0             347         51.3             226       75.8
#> 75          30.2              19         50.4             186       70.5
#> 76          36.2             281         54.9             332       65.6
#> 77          30.4              20         43.4               6       69.7
#> 78          31.9              45         50.5             196       71.7
#> 79          35.5             247         52.6             276       70.2
#> 80          36.4             282         52.0             258       71.1
#> 81          33.6             123         47.1              55       71.7
#> 82          41.8             353         51.7             249       73.2
#> 83          39.0             345         50.3             179       71.3
#> 84          33.5             119         47.9              75       67.9
#> 85          31.8              42         49.9             159       70.6
#> 86          39.6             351         54.2             320       74.6
#> 87          34.2             160         49.6             145       70.6
#> 88          38.4             335         48.2              84       74.2
#> 89          33.7             131         50.5             192       76.5
#> 90          35.3             229         52.2             266       78.6
#> 91          32.0              49         49.9             164       72.5
#> 92          31.2              29         48.6             105       68.8
#> 93          35.1             220         46.3              33       73.4
#> 94          38.0             329         51.3             227       71.5
#> 95          39.1             349         48.5             100       70.0
#> 96          33.9             142         40.7               1       71.1
#> 97          31.5              34         44.1              10       66.8
#> 98          37.4             320         48.2              87       70.5
#> 99          34.6             191         50.0             166       69.9
#> 100         34.2             164         50.3             182       71.0
#> 101         30.0              16         50.8             204       70.2
#> 102         35.4             235         42.2               4       71.3
#> 103         34.5             184         56.2             340       72.9
#> 104         33.0              94         47.3              63       70.9
#> 105         33.1              96         54.7             327       71.0
#> 106         33.0              93         47.2              56       69.6
#> 107         35.3             228         51.7             251       71.0
#> 108         36.2             278         54.1             318       70.5
#> 109         33.7             129         52.1             261       72.0
#> 110         33.9             146         49.6             148       71.7
#> 111         34.7             196         47.9              73       70.2
#> 112         27.9               1         43.0               5       69.4
#> 113         31.9              47         49.3             139       72.2
#> 114         34.3             175         43.6               8       70.5
#> 115         35.7             258         51.0             214       71.4
#> 116         38.1             330         56.9             347       72.4
#> 117         37.3             315         52.2             263       73.1
#> 118         35.7             256         52.2             264       70.4
#> 119         35.3             224         51.2             223       71.2
#> 120         34.8             201         54.9             333       71.3
#> 121         37.3             316         49.3             138       72.8
#> 122         31.7              40         49.7             150       70.4
#> 123         36.5             284         53.0             284       70.5
#> 124         30.9              26         51.0             212       70.4
#> 125         35.0             211         53.5             297       71.6
#> 126         34.3             172         49.7             152       70.0
#> 127         34.3             173         52.0             257       74.3
#> 128         36.6             295         50.3             185       68.4
#> 129         33.3             106         48.8             120       70.2
#> 130         37.6             324         61.2             353       73.5
#> 131         34.5             185         51.5             241       72.2
#> 132         29.0               5         48.8             118       70.2
#> 133         36.9             302         51.1             218       76.0
#> 134         38.8             342         54.4             324       73.5
#> 135         36.6             293         51.2             222       70.4
#> 136         34.2             163         51.0             211       72.0
#> 137         33.4             116         46.0              26       71.0
#> 138         33.6             122         46.0              27       68.6
#> 139         35.0             215         50.5             195       73.3
#> 140         38.1             331         56.7             344       71.8
#> 141         34.5             187         50.3             184       67.8
#> 142         28.9               4         48.3              90       71.7
#> 143         31.9              46         44.7              14       72.3
#> 144         32.4              67         43.6               7       66.7
#> 145         33.8             139         46.8              46       71.9
#> 146         32.9              88         49.7             149       72.6
#> 147         35.4             238         46.9              50       71.2
#> 148         36.8             299         49.6             147       72.4
#> 149         31.8              44         50.8             205       69.1
#> 150         35.4             234         46.2              30       69.6
#> 151         32.8              81         48.8             119       67.8
#> 152         37.4             321         50.1             176       72.0
#> 153         35.9             267         51.0             213       65.5
#> 154         33.2             102         46.3              32       67.6
#> 155         33.3             103         48.7             108       69.0
#> 156         34.4             179         54.0             316       68.3
#> 157         38.2             332         54.7             329       68.0
#> 158         35.8             262         55.9             339       70.3
#> 159         37.8             325         51.5             237       73.3
#> 160         36.5             285         52.1             260       69.4
#> 161         30.4              21         49.9             165       71.2
#> 162         33.3             109         45.8              23       67.2
#> 163         34.6             190         51.6             244       73.4
#> 164         33.3             108         48.9             124       68.9
#> 165         33.0              91         53.6             308       73.5
#> 166         35.5             242         50.8             208       68.8
#> 167         35.9             266         48.8             115       71.9
#> 168         35.5             243         45.1              20       66.3
#> 169         34.4             177         52.5             270       70.9
#> 170         37.3             311         52.8             279       71.1
#> 171         33.5             121         49.2             134       73.2
#> 172         32.5              70         50.0             166       70.5
#> 173         37.3             317         51.2             219       73.0
#> 174         31.6              37         54.7             326       71.4
#> 175         35.5             241         51.4             232       71.8
#> 176         29.1               6         44.3              11       66.3
#> 177         32.0              53         46.0              25       69.5
#> 178         34.2             166         55.0             334       73.5
#> 179         34.8             204         49.0             129       68.0
#> 180         34.7             195         56.4             342       72.9
#> 181         32.8              82         47.7              69       71.0
#> 182         34.5             181         47.5              66       68.3
#> 183         31.7              41         49.5             142       70.8
#> 184         34.2             165         50.5             191       71.6
#> 185         32.7              76         47.9              74       74.1
#> 186         35.8             263         53.6             305       67.2
#> 187         39.3             350         53.8             315       77.0
#> 188         34.6             193         52.3             268       73.9
#> 189         35.1             218         48.2              83       72.4
#> 190         38.5             338         56.7             343       69.5
#> 191         32.8              77         47.5              65       69.2
#> 192         35.5             244         50.8             203       67.5
#> 193         33.3             105         48.4              97       71.1
#> 194         36.7             298         52.2             265       73.4
#> 195         38.4             337         49.0             126       67.1
#> 196         35.9             265         51.9             255       68.9
#> 197         33.2             100         47.4              64       70.0
#> 198         33.4             113         48.1              81       70.9
#> 199         40.3             352         49.4             140       71.6
#> 200         35.8             261         50.7             200       75.2
#> 201         33.3             110         53.0             285       70.2
#> 202         34.6             189         53.4             296       68.4
#> 203         35.0             214         50.0             171       70.6
#> 204         33.5             120         51.6             247       69.5
#> 205         37.3             318         53.6             304       73.9
#> 206         30.0              17         50.1             172       68.7
#> 207         33.3             107         53.7             312       73.3
#> 208         33.0              95         49.1             131       68.5
#> 209         35.7             254         49.7             151       69.2
#> 210         36.1             274         48.0              79       71.5
#> 211         32.9              90         50.6             199       73.4
#> 212         34.4             176         52.2             267       71.7
#> 213         29.3               9         49.2             135       70.5
#> 214         32.9              83         51.8             253       68.0
#> 215         33.4             114         47.3              61       70.5
#> 216         36.4             283         51.3             228       74.0
#> 217         34.1             155         51.1             215       71.6
#> 218         34.7             197         53.2             288       68.9
#> 219         37.1             308         57.5             350       71.6
#> 220         32.4              66         49.0             127       74.6
#> 221         31.4              33         49.0             128       67.4
#> 222         39.0             346         54.3             322       74.4
#> 223         33.8             135         46.9              49       70.9
#> 224         31.6              39         48.5              99       69.3
#> 225         32.7              74         50.5             193       70.5
#> 226         34.9             209         51.7             250       72.7
#> 227         32.5              69         48.2              86       68.7
#> 228         37.4             319         49.9             160       70.3
#> 229         32.9              87         46.8              48       72.2
#> 230         37.8             327         50.1             173       70.0
#> 231         32.1              55         47.7              68       70.5
#> 232         33.5             118         45.3              21       72.2
#> 233         36.2             279         48.5             101       70.9
#> 234         37.0             306         50.8             207       75.9
#> 235         35.2             221         48.4              92       71.8
#> 236         35.6             249         48.7             109       69.9
#> 237         33.6             127         45.8              24       71.6
#> 238         34.2             167         51.2             221       71.5
#> 239         36.7             296         52.4             269       67.3
#> 240         36.6             289         48.3              89       73.6
#> 241         32.9              89         49.6             146       69.6
#> 242         37.0             305         50.7             202       71.0
#> 243         32.9              86         51.5             235       68.0
#> 244         32.0              52         51.6             243       66.9
#> 245         37.3             312         56.3             341       65.3
#> 246         33.7             128         50.6             198       71.2
#> 247         37.1             309         49.3             136       71.9
#> 248         35.0             210         44.4              12       73.1
#> 249         36.6             294         51.5             236       71.5
#> 250         32.3              61         46.2              31       65.8
#> 251         34.5             183         47.0              52       68.6
#> 252         34.0             151         51.5             238       71.3
#> 253         35.6             253         50.8             206       74.1
#> 254         34.6             192         53.3             292       68.0
#> 255         31.6              36         48.7             111       69.4
#> 256         38.4             333         52.6             273       72.2
#> 257         34.1             157         48.8             113       72.8
#> 258         30.1              18         46.6              40       67.5
#> 259         36.7             297         54.8             330       69.2
#> 260         33.9             148         48.1              82       72.6
#> 261         33.6             126         52.1             262       69.8
#> 262         29.2               7         50.0             170       71.3
#> 263         33.7             130         51.9             254       71.0
#> 264         38.8             343         52.8             280       73.5
#> 265         31.6              35         49.3             137       73.0
#> 266         38.6             340         46.7              41       74.0
#> 267         36.9             303         57.1             348       70.6
#> 268         34.0             154         48.7             110       74.2
#> 269         35.7             255         53.6             303       68.2
#> 270         36.0             273         53.3             294       71.1
#> 271         30.9              25         48.7             106       68.8
#> 272         31.8              43         48.8             116       66.3
#> 273         31.2              28         53.7             311       69.3
#> 274         33.9             144         51.3             225       69.7
#> 275         34.1             159         50.5             190       71.2
#> 276         36.0             271         50.2             177       74.5
#> 277         34.9             208         46.1              29       74.7
#> 278         33.8             140         49.5             144       68.0
#> 279         36.0             270         49.9             158       72.7
#> 280         32.1              58         46.7              43       70.6
#> 281         32.2              59         48.9             122       70.1
#> 282         33.2             101         47.8              72       70.0
#> 283         35.0             212         51.1             216       65.1
#> 284         34.7             194         53.6             309       71.0
#> 285         34.3             171         54.0             317       72.1
#> 286         37.3             314         46.7              44       66.8
#> 287         36.5             287         51.5             240       70.7
#> 288         35.4             232         48.4              93       71.8
#> 289         34.0             150         54.4             323       72.7
#> 290         33.7             134         49.4             141       69.0
#> 291         35.9             269         46.8              45       66.1
#> 292         33.6             124         50.7             201       68.2
#> 293         35.4             240         53.4             295       68.2
#> 294         31.9              48         48.8             114       74.4
#> 295         32.8              79         46.4              35       68.1
#> 296         33.8             136         53.2             291       74.0
#> 297         34.6             188         46.4              36       67.9
#> 298         36.2             280         56.7             345       72.1
#> 299         29.6              11         46.1              28       65.9
#> 300         34.0             153         48.7             112       69.2
#> 301         32.4              64         50.3             183       76.1
#> 302         36.1             277         51.3             229       71.9
#> 303         32.0              51         50.9             210       69.2
#> 304         33.1              97         48.6             104       70.8
#> 305         35.3             231         54.1             319       63.7
#> 306         35.9             267         53.7             310       71.0
#> 307         34.0             149         51.8             252       71.3
#> 308         33.8             141         50.3             180       69.0
#> 309         29.3               8         48.0              76       71.4
#> 310         32.1              57         55.3             336       69.5
#> 311         33.1              98         47.3              62       64.9
#> 312         35.3             226         47.0              51       66.5
#> 313         35.8             259         51.1             217       72.1
#> 314         37.0             307         50.4             188       70.6
#> 315         34.9             207         48.0              77       71.6
#> 316         35.6             248         49.8             156       65.8
#> 317         35.5             246         49.9             162       74.2
#> 318         33.3             110         47.7              70       72.9
#> 319         33.0              92         46.5              37       69.3
#> 320         36.0             272         49.5             143       74.0
#> 321         39.1             348         51.4             233       69.2
#> 322         36.6             288         54.2             321       70.1
#> 323         36.6             291         53.8             314       74.0
#> 324         33.4             117         49.8             154       70.8
#> 325         38.7             341         52.7             278       71.3
#> 326         32.0              50         48.5             103       68.4
#> 327         30.0              15         45.0              18       69.6
#> 328         34.1             157         54.7             328       69.5
#> 329         33.1              99         49.1             130       68.6
#> 330         29.7              12         46.3              34       68.9
#> 331         36.9             301         50.1             175       69.7
#> 332         28.5               2         43.8               9       69.0
#> 333         29.9              14         50.0             166       69.4
#> 334         38.4             334         57.8             351       69.5
#> 335         31.4              31         46.7              42       72.2
#> 336         37.5             322         56.8             346       69.8
#> 337         32.6              73         51.5             239       70.1
#> 338         32.5              71         50.3             181       72.8
#> 339         35.2             223         49.9             161       71.3
#> 340         34.2             162         50.4             189       68.3
#> 341         34.8             206         54.6             325       71.1
#> 342         35.1             219         52.6             274       71.9
#> 343         35.9             264         48.9             123       70.8
#> 344         35.8             260         48.4              94       70.0
#> 345         34.8             203         53.6             306       70.5
#> 346         36.1             276         53.5             300       71.7
#> 347         34.7             198         52.6             271       71.9
#> 348         36.6             290         47.1              54       69.7
#> 349         32.9              85         52.0             256       69.8
#> 350         37.5             323         48.1              80       69.3
#> 351         32.3              60         48.8             117       72.4
#> 352         37.3             313         53.3             293       69.2
#> 353         35.3             230         46.8              47       70.1
#>     Def.FT.Pct.Rk Def.Blk.Pct Def.Blk.Pct.Rk Def.Stl.Pct Def.Stl.Pct.Rk
#> 1             302         6.3            309         7.5            281
#> 2             183         8.9            188         8.7            187
#> 3              54         6.1            316         8.3            225
#> 4              79        11.2             74         7.7            273
#> 5             136        10.5            117        10.6             45
#> 6             255         5.6            332         8.3            223
#> 7             192         9.7            147         9.0            154
#> 8              19        13.0             28         9.1            146
#> 9             264         8.4            205        10.4             57
#> 10            343         5.6            331         7.6            278
#> 11             11        10.2            127        11.2             26
#> 12             38        11.2             81         6.9            325
#> 13            149         9.3            171         9.0            147
#> 14            225         6.6            295         8.1            240
#> 15            216        11.0             97         7.1            312
#> 16             34        11.2             78         7.3            300
#> 17             49         9.4            164         8.5            212
#> 18            314         6.0            322         9.2            132
#> 19            282         6.2            314         9.8             85
#> 20            173        10.3            123        10.1             71
#> 21            200        15.5              5        13.1              2
#> 22            126        14.0             16        11.0             33
#> 23             42        11.5             65         7.2            304
#> 24            306         9.9            143         8.9            168
#> 25            245         4.8            343         8.4            220
#> 26            127         8.1            220         9.4            114
#> 27             67         5.1            340         7.4            294
#> 28            293         7.4            261         8.1            244
#> 29             55         7.3            266         9.5            108
#> 30            317         6.3            306         6.7            331
#> 31             39        13.7             21         7.5            282
#> 32            320         6.9            286         9.2            134
#> 33            265         7.4            260         8.9            172
#> 34            227        14.0             17        11.7             18
#> 35              5         5.2            337         7.4            289
#> 36            339         8.1            221         9.4            116
#> 37            279         7.5            256        12.0             14
#> 38            153         4.1            353         7.4            291
#> 39            204         4.8            344         5.6            352
#> 40            101         9.0            182         9.7             92
#> 41            348         8.1            219         9.1            139
#> 42            190         8.2            217        10.0             74
#> 43            122        11.7             56         9.9             78
#> 44            300        12.6             33         9.1            140
#> 45            133        10.9             99        10.1             69
#> 46            344        13.1             26         8.5            213
#> 47            143        12.3             39         9.6            102
#> 48            290        11.5             64         7.7            271
#> 49             64        10.8            103         8.2            228
#> 50            156         9.7            149         8.7            191
#> 51             24        11.9             47         8.1            245
#> 52            226         7.0            284         8.6            203
#> 53            262         7.0            283         6.8            328
#> 54             94         9.1            178         8.7            184
#> 55             58         7.1            275         9.5            106
#> 56            139        11.6             61         9.3            123
#> 57            201        10.1            131         7.2            306
#> 58             30         7.4            257         9.2            133
#> 59             36         4.5            350         6.0            346
#> 60            271         8.8            191         6.0            345
#> 61            171         7.2            271        10.1             73
#> 62            338         6.6            292         6.7            333
#> 63              7        14.8             10         8.4            219
#> 64            219         6.5            299         5.4            353
#> 65            276         7.6            248         9.0            148
#> 66            258         7.1            276         7.9            258
#> 67            336        12.1             43         8.6            195
#> 68            280         8.1            226         7.7            272
#> 69            103        15.4              8        10.8             37
#> 70             48         7.3            263         7.8            268
#> 71              3        12.6             34         8.5            211
#> 72            311        11.1             88         7.7            269
#> 73             81         9.0            180         8.5            209
#> 74            346         8.8            189         6.6            337
#> 75            158        11.2             79        10.6             44
#> 76              9         7.8            238         7.4            293
#> 77            114        13.8             18        10.5             48
#> 78            238         5.2            336         7.0            319
#> 79            145         6.2            313         8.4            215
#> 80            203         6.6            298         5.7            350
#> 81            239        12.5             35        10.3             61
#> 82            299         7.7            246         6.8            327
#> 83            212        10.7            105         8.6            196
#> 84             41         9.5            160         9.2            130
#> 85            172         9.1            177         7.1            313
#> 86            341         7.6            251         7.3            295
#> 87            166        11.1             86         8.1            243
#> 88            330        11.3             69         9.2            137
#> 89            351         7.3            267         8.4            217
#> 90            353         6.0            320         7.6            276
#> 91            278        11.1             92         8.5            214
#> 92             72        11.7             52        12.2              8
#> 93            307        11.7             56         8.0            252
#> 94            228        10.4            119         5.7            351
#> 95            125        11.8             51        10.4             53
#> 96            202        10.7            108         8.2            226
#> 97             21        11.0             94         7.9            260
#> 98            158         9.6            152        10.3             63
#> 99            121         7.6            250         9.2            125
#> 100           188         9.8            146        12.1             12
#> 101           142         9.6            158         7.5            284
#> 102           214        12.4             38         8.6            202
#> 103           291         7.0            280        10.9             34
#> 104           181         7.4            258         7.7            274
#> 105           195         8.4            208         7.3            299
#> 106           111        10.2            128         8.6            204
#> 107           194         8.1            227         7.5            286
#> 108           160         5.1            338         9.1            144
#> 109           257         6.3            307         9.5            103
#> 110           240        10.5            118         8.0            254
#> 111           144        10.7            106         7.9            261
#> 112           102        13.4             23         9.7             96
#> 113           268         9.0            181         8.9            160
#> 114           154        13.4             22         8.8            178
#> 115           220         7.6            247        10.3             60
#> 116           274         4.8            345         8.7            189
#> 117           298        12.4             36        11.1             29
#> 118           149         5.7            328         8.7            190
#> 119           206         9.4            163         8.2            227
#> 120           215         8.0            232         9.1            145
#> 121           289        10.5            114         7.3            301
#> 122           148        10.0            137         7.3            297
#> 123           157         7.7            241        10.4             56
#> 124           151        10.3            124         9.9             80
#> 125           230         6.8            288         9.0            149
#> 126           130         8.7            194         8.2            234
#> 127           333         6.6            296         9.0            158
#> 128            62         7.7            242         9.5            107
#> 129           138         8.9            185         7.3            296
#> 130           318         5.1            339         9.2            135
#> 131           266         8.9            186         7.2            307
#> 132           141        14.6             11        11.6             19
#> 133           349        11.6             62         7.1            310
#> 134           312         5.8            327         6.2            343
#> 135           152         6.0            318         9.6            100
#> 136           254         6.6            294         7.1            314
#> 137           187        16.3              4        13.3              1
#> 138            69        10.9            102         9.5            109
#> 139           303         8.0            228         7.0            321
#> 140           246        10.0            141        10.7             42
#> 141            35         5.9            324         7.2            308
#> 142           241        11.1             90        10.2             68
#> 143           272        13.4             24         6.5            338
#> 144            20        14.3             15         8.6            199
#> 145           249        10.6            111         8.7            182
#> 146           281         8.2            216         8.2            235
#> 147           209         6.4            304         6.1            344
#> 148           273         8.0            229         7.8            266
#> 149            85         8.4            209         7.1            315
#> 150           110        11.4             68         9.2            138
#> 151            37         7.1            274         9.0            155
#> 152           256         8.7            196         7.9            257
#> 153             8         7.2            270         9.0            157
#> 154            33        11.2             76         8.8            180
#> 155            83         6.3            305         9.6            101
#> 156            57         8.8            192        11.3             24
#> 157            45         4.6            348         6.3            341
#> 158           146         6.3            308         9.0            159
#> 159           304         5.2            335         5.8            349
#> 160            99         6.0            319         8.9            171
#> 161           208        11.5             66         9.8             82
#> 162            26         8.3            213         8.6            201
#> 163           310         7.7            243         7.9            262
#> 164            77        15.4              7        11.2             25
#> 165           313         7.3            268        10.3             59
#> 166            74         8.1            222         9.0            152
#> 167           250         9.3            169        10.3             64
#> 168            16        14.5             12         9.4            117
#> 169           184        10.5            116         9.2            126
#> 170           196         6.9            285         7.0            323
#> 171           301        11.9             49         8.7            188
#> 172           155         6.8            290         8.7            186
#> 173           296         9.7            148         8.8            179
#> 174           221         6.5            301         7.6            275
#> 175           244        11.2             77        11.8             16
#> 176            17        10.3            126         9.3            119
#> 177           107         7.9            234         6.3            340
#> 178           316         9.3            168         8.6            197
#> 179            46         6.8            289         8.0            253
#> 180           294         6.5            302         8.9            166
#> 181           186        11.7             54         9.0            153
#> 182            60        13.8             19         9.2            127
#> 183           177         8.9            184         9.5            104
#> 184           231         8.4            203         8.1            246
#> 185           328         7.0            279         8.8            177
#> 186            27        10.1            133        12.2              6
#> 187           352         6.2            311        12.2              7
#> 188           321         7.9            233        10.5             52
#> 189           275        11.3             72         8.9            165
#> 190           108         7.4            259        10.0             75
#> 191            87         7.0            281         7.8            264
#> 192            31         9.3            170         9.2            136
#> 193           198        11.6             60         6.6            336
#> 194           308         9.8            145         9.3            122
#> 195            25        11.9             45         8.0            248
#> 196            75         8.3            215         9.2            128
#> 197           129        10.9            100         8.0            250
#> 198           179         7.5            252         8.1            241
#> 199           235        12.1             42        10.4             55
#> 200           345         6.2            312         7.7            270
#> 201           140         9.4            162         6.9            326
#> 202            61         7.5            254         9.3            124
#> 203           167        11.1             83        11.7             17
#> 204           104         7.0            278         8.1            242
#> 205           322         9.2            173         9.0            150
#> 206            71        11.3             73        10.5             51
#> 207           305         7.1            273         9.7             91
#> 208            65        10.0            136         8.3            224
#> 209            90         9.6            151         8.5            205
#> 210           229         9.1            176         7.0            316
#> 211           309         6.6            297         9.1            141
#> 212           237         7.3            264        10.3             62
#> 213           165        10.0            138         9.7             95
#> 214            44         6.6            293         7.5            285
#> 215           164         9.6            153         8.5            208
#> 216           326        10.8            104         7.4            287
#> 217           232        10.5            113         9.3            120
#> 218            78        10.1            129         9.7             90
#> 219           236         9.6            157         8.0            255
#> 220           340         9.9            142         8.0            249
#> 221            29         7.7            244        11.6             20
#> 222           334         4.7            347         9.8             83
#> 223           182        11.2             75        10.5             49
#> 224            93        11.0             93        10.9             35
#> 225           163        10.5            115        10.9             36
#> 226           284         8.7            193         9.6             98
#> 227            70         9.6            155        11.5             21
#> 228           147        11.7             53         9.0            156
#> 229           267        16.8              2        12.1             11
#> 230           131        12.4             37         7.8            265
#> 231           161         7.0            282         7.4            288
#> 232           263        12.7             30        10.2             66
#> 233           180         8.9            183        11.0             31
#> 234           347         9.4            166        11.0             30
#> 235           247         6.0            317         8.6            200
#> 236           123        10.6            110         8.0            251
#> 237           233        11.1             85        10.0             76
#> 238           224         8.6            198        10.7             41
#> 239            28         4.5            351        10.2             65
#> 240           319         8.8            190         8.7            183
#> 241           113         9.5            159         8.7            192
#> 242           185         8.5            201         9.9             77
#> 243            43         6.2            310        12.1             13
#> 244            23         8.4            204         9.0            151
#> 245             6         5.0            342         5.8            347
#> 246           205         8.4            207         8.0            247
#> 247           248        11.1             87         8.0            256
#> 248           297        13.7             20         9.8             86
#> 249           223        10.7            109         7.6            280
#> 250            10        15.4              6         8.8            174
#> 251            66        14.4             14         9.9             79
#> 252           217         9.6            156         7.2            302
#> 253           329         9.6            154         7.0            317
#> 254            47         6.5            300         9.2            129
#> 255           100         7.7            245         7.4            290
#> 256           268         7.2            272         9.6             99
#> 257           288        11.3             71        10.6             43
#> 258            32        12.6             32         8.8            181
#> 259            86         7.7            240         9.6             97
#> 260           283         7.5            253         9.4            111
#> 261           120         5.3            334         5.8            348
#> 262           210        11.0             96        10.7             39
#> 263           193        10.1            134         9.4            113
#> 264           315         7.5            255         7.6            277
#> 265           295         7.8            237         9.4            118
#> 266           325        17.7              1         8.2            231
#> 267           170         5.0            341         6.7            334
#> 268           332        11.2             80         9.8             88
#> 269            53         5.9            325         7.0            318
#> 270           199         9.7            150         9.2            131
#> 271            73         8.3            211         9.4            112
#> 272            15         8.3            214         7.2            305
#> 273            95         4.6            349        12.2             10
#> 274           117         7.3            265         8.3            221
#> 275           207         7.4            262         8.4            218
#> 276           337        11.0             95         7.3            298
#> 277           342         8.7            197         8.7            185
#> 278            50        12.1             41        11.0             32
#> 279           285        10.1            130         8.2            233
#> 280           168         8.6            199         9.1            143
#> 281           137        11.0             98        10.5             47
#> 282           128        12.7             31         8.2            230
#> 283             4         6.7            291        10.5             50
#> 284           189         8.5            202         8.9            169
#> 285           260         8.1            225         8.7            193
#> 286            22        14.9              9         8.8            175
#> 287           174         8.3            210         6.9            324
#> 288           243        10.4            121        11.1             28
#> 289           286         7.7            239        11.9             15
#> 290            84        11.8             50        12.2              9
#> 291            14         7.8            236         6.7            330
#> 292            52         9.1            175         6.6            335
#> 293            56         4.5            352         8.4            216
#> 294           335         9.1            174         7.4            292
#> 295            51         8.0            231         8.9            164
#> 296           323         5.7            329         7.9            259
#> 297            40        10.7            107         8.3            222
#> 298           261         9.1            179         9.8             84
#> 299            13         8.7            195         8.2            236
#> 300            88        10.1            135         7.1            309
#> 301           350        10.3            125        11.2             27
#> 302           250         9.4            167         8.5            207
#> 303            90         6.9            287         7.6            279
#> 304           175        11.7             58         8.2            238
#> 305             1         4.7            346        10.7             40
#> 306           191         8.9            187         7.9            263
#> 307           213         8.6            200        11.5             23
#> 308            82         8.1            224        12.9              3
#> 309           221        11.1             84         8.2            237
#> 310           105         9.8            144         9.7             93
#> 311             2        12.1             44         9.3            121
#> 312            18        11.3             70         9.5            110
#> 313           259         9.3            172         6.4            339
#> 314           169        13.1             25         8.9            163
#> 315           233        10.4            120         7.0            322
#> 316            12         8.3            212         7.5            283
#> 317           331        11.1             82         7.2            303
#> 318           292        11.7             55        10.1             72
#> 319            96        10.3            122         6.8            329
#> 320           327        10.1            132         9.4            115
#> 321            90         5.5            333         7.8            267
#> 322           134         7.6            249         9.1            142
#> 323           324         7.8            235         6.7            332
#> 324           176         8.1            223         8.9            162
#> 325           211        10.6            112        10.7             38
#> 326            63         8.4            206         8.2            229
#> 327           112        16.4              3        12.4              5
#> 328           109         7.2            269         7.0            320
#> 329            68        12.8             29         9.7             94
#> 330            76        14.4             13        10.1             70
#> 331           115         6.4            303         6.2            342
#> 332            80        12.2             40        11.5             22
#> 333            98         8.2            218         8.9            167
#> 334           106         5.7            330         8.2            239
#> 335           270        11.9             46        10.6             46
#> 336           118         6.0            323         8.6            198
#> 337           132         9.4            165         8.2            232
#> 338           287         5.9            326         8.5            210
#> 339           218        11.9             48         8.8            176
#> 340            59        13.0             27        10.4             54
#> 341           197        11.5             63         9.8             87
#> 342           250         6.0            321         8.9            173
#> 343           178        10.0            139         8.9            170
#> 344           124        11.1             91         9.8             89
#> 345           162        10.9            101        12.4              4
#> 346           242         8.0            230         9.8             81
#> 347           253         6.1            315         8.9            161
#> 348           116         9.5            161         7.1            311
#> 349           119        10.0            140        10.2             67
#> 350            97        11.1             89         8.5            206
#> 351           277        11.4             67        10.3             58
#> 352            88         7.0            277         8.6            194
#> 353           135        11.6             59         9.5            105
#>     Def.NonStl.Pct Def.NonStl.Pct.Rk Def.A.Pct Def.A.Pct.Rk Def.FG_3A.Pct
#> 1              8.1               321      57.0          307          42.5
#> 2             10.5                97      48.4           78          39.9
#> 3              7.3               343      48.8           87          48.1
#> 4             10.3               110      53.2          211          35.3
#> 5              9.6               168      52.3          189          38.5
#> 6              9.1               239      48.7           85          39.4
#> 7              8.8               256      51.8          172          40.9
#> 8              8.3               308      43.4           19          42.5
#> 9             11.2                43      56.5          299          49.9
#> 10             9.2               220      48.0           73          43.2
#> 11             8.2               315      54.9          263          47.4
#> 12             9.7               165      51.0          148          35.6
#> 13             9.2               218      53.4          216          37.0
#> 14             8.5               289      51.5          161          35.9
#> 15             8.2               311      44.8           31          35.9
#> 16             7.2               347      46.2           52          37.4
#> 17             9.6               175      55.0          264          38.7
#> 18             7.5               340      45.3           38          35.9
#> 19             9.5               183      50.6          131          39.6
#> 20             9.4               195      51.8          170          41.0
#> 21            11.5                23      52.2          185          43.5
#> 22            10.0               129      58.8          324          45.7
#> 23             8.2               318      41.0            5          34.9
#> 24             9.1               232      50.6          128          45.1
#> 25             9.5               184      49.9          115          41.6
#> 26            11.4                27      55.2          268          39.2
#> 27             8.6               276      54.3          251          35.6
#> 28             9.0               242      55.6          279          36.7
#> 29             9.6               172      51.1          150          39.1
#> 30             8.2               319      51.8          173          38.3
#> 31             7.4               342      51.9          175          37.2
#> 32             7.2               349      43.1           13          31.6
#> 33             9.4               201      53.9          231          44.9
#> 34             7.8               329      50.6          129          36.6
#> 35             8.2               312      45.4           39          36.9
#> 36             9.9               138      45.0           32          36.1
#> 37            11.3                38      48.7           82          33.1
#> 38             9.8               145      53.8          229          44.7
#> 39             7.8               332      58.3          318          43.6
#> 40            11.1                53      52.0          179          37.5
#> 41            10.4               101      48.8           90          38.0
#> 42            11.2                47      54.2          245          39.1
#> 43             9.1               230      51.0          146          39.6
#> 44             9.5               187      53.4          219          43.2
#> 45             8.0               322      53.8          227          44.0
#> 46             9.2               226      55.1          266          42.3
#> 47             7.6               336      47.7           67          39.2
#> 48            10.7                78      53.2          209          39.4
#> 49            11.4                30      54.1          238          36.8
#> 50             9.4               191      56.7          303          33.8
#> 51            12.6                 5      57.5          311          42.4
#> 52             9.4               192      53.6          223          44.9
#> 53             7.8               330      47.8           68          36.4
#> 54             7.3               344      44.4           25          34.5
#> 55             9.2               223      42.9           11          35.6
#> 56             9.9               135      57.4          310          41.5
#> 57            12.6                 4      53.6          225          39.2
#> 58            11.2                42      45.9           50          37.0
#> 59             8.8               263      46.8           59          38.4
#> 60             9.9               141      41.3            6          33.3
#> 61            10.5                95      51.3          155          38.5
#> 62             7.7               333      45.6           44          35.5
#> 63             9.6               171      51.3          153          40.2
#> 64            10.0               131      49.1           95          39.5
#> 65             7.3               345      53.4          218          35.6
#> 66             9.5               177      55.1          265          42.0
#> 67            11.7                19      50.3          125          39.8
#> 68             9.2               227      55.5          277          39.8
#> 69            12.0                13      49.5          100          40.3
#> 70            10.0               126      56.3          296          45.5
#> 71             9.5               178      53.5          222          38.4
#> 72             7.4               341      48.5           79          37.8
#> 73             9.8               148      57.8          314          41.2
#> 74             7.9               324      57.4          309          39.0
#> 75            11.1                50      50.9          140          37.2
#> 76             9.7               166      53.2          210          41.7
#> 77             8.4               295      41.4            7          34.9
#> 78            11.1                49      50.1          121          40.7
#> 79            10.9                64      56.2          294          47.8
#> 80             9.7               160      47.6           66          35.3
#> 81             8.5               292      49.9          116          39.2
#> 82             8.9               253      52.1          183          43.4
#> 83             9.8               152      56.7          302          40.6
#> 84             9.1               236      54.2          247          43.8
#> 85             9.2               219      54.1          242          34.7
#> 86             7.7               334      53.1          206          37.1
#> 87             9.4               200      49.2           97          38.5
#> 88             7.9               327      52.2          184          36.1
#> 89             9.0               245      55.8          285          49.8
#> 90             9.7               162      42.4           10          32.7
#> 91             9.9               133      51.6          162          39.0
#> 92             7.8               328      46.1           51          38.9
#> 93            11.1                51      46.7           57          37.7
#> 94            10.5                96      50.8          137          37.3
#> 95            10.1               124      52.0          177          40.7
#> 96             8.4               299      43.3           17          33.4
#> 97             9.3               206      45.5           43          35.0
#> 98            10.3               117      55.3          272          34.5
#> 99             8.6               281      46.8           58          43.3
#> 100            9.1               235      54.2          244          42.2
#> 101            9.2               211      41.9            8          36.3
#> 102            8.8               262      50.8          138          39.8
#> 103            8.9               254      67.8          351          41.0
#> 104            9.0               243      55.5          278          43.8
#> 105            8.7               275      45.8           46          33.8
#> 106           10.2               119      54.1          239          41.9
#> 107           12.0                12      54.3          250          43.3
#> 108           10.1               122      48.9           91          43.5
#> 109            9.8               146      51.7          164          36.4
#> 110            8.3               307      54.1          241          40.6
#> 111            7.2               350      60.5          338          41.4
#> 112            8.5               286      49.9          114          41.1
#> 113            8.3               309      43.3           16          33.4
#> 114            9.1               229      47.9           71          38.6
#> 115            8.6               283      47.2           62          40.9
#> 116            8.2               310      51.9          174          39.9
#> 117           11.0                58      56.4          297          43.4
#> 118           10.3               113      49.7          105          39.4
#> 119            9.8               154      56.2          295          40.2
#> 120            7.9               325      50.9          143          39.1
#> 121            9.2               215      50.9          142          37.6
#> 122            8.5               290      45.2           36          32.8
#> 123           10.5                91      50.9          144          36.0
#> 124           11.7                20      52.1          182          34.3
#> 125            7.0               351      53.0          204          41.0
#> 126            9.9               139      56.1          292          39.7
#> 127            9.5               182      52.5          193          40.5
#> 128            9.1               237      55.4          276          42.4
#> 129            9.3               205      49.8          111          34.6
#> 130           10.5                90      53.9          232          39.1
#> 131            7.8               331      52.1          181          39.2
#> 132            9.3               210      55.1          267          45.4
#> 133            8.4               296      48.1           74          36.3
#> 134            8.4               301      48.7           84          43.0
#> 135           11.8                16      51.5          160          35.6
#> 136           11.1                48      48.9           92          37.7
#> 137           10.9                63      58.6          321          35.3
#> 138            8.7               274      52.7          198          41.8
#> 139            9.8               144      59.9          336          34.8
#> 140            9.8               149      55.3          271          41.8
#> 141           10.3               115      45.4           40          34.4
#> 142            9.2               228      45.4           41          35.8
#> 143            7.5               339      51.9          176          39.4
#> 144            9.9               137      52.9          203          40.5
#> 145            8.8               258      53.2          212          37.7
#> 146            9.3               204      44.4           26          32.3
#> 147            9.0               246      44.0           22          30.7
#> 148           10.8                68      45.0           35          31.2
#> 149            9.5               180      46.2           53          35.5
#> 150            9.8               151      48.0           72          35.8
#> 151            9.0               247      50.1          117          37.2
#> 152            8.7               273      51.5          159          39.5
#> 153            9.6               173      56.8          306          39.1
#> 154           10.4               103      51.7          165          39.9
#> 155            9.4               193      40.5            3          32.5
#> 156            7.2               348      48.1           75          38.1
#> 157            8.4               302      47.6           64          34.3
#> 158            7.6               335      54.0          235          43.6
#> 159            9.5               189      52.6          196          40.2
#> 160           11.3                41      44.6           30          38.3
#> 161            8.8               259      59.8          332          36.0
#> 162            8.7               272      49.8          108          41.3
#> 163            9.5               188      56.7          304          40.4
#> 164           11.3                39      54.1          240          42.0
#> 165           11.4                31      53.2          213          35.4
#> 166            9.2               224      55.9          287          34.1
#> 167           10.8                73      56.0          289          42.3
#> 168           11.5                25      50.7          132          42.8
#> 169            9.6               176      48.8           89          39.4
#> 170           10.4               102      46.2           54          33.8
#> 171           11.3                37      52.9          201          33.7
#> 172            9.4               199      48.6           81          39.2
#> 173            9.0               248      52.2          187          43.2
#> 174           10.2               120      47.5           63          36.8
#> 175            9.0               241      44.4           27          35.3
#> 176            8.6               277      45.8           47          30.1
#> 177            9.8               153      47.9           70          37.2
#> 178            7.5               337      51.3          154          37.7
#> 179            9.1               231      44.5           28          31.2
#> 180            9.3               208      52.9          200          40.0
#> 181            9.5               181      48.7           83          32.7
#> 182            9.4               202      55.6          280          38.2
#> 183           11.2                45      54.6          255          36.9
#> 184            8.2               316      51.3          156          40.0
#> 185            9.4               198      50.1          120          37.4
#> 186           10.5                87      57.7          313          43.4
#> 187            8.3               306      56.0          291          35.5
#> 188           11.8                18      49.7          104          38.3
#> 189            8.5               285      62.2          345          41.1
#> 190            9.3               209      59.6          328          41.8
#> 191            9.7               155      55.7          284          44.0
#> 192           10.6                84      55.9          286          33.2
#> 193           10.3               112      43.1           14          32.7
#> 194           10.8                75      45.9           48          35.7
#> 195            8.7               271      61.8          343          38.7
#> 196            8.8               264      43.5           20          35.9
#> 197            8.9               250      55.4          275          29.0
#> 198           10.8                72      38.6            1          39.6
#> 199           11.4                32      52.5          194          36.8
#> 200            9.7               157      45.5           42          36.0
#> 201            8.4               303      53.7          226          45.3
#> 202           10.8                70      53.1          207          46.6
#> 203           10.5                94      47.0           60          38.2
#> 204           10.8                69      49.1           94          35.7
#> 205           10.5                92      50.3          126          41.9
#> 206           10.5                93      49.7          106          41.2
#> 207            9.3               203      51.4          157          42.9
#> 208           10.9                61      54.8          261          39.2
#> 209            9.1               233      49.4           99          34.1
#> 210            9.8               142      49.6          103          38.2
#> 211           11.8                17      46.5           56          35.3
#> 212            9.5               185      60.3          337          37.6
#> 213           10.7                82      40.3            2          35.9
#> 214           12.9                 3      47.8           69          36.9
#> 215           10.4                98      54.2          248          43.5
#> 216           10.3               116      50.7          135          36.6
#> 217            9.9               140      59.7          331          36.3
#> 218            9.2               217      50.9          141          37.4
#> 219            8.9               252      59.8          334          48.8
#> 220           11.2                46      45.0           33          31.1
#> 221           11.2                44      54.5          253          42.9
#> 222           10.4               105      53.8          228          33.7
#> 223            8.8               266      48.8           88          34.2
#> 224           11.5                24      48.3           77          38.1
#> 225           11.6                21      53.6          224          33.8
#> 226           10.1               123      53.4          217          39.4
#> 227           10.3               107      57.6          312          36.8
#> 228           12.6                 6      65.2          348          44.5
#> 229           11.0                60      67.8          352          48.1
#> 230            9.2               222      49.5          101          38.4
#> 231            9.3               207      51.7          168          40.5
#> 232           10.1               125      43.8           21          38.8
#> 233           12.5                 8      59.7          330          41.8
#> 234           10.4               104      55.2          270          38.4
#> 235           10.7                77      43.2           15          35.2
#> 236            8.2               314      55.7          282          42.2
#> 237           11.3                40      58.8          323          40.6
#> 238            9.1               234      53.0          205          33.2
#> 239           13.7                 2      54.1          242          36.8
#> 240            8.9               251      51.1          152          36.6
#> 241           10.4               100      61.4          341          37.1
#> 242            9.7               159      53.4          215          39.3
#> 243            8.6               284      50.1          118          38.3
#> 244            9.2               213      49.8          107          39.1
#> 245            9.6               169      59.7          329          47.9
#> 246            9.4               194      44.3           24          34.6
#> 247            8.4               300      61.4          342          39.3
#> 248           10.0               132      44.5           29          39.6
#> 249           10.6                86      59.8          333          45.2
#> 250           11.0                57      51.5          158          43.0
#> 251            8.6               279      52.0          180          40.8
#> 252           10.9                65      55.9          288          40.5
#> 253            8.2               317      59.9          335          46.0
#> 254           11.9                14      51.6          163          37.5
#> 255           10.7                80      50.1          122          40.6
#> 256           10.7                83      45.9           49          35.0
#> 257            9.5               179      51.0          145          37.4
#> 258            9.8               143      52.0          177          42.0
#> 259           12.5                 9      50.7          134          35.6
#> 260            8.4               294      55.2          269          44.7
#> 261           11.1                52      42.0            9          38.4
#> 262            7.0               352      50.2          123          30.4
#> 263           10.5                88      48.9           93          38.7
#> 264           11.0                55      54.8          259          38.1
#> 265           11.3                36      48.2           76          39.6
#> 266           10.5                89      53.4          220          40.5
#> 267           13.8                 1      50.6          130          39.6
#> 268           10.0               127      53.1          208          40.2
#> 269           10.8                76      54.7          258          46.5
#> 270           11.3                35      48.6           80          37.3
#> 271           10.3               114      56.0          290          35.4
#> 272           10.2               121      43.1           12          37.5
#> 273           12.5                 7      51.7          166          36.0
#> 274            8.3               304      49.3           98          40.9
#> 275            9.1               240      52.8          199          40.9
#> 276            9.8               150      50.8          139          36.3
#> 277           11.4                29      58.4          320          40.4
#> 278           10.6                85      55.4          274          34.6
#> 279            7.5               338      59.2          326          44.1
#> 280            8.7               268      45.6           45          34.7
#> 281           10.8                74      58.1          317          39.4
#> 282            7.3               346      45.3           37          35.8
#> 283            9.4               197      55.7          281          35.4
#> 284           12.3                10      54.1          236          36.0
#> 285            9.6               174      52.3          188          36.7
#> 286            8.8               265      52.2          186          37.4
#> 287            8.6               278      53.9          230          33.2
#> 288            8.5               287      49.9          112          33.3
#> 289            9.6               167      51.0          147          34.4
#> 290            7.9               326      45.0           33          40.0
#> 291           12.3                11      49.5          102          37.0
#> 292            8.5               293      51.8          171          38.7
#> 293           10.3               108      52.3          190          40.3
#> 294            9.2               212      54.2          246          40.5
#> 295           10.9                66      49.8          109          37.1
#> 296            8.7               267      62.0          344          42.9
#> 297            8.9               255      40.9            4          27.3
#> 298            8.4               298      66.8          350          44.7
#> 299           10.9                67      44.2           23          38.0
#> 300            9.7               158      50.8          136          33.9
#> 301           10.4                99      65.8          349          42.4
#> 302           10.0               130      50.3          124          36.2
#> 303            9.9               136      52.4          192          34.1
#> 304            8.2               313      49.1           96          36.7
#> 305           10.2               118      53.5          221          38.4
#> 306            9.2               214      56.4          298          37.1
#> 307           11.5                22      53.9          233          49.3
#> 308           11.4                33      58.0          316          34.7
#> 309            9.7               161      56.5          300          32.0
#> 310            8.5               291      61.4          340          37.0
#> 311            8.8               260      54.6          256          38.2
#> 312            7.9               323      51.1          151          38.1
#> 313           11.4                28      54.4          252          38.6
#> 314            9.2               221      46.4           55          34.7
#> 315            9.4               196      47.2           61          35.6
#> 316            9.6               170      54.7          257          40.2
#> 317           10.7                81      52.6          197          42.3
#> 318           10.4               106      48.7           86          41.4
#> 319           10.8                71      49.8          110          37.3
#> 320           10.7                79      55.7          283          40.7
#> 321            9.7               156      54.1          237          37.2
#> 322            8.8               257      57.0          308          41.0
#> 323           11.0                54      56.8          305          41.0
#> 324           10.0               128      50.1          119          34.9
#> 325            8.4               297      64.8          347          48.1
#> 326            8.6               282      47.6           65          32.1
#> 327            7.0               353      49.9          113          34.9
#> 328            9.1               238      56.6          301          40.3
#> 329            8.8               261      58.3          319          42.8
#> 330            8.6               280      61.1          339          37.7
#> 331            9.0               249      50.3          127          38.2
#> 332           11.9                15      50.7          133          33.2
#> 333            9.2               225      51.7          167          37.9
#> 334            8.5               288      56.1          293          43.8
#> 335            8.7               270      54.8          260          37.6
#> 336           10.3               111      54.0          234          37.3
#> 337            8.1               320      52.3          191          47.3
#> 338            8.7               269      43.4           18          36.3
#> 339           11.0                59      54.6          254          41.1
#> 340            9.7               164      69.1          353          41.2
#> 341            9.0               244      53.3          214          36.0
#> 342            8.3               305      52.9          202          37.0
#> 343            9.5               186      51.7          169          39.5
#> 344           11.4                26      58.8          322          51.4
#> 345           10.9                62      51.1          149          35.7
#> 346            9.5               190      62.4          346          40.5
#> 347            9.9               134      58.9          325          39.5
#> 348            9.7               163      55.3          273          40.1
#> 349            9.2               216      54.3          249          37.1
#> 350           11.0                56      57.8          315          37.3
#> 351            9.8               147      52.6          195          37.7
#> 352           10.3               109      59.2          327          44.0
#> 353           11.4                34      54.9          262          36.6
#>     Def.FG_3A.Pct.Rk  AdjD AdjD.Rk
#> 1                298 109.7     272
#> 2                229  97.4      56
#> 3                348 105.3     183
#> 4                 63 104.4     165
#> 5                180 110.7     295
#> 6                211 109.6     271
#> 7                261 105.9     201
#> 8                299  89.2       5
#> 9                352  94.0      20
#> 10               308 110.4     289
#> 11               343 102.2     127
#> 12                76  96.7      45
#> 13               119 109.0     262
#> 14                86 102.3     131
#> 15                83 112.9     323
#> 16               140 108.5     256
#> 17               185 101.5     118
#> 18                87 103.4     151
#> 19               223 110.9     297
#> 20               265  99.0      77
#> 21               315  95.9      36
#> 22               338 102.8     143
#> 23                53  98.5      69
#> 24               333 104.4     164
#> 25               279 110.7     293
#> 26               198 105.6     194
#> 27                72 113.4     331
#> 28               108 109.6     268
#> 29               197  99.3      83
#> 30               170 113.2     328
#> 31               131  90.2       9
#> 32                 9  97.4      55
#> 33               331 107.8     245
#> 34               104  97.6      61
#> 35               117 111.7     310
#> 36                94 103.9     155
#> 37                18 102.0     121
#> 38               329 115.4     346
#> 39               318 118.9     352
#> 40               146 106.8     226
#> 41               158  97.2      49
#> 42               195 107.2     229
#> 43               220 102.8     140
#> 44               307  95.6      34
#> 45               324 104.7     170
#> 46               293 101.3     110
#> 47               200 109.0     260
#> 48               213 101.4     113
#> 49               115 107.7     241
#> 50                30 111.6     308
#> 51               297 105.7     196
#> 52               332 105.7     197
#> 53               103 108.9     257
#> 54                42 101.5     117
#> 55                71 106.1     206
#> 56               278 106.1     207
#> 57               199 113.9     334
#> 58               121  99.6      87
#> 59               177 111.2     303
#> 60                24 102.8     142
#> 61               179 100.0      97
#> 62                68 110.6     292
#> 63               239  96.5      42
#> 64               217 107.8     244
#> 65                74 111.1     302
#> 66               287 110.0     281
#> 67               225  98.6      71
#> 68               227 111.6     309
#> 69               240  84.1       1
#> 70               337 105.3     185
#> 71               175  95.6      33
#> 72               156 102.8     141
#> 73               272 101.3     111
#> 74               191 114.2     336
#> 75               132 103.3     148
#> 76               280 110.2     284
#> 77                52  91.6      12
#> 78               257  97.2      51
#> 79               344 109.8     277
#> 80                59 109.7     275
#> 81               203  96.8      47
#> 82               312 113.0     325
#> 83               255 112.0     312
#> 84               320  92.0      15
#> 85                50 103.9     154
#> 86               125 118.4     350
#> 87               181 100.4      99
#> 88                95 112.5     318
#> 89               351 107.3     233
#> 90                14 106.3     212
#> 91               190 102.3     130
#> 92               189  97.4      57
#> 93               152  99.6      88
#> 94               138 115.3     345
#> 95               256 101.4     115
#> 96                26  98.2      65
#> 97                57  88.5       4
#> 98                43  99.2      80
#> 99               311 102.3     132
#> 100              290 101.0     106
#> 101               99 102.8     139
#> 102              226  97.2      52
#> 103              266 112.6     320
#> 104              322 100.4      98
#> 105               31 108.1     250
#> 106              286  99.0      78
#> 107              310 105.0     180
#> 108              316 104.6     166
#> 109              102 105.4     188
#> 110              254 102.5     133
#> 111              277 102.7     137
#> 112              271  91.2      11
#> 113               25 102.1     125
#> 114              183  90.1       8
#> 115              260 106.5     218
#> 116              230 112.7     321
#> 117              313 108.0     248
#> 118              208 102.1     123
#> 119              237 111.4     304
#> 120              194 113.5     332
#> 121              147 111.0     301
#> 122               17 106.7     222
#> 123               88 107.6     239
#> 124               39  98.1      62
#> 125              267 109.0     261
#> 126              224  99.2      81
#> 127              249 104.2     161
#> 128              296 109.7     276
#> 129               46 103.9     156
#> 130              192 120.6     353
#> 131              202 110.7     294
#> 132              336  91.7      13
#> 133               98 108.4     255
#> 134              305 114.7     339
#> 135               75 107.5     235
#> 136              155 102.7     136
#> 137               60  93.5      18
#> 138              284  92.3      17
#> 139               51 109.2     265
#> 140              281 110.3     286
#> 141               41 106.8     225
#> 142               80  98.6      73
#> 143              207  94.1      21
#> 144              251  96.0      38
#> 145              153 103.5     152
#> 146               12  98.3      67
#> 147                5 108.9     258
#> 148                8 104.9     178
#> 149               69 106.1     208
#> 150               82  94.4      26
#> 151              130 103.3     149
#> 152              214 107.6     240
#> 153              196 108.3     253
#> 154              228  95.9      35
#> 155               13  99.9      94
#> 156              160 110.3     287
#> 157               38 113.2     327
#> 158              319 112.6     319
#> 159              238 111.4     306
#> 160              171 102.0     122
#> 161               91  95.2      29
#> 162              275  94.1      23
#> 163              244 108.9     259
#> 164              289  97.2      53
#> 165               64 101.1     108
#> 166               34 105.9     202
#> 167              294 101.0     105
#> 168              300  94.8      28
#> 169              212 106.5     219
#> 170               32 109.7     274
#> 171               27 102.2     129
#> 172              204 104.3     163
#> 173              309 106.7     223
#> 174              113 112.4     317
#> 175               61 106.3     213
#> 176                3  86.2       2
#> 177              129  94.4      24
#> 178              151 112.3     316
#> 179                7 104.9     177
#> 180              232 110.4     288
#> 181               16 106.5     217
#> 182              166  98.8      75
#> 183              116 108.1     249
#> 184              233 108.2     251
#> 185              143  94.4      25
#> 186              314 105.9     203
#> 187               67 110.5     291
#> 188              169 104.9     176
#> 189              270 106.7     221
#> 190              283 115.3     344
#> 191              323 100.4     100
#> 192               22 109.7     273
#> 193               15  97.5      58
#> 194               79 107.9     246
#> 195              184 112.9     322
#> 196               84 109.1     263
#> 197                2 104.8     173
#> 198              218  99.3      84
#> 199              114 104.0     158
#> 200               92 106.2     209
#> 201              335 109.6     269
#> 202              341 106.5     220
#> 203              164  98.8      74
#> 204               77 106.3     214
#> 205              285 109.8     278
#> 206              274  98.4      68
#> 207              304 103.7     153
#> 208              201 102.1     126
#> 209               35 106.4     215
#> 210              168 105.8     199
#> 211               62 105.5     192
#> 212              149 107.9     247
#> 213               85  95.4      31
#> 214              118  98.2      63
#> 215              317  98.2      64
#> 216              106 110.0     280
#> 217              101 104.7     171
#> 218              139 107.5     236
#> 219              349 114.5     337
#> 220                6 105.6     195
#> 221              303  88.4       3
#> 222               28 112.9     324
#> 223               37  99.1      79
#> 224              161  92.2      16
#> 225               29 105.1     181
#> 226              209 100.8     104
#> 227              112  95.9      37
#> 228              327 108.4     254
#> 229              347  95.3      30
#> 230              174 110.4     290
#> 231              248 100.8     103
#> 232              188  90.4      10
#> 233              282 104.8     172
#> 234              173 106.0     205
#> 235               58 102.1     124
#> 236              291 100.5     102
#> 237              253  98.5      70
#> 238               21 105.4     189
#> 239              111 110.7     296
#> 240              106 104.3     162
#> 241              126 104.7     168
#> 242              205 105.8     200
#> 243              172  99.5      85
#> 244              193 104.0     157
#> 245              345 114.0     335
#> 246               44 104.9     179
#> 247              206 110.2     283
#> 248              221  91.8      14
#> 249              334 112.1     313
#> 250              306  97.2      50
#> 251              259  99.9      92
#> 252              247 104.8     175
#> 253              339 110.9     298
#> 254              144 104.1     159
#> 255              252  99.9      91
#> 256               56 109.6     270
#> 257              142  96.3      41
#> 258              288  99.9      95
#> 259               70 112.1     315
#> 260              328 105.4     187
#> 261              176 107.5     237
#> 262                4 105.2     182
#> 263              186 102.2     128
#> 264              163 115.1     343
#> 265              222  98.8      76
#> 266              246 108.3     252
#> 267              219 116.8     348
#> 268              236  97.5      60
#> 269              340 107.7     242
#> 270              135 111.5     307
#> 271               66 105.5     191
#> 272              145  96.1      39
#> 273               89 106.2     210
#> 274              262 103.2     146
#> 275              263 105.6     193
#> 276              100 110.2     285
#> 277              243 104.8     174
#> 278               45 105.5     190
#> 279              326 107.2     231
#> 280               47  98.6      72
#> 281              210  97.4      54
#> 282               81 102.0     120
#> 283               65 107.5     238
#> 284               93 110.9     300
#> 285              109 111.4     305
#> 286              141 103.4     150
#> 287               20 114.9     342
#> 288               23  94.5      27
#> 289               40 106.0     204
#> 290              231  97.5      59
#> 291              121 101.4     114
#> 292              187 107.3     232
#> 293              241 103.2     147
#> 294              250 102.7     138
#> 295              124  99.3      82
#> 296              302 107.2     230
#> 297                1  98.2      66
#> 298              330 117.0     349
#> 299              159  94.1      22
#> 300               33  97.0      48
#> 301              295  99.8      90
#> 302               96 102.7     135
#> 303               36 109.3     267
#> 304              110 101.1     107
#> 305              178 109.1     264
#> 306              127 110.9     299
#> 307              350 102.0     119
#> 308               48 101.1     109
#> 309               10  93.8      19
#> 310              120 113.4     330
#> 311              165  95.4      32
#> 312              162  96.8      46
#> 313              182 110.1     282
#> 314               49 106.5     216
#> 315               73 101.4     116
#> 316              235 106.2     211
#> 317              292 106.8     224
#> 318              276  99.6      86
#> 319              137  96.5      44
#> 320              258 107.7     243
#> 321              133 114.5     338
#> 322              268 113.3     329
#> 323              264 114.9     341
#> 324               54 103.1     145
#> 325              346 111.9     311
#> 326               11 102.5     134
#> 327               55  89.3       6
#> 328              242 105.3     186
#> 329              301  99.7      89
#> 330              154  96.5      43
#> 331              167 107.0     228
#> 332               19  89.5       7
#> 333              157  99.9      93
#> 334              321 118.6     351
#> 335              148  96.2      40
#> 336              134 113.1     326
#> 337              342 104.7     169
#> 338               97 100.0      96
#> 339              269 107.5     234
#> 340              273 103.0     144
#> 341               90 112.1     314
#> 342              123 105.3     184
#> 343              216 100.5     101
#> 344              353 104.1     160
#> 345               78 105.8     198
#> 346              245 116.1     347
#> 347              215 113.8     333
#> 348              234 109.3     266
#> 349              128 106.9     227
#> 350              136 110.0     279
#> 351              150 101.4     112
#> 352              325 114.8     340
#> 353              105 104.6     167
# }
```
