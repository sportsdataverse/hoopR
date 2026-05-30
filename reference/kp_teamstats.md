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
#>                        team conf off_fg_3_pct off_fg_3_pct_rk off_fg_2_pct
#> 1                    Lehigh  Pat         42.3               1         51.9
#> 2                   Wofford   SC         41.4               2         53.9
#> 3          South Dakota St.  Sum         41.2               3         56.2
#> 4             Grambling St. SWAC         40.2               4         45.5
#> 5       Fairleigh Dickinson  NEC         40.2               5         51.0
#> 6          Louisiana Monroe   SB         39.7               6         49.6
#> 7                   Colgate  Pat         39.5               7         53.5
#> 8                  Virginia  ACC         39.5               8         52.5
#> 9             Virginia Tech  ACC         39.4               9         52.9
#> 10           Nebraska Omaha  Sum         39.3              10         51.8
#> 11            Southern Miss CUSA         39.1              11         50.0
#> 12                Marquette   BE         38.8              12         50.0
#> 13                  Hofstra  CAA         38.7              13         54.5
#> 14              Utah Valley  WAC         38.4              14         54.2
#> 15                Lafayette  Pat         38.3              15         49.1
#> 16         Western Illinois  Sum         38.2              16         45.9
#> 17                      USC  P12         38.2              17         50.3
#> 18             Northeastern  CAA         38.2              18         55.8
#> 19                 Hartford   AE         38.2              19         51.5
#> 20               Fresno St.  MWC         38.2              20         51.9
#> 21                   Auburn  SEC         38.1              21         51.7
#> 22              Georgia St.   SB         38.1              22         51.2
#> 23                   Toledo  MAC         38.0              23         50.2
#> 24                  Radford BSth         38.0              24         50.1
#> 25             Presbyterian BSth         37.9              25         50.2
#> 26               Pepperdine  WCC         37.9              26         48.4
#> 27             UC Riverside   BW         37.9              27         47.2
#> 28                  Oakland Horz         37.9              28         52.2
#> 29                Creighton   BE         37.9              29         55.7
#> 30                 Delaware  CAA         37.8              30         50.9
#> 31             Michigan St.  B10         37.8              31         54.3
#> 32             Saint Mary's  WCC         37.8              32         52.3
#> 33             Gardner Webb BSth         37.7              33         53.6
#> 34          Mississippi St.  SEC         37.7              34         53.3
#> 35               Quinnipiac MAAC         37.7              35         48.5
#> 36                  Montana BSky         37.7              36         55.8
#> 37        Abilene Christian Slnd         37.7              37         49.5
#> 38              Montana St. BSky         37.6              38         51.1
#> 39                    Idaho BSky         37.6              39         46.5
#> 40              Austin Peay  OVC         37.5              40         51.1
#> 41                 Lipscomb ASun         37.5              41         53.8
#> 42          Sam Houston St. Slnd         37.5              42         48.6
#> 43        Southern Illinois  MVC         37.4              43         51.2
#> 44                   Purdue  B10         37.4              44         51.5
#> 45                  Samford   SC         37.3              45         53.0
#> 46             Oklahoma St.  B12         37.2              46         46.0
#> 47        Purdue Fort Wayne  Sum         37.2              47         55.8
#> 48                  Bradley  MVC         37.0              48         46.5
#> 49            South Alabama   SB         37.0              49         51.1
#> 50             Nicholls St. Slnd         37.0              50         45.5
#> 51              Norfolk St. MEAC         37.0              51         46.1
#> 52         Coastal Carolina   SB         37.0              52         49.5
#> 53                     Utah  P12         37.0              53         54.6
#> 54                  Belmont  OVC         37.0              54         59.3
#> 55         Central Michigan  MAC         36.9              55         48.9
#> 56       Florida Gulf Coast ASun         36.9              56         50.7
#> 57                   Howard MEAC         36.8              57         45.5
#> 58                  Liberty ASun         36.8              58         56.4
#> 59         Western Carolina   SC         36.8              59         52.3
#> 60                  Seattle  WAC         36.8              60         46.1
#> 61           Loyola Chicago  MVC         36.7              61         55.0
#> 62         North Dakota St.  Sum         36.7              62         52.1
#> 63                Tennessee  SEC         36.7              63         55.4
#> 64                 Winthrop BSth         36.7              64         53.4
#> 65            James Madison  CAA         36.7              65         47.5
#> 66   Southeast Missouri St.  OVC         36.6              66         47.4
#> 67           South Carolina  SEC         36.5              67         44.9
#> 68            Cleveland St. Horz         36.5              68         48.9
#> 69               Texas Tech  B12         36.5              68         52.8
#> 70        Northern Illinois  MAC         36.5              70         51.6
#> 71                      UCF Amer         36.5              71         52.0
#> 72                     Yale  Ivy         36.5              72         56.0
#> 73                     Iowa  B10         36.4              73         51.4
#> 74             Oral Roberts  Sum         36.4              74         50.7
#> 75              Florida A&M MEAC         36.4              75         46.9
#> 76           Washington St.  P12         36.4              76         51.5
#> 77                  Gonzaga  WCC         36.3              77         61.4
#> 78                 Missouri  SEC         36.3              78         47.6
#> 79                   Marist MAAC         36.3              79         50.8
#> 80              Chattanooga   SC         36.3              80         49.3
#> 81                 Iowa St.  B12         36.3              81         55.0
#> 82                   Denver  Sum         36.2              82         47.8
#> 83         Eastern Illinois  OVC         36.2              83         46.7
#> 84           North Carolina  ACC         36.2              84         52.1
#> 85              Santa Clara  WCC         36.2              85         49.8
#> 86                Idaho St. BSky         36.2              86         50.4
#> 87                  Harvard  Ivy         36.1              87         52.7
#> 88       Cal St. Northridge   BW         36.1              88         50.3
#> 89                 Longwood BSth         36.1              89         50.7
#> 90             North Dakota  Sum         36.0              90         49.6
#> 91        Northern Kentucky Horz         36.0              91         55.0
#> 92                   Furman   SC         36.0              92         56.7
#> 93                  Vermont   AE         35.9              93         51.6
#> 94                  Niagara MAAC         35.9              94         46.1
#> 95       East Tennessee St.   SC         35.9              95         55.0
#> 96                UC Irvine   BW         35.9              96         50.1
#> 97                Wisconsin  B10         35.9              97         49.7
#> 98              Mississippi  SEC         35.8              98         52.7
#> 99            Bowling Green  MAC         35.8              99         48.8
#> 100              St. John's   BE         35.7             100         50.7
#> 101                   Drake  MVC         35.7             101         53.2
#> 102                Utah St.  MWC         35.7             102         54.1
#> 103                 Detroit Horz         35.6             103         46.7
#> 104                Davidson  A10         35.6             104         52.8
#> 105               Dartmouth  Ivy         35.6             105         50.6
#> 106           San Diego St.  MWC         35.6             106         47.9
#> 107             Little Rock   SB         35.6             107         54.9
#> 108                 Pacific  WCC         35.6             108         44.9
#> 109             Indiana St.  MVC         35.6             109         46.7
#> 110              Georgetown   BE         35.5             110         49.6
#> 111                    UCLA  P12         35.5             111         51.4
#> 112                 Houston Amer         35.5             112         51.3
#> 113           San Francisco  WCC         35.4             113         53.8
#> 114                Kentucky  SEC         35.4             114         52.9
#> 115                Columbia  Ivy         35.4             115         50.6
#> 116                     VMI   SC         35.4             116         47.6
#> 117              Holy Cross  Pat         35.4             117         52.5
#> 118                  Butler   BE         35.3             118         51.4
#> 119        Central Arkansas Slnd         35.3             119         46.3
#> 120          St. Francis PA  NEC         35.3             120         46.4
#> 121            Sacred Heart  NEC         35.2             121         51.1
#> 122               Weber St. BSky         35.2             122         53.4
#> 123                    UMKC  WAC         35.2             123         47.8
#> 124              N.C. State  ACC         35.2             124         51.6
#> 125            Colorado St.  MWC         35.2             125         55.5
#> 126               Villanova   BE         35.2             126         53.7
#> 127               Boise St.  MWC         35.2             127         54.7
#> 128                    Iona MAAC         35.1             128         53.2
#> 129                Bucknell  Pat         35.1             129         53.3
#> 130          Incarnate Word Slnd         35.1             130         51.4
#> 131                    Rice CUSA         35.1             131         48.0
#> 132                  Oregon  P12         35.1             132         51.6
#> 133          William & Mary  CAA         35.0             133         55.8
#> 134          UNC Wilmington  CAA         35.0             134         49.3
#> 135               Fairfield MAAC         35.0             135         49.5
#> 136           Northern Iowa  MVC         35.0             135         46.2
#> 137              Washington  P12         35.0             135         51.9
#> 138                  Kansas  B12         35.0             138         52.6
#> 139           Massachusetts  A10         35.0             139         50.2
#> 140              California  P12         35.0             140         46.5
#> 141                  Hawaii   BW         35.0             141         52.2
#> 142              Murray St.  OVC         34.9             142         56.2
#> 143                Maryland  B10         34.9             143         50.8
#> 144            Old Dominion CUSA         34.9             144         44.0
#> 145        Illinois Chicago Horz         34.9             145         54.0
#> 146               San Diego  WCC         34.8             146         52.4
#> 147             Cal Baptist  WAC         34.8             147         50.4
#> 148       Northern Colorado BSky         34.8             148         53.5
#> 149        UC Santa Barbara   BW         34.8             149         49.4
#> 150                   Texas  B12         34.8             150         49.8
#> 151                    NJIT ASun         34.8             151         49.8
#> 152      Eastern Washington BSky         34.8             152         48.9
#> 153                  Albany   AE         34.8             153         46.9
#> 154                  Nevada  MWC         34.7             154         54.8
#> 155                    Penn  Ivy         34.7             155         52.9
#> 156                Richmond  A10         34.7             156         55.5
#> 157                  Drexel  CAA         34.7             157         50.9
#> 158        Northern Arizona BSky         34.6             158         49.2
#> 159                    Elon  CAA         34.6             159         52.2
#> 160              Wright St. Horz         34.6             160         50.5
#> 161                     TCU  B12         34.6             161         52.3
#> 162                Oklahoma  B12         34.6             162         49.7
#> 163                 Wyoming  MWC         34.5             163         47.1
#> 164                Arkansas  SEC         34.5             164         50.6
#> 165                Illinois  B10         34.5             164         48.2
#> 166              New Mexico  MWC         34.5             166         47.7
#> 167     Charleston Southern BSth         34.5             167         48.4
#> 168              Cincinnati Amer         34.5             168         47.6
#> 169               Green Bay Horz         34.5             169         51.4
#> 170         Appalachian St.   SB         34.4             170         51.3
#> 171             Connecticut Amer         34.4             171         50.7
#> 172                    UTSA CUSA         34.3             172         48.0
#> 173                  DePaul   BE         34.3             173         53.3
#> 174            UMass Lowell   AE         34.3             174         55.1
#> 175                Marshall CUSA         34.2             175         52.3
#> 176                Michigan  B10         34.2             176         51.8
#> 177              Louisville  ACC         34.2             177         50.6
#> 178          Youngstown St. Horz         34.2             178         48.5
#> 179              Evansville  MVC         34.2             179         47.9
#> 180       Boston University  Pat         34.2             180         54.5
#> 181            LIU Brooklyn  NEC         34.1             181         50.3
#> 182                  Baylor  B12         34.1             182         51.2
#> 183      North Carolina A&T MEAC         34.1             183         51.0
#> 184                 Hampton BSth         34.1             184         47.5
#> 185                Ohio St.  B10         34.1             184         49.7
#> 186                   Rider MAAC         34.1             186         50.3
#> 187               Loyola MD  Pat         34.1             187         51.8
#> 188           Robert Morris  NEC         34.1             188         47.3
#> 189                     SMU Amer         34.1             189         51.3
#> 190        Tennessee Martin  OVC         34.1             190         49.9
#> 191                   Tulsa Amer         34.0             191         51.3
#> 192     Arkansas Pine Bluff SWAC         34.0             192         47.0
#> 193                 Alabama  SEC         34.0             193         49.9
#> 194               Louisiana   SB         33.9             194         50.7
#> 195              Binghamton   AE         33.9             195         48.4
#> 196                   Siena MAAC         33.9             196         52.0
#> 197           North Florida ASun         33.9             197         53.2
#> 198          New Mexico St.  WAC         33.9             198         56.9
#> 199            Missouri St.  MVC         33.9             199         51.4
#> 200            South Dakota  Sum         33.9             200         49.6
#> 201               Milwaukee Horz         33.8             201         46.5
#> 202                  Mercer   SC         33.8             202         51.2
#> 203          UNC Greensboro   SC         33.8             203         51.4
#> 204          Long Beach St.   BW         33.8             204         46.3
#> 205                Campbell BSth         33.8             205         54.8
#> 206                   Brown  Ivy         33.8             206         50.2
#> 207              Charleston  CAA         33.7             207         56.3
#> 208          Louisiana Tech CUSA         33.7             208         49.3
#> 209                    UNLV  MWC         33.7             209         48.8
#> 210           Southern Utah BSky         33.7             210         50.0
#> 211  Southeastern Louisiana Slnd         33.6             211         50.4
#> 212                   Lamar Slnd         33.6             212         48.8
#> 213                 Buffalo  MAC         33.6             213         55.6
#> 214                 Arizona  P12         33.6             214         48.1
#> 215             Arizona St.  P12         33.6             215         50.8
#> 216            Morehead St.  OVC         33.6             215         47.1
#> 217          Tennessee Tech  OVC         33.6             217         43.9
#> 218                Kent St.  MAC         33.6             218         49.1
#> 219             The Citadel   SC         33.5             219         54.1
#> 220          St. Francis NY  NEC         33.5             220         47.3
#> 221              Kansas St.  B12         33.4             221         48.8
#> 222         Houston Baptist Slnd         33.4             222         49.3
#> 223                Nebraska  B10         33.4             223         48.6
#> 224                 Florida  SEC         33.4             224         49.5
#> 225             New Orleans Slnd         33.3             225         47.2
#> 226                Miami FL  ACC         33.3             226         51.3
#> 227           South Florida Amer         33.3             227         48.5
#> 228       Stephen F. Austin Slnd         33.3             228         47.6
#> 229                Syracuse  ACC         33.3             229         49.3
#> 230                    Troy   SB         33.2             230         51.7
#> 231                  Dayton  A10         33.2             231         59.5
#> 232             Florida St.  ACC         33.2             232         50.9
#> 233               Manhattan MAAC         33.1             233         45.6
#> 234          Sacramento St. BSky         33.1             234         48.3
#> 235            Grand Canyon  WAC         33.1             235         52.5
#> 236                  Xavier   BE         33.1             236         54.7
#> 237              Pittsburgh  ACC         33.1             237         46.9
#> 238                La Salle  A10         33.1             238         45.3
#> 239              Morgan St. MEAC         33.1             239         41.5
#> 240                     BYU  WCC         33.0             240         54.6
#> 241                 Fordham  A10         33.0             241         44.7
#> 242                   IUPUI Horz         33.0             242         50.5
#> 243                  Temple Amer         33.0             243         50.1
#> 244            George Mason  A10         33.0             244         50.5
#> 245            San Jose St.  MWC         33.0             245         44.1
#> 246                 Cornell  Ivy         32.9             246         52.4
#> 247                Portland  WCC         32.9             247         45.8
#> 248                 Clemson  ACC         32.8             248         51.5
#> 249     Central Connecticut  NEC         32.8             249         45.8
#> 250         St. Bonaventure  A10         32.8             250         47.9
#> 251        Western Kentucky CUSA         32.7             251         50.2
#> 252            Illinois St.  MVC         32.7             252         49.1
#> 253                  Towson  CAA         32.7             253         47.6
#> 254                UC Davis   BW         32.7             254         49.0
#> 255        Florida Atlantic CUSA         32.6             255         47.0
#> 256           Tennessee St.  OVC         32.6             256         49.3
#> 257              Providence   BE         32.6             257         47.5
#> 258             Stony Brook   AE         32.6             258         47.7
#> 259                Southern SWAC         32.6             259         48.8
#> 260                     UAB CUSA         32.6             260         51.3
#> 261           New Hampshire   AE         32.6             261         39.4
#> 262                American  Pat         32.5             262         55.6
#> 263        Georgia Southern   SB         32.5             262         56.7
#> 264                  Bryant  NEC         32.5             264         49.2
#> 265               Texas St.   SB         32.5             265         50.8
#> 266           Saint Peter's MAAC         32.5             266         48.8
#> 267      South Carolina St. MEAC         32.4             267         46.5
#> 268              Seton Hall   BE         32.4             268         50.6
#> 269               Air Force  MWC         32.4             269         53.1
#> 270                Canisius MAAC         32.4             270         52.0
#> 271         Bethune Cookman MEAC         32.4             271         48.3
#> 272                Colorado  P12         32.3             272         52.4
#> 273        Prairie View A&M SWAC         32.3             273         49.3
#> 274                Miami OH  MAC         32.3             274         48.7
#> 275        Middle Tennessee CUSA         32.3             275         45.7
#> 276            Arkansas St.   SB         32.3             276         46.5
#> 277  Texas A&M Corpus Chris Slnd         32.3             277         47.6
#> 278                Duquesne  A10         32.2             278         51.2
#> 279          Saint Joseph's  A10         32.2             279         47.8
#> 280                Ball St.  MAC         32.2             280         53.5
#> 281                 Memphis Amer         32.2             281         52.6
#> 282                 Georgia  SEC         32.2             282         51.1
#> 283          Texas Southern SWAC         32.1             283         52.2
#> 284             Alabama St. SWAC         32.1             284         44.7
#> 285             USC Upstate BSth         32.1             285         46.8
#> 286              Oregon St.  P12         32.1             286         54.5
#> 287                Cal Poly   BW         32.0             287         46.6
#> 288                Penn St.  B10         32.0             288         47.2
#> 289        Eastern Kentucky  OVC         32.0             289         47.7
#> 290                     LSU  SEC         31.9             290         52.9
#> 291                    UTEP CUSA         31.9             291         44.5
#> 292                  Tulane Amer         31.8             292         46.7
#> 293                    Army  Pat         31.8             293         51.0
#> 294          Boston College  ACC         31.7             294         49.1
#> 295             North Texas CUSA         31.7             295         50.5
#> 296                    Navy  Pat         31.7             296         46.4
#> 297                Stanford  P12         31.7             297         53.2
#> 298           UNC Asheville BSth         31.7             298         45.2
#> 299                   Akron  MAC         31.7             299         48.8
#> 300               Minnesota  B10         31.7             300         48.5
#> 301        Loyola Marymount  WCC         31.6             301         50.3
#> 302           West Virginia  B12         31.6             302         47.6
#> 303  North Carolina Central MEAC         31.6             303         51.3
#> 304              Notre Dame  ACC         31.5             304         45.4
#> 305             Alabama A&M SWAC         31.4             305         45.0
#> 306            Kennesaw St. ASun         31.4             306         39.1
#> 307                    UMBC   AE         31.3             307         49.5
#> 308    UT Rio Grande Valley  WAC         31.3             308         46.0
#> 309            Northwestern  B10         31.3             309         46.4
#> 310              Alcorn St. SWAC         31.3             310         45.0
#> 311                 Indiana  B10         31.2             311         53.1
#> 312                 Rutgers  B10         31.2             312         47.2
#> 313        Mount St. Mary's  NEC         31.2             313         48.7
#> 314            Jacksonville ASun         31.1             314         51.0
#> 315              Vanderbilt  SEC         31.1             315         50.0
#> 316       George Washington  A10         31.1             316         45.3
#> 317               Charlotte CUSA         31.1             317         49.2
#> 318        Jacksonville St.  OVC         31.0             318         52.3
#> 319             Wichita St. Amer         31.0             319         47.1
#> 320     Cal St. Bakersfield  WAC         31.0             320         46.7
#> 321  Mississippi Valley St. SWAC         31.0             321         40.1
#> 322                 Stetson ASun         31.0             322         45.0
#> 323             McNeese St. Slnd         31.0             323         51.3
#> 324              Valparaiso  MVC         31.0             324         50.1
#> 325                   Maine   AE         31.0             325         49.9
#> 326       Cal St. Fullerton   BW         30.8             326         50.3
#> 327                    Duke  ACC         30.8             327         58.0
#> 328             Wake Forest  ACC         30.8             328         44.1
#> 329               Texas A&M  SEC         30.8             329         51.0
#> 330            Georgia Tech  ACC         30.7             330         50.7
#> 331        Western Michigan  MAC         30.5             331         49.4
#> 332                     VCU  A10         30.5             332         53.1
#> 333            UT Arlington   SB         30.5             333         47.9
#> 334             Chicago St.  WAC         30.5             334         43.5
#> 335             Saint Louis  A10         30.4             335         47.2
#> 336        SIU Edwardsville  OVC         30.3             336         47.6
#> 337              High Point BSth         30.3             337         51.0
#> 338               Princeton  Ivy         30.3             338         48.1
#> 339                  Wagner  NEC         30.1             339         43.1
#> 340        Eastern Michigan  MAC         29.9             340         50.4
#> 341            Portland St. BSky         29.8             341         48.3
#> 342           North Alabama ASun         29.7             342         44.4
#> 343                    Ohio  MAC         29.7             343         50.7
#> 344                Monmouth MAAC         29.7             344         46.4
#> 345                     FIU CUSA         29.4             345         52.2
#> 346            Savannah St. MEAC         29.2             346         53.7
#> 347            Delaware St. MEAC         29.0             347         37.7
#> 348              Coppin St. MEAC         28.5             348         47.7
#> 349           East Carolina Amer         28.4             349         47.7
#> 350        Northwestern St. Slnd         28.0             350         46.2
#> 351            Rhode Island  A10         28.0             351         50.0
#> 352  Maryland Eastern Shore MEAC         27.9             352         44.5
#> 353             Jackson St. SWAC         27.9             353         45.9
#> 354                     BYU  WCC         41.9               1         54.8
#> 355                  Oregon  P12         39.6               2         51.4
#> 356                UC Davis   BW         39.1               3         48.5
#> 357            South Dakota  Sum         38.8               4         52.9
#> 358            Saint Mary's  WCC         38.7               5         51.9
#> 359               Creighton   BE         38.7               6         53.0
#> 360                 Gonzaga  WCC         38.6               7         57.4
#> 361           Northern Iowa  MVC         38.6               8         52.6
#> 362                  Nevada  MWC         38.3               9         49.5
#> 363               Marquette   BE         38.2              10         46.9
#> 364           San Diego St.  MWC         37.9              11         53.0
#> 365           North Florida ASun         37.8              12         52.4
#> 366             Cal Baptist  WAC         37.7              13         46.7
#> 367  Texas A&M Corpus Chris Slnd         37.7              14         48.4
#> 368              Louisville  ACC         37.6              15         50.1
#> 369             Indiana St.  MVC         37.5              16         49.3
#> 370             North Texas CUSA         37.5              17         54.6
#> 371       Northern Colorado BSky         37.4              18         53.6
#> 372       Stephen F. Austin Slnd         37.4              19         52.3
#> 373                 Hofstra  CAA         37.4              20         49.0
#> 374                Stanford  P12         37.3              21         52.1
#> 375      Cal St. Northridge   BW         37.3              22         49.4
#> 376                Ohio St.  B10         37.3              23         49.7
#> 377             McNeese St. Slnd         37.3              24         54.3
#> 378                 Niagara MAAC         37.2              25         46.2
#> 379                 Bradley  MVC         37.1              26         46.6
#> 380                  Dayton  A10         37.1              27         62.3
#> 381            Northeastern  CAA         37.1              28         54.4
#> 382               Air Force  MWC         36.9              29         51.0
#> 383                    Yale  Ivy         36.9              30         52.7
#> 384            Colorado St.  MWC         36.9              31         52.9
#> 385        Western Carolina   SC         36.8              32         54.0
#> 386                Davidson  A10         36.8              33         52.0
#> 387                  Toledo  MAC         36.8              33         47.9
#> 388              Murray St.  OVC         36.7              35         51.6
#> 389               Green Bay Horz         36.6              36         48.8
#> 390        Western Illinois  Sum         36.6              37         44.7
#> 391                 Montana BSky         36.4              38         51.4
#> 392            Gardner Webb BSth         36.4              39         50.0
#> 393         Houston Baptist Slnd         36.4              40         48.3
#> 394                   Akron  MAC         36.2              41         49.6
#> 395                Richmond  A10         36.2              42         52.9
#> 396           Robert Morris  NEC         36.1              43         49.6
#> 397          St. Francis PA  NEC         36.0              44         50.3
#> 398          Loyola Chicago  MVC         36.0              45         55.3
#> 399               Villanova   BE         35.9              46         51.5
#> 400            Illinois St.  MVC         35.9              47         47.0
#> 401             Georgia St.   SB         35.8              48         48.3
#> 402           Tennessee St.  OVC         35.7              49         52.7
#> 403                 Colgate  Pat         35.7              50         52.1
#> 404              Quinnipiac MAAC         35.7              51         48.1
#> 405             Chattanooga   SC         35.7              52         51.8
#> 406     Fairleigh Dickinson  NEC         35.7              53         49.7
#> 407               UC Irvine   BW         35.6              54         50.8
#> 408               Princeton  Ivy         35.5              55         53.8
#> 409          Louisiana Tech CUSA         35.5              56         53.3
#> 410              Texas Tech  B12         35.5              57         50.8
#> 411              Wright St. Horz         35.5              58         49.9
#> 412                   Siena MAAC         35.5              59         51.0
#> 413        South Dakota St.  Sum         35.4              60         57.4
#> 414                     TCU  B12         35.4              61         46.6
#> 415            Missouri St.  MVC         35.4              62         48.2
#> 416                  Drexel  CAA         35.3              63         49.0
#> 417             Austin Peay  OVC         35.3              64         50.4
#> 418           UNC Asheville BSth         35.3              65         52.2
#> 419        Northern Arizona BSky         35.3              66         48.1
#> 420          Long Beach St.   BW         35.3              67         46.2
#> 421                 Arizona  P12         35.2              68         49.6
#> 422                  Mercer   SC         35.2              69         49.9
#> 423        North Dakota St.  Sum         35.2              70         51.2
#> 424               Wisconsin  B10         35.2              71         48.3
#> 425                Delaware  CAA         35.2              72         55.4
#> 426                 Radford BSth         35.2              73         52.4
#> 427                    Elon  CAA         35.2              74         46.3
#> 428        Northwestern St. Slnd         35.2              75         47.9
#> 429                    Duke  ACC         35.2              76         52.5
#> 430           Virginia Tech  ACC         35.2              77         48.1
#> 431          William & Mary  CAA         35.2              78         54.0
#> 432                    UMKC  WAC         35.1              79         49.4
#> 433              Pepperdine  WCC         35.1              80         48.4
#> 434             Florida St.  ACC         35.1              81         51.5
#> 435             Little Rock   SB         35.1              82         52.9
#> 436                Colorado  P12         35.1              83         49.1
#> 437                  Baylor  B12         35.1              84         47.5
#> 438             Wake Forest  ACC         35.1              85         47.3
#> 439                     USC  P12         35.0              86         48.1
#> 440              Charleston  CAA         34.9              87         50.3
#> 441             Santa Clara  WCC         34.9              88         52.0
#> 442                 Liberty ASun         34.9              89         55.7
#> 443                   Drake  MVC         34.9              90         51.3
#> 444                 Alabama  SEC         34.9              91         52.1
#> 445            UC Riverside   BW         34.8              92         48.0
#> 446         Sam Houston St. Slnd         34.8              93         49.8
#> 447                 Belmont  OVC         34.8              94         56.8
#> 448     Central Connecticut  NEC         34.8              95         41.2
#> 449            Michigan St.  B10         34.8              96         52.9
#> 450                     VMI   SC         34.8              97         48.6
#> 451                  Towson  CAA         34.8              98         46.9
#> 452                 Florida  SEC         34.7              99         52.2
#> 453                  Howard MEAC         34.7             100         45.9
#> 454                    Iowa  B10         34.7             101         51.3
#> 455                Campbell BSth         34.6             102         53.0
#> 456                     VCU  A10         34.6             103         48.4
#> 457              Georgetown   BE         34.6             104         47.8
#> 458          New Mexico St.  WAC         34.6             105         53.4
#> 459                Hartford   AE         34.6             106         46.4
#> 460                  Furman   SC         34.5             107         57.0
#> 461              Notre Dame  ACC         34.5             108         49.4
#> 462                Winthrop BSth         34.4             109         54.1
#> 463      Eastern Washington BSky         34.4             110         52.2
#> 464                Longwood BSth         34.4             111         44.8
#> 465                    UTSA CUSA         34.4             112         45.5
#> 466                Portland  WCC         34.4             113         47.0
#> 467                Bucknell  Pat         34.3             114         47.8
#> 468                Kentucky  SEC         34.3             115         50.4
#> 469           Bowling Green  MAC         34.3             116         45.3
#> 470        UC Santa Barbara   BW         34.2             117         51.0
#> 471                    Ohio  MAC         34.2             118         51.3
#> 472              Alcorn St. SWAC         34.2             119         44.7
#> 473                     LIU  NEC         34.2             120         51.4
#> 474           Saint Peter's MAAC         34.2             121         43.5
#> 475             Saint Louis  A10         34.2             122         49.7
#> 476                  Butler   BE         34.1             123         52.9
#> 477         St. Bonaventure  A10         34.1             124         48.1
#> 478                 Wofford   SC         34.1             125         55.3
#> 479            Arkansas St.   SB         34.1             126         47.8
#> 480                     FIU CUSA         34.1             127         52.1
#> 481               Idaho St. BSky         34.1             128         49.4
#> 482            Grand Canyon  WAC         34.1             129         50.5
#> 483                  Marist MAAC         34.1             130         42.4
#> 484                 Pacific  WCC         34.1             131         48.9
#> 485                  Kansas  B12         34.1             132         54.9
#> 486       Southern Illinois  MVC         34.1             133         48.3
#> 487              Valparaiso  MVC         34.0             134         50.4
#> 488          Nebraska Omaha  Sum         34.0             135         49.4
#> 489                Cal Poly   BW         34.0             136         45.5
#> 490                    Rice CUSA         34.0             137         51.9
#> 491               Charlotte CUSA         34.0             138         51.9
#> 492                American  Pat         34.0             139         51.9
#> 493      East Tennessee St.   SC         33.9             140         55.2
#> 494                Michigan  B10         33.9             141         54.1
#> 495        Eastern Illinois  OVC         33.8             142         50.3
#> 496       Northern Illinois  MAC         33.8             143         45.2
#> 497        Illinois Chicago Horz         33.8             144         50.9
#> 498            Portland St. BSky         33.8             145         49.2
#> 499                Kent St.  MAC         33.7             146         53.4
#> 500              Fresno St.  MWC         33.7             147         49.0
#> 501                  Lehigh  Pat         33.7             148         49.4
#> 502               Minnesota  B10         33.7             149         48.6
#> 503                Lipscomb ASun         33.7             150         49.8
#> 504                   IUPUI Horz         33.7             151         46.2
#> 505                 Houston Amer         33.7             152         46.6
#> 506        Louisiana Monroe   SB         33.7             153         46.3
#> 507            UMass Lowell   AE         33.7             154         52.2
#> 508               Boise St.  MWC         33.6             155         51.6
#> 509                 Samford   SC         33.6             156         46.8
#> 510                La Salle  A10         33.6             157         46.9
#> 511         Mississippi St.  SEC         33.6             158         51.9
#> 512                Miami OH  MAC         33.6             159         47.0
#> 513               Lafayette  Pat         33.6             160         53.4
#> 514              California  P12         33.5             161         45.5
#> 515                    Utah  P12         33.5             162         52.0
#> 516           North Alabama ASun         33.5             163         46.6
#> 517                Ball St.  MAC         33.5             164         50.5
#> 518              Seton Hall   BE         33.5             165         52.3
#> 519             Stony Brook   AE         33.5             166         45.9
#> 520           San Francisco  WCC         33.5             167         52.2
#> 521            Nicholls St. Slnd         33.4             168         49.1
#> 522                   Texas  B12         33.4             169         49.8
#> 523                Monmouth MAAC         33.4             170         45.4
#> 524                  Tulane Amer         33.4             171         46.3
#> 525                Arkansas  SEC         33.4             172         51.5
#> 526                   Lamar Slnd         33.3             173         47.1
#> 527               Merrimack  NEC         33.3             173         47.4
#> 528            Oral Roberts  Sum         33.3             173         51.4
#> 529        Tennessee Martin  OVC         33.3             173         51.4
#> 530              Vanderbilt  SEC         33.3             173         50.3
#> 531                    Iona MAAC         33.3             178         51.8
#> 532        Western Kentucky CUSA         33.3             179         52.0
#> 533                 Stetson ASun         33.3             180         49.5
#> 534                   Idaho BSky         33.3             181         46.8
#> 535              Providence   BE         33.2             182         45.9
#> 536        Western Michigan  MAC         33.1             183         47.3
#> 537        Coastal Carolina   SB         33.1             184         50.4
#> 538        Middle Tennessee CUSA         33.0             185         45.9
#> 539                  Purdue  B10         33.0             186         46.7
#> 540           New Hampshire   AE         33.0             187         44.8
#> 541           South Alabama   SB         33.0             188         52.2
#> 542                  Hawaii   BW         32.9             189         48.4
#> 543                 Memphis Amer         32.9             190         50.0
#> 544                Syracuse  ACC         32.9             191         51.4
#> 545                 Vermont   AE         32.9             191         53.4
#> 546           Massachusetts  A10         32.9             193         49.1
#> 547                Utah St.  MWC         32.9             194         53.3
#> 548                 Harvard  Ivy         32.8             195         52.4
#> 549                    Army  Pat         32.8             196         55.0
#> 550             Wichita St. Amer         32.8             197         45.8
#> 551                     LSU  SEC         32.7             198         54.7
#> 552            Sacred Heart  NEC         32.7             199         49.2
#> 553             New Orleans Slnd         32.6             200         48.2
#> 554                  Albany   AE         32.6             201         47.3
#> 555              New Mexico  MWC         32.6             202         54.2
#> 556                    Penn  Ivy         32.6             202         55.0
#> 557                 Indiana  B10         32.6             204         49.5
#> 558                Penn St.  B10         32.5             205         50.0
#> 559            Presbyterian BSth         32.5             206         50.9
#> 560              Washington  P12         32.5             207         51.4
#> 561                 Cornell  Ivy         32.5             208         50.5
#> 562              Oregon St.  P12         32.5             209         53.2
#> 563                 Hampton BSth         32.4             210         50.8
#> 564             The Citadel   SC         32.4             211         50.6
#> 565            North Dakota  Sum         32.4             212         51.9
#> 566              Binghamton   AE         32.4             213         47.2
#> 567    UT Rio Grande Valley  WAC         32.4             214         46.1
#> 568             Connecticut Amer         32.4             215         47.4
#> 569          Tennessee Tech  OVC         32.4             216         46.8
#> 570               Loyola MD  Pat         32.3             217         55.2
#> 571                     SMU Amer         32.3             218         54.7
#> 572                     UCF Amer         32.3             219         49.9
#> 573             Arizona St.  P12         32.3             220         49.0
#> 574           James Madison  CAA         32.3             221         48.1
#> 575        Georgia Southern   SB         32.3             222         51.4
#> 576                 Detroit Horz         32.3             223         44.5
#> 577                  Temple Amer         32.2             224         44.7
#> 578       Cal St. Fullerton   BW         32.2             225         47.3
#> 579                    UCLA  P12         32.2             226         48.4
#> 580                   Tulsa Amer         32.2             227         50.3
#> 581       Boston University  Pat         32.1             228         53.0
#> 582                  Denver  Sum         32.1             229         49.5
#> 583  Southeast Missouri St.  OVC         32.1             230         46.4
#> 584              St. John's   BE         32.1             231         44.9
#> 585       George Washington  A10         32.1             232         49.6
#> 586                   Rider MAAC         32.1             233         49.6
#> 587             USC Upstate BSth         32.0             234         47.0
#> 588              Holy Cross  Pat         32.0             235         50.1
#> 589             Mississippi  SEC         32.0             235         48.9
#> 590               Louisiana   SB         32.0             237         48.0
#> 591          UNC Greensboro   SC         31.9             238         49.5
#> 592                    UNLV  MWC         31.9             239         50.9
#> 593                  Bryant  NEC         31.9             240         48.0
#> 594              Evansville  MVC         31.9             241         49.2
#> 595              Cincinnati Amer         31.9             242         51.7
#> 596       Purdue Fort Wayne  Sum         31.9             243         50.7
#> 597              N.C. State  ACC         31.9             244         52.6
#> 598                Duquesne  A10         31.8             245         53.8
#> 599        Florida Atlantic CUSA         31.8             246         49.1
#> 600     Charleston Southern BSth         31.8             247         48.9
#> 601                Oklahoma  B12         31.8             248         48.6
#> 602                 Wyoming  MWC         31.8             249         48.3
#> 603                Nebraska  B10         31.8             250         46.3
#> 604           Southern Utah BSky         31.8             251         49.2
#> 605                 Fordham  A10         31.8             252         43.1
#> 606               Texas St.   SB         31.8             253         49.4
#> 607            Jacksonville ASun         31.7             254         48.2
#> 608                Miami FL  ACC         31.7             255         49.5
#> 609         Bethune Cookman MEAC         31.7             256         45.9
#> 610                     UAB CUSA         31.7             257         50.6
#> 611                    Troy   SB         31.7             258         45.0
#> 612              High Point BSth         31.7             259         44.7
#> 613               Milwaukee Horz         31.7             260         46.4
#> 614                Marshall CUSA         31.7             261         51.9
#> 615                Iowa St.  B12         31.6             262         51.3
#> 616          Sacramento St. BSky         31.6             263         44.7
#> 617            Rhode Island  A10         31.5             264         46.7
#> 618        Jacksonville St.  OVC         31.5             265         49.6
#> 619            Oklahoma St.  B12         31.5             266         48.0
#> 620                 Clemson  ACC         31.5             267         52.6
#> 621                 Buffalo  MAC         31.5             268         49.8
#> 622             Montana St. BSky         31.5             269         49.8
#> 623       Abilene Christian Slnd         31.5             270         51.0
#> 624          UNC Wilmington  CAA         31.4             271         45.2
#> 625        Central Michigan  MAC         31.4             272         47.7
#> 626     Cal St. Bakersfield  WAC         31.4             273         46.3
#> 627        Eastern Kentucky  OVC         31.3             274         46.2
#> 628                Southern SWAC         31.3             275         48.3
#> 629              Kansas St.  B12         31.3             276         47.9
#> 630               Tennessee  SEC         31.3             277         49.9
#> 631        Mount St. Mary's  NEC         31.3             278         45.8
#> 632            Northwestern  B10         31.2             279         46.9
#> 633                 Seattle  WAC         31.2             280         44.3
#> 634          Youngstown St. Horz         31.2             281         47.8
#> 635                  Xavier   BE         31.2             282         50.2
#> 636        Central Arkansas Slnd         31.2             283         49.8
#> 637                  DePaul   BE         31.1             284         48.4
#> 638               Dartmouth  Ivy         31.1             285         51.6
#> 639                Maryland  B10         31.1             286         50.1
#> 640            Georgia Tech  ACC         31.1             287         51.2
#> 641             Norfolk St. MEAC         31.0             288         47.3
#> 642          South Carolina  SEC         31.0             289         49.5
#> 643        SIU Edwardsville  OVC         31.0             290         47.1
#> 644               Manhattan MAAC         30.9             291         45.3
#> 645            Delaware St. MEAC         30.9             292         47.4
#> 646           South Florida Amer         30.9             293         46.7
#> 647          Washington St.  P12         30.9             294         45.5
#> 648                 Rutgers  B10         30.8             295         50.1
#> 649          Boston College  ACC         30.8             296         46.7
#> 650      Florida Gulf Coast ASun         30.8             297         48.0
#> 651               San Diego  WCC         30.7             298         45.8
#> 652  North Carolina Central MEAC         30.6             299         52.6
#> 653       Northern Kentucky Horz         30.6             300         52.4
#> 654                  Auburn  SEC         30.6             301         53.3
#> 655                  Wagner  NEC         30.5             302         46.9
#> 656          Texas Southern SWAC         30.5             303         45.9
#> 657                    NJIT ASun         30.4             304         45.1
#> 658             Chicago St.  WAC         30.4             305         45.4
#> 659          North Carolina  ACC         30.4             306         46.8
#> 660                   Brown  Ivy         30.4             307         44.5
#> 661            George Mason  A10         30.4             308         48.7
#> 662            UT Arlington   SB         30.4             309         48.5
#> 663                Illinois  B10         30.3             310         49.6
#> 664                Virginia  ACC         30.3             311         47.8
#> 665             Alabama St. SWAC         30.3             312         44.1
#> 666        Prairie View A&M SWAC         30.3             313         48.1
#> 667             Utah Valley  WAC         30.2             314         51.4
#> 668                Canisius MAAC         30.2             315         50.2
#> 669         Appalachian St.   SB         30.2             316         50.3
#> 670               Weber St. BSky         30.2             317         50.7
#> 671                    UMBC   AE         30.2             318         50.3
#> 672                 Georgia  SEC         30.1             319         54.5
#> 673           Grambling St. SWAC         30.0             320         48.6
#> 674  Southeastern Louisiana Slnd         29.9             321         47.9
#> 675           Southern Miss CUSA         29.9             322         49.1
#> 676                    UTEP CUSA         29.9             323         49.0
#> 677                Columbia  Ivy         29.8             324         46.9
#> 678          Saint Joseph's  A10         29.7             325         48.5
#> 679                Missouri  SEC         29.7             326         48.7
#> 680        Loyola Marymount  WCC         29.7             327         54.4
#> 681            San Jose St.  MWC         29.6             328         45.9
#> 682      North Carolina A&T MEAC         29.6             329         48.4
#> 683              Pittsburgh  ACC         29.6             330         45.5
#> 684               Texas A&M  SEC         29.4             331         48.0
#> 685  Mississippi Valley St. SWAC         29.4             332         42.2
#> 686                 Oakland Horz         29.4             333         50.6
#> 687                    Navy  Pat         29.4             334         47.5
#> 688            Old Dominion CUSA         29.3             335         46.0
#> 689          St. Francis NY  NEC         29.3             335         47.7
#> 690          Incarnate Word Slnd         29.1             337         46.8
#> 691           West Virginia  B12         28.6             338         47.9
#> 692               Fairfield MAAC         28.4             339         43.4
#> 693           Cleveland St. Horz         28.4             340         45.1
#> 694             Florida A&M MEAC         28.4             341         46.2
#> 695                   Maine   AE         28.2             342         49.3
#> 696              Coppin St. MEAC         28.1             343         49.2
#> 697             Alabama A&M SWAC         28.1             344         42.6
#> 698      South Carolina St. MEAC         28.1             345         47.8
#> 699           East Carolina Amer         28.1             346         49.0
#> 700              Morgan St. MEAC         27.9             347         47.7
#> 701            Morehead St.  OVC         27.3             348         50.6
#> 702        Eastern Michigan  MAC         26.7             349         50.1
#> 703     Arkansas Pine Bluff SWAC         26.3             350         44.6
#> 704             Jackson St. SWAC         26.3             351         47.6
#> 705  Maryland Eastern Shore MEAC         25.0             352         42.5
#> 706            Kennesaw St. ASun         24.8             353         40.2
#> 707                  Baylor  B12         41.3               1         53.2
#> 708        South Dakota St.  Sum         40.9               2         53.9
#> 709                 Colgate  Pat         40.3               3         54.4
#> 710       Purdue Fort Wayne Horz         40.0               4         57.0
#> 711             Cal Baptist  WAC         39.5               5         50.3
#> 712               Texas St.   SB         39.4               6         49.1
#> 713                 Detroit Horz         39.1               7         52.2
#> 714            South Dakota  Sum         39.1               8         50.5
#> 715                 Liberty ASun         38.8               9         55.8
#> 716                    Iowa  B10         38.6              10         52.7
#> 717              Charleston  CAA         38.2              11         47.8
#> 718          Incarnate Word Slnd         38.2              12         45.8
#> 719                Michigan  B10         38.1              13         53.5
#> 720       Cal St. Fullerton   BW         38.0              14         48.1
#> 721                American  Pat         37.8              15         49.5
#> 722                  Bryant  NEC         37.7              16         51.0
#> 723          Sacramento St. BSky         37.7              17         48.0
#> 724                  Oregon  P12         37.7              18         52.9
#> 725              Evansville  MVC         37.7              19         50.0
#> 726            Oral Roberts  Sum         37.7              20         50.0
#> 727             Florida St.  ACC         37.6              21         52.7
#> 728       Northern Colorado BSky         37.6              22         47.4
#> 729     Fairleigh Dickinson  NEC         37.5              23         49.4
#> 730                Virginia  ACC         37.5              24         54.9
#> 731            Tarleton St.  WAC         37.4              25         45.6
#> 732            Arkansas St.   SB         37.4              26         44.8
#> 733                Campbell BSth         37.4              27         55.4
#> 734              Bellarmine ASun         37.3              28         55.0
#> 735                  Toledo  MAC         37.2              29         52.5
#> 736                Illinois  B10         37.2              30         55.4
#> 737       Southern Illinois  MVC         37.2              31         49.7
#> 738             Norfolk St. MEAC         37.2              32         44.7
#> 739                Colorado  P12         37.2              33         50.4
#> 740                  Dayton  A10         37.2              34         55.2
#> 741                    UCLA  P12         37.2              35         50.3
#> 742             North Texas CUSA         37.2              36         52.7
#> 743                 Arizona  P12         37.2              37         48.1
#> 744             McNeese St. Slnd         37.2              38         51.7
#> 745            UC Riverside   BW         37.1              39         50.3
#> 746                  Drexel  CAA         37.1              40         52.0
#> 747                     VMI   SC         37.0              41         52.4
#> 748              Wright St. Horz         37.0              42         53.8
#> 749            UC San Diego   BW         37.0              43         54.6
#> 750           San Diego St.  MWC         36.8              44         50.4
#> 751                 Gonzaga  WCC         36.8              45         63.9
#> 752              Notre Dame  ACC         36.8              46         52.9
#> 753                     BYU  WCC         36.7              47         54.8
#> 754                 Montana BSky         36.6              48         46.5
#> 755                  Mercer   SC         36.6              49         53.9
#> 756              Murray St.  OVC         36.6              50         54.5
#> 757               Weber St. BSky         36.6              51         57.3
#> 758           Robert Morris Horz         36.5              52         48.3
#> 759               Wisconsin  B10         36.5              53         46.6
#> 760              Georgetown   BE         36.5              54         46.1
#> 761           West Virginia  B12         36.4              55         46.1
#> 762       Abilene Christian Slnd         36.4              56         49.3
#> 763                   Drake  MVC         36.4              57         52.9
#> 764                 Memphis Amer         36.3              58         48.9
#> 765                Monmouth MAAC         36.3              59         45.4
#> 766                Miami OH  MAC         36.2              60         48.1
#> 767           North Florida ASun         36.2              61         51.2
#> 768               Creighton   BE         36.1              62         55.7
#> 769            Gardner Webb BSth         36.1              63         51.0
#> 770               Lafayette  Pat         36.0              64         48.4
#> 771                    Rice CUSA         36.0              65         51.3
#> 772                     USC  P12         36.0              66         52.2
#> 773        Central Arkansas Slnd         36.0              67         46.8
#> 774                Ohio St.  B10         36.0              67         52.2
#> 775      Eastern Washington BSky         36.0              69         54.4
#> 776                Marshall CUSA         36.0              70         55.5
#> 777          Long Beach St.   BW         35.9              71         49.0
#> 778              N.C. State  ACC         35.8              72         52.6
#> 779                 Stetson ASun         35.8              73         48.0
#> 780        Eastern Kentucky  OVC         35.8              74         49.6
#> 781           UNC Asheville BSth         35.8              75         55.2
#> 782                Davidson  A10         35.7              76         56.8
#> 783                  Hawaii   BW         35.7              77         48.6
#> 784                 Wyoming  MWC         35.7              78         53.9
#> 785                    Ohio  MAC         35.6              79         55.5
#> 786                   Texas  B12         35.6              80         52.5
#> 787                 Florida  SEC         35.6              81         53.0
#> 788               Louisiana   SB         35.6              81         48.8
#> 789              Holy Cross  Pat         35.6              83         48.8
#> 790                 Wofford   SC         35.6              84         56.6
#> 791                    Utah  P12         35.5              85         53.0
#> 792                     UCF Amer         35.5              86         47.9
#> 793                  Nevada  MWC         35.5              87         50.0
#> 794        Florida Atlantic CUSA         35.4              88         50.2
#> 795           Virginia Tech  ACC         35.4              89         51.6
#> 796             Chattanooga   SC         35.4              90         48.6
#> 797          Loyola Chicago  MVC         35.4              91         57.2
#> 798              Texas Tech  B12         35.4              92         47.8
#> 799            Northeastern  CAA         35.4              93         50.4
#> 800               Villanova   BE         35.3              94         53.4
#> 801                Maryland  B10         35.3              95         53.3
#> 802            UT Arlington   SB         35.3              96         41.7
#> 803                   Rider MAAC         35.3              97         46.2
#> 804            Colorado St.  MWC         35.2              98         55.1
#> 805  Southeast Missouri St.  OVC         35.2              99         48.0
#> 806                    Duke  ACC         35.2             100         54.1
#> 807                 Alabama  SEC         35.2             101         50.7
#> 808                Winthrop BSth         35.2             102         52.5
#> 809            Morehead St.  OVC         35.1             103         52.0
#> 810                    UMKC  Sum         35.1             104         50.4
#> 811              Oregon St.  P12         35.1             105         47.0
#> 812           South Alabama   SB         35.1             106         49.4
#> 813             Wake Forest  ACC         35.1             107         45.9
#> 814                     SMU Amer         35.0             108         51.9
#> 815        Northern Arizona BSky         35.0             109         45.8
#> 816            Missouri St.  MVC         35.0             110         55.2
#> 817                Syracuse  ACC         35.0             111         50.4
#> 818              Vanderbilt  SEC         34.9             112         50.2
#> 819      East Tennessee St.   SC         34.9             113         49.0
#> 820               Boise St.  MWC         34.9             114         52.2
#> 821                 Houston Amer         34.8             115         49.0
#> 822            Georgia Tech  ACC         34.8             116         55.1
#> 823                  Furman   SC         34.8             117         60.8
#> 824                Richmond  A10         34.8             118         53.5
#> 825                  Denver  Sum         34.8             119         48.6
#> 826          Louisiana Tech CUSA         34.8             120         49.6
#> 827             Saint Louis  A10         34.8             121         51.3
#> 828         Sam Houston St. Slnd         34.8             122         49.1
#> 829                     LSU  SEC         34.7             123         52.4
#> 830                 Belmont  OVC         34.7             124         59.4
#> 831             Utah Valley  WAC         34.7             125         51.2
#> 832        Northwestern St. Slnd         34.7             126         47.3
#> 833                    Iona MAAC         34.6             127         49.9
#> 834            UMass Lowell   AE         34.6             128         50.8
#> 835            Northwestern  B10         34.6             129         49.1
#> 836                  Howard MEAC         34.6             130         50.4
#> 837        Jacksonville St.  OVC         34.6             130         52.6
#> 838                Longwood BSth         34.6             132         48.7
#> 839        Western Kentucky CUSA         34.5             133         49.9
#> 840                    UNLV  MWC         34.5             134         49.8
#> 841                 Clemson  ACC         34.5             135         48.6
#> 842             Georgia St.   SB         34.5             136         51.0
#> 843              St. John's   BE         34.5             137         49.7
#> 844                 Vermont   AE         34.4             138         54.4
#> 845                   Siena MAAC         34.4             139         52.2
#> 846                   IUPUI Horz         34.4             140         47.3
#> 847         St. Bonaventure  A10         34.4             141         48.9
#> 848        UC Santa Barbara   BW         34.3             142         53.2
#> 849        Coastal Carolina   SB         34.3             143         48.6
#> 850         Mississippi St.  SEC         34.3             143         49.7
#> 851                  Temple Amer         34.2             145         43.8
#> 852                Ball St.  MAC         34.2             146         51.4
#> 853          Washington St.  P12         34.1             147         45.7
#> 854                Oklahoma  B12         34.1             148         50.6
#> 855                   Idaho BSky         34.1             149         47.4
#> 856        North Dakota St.  Sum         34.1             150         49.9
#> 857                Lipscomb ASun         34.1             151         51.2
#> 858                    UMBC   AE         34.1             152         49.8
#> 859          UNC Wilmington  CAA         34.0             153         47.2
#> 860             Jackson St. SWAC         34.0             154         41.8
#> 861            Illinois St.  MVC         34.0             155         50.0
#> 862           San Francisco  WCC         34.0             156         51.5
#> 863        Louisiana Monroe   SB         34.0             157         46.5
#> 864                 Buffalo  MAC         33.9             158         51.3
#> 865             New Orleans Slnd         33.9             159         52.8
#> 866             USC Upstate BSth         33.9             160         47.7
#> 867              Pittsburgh  ACC         33.9             161         47.8
#> 868             Wichita St. Amer         33.8             162         44.6
#> 869             Indiana St.  MVC         33.8             163         47.9
#> 870                Penn St.  B10         33.8             164         45.8
#> 871                     TCU  B12         33.8             165         49.5
#> 872     Cal St. Bakersfield   BW         33.8             166         47.6
#> 873                Portland  WCC         33.8             167         43.6
#> 874        Loyola Marymount  WCC         33.8             168         52.2
#> 875            North Dakota  Sum         33.7             169         48.7
#> 876                  Albany   AE         33.7             170         50.5
#> 877                La Salle  A10         33.6             171         49.9
#> 878                Kentucky  SEC         33.6             172         45.5
#> 879                  Kansas  B12         33.6             173         48.9
#> 880          Nebraska Omaha  Sum         33.5             174         44.8
#> 881             Connecticut   BE         33.5             175         48.3
#> 882      Cal St. Northridge   BW         33.5             176         47.2
#> 883                Kent St.  MAC         33.5             177         51.3
#> 884        Mount St. Mary's  NEC         33.4             178         47.7
#> 885           Southern Utah BSky         33.4             179         54.0
#> 886                   Akron  MAC         33.4             180         52.7
#> 887             Arizona St.  P12         33.3             181         48.8
#> 888           Grambling St. SWAC         33.3             181         46.9
#> 889         Houston Baptist Slnd         33.3             181         47.9
#> 890           James Madison  CAA         33.3             181         50.9
#> 891                  Purdue  B10         33.3             181         51.7
#> 892  Texas A&M Corpus Chris Slnd         33.3             181         45.1
#> 893                 Oakland Horz         33.3             187         47.7
#> 894             Austin Peay  OVC         33.3             188         50.6
#> 895               Green Bay Horz         33.3             189         48.8
#> 896        Western Carolina   SC         33.2             190         53.2
#> 897              Washington  P12         33.2             191         48.3
#> 898                 Hampton BSth         33.2             192         49.3
#> 899                Utah St.  MWC         33.2             193         49.8
#> 900        Tennessee Martin  OVC         33.2             194         43.3
#> 901                Arkansas  SEC         33.2             195         51.2
#> 902                Nebraska  B10         33.2             196         47.1
#> 903        Western Michigan  MAC         33.2             197         49.0
#> 904            Oklahoma St.  B12         33.2             198         51.9
#> 905          St. Francis NY  NEC         33.1             199         49.4
#> 906                    Elon  CAA         33.1             200         47.3
#> 907               Tennessee  SEC         33.1             201         49.6
#> 908  North Carolina Central MEAC         33.1             202         45.3
#> 909                    UTSA CUSA         33.1             203         49.2
#> 910              Binghamton   AE         33.1             204         48.3
#> 911               Air Force  MWC         33.0             205         54.1
#> 912          Boston College  ACC         33.0             206         50.1
#> 913           North Alabama ASun         33.0             207         47.3
#> 914                Bucknell  Pat         33.0             208         53.6
#> 915                 Hofstra  CAA         33.0             209         51.7
#> 916            Sacred Heart  NEC         32.9             210         47.1
#> 917                     VCU  A10         32.9             211         51.7
#> 918              Morgan St. MEAC         32.9             212         48.2
#> 919              Pepperdine  WCC         32.9             213         52.3
#> 920              California  P12         32.9             214         49.5
#> 921  Mississippi Valley St. SWAC         32.9             215         38.3
#> 922               UC Irvine   BW         32.9             216         46.7
#> 923               Milwaukee Horz         32.9             217         49.7
#> 924             The Citadel   SC         32.8             218         53.8
#> 925                    UTEP CUSA         32.8             219         46.5
#> 926        Illinois Chicago Horz         32.7             220         50.2
#> 927                     FIU CUSA         32.7             221         51.9
#> 928               Charlotte CUSA         32.7             222         49.3
#> 929            George Mason  A10         32.7             223         48.5
#> 930                    Navy  Pat         32.6             224         50.6
#> 931                  Auburn  SEC         32.6             225         53.1
#> 932              Fresno St.  MWC         32.6             226         48.7
#> 933           Massachusetts  A10         32.6             227         50.9
#> 934        Middle Tennessee CUSA         32.5             228         43.1
#> 935                  Xavier   BE         32.5             229         54.3
#> 936                Missouri  SEC         32.5             230         52.0
#> 937           South Florida Amer         32.4             231         43.3
#> 938        Eastern Illinois  OVC         32.4             232         49.7
#> 939       Northern Illinois  MAC         32.4             233         42.8
#> 940     Central Connecticut  NEC         32.4             234         48.5
#> 941       George Washington  A10         32.4             235         50.4
#> 942                 Indiana  B10         32.4             236         48.5
#> 943              Quinnipiac MAAC         32.4             237         45.7
#> 944                 Georgia  SEC         32.3             238         51.8
#> 945                  Butler   BE         32.3             239         46.8
#> 946                Southern SWAC         32.3             240         47.8
#> 947           Saint Peter's MAAC         32.3             241         44.1
#> 948                Hartford   AE         32.3             242         51.1
#> 949               Marquette   BE         32.3             242         51.9
#> 950                    Army  Pat         32.3             244         54.1
#> 951           Northern Iowa  MVC         32.2             245         51.1
#> 952       Stephen F. Austin Slnd         32.2             246         57.1
#> 953        Central Michigan  MAC         32.2             247         48.8
#> 954                Stanford  P12         32.2             248         52.8
#> 955           Cleveland St. Horz         32.1             249         51.7
#> 956          Tennessee Tech  OVC         32.1             250         51.6
#> 957              Seton Hall   BE         32.1             251         51.1
#> 958            Michigan St.  B10         32.1             252         48.1
#> 959                Iowa St.  B12         32.1             253         48.0
#> 960             Montana St. BSky         32.0             254         50.5
#> 961              Providence   BE         32.0             255         48.5
#> 962          New Mexico St.  WAC         31.9             256         50.8
#> 963                UC Davis   BW         31.9             257         48.3
#> 964       Boston University  Pat         31.9             258         50.8
#> 965      South Carolina St. MEAC         31.9             259         43.2
#> 966            Nicholls St. Slnd         31.8             260         53.0
#> 967            Grand Canyon  WAC         31.8             261         55.2
#> 968          North Carolina  ACC         31.8             262         48.5
#> 969                  Wagner  NEC         31.8             263         49.7
#> 970        Western Illinois  Sum         31.8             264         44.6
#> 971                 Seattle  WAC         31.8             265         45.6
#> 972           New Hampshire   AE         31.8             266         44.0
#> 973         Appalachian St.   SB         31.7             267         46.4
#> 974             Alabama St. SWAC         31.7             268         41.3
#> 975               Merrimack  NEC         31.7             269         54.1
#> 976           Bowling Green  MAC         31.6             270         47.7
#> 977                  Lehigh  Pat         31.6             271         47.0
#> 978            San Jose St.  MWC         31.6             272         42.9
#> 979                Cal Poly   BW         31.5             273         42.9
#> 980               Fairfield MAAC         31.5             274         44.4
#> 981                   Maine   AE         31.5             275         43.4
#> 982                  DePaul   BE         31.5             276         45.7
#> 983           Southern Miss CUSA         31.5             277         47.3
#> 984                 Bradley  MVC         31.4             278         51.6
#> 985                Delaware  CAA         31.4             279         51.0
#> 986          Saint Joseph's  A10         31.4             280         50.1
#> 987            Jacksonville ASun         31.4             281         49.9
#> 988             Florida A&M MEAC         31.4             282         49.2
#> 989                 Niagara MAAC         31.3             283         46.4
#> 990             Little Rock   SB         31.3             284         52.2
#> 991                   Lamar Slnd         31.2             285         45.7
#> 992            Rhode Island  A10         31.2             286         50.3
#> 993                 Rutgers  B10         31.2             287         51.7
#> 994        SIU Edwardsville  OVC         31.2             288         50.5
#> 995              Cincinnati Amer         31.1             289         49.4
#> 996            Delaware St. MEAC         31.1             290         45.0
#> 997                     UAB CUSA         31.1             290         49.4
#> 998     Charleston Southern BSth         31.1             292         46.4
#> 999                  Marist MAAC         31.0             293         50.8
#> 1000       Georgia Southern   SB         30.9             294         49.1
#> 1001         St. Francis PA  NEC         30.9             295         48.6
#> 1002         Youngstown St. Horz         30.9             296         50.1
#> 1003                Radford BSth         30.9             297         52.9
#> 1004             Louisville  ACC         30.8             298         48.4
#> 1005    Arkansas Pine Bluff SWAC         30.8             299         41.9
#> 1006      Northern Kentucky Horz         30.7             300         53.7
#> 1007              Loyola MD  Pat         30.6             301         53.4
#> 1008       Eastern Michigan  MAC         30.6             302         47.2
#> 1009                   NJIT   AE         30.5             303         46.0
#> 1010         South Carolina  SEC         30.5             304         47.2
#> 1011       Prairie View A&M SWAC         30.4             305         53.0
#> 1012              San Diego  WCC         30.4             306         46.8
#> 1013     North Carolina A&T MEAC         30.4             307         45.4
#> 1014           Presbyterian BSth         30.3             308         47.3
#> 1015             Coppin St. MEAC         30.3             309         51.6
#> 1016              Idaho St. BSky         30.2             310         48.3
#> 1017             Alcorn St. SWAC         30.1             311         44.0
#> 1018            Mississippi  SEC         30.0             312         50.3
#> 1019                  Tulsa Amer         30.0             313         51.6
#> 1020             Kansas St.  B12         30.0             314         48.8
#> 1021              Texas A&M  SEC         29.9             315         49.4
#> 1022            Santa Clara  WCC         29.9             316         49.0
#> 1023         UNC Greensboro   SC         29.9             317         49.9
#> 1024               Duquesne  A10         29.9             318         49.3
#> 1025                 Tulane Amer         29.8             319         44.0
#> 1026          East Carolina Amer         29.8             320         45.5
#> 1027             Valparaiso  MVC         29.7             321         48.9
#> 1028                Pacific  WCC         29.7             322         49.1
#> 1029              Dixie St.  WAC         29.7             323         45.9
#> 1030               Canisius MAAC         29.7             324         48.8
#> 1031               Miami FL  ACC         29.5             325         48.9
#> 1032           Kennesaw St. ASun         29.4             326         46.7
#> 1033           Saint Mary's  WCC         29.4             327         50.1
#> 1034           Old Dominion CUSA         29.4             328         50.6
#> 1035           Portland St. BSky         29.2             329         44.8
#> 1036            Stony Brook   AE         29.2             330         47.3
#> 1037 Southeastern Louisiana Slnd         29.2             331         46.5
#> 1038             High Point BSth         29.0             332         46.7
#> 1039                 Towson  CAA         28.9             333         46.2
#> 1040     Florida Gulf Coast ASun         28.9             334         51.0
#> 1041          Tennessee St.  OVC         28.8             335         49.1
#> 1042            Alabama A&M SWAC         28.8             336         45.5
#> 1043                    LIU  NEC         28.7             337         50.1
#> 1044         William & Mary  CAA         28.7             338         47.9
#> 1045              Minnesota  B10         28.4             339         46.7
#> 1046                Samford   SC         28.3             340         51.3
#> 1047                   Troy   SB         28.1             341         46.0
#> 1048         Texas Southern SWAC         27.7             342         50.0
#> 1049                Fordham  A10         26.9             343         42.2
#> 1050             New Mexico  MWC         26.8             344         45.5
#> 1051   UT Rio Grande Valley  WAC         26.7             345         44.7
#> 1052              Manhattan MAAC         26.4             346         44.4
#> 1053            Chicago St.  WAC         25.1             347         43.9
#> 1054        Bethune Cookman MEAC          0.0             348          0.0
#> 1055                  Brown  Ivy          0.0             348          0.0
#> 1056               Columbia  Ivy          0.0             348          0.0
#> 1057                Cornell  Ivy          0.0             348          0.0
#> 1058              Dartmouth  Ivy          0.0             348          0.0
#> 1059                Harvard  Ivy          0.0             348          0.0
#> 1060 Maryland Eastern Shore MEAC          0.0             348          0.0
#> 1061                   Penn  Ivy          0.0             348          0.0
#> 1062              Princeton  Ivy          0.0             348          0.0
#> 1063                   Yale  Ivy          0.0             348          0.0
#>      off_fg_2_pct_rk off_ft_pct off_ft_pct_rk off_blk_pct off_blk_pct_rk
#> 1                 96       77.4            10        10.3            260
#> 2                 43       71.0           165         7.5             44
#> 3                 11       77.3            11         8.9            148
#> 4                326       69.3           231         9.3            182
#> 5                141       73.6            81         9.3            176
#> 6                200       78.7             4        11.2            301
#> 7                 49       74.4            57         9.7            218
#> 8                 75       74.4            54         8.3             93
#> 9                 66       76.1            20        10.0            240
#> 10               100       71.6           151         9.0            149
#> 11               190       66.6           315         8.1             75
#> 12               187       75.7            26         8.9            145
#> 13                35       80.6             1         7.3             31
#> 14                39       73.0            97         8.4            104
#> 15               222       74.7            45         6.3              8
#> 16               321       71.7           146         7.7             54
#> 17               175       64.5           335         7.6             50
#> 18                14       75.1            37         7.4             38
#> 19               111       74.2            61        11.4            311
#> 20                98       71.7           144        10.8            289
#> 21               103       71.3           157        12.1            338
#> 22               130       65.9           325         9.9            233
#> 23               179       77.1            12         8.1             76
#> 24               182       70.9           168         9.4            191
#> 25               181       74.9            43         8.8            134
#> 26               244       75.8            25         9.8            227
#> 27               281       68.2           266         7.1             24
#> 28                88       74.4            53         9.5            201
#> 29                17       68.1           273        10.8            285
#> 30               145       72.9            98         9.2            173
#> 31                38       75.3            31         8.4            108
#> 32                84       74.2            63         9.2            171
#> 33                48       71.6           148         8.9            136
#> 34                55       71.7           145        10.1            250
#> 35               243       72.4           113        11.5            320
#> 36                14       69.5           217         8.3             96
#> 37               204       71.9           134         8.0             71
#> 38               132       74.1            69         6.9             18
#> 39               302       72.6           107         8.8            130
#> 40               136       70.8           172         8.3             94
#> 41                44       76.0            22        10.6            277
#> 42               239       76.0            21         8.9            141
#> 43               127       68.5           256         8.6            118
#> 44               108       71.9           137        11.6            322
#> 45                64       72.7           103         7.8             60
#> 46               318       68.9           246        10.4            264
#> 47                13       69.9           198         9.0            151
#> 48               303       69.1           236         7.4             39
#> 49               133       68.2           270        14.3            351
#> 50               327       77.1            13        10.8            287
#> 51               315       71.6           147         9.3            185
#> 52               205       72.0           131         9.7            217
#> 53                34       70.6           177        13.2            348
#> 54                 3       73.5            84        10.2            254
#> 55               228       67.1           300        13.2            347
#> 56               155       67.5           292        10.0            236
#> 57               328       73.0            96         6.1              6
#> 58                 8       78.2             6         9.3            178
#> 59                85       66.9           304        14.4            352
#> 60               317       71.6           150         7.2             30
#> 61                24       66.7           314        12.8            345
#> 62                91       76.8            15        10.0            237
#> 63                22       75.8            24         6.4             11
#> 64                53       72.3           118        11.7            327
#> 65               276       72.3           122         9.3            179
#> 66               278       69.4           225        10.9            293
#> 67               336       67.4           293        10.4            268
#> 68               226       68.0           280        10.3            261
#> 69                69       73.2            92         7.0             19
#> 70               106       73.3            91         7.8             59
#> 71                94       64.9           330         8.1             77
#> 72                12       73.5            83         7.8             62
#> 73               116       73.9            73         7.9             65
#> 74               157       69.8           207         8.0             73
#> 75               292       60.2           351         8.2             82
#> 76               110       75.5            27         7.9             66
#> 77                 1       76.1            19         5.8              2
#> 78               267       70.3           184        11.3            307
#> 79               147       68.5           259        10.2            255
#> 80               216       68.0           282         8.9            138
#> 81                25       73.2            95         7.4             41
#> 82               260       76.3            16         7.2             28
#> 83               297       69.0           240         9.1            162
#> 84                92       74.3            60        11.0            297
#> 85               194       71.2           161         8.4            103
#> 86               169       73.4            88         8.2             81
#> 87                71       72.1           126         8.5            109
#> 88               174       63.7           342         7.0             21
#> 89               154       73.7            78        11.9            334
#> 90               201       68.9           245         6.4             12
#> 91                27       67.1           303        11.6            323
#> 92                 7       72.3           121        11.5            319
#> 93               105       74.9            42         8.8            132
#> 94               316       73.6            82         8.6            119
#> 95                26       66.3           322         9.2            163
#> 96               183       70.6           179         7.2             26
#> 97               198       64.8           332        10.8            290
#> 98                72       78.3             5         9.8            224
#> 99               233       67.4           294         7.5             42
#> 100              152       71.9           135         6.4              9
#> 101               59       75.9            23         9.5            200
#> 102               40       75.0            40         9.4            192
#> 103              296       71.8           141        10.1            251
#> 104               70       75.2            34         7.6             47
#> 105              162       71.4           154         9.3            185
#> 106              257       72.0           130         7.3             33
#> 107               28       65.5           327         7.0             22
#> 108              337       74.4            55        11.2            303
#> 109              298       73.3            90         8.4            106
#> 110              203       73.7            79         9.1            160
#> 111              118       63.3           343         8.6            117
#> 112              119       70.3           185         6.4             13
#> 113               45       65.7           326        10.8            291
#> 114               68       73.9            71         7.8             57
#> 115              159       69.4           219         8.7            122
#> 116              269       72.4           114        11.4            316
#> 117               77       66.7           310         7.9             64
#> 118              114       73.8            76        10.7            278
#> 119              312       72.8           101         8.3             99
#> 120              307       71.2           160        11.8            330
#> 121              135       75.5            28        10.3            262
#> 122               52       74.2            67         7.7             55
#> 123              259       69.8           204        10.0            242
#> 124              104       70.8           172        10.1            253
#> 125               21       69.1           238         6.8             15
#> 126               46       72.8           100         8.8            135
#> 127               32       72.7           102         8.0             72
#> 128               57       74.5            48        11.2            303
#> 129               56       74.9            41         9.2            167
#> 130              113       80.5             2        10.0            243
#> 131              254       67.9           284        10.3            263
#> 132              107       72.1           127         8.0             70
#> 133               16       66.7           312         8.3             95
#> 134              211       73.2            94         6.2              7
#> 135              208       69.3           229        10.7            280
#> 136              314       74.2            64         7.6             49
#> 137               97       69.5           215         7.6             46
#> 138               73       70.5           182         8.9            142
#> 139              178       68.1           273        10.4            266
#> 140              301       72.3           120         8.7            127
#> 141               87       69.8           205         7.2             25
#> 142               10       73.4            89         9.5            202
#> 143              146       74.3            59         9.8            228
#> 144              345       66.3           321         6.8             14
#> 145               42       69.4           222         9.4            188
#> 146               78       74.8            44        10.0            241
#> 147              168       77.5             9         7.5             43
#> 148               50       69.8           201        10.5            270
#> 149              210       71.8           140         8.3             91
#> 150              195       69.9           200        10.1            248
#> 151              196       71.8           138        10.3            258
#> 152              227       72.5           112         9.1            155
#> 153              291       74.5            50        12.2            339
#> 154               29       70.8           170         7.4             40
#> 155               65       64.1           337         8.6            116
#> 156               20       66.1           323         9.6            204
#> 157              143       75.3            33         9.6            208
#> 158              220       70.5           181         8.3             98
#> 159               90       69.3           227         7.3             35
#> 160              165       74.0            70        10.4            265
#> 161               83       68.2           271        10.6            271
#> 162              197       69.7           209         9.5            198
#> 163              286       72.1           128         9.4            193
#> 164              160       66.8           308         9.0            152
#> 165              250       70.2           188         9.7            211
#> 166              262       70.0           195         9.7            213
#> 167              245       69.2           233         9.8            223
#> 168              270       70.4           183         9.4            189
#> 169              115       69.8           208         7.7             53
#> 170              123       71.8           142         9.5            203
#> 171              156       68.0           281         8.7            125
#> 172              253       73.7            77         9.3            184
#> 173               54       72.7           105         7.6             51
#> 174               23       71.7           143        10.4            269
#> 175               82       72.2           123         7.3             34
#> 176              101       70.1           190         9.6            205
#> 177              161       77.7             8        10.6            272
#> 178              242       69.7           212         9.4            187
#> 179              255       72.4           117         9.8            229
#> 180               37       68.4           263         8.2             86
#> 181              171       70.2           189        11.4            313
#> 182              131       67.7           288        12.6            341
#> 183              140       66.7           311         9.7            219
#> 184              277       79.6             3         9.0            150
#> 185              199       73.4            87         9.2            174
#> 186              173       61.6           348         9.1            159
#> 187               99       71.0           166        11.5            317
#> 188              280       69.4           223         8.9            146
#> 189              126       71.5           152         7.7             56
#> 190              191       75.4            29         8.3             99
#> 191              122       69.5           216         9.3            175
#> 192              289       67.8           287         9.4            196
#> 193              192       66.6           316        11.7            328
#> 194              153       74.4            51         8.0             69
#> 195              246       63.7           340         9.6            209
#> 196               93       68.0           283         8.2             83
#> 197               60       68.7           251         9.8            230
#> 198                5       67.6           291         6.0              4
#> 199              117       68.8           248         9.2            170
#> 200              202       73.6            80        11.0            298
#> 201              306       74.2            68         9.5            197
#> 202              128       68.6           253        11.4            314
#> 203              112       69.7           210         8.1             74
#> 204              311       69.8           203         8.7            124
#> 205               30       75.4            30         7.0             20
#> 206              180       72.1           129         9.8            221
#> 207                9       76.1            18         8.1             79
#> 208              215       66.0           324        10.2            256
#> 209              235       68.5           261         6.9             17
#> 210              189       71.4           154        10.9            295
#> 211              170       72.3           119        11.9            331
#> 212              231       69.1           237         9.8            222
#> 213               18       68.4           264         8.6            120
#> 214              251       71.9           135        10.6            274
#> 215              149       68.0           279         8.7            123
#> 216              288       70.7           175        13.5            349
#> 217              346       62.5           346         9.7            220
#> 218              221       72.6           108         8.3             99
#> 219               41       73.9            72        11.8            329
#> 220              279       68.5           257        10.8            284
#> 221              230       66.7           313         8.2             84
#> 222              212       67.1           301         9.9            234
#> 223              238       69.4           220         9.8            231
#> 224              205       72.1           125         9.2            165
#> 225              284       69.5           218        10.6            276
#> 226              121       73.5            85         8.7            121
#> 227              240       64.4           336        12.8            346
#> 228              271       68.5           255         8.3             97
#> 229              213       68.5           260         9.9            232
#> 230              102       72.4           115         6.0              5
#> 231                2       69.0           239         8.1             78
#> 232              144       74.4            52         8.4            102
#> 233              325       58.4           353        12.0            336
#> 234              247       70.7           176         9.1            157
#> 235               76       72.9            99         8.1             80
#> 236               31       67.9           285         8.9            144
#> 237              293       69.7           211        15.1            353
#> 238              331       77.0            14         9.7            210
#> 239              349       70.0           196        12.0            335
#> 240               33       72.7           106         7.2             27
#> 241              339       68.9           241         8.9            143
#> 242              163       70.0           194        11.6            324
#> 243              185       72.7           104         6.8             16
#> 244              164       71.6           149        10.8            288
#> 245              343       65.1           329         8.2             88
#> 246               80       71.8           139        11.5            318
#> 247              322       66.3           320        11.3            308
#> 248              109       73.2            93         8.3             92
#> 249              323       78.1             7        10.4            267
#> 250              256       74.2            66         7.6             48
#> 251              177       72.4           116         9.6            206
#> 252              223       72.2           124         7.5             45
#> 253              268       69.9           197         5.8              1
#> 254              225       70.8           171        10.0            244
#> 255              290       76.2            17         7.3             32
#> 256              217       70.1           190        10.8            283
#> 257              275       69.1           235         8.4            105
#> 258              266       72.0           132        10.9            294
#> 259              229       66.8           307         9.2            166
#> 260              125       67.3           295         8.4            107
#> 261              351       61.3           349         9.4            195
#> 262               19       69.8           206         9.2            172
#> 263                6       70.2           186         7.8             58
#> 264              218       71.2           159        11.9            333
#> 265              148       68.2           267        11.2            300
#> 266              234       72.6           109         9.3            181
#> 267              304       74.3            58         8.7            128
#> 268              158       70.6           178        11.7            326
#> 269               61       68.0           277         8.2             87
#> 270               95       69.2           232         9.3            180
#> 271              249       60.9           350        10.6            273
#> 272               79       75.3            32         9.1            156
#> 273              214       68.2           269        11.4            310
#> 274              236       71.0           164        10.7            279
#> 275              324       66.9           305         9.3            177
#> 276              305       73.8            74         9.8            225
#> 277              272       70.2           187         9.8            226
#> 278              129       69.4           224        11.2            302
#> 279              261       75.1            36         7.4             37
#> 280               51       70.1           192         8.8            133
#> 281               74       71.4           156        11.4            312
#> 282              134       70.5           180         9.0            153
#> 283               89       66.8           306         9.3            183
#> 284              338       64.8           331         9.9            235
#> 285              294       71.1           162        10.3            259
#> 286               36       74.2            64         7.7             52
#> 287              300       64.5           334        10.2            257
#> 288              282       69.3           226         9.2            168
#> 289              263       71.0           167         9.1            161
#> 290               67       75.2            35         7.9             67
#> 291              340       67.3           297        10.9            296
#> 292              295       68.9           243         9.7            214
#> 293              137       68.1           276        12.5            340
#> 294              224       69.8           202         8.6            114
#> 295              166       67.1           302        12.6            343
#> 296              308       71.5           153        11.9            332
#> 297               58       67.2           298         8.8            129
#> 298              332       75.1            38        11.4            309
#> 299              232       71.3           158         8.6            115
#> 300              241       68.2           272        10.9            292
#> 301              176       75.0            39         9.4            194
#> 302              274       68.8           249        10.0            239
#> 303              120       70.8           174        10.8            286
#> 304              329       74.4            56         8.6            113
#> 305              333       62.7           345         8.9            139
#> 306              352       69.4           221         8.5            110
#> 307              207       69.6           213         8.8            131
#> 308              319       69.6           214         8.9            147
#> 309              310       73.5            86         9.6            207
#> 310              335       66.5           317         8.3             90
#> 311               63       65.5           328        10.1            252
#> 312              285       63.7           341         8.9            139
#> 313              237       67.6           289         9.7            212
#> 314              138       67.2           299         8.7            126
#> 315              186       67.3           296        11.3            306
#> 316              330       68.5           258         9.1            158
#> 317              219       74.2            62        12.8            344
#> 318               81       74.7            46         5.9              3
#> 319              287       72.5           111        10.6            275
#> 320              299       67.6           290         7.2             29
#> 321              350       66.3           319        10.1            246
#> 322              334       67.8           286         9.2            169
#> 323              124       71.9           133         8.3             89
#> 324              184       69.9           199         8.5            111
#> 325              193       63.9           339         7.3             36
#> 326              172       71.1           163         7.1             23
#> 327                4       68.6           252         8.0             68
#> 328              344       72.5           110        11.7            325
#> 329              139       69.3           230        12.6            342
#> 330              150       68.9           244         9.5            199
#> 331              209       69.3           228        10.1            247
#> 332               62       70.1           193         7.9             63
#> 333              258       73.8            75        11.4            315
#> 334              347       68.9           242         8.2             85
#> 335              283       59.8           352        10.1            249
#> 336              273       69.2           234         7.8             61
#> 337              142       68.8           247        10.7            281
#> 338              252       74.5            49        11.2            305
#> 339              348       74.6            47        10.0            237
#> 340              167       61.9           347         9.2            164
#> 341              248       70.8           169         9.0            154
#> 342              342       68.1           275        13.5            350
#> 343              151       63.1           344         6.4             10
#> 344              309       68.6           254         9.7            215
#> 345               86       64.8           333        12.1            337
#> 346               47       66.8           309        10.8            282
#> 347              353       68.3           265        11.5            321
#> 348              265       66.5           318         8.5            112
#> 349              264       68.2           268         9.7            216
#> 350              313       68.4           262        11.0            299
#> 351              188       68.0           278         8.9            137
#> 352              341       68.8           250         9.4            190
#> 353              320       64.0           338        10.1            245
#> 354               15       69.7           219         7.0             29
#> 355              100       70.0           215         9.6            254
#> 356              210       78.5             9         8.7            154
#> 357               48       75.3            43         7.2             42
#> 358               78       75.4            39         8.9            191
#> 359               40       74.9            59         9.4            237
#> 360                2       68.8           251         6.9             25
#> 361               52       75.6            37         7.4             57
#> 362              173       75.3            42         7.5             61
#> 363              276       74.3            76         9.4            243
#> 364               40       77.3            15         5.8              4
#> 365               59       76.5            23        10.4            294
#> 366              288       78.8             6        10.9            317
#> 367              216       70.1           210        10.2            291
#> 368              142       73.1           101         9.0            203
#> 369              182       71.3           170         7.5             70
#> 370               18       76.9            20        10.7            312
#> 371               30       67.3           293         9.6            256
#> 372               60       69.7           223         8.9            182
#> 373              196       78.6             8         7.0             31
#> 374               68       70.3           204        11.3            328
#> 375              175       72.6           119         8.1            103
#> 376              159       75.2            46         9.6            253
#> 377               22       72.2           137         8.4            127
#> 378              303       75.2            48         9.7            266
#> 379              289       73.4            92         7.2             40
#> 380                1       72.0           142         7.9             85
#> 381               20       79.2             4         7.3             49
#> 382              109       72.4           121         8.8            172
#> 383               49       71.9           145         9.5            249
#> 384               43       67.9           270         7.6             71
#> 385               27       70.9           184        11.7            338
#> 386               72       76.2            29         9.1            207
#> 387              245       74.5            71         9.8            270
#> 388               86       70.4           198         9.6            260
#> 389              202       76.3            26         6.3              9
#> 390              338       79.6             2         7.2             39
#> 391               96       71.8           148         6.7             20
#> 392              144       68.9           249         8.2            107
#> 393              224       74.7            65        11.0            323
#> 394              161       76.9            19         8.5            134
#> 395               44       77.6            14         8.4            128
#> 396              164       67.6           285         9.6            262
#> 397              130       75.1            50         8.4            131
#> 398                9       65.1           325        10.4            298
#> 399               90       75.9            34        10.3            293
#> 400              272       70.0           213         8.2            109
#> 401              220       74.4            72         9.8            272
#> 402               50       65.3           323         8.0             95
#> 403               69       75.0            56         8.7            162
#> 404              233       76.2            31        11.4            331
#> 405               84       70.8           190         9.6            257
#> 406              158       72.1           139         8.7            157
#> 407              115       73.1            98         6.7             21
#> 408               28       73.4            93        11.4            333
#> 409               36       66.4           312         8.9            188
#> 410              116       75.4            41         9.1            216
#> 411              150       67.1           296         7.4             53
#> 412              108       70.4           196         9.8            271
#> 413                3       71.1           175         8.9            178
#> 414              292       63.5           340        13.0            349
#> 415              227       74.9            61         7.7             76
#> 416              198       70.7           191         9.4            242
#> 417              127       71.3           165         6.6             16
#> 418               64       66.3           314         7.9             87
#> 419              230       70.8           188         7.2             38
#> 420              305       69.1           247         6.9             24
#> 421              163       73.2            96         8.0             90
#> 422              147       72.4           123         7.3             47
#> 423              106       79.5             3         9.9            279
#> 424              219       76.4            24         9.6            261
#> 425                7       76.0            32         7.5             68
#> 426               58       64.5           332         8.8            170
#> 427              296       73.4            91        10.2            289
#> 428              241       72.9           109         7.3             50
#> 429               55       72.0           141         9.0            206
#> 430              229       71.1           178        10.4            297
#> 431               26       74.5            69         8.3            119
#> 432              178       68.6           256        12.5            345
#> 433              215       79.2             5         7.0             32
#> 434               91       75.0            54         7.5             62
#> 435               45       71.1           176         9.2            222
#> 436              189       73.6            89         8.6            147
#> 437              256       69.0           248        13.0            350
#> 438              265       74.7            67         9.4            236
#> 439              234       66.2           315         7.5             69
#> 440              136       76.3            28         9.0            198
#> 441               73       73.7            86         8.3            112
#> 442                6       71.4           162         5.8              3
#> 443              103       71.3           163         8.3            121
#> 444               71       69.3           235        12.4            343
#> 445              240       69.4           232         8.9            184
#> 446              152       74.1            81         8.7            163
#> 447                5       71.0           180         8.1             98
#> 448              352       67.9           272        10.9            319
#> 449               47       75.0            55         9.2            218
#> 450              206       70.5           195         9.9            281
#> 451              274       77.8            13         7.1             36
#> 452               67       72.3           128         7.0             27
#> 453              314       69.7           221         7.4             56
#> 454              101       75.0            58         9.9            276
#> 455               39       72.7           116         6.6             17
#> 456              217       69.6           224         8.7            158
#> 457              247       77.1            16         7.5             64
#> 458               33       71.3           166         7.0             30
#> 459              294       70.6           192         9.6            252
#> 460                4       70.4           197         9.2            221
#> 461              180       73.5            90         9.2            227
#> 462               25       63.4           342         9.7            269
#> 463               62       68.7           253         9.2            219
#> 464              333       70.8           187        12.0            342
#> 465              318       77.8            12         9.9            275
#> 466              271       68.1           266         7.7             75
#> 467              250       68.7           252         9.5            246
#> 468              126       79.7             1         7.7             81
#> 469              325       75.1            53         8.1            102
#> 470              110       74.9            60         7.3             43
#> 471              102       68.8           250         7.7             73
#> 472              336       74.8            62         8.8            176
#> 473               95       71.3           168        11.0            322
#> 474              345       72.3           127        12.9            348
#> 475              157       57.1           353         8.6            144
#> 476               46       72.8           114         9.0            202
#> 477              232       73.7            87         8.0             94
#> 478                8       70.9           182         8.8            164
#> 479              246       72.2           133         5.9              5
#> 480               70       64.6           331         8.5            137
#> 481              174       66.3           313         9.0            196
#> 482              123       74.5            70         6.8             22
#> 483              350       64.8           328         7.0             33
#> 484              201       67.1           297         6.4             11
#> 485               14       67.1           295         9.7            268
#> 486              221       73.1           100        11.7            335
#> 487              128       71.7           156         7.4             54
#> 488              179       71.3           163         7.5             67
#> 489              322       68.0           267         8.6            146
#> 490               76       72.4           124        10.4            295
#> 491               78       70.3           202        10.7            309
#> 492               81       70.3           200         8.4            133
#> 493               11       70.2           208         8.4            122
#> 494               24       71.7           154         7.3             48
#> 495              131       65.6           321         7.4             58
#> 496              327       67.6           279         8.7            153
#> 497              113       67.8           273         7.7             77
#> 498              186       72.3           126         8.3            115
#> 499               32       72.8           111         6.0              6
#> 500              194       71.7           153         8.3            110
#> 501              177       72.8           113         8.7            156
#> 502              207       69.1           243         9.9            280
#> 503              151       69.1           244        10.6            307
#> 504              301       64.7           330        10.2            287
#> 505              291       73.0           105         5.7              2
#> 506              300       67.7           275         7.7             80
#> 507               63       70.9           183         8.8            173
#> 508               87       75.2            47         7.1             35
#> 509              281       74.7            66         9.0            201
#> 510              275       66.5           309        11.9            340
#> 511               77       75.4            38         7.5             60
#> 512              270       72.2           132         9.4            241
#> 513               34       73.6            88         6.1              8
#> 514              320       73.8            85         9.6            251
#> 515               75       73.0           106        11.3            330
#> 516              290       69.2           236        11.1            324
#> 517              124       69.9           216         9.3            234
#> 518               61       71.5           158         8.8            175
#> 519              312       72.2           136         8.5            136
#> 520               65       71.4           161         8.6            149
#> 521              188       74.4            73         7.4             55
#> 522              154       68.5           260         9.6            255
#> 523              323       72.1           140         9.0            192
#> 524              298       71.2           171         9.2            223
#> 525               89       73.1           102         8.7            151
#> 526              268       71.7           150         8.5            140
#> 527              260       67.5           286        11.7            336
#> 528               99       76.4            25         8.7            159
#> 529               98       75.3            44         8.4            125
#> 530              133       69.7           222        13.0            351
#> 531               83       77.0            18         9.1            211
#> 532               74       78.7             7         8.7            155
#> 533              168       66.7           306         9.2            229
#> 534              279       66.7           307         7.5             59
#> 535              311       69.4           233         8.9            189
#> 536              264       71.5           160         9.0            205
#> 537              129       71.7           155         8.1            100
#> 538              309       66.7           305         9.1            209
#> 539              284       68.7           255         9.7            267
#> 540              334       66.7           304         8.9            180
#> 541               66       73.0           108         9.9            282
#> 542              213       70.8           186         8.9            177
#> 543              146       67.9           269         8.1            104
#> 544               93       74.0            82         8.3            114
#> 545               31       71.8           147         8.0             93
#> 546              190       70.1           209         6.4             10
#> 547               35       76.3            27         9.1            212
#> 548               56       70.1           211         6.7             18
#> 549               12       61.8           349         9.3            235
#> 550              317       69.7           218        10.8            314
#> 551               17       76.9            21         8.3            111
#> 552              187       73.3            95        10.1            284
#> 553              226       74.1            80        10.8            313
#> 554              262       71.2           174        11.0            321
#> 555               23       72.0           143         7.2             37
#> 556               13       66.4           310         9.2            217
#> 557              172       67.9           271         8.3            120
#> 558              145       69.2           237         8.6            143
#> 559              111       71.8           149        10.2            290
#> 560               97       72.2           134         6.1              7
#> 561              125       70.5           193        10.5            305
#> 562               38       75.1            52         8.8            165
#> 563              114       69.7           220         7.3             45
#> 564              120       68.5           261         8.9            183
#> 565               82       75.9            33         8.7            152
#> 566              266       72.4           122         9.1            213
#> 567              306       73.1            99         5.5              1
#> 568              258       74.2            78        10.1            285
#> 569              282       67.7           278         9.5            250
#> 570               10       63.8           337         9.0            193
#> 571               16       76.2            30         9.2            224
#> 572              149       71.1           179         7.3             46
#> 573              195       69.5           228         9.9            278
#> 574              228       65.2           324         9.8            273
#> 575               92       67.7           277         6.5             15
#> 576              341       78.2            10        10.4            301
#> 577              335       68.7           254        10.9            316
#> 578              261       66.4           311         9.2            228
#> 579              214       71.9           144         8.4            129
#> 580              135       70.8           189         9.9            274
#> 581               42       64.1           335         6.9             26
#> 582              167       69.2           240         6.5             14
#> 583              295       70.3           205         9.4            240
#> 584              332       70.3           201         9.6            259
#> 585              160       69.8           217        11.8            339
#> 586              162       65.1           326         9.4            239
#> 587              269       68.6           258         8.9            190
#> 588              141       67.6           282         8.8            166
#> 589              200       73.0           107        10.4            300
#> 590              238       74.3            75         8.5            135
#> 591              171       62.2           346         7.2             41
#> 592              112       69.2           241         9.6            258
#> 593              239       67.5           287        10.5            304
#> 594              185       72.8           112         7.5             63
#> 595               85       67.7           276        10.7            310
#> 596              117       67.4           289         9.4            244
#> 597               54       71.0           181         8.6            148
#> 598               29       70.3           202         9.2            230
#> 599              191       70.2           207         6.9             23
#> 600              199       75.7            36         8.8            168
#> 601              208       76.6            22         7.1             34
#> 602              223       73.0           103         9.0            200
#> 603              299       60.3           351        13.7            353
#> 604              183       72.2           130        10.8            315
#> 605              347       66.2           316         8.4            123
#> 606              176       75.2            49         8.2            108
#> 607              225       66.8           303         8.5            141
#> 608              169       75.9            35        11.5            334
#> 609              313       70.0           214         7.7             74
#> 610              119       71.2           172         8.6            142
#> 611              331       66.9           300        11.4            332
#> 612              337       69.5           229        10.1            283
#> 613              293       70.9           185         8.9            179
#> 614               80       66.7           307         8.0             91
#> 615              104       74.6            68         7.9             89
#> 616              339       72.4           125         7.5             65
#> 617              285       67.6           280         7.6             72
#> 618              165       69.6           227         8.9            181
#> 619              236       73.4            94         9.0            194
#> 620               53       68.6           257         8.3            113
#> 621              155       68.4           262         9.2            225
#> 622              153       74.1            79        10.4            296
#> 623              107       74.3            77        11.3            329
#> 624              328       71.5           159         7.3             44
#> 625              254       75.1            51         8.9            186
#> 626              297       67.0           298         7.0             28
#> 627              304       72.3           129         8.8            174
#> 628              222       67.6           281         8.7            160
#> 629              243       66.1           317        12.0            341
#> 630              148       75.0            56         8.8            169
#> 631              315       69.2           242        10.5            303
#> 632              273       73.1            97         8.9            185
#> 633              343       77.0            17         8.4            132
#> 634              251       69.6           225         8.8            171
#> 635              138       65.8           319         8.7            150
#> 636              156       72.2           138         9.1            208
#> 637              212       65.7           320         8.9            187
#> 638               88       67.5           288         7.8             83
#> 639              139       74.7            64        10.9            318
#> 640              105       67.3           292         9.0            199
#> 641              263       71.7           152         9.5            247
#> 642              170       62.8           344         8.4            130
#> 643              267       68.3           264         8.5            139
#> 644              326       62.1           348         9.1            214
#> 645              259       68.5           259         9.1            210
#> 646              286       65.0           327         9.7            265
#> 647              319       74.3            74        10.1            286
#> 648              143       64.5           333         9.0            204
#> 649              287       65.9           318         9.3            233
#> 650              235       69.5           231         9.7            263
#> 651              316       67.6           283         9.3            231
#> 652               51       65.4           322         8.7            161
#> 653               57       70.1           212         6.4             13
#> 654               37       67.4           290         9.3            232
#> 655              278       72.7           115         9.0            197
#> 656              310       71.1           176         9.7            264
#> 657              329       68.0           268         9.4            238
#> 658              324       72.5           120         6.4             12
#> 659              283       68.2           265         9.4            245
#> 660              342       73.8            84        11.7            337
#> 661              203       69.1           246         9.9            277
#> 662              209       75.2            45         9.2            219
#> 663              166       72.6           117         8.1            105
#> 664              249       71.7           151         8.6            145
#> 665              344       62.2           347        10.7            311
#> 666              231       71.2           173         7.8             84
#> 667               94       71.6           157        11.2            326
#> 668              137       69.6           226         7.4             52
#> 669              134       67.0           299         8.2            106
#> 670              118       72.6           118         7.3             51
#> 671              132       63.7           338         9.0            195
#> 672               19       70.3           205         9.1            215
#> 673              205       67.6           284         8.1            101
#> 674              244       67.4           291         8.5            138
#> 675              192       72.2           131         6.7             19
#> 676              193       75.4            40         8.0             92
#> 677              277       72.8           110        10.5            302
#> 678              211       70.5           194        13.1            352
#> 679              204       78.0            11        10.4            299
#> 680               21       68.3           263        10.3            292
#> 681              308       71.8           146         7.7             79
#> 682              218       60.9           350         8.0             96
#> 683              321       71.3           167        11.0            320
#> 684              237       67.8           274        12.6            346
#> 685              351       64.8           329         7.7             77
#> 686              121       69.1           245         8.4            124
#> 687              257       69.2           239        12.7            347
#> 688              307       69.2           237         9.5            248
#> 689              253       73.0           104         7.8             82
#> 690              280       74.0            83        10.2            288
#> 691              242       64.2           334         8.1             99
#> 692              346       69.5           230         8.3            116
#> 693              330       66.9           301        11.3            327
#> 694              302       63.5           341         8.3            118
#> 695              181       71.3           169         7.9             88
#> 696              184       63.6           339         8.0             97
#> 697              348       67.2           294        11.1            325
#> 698              248       74.8            63         9.2            226
#> 699              197       72.2           135         8.3            117
#> 700              252       69.4           234         8.8            167
#> 701              122       63.8           336        12.5            344
#> 702              140       62.4           345         8.4            126
#> 703              340       58.5           352         7.5             66
#> 704              255       66.9           302         7.9             86
#> 705              349       63.1           343        10.6            308
#> 706              353       70.4           199        10.6            306
#> 707               48       70.8           186        10.6            291
#> 708               36       71.6           154         8.1            130
#> 709               28       72.3           129         7.4             64
#> 710                7       68.9           239         7.2             48
#> 711              142       73.3            90         6.9             32
#> 712              195       71.9           142         7.6             84
#> 713               79       80.4             5         8.3            144
#> 714              132       78.4            14         6.1              9
#> 715               10       77.7            22         7.9            106
#> 716               64       71.5           160         8.3            147
#> 717              252       70.3           203         9.7            247
#> 718              301       69.9           217         9.6            236
#> 719               44       76.9            27         7.4             67
#> 720              240       73.7            78         9.2            209
#> 721              177       70.5           198         7.8            100
#> 722              114       76.0            40        10.1            268
#> 723              245       67.8           269         5.5              4
#> 724               59       71.1           173         7.6             78
#> 725              154       71.8           144         8.5            154
#> 726              154       82.2             1         9.6            243
#> 727               63       74.1            70         7.3             51
#> 728              259       68.1           259         8.6            170
#> 729              182       71.2           166         8.8            177
#> 730               23       81.6             3         7.6             90
#> 731              308       74.2            65        11.8            333
#> 732              319       72.4           128        11.2            323
#> 733               15       67.7           272         7.3             54
#> 734               22       76.5            31         7.8             98
#> 735               69       78.0            18         8.5            156
#> 736               14       69.0           236         9.3            225
#> 737              171       66.1           308        10.6            297
#> 738              321       70.8           191        10.5            287
#> 739              137       81.9             2         8.1            122
#> 740               16       71.3           163         9.7            249
#> 741              144       71.5           158         7.3             58
#> 742               65       74.6            62         9.0            196
#> 743              238       72.7           111         7.0             39
#> 744               94       71.0           177        10.7            302
#> 745              145       70.6           195         8.1            132
#> 746               81       78.0            19         8.9            185
#> 747               72       76.5            30         8.8            179
#> 748               40       72.4           125         5.2              1
#> 749               25       60.7           342         9.3            218
#> 750              136       71.5           159         8.8            181
#> 751                1       73.1            97         6.8             26
#> 752               57       77.3            26        11.8            336
#> 753               24       73.0            98         5.6              5
#> 754              286       78.9            11         8.4            151
#> 755               37       72.1           137         7.2             50
#> 756               26       67.5           276        11.4            328
#> 757                4       77.9            20         6.6             18
#> 758              235       65.5           320         6.8             25
#> 759              284       76.8            29        10.8            304
#> 760              295       75.3            48         7.9            103
#> 761              294       71.9           140         6.8             30
#> 762              187       69.5           227        10.5            290
#> 763               56       71.1           173         7.8             97
#> 764              205       61.7           340         8.1            128
#> 765              313       70.7           192        10.6            293
#> 766              239       77.5            23        10.2            277
#> 767              110       72.2           134        10.3            279
#> 768               11       64.0           329         8.3            146
#> 769              118       69.0           235        10.0            265
#> 770              230       80.4             4         7.9            104
#> 771              104       72.8           108        11.0            315
#> 772               80       64.9           326         6.9             33
#> 773              277       71.3           165         9.0            202
#> 774               77       75.6            46         7.6             75
#> 775               27       80.3             6         6.1             12
#> 776               13       72.5           124         7.4             63
#> 777              199       68.3           256         7.7             92
#> 778               67       70.2           207         9.6            240
#> 779              242       70.3           205         9.0            191
#> 780              174       70.3           202         7.5             73
#> 781               19       60.6           343        11.6            331
#> 782                8       68.2           258         8.1            126
#> 783              218       72.6           116         8.0            116
#> 784               38       71.9           141        11.0            314
#> 785               12       70.8           185         7.2             43
#> 786               70       71.0           179         9.4            227
#> 787               53       75.3            49         8.9            187
#> 788              214       70.1           213         7.6             82
#> 789              209       69.8           224         8.0            115
#> 790                9       71.3           164        11.0            311
#> 791               55       79.2             8        10.6            295
#> 792              246       72.9           103         8.1            124
#> 793              154       76.3            35         7.7             95
#> 794              148       66.3           304         8.4            150
#> 795               95       69.8           221        10.0            264
#> 796              220       79.0            10        10.6            296
#> 797                5       72.7           109         8.6            168
#> 798              253       71.0           180         7.6             79
#> 799              138       73.9            74         7.0             37
#> 800               46       76.3            34         8.6            173
#> 801               47       69.8           219         9.2            215
#> 802              345       72.9            99         8.7            174
#> 803              293       73.3            91         8.0            121
#> 804               21       79.2             7        10.6            298
#> 805              244       67.1           286        10.2            270
#> 806               34       69.1           233        10.2            278
#> 807              125       70.8           190        14.2            344
#> 808               68       68.8           247         9.5            232
#> 809               83       68.1           260         9.2            211
#> 810              135       67.1           284         9.9            261
#> 811              275       76.4            32         7.8            101
#> 812              181       72.2           135        12.6            341
#> 813              299       72.2           136        16.3            347
#> 814               84       72.8           106        10.8            306
#> 815              302       66.2           305         8.3            143
#> 816               17       75.0            53         7.6             91
#> 817              134       78.2            16         8.9            184
#> 818              146       73.6            79        14.0            343
#> 819              202       69.8           223         9.5            231
#> 820               75       74.2            66         6.7             20
#> 821              200       73.3            92         7.3             53
#> 822               20       72.6           118         7.6             81
#> 823                2       72.3           131         9.2            214
#> 824               43       73.4            86         7.5             74
#> 825              223       72.1           138         9.3            224
#> 826              176       68.8           248         9.0            193
#> 827              102       70.4           200         9.6            239
#> 828              192       70.8           184         8.9            189
#> 829               71       75.1            50         9.2            216
#> 830                3       74.0            72        10.7            301
#> 831              109       63.0           336         7.9            111
#> 832              267       67.5           278         7.6             83
#> 833              161       74.4            64         7.3             56
#> 834              122       66.2           307         7.6             77
#> 835              194       71.5           157         8.6            170
#> 836              140       68.2           257         8.8            180
#> 837               66       68.6           250         7.5             72
#> 838              216       69.3           230         9.7            245
#> 839              162       78.8            12        10.3            281
#> 840              165       71.2           170         9.3            221
#> 841              221       76.9            28         9.9            259
#> 842              117       68.9           240         7.6             86
#> 843              168       74.9            55         9.3            219
#> 844               29       78.0            17         6.7             23
#> 845               76       65.8           313         7.9            110
#> 846              263       71.8           147         5.8              7
#> 847              203       73.8            76         8.0            119
#> 848               49       76.3            33         6.1             11
#> 849              219       73.4            85         7.2             49
#> 850              169       65.8           312         9.6            238
#> 851              332       71.6           155        10.3            283
#> 852              101       75.1            52         7.4             66
#> 853              303       71.0           181        10.2            274
#> 854              128       74.5            63         8.1            133
#> 855              260       72.5           119         8.6            172
#> 856              159       76.0            39         7.7             93
#> 857              108       68.9           242         9.0            195
#> 858              166       71.1           172         8.1            127
#> 859              268       77.3            25         8.7            175
#> 860              344       68.0           261         8.2            135
#> 861              154       65.8           314         7.3             60
#> 862              100       71.7           150        10.5            289
#> 863              287       70.3           204         8.5            158
#> 864              106       66.8           295         6.8             29
#> 865               60       73.9            73         9.0            197
#> 866              255       72.5           123         9.0            192
#> 867              250       66.4           302        10.7            303
#> 868              324       68.9           241         8.5            153
#> 869              247       73.6            80         7.5             70
#> 870              300       73.8            75        11.7            332
#> 871              179       67.2           283        10.2            273
#> 872              258       71.7           149         7.1             42
#> 873              333       79.1             9        13.7            342
#> 874               78       72.6           115         9.8            254
#> 875              217       69.8           222         9.9            260
#> 876              130       72.4           126        11.0            317
#> 877              163       67.5           279         8.2            137
#> 878              312       72.9           102         9.1            206
#> 879              207       71.8           146         7.8             99
#> 880              318       68.8           244         6.4             14
#> 881              233       72.2           133         6.8             28
#> 882              269       72.6           114         6.7             21
#> 883              105       78.4            13         7.0             35
#> 884              256       67.0           287         8.3            145
#> 885               35       76.2            36         9.0            198
#> 886               62       75.4            47         7.4             69
#> 887              213       72.8           104         8.2            138
#> 888              276       66.7           296        11.5            330
#> 889              248       73.1            96         9.1            205
#> 890              120       67.0           289         9.6            242
#> 891               93       71.1           171         9.7            248
#> 892              316       68.8           245         8.9            186
#> 893              254       70.6           194        10.2            272
#> 894              127       75.7            41         6.6             17
#> 895              211       74.9            56         6.7             24
#> 896               50       72.8           105         8.1            123
#> 897              236       70.5           196         8.6            165
#> 898              186       72.5           122         7.7             94
#> 899              167       71.3           162         8.9            183
#> 900              336       71.2           169         9.0            201
#> 901              107       74.0            71         8.5            155
#> 902              272       63.9           330        10.9            309
#> 903              198       65.9           310         7.5             71
#> 904               86       71.0           178        11.1            319
#> 905              184       73.5            84         9.2            213
#> 906              266       75.1            51        10.5            288
#> 907              175       74.6            61         7.2             45
#> 908              315       70.2           211         9.8            255
#> 909              191       75.7            43         7.9            105
#> 910              232       67.2           281         7.9            111
#> 911               32       69.3           231         8.2            142
#> 912              151       70.2           209        10.6            299
#> 913              262       75.7            42         8.4            152
#> 914               42       76.2            37         9.1            208
#> 915               89       71.2           166         8.7            176
#> 916              273       74.1            68        12.1            339
#> 917               91       76.1            38         8.5            161
#> 918              237       74.8            58         9.2            212
#> 919               73       77.8            21         5.4              2
#> 920              178       70.5           199         9.3            219
#> 921              347       57.2           346         9.7            246
#> 922              282       75.6            44         5.4              3
#> 923              173       73.2            95         7.2             44
#> 924               39       71.1           173         9.3            226
#> 925              285       75.6            45         7.8            102
#> 926              147       65.9           311         7.3             52
#> 927               87       67.5           277         9.5            233
#> 928              189       73.7            77        10.8            306
#> 929              224       63.4           332         6.8             27
#> 930              129       70.9           183         9.1            207
#> 931               51       70.8           187        11.5            329
#> 932              215       66.9           292        10.2            275
#> 933              119       73.3            89        10.3            280
#> 934              338       67.6           274         9.5            235
#> 935               30       69.4           228         7.4             65
#> 936               82       70.1           214        11.3            325
#> 937              335       63.2           334        10.6            292
#> 938              172       65.7           315         7.6             88
#> 939              341       61.5           341         7.1             41
#> 940              228       70.2           208         8.1            125
#> 941              139       69.9           218        10.0            263
#> 942              225       66.5           300         9.6            237
#> 943              306       68.8           246        11.8            334
#> 944               88       68.5           251        10.7            300
#> 945              278       64.6           328        11.0            312
#> 946              251       67.2           282        10.5            286
#> 947              327       69.8           225        11.3            326
#> 948              113       71.6           156        11.1            318
#> 949               85       73.5            83         9.3            217
#> 950               33       63.3           333         9.8            258
#> 951              112       67.9           265         8.1            130
#> 952                6       68.0           263         7.7             96
#> 953              208       67.8           267         9.8            257
#> 954               61       71.7           153         9.6            241
#> 955               90       67.1           285         7.6             85
#> 956               99       67.6           275         9.0            190
#> 957              111       73.2            94         9.6            244
#> 958              241       72.7           112         8.0            113
#> 959              243       78.3            15         9.0            194
#> 960              133       74.6            59         8.0            117
#> 961              226       70.0           216         8.6            164
#> 962              123       72.4           126         8.0            118
#> 963              231       77.5            24         8.9            188
#> 964              124       75.0            53         7.0             38
#> 965              337       61.9           339         9.3            223
#> 966               52       67.0           290         7.0             36
#> 967               17       69.1           234         6.4             15
#> 968              227       66.8           294        10.1            269
#> 969              170       71.8           145         8.6            167
#> 970              323       71.7           152        10.9            310
#> 971              307       72.8           107         8.0            120
#> 972              329       67.7           273         9.8            253
#> 973              290       72.3           130        14.2            345
#> 974              346       64.7           327        11.4            327
#> 975               31       66.3           303         7.2             47
#> 976              257       73.5            81         9.2            210
#> 977              274       70.1           212         7.3             57
#> 978              339       65.6           318        11.1            321
#> 979              340       72.0           139         9.7            250
#> 980              325       69.6           226        10.0            266
#> 981              334       56.9           347         7.6             89
#> 982              304       67.8           270         9.1            204
#> 983              265       69.0           238         5.6              6
#> 984               98       72.9           100         6.1             10
#> 985              115       71.7           151         8.5            157
#> 986              150       72.5           121        11.0            313
#> 987              160       66.9           291         8.0            114
#> 988              190       65.2           323         6.4             16
#> 989              291       70.8           188         9.4            228
#> 990               74       71.0           176         8.5            162
#> 991              305       73.4            87         7.9            108
#> 992              143       66.8           293         9.7            251
#> 993               92       63.6           331         8.4            148
#> 994              131       68.4           253         6.8             31
#> 995              180       65.6           317        10.3            282
#> 996              317       73.2            93        12.0            338
#> 997              185       70.2           206         8.5            160
#> 998              289       71.2           168        12.2            340
#> 999              121       68.4           254         9.0            198
#> 1000             197       65.7           316         9.1            203
#> 1001             222       71.4           161         9.4            229
#> 1002             153       72.5           120         7.3             55
#> 1003              58       68.9           243         8.2            139
#> 1004             229       71.7           148         9.0            200
#> 1005             343       72.3           132         9.9            262
#> 1006              41       70.5           197         6.1              8
#> 1007              45       60.4           345         7.4             68
#> 1008             271       74.2            67         6.3             13
#> 1009             296       69.1           232         9.3            222
#> 1010             270       65.4           321        10.4            284
#> 1011              54       65.3           322         8.2            134
#> 1012             279       65.0           325         7.6             87
#> 1013             314       66.2           306        10.8            308
#> 1014             261       68.5           252        10.4            285
#> 1015              96       62.2           338         9.5            230
#> 1016             234       69.3           229         6.7             22
#> 1017             328       72.6           113        10.8            305
#> 1018             141       70.2           210         8.2            136
#> 1019              96       69.0           237         8.2            140
#> 1020             212       66.4           301         9.8            252
#> 1021             183       72.6           116        11.8            335
#> 1022             201       68.0           262         7.6             80
#> 1023             164       68.3           255         7.1             40
#> 1024             188       65.0           324         8.5            163
#> 1025             330       74.6            59        10.2            276
#> 1026             310       72.9           100         8.2            141
#> 1027             206       71.8           143         7.3             61
#> 1028             193       66.5           299         6.7             19
#> 1029             298       73.5            82        10.2            271
#> 1030             210       71.0           182         9.8            255
#> 1031             204       70.0           215        11.0            316
#> 1032             280       65.9           309         7.4             62
#> 1033             152       73.4            88        10.0            267
#> 1034             126       70.7           193         8.6            166
#> 1035             320       67.4           280         7.9            107
#> 1036             264       68.0           264         8.1            129
#> 1037             288       67.8           271         9.5            234
#> 1038             283       68.7           249        10.6            294
#> 1039             292       72.7           110         7.9            109
#> 1040             116       65.5           319        11.1            320
#> 1041             196       67.9           266        11.2            322
#> 1042             311       62.7           337         6.9             34
#> 1043             149       66.7           296         7.6             76
#> 1044             249       74.9            57        14.9            346
#> 1045             281       74.1            69         7.3             59
#> 1046             103       67.8           267         8.4            149
#> 1047             297       70.4           201        11.9            337
#> 1048             154       70.8           189         8.6            169
#> 1049             342       67.0           288         8.8            178
#> 1050             309       60.4           344         7.2             46
#> 1051             322       63.0           335         8.5            158
#> 1052             326       66.6           298        11.2            324
#> 1053             331       69.8           219         8.8            182
#> 1054             348        0.0           348       100.0            348
#> 1055             348        0.0           348       100.0            348
#> 1056             348        0.0           348       100.0            348
#> 1057             348        0.0           348       100.0            348
#> 1058             348        0.0           348       100.0            348
#> 1059             348        0.0           348       100.0            348
#> 1060             348        0.0           348       100.0            348
#> 1061             348        0.0           348       100.0            348
#> 1062             348        0.0           348       100.0            348
#> 1063             348        0.0           348       100.0            348
#>      off_stl_pct off_stl_pct_rk off_non_stl_pct off_non_stl_pct_rk off_a_pct
#> 1            9.6            266             8.9                102      55.0
#> 2            8.2             92             7.9                 32      49.9
#> 3            7.4             27             8.8                 98      50.2
#> 4            9.9            290            12.3                337      50.6
#> 5            9.2            219            10.5                262      52.7
#> 6            8.0             68             8.2                 47      54.3
#> 7           10.5            329             8.8                 96      57.4
#> 8            8.1             87             6.6                  3      55.9
#> 9            7.8             51             9.6                175      59.5
#> 10           6.6              3             6.9                  6      43.5
#> 11           8.0             72             7.7                 21      60.0
#> 12           9.7            278             9.6                185      51.1
#> 13           6.6              7             7.2                 12      48.7
#> 14          10.5            328             9.7                190      51.0
#> 15           8.7            163             9.9                215      51.6
#> 16           8.6            150             7.7                 22      39.6
#> 17           8.1             80             8.4                 62      57.2
#> 18           8.1             78             8.5                 72      54.5
#> 19           8.6            153             9.2                127      54.6
#> 20           8.2             96             9.9                213      53.9
#> 21           8.3            102             8.5                 70      52.6
#> 22           7.1             16             9.3                144      45.6
#> 23           9.1            210             8.3                 49      59.4
#> 24           6.7              8             9.7                186      52.2
#> 25           6.9             11             7.7                 24      58.6
#> 26           8.7            167             9.3                143      55.2
#> 27           8.7            168            11.5                321      52.1
#> 28           9.2            212             9.3                146      66.5
#> 29           9.0            195             9.6                183      56.7
#> 30           8.0             71             9.2                133      50.8
#> 31           9.1            208             9.4                156      66.8
#> 32           7.6             40             8.7                 87      37.9
#> 33           8.7            166             8.3                 54      51.6
#> 34           8.5            128            10.7                280      51.8
#> 35           8.6            151            10.8                284      53.2
#> 36           8.1             82             9.3                147      52.2
#> 37           8.3             98             9.1                118      57.7
#> 38           8.5            136             8.6                 75      56.9
#> 39           9.1            209            10.7                279      51.1
#> 40           8.0             67             8.6                 84      46.0
#> 41           8.8            171             9.0                110      60.8
#> 42           8.1             85            10.1                231      61.6
#> 43           9.5            248            11.5                319      54.6
#> 44           7.4             30             8.4                 60      53.6
#> 45           9.3            233             9.9                217      50.3
#> 46           8.7            161             9.3                145      55.5
#> 47           8.0             73             8.7                 93      51.7
#> 48           8.4            110            10.4                255      52.4
#> 49           8.3            103            11.2                311      53.5
#> 50           6.6              5            10.7                271      54.6
#> 51           7.0             12            13.3                345      51.4
#> 52           9.0            202            10.5                260      50.4
#> 53           8.7            159            10.5                263      54.7
#> 54           8.2             94             7.0                  8      61.4
#> 55           6.8              9             9.4                159      47.9
#> 56          10.4            317            10.9                295      55.1
#> 57           7.5             33             9.3                139      47.1
#> 58           8.5            139             8.6                 83      54.1
#> 59          12.3            352            12.8                343      49.0
#> 60           8.5            122             9.1                119      45.8
#> 61           9.1            203             9.7                191      55.7
#> 62           7.7             47             8.0                 38      45.8
#> 63           8.8            173             7.0                  9      59.5
#> 64           9.5            253            10.7                277      52.4
#> 65           8.6            144            10.2                238      49.7
#> 66           8.5            127            11.7                324      50.5
#> 67           9.6            262             9.6                181      51.2
#> 68           9.6            263             8.9                103      56.7
#> 69           9.2            216             8.5                 71      52.3
#> 70           7.3             24             9.8                202      39.1
#> 71           8.6            141             9.1                120      53.6
#> 72           9.6            270             8.1                 46      55.9
#> 73           9.3            228             7.9                 31      59.3
#> 74          10.1            301            10.3                244      51.7
#> 75          10.4            318            14.3                352      50.1
#> 76          10.2            307             9.0                114      57.4
#> 77           7.6             38             7.3                 14      56.2
#> 78           9.1            204            12.0                333      46.7
#> 79           8.6            142            10.4                249      51.0
#> 80           9.8            284             9.3                142      51.0
#> 81           7.6             41             8.6                 81      54.1
#> 82           8.5            130            11.2                312      46.5
#> 83           9.8            288             9.0                112      52.1
#> 84           8.9            181             8.3                 57      60.6
#> 85           9.6            264            10.9                291      55.9
#> 86           7.8             53             9.8                205      49.1
#> 87          10.8            337            11.8                326      46.6
#> 88           8.3            106             8.3                 53      52.4
#> 89           8.5            129            11.9                331      49.6
#> 90          10.0            299             7.9                 33      48.2
#> 91           8.5            132             9.3                149      61.7
#> 92          10.4            322             8.0                 41      56.0
#> 93           8.4            118             8.4                 64      46.1
#> 94           8.0             75             9.3                138      43.1
#> 95           9.3            232            10.7                272      53.6
#> 96           7.7             44             9.8                196      48.3
#> 97           7.8             60             6.8                  5      49.2
#> 98           8.9            178             9.3                141      54.2
#> 99           9.0            198             7.5                 18      45.3
#> 100          7.1             15             7.3                 13      50.0
#> 101         10.4            320             8.7                 88      56.9
#> 102          8.7            155             9.5                168      62.1
#> 103          8.0             76             8.3                 51      40.7
#> 104          7.6             39             9.1                124      58.6
#> 105          9.3            231             8.3                 50      52.4
#> 106          8.5            134             9.8                193      56.7
#> 107          7.8             58            14.8                353      53.1
#> 108          8.9            183            10.7                274      45.2
#> 109          8.5            121            10.1                229      44.1
#> 110         10.2            306             7.7                 23      60.6
#> 111          9.4            240             9.5                171      51.4
#> 112          7.8             61             8.7                 86      55.8
#> 113          7.1             17             8.0                 37      50.4
#> 114          8.6            146            10.0                222      51.2
#> 115          8.9            190             9.0                117      54.4
#> 116          8.1             77             8.5                 68      52.2
#> 117          8.7            158             7.5                 17      60.3
#> 118          7.9             62             8.2                 48      50.4
#> 119          8.6            149            11.1                304      57.6
#> 120          7.2             22            10.2                239      46.0
#> 121          9.7            280            10.1                230      52.9
#> 122          7.9             65             8.1                 45      40.1
#> 123          7.6             37             9.6                176      45.0
#> 124          8.6            152             8.6                 85      50.8
#> 125          8.5            135             8.5                 67      54.2
#> 126          7.9             66             8.9                108      56.9
#> 127          7.2             19            10.1                224      47.1
#> 128          7.6             34             9.8                194      50.4
#> 129          9.5            256             7.8                 25      59.9
#> 130         11.6            350            12.5                339      50.7
#> 131          8.6            148            10.3                245      53.7
#> 132          7.9             64             9.8                207      52.3
#> 133          9.7            271             8.6                 74      62.7
#> 134          8.9            179             9.6                180      56.0
#> 135          9.5            258            11.1                307      52.7
#> 136         10.1            300             7.8                 26      48.1
#> 137          8.9            189            10.8                289      47.5
#> 138          9.2            220             9.6                177      48.3
#> 139          9.7            273            10.5                258      57.9
#> 140          7.2             20             9.2                132      45.7
#> 141          8.3            107             9.2                136      60.8
#> 142          8.7            160             8.5                 69      58.6
#> 143         10.4            325             8.9                104      52.1
#> 144          7.4             26            10.4                253      53.3
#> 145          9.1            205            10.9                292      55.0
#> 146          9.7            276             9.1                123      56.2
#> 147          8.0             74             9.9                216      40.8
#> 148          9.5            259             8.9                100      50.1
#> 149          7.1             14             9.8                195      50.6
#> 150          7.6             36             8.6                 77      52.4
#> 151          8.0             70             9.1                122      44.5
#> 152          8.7            156             8.4                 65      53.0
#> 153          9.4            244            11.5                318      55.6
#> 154          6.6              6             8.1                 43      53.9
#> 155          9.2            213             9.1                125      56.0
#> 156          8.4            112             6.9                  7      61.1
#> 157          8.5            140             8.1                 44      51.6
#> 158          7.8             56             9.2                130      48.5
#> 159          9.7            275             8.8                 94      56.4
#> 160          8.2             90             9.1                126      54.6
#> 161          8.6            145            10.6                267      60.4
#> 162          9.5            254             7.4                 16      48.7
#> 163          9.5            255            10.3                247      47.9
#> 164          8.6            154             9.7                188      60.8
#> 165          8.1             89            10.2                235      51.7
#> 166          9.5            257             9.8                204      53.7
#> 167          9.6            268             8.3                 56      52.0
#> 168          5.8              1            10.1                232      53.4
#> 169          9.2            218             8.0                 40      51.6
#> 170          9.8            286             8.0                 35      45.0
#> 171          8.9            182             9.6                182      48.3
#> 172          7.8             52             8.6                 78      47.5
#> 173          9.4            241             9.4                158      50.8
#> 174          9.9            293             9.7                189      56.3
#> 175          8.4            117             7.5                 19      50.3
#> 176          6.1              2             7.8                 29      54.4
#> 177          8.3            101             9.2                128      53.6
#> 178          8.3            108            10.2                234      50.8
#> 179          7.8             54            10.6                264      52.4
#> 180          8.7            165            10.1                226      48.5
#> 181          9.4            236            10.7                273      51.7
#> 182          8.9            188            10.8                281      54.4
#> 183          8.8            172            10.6                268      54.1
#> 184          6.6              4             8.0                 36      49.2
#> 185          9.3            229             9.4                163      58.9
#> 186          8.2             91             9.9                208      53.1
#> 187         10.2            308             9.3                148      53.2
#> 188          9.3            225            11.7                325      54.6
#> 189          7.3             25             9.3                137      52.9
#> 190          9.6            267             9.2                134      51.0
#> 191          9.6            261             8.4                 63      55.4
#> 192         11.2            343            10.9                294      49.9
#> 193          9.3            227            10.2                240      48.8
#> 194          8.1             86             9.2                135      53.2
#> 195         10.3            310             8.3                 52      40.2
#> 196          7.6             35             8.0                 42      53.8
#> 197         12.5            353             9.3                140      58.6
#> 198          7.2             21            10.6                265      53.1
#> 199          8.6            147             9.6                179      45.1
#> 200          7.7             45             8.4                 59      52.1
#> 201          8.5            131             9.5                170      45.8
#> 202          9.5            250             9.8                200      48.8
#> 203          8.4            119             8.7                 89      44.7
#> 204         10.4            324             8.6                 73      43.9
#> 205          8.1             83             6.7                  4      54.4
#> 206          9.5            249            10.8                290      50.8
#> 207          7.7             43             7.9                 34      43.3
#> 208          8.3             97             8.7                 92      51.7
#> 209          9.1            206             9.5                167      50.7
#> 210          9.2            211             9.8                197      47.2
#> 211         10.4            326            13.7                347      59.5
#> 212          8.9            180            11.1                305      52.9
#> 213          7.0             13             8.8                 97      54.8
#> 214          7.8             57             8.9                106      50.1
#> 215          8.8            177             9.8                199      51.1
#> 216          8.3             99             9.0                113      51.7
#> 217         11.6            349            11.2                310      51.3
#> 218          8.4            113             8.0                 39      48.5
#> 219          8.9            185             8.4                 61      49.4
#> 220          7.5             32            10.1                227      44.4
#> 221          9.6            269             7.8                 27      57.6
#> 222         10.1            305             9.4                154      52.6
#> 223          7.2             18             7.2                 11      50.8
#> 224          9.4            238             8.5                 66      51.0
#> 225         11.4            347            10.4                250      55.0
#> 226          8.3            100             8.6                 82      51.3
#> 227          9.9            289            12.8                341      56.9
#> 228          9.7            279            10.8                282      43.3
#> 229          9.8            287             8.7                 90      50.5
#> 230          8.8            170            11.1                303      50.1
#> 231          8.0             69            10.8                283      60.0
#> 232          7.8             55            11.1                306      49.5
#> 233         10.0            297            14.1                351      55.3
#> 234          9.8            281             9.4                153      51.4
#> 235          7.6             42             9.6                184      51.0
#> 236         10.1            304             9.4                160      56.3
#> 237          9.5            252            10.1                228      50.3
#> 238          9.2            222            10.9                293      54.4
#> 239          7.7             48            10.1                233      47.3
#> 240          7.9             63             7.4                 15      54.9
#> 241          8.6            143             7.8                 28      46.9
#> 242          9.9            294             9.8                192      52.2
#> 243          7.7             49             7.9                 30      54.5
#> 244          9.9            295             9.0                111      48.4
#> 245         10.8            335            11.1                301      59.0
#> 246          9.0            197            10.0                218      59.2
#> 247          9.7            277            10.2                237      52.4
#> 248          8.3            104            11.4                316      49.2
#> 249          9.8            282            10.0                221      46.4
#> 250          8.7            162             9.9                212      50.8
#> 251          8.5            125            11.2                309      48.9
#> 252          8.5            133             9.9                210      51.0
#> 253          8.5            123            10.3                246      39.0
#> 254          9.5            251            10.4                252      51.3
#> 255         10.8            334             9.8                206      53.1
#> 256          8.9            191            13.7                348      44.3
#> 257          9.8            283             8.9                105      58.8
#> 258          9.0            200            11.6                323      45.5
#> 259          9.3            230            13.9                350      48.6
#> 260          7.5             31             9.3                151      43.2
#> 261          8.2             93            10.3                241      52.7
#> 262          9.3            224             9.4                165      51.5
#> 263          7.8             59            10.8                285      39.8
#> 264          8.5            126             9.9                214      45.0
#> 265          9.3            226            10.4                248      55.4
#> 266         10.9            338            12.4                338      42.6
#> 267          8.1             79            12.8                342      48.0
#> 268          8.1             84             9.4                155      51.7
#> 269         10.4            323             8.9                101      53.7
#> 270          7.8             50            10.8                287      58.4
#> 271          9.4            237            12.1                336      52.6
#> 272         10.1            302             8.9                109      51.7
#> 273          6.9             10            10.5                257      48.6
#> 274          8.8            175             9.9                209      44.6
#> 275         10.9            339            11.9                330      45.4
#> 276          8.3            105            11.0                299      45.1
#> 277         10.3            313            12.0                332      55.4
#> 278          9.6            265            10.2                236      54.6
#> 279          7.3             23             6.1                  1      50.1
#> 280          9.4            235            10.8                286      47.6
#> 281         10.3            316             9.4                161      54.6
#> 282         10.6            333            11.8                328      54.5
#> 283          9.4            239            10.4                251      53.4
#> 284         10.5            327            10.4                254      43.9
#> 285          8.9            186            11.0                297      54.7
#> 286          9.0            193             9.3                150      58.1
#> 287          8.1             88             8.8                 99      42.7
#> 288          9.8            285             8.3                 55      49.2
#> 289          8.7            157             9.6                174      50.1
#> 290          8.9            187             9.0                115      45.7
#> 291          9.4            242            13.3                346      46.8
#> 292         10.4            321            10.6                269      60.6
#> 293          9.4            243             7.0                 10      59.3
#> 294          8.4            114             9.1                121      49.7
#> 295          9.7            274            10.5                256      51.0
#> 296         10.8            336             9.8                203      54.5
#> 297          9.0            192            11.9                329      48.5
#> 298         11.0            340            12.5                340      48.9
#> 299          8.4            109             8.9                107      49.9
#> 300          8.5            138             8.6                 76      59.0
#> 301          8.8            176            10.5                261      55.4
#> 302         11.4            348             9.9                211      54.2
#> 303          8.8            174            13.9                349      59.8
#> 304          7.4             29             6.5                  2      54.5
#> 305         11.3            346            11.3                313      52.3
#> 306         10.0            296             9.0                116      48.3
#> 307          8.5            124             9.8                201      53.0
#> 308          8.4            120             9.6                172      56.0
#> 309          8.5            137             7.6                 20      61.4
#> 310         12.0            351            12.0                335      52.1
#> 311          8.4            116             9.4                164      51.0
#> 312          9.5            260             9.6                178      50.6
#> 313          9.0            199            10.0                219      48.5
#> 314          9.7            272            10.3                242      50.4
#> 315          9.4            245            11.1                302      50.4
#> 316          9.9            292             8.4                 58      50.3
#> 317         10.5            330            11.5                320      48.2
#> 318          9.2            221             9.6                173      46.6
#> 319          7.4             28            10.0                220      53.7
#> 320          7.7             46            11.3                314      41.2
#> 321          8.4            111            10.1                225      49.0
#> 322          8.9            184             8.7                 91      52.0
#> 323         10.3            311            11.0                300      55.4
#> 324         10.4            319             9.8                198      53.0
#> 325         11.1            341            11.0                298      63.0
#> 326          8.1             81            11.0                296      45.4
#> 327          8.7            164             8.8                 95      52.4
#> 328         10.2            309             9.2                129      46.2
#> 329         10.3            315             9.7                187      46.7
#> 330         10.3            312            10.7                275      57.4
#> 331         11.2            344            10.5                259      48.0
#> 332          9.2            223            10.7                278      54.9
#> 333          9.0            201            11.3                315      54.3
#> 334         10.5            331            12.0                334      50.9
#> 335          9.0            196            10.3                243      53.8
#> 336          9.4            234             9.4                152      48.1
#> 337          8.8            169            11.6                322      51.8
#> 338          9.2            217             8.6                 80      41.7
#> 339          9.0            194            11.8                327      52.8
#> 340         10.1            303            10.6                270      43.7
#> 341          8.2             95            11.2                308      50.1
#> 342          9.2            215            10.1                223      44.4
#> 343         10.6            332             9.4                157      56.2
#> 344         10.0            298            10.6                266      47.7
#> 345          9.1            207             8.6                 79      49.5
#> 346          9.2            214            10.7                276      55.5
#> 347          9.5            247             9.5                169      47.4
#> 348         10.3            314            12.9                344      45.9
#> 349          9.5            246             9.5                166      51.0
#> 350         11.2            345            11.4                317      46.0
#> 351          8.4            115             9.4                162      48.8
#> 352          9.9            291            10.8                288      52.6
#> 353         11.1            342             9.2                131      49.9
#> 354          8.8            145             6.7                  3      57.7
#> 355          6.0              2            11.4                308      52.0
#> 356          9.3            202             9.6                159      49.3
#> 357          7.3             23             7.7                 17      49.0
#> 358          6.0              1             8.9                 82      43.4
#> 359          7.1             16             8.8                 73      56.1
#> 360          8.3             98             7.0                  4      52.5
#> 361         10.4            311             8.2                 30      45.6
#> 362          6.6              7            10.1                208      55.0
#> 363          9.3            212             9.5                149      53.5
#> 364          8.2             86             8.1                 26      54.9
#> 365          8.2             92             9.0                 95      57.8
#> 366          8.6            123             9.2                113      50.5
#> 367         12.8            352            13.7                351      54.0
#> 368          8.9            161             9.0                 93      53.5
#> 369          7.5             32             9.4                144      50.9
#> 370         10.8            328             9.7                175      49.5
#> 371          7.0             14             8.4                 45      48.5
#> 372          9.9            284            13.7                350      52.6
#> 373          8.6            130             7.8                 19      45.8
#> 374          9.2            193            11.6                313      51.1
#> 375          7.2             20             9.1                 99      50.7
#> 376          7.5             28            11.6                314      54.7
#> 377         11.2            344            11.4                309      55.9
#> 378          7.1             15             8.7                 66      49.7
#> 379          8.4            104             8.9                 80      51.5
#> 380          7.8             54            10.2                220      60.3
#> 381          7.9             63            10.1                204      51.5
#> 382          9.1            189             8.9                 85      58.3
#> 383          9.7            249             8.8                 74      56.0
#> 384          8.9            164             9.7                172      58.2
#> 385          9.1            188            10.6                257      53.6
#> 386          7.6             41             8.8                 72      55.9
#> 387          9.4            222             8.2                 31      57.4
#> 388          8.8            149            11.1                289      53.2
#> 389          7.6             37             8.6                 62      55.5
#> 390          6.8             10             8.6                 63      36.6
#> 391          8.5            109             8.4                 46      46.4
#> 392          8.6            122             9.5                157      53.3
#> 393         11.0            334            10.4                245      46.4
#> 394          8.2             85             9.8                182      50.7
#> 395          8.0             70             7.5                 11      56.9
#> 396          8.9            167             9.8                179      64.1
#> 397          8.1             81             9.4                135      41.5
#> 398          9.2            195            10.2                228      57.2
#> 399          8.4            101             7.7                 15      56.3
#> 400          9.7            252            11.3                301      51.1
#> 401          8.2             89            10.7                263      52.4
#> 402          9.8            272            14.9                353      52.7
#> 403          7.7             46             8.0                 24      52.2
#> 404          9.8            268            10.1                215      57.9
#> 405          8.2             91             9.3                125      51.1
#> 406          9.7            250             8.9                 77      45.6
#> 407          7.9             64            12.3                338      53.4
#> 408          8.8            148             9.5                148      52.0
#> 409          7.4             26            11.0                285      47.4
#> 410          9.1            187            10.6                255      61.2
#> 411          8.5            112             8.1                 29      47.8
#> 412          8.4            106            10.7                264      52.1
#> 413          9.4            218             9.0                 92      50.3
#> 414          9.7            261            11.8                320      61.9
#> 415          9.0            173            10.7                265      46.4
#> 416         11.4            346            10.1                207      58.1
#> 417          8.6            124             9.8                180      49.1
#> 418          6.8              9             9.6                167      38.5
#> 419          7.7             50             9.4                145      51.2
#> 420         10.8            329            11.2                294      45.1
#> 421          6.8             11             9.8                185      57.9
#> 422         10.1            291            10.9                278      55.2
#> 423          6.7              8             7.9                 21      46.5
#> 424          7.7             44             7.7                 18      51.1
#> 425          9.8            265             8.9                 75      48.2
#> 426          6.3              5            10.0                202      50.1
#> 427          8.9            158             8.4                 40      54.1
#> 428         11.1            337            10.5                247      47.6
#> 429          9.8            271             8.0                 23      52.1
#> 430          6.1              3             8.5                 53      59.5
#> 431          9.9            281             8.9                 78      53.2
#> 432          8.6            126            11.2                295      48.5
#> 433          9.0            178             8.4                 48      56.5
#> 434          7.6             36            11.3                302      48.5
#> 435          9.7            253            12.4                341      59.5
#> 436         10.7            325             8.6                 55      54.3
#> 437          8.7            135             9.2                109      54.1
#> 438         10.5            313             9.3                129      51.6
#> 439         11.2            341             9.2                119      55.1
#> 440          7.7             42             8.6                 60      44.5
#> 441          9.1            183             9.6                171      57.0
#> 442          7.6             35             7.6                 14      51.7
#> 443          9.8            270             9.4                139      60.4
#> 444         11.0            335             8.2                 32      51.6
#> 445          8.5            111            12.1                332      50.5
#> 446          9.3            206             9.5                154      54.6
#> 447          7.7             49             8.3                 36      60.4
#> 448         10.4            310            10.0                196      43.4
#> 449          8.7            132             9.4                142      65.0
#> 450          8.5            108            10.0                201      62.6
#> 451          7.2             19            10.9                277      46.4
#> 452          8.2             88             9.6                168      46.5
#> 453          9.0            168            11.7                316      54.6
#> 454          8.8            146             8.4                 41      63.9
#> 455          9.6            246             9.6                166      58.1
#> 456          9.6            238             8.3                 37      52.8
#> 457         10.7            326             8.3                 35      57.0
#> 458          9.4            225            11.2                292      57.3
#> 459          9.7            257             9.9                191      55.7
#> 460          9.0            182             7.6                 12      53.3
#> 461          8.1             78             6.1                  1      62.1
#> 462          8.9            155            10.2                221      54.4
#> 463         10.1            292             7.6                 13      58.8
#> 464          8.6            127            10.7                259      49.2
#> 465          7.5             30             9.5                153      44.4
#> 466         10.3            304             9.6                161      54.5
#> 467          9.9            276             9.2                110      50.0
#> 468          7.2             22            10.8                275      52.2
#> 469          7.9             60             7.2                  6      46.3
#> 470          7.1             17            11.1                290      55.7
#> 471          9.3            200             9.4                141      56.1
#> 472         10.7            327             9.9                189      48.2
#> 473          8.6            128            10.3                236      52.7
#> 474         11.1            339            12.3                339      46.7
#> 475          9.9            277             8.9                 79      54.5
#> 476          8.7            134             8.7                 65      50.9
#> 477          8.0             73             9.4                140      53.8
#> 478          8.8            144             9.1                103      50.8
#> 479          9.0            176            10.0                200      58.5
#> 480         10.7            324             9.7                174      50.9
#> 481          9.3            211            10.9                279      45.0
#> 482          7.9             59             9.0                 94      48.0
#> 483          9.8            267            11.2                293      49.3
#> 484          8.1             75            10.1                218      45.8
#> 485          9.4            217             9.4                138      51.0
#> 486         10.1            295             9.3                132      52.9
#> 487          9.1            186             9.1                100      57.0
#> 488          7.8             53             9.2                106      43.6
#> 489          9.0            174            10.1                211      42.5
#> 490          8.5            118            10.3                231      56.8
#> 491         10.3            305            10.3                235      52.3
#> 492          8.6            129             9.2                117      48.2
#> 493          8.9            166             9.3                124      50.7
#> 494          6.6              6             8.7                 67      52.7
#> 495          8.5            116             8.9                 83      49.4
#> 496          7.5             31            10.5                252      41.0
#> 497          9.7            256            12.7                344      56.1
#> 498          7.9             62             9.7                176      47.4
#> 499          7.4             25            11.0                284      49.8
#> 500          8.7            136            10.7                261      51.6
#> 501         10.0            288             9.9                192      48.0
#> 502          7.7             48             9.0                 90      58.7
#> 503          9.2            192             9.7                173      51.2
#> 504          9.5            229             9.2                116      54.3
#> 505          7.7             47            10.1                206      50.8
#> 506          9.3            204            11.3                299      53.2
#> 507          9.4            215             9.5                156      54.2
#> 508          8.5            120             9.2                114      49.8
#> 509         10.5            314            10.4                237      44.3
#> 510         11.7            349             9.2                108      55.0
#> 511         10.5            321            10.1                213      51.1
#> 512          7.8             51             8.6                 61      45.5
#> 513          8.4            107             9.3                133      58.8
#> 514          7.4             24            11.9                322      41.5
#> 515          9.7            260            10.0                197      56.5
#> 516          8.0             72            13.3                348      45.4
#> 517          9.2            197            10.3                230      54.9
#> 518          9.0            181             9.6                164      55.8
#> 519          8.9            163            11.8                319      46.8
#> 520          8.8            151             8.5                 51      44.8
#> 521          8.9            165            10.4                238      44.6
#> 522          9.7            255            10.8                271      48.5
#> 523          8.3            100             9.3                126      52.8
#> 524          7.4             27             9.5                151      48.0
#> 525          6.9             12             9.0                 91      47.2
#> 526          9.8            275            10.4                239      51.2
#> 527          8.0             69            10.6                254      55.2
#> 528          6.2              4             7.7                 16      45.1
#> 529          9.3            209             9.2                107      43.9
#> 530          8.0             67            10.4                243      48.0
#> 531          9.8            273            10.7                258      54.8
#> 532          7.9             61             9.8                184      42.4
#> 533          8.9            159            12.9                345      41.9
#> 534         10.5            315            10.5                250      48.7
#> 535         10.0            286             9.3                128      58.2
#> 536          9.1            185             9.8                177      46.8
#> 537         10.3            307            11.5                312      48.4
#> 538          9.7            251            10.8                274      52.3
#> 539          7.8             56             9.5                155      54.2
#> 540          8.9            162             9.5                150      52.4
#> 541          8.1             79            10.2                222      42.9
#> 542          8.8            150             9.8                186      55.1
#> 543         10.4            312            11.9                324      56.5
#> 544          8.5            115             8.0                 22      55.1
#> 545          8.7            139             8.5                 49      53.5
#> 546         10.2            297             8.6                 64      54.4
#> 547          9.6            245             8.6                 57      61.3
#> 548          9.7            263             9.9                194      45.3
#> 549          9.0            172             7.9                 20      58.5
#> 550          8.7            140             9.2                112      56.8
#> 551          8.0             74             9.6                163      44.9
#> 552          9.6            244            10.7                266      50.2
#> 553          9.5            226            10.8                272      53.6
#> 554         10.9            331             8.8                 69      56.4
#> 555          9.6            239             9.9                193      54.9
#> 556          9.9            282             7.4                  8      53.8
#> 557          9.0            180             9.2                120      51.0
#> 558          7.6             40             8.1                 27      53.2
#> 559         11.1            338            10.8                269      51.2
#> 560          9.5            235            11.7                317      51.3
#> 561          8.7            141             9.1                101      55.3
#> 562          8.4            105             9.0                 87      59.4
#> 563          7.5             29             8.2                 33      52.0
#> 564         10.0            287            10.1                217      54.7
#> 565          9.6            242             9.4                143      47.7
#> 566          9.1            191             8.5                 50      45.8
#> 567          7.7             45            10.3                234      54.4
#> 568          9.7            254            10.2                223      51.2
#> 569         10.1            296            11.5                310      56.3
#> 570          9.4            214             9.8                178      59.3
#> 571         10.5            317             9.3                130      60.6
#> 572          9.9            278            10.1                205      54.7
#> 573          8.9            157             9.0                 89      42.3
#> 574          8.0             71             9.2                111      48.9
#> 575          8.2             94            10.0                199      45.1
#> 576          9.0            171            10.2                219      44.5
#> 577          9.0            179             9.1                 98      57.7
#> 578          8.6            131             9.9                188      47.1
#> 579          8.5            113            11.0                283      53.6
#> 580         10.6            323             9.1                104      53.7
#> 581          9.6            240             7.3                  7      46.9
#> 582          8.7            137            10.6                253      45.2
#> 583          8.1             80            11.5                311      48.7
#> 584          7.0             13             8.1                 28      54.3
#> 585         10.4            308             9.1                 96      52.2
#> 586          9.3            210            10.3                233      51.8
#> 587          8.6            125             9.4                146      51.1
#> 588         10.4            309            10.1                214      47.2
#> 589          8.8            142            10.1                212      53.7
#> 590          9.7            258             9.4                137      46.6
#> 591          8.3             95             8.3                 34      46.4
#> 592          9.1            184            10.3                229      49.8
#> 593          9.3            207            11.3                298      53.9
#> 594          8.0             66            10.4                241      53.2
#> 595          9.4            220            10.8                273      57.3
#> 596          9.2            194            11.1                288      50.5
#> 597          9.4            219             7.5                 10      49.0
#> 598          9.2            196             9.3                121      56.5
#> 599          9.5            234             9.2                118      47.3
#> 600         10.2            298             8.6                 59      53.3
#> 601          8.9            156             7.1                  5      48.0
#> 602          8.7            138             9.8                187      52.3
#> 603          7.6             39             8.4                 43      54.2
#> 604          8.0             65            11.2                297      44.1
#> 605         10.3            306             8.6                 54      54.3
#> 606          7.6             38             9.0                 86      55.5
#> 607          9.9            280            10.4                242      45.5
#> 608          8.8            143             8.4                 44      38.9
#> 609          9.2            199            10.9                276      45.9
#> 610         10.1            294            12.0                331      42.3
#> 611          9.5            230            10.4                240      57.6
#> 612          9.9            283            11.6                315      53.6
#> 613          7.9             57            11.0                281      48.5
#> 614         10.9            332             8.4                 42      50.5
#> 615         10.2            301             8.5                 52      53.0
#> 616          8.4            102            10.8                267      54.5
#> 617          7.5             34             8.8                 71      48.3
#> 618          9.6            237            11.1                291      52.3
#> 619          9.0            175            10.5                246      50.1
#> 620          9.8            266             8.7                 68      54.6
#> 621          9.0            170             9.4                136      50.5
#> 622          9.6            243            11.0                286      48.2
#> 623         10.0            290            10.5                251      55.3
#> 624          9.3            213             9.5                158      47.9
#> 625          8.8            152             8.9                 76      40.7
#> 626          7.7             43            13.1                346      44.6
#> 627          9.3            201             9.6                160      44.3
#> 628          8.2             93            12.0                330      52.9
#> 629         11.2            340            10.1                209      55.1
#> 630         11.4            347             9.1                 97      62.7
#> 631          8.3             99             9.6                170      50.3
#> 632          8.2             84             7.4                  9      57.1
#> 633          7.2             21             6.4                  2      41.9
#> 634          8.5            114             9.3                127      46.8
#> 635         10.0            285             9.8                183      55.2
#> 636         12.3            351            10.7                262      58.3
#> 637         11.2            342             9.2                105      52.3
#> 638          9.1            190             9.8                181      51.4
#> 639          8.1             82             8.6                 56      55.0
#> 640         11.0            333            12.0                327      53.3
#> 641          8.5            117            12.4                340      52.6
#> 642          8.5            110             9.6                169      53.5
#> 643          8.8            154            11.0                280      55.0
#> 644          9.5            228            11.4                303      58.0
#> 645         10.2            302             9.6                165      40.2
#> 646         10.0            289            12.2                335      46.7
#> 647          8.1             76             9.1                102      47.7
#> 648          7.9             58            10.0                203      47.8
#> 649          9.7            264             9.9                190      54.3
#> 650         11.3            345            12.0                329      54.5
#> 651          9.6            236            10.6                256      50.1
#> 652          9.2            198            13.6                349      53.5
#> 653          7.8             55            10.2                227      54.1
#> 654          9.3            203             8.6                 58      49.1
#> 655          9.5            233            10.1                210      52.4
#> 656         10.2            299            10.8                270      43.7
#> 657          8.0             68             8.3                 38      45.8
#> 658         12.2            350            14.2                352      48.9
#> 659          9.7            259             8.4                 39      54.5
#> 660         11.2            343            10.0                198      47.6
#> 661          9.7            247            10.4                244      45.6
#> 662          7.2             18             9.0                 88      58.4
#> 663          8.4            103             9.5                152      50.0
#> 664         10.9            330             9.2                115      54.8
#> 665         10.5            318            12.1                334      47.6
#> 666          8.3             97            11.9                325      57.7
#> 667          8.6            121            11.3                300      54.2
#> 668          9.6            241            10.8                268      56.1
#> 669         10.2            300             9.3                123      48.9
#> 670          9.0            177             8.4                 47      40.1
#> 671          9.5            232             8.9                 84      46.8
#> 672          8.7            133            11.4                305      49.8
#> 673          9.3            205            11.0                282      50.1
#> 674          9.8            274            12.4                342      49.5
#> 675         11.0            336            11.1                287      54.8
#> 676          8.2             90            11.4                304      54.3
#> 677          7.8             52             8.0                 25      43.3
#> 678          9.3            208             8.9                 81      52.2
#> 679          8.8            147            12.1                333      50.3
#> 680         10.5            316            11.4                307      49.4
#> 681          9.7            262             8.8                 70      54.7
#> 682          8.8            153            11.8                318      56.4
#> 683          8.2             87            10.2                225      53.5
#> 684         10.1            293            11.2                296      52.5
#> 685          9.0            169             9.3                122      41.7
#> 686          9.7            248            10.3                232      57.3
#> 687          9.5            231             9.3                131      49.0
#> 688          7.5             33            10.5                249      44.3
#> 689          8.1             77            10.1                216      46.0
#> 690          9.4            221            12.5                343      51.8
#> 691         10.5            319            10.2                224      49.5
#> 692          9.4            224            11.9                323      42.4
#> 693         10.3            303            11.9                326      50.4
#> 694         10.5            320            10.7                260      41.6
#> 695         11.5            348            11.4                306      61.6
#> 696          8.9            160            10.2                226      42.7
#> 697          9.4            223             9.3                134      49.7
#> 698          8.2             83            12.2                336      46.9
#> 699          9.8            269             9.5                147      57.2
#> 700          9.5            227            13.1                347      47.4
#> 701          8.5            119             9.6                162      51.2
#> 702          9.9            279            11.8                321      40.4
#> 703         14.2            353            12.0                328      47.7
#> 704          8.3             96             9.9                195      44.0
#> 705         10.6            322            10.5                248      52.6
#> 706          9.4            216            12.2                337      42.0
#> 707          8.0             71             8.5                 75      55.3
#> 708          8.9            154             8.4                 63      50.6
#> 709          7.4             30             7.3                 12      57.0
#> 710         10.8            316            12.9                339      52.0
#> 711          8.9            152            10.8                257      61.1
#> 712          8.8            143            11.3                292      52.8
#> 713          8.0             69             8.8                 98      52.7
#> 714          6.7              8             8.6                 81      52.3
#> 715          8.8            140             7.2                 11      57.4
#> 716          7.5             37             5.8                  1      64.4
#> 717          7.5             35             8.8                 92      42.5
#> 718          9.8            243            10.8                256      51.7
#> 719          7.3             26             9.3                131      57.5
#> 720          9.5            210             8.1                 48      49.9
#> 721         12.0            340            10.3                221      51.6
#> 722          9.6            216            10.8                248      52.0
#> 723          6.3              3             8.6                 79      45.0
#> 724          7.2             21             9.5                148      49.9
#> 725          8.2             85             9.2                119      51.0
#> 726          7.6             41             7.9                 29      43.8
#> 727          9.9            249            10.6                239      52.4
#> 728          8.7            135            11.9                317      42.6
#> 729          9.6            224             9.9                188      44.5
#> 730          8.1             79             6.9                  8      54.8
#> 731          5.3              1            13.1                341      51.5
#> 732         10.3            282             9.2                120      55.2
#> 733          8.8            139             9.7                176      55.0
#> 734          8.2             92             9.2                118      55.1
#> 735          7.6             44             8.0                 35      55.4
#> 736          9.3            193             8.8                 97      55.7
#> 737          9.9            259             8.5                 76      57.3
#> 738          7.6             42            10.0                199      48.3
#> 739          7.2             18            10.0                198      52.7
#> 740          8.3            102            12.9                340      54.9
#> 741          7.3             25             8.4                 62      51.1
#> 742          9.7            229            10.1                208      52.1
#> 743          7.8             54             9.4                142      60.4
#> 744         12.0            339            11.0                274      59.9
#> 745          7.3             23            10.5                236      53.8
#> 746          9.3            195            10.1                204      58.0
#> 747          9.0            160             7.8                 26      52.1
#> 748          9.9            253             8.2                 51      52.0
#> 749         10.1            273             9.5                151      64.2
#> 750          6.9             13             9.7                179      54.2
#> 751          8.2             90             8.0                 33      55.6
#> 752          9.0            158             6.7                  4      57.0
#> 753          9.1            162             9.9                187      55.6
#> 754          8.4            105            11.1                278      50.6
#> 755          8.8            141             9.2                128      56.8
#> 756          7.2             20            12.1                324      58.2
#> 757          8.4            109             8.8                 96      49.8
#> 758          9.2            179             9.8                184      57.9
#> 759          6.6              6             7.1                  9      54.0
#> 760         10.7            312            10.8                252      51.7
#> 761          8.6            125             8.2                 50      52.9
#> 762          9.8            238             9.4                141      66.5
#> 763          8.1             83             7.2                 10      46.0
#> 764          8.4            113            13.2                343      60.7
#> 765          8.6            127             9.0                111      54.1
#> 766          8.2             94             8.1                 43      46.5
#> 767         11.3            327            10.2                216      51.1
#> 768          7.9             65             7.8                 25      55.2
#> 769          8.2             86             9.3                132      52.1
#> 770          7.0             14             8.0                 34      60.0
#> 771         10.5            299             9.8                186      58.6
#> 772          8.1             82             9.9                190      50.7
#> 773         12.7            346            11.2                288      53.4
#> 774          7.0             15             8.5                 72      49.6
#> 775          8.2             88             8.4                 61      54.5
#> 776          9.5            212             6.7                  5      53.2
#> 777          9.9            255            11.1                277      45.9
#> 778          9.2            184             9.5                154      48.3
#> 779          8.2             95            11.4                296      53.5
#> 780          7.8             58             8.8                 95      53.2
#> 781          9.2            178            12.0                321      46.4
#> 782          7.6             45             9.6                167      57.8
#> 783         10.3            283             9.5                150      45.8
#> 784          7.9             66             8.0                 39      54.1
#> 785          7.8             56             9.2                129      59.7
#> 786          8.9            150            11.8                311      50.9
#> 787         10.7            309            10.5                237      44.2
#> 788          9.3            186            11.1                280      45.9
#> 789          9.9            260             8.3                 58      44.9
#> 790          9.6            220             9.3                136      55.4
#> 791          9.3            185             9.1                116      57.6
#> 792         10.1            271            11.5                299      52.6
#> 793          9.4            205             9.0                106      57.1
#> 794          7.9             61            12.6                334      49.5
#> 795          8.6            126             8.6                 78      56.1
#> 796          7.3             24             8.7                 82      48.9
#> 797          7.8             57            10.4                231      60.8
#> 798          8.1             80             7.9                 30      51.8
#> 799          9.9            250             9.6                169      51.4
#> 800          6.1              2             7.7                 19      57.1
#> 801          8.7            131             8.1                 41      53.8
#> 802          8.5            116             7.7                 20      49.4
#> 803          9.3            194             9.0                109      50.4
#> 804          9.3            192            10.4                230      56.9
#> 805          9.7            230            12.0                322      59.4
#> 806          9.1            167             9.2                124      56.4
#> 807         10.6            301             8.0                 37      50.2
#> 808          8.1             81            11.2                289      53.8
#> 809         11.9            338            11.2                285      51.4
#> 810          7.6             46            12.0                320      49.3
#> 811          7.9             64             9.7                174      59.4
#> 812          9.2            181             8.5                 73      43.1
#> 813         11.3            325             8.7                 90      49.7
#> 814         10.1            267             9.7                175      57.0
#> 815          8.2             89             9.8                182      47.1
#> 816          8.2             93            10.0                200      50.7
#> 817          8.5            122             7.8                 24      56.4
#> 818          9.8            240            10.1                209      52.2
#> 819          9.6            218            10.7                245      46.5
#> 820          7.7             48             9.1                114      51.6
#> 821          7.5             31             8.7                 89      52.1
#> 822          7.8             53             8.3                 54      57.1
#> 823         10.1            274             7.8                 22      56.4
#> 824          7.3             27             7.6                 18      52.7
#> 825          9.2            175            11.8                310      47.7
#> 826          8.5            120             9.7                170      50.2
#> 827          9.7            235             8.0                 40      63.0
#> 828          9.1            166            11.1                283      53.4
#> 829          7.9             68             7.6                 15      42.0
#> 830          8.6            130             7.9                 32      60.9
#> 831          9.3            196            11.9                316      60.5
#> 832         10.0            262             9.5                153      48.0
#> 833         10.8            314            11.7                307      54.9
#> 834          8.9            147            12.1                325      47.7
#> 835          8.8            144             8.4                 60      57.9
#> 836         10.6            304             7.9                 27      64.6
#> 837          9.0            159            10.8                259      52.6
#> 838          9.4            207            10.3                225      44.7
#> 839          9.7            227            10.8                253      53.9
#> 840          7.9             60            11.7                305      49.2
#> 841         10.0            266             9.3                135      56.8
#> 842          9.2            172             7.7                 21      56.2
#> 843          9.2            171             7.6                 17      56.5
#> 844          7.5             33            10.6                241      55.1
#> 845          9.5            211            10.0                195      52.3
#> 846          9.3            197             9.8                185      52.9
#> 847          7.5             34             8.9                101      56.5
#> 848          6.8             10             9.6                168      58.5
#> 849         10.8            313            11.0                271      54.6
#> 850         10.5            296            11.6                301      50.6
#> 851          8.2             98            11.3                290      61.5
#> 852         10.0            265             9.7                178      51.9
#> 853          9.9            251            11.7                308      51.8
#> 854          8.0             75             7.6                 16      49.7
#> 855         13.1            347            10.9                265      54.4
#> 856          7.5             39            11.2                287      43.2
#> 857          8.7            132             8.7                 88      51.6
#> 858          7.7             49            11.1                276      45.3
#> 859          7.4             29             8.7                 83      45.0
#> 860          9.3            189            11.9                314      47.4
#> 861          9.9            247             9.4                143      47.3
#> 862          8.0             70             8.9                103      46.1
#> 863          9.6            215             9.6                159      58.3
#> 864          8.4            108            10.1                205      50.9
#> 865         11.0            319            11.3                291      55.9
#> 866         10.5            295            10.3                222      51.7
#> 867          8.6            123             9.8                183      57.8
#> 868          7.7             50             8.0                 36      53.1
#> 869          7.9             67            10.4                228      45.7
#> 870          7.9             62             8.4                 59      52.6
#> 871         10.3            285            10.7                246      54.4
#> 872          8.5            119            11.1                279      53.2
#> 873          8.5            117            10.5                238      52.3
#> 874         10.0            264            13.4                344      53.3
#> 875          9.2            173             9.5                152      49.1
#> 876          8.1             76            10.0                194      47.3
#> 877         10.2            276            10.5                235      49.3
#> 878          8.7            136            11.0                273      50.9
#> 879          8.4            110             8.7                 84      52.8
#> 880          8.8            145             9.3                133      37.8
#> 881          8.2             91             9.4                137      49.3
#> 882          8.4            112             8.3                 55      50.9
#> 883          9.4            203             9.9                192      52.7
#> 884         10.2            277             9.9                189      50.5
#> 885          6.5              5             9.5                149      47.3
#> 886          8.1             77             9.0                105      48.2
#> 887          7.6             43             7.4                 14      49.8
#> 888         10.7            307            11.0                269      59.4
#> 889         12.3            342            10.3                219      55.3
#> 890          8.2             96             8.5                 70      50.1
#> 891          8.3            100            10.4                227      55.9
#> 892         12.2            341            11.6                300      56.7
#> 893          8.6            128             9.2                122      57.4
#> 894         11.1            321            10.0                202      47.8
#> 895          8.2             87             7.3                 13      53.7
#> 896         10.3            284             9.2                117      49.3
#> 897          8.2             97            11.0                270      43.8
#> 898          9.2            176             9.0                107      47.2
#> 899          9.6            222            10.5                233      60.7
#> 900         10.3            281            10.8                247      52.3
#> 901          8.7            133             8.4                 65      49.8
#> 902          9.4            201            10.2                217      54.6
#> 903         11.4            330             9.7                172      49.4
#> 904         10.8            317            10.2                213      47.2
#> 905          8.2             99             8.0                 38      50.0
#> 906          9.6            223             7.9                 28      46.0
#> 907          9.4            206             8.7                 87      58.8
#> 908          9.2            177            12.2                327      49.0
#> 909          7.3             22             8.5                 68      48.9
#> 910         10.0            261            10.6                242      46.3
#> 911          9.4            202            13.2                342      59.0
#> 912          9.4            204             9.8                181      46.0
#> 913          8.4            107            11.9                315      42.8
#> 914          9.6            217             7.8                 23      46.3
#> 915          8.5            121             8.9                102      49.2
#> 916          8.5            115            10.2                214      55.9
#> 917          9.1            168            11.5                298      52.7
#> 918          9.6            219            11.1                284      52.6
#> 919          8.9            151             8.8                 93      58.4
#> 920          9.1            164            10.1                210      51.9
#> 921         12.6            343            11.7                306      55.0
#> 922         10.4            292             8.5                 77      43.1
#> 923          7.1             17             8.1                 49      48.5
#> 924          9.5            208             6.6                  3      52.7
#> 925          7.6             40             8.5                 71      45.0
#> 926          9.1            165             9.7                171      53.2
#> 927         10.1            272            10.8                254      53.8
#> 928         10.5            297             9.6                160      51.5
#> 929          8.7            138             9.0                104      50.0
#> 930          9.0            156             9.2                125      47.6
#> 931         11.8            335            10.2                212      56.3
#> 932          9.7            233            11.8                312      45.5
#> 933          9.5            213             6.8                  6      57.1
#> 934         10.9            318            10.8                249      44.3
#> 935          7.8             59             8.1                 46      62.6
#> 936          8.7            137            10.0                201      51.6
#> 937          9.7            236            11.1                281      48.6
#> 938         10.4            293             9.6                161      50.9
#> 939          8.9            153            11.3                293      44.7
#> 940         10.7            311             9.0                108      51.7
#> 941         10.3            288             9.4                140      47.2
#> 942          8.5            118             8.7                 85      57.5
#> 943          9.8            244             9.6                164      55.2
#> 944         11.4            329            10.1                206      52.9
#> 945          7.8             51             9.6                158      53.8
#> 946         10.3            286            11.7                303      57.4
#> 947          9.9            252            11.9                318      52.8
#> 948          8.6            124            11.0                272      47.0
#> 949         10.6            305            10.3                220      50.4
#> 950         10.1            269             8.1                 42      51.8
#> 951         10.6            302             8.5                 74      51.0
#> 952         10.6            303            12.9                338      51.0
#> 953          8.4            111             9.6                156      38.0
#> 954          9.9            248            11.2                286      49.0
#> 955          9.2            183             9.5                155      52.9
#> 956         10.4            289            12.2                329      57.9
#> 957          9.5            214             9.3                134      51.6
#> 958          9.3            199             9.4                144      63.7
#> 959         11.5            332             9.6                166      47.0
#> 960          8.3            104             9.5                146      41.4
#> 961          9.3            187             7.9                 31      53.3
#> 962          6.9             12            11.4                294      51.2
#> 963          8.8            146            11.5                297      44.0
#> 964          9.3            188             9.0                110      40.1
#> 965         10.4            290            13.6                347      44.4
#> 966          7.5             38            10.2                211      46.1
#> 967          9.2            169            10.8                255      56.1
#> 968         11.9            337             8.5                 69      55.3
#> 969          9.2            174             8.9                100      48.4
#> 970          7.7             47             9.6                165      40.9
#> 971          7.4             28             8.2                 53      43.8
#> 972          8.0             74             8.3                 56      47.5
#> 973          8.9            148             8.8                 94      49.4
#> 974         10.7            308            11.7                302      45.7
#> 975          9.8            245            10.1                203      49.8
#> 976          7.2             19             6.3                  2      45.6
#> 977          9.8            246             8.3                 57      49.2
#> 978          9.3            198             8.4                 67      42.5
#> 979         10.7            310             9.6                163      55.5
#> 980          9.3            190            10.4                229      46.7
#> 981         12.6            344            12.4                332      62.8
#> 982         10.2            278            11.8                313      45.1
#> 983         10.3            287            10.3                224      50.4
#> 984          9.7            234             9.2                123      51.7
#> 985          8.9            155            12.2                328      51.7
#> 986          9.6            225             9.0                112      56.7
#> 987          9.0            157            11.0                275      44.4
#> 988         10.4            291            13.5                345      53.0
#> 989          7.1             16             8.1                 45      52.7
#> 990          9.9            256            12.5                333      55.2
#> 991          9.9            254            10.2                215      49.6
#> 992          9.8            239             9.9                193      47.7
#> 993          9.9            258             6.8                  7      51.8
#> 994         11.2            324            11.7                304      54.3
#> 995          9.7            228            10.9                263      60.8
#> 996         11.2            323            11.1                282      47.2
#> 997          6.4              4             9.2                121      40.0
#> 998         12.6            345            11.0                268      44.7
#> 999         10.0            263            11.4                295      48.2
#> 1000        10.6            306            10.8                250      47.6
#> 1001         9.8            242            10.4                226      52.3
#> 1002         8.6            129             8.1                 44      48.5
#> 1003         9.7            237            13.6                346      44.9
#> 1004         8.8            142             8.4                 64      44.7
#> 1005        11.8            336            10.7                243      45.8
#> 1006         9.2            170             9.4                138      44.8
#> 1007        11.3            326             8.9                 99      47.9
#> 1008         8.0             72             9.1                113      44.7
#> 1009         6.7              9             9.5                145      41.1
#> 1010        10.2            280             9.6                157      49.5
#> 1011         9.7            232             9.7                173      58.7
#> 1012         9.6            221             8.4                 66      52.6
#> 1013         7.8             52            10.9                261      52.3
#> 1014        11.1            320            12.1                323      47.1
#> 1015         9.1            163            10.9                262      54.1
#> 1016        11.2            322            12.3                330      46.6
#> 1017         9.5            209            10.9                266      40.7
#> 1018        10.2            279            10.5                234      48.9
#> 1019        10.8            315             9.2                127      56.8
#> 1020        11.8            334            10.6                240      58.9
#> 1021        10.1            268            12.2                326      54.4
#> 1022         8.1             84             9.7                180      47.5
#> 1023         6.9             11             8.6                 80      45.0
#> 1024         9.9            257             9.6                162      55.0
#> 1025         7.8             55             8.7                 86      55.3
#> 1026         9.8            241             8.8                 91      67.2
#> 1027         8.5            114             9.5                147      53.3
#> 1028         6.7              7             9.9                191      47.7
#> 1029        10.1            270            10.8                258      61.7
#> 1030         7.5             36             9.2                130      51.4
#> 1031        10.2            275             8.2                 52      47.1
#> 1032         9.7            231            10.9                264      43.7
#> 1033         7.9             63             9.1                115      45.7
#> 1034         9.3            191             9.2                126      45.9
#> 1035         8.3            103            11.7                309      43.0
#> 1036         9.4            200            10.8                251      49.8
#> 1037         9.2            180            12.7                337      44.2
#> 1038         9.2            182             9.4                139      51.8
#> 1039         8.0             73            10.3                223      39.2
#> 1040         9.6            226            10.7                244      48.4
#> 1041         8.3            101            12.6                335      46.4
#> 1042        11.3            328            10.1                207      47.6
#> 1043         8.9            149            10.4                232      61.2
#> 1044        10.4            294             9.7                177      47.2
#> 1045         7.5             32             8.1                 47      56.7
#> 1046        10.5            298            10.8                260      48.7
#> 1047        11.5            331            10.0                196      50.6
#> 1048         8.4            106            12.4                331      43.6
#> 1049        10.6            300            10.2                218      59.5
#> 1050        11.6            333            10.0                197      52.2
#> 1051         8.1             78            11.0                267      56.6
#> 1052         8.7            134            12.0                319      53.5
#> 1053         9.1            161            12.6                336      49.4
#> 1054       100.0            348           100.0                348       0.0
#> 1055       100.0            348           100.0                348       0.0
#> 1056       100.0            348           100.0                348       0.0
#> 1057       100.0            348           100.0                348       0.0
#> 1058       100.0            348           100.0                348       0.0
#> 1059       100.0            348           100.0                348       0.0
#> 1060       100.0            348           100.0                348       0.0
#> 1061       100.0            348           100.0                348       0.0
#> 1062       100.0            348           100.0                348       0.0
#> 1063       100.0            348           100.0                348       0.0
#>      off_a_pct_rk off_fg_3a_pct off_fg_3a_pct_rk adj_o adj_o_rk ncaa_seed year
#> 1              81          38.3              183 108.9       91        NA 2019
#> 2             244          43.9               49 118.1       10         7 2019
#> 3             234          41.3              102 112.7       37        NA 2019
#> 4             221          30.5              336  95.9      318        NA 2019
#> 5             144          35.2              268 106.5      139        16 2019
#> 6             106          44.2               44 112.5       40        NA 2019
#> 7              44          41.4              100 110.5       60        15 2019
#> 8              67          39.5              149 123.4        2         1 2019
#> 9              25          43.7               54 118.1       11         4 2019
#> 10            336          36.3              239 110.2       65        NA 2019
#> 11             19          37.0              220 107.1      121        NA 2019
#> 12            197          41.7               98 113.2       32         5 2019
#> 13            266          38.8              170 116.4       17        NA 2019
#> 14            199          38.3              180 108.5       96        NA 2019
#> 15            186          41.0              112 101.6      231        NA 2019
#> 16            350          34.0              296  97.6      296        NA 2019
#> 17             47          36.0              243 109.8       72        NA 2019
#> 18             96          46.4               20 111.0       58        13 2019
#> 19             92          45.7               30 108.5       95        NA 2019
#> 20            114          47.9               12 108.4      100        NA 2019
#> 21            147          49.6                8 120.9        6         5 2019
#> 22            315          43.5               60 107.7      111        14 2019
#> 23             26          42.8               76 109.8       70        NA 2019
#> 24            162          38.2              184 109.3       79        NA 2019
#> 25             35          47.6               14 109.3       78        NA 2019
#> 26             79          42.2               89 107.0      124        NA 2019
#> 27            169          40.5              128  98.3      289        NA 2019
#> 28              2          43.6               57 107.8      107        NA 2019
#> 29             54          46.7               17 112.0       47        NA 2019
#> 30            216          41.1              109 104.9      165        NA 2019
#> 31              1          37.8              190 121.0        5         2 2019
#> 32            353          35.2              269 114.7       23        11 2019
#> 33            184          37.6              196 107.8      109        16 2019
#> 34            173          39.1              162 117.7       13         5 2019
#> 35            132          53.4                4 105.5      154        NA 2019
#> 36            164          38.3              181 107.4      114        15 2019
#> 37             41          34.5              282 103.4      196        15 2019
#> 38             48          43.8               52 107.8      108        NA 2019
#> 39            196          38.7              173  95.2      324        NA 2019
#> 40            308          34.1              295 111.1       55        NA 2019
#> 41             12          39.2              156 111.7       50        NA 2019
#> 42              7          42.3               87 106.1      145        NA 2019
#> 43             91          33.1              309 104.6      172        NA 2019
#> 44            125          45.5               32 122.5        4         3 2019
#> 45            233          35.1              270 106.6      136        NA 2019
#> 46             71          41.9               95 109.5       75        NA 2019
#> 47            178          45.8               29 106.8      130        NA 2019
#> 48            151          35.3              262 101.5      234        15 2019
#> 49            126          40.5              127 103.1      200        NA 2019
#> 50             95          46.4               22  98.7      281        NA 2019
#> 51            188          37.2              214  98.5      284        NA 2019
#> 52            225          38.7              172 106.8      132        NA 2019
#> 53             88          46.5               19 114.8       22        NA 2019
#> 54              8          43.8               51 115.6       18        11 2019
#> 55            286          37.8              192 110.4       63        NA 2019
#> 56             80          40.5              126 101.6      233        NA 2019
#> 57            295          30.3              338 102.0      221        NA 2019
#> 58            113          42.8               77 111.1       54        12 2019
#> 59            258          45.8               28 101.6      232        NA 2019
#> 60            310          33.3              305 100.8      248        NA 2019
#> 61             69          33.5              302 104.2      180        NA 2019
#> 62            311          48.0               11 107.4      117        16 2019
#> 63             24          32.2              324 122.7        3         2 2019
#> 64            153          52.7                5 107.0      126        NA 2019
#> 65            248          36.5              236 101.1      247        NA 2019
#> 66            222          39.5              151  97.8      294        NA 2019
#> 67            195          34.6              279 108.1      104        NA 2019
#> 68             52          44.4               41 101.9      223        NA 2019
#> 69            159          36.0              246 114.1       25         3 2019
#> 70            351          32.3              323 109.0       86        NA 2019
#> 71            124          35.6              254 112.1       44         9 2019
#> 72             66          35.3              263 111.6       51        14 2019
#> 73             27          39.0              166 117.4       15        10 2019
#> 74            181          38.9              167 103.7      189        NA 2019
#> 75            235          29.4              345  89.4      347        NA 2019
#> 76             45          44.5               40 106.4      140        NA 2019
#> 77             58          35.3              265 124.5        1         1 2019
#> 78            298          41.2              103 107.0      127        NA 2019
#> 79            205          41.0              110 100.2      254        NA 2019
#> 80            201          43.4               64 101.5      237        NA 2019
#> 81            112          39.6              147 118.9        9         6 2019
#> 82            302          36.3              238  99.9      261        NA 2019
#> 83            168          38.7              174 100.0      258        NA 2019
#> 84             14          35.8              253 119.7        8         1 2019
#> 85             65          40.2              136 102.1      217        NA 2019
#> 86            257          42.7               80 102.2      216        NA 2019
#> 87            300          42.1               91 105.7      150        NA 2019
#> 88            154          30.8              333 104.8      170        NA 2019
#> 89            249          50.1                6  99.5      274        NA 2019
#> 90            279          36.9              222  97.6      297        NA 2019
#> 91              6          41.3              101 109.4       76        14 2019
#> 92             64          47.0               16 108.9       89        NA 2019
#> 93            305          41.0              113 108.5       97        13 2019
#> 94            340          39.1              158 101.8      225        NA 2019
#> 95            123          37.2              213 109.9       67        NA 2019
#> 96            276          32.4              320 107.4      118        13 2019
#> 97            255          34.6              281 110.4       62         5 2019
#> 98            108          39.9              145 113.2       33         8 2019
#> 99            319          36.0              244 108.4       99        NA 2019
#> 100           242          38.5              177 108.6       92        11 2019
#> 101            49          39.6              146 106.5      137        NA 2019
#> 102             5          37.9              188 112.6       39         8 2019
#> 103           346          44.0               47 106.5      138        NA 2019
#> 104            36          46.4               21 108.2      102        NA 2019
#> 105           157          40.0              139 103.4      194        NA 2019
#> 106            53          37.2              215 103.9      184        NA 2019
#> 107           136          34.2              292 100.0      260        NA 2019
#> 108           320          33.1              311 100.0      256        NA 2019
#> 109           332          28.6              349 101.4      239        NA 2019
#> 110            15          37.5              201 108.9       90        NA 2019
#> 111           190          35.8              251 109.0       88        NA 2019
#> 112            68          42.6               83 115.3       19         3 2019
#> 113           224          38.9              168 112.0       45        NA 2019
#> 114           194          29.6              341 117.6       14         2 2019
#> 115           101          36.7              227 101.9      222        NA 2019
#> 116           165          46.0               24 102.4      213        NA 2019
#> 117            18          36.5              234 101.2      244        NA 2019
#> 118           228          42.8               79 111.3       53        NA 2019
#> 119            42          42.4               85  99.9      262        NA 2019
#> 120           307          35.9              247 105.5      155        NA 2019
#> 121           142          35.0              271 104.2      179        NA 2019
#> 122           348          35.2              267 101.7      229        NA 2019
#> 123           325          40.3              129 101.1      245        NA 2019
#> 124           214          35.8              252 113.1       34        NA 2019
#> 125           109          39.4              153 107.6      112        NA 2019
#> 126            50          53.5                3 116.5       16         6 2019
#> 127           294          40.0              140 107.4      116        NA 2019
#> 128           226          44.5               39 106.9      129        16 2019
#> 129            21          45.9               26 105.8      149        NA 2019
#> 130           217          34.5              284  97.5      298        NA 2019
#> 131           121          42.6               84 103.2      198        NA 2019
#> 132           161          39.5              152 109.5       74        12 2019
#> 133             4          41.5               99 103.6      190        NA 2019
#> 134            62          37.1              218 105.4      156        NA 2019
#> 135           145          42.2               90  96.0      317        NA 2019
#> 136           281          42.8               74 101.5      235        NA 2019
#> 137           290          39.9              144 107.7      110         9 2019
#> 138           275          34.9              275 113.9       27         4 2019
#> 139            40          40.0              141 102.9      203        NA 2019
#> 140           314          34.1              294 103.5      192        NA 2019
#> 141            13          42.8               75 103.7      188        NA 2019
#> 142            34          36.6              233 112.5       41        12 2019
#> 143           166          37.0              219 113.4       31         6 2019
#> 144           129          37.3              210 101.4      238        14 2019
#> 145            83          45.6               31 100.8      249        NA 2019
#> 146            60          40.2              133 105.9      147        NA 2019
#> 147           345          42.9               73 106.1      144        NA 2019
#> 148           240          45.4               35 102.6      206        NA 2019
#> 149           219          32.7              319 105.3      160        NA 2019
#> 150           152          43.5               59 113.6       29        NA 2019
#> 151           328          37.1              216 101.8      227        NA 2019
#> 152           137          43.4               65 101.3      242        NA 2019
#> 153            70          45.5               33  98.4      285        NA 2019
#> 154           115          42.8               78 114.0       26         7 2019
#> 155            63          44.3               43 104.1      181        NA 2019
#> 156            10          40.2              135 107.0      125        NA 2019
#> 157           183          34.9              276 105.6      151        NA 2019
#> 158           269          41.2              105 100.8      250        NA 2019
#> 159            55          50.0                7  99.0      277        NA 2019
#> 160            90          40.1              138 107.1      122        NA 2019
#> 161            17          37.5              202 110.3       64        NA 2019
#> 162           265          33.1              310 111.1       57         9 2019
#> 163           285          43.3               67  95.1      325        NA 2019
#> 164            11          37.5              204 110.1       66        NA 2019
#> 165           176          37.5              200 109.1       83        NA 2019
#> 166           118          43.7               55 104.1      183        NA 2019
#> 167           171          42.7               81 101.1      246        NA 2019
#> 168           127          33.3              304 112.3       42         7 2019
#> 169           184          36.8              225 104.9      166        NA 2019
#> 170           323          41.9               96 106.2      142        NA 2019
#> 171           278          37.4              208 109.0       85        NA 2019
#> 172           289          41.8               97 105.8      148        NA 2019
#> 173           211          32.8              317 111.7       49        NA 2019
#> 174            57          39.0              165 104.5      174        NA 2019
#> 175           231          44.7               38 106.9      128        NA 2019
#> 176           104          39.9              143 114.5       24         2 2019
#> 177           122          43.7               56 113.7       28         7 2019
#> 178           213          44.0               48 104.3      178        NA 2019
#> 179           155          43.8               50  99.7      268        NA 2019
#> 180           270          33.1              312 104.4      176        NA 2019
#> 181           181          43.0               71  98.3      290        NA 2019
#> 182           101          40.8              116 115.3       20         9 2019
#> 183           111          35.9              248  96.8      305        NA 2019
#> 184           253          38.1              185 107.4      115        NA 2019
#> 185            32          40.1              137 109.1       84        11 2019
#> 186           133          34.4              286 101.5      236        NA 2019
#> 187           131          33.6              301 101.8      226        NA 2019
#> 188            89          38.6              176  96.1      314        NA 2019
#> 189           140          41.0              111 112.7       38        NA 2019
#> 190           203          38.3              182 104.9      167        NA 2019
#> 191            73          37.6              195 105.4      158        NA 2019
#> 192           246          34.3              289  96.6      308        NA 2019
#> 193           263          36.9              223 108.2      103        NA 2019
#> 194           130          40.7              121 106.7      133        NA 2019
#> 195           347          42.9               72  96.1      316        NA 2019
#> 196           117          47.7               13 100.7      251        NA 2019
#> 197            37          45.3               36 104.1      182        NA 2019
#> 198           134          46.5               18 113.0       35        12 2019
#> 199           321          37.2              212 103.1      199        NA 2019
#> 200           167          40.7              122 100.6      253        NA 2019
#> 201           312          37.5              205  98.6      283        NA 2019
#> 202           264          37.9              189 103.4      193        NA 2019
#> 203           326          37.3              211 106.4      141        NA 2019
#> 204           334          30.3              339 101.3      243        NA 2019
#> 205           103          48.3                9 108.3      101        NA 2019
#> 206           212          40.8              118  99.6      269        NA 2019
#> 207           337          36.6              232 108.5       93        NA 2019
#> 208           175          39.5              150 105.0      163        NA 2019
#> 209           218          40.2              132 106.1      146        NA 2019
#> 210           293          39.6              148  96.4      311        NA 2019
#> 211            23          40.9              114  99.5      272        NA 2019
#> 212           141          33.0              314 103.3      197        NA 2019
#> 213            86          44.1               46 115.2       21         6 2019
#> 214           238          37.6              198 105.5      153        NA 2019
#> 215           198          35.5              259 109.7       73        11 2019
#> 216           180          38.7              171 102.7      205        NA 2019
#> 217           192          34.4              285  89.9      345        NA 2019
#> 218           270          39.3              154 109.9       69        NA 2019
#> 219           252          53.6                2 106.7      134        NA 2019
#> 220           329          40.2              134  96.1      315        NA 2019
#> 221            43          38.4              179 108.4       98         4 2019
#> 222           149          31.9              327 103.0      201        NA 2019
#> 223           210          37.5              199 113.5       30        NA 2019
#> 224           207          43.3               66 110.5       61        10 2019
#> 225            82          29.2              347  97.0      302        NA 2019
#> 226           191          43.5               61 109.9       68        NA 2019
#> 227            51          38.7              175 102.6      208        NA 2019
#> 228           338          35.2              266  95.5      320        NA 2019
#> 229           223          43.2               68 110.5       59         8 2019
#> 230           236          40.9              115 102.9      202        NA 2019
#> 231            20          34.5              283 112.1       43        NA 2019
#> 232           251          37.7              193 112.8       36         4 2019
#> 233            78          41.1              108  89.6      346        NA 2019
#> 234           189          29.6              342  96.6      309        NA 2019
#> 235           208          39.0              163 107.6      113        NA 2019
#> 236            56          37.4              207 111.1       56        NA 2019
#> 237           232          36.9              221 104.9      168        NA 2019
#> 238           105          43.5               58 100.0      257        NA 2019
#> 239           292          27.3              351  92.8      337        NA 2019
#> 240            84          36.4              237 112.0       46        NA 2019
#> 241           296          43.5               63  96.7      306        NA 2019
#> 242           163          35.4              260 103.8      186        NA 2019
#> 243            97          37.4              206 109.2       80        11 2019
#> 244           274          34.3              288 104.6      173        NA 2019
#> 245            30          35.8              250  92.0      339        NA 2019
#> 246            29          42.4               86  99.9      264        NA 2019
#> 247           158          40.3              131  94.6      329        NA 2019
#> 248           254          35.6              256 108.0      106        NA 2019
#> 249           303          33.9              297  97.2      301        NA 2019
#> 250           215          33.2              308 102.1      218        NA 2019
#> 251           260          31.8              329 105.1      162        NA 2019
#> 252           203          38.5              178 101.4      240        NA 2019
#> 253           352          29.3              346 100.2      255        NA 2019
#> 254           193          37.7              194  96.5      310        NA 2019
#> 255           135          45.5               34  99.9      263        NA 2019
#> 256           331          40.8              117  98.9      280        NA 2019
#> 257            33          35.0              273 105.0      164        NA 2019
#> 258           316          36.9              224  99.5      271        NA 2019
#> 259           268          31.8              328  94.2      330        NA 2019
#> 260           339          34.4              287 107.1      123        NA 2019
#> 261           146          48.1               10  84.4      353        NA 2019
#> 262           187          35.5              258 102.1      220        NA 2019
#> 263           349          31.2              331 108.5       94        NA 2019
#> 264           324          42.1               92  99.5      273        NA 2019
#> 265            74          38.1              186 102.4      212        NA 2019
#> 266           342          34.6              280  94.7      327        NA 2019
#> 267           284          31.1              332  98.3      287        NA 2019
#> 268           179          36.7              228 109.0       87        10 2019
#> 269           119          40.5              124 100.6      252        NA 2019
#> 270            38          43.1               70 101.6      230        NA 2019
#> 271           150          33.0              313  93.6      332        NA 2019
#> 272           177          34.9              274 106.8      131        NA 2019
#> 273           267          33.9              298 102.1      219        16 2019
#> 274           327          45.9               27 104.8      169        NA 2019
#> 275           318          35.4              261  98.3      288        NA 2019
#> 276           322          37.5              202 102.4      210        NA 2019
#> 277            75          34.1              293  94.6      328        NA 2019
#> 278            94          44.4               42 104.6      171        NA 2019
#> 279           241          44.7               37 105.4      159        NA 2019
#> 280           288          32.9              316 102.5      209        NA 2019
#> 281            93          36.1              242 109.2       81        NA 2019
#> 282            98          37.1              217 106.1      143        NA 2019
#> 283           128          35.6              255 105.2      161        NA 2019
#> 284           333          39.0              164  95.2      323        NA 2019
#> 285            87          44.1               45  93.3      334        NA 2019
#> 286            39          36.6              229 111.7       48        NA 2019
#> 287           341          40.3              130  97.0      303        NA 2019
#> 288           256          36.5              235 109.4       77        NA 2019
#> 289           239          39.2              157  99.8      266        NA 2019
#> 290           313          34.2              291 117.7       12         3 2019
#> 291           297          38.9              169  90.1      343        NA 2019
#> 292            16          37.6              197  97.3      300        NA 2019
#> 293            28          43.5               62  96.3      312        NA 2019
#> 294           247          38.0              187 107.2      119        NA 2019
#> 295           201          43.1               69  99.8      265        NA 2019
#> 296           100          36.7              226  97.3      299        NA 2019
#> 297           273          36.6              230 103.7      187        NA 2019
#> 298           261          42.1               93  93.3      333        NA 2019
#> 299           245          47.6               15 100.0      259        NA 2019
#> 300            31          29.6              343 111.4       52        10 2019
#> 301            77          28.2              350 103.6      191        NA 2019
#> 302           110          39.1              160 109.8       71        NA 2019
#> 303            22          36.6              231  97.8      295        16 2019
#> 304            98          43.7               53 108.0      105        NA 2019
#> 305           160          32.0              326  87.0      350        NA 2019
#> 306           277          22.6              353  92.0      338        NA 2019
#> 307           138          42.0               94  96.2      313        NA 2019
#> 308            61          29.7              340  99.6      270        NA 2019
#> 309             9          40.7              120 102.9      204        NA 2019
#> 310           170          36.2              240  89.3      348        NA 2019
#> 311           200          33.6              299 109.1       82        NA 2019
#> 312           220          33.2              306 105.6      152        NA 2019
#> 313           272          41.1              107  94.8      326        NA 2019
#> 314           229          32.7              318  99.1      276        NA 2019
#> 315           227          42.2               88 102.2      215        NA 2019
#> 316           230          34.3              290  95.4      321        NA 2019
#> 317           280          42.6               82  95.6      319        NA 2019
#> 318           301          30.5              335 105.4      157        NA 2019
#> 319           120          39.1              159 106.6      135        NA 2019
#> 320           344          32.3              322 102.6      207        NA 2019
#> 321           259          28.7              348  89.9      344        NA 2019
#> 322           172          35.0              272  97.9      293        NA 2019
#> 323            76          32.4              321  98.1      292        NA 2019
#> 324           139          33.2              307  98.2      291        NA 2019
#> 325             3          37.8              191  93.3      335        NA 2019
#> 326           317          30.8              334  98.3      286        NA 2019
#> 327           156          37.3              209 120.0        7         1 2019
#> 328           304          35.3              264 104.4      175        NA 2019
#> 329           299          36.0              245 107.2      120        NA 2019
#> 330            46          33.4              303 101.7      228        NA 2019
#> 331           283          39.3              155  99.2      275        NA 2019
#> 332            85          41.2              104 104.3      177         8 2019
#> 333           107          40.6              123 101.3      241        NA 2019
#> 334           209          27.2              352  90.4      340        NA 2019
#> 335           116          32.9              315 102.2      214        13 2019
#> 336           282          35.5              257  96.9      304        NA 2019
#> 337           174          33.6              300  99.7      267        NA 2019
#> 338           343          40.5              125  98.9      279        NA 2019
#> 339           143          45.9               25  93.9      331        NA 2019
#> 340           335          34.9              277 103.4      195        NA 2019
#> 341           237          39.1              161 101.9      224        NA 2019
#> 342           330          40.8              119  95.3      322        NA 2019
#> 343            59          34.6              278  98.9      278        NA 2019
#> 344           287          29.5              344  93.2      336        NA 2019
#> 345           250          41.1              106 102.4      211        NA 2019
#> 346            72          57.7                1  96.6      307        NA 2019
#> 347           291          40.0              142  84.5      352        NA 2019
#> 348           309          46.0               23  88.9      349        NA 2019
#> 349           206          30.4              337  98.7      282        NA 2019
#> 350           306          35.9              249  90.1      342        NA 2019
#> 351           262          32.1              325 103.8      185        NA 2019
#> 352           148          36.2              241  85.4      351        NA 2019
#> 353           243          31.3              330  90.2      341        NA 2019
#> 354            37          41.3               89 116.3        7         5 2020
#> 355           173          37.3              180 117.1        6         4 2020
#> 356           234          37.3              179 104.7      140        NA 2020
#> 357           241          32.9              282 108.6       63        NA 2020
#> 358           329          35.9              225 113.7       16         8 2020
#> 359            63          42.7               59 118.2        3         2 2020
#> 360           157          31.3              303 121.3        1         1 2020
#> 361           302          41.4               87 112.7       23        NA 2020
#> 362            82          42.9               53 110.3       44        NA 2020
#> 363           130          44.6               29 114.0       14         9 2020
#> 364            86          42.2               70 115.1       11         2 2020
#> 365            34          52.2                1 112.0       31        NA 2020
#> 366           210          41.7               83 105.4      124        NA 2020
#> 367           119          38.7              141  94.3      317        NA 2020
#> 368           134          38.0              164 114.5       12         4 2020
#> 369           199          34.2              259 105.8      113        NA 2020
#> 370           229          40.9               94 111.2       34        13 2020
#> 371           249          45.1               28 110.2       45        NA 2020
#> 372           155          27.7              344 104.1      152        12 2020
#> 373           300          38.0              163 108.7       62        14 2020
#> 374           192          35.2              238 104.4      143        NA 2020
#> 375           204          33.9              262 107.4       82        NA 2020
#> 376            92          41.4               86 114.3       13         5 2020
#> 377            65          35.9              223 103.0      172        NA 2020
#> 378           227          36.6              210 100.1      218        NA 2020
#> 379           182          31.6              300 106.8       92        14 2020
#> 380            14          39.0              136 119.1        2         1 2020
#> 381           181          40.2              109 105.4      123        NA 2020
#> 382            25          42.2               71 107.8       76        NA 2020
#> 383            64          42.0               75 107.9       73        12 2020
#> 384            28          38.9              137 109.3       52        NA 2020
#> 385           127          45.4               24 107.3       83        NA 2020
#> 386            66          44.3               32 112.5       26        NA 2020
#> 387            39          41.8               80 106.3      102        NA 2020
#> 388           141          31.8              294 102.4      178        NA 2020
#> 389            70          32.8              285 105.8      109        NA 2020
#> 390           353          37.4              178  98.3      250        NA 2020
#> 391           290          27.6              345 103.2      169        NA 2020
#> 392           136          38.9              139 102.2      181        NA 2020
#> 393           294          33.0              279 102.9      175        NA 2020
#> 394           205          44.3               33 108.5       66        13 2020
#> 395            49          37.8              167 109.2       53        11 2020
#> 396             2          39.6              118 100.5      212        16 2020
#> 397           344          29.8              319 107.6       81        NA 2020
#> 398            44          31.1              307 103.7      159        NA 2020
#> 399            58          47.3               15 113.9       15         2 2020
#> 400           196          42.2               69  98.4      248        NA 2020
#> 401           158          37.7              168 105.6      115        NA 2020
#> 402           151          37.1              186  96.4      279        NA 2020
#> 403           168          46.0               23 107.2       86        NA 2020
#> 404            33          51.3                2 100.7      207        NA 2020
#> 405           195          41.7               82 106.6       93        NA 2020
#> 406           304          36.1              218 102.1      186        NA 2020
#> 407           135          29.9              318 105.4      121        14 2020
#> 408           172          44.2               36 107.0       89        NA 2020
#> 409           273          39.5              122 108.7       60        NA 2020
#> 410            10          36.6              209 109.8       47        10 2020
#> 411           264          33.7              265 104.9      132        NA 2020
#> 412           170          33.2              275 107.2       87        16 2020
#> 413           213          36.3              213 110.0       46        NA 2020
#> 414             7          43.0               52 105.5      119        NA 2020
#> 415           292          33.8              263 104.8      133        NA 2020
#> 416            29          37.0              189 100.0      219        NA 2020
#> 417           237          33.4              273 106.9       90        NA 2020
#> 418           352          37.1              185  98.7      243        NA 2020
#> 419           189          33.9              260 102.3      179        NA 2020
#> 420           312          29.6              328  94.2      320        NA 2020
#> 421            32          34.7              249 111.0       35         7 2020
#> 422            74          37.1              187 100.1      216        NA 2020
#> 423           288          46.3               21 106.8       91        15 2020
#> 424           193          44.5               31 110.8       40         4 2020
#> 425           256          38.3              155 105.6      116        NA 2020
#> 426           218          38.5              146 105.6      118        NA 2020
#> 427           118          49.3                6 100.6      208        NA 2020
#> 428           269          36.8              195  98.3      251        NA 2020
#> 429           171          31.5              301 115.7        9         3 2020
#> 430            16          47.7               13 104.3      147        NA 2020
#> 431           143          39.0              133 103.3      167        NA 2020
#> 432           251          35.4              234  97.5      263        NA 2020
#> 433            52          37.5              174 107.2       85        NA 2020
#> 434           250          35.4              233 111.7       32         2 2020
#> 435            15          33.1              277 106.4       99        15 2020
#> 436           109          38.6              144 109.1       54         8 2020
#> 437           116          36.9              194 113.5       17         1 2020
#> 438           179          32.9              280 108.7       61        NA 2020
#> 439            80          32.1              292 104.3      145         9 2020
#> 440           318          40.1              111 105.0      129        NA 2020
#> 441            48          36.0              221 102.6      176        NA 2020
#> 442           177          40.0              113 106.1      107        12 2020
#> 443            12          38.5              147 102.0      189        NA 2020
#> 444           178          49.0                8 111.0       37        NA 2020
#> 445           208          42.1               73  95.8      294        NA 2020
#> 446            95          35.3              236  99.5      229        NA 2020
#> 447            13          43.6               44 106.5       97        14 2020
#> 448           330          31.6              299  90.3      342        NA 2020
#> 449             1          37.5              176 115.2       10         3 2020
#> 450             5          50.6                4 100.2      215        NA 2020
#> 451           293          33.7              266 105.7      114        NA 2020
#> 452           289          36.8              199 112.5       27         9 2020
#> 453            96          37.2              182  93.6      326        NA 2020
#> 454             3          37.6              172 117.3        5         6 2020
#> 455            30          40.5              101  96.8      275        NA 2020
#> 456           149          37.2              183 104.7      138        NA 2020
#> 457            46          31.0              309 111.0       36        NA 2020
#> 458            40          46.6               18 107.6       80        13 2020
#> 459            69          40.2              108  94.4      312        NA 2020
#> 460           138          46.6               17 107.7       78        NA 2020
#> 461             6          45.1               27 110.7       41        NA 2020
#> 462           104          43.6               43 104.7      136        16 2020
#> 463            20          42.4               63 105.4      120        15 2020
#> 464           236          48.8                9  91.3      339        NA 2020
#> 465           320          42.8               56 104.2      149        NA 2020
#> 466           100          35.6              231  94.4      314        NA 2020
#> 467           221          41.8               78  96.2      285        NA 2020
#> 468           166          26.6              350 112.7       24         4 2020
#> 469           295          36.6              207 104.3      146        NA 2020
#> 470            68          35.4              235 106.1      106        NA 2020
#> 471            60          42.8               57 103.6      161        NA 2020
#> 472           254          38.4              150  96.9      271        NA 2020
#> 473           152          45.4               25  97.4      265        NA 2020
#> 474           285          32.5              288  95.4      300        NA 2020
#> 475            98          27.1              347 105.8      111        NA 2020
#> 476           200          36.8              198 112.6       25         5 2020
#> 477           122          33.5              271 106.6       95        NA 2020
#> 478           202          47.9               12 104.5      142        NA 2020
#> 479            22          32.2              291 104.2      148        NA 2020
#> 480           201          41.4               88 103.7      157        NA 2020
#> 481           313          33.6              269 100.8      206        NA 2020
#> 482           258          33.1              278 103.4      164        NA 2020
#> 483           235          40.0              112  90.2      343        NA 2020
#> 484           298          28.0              341 103.8      156        NA 2020
#> 485           197          32.5              287 115.8        8         1 2020
#> 486           147          41.2               90  98.2      252        NA 2020
#> 487            47          40.3              104 104.5      141        NA 2020
#> 488           328          30.2              315 103.2      170        NA 2020
#> 489           334          33.6              270  95.2      301        NA 2020
#> 490            51          50.7                3 105.8      110        NA 2020
#> 491           162          36.8              200  98.5      247        NA 2020
#> 492           255          34.8              246 101.1      202        NA 2020
#> 493           206          39.2              128 108.2       69        11 2020
#> 494           150          39.1              129 113.2       20         6 2020
#> 495           232          32.5              290  98.2      253        NA 2020
#> 496           346          36.7              203  99.8      222        NA 2020
#> 497            61          37.9              166  96.4      280        NA 2020
#> 498           272          30.5              313 108.8       57        NA 2020
#> 499           223          40.3              106 106.1      105        NA 2020
#> 500           180          49.1                7 105.1      127        NA 2020
#> 501           262          29.8              320  97.0      269        NA 2020
#> 502            21          40.7               96 112.1       30        NA 2020
#> 503           187          35.2              240 101.2      201        NA 2020
#> 504           110          38.8              140  99.4      231        NA 2020
#> 505           203          34.3              256 112.7       22         7 2020
#> 506           142          34.8              245  96.1      287        NA 2020
#> 507           115          35.7              228 104.4      144        NA 2020
#> 508           224          42.0               74 107.0       88        NA 2020
#> 509           322          32.8              284  98.6      245        NA 2020
#> 510            83          41.6               84  99.6      226        NA 2020
#> 511           191          28.0              342 113.4       19        NA 2020
#> 512           306          41.4               85 102.0      188        NA 2020
#> 513            19          43.4               45 100.6      211        NA 2020
#> 514           345          28.4              339 101.5      195        NA 2020
#> 515            55          38.3              156 106.3      100        NA 2020
#> 516           307          36.3              214  96.0      289        NA 2020
#> 517            87          47.9               11  99.2      235        NA 2020
#> 518            67          40.5               99 112.3       29         3 2020
#> 519           284          42.9               55  97.7      260        NA 2020
#> 520           315          43.2               48 108.3       68        NA 2020
#> 521           316          36.7              206  99.7      223        NA 2020
#> 522           248          42.9               54 104.1      153        NA 2020
#> 523           148          36.9              193  99.1      238        NA 2020
#> 524           261          40.3              105 101.9      192        NA 2020
#> 525           277          39.9              114 109.1       55        NA 2020
#> 526           188          30.7              311  96.3      283        NA 2020
#> 527            76          42.4               64  93.9      325        NA 2020
#> 528           311          36.8              197 108.2       70        NA 2020
#> 529           326          38.1              159 105.1      128        NA 2020
#> 530           259          44.3               35 104.7      139        NA 2020
#> 531            89          42.4               62 101.6      194        NA 2020
#> 532           336          36.7              205 108.9       56        NA 2020
#> 533           340          31.7              295  98.1      255        NA 2020
#> 534           245          25.6              351  92.8      332        NA 2020
#> 535            27          36.6              208 107.8       75         8 2020
#> 536           282          37.7              169  99.4      232        NA 2020
#> 537           252          35.5              232 104.8      134        NA 2020
#> 538           165          42.3               67  97.5      264        NA 2020
#> 539           113          36.2              216 109.3       50        NA 2020
#> 540           160          42.4               65  95.0      304        NA 2020
#> 541           332          29.6              325 104.9      130        NA 2020
#> 542            78          38.1              161  97.6      261        NA 2020
#> 543            53          35.2              239 100.6      210        NA 2020
#> 544            77          42.3               68 112.8       21        NA 2020
#> 545           131          43.7               42 106.5       98        13 2020
#> 546           105          40.2              110 102.9      174        NA 2020
#> 547             9          38.2              158 109.6       49        11 2020
#> 548           308          38.0              165 104.7      137        NA 2020
#> 549            23          36.4              212  98.8      242        NA 2020
#> 550            50          39.3              124 105.6      117        11 2020
#> 551           314          34.3              257 118.1        4         8 2020
#> 552           216          39.0              132 102.2      185        NA 2020
#> 553           128          26.8              348  99.3      233        NA 2020
#> 554            57          44.0               39  94.3      316        NA 2020
#> 555            85          36.8              196 105.3      125        NA 2020
#> 556           121          43.9               40 103.4      163        NA 2020
#> 557           198          29.6              326 108.5       65        10 2020
#> 558           140          39.6              119 110.3       43         6 2020
#> 559           185          36.1              220  96.9      272        NA 2020
#> 560           184          38.4              151 105.8      112        NA 2020
#> 561            72          39.2              127 101.2      198        NA 2020
#> 562            17          34.9              242 110.9       39        NA 2020
#> 563           174          31.1              306 104.8      135        NA 2020
#> 564            91          47.7               14  94.9      305        NA 2020
#> 565           266          40.7               97 102.2      183        NA 2020
#> 566           299          48.3               10  99.7      224        NA 2020
#> 567           103          29.8              321  98.7      244        NA 2020
#> 568           190          35.8              227 108.6       64        NA 2020
#> 569            59          43.2               49  92.5      334        NA 2020
#> 570            18          36.9              191 100.4      213        NA 2020
#> 571            11          42.8               58 112.4       28        NA 2020
#> 572            94          38.5              149 103.5      162        NA 2020
#> 573           338          36.9              192 106.0      108        10 2020
#> 574           244          40.5              102  99.5      230        NA 2020
#> 575           310          39.5              121 102.2      184        NA 2020
#> 576           319          44.1               38  99.9      221        NA 2020
#> 577            36          35.0              241 100.1      217        NA 2020
#> 578           278          33.6              268  95.9      292        NA 2020
#> 579           126          33.5              272 109.3       51        11 2020
#> 580           123          34.3              258 103.2      168        NA 2020
#> 581           279          34.4              253 103.4      166        16 2020
#> 582           309          29.2              331  95.0      303        NA 2020
#> 583           246          34.7              248  94.0      324        NA 2020
#> 584           106          31.3              304 106.1      104        NA 2020
#> 585           167          42.5               61  99.2      236        NA 2020
#> 586           176          33.3              274 100.9      204        NA 2020
#> 587           194          36.7              202  95.5      295        NA 2020
#> 588           276          38.1              160  95.9      291        NA 2020
#> 589           124          33.7              264 103.7      158        NA 2020
#> 590           287          41.1               92 101.3      196        NA 2020
#> 591           291          42.4               66 103.7      160        NA 2020
#> 592           226          40.2              107 107.9       74        NA 2020
#> 593           120          43.3               46  97.8      257        NA 2020
#> 594           144          42.6               60  96.9      274        NA 2020
#> 595            42          36.1              219 108.8       59        12 2020
#> 596           207          44.3               34  95.4      299        NA 2020
#> 597           239          35.6              230 110.7       42        11 2020
#> 598            54          43.1               50 106.6       94        NA 2020
#> 599           275          42.1               72  99.7      225        NA 2020
#> 600           137          43.8               41  95.4      296        NA 2020
#> 601           259          38.9              138 108.8       58        10 2020
#> 602           163          46.4               20  94.1      322        NA 2020
#> 603           112          39.6              120 102.0      190        NA 2020
#> 604           324          31.4              302  98.8      240        NA 2020
#> 605           107          41.7               81  89.1      347        NA 2020
#> 606            71          28.4              338 106.3      101        NA 2020
#> 607           305          34.8              244  96.0      290        NA 2020
#> 608           351          37.2              184 107.7       79        NA 2020
#> 609           297          31.6              298  95.4      298        NA 2020
#> 610           337          29.5              330 100.8      205        NA 2020
#> 611            38          44.5               30  96.2      284        NA 2020
#> 612           125          35.2              237  94.5      310        NA 2020
#> 613           247          39.4              123  96.0      288        NA 2020
#> 614           209          38.5              148 101.2      199        NA 2020
#> 615           145          37.7              171 109.6       48        NA 2020
#> 616            98          28.3              340  97.1      268        NA 2020
#> 617           253          29.1              332 105.2      126        NA 2020
#> 618           164          35.9              224  95.8      293        NA 2020
#> 619           220          33.7              267 107.2       84        NA 2020
#> 620            97          46.4               19 103.9      155        NA 2020
#> 621           211          37.6              173 104.1      151        NA 2020
#> 622           257          32.5              289  97.0      270        NA 2020
#> 623            73          36.7              204  99.1      239        NA 2020
#> 624           263          32.6              286  92.1      337        NA 2020
#> 625           347          37.5              175 102.0      187        NA 2020
#> 626           317          27.1              346  96.2      286        NA 2020
#> 627           323          39.1              131  95.4      297        NA 2020
#> 628           146          29.9              317  97.2      267        NA 2020
#> 629            79          39.1              130 102.5      177        NA 2020
#> 630             4          36.1              217 106.6       96        NA 2020
#> 631           214          38.3              153  96.4      281        NA 2020
#> 632            45          33.9              261 104.9      131        NA 2020
#> 633           341          37.7              170 101.2      200        NA 2020
#> 634           283          37.5              177 103.0      173        NA 2020
#> 635            75          34.7              247 106.1      103        NA 2020
#> 636            26          40.6               98  98.0      256        NA 2020
#> 637           161          30.4              314 103.4      165        NA 2020
#> 638           183          39.8              115  96.7      276        NA 2020
#> 639            84          43.1               51 113.5       18         3 2020
#> 640           139          29.6              324 103.1      171        NA 2020
#> 641           154          42.0               76  94.2      321        NA 2020
#> 642           132          29.7              322 105.4      122        NA 2020
#> 643            81          31.2              305  92.3      336        NA 2020
#> 644            31          39.8              116  92.8      331        NA 2020
#> 645           349          39.3              126  94.1      323        NA 2020
#> 646           286          38.4              152 100.2      214        NA 2020
#> 647           267          39.3              124 102.2      182        NA 2020
#> 648           265          29.6              327 107.9       72         9 2020
#> 649           108          40.5              100  99.6      228        NA 2020
#> 650           101          41.8               79  91.2      340        NA 2020
#> 651           217          34.3              255  94.4      315        NA 2020
#> 652           133          36.6              211  94.2      319        16 2020
#> 653           117          45.3               26 102.0      191        15 2020
#> 654           238          44.1               37 111.4       33         5 2020
#> 655           159          37.0              190  97.3      266        NA 2020
#> 656           327          28.6              337  99.1      237        NA 2020
#> 657           301          32.9              281  94.7      307        NA 2020
#> 658           243          36.0              222  86.9      349        NA 2020
#> 659           102          28.9              334 107.7       77        NA 2020
#> 660           271          38.1              162  96.4      278        NA 2020
#> 661           302          34.5              251 101.3      197        NA 2020
#> 662            24          41.8               77 102.3      180        NA 2020
#> 663           221          30.6              312 110.9       38         7 2020
#> 664            90          37.0              188  99.3      234         7 2020
#> 665           270          39.0              135  86.2      350        NA 2020
#> 666            35          26.7              349  96.3      282        16 2020
#> 667           114          37.2              181  96.5      277        NA 2020
#> 668            62          34.3              254  97.7      259        NA 2020
#> 669           242          38.5              145  99.9      220        NA 2020
#> 670           350          35.6              229  98.8      241        NA 2020
#> 671           281          38.7              142  97.8      258        NA 2020
#> 672           225          38.7              143 108.2       71        NA 2020
#> 673           219          27.7              343  93.1      328        NA 2020
#> 674           230          35.9              226  92.0      338        NA 2020
#> 675            88          30.1              316  94.4      313        NA 2020
#> 676           111          40.8               95  96.9      273        NA 2020
#> 677           331          36.2              215  95.2      302        NA 2020
#> 678           169          49.7                5 101.9      193        NA 2020
#> 679           215          40.4              103 104.1      150        NA 2020
#> 680           233          34.9              243 100.6      209        NA 2020
#> 681            93          46.3               22  97.5      262        NA 2020
#> 682            56          32.1              293  92.3      335        NA 2020
#> 683           129          31.7              297 104.0      154        NA 2020
#> 684           156          41.0               93 101.0      203        NA 2020
#> 685           342          41.2               91  89.8      345        NA 2020
#> 686            41          38.2              157  98.6      246        NA 2020
#> 687           240          39.0              134  98.1      254        NA 2020
#> 688           321          33.1              276  98.3      249        NA 2020
#> 689           296          34.7              250  94.6      308        NA 2020
#> 690           175          36.8              201  90.3      341        NA 2020
#> 691           231          29.6              329 108.3       67         6 2020
#> 692           335          29.1              333  90.1      344        NA 2020
#> 693           212          22.4              353  92.9      329        NA 2020
#> 694           343          23.8              352  94.4      311        NA 2020
#> 695             8          43.3               47  92.9      330        NA 2020
#> 696           333          46.9               16  89.6      346        NA 2020
#> 697           228          31.7              296  87.9      348        NA 2020
#> 698           280          29.6              323  94.9      306        NA 2020
#> 699            43          32.8              283  99.6      227        NA 2020
#> 700           274          31.0              308  93.2      327        NA 2020
#> 701           186          34.4              252  94.6      309        NA 2020
#> 702           348          38.3              154  94.2      318        NA 2020
#> 703           268          28.8              335  79.0      353        NA 2020
#> 704           325          28.7              336  92.8      333        NA 2020
#> 705           153          39.7              117  81.7      352        NA 2020
#> 706           339          30.9              310  83.5      351        NA 2020
#> 707            86          38.4              159 125.0        2         1 2021
#> 708           203          35.1              232 111.5       39        NA 2021
#> 709            56          36.5              196 110.3       53        14 2021
#> 710           164          40.5               91 100.3      214        NA 2021
#> 711            13          40.3               96 104.3      131        NA 2021
#> 712           136          27.0              340  99.6      228        NA 2021
#> 713           141          44.6               31 109.3       65        NA 2021
#> 714           155          33.8              263 107.3       97        NA 2021
#> 715            48          47.0               16 109.8       58        13 2021
#> 716             4          39.8              108 123.5        3         2 2021
#> 717           336          39.9              105 102.2      170        NA 2021
#> 718           173          39.7              112  93.6      308        NA 2021
#> 719            45          33.9              261 117.6        9         1 2021
#> 720           216          35.7              222 101.6      188        NA 2021
#> 721           180          42.7               46  96.5      277        NA 2021
#> 722           163          40.5               89 103.2      160        NA 2021
#> 723           307          30.5              314 102.4      168        NA 2021
#> 724           215          37.6              173 117.2       10         7 2021
#> 725           194          49.0                7 105.8      114        NA 2021
#> 726           327          46.6               17 109.3       66        15 2021
#> 727           150          34.9              238 114.9       16         4 2021
#> 728           335          43.1               45  99.0      238        NA 2021
#> 729           318          36.2              214 100.7      202        NA 2021
#> 730            98          42.7               48 114.7       17         4 2021
#> 731           185          28.7              328  97.0      270        NA 2021
#> 732            90          28.5              331  99.2      233        NA 2021
#> 733            95          36.5              197 102.9      162        NA 2021
#> 734            91          31.5              303 108.3       78        NA 2021
#> 735            82          45.2               26 114.3       19        NA 2021
#> 736            77          30.0              320 118.0        8         1 2021
#> 737            49          41.6               62 100.0      219        NA 2021
#> 738           252          35.6              224  99.1      234        16 2021
#> 739           143          36.4              201 116.3       13         5 2021
#> 740            97          41.6               64 108.3       77        NA 2021
#> 741           191          31.6              301 116.9       11        11 2021
#> 742           162          37.6              172 106.7      101        13 2021
#> 743            20          31.4              304 115.6       15        NA 2021
#> 744            22          36.6              195  95.7      283        NA 2021
#> 745           112          42.3               53 103.6      147        NA 2021
#> 746            37          35.5              225 106.5      104        16 2021
#> 747           160          45.4               25 107.8       88        NA 2021
#> 748           165          32.9              282 108.3       80        NA 2021
#> 749             5          49.0                6 101.7      182        NA 2021
#> 750           106          40.4               94 111.0       45         6 2021
#> 751            79          33.2              275 126.4        1         1 2021
#> 752            55          43.4               42 113.8       21        NA 2021
#> 753            78          38.6              150 113.7       23         6 2021
#> 754           205          28.1              334  98.8      239        NA 2021
#> 755            60          38.6              157 106.2      108        NA 2021
#> 756            36          39.9              104 103.3      158        NA 2021
#> 757           219          36.9              187 107.7       91        NA 2021
#> 758            40          34.1              252  98.1      249        NA 2021
#> 759           110          40.8               82 113.0       29         9 2021
#> 760           176          38.9              142 107.9       87        12 2021
#> 761           131          33.1              279 116.8       12         3 2021
#> 762             2          36.0              218 101.7      184        14 2021
#> 763           292          31.6              302 112.5       33        11 2021
#> 764            18          36.1              216 105.5      117        NA 2021
#> 765           109          34.6              245  99.0      237        NA 2021
#> 766           284          38.9              140 106.0      111        NA 2021
#> 767           190          48.0               14 101.9      176        NA 2021
#> 768            88          43.6               40 113.4       25         5 2021
#> 769           161          43.9               39 104.5      130        NA 2021
#> 770            21          38.6              154 102.9      163        NA 2021
#> 771            32          49.0                8 103.9      141        NA 2021
#> 772           201          31.0              310 115.7       14         6 2021
#> 773           120          34.0              254  97.6      258        NA 2021
#> 774           224          39.2              130 120.7        4         2 2021
#> 775           101          39.8              106 109.5       62        14 2021
#> 776           127          41.0               78 109.2       67        NA 2021
#> 777           295          33.8              262  97.6      256        NA 2021
#> 778           251          32.7              287 109.4       63        NA 2021
#> 779           119          42.5               52 100.3      212        NA 2021
#> 780           126          40.0              101 101.0      197        NA 2021
#> 781           286          39.1              133 100.6      204        NA 2021
#> 782            42          48.3               12 113.9       20        NA 2021
#> 783           298          38.6              155 101.7      185        NA 2021
#> 784           107          48.8                9 109.1       68        NA 2021
#> 785            23          39.3              128 111.4       40        13 2021
#> 786           199          42.1               56 113.1       28         3 2021
#> 787           322          33.8              264 111.0       44         7 2021
#> 788           296          32.8              284 100.3      211        NA 2021
#> 789           310          32.8              285  97.2      265        NA 2021
#> 790            81          51.7                1 106.4      106        NA 2021
#> 791            43          34.6              243 112.7       31        NA 2021
#> 792           148          40.2               99 106.5      103        NA 2021
#> 793            52          39.3              127 108.8       72        NA 2021
#> 794           226          41.1               76 101.9      174        NA 2021
#> 795            73          41.0               79 109.7       59        10 2021
#> 796           243          40.3               97 103.0      161        NA 2021
#> 797            16          37.1              183 111.3       41         8 2021
#> 798           172          31.3              305 112.7       32         6 2021
#> 799           186          43.9               38  98.5      242        NA 2021
#> 800            51          44.8               30 119.0        6         5 2021
#> 801           114          43.1               44 111.8       37        10 2021
#> 802           230          39.0              136  98.2      246        NA 2021
#> 803           209          31.2              307  99.5      229        NA 2021
#> 804            57          44.0               37 108.1       83        NA 2021
#> 805            27          39.6              115  95.5      287        NA 2021
#> 806            69          38.6              152 114.5       18        NA 2021
#> 807           210          46.5               18 112.9       30         2 2021
#> 808           115          39.3              129 105.0      124        12 2021
#> 809           187          34.5              247 100.6      205        14 2021
#> 810           232          33.4              269  96.2      278        NA 2021
#> 811            25          35.3              231 112.1       36        12 2021
#> 812           332          44.2               33 103.3      157        NA 2021
#> 813           223          46.0               22 101.3      191        NA 2021
#> 814            54          37.1              180 110.8       47        NA 2021
#> 815           277          33.2              277  98.4      244        NA 2021
#> 816           200          38.6              153 107.8       90        NA 2021
#> 817            68          40.3               95 113.7       24        11 2021
#> 818           157          47.1               15 108.9       71        NA 2021
#> 819           283          41.0               77 103.2      159        NA 2021
#> 820           180          39.0              139 109.1       69        NA 2021
#> 821           159          42.2               55 118.3        7         2 2021
#> 822            53          36.4              202 113.7       22         9 2021
#> 823            67          48.3               13 109.8       57        NA 2021
#> 824           139          35.8              221 110.9       46        NA 2021
#> 825           258          34.6              246  94.2      304        NA 2021
#> 826           211          36.7              190 104.2      133        NA 2021
#> 827             7          31.0              309 110.4       50        NA 2021
#> 828           121          41.2               70 101.3      193        NA 2021
#> 829           338          37.0              186 120.1        5         8 2021
#> 830            14          42.7               49 109.4       64        NA 2021
#> 831            19          26.6              343 100.5      207        NA 2021
#> 832           255          33.6              265  96.7      273        NA 2021
#> 833            96          37.7              169 100.2      217        15 2021
#> 834           260          34.9              237  99.8      223        NA 2021
#> 835            38          40.5               88 104.3      132        NA 2021
#> 836             3          45.4               24  98.2      247        NA 2021
#> 837           146          39.7              114 104.9      125        NA 2021
#> 838           316          37.5              174  98.0      251        NA 2021
#> 839           111          32.8              286 106.6      102        NA 2021
#> 840           238          41.2               72 103.7      143        NA 2021
#> 841            59          43.4               43 106.4      107         7 2021
#> 842            71          35.1              235 105.7      115        NA 2021
#> 843            65          33.3              274 111.2       42        NA 2021
#> 844            92          40.7               84 105.5      118        NA 2021
#> 845           152          35.1              233  99.8      224        NA 2021
#> 846           134          38.9              144  96.2      279        NA 2021
#> 847            66          31.9              298 110.0       55         9 2021
#> 848            33          34.0              256 109.9       56        12 2021
#> 849           100          39.4              122  99.3      231        NA 2021
#> 850           202          28.0              335 107.7       93        NA 2021
#> 851            11          38.7              149 101.5      189        NA 2021
#> 852           167          41.2               71 103.4      154        NA 2021
#> 853           170          39.6              116 102.4      167        NA 2021
#> 854           222          38.2              160 112.1       35         8 2021
#> 855           103          31.6              300  90.6      338        NA 2021
#> 856           330          36.2              211 103.7      144        NA 2021
#> 857           180          36.4              200 100.9      198        NA 2021
#> 858           304          37.1              181 100.6      203        NA 2021
#> 859           308          36.4              204 102.1      173        NA 2021
#> 860           267          29.3              325  88.1      349        NA 2021
#> 861           269          39.5              121  98.7      240        NA 2021
#> 862           290          50.3                2 106.9      100        NA 2021
#> 863            35          39.0              137  93.2      313        NA 2021
#> 864           197          31.2              308 107.4       95        NA 2021
#> 865            75          28.6              330  97.3      260        NA 2021
#> 866           177          40.1              100  94.8      293        NA 2021
#> 867            41          33.2              278 108.2       81        NA 2021
#> 868           129          40.7               85 109.5       61        11 2021
#> 869           300          33.5              267 102.6      166        NA 2021
#> 870           147          41.9               58 112.2       34        NA 2021
#> 871           102          36.3              207 104.7      128        NA 2021
#> 872           128          26.7              342 104.6      129        NA 2021
#> 873           151          38.2              161  97.1      267        NA 2021
#> 874           122          34.9              239 107.8       89        NA 2021
#> 875           239          38.8              146  97.7      254        NA 2021
#> 876           268          34.3              250  97.3      263        NA 2021
#> 877           235          39.3              126 101.8      181        NA 2021
#> 878           196          32.2              292 108.0       84        NA 2021
#> 879           135          36.4              199 110.1       54         3 2021
#> 880           347          26.6              344  94.6      300        NA 2021
#> 881           233          33.4              270 113.1       27         7 2021
#> 882           198          37.7              170 101.7      186        NA 2021
#> 883           141          39.8              110 105.8      113        NA 2021
#> 884           206          36.7              191  94.5      301        16 2021
#> 885           270          41.6               63 108.5       74        NA 2021
#> 886           254          46.3               19 108.6       73        NA 2021
#> 887           217          35.4              228 108.4       75        NA 2021
#> 888            26          28.9              327  92.1      324        NA 2021
#> 889            84          39.8              107  92.5      321        NA 2021
#> 890           212          41.4               68 103.5      151        NA 2021
#> 891            76          37.8              167 113.3       26         4 2021
#> 892            62          36.3              205  89.4      347        NA 2021
#> 893            46          41.9               57 103.9      140        NA 2021
#> 894           257          35.5              227 104.0      137        NA 2021
#> 895           117          33.9              259 102.4      169        NA 2021
#> 896           234          41.3               69  99.9      220        NA 2021
#> 897           325          39.2              131 104.0      135        NA 2021
#> 898           274          38.8              147  94.9      289        NA 2021
#> 899            17          32.6              290 104.8      126        11 2021
#> 900           154          35.7              223  92.3      323        NA 2021
#> 901           218          33.9              260 111.1       43         3 2021
#> 902            99          42.5               50 101.8      179        NA 2021
#> 903           231          38.0              162  94.7      294        NA 2021
#> 904           273          32.2              293 109.6       60         4 2021
#> 905           213          29.3              324 100.9      199        NA 2021
#> 906           293          44.0               36  96.7      274        NA 2021
#> 907            30          34.6              244 108.0       85         5 2021
#> 908           240          36.2              213  93.3      311        NA 2021
#> 909           242          36.8              188 106.5      105        NA 2021
#> 910           288          45.4               23  97.2      266        NA 2021
#> 911            28          45.0               27  94.4      302        NA 2021
#> 912           291          46.1               21 105.1      123        NA 2021
#> 913           334          38.8              145  94.7      297        NA 2021
#> 914           287          39.1              134  97.3      262        NA 2021
#> 915           236          39.3              125 105.9      112        NA 2021
#> 916            74          41.5               67  98.2      248        NA 2021
#> 917           144          34.9              236 105.2      122        10 2021
#> 918           145          39.5              120 100.0      218        NA 2021
#> 919            34          36.2              212 108.3       79        NA 2021
#> 920           166          40.8               83 105.5      119        NA 2021
#> 921            94          48.4               11  79.4      357        NA 2021
#> 922           331          24.5              346 101.3      192        NA 2021
#> 923           248          35.9              219 101.8      180        NA 2021
#> 924           138          44.9               28 104.0      136        NA 2021
#> 925           309          36.2              210 103.3      156        NA 2021
#> 926           125          41.8               59  93.1      315        NA 2021
#> 927           116          49.1                5  97.3      264        NA 2021
#> 928           184          34.8              240  97.3      261        NA 2021
#> 929           213          36.4              203 101.1      195        NA 2021
#> 930           262          32.6              289 103.7      145        NA 2021
#> 931            70          46.1               20 111.6       38        NA 2021
#> 932           303          39.7              113  99.6      227        NA 2021
#> 933            50          44.0               35 105.4      120        NA 2021
#> 934           321          39.9              103  91.2      332        NA 2021
#> 935             9          38.8              148 110.6       48        NA 2021
#> 936           179          37.9              164 110.6       49         9 2021
#> 937           246          32.9              283 100.8      200        NA 2021
#> 938           195          35.4              229  95.5      286        NA 2021
#> 939           313          28.1              333  93.3      312        NA 2021
#> 940           174          37.6              171  92.5      320        NA 2021
#> 941           271          33.9              258 101.6      187        NA 2021
#> 942            44          32.3              291 109.1       70        NA 2021
#> 943            87          41.5               66  89.6      345        NA 2021
#> 944           133          32.1              294 107.9       86        NA 2021
#> 945           112          39.8              109 102.7      164        NA 2021
#> 946            47          29.9              321  91.5      329        NA 2021
#> 947           137          34.4              248  90.4      339        NA 2021
#> 948           280          42.5               51  97.0      271        16 2021
#> 949           207          37.4              176 107.5       94        NA 2021
#> 950           169          40.5               87  98.1      250        NA 2021
#> 951           192          38.9              141 103.3      155        NA 2021
#> 952           193          23.9              347 103.5      152        NA 2021
#> 953           346          31.8              299 100.2      215        NA 2021
#> 954           241          30.9              311 106.0      110        NA 2021
#> 955           132          34.3              249 100.6      206        15 2021
#> 956            39          42.7               47  96.0      281        NA 2021
#> 957           183          36.8              189 110.3       51        NA 2021
#> 958             6          33.9              257 107.1       98        11 2021
#> 959           279          38.6              151 100.3      213        NA 2021
#> 960           339          33.0              280  99.4      230        NA 2021
#> 961           124          33.6              266 107.3       96        NA 2021
#> 962           189          48.7               10 104.1      134        NA 2021
#> 963           324          31.3              306  98.0      253        NA 2021
#> 964           343          37.9              163 100.3      210        NA 2021
#> 965           320          37.5              175  87.2      351        NA 2021
#> 966           289          37.8              166 100.4      209        NA 2021
#> 967            72          36.2              209 105.4      121        15 2021
#> 968            85          27.9              336 110.3       52         8 2021
#> 969           249          30.5              313 100.8      201        NA 2021
#> 970           341          36.6              193  98.0      252        NA 2021
#> 971           326          41.8               60  98.6      241        NA 2021
#> 972           266          36.6              194  96.0      282        NA 2021
#> 973           229          44.5               32  98.4      245        16 2021
#> 974           301          34.7              242  84.4      355        NA 2021
#> 975           221          41.2               73  90.7      336        NA 2021
#> 976           302          38.5              158 105.5      116        NA 2021
#> 977           237          25.6              345  91.6      326        NA 2021
#> 978           337          39.5              119  95.5      285        NA 2021
#> 979            80          37.1              184  90.1      343        NA 2021
#> 980           281          35.5              226  94.9      290        NA 2021
#> 981             8          44.9               29  85.9      353        NA 2021
#> 982           305          28.3              332  97.6      257        NA 2021
#> 983           208          30.0              319  92.9      317        NA 2021
#> 984           178          36.5              198 103.5      149        NA 2021
#> 985           174          39.3              124  97.0      269        NA 2021
#> 986            61          49.2                4 101.2      194        NA 2021
#> 987           319          39.4              123  93.7      307        NA 2021
#> 988           130          26.9              341  90.2      341        NA 2021
#> 989           140          37.2              178  99.8      222        NA 2021
#> 990            89          33.5              268  98.4      243        NA 2021
#> 991           225          27.7              337  93.1      316        NA 2021
#> 992           259          31.9              296 104.7      127        NA 2021
#> 993           168          33.4              271 108.1       82        10 2021
#> 994           105          34.8              241  92.6      319        NA 2021
#> 995            15          39.1              132 103.6      148        NA 2021
#> 996           271          42.3               54  90.9      335        NA 2021
#> 997           344          27.6              338 103.5      153        NA 2021
#> 998           315          43.4               41  89.8      344        NA 2021
#> 999           253          41.2               74  91.6      328        NA 2021
#> 1000          263          41.7               61  94.1      305        NA 2021
#> 1001          153          33.0              281  94.7      296        NA 2021
#> 1002          247          36.6              192 102.2      171        NA 2021
#> 1003          311          36.3              208  97.7      255        NA 2021
#> 1004          313          30.3              316 107.7       92        NA 2021
#> 1005          297          29.5              322  91.2      331        NA 2021
#> 1006          312          39.6              118 103.8      142        NA 2021
#> 1007          256          30.3              315  96.8      272        NA 2021
#> 1008          317          37.8              168  97.1      268        NA 2021
#> 1009          340          35.8              220  94.2      303        NA 2021
#> 1010          227          34.2              251 103.9      139        NA 2021
#> 1011           31          36.1              215  94.6      299        NA 2021
#> 1012          149          31.9              297  97.4      259        NA 2021
#> 1013          156          33.3              273  95.6      284        NA 2021
#> 1014          278          35.1              234  90.6      337        NA 2021
#> 1015          108          49.5                3  91.0      334        NA 2021
#> 1016          282          38.6              156  93.7      306        NA 2021
#> 1017          342          34.0              255  91.1      333        NA 2021
#> 1018          244          30.6              312 106.1      109        NA 2021
#> 1019           58          39.6              117 102.6      165        NA 2021
#> 1020           29          40.9               80  99.6      226        NA 2021
#> 1021          104          40.5               92 101.9      175        NA 2021
#> 1022          265          32.0              295 100.4      208        NA 2021
#> 1023          306          39.0              135 103.6      146        13 2021
#> 1024           93          37.0              185 101.7      183        NA 2021
#> 1025           83          40.0              102  99.8      225        NA 2021
#> 1026            1          32.7              288  99.3      232        NA 2021
#> 1027          122          40.2               98  96.6      275        NA 2021
#> 1028          261          28.6              329 103.5      150        NA 2021
#> 1029           10          34.0              253  91.3      330        NA 2021
#> 1030          188          41.6               65  99.1      235        NA 2021
#> 1031          276          33.3              272 102.1      172        NA 2021
#> 1032          328          37.2              179  87.8      350        NA 2021
#> 1033          299          37.8              165 101.8      178        NA 2021
#> 1034          294          30.2              317 101.1      196        NA 2021
#> 1035          333          38.9              143  93.1      314        NA 2021
#> 1036          220          36.3              206  94.7      295        NA 2021
#> 1037          323          40.5               90  92.9      318        NA 2021
#> 1038          171          29.2              326  96.1      280        NA 2021
#> 1039          345          29.5              323  99.0      236        NA 2021
#> 1040          250          44.0               34  93.5      309        NA 2021
#> 1041          285          35.3              230  90.2      340        NA 2021
#> 1042          264          33.2              276  84.8      354        NA 2021
#> 1043           12          40.4               93  93.4      310        NA 2021
#> 1044          275          36.1              217  94.8      291        NA 2021
#> 1045           63          40.7               86 108.4       76        NA 2021
#> 1046          245          39.0              138  96.5      276        NA 2021
#> 1047          204          39.7              111  92.4      322        NA 2021
#> 1048          329          27.3              339  99.8      221        16 2021
#> 1049           24          41.1               75  86.3      352        NA 2021
#> 1050          158          30.1              318  91.6      327        NA 2021
#> 1051           64          37.1              182  91.8      325        NA 2021
#> 1052          118          37.3              177  89.5      346        NA 2021
#> 1053          228          40.8               81  88.3      348        NA 2021
#> 1054          348           0.0              348  90.1      342        NA 2021
#> 1055          348           0.0              348  95.2      288        NA 2021
#> 1056          348           0.0              348  94.7      298        NA 2021
#> 1057          348           0.0              348 101.4      190        NA 2021
#> 1058          348           0.0              348  94.8      292        NA 2021
#> 1059          348           0.0              348 101.9      177        NA 2021
#> 1060          348           0.0              348  83.9      356        NA 2021
#> 1061          348           0.0              348 100.2      216        NA 2021
#> 1062          348           0.0              348 104.0      138        NA 2021
#> 1063          348           0.0              348 107.1       99        NA 2021
#>      def_fg_3_pct def_fg_3_pct_rk def_fg_2_pct def_fg_2_pct_rk def_ft_pct
#> 1            33.8             137         49.8             155       73.3
#> 2            32.6              72         50.6             197       70.9
#> 3            34.5             182         48.9             121       68.2
#> 4            30.6              22         44.7              15       68.9
#> 5            35.3             225         51.3             230       70.1
#> 6            35.4             239         52.7             277       72.0
#> 7            33.9             145         50.5             194       71.0
#> 8            28.9               3         45.7              22       66.6
#> 9            32.7              75         49.0             125       72.2
#> 10           36.5             286         55.2             335       74.7
#> 11           34.2             161         47.0              53       65.8
#> 12           32.4              65         45.1              19       67.9
#> 13           35.3             227         51.5             242       70.4
#> 14           34.7             200         47.3              60       71.5
#> 15           38.5             339         52.9             281       71.3
#> 16           38.9             344         48.4              98       67.7
#> 17           33.4             115         48.4              96       68.0
#> 18           33.7             133         53.0             283       73.5
#> 19           34.4             180         53.2             290       72.6
#> 20           30.7              24         50.2             178       70.6
#> 21           34.7             199         51.4             234       71.1
#> 22           32.8              78         51.2             220       70.0
#> 23           31.4              32         46.6              39       67.9
#> 24           34.8             202         51.6             246       73.4
#> 25           35.4             236         53.5             301       71.8
#> 26           34.8             205         54.9             331       70.0
#> 27           37.2             310         53.8             313       68.6
#> 28           35.2             222         53.2             287       72.9
#> 29           35.0             213         52.9             282       68.2
#> 30           38.4             336         49.9             163       73.5
#> 31           31.6              38         41.9               2       67.9
#> 32           32.1              56         49.2             132       73.6
#> 33           33.7             132         50.4             187       72.2
#> 34           35.7             257         48.4              95       71.5
#> 35           34.5             186         50.1             174       65.2
#> 36           34.3             174         49.2             133       74.6
#> 37           33.3             110         49.8             153       72.5
#> 38           37.8             326         57.4             349       70.4
#> 39           34.3             170         55.4             337       71.2
#> 40           33.9             147         53.5             302       69.4
#> 41           32.0              54         48.5             102       75.9
#> 42           34.0             152         51.4             231       71.0
#> 43           35.1             217         47.6              67       69.9
#> 44           34.2             168         47.2              58       73.2
#> 45           35.1             216         47.3              59       70.1
#> 46           35.4             233         48.3              88       74.8
#> 47           38.0             328         52.0             259       70.2
#> 48           32.8              80         46.5              38       72.8
#> 49           35.6             252         51.3             224       68.5
#> 50           30.7              23         53.5             298       70.5
#> 51           33.9             143         48.0              78       67.0
#> 52           32.3              62         53.1             286       71.5
#> 53           35.6             250         51.7             248       72.2
#> 54           34.4             178         47.2              57       69.3
#> 55           29.3              10         53.6             307       68.3
#> 56           36.8             300         49.9             157       70.2
#> 57           35.5             245         50.8             209       71.1
#> 58           33.3             104         48.3              91       67.4
#> 59           34.1             156         57.8             352       67.8
#> 60           33.6             125         44.9              17       72.2
#> 61           36.6             292         48.7             107       70.6
#> 62           37.0             304         52.6             275       74.5
#> 63           35.4             237         44.7              16       65.5
#> 64           33.8             138         51.6             245       71.4
#> 65           35.6             251         52.6             272       72.4
#> 66           32.3              63         55.7             338       72.1
#> 67           34.2             169         48.2              85       74.4
#> 68           32.9              84         53.2             289       72.6
#> 69           29.8              13         41.9               3       69.4
#> 70           36.1             275         50.0             166       68.0
#> 71           31.3              30         44.5              13       65.0
#> 72           31.0              27         47.8              71       73.4
#> 73           32.4              68         53.5             299       69.0
#> 74           39.0             347         51.3             226       75.8
#> 75           30.2              19         50.4             186       70.5
#> 76           36.2             281         54.9             332       65.6
#> 77           30.4              20         43.4               6       69.7
#> 78           31.9              45         50.5             196       71.7
#> 79           35.5             247         52.6             276       70.2
#> 80           36.4             282         52.0             258       71.1
#> 81           33.6             123         47.1              55       71.7
#> 82           41.8             353         51.7             249       73.2
#> 83           39.0             345         50.3             179       71.3
#> 84           33.5             119         47.9              75       67.9
#> 85           31.8              42         49.9             159       70.6
#> 86           39.6             351         54.2             320       74.6
#> 87           34.2             160         49.6             145       70.6
#> 88           38.4             335         48.2              84       74.2
#> 89           33.7             131         50.5             192       76.5
#> 90           35.3             229         52.2             266       78.6
#> 91           32.0              49         49.9             164       72.5
#> 92           31.2              29         48.6             105       68.8
#> 93           35.1             220         46.3              33       73.4
#> 94           38.0             329         51.3             227       71.5
#> 95           39.1             349         48.5             100       70.0
#> 96           33.9             142         40.7               1       71.1
#> 97           31.5              34         44.1              10       66.8
#> 98           37.4             320         48.2              87       70.5
#> 99           34.6             191         50.0             166       69.9
#> 100          34.2             164         50.3             182       71.0
#> 101          30.0              16         50.8             204       70.2
#> 102          35.4             235         42.2               4       71.3
#> 103          34.5             184         56.2             340       72.9
#> 104          33.0              94         47.3              63       70.9
#> 105          33.1              96         54.7             327       71.0
#> 106          33.0              93         47.2              56       69.6
#> 107          35.3             228         51.7             251       71.0
#> 108          36.2             278         54.1             318       70.5
#> 109          33.7             129         52.1             261       72.0
#> 110          33.9             146         49.6             148       71.7
#> 111          34.7             196         47.9              73       70.2
#> 112          27.9               1         43.0               5       69.4
#> 113          31.9              47         49.3             139       72.2
#> 114          34.3             175         43.6               8       70.5
#> 115          35.7             258         51.0             214       71.4
#> 116          38.1             330         56.9             347       72.4
#> 117          37.3             315         52.2             263       73.1
#> 118          35.7             256         52.2             264       70.4
#> 119          35.3             224         51.2             223       71.2
#> 120          34.8             201         54.9             333       71.3
#> 121          37.3             316         49.3             138       72.8
#> 122          31.7              40         49.7             150       70.4
#> 123          36.5             284         53.0             284       70.5
#> 124          30.9              26         51.0             212       70.4
#> 125          35.0             211         53.5             297       71.6
#> 126          34.3             172         49.7             152       70.0
#> 127          34.3             173         52.0             257       74.3
#> 128          36.6             295         50.3             185       68.4
#> 129          33.3             106         48.8             120       70.2
#> 130          37.6             324         61.2             353       73.5
#> 131          34.5             185         51.5             241       72.2
#> 132          29.0               5         48.8             118       70.2
#> 133          36.9             302         51.1             218       76.0
#> 134          38.8             342         54.4             324       73.5
#> 135          36.6             293         51.2             222       70.4
#> 136          34.2             163         51.0             211       72.0
#> 137          33.4             116         46.0              26       71.0
#> 138          33.6             122         46.0              27       68.6
#> 139          35.0             215         50.5             195       73.3
#> 140          38.1             331         56.7             344       71.8
#> 141          34.5             187         50.3             184       67.8
#> 142          28.9               4         48.3              90       71.7
#> 143          31.9              46         44.7              14       72.3
#> 144          32.4              67         43.6               7       66.7
#> 145          33.8             139         46.8              46       71.9
#> 146          32.9              88         49.7             149       72.6
#> 147          35.4             238         46.9              50       71.2
#> 148          36.8             299         49.6             147       72.4
#> 149          31.8              44         50.8             205       69.1
#> 150          35.4             234         46.2              30       69.6
#> 151          32.8              81         48.8             119       67.8
#> 152          37.4             321         50.1             176       72.0
#> 153          35.9             267         51.0             213       65.5
#> 154          33.2             102         46.3              32       67.6
#> 155          33.3             103         48.7             108       69.0
#> 156          34.4             179         54.0             316       68.3
#> 157          38.2             332         54.7             329       68.0
#> 158          35.8             262         55.9             339       70.3
#> 159          37.8             325         51.5             237       73.3
#> 160          36.5             285         52.1             260       69.4
#> 161          30.4              21         49.9             165       71.2
#> 162          33.3             109         45.8              23       67.2
#> 163          34.6             190         51.6             244       73.4
#> 164          33.3             108         48.9             124       68.9
#> 165          33.0              91         53.6             308       73.5
#> 166          35.5             242         50.8             208       68.8
#> 167          35.9             266         48.8             115       71.9
#> 168          35.5             243         45.1              20       66.3
#> 169          34.4             177         52.5             270       70.9
#> 170          37.3             311         52.8             279       71.1
#> 171          33.5             121         49.2             134       73.2
#> 172          32.5              70         50.0             166       70.5
#> 173          37.3             317         51.2             219       73.0
#> 174          31.6              37         54.7             326       71.4
#> 175          35.5             241         51.4             232       71.8
#> 176          29.1               6         44.3              11       66.3
#> 177          32.0              53         46.0              25       69.5
#> 178          34.2             166         55.0             334       73.5
#> 179          34.8             204         49.0             129       68.0
#> 180          34.7             195         56.4             342       72.9
#> 181          32.8              82         47.7              69       71.0
#> 182          34.5             181         47.5              66       68.3
#> 183          31.7              41         49.5             142       70.8
#> 184          34.2             165         50.5             191       71.6
#> 185          32.7              76         47.9              74       74.1
#> 186          35.8             263         53.6             305       67.2
#> 187          39.3             350         53.8             315       77.0
#> 188          34.6             193         52.3             268       73.9
#> 189          35.1             218         48.2              83       72.4
#> 190          38.5             338         56.7             343       69.5
#> 191          32.8              77         47.5              65       69.2
#> 192          35.5             244         50.8             203       67.5
#> 193          33.3             105         48.4              97       71.1
#> 194          36.7             298         52.2             265       73.4
#> 195          38.4             337         49.0             126       67.1
#> 196          35.9             265         51.9             255       68.9
#> 197          33.2             100         47.4              64       70.0
#> 198          33.4             113         48.1              81       70.9
#> 199          40.3             352         49.4             140       71.6
#> 200          35.8             261         50.7             200       75.2
#> 201          33.3             110         53.0             285       70.2
#> 202          34.6             189         53.4             296       68.4
#> 203          35.0             214         50.0             171       70.6
#> 204          33.5             120         51.6             247       69.5
#> 205          37.3             318         53.6             304       73.9
#> 206          30.0              17         50.1             172       68.7
#> 207          33.3             107         53.7             312       73.3
#> 208          33.0              95         49.1             131       68.5
#> 209          35.7             254         49.7             151       69.2
#> 210          36.1             274         48.0              79       71.5
#> 211          32.9              90         50.6             199       73.4
#> 212          34.4             176         52.2             267       71.7
#> 213          29.3               9         49.2             135       70.5
#> 214          32.9              83         51.8             253       68.0
#> 215          33.4             114         47.3              61       70.5
#> 216          36.4             283         51.3             228       74.0
#> 217          34.1             155         51.1             215       71.6
#> 218          34.7             197         53.2             288       68.9
#> 219          37.1             308         57.5             350       71.6
#> 220          32.4              66         49.0             127       74.6
#> 221          31.4              33         49.0             128       67.4
#> 222          39.0             346         54.3             322       74.4
#> 223          33.8             135         46.9              49       70.9
#> 224          31.6              39         48.5              99       69.3
#> 225          32.7              74         50.5             193       70.5
#> 226          34.9             209         51.7             250       72.7
#> 227          32.5              69         48.2              86       68.7
#> 228          37.4             319         49.9             160       70.3
#> 229          32.9              87         46.8              48       72.2
#> 230          37.8             327         50.1             173       70.0
#> 231          32.1              55         47.7              68       70.5
#> 232          33.5             118         45.3              21       72.2
#> 233          36.2             279         48.5             101       70.9
#> 234          37.0             306         50.8             207       75.9
#> 235          35.2             221         48.4              92       71.8
#> 236          35.6             249         48.7             109       69.9
#> 237          33.6             127         45.8              24       71.6
#> 238          34.2             167         51.2             221       71.5
#> 239          36.7             296         52.4             269       67.3
#> 240          36.6             289         48.3              89       73.6
#> 241          32.9              89         49.6             146       69.6
#> 242          37.0             305         50.7             202       71.0
#> 243          32.9              86         51.5             235       68.0
#> 244          32.0              52         51.6             243       66.9
#> 245          37.3             312         56.3             341       65.3
#> 246          33.7             128         50.6             198       71.2
#> 247          37.1             309         49.3             136       71.9
#> 248          35.0             210         44.4              12       73.1
#> 249          36.6             294         51.5             236       71.5
#> 250          32.3              61         46.2              31       65.8
#> 251          34.5             183         47.0              52       68.6
#> 252          34.0             151         51.5             238       71.3
#> 253          35.6             253         50.8             206       74.1
#> 254          34.6             192         53.3             292       68.0
#> 255          31.6              36         48.7             111       69.4
#> 256          38.4             333         52.6             273       72.2
#> 257          34.1             157         48.8             113       72.8
#> 258          30.1              18         46.6              40       67.5
#> 259          36.7             297         54.8             330       69.2
#> 260          33.9             148         48.1              82       72.6
#> 261          33.6             126         52.1             262       69.8
#> 262          29.2               7         50.0             170       71.3
#> 263          33.7             130         51.9             254       71.0
#> 264          38.8             343         52.8             280       73.5
#> 265          31.6              35         49.3             137       73.0
#> 266          38.6             340         46.7              41       74.0
#> 267          36.9             303         57.1             348       70.6
#> 268          34.0             154         48.7             110       74.2
#> 269          35.7             255         53.6             303       68.2
#> 270          36.0             273         53.3             294       71.1
#> 271          30.9              25         48.7             106       68.8
#> 272          31.8              43         48.8             116       66.3
#> 273          31.2              28         53.7             311       69.3
#> 274          33.9             144         51.3             225       69.7
#> 275          34.1             159         50.5             190       71.2
#> 276          36.0             271         50.2             177       74.5
#> 277          34.9             208         46.1              29       74.7
#> 278          33.8             140         49.5             144       68.0
#> 279          36.0             270         49.9             158       72.7
#> 280          32.1              58         46.7              43       70.6
#> 281          32.2              59         48.9             122       70.1
#> 282          33.2             101         47.8              72       70.0
#> 283          35.0             212         51.1             216       65.1
#> 284          34.7             194         53.6             309       71.0
#> 285          34.3             171         54.0             317       72.1
#> 286          37.3             314         46.7              44       66.8
#> 287          36.5             287         51.5             240       70.7
#> 288          35.4             232         48.4              93       71.8
#> 289          34.0             150         54.4             323       72.7
#> 290          33.7             134         49.4             141       69.0
#> 291          35.9             269         46.8              45       66.1
#> 292          33.6             124         50.7             201       68.2
#> 293          35.4             240         53.4             295       68.2
#> 294          31.9              48         48.8             114       74.4
#> 295          32.8              79         46.4              35       68.1
#> 296          33.8             136         53.2             291       74.0
#> 297          34.6             188         46.4              36       67.9
#> 298          36.2             280         56.7             345       72.1
#> 299          29.6              11         46.1              28       65.9
#> 300          34.0             153         48.7             112       69.2
#> 301          32.4              64         50.3             183       76.1
#> 302          36.1             277         51.3             229       71.9
#> 303          32.0              51         50.9             210       69.2
#> 304          33.1              97         48.6             104       70.8
#> 305          35.3             231         54.1             319       63.7
#> 306          35.9             267         53.7             310       71.0
#> 307          34.0             149         51.8             252       71.3
#> 308          33.8             141         50.3             180       69.0
#> 309          29.3               8         48.0              76       71.4
#> 310          32.1              57         55.3             336       69.5
#> 311          33.1              98         47.3              62       64.9
#> 312          35.3             226         47.0              51       66.5
#> 313          35.8             259         51.1             217       72.1
#> 314          37.0             307         50.4             188       70.6
#> 315          34.9             207         48.0              77       71.6
#> 316          35.6             248         49.8             156       65.8
#> 317          35.5             246         49.9             162       74.2
#> 318          33.3             110         47.7              70       72.9
#> 319          33.0              92         46.5              37       69.3
#> 320          36.0             272         49.5             143       74.0
#> 321          39.1             348         51.4             233       69.2
#> 322          36.6             288         54.2             321       70.1
#> 323          36.6             291         53.8             314       74.0
#> 324          33.4             117         49.8             154       70.8
#> 325          38.7             341         52.7             278       71.3
#> 326          32.0              50         48.5             103       68.4
#> 327          30.0              15         45.0              18       69.6
#> 328          34.1             157         54.7             328       69.5
#> 329          33.1              99         49.1             130       68.6
#> 330          29.7              12         46.3              34       68.9
#> 331          36.9             301         50.1             175       69.7
#> 332          28.5               2         43.8               9       69.0
#> 333          29.9              14         50.0             166       69.4
#> 334          38.4             334         57.8             351       69.5
#> 335          31.4              31         46.7              42       72.2
#> 336          37.5             322         56.8             346       69.8
#> 337          32.6              73         51.5             239       70.1
#> 338          32.5              71         50.3             181       72.8
#> 339          35.2             223         49.9             161       71.3
#> 340          34.2             162         50.4             189       68.3
#> 341          34.8             206         54.6             325       71.1
#> 342          35.1             219         52.6             274       71.9
#> 343          35.9             264         48.9             123       70.8
#> 344          35.8             260         48.4              94       70.0
#> 345          34.8             203         53.6             306       70.5
#> 346          36.1             276         53.5             300       71.7
#> 347          34.7             198         52.6             271       71.9
#> 348          36.6             290         47.1              54       69.7
#> 349          32.9              85         52.0             256       69.8
#> 350          37.5             323         48.1              80       69.3
#> 351          32.3              60         48.8             117       72.4
#> 352          37.3             313         53.3             293       69.2
#> 353          35.3             230         46.8              47       70.1
#> 354          30.3              38         50.8             235       69.7
#> 355          32.6             147         46.2              56       73.3
#> 356          35.0             278         55.0             339       71.8
#> 357          36.6             321         50.7             232       73.7
#> 358          34.0             228         50.7             233       71.6
#> 359          31.8              96         48.9             158       70.0
#> 360          32.0             108         47.4              91       69.7
#> 361          33.7             211         47.2              84       68.3
#> 362          29.8              22         48.8             151       71.7
#> 363          32.3             124         45.9              51       66.5
#> 364          30.2              36         45.3              37       72.6
#> 365          31.6              88         51.3             253       70.1
#> 366          30.4              40         48.6             145       69.1
#> 367          31.6              85         49.4             179       72.8
#> 368          30.1              33         45.1              32       73.0
#> 369          31.8              97         52.3             285       69.8
#> 370          35.5             293         47.8             106       69.1
#> 371          28.5               6         50.2             210       70.4
#> 372          34.4             250         48.4             139       72.6
#> 373          30.7              52         52.9             302       72.5
#> 374          29.6              20         46.3              59       69.7
#> 375          38.7             348         52.4             291       72.1
#> 376          32.7             152         44.2              17       69.1
#> 377          37.3             332         48.8             152       75.3
#> 378          35.6             296         52.4             291       70.8
#> 379          31.7              90         45.6              43       75.0
#> 380          33.0             163         45.1              33       64.4
#> 381          32.8             157         53.2             310       72.5
#> 382          37.9             343         55.6             347       71.8
#> 383          30.6              48         46.9              79       73.3
#> 384          34.4             247         51.5             262       72.4
#> 385          31.3              75         53.0             305       72.9
#> 386          33.3             183         49.0             161       71.0
#> 387          34.8             269         46.6              69       70.4
#> 388          31.0              60         46.3              62       69.3
#> 389          34.9             271         50.8             237       75.5
#> 390          37.7             338         55.1             341       75.8
#> 391          33.6             203         48.0             119       72.0
#> 392          33.1             173         49.2             167       71.2
#> 393          38.4             347         58.4             353       74.0
#> 394          31.5              82         45.2              34       66.3
#> 395          30.5              44         49.1             165       68.1
#> 396          32.3             122         51.5             261       73.1
#> 397          33.6             199         51.2             252       72.0
#> 398          36.9             325         49.8             195       67.2
#> 399          32.5             137         47.9             118       70.2
#> 400          34.4             251         51.5             259       71.7
#> 401          29.9              25         48.0             122       72.5
#> 402          31.5              79         46.8              76       72.1
#> 403          31.4              78         51.4             258       65.4
#> 404          35.3             286         46.5              68       68.2
#> 405          32.2             119         52.7             296       69.9
#> 406          34.7             264         52.8             300       70.0
#> 407          35.6             297         40.8               2       71.1
#> 408          35.4             290         51.9             270       76.3
#> 409          31.3              73         47.4              89       70.9
#> 410          31.0              59         46.1              55       69.4
#> 411          30.0              28         47.3              87       71.1
#> 412          31.8             101         48.7             149       74.4
#> 413          30.7              53         49.2             170       68.1
#> 414          35.1             282         47.6              96       66.7
#> 415          33.8             215         49.0             160       71.2
#> 416          31.9             102         51.1             248       75.7
#> 417          36.4             314         52.3             289       70.6
#> 418          37.5             335         57.1             351       66.0
#> 419          36.4             315         52.8             301       73.3
#> 420          36.4             316         50.6             224       71.5
#> 421          31.2              67         44.4              19       73.3
#> 422          31.9             104         50.7             233       66.6
#> 423          32.7             149         49.3             174       72.2
#> 424          33.1             175         44.9              27       69.0
#> 425          35.1             281         48.1             130       76.6
#> 426          32.9             159         50.8             236       67.3
#> 427          36.9             326         50.6             229       74.4
#> 428          35.5             291         45.4              39       71.1
#> 429          29.9              26         46.0              53       67.1
#> 430          32.2             120         48.6             146       68.6
#> 431          35.6             295         47.4              92       71.4
#> 432          31.2              66         50.9             241       76.6
#> 433          38.1             345         50.3             212       71.5
#> 434          31.7              95         46.6              70       73.3
#> 435          34.5             257         47.3              86       69.5
#> 436          34.2             234         44.8              26       71.1
#> 437          31.1              62         44.4              20       68.7
#> 438          33.3             187         49.5             183       70.4
#> 439          31.3              74         43.1               7       69.8
#> 440          33.2             180         48.7             147       74.4
#> 441          34.5             253         47.2              83       72.4
#> 442          30.0              30         45.9              50       69.5
#> 443          37.2             330         46.3              61       73.9
#> 444          31.2              71         48.4             141       74.1
#> 445          36.6             319         43.4              11       70.0
#> 446          32.1             112         52.2             283       74.0
#> 447          33.2             181         46.7              72       64.2
#> 448          36.9             323         52.1             277       69.6
#> 449          28.7              10         43.4              10       70.3
#> 450          32.3             126         52.3             286       73.4
#> 451          32.7             148         48.5             144       74.2
#> 452          32.6             141         47.4              93       72.9
#> 453          34.7             263         55.0             337       68.9
#> 454          32.1             111         50.3             214       72.6
#> 455          31.5              80         51.0             246       71.0
#> 456          33.7             213         46.8              75       70.6
#> 457          36.4             313         48.1             131       73.4
#> 458          32.9             161         49.7             191       73.3
#> 459          27.2               1         49.2             171       69.8
#> 460          31.2              68         53.6             318       71.9
#> 461          33.7             206         45.8              46       72.0
#> 462          32.3             123         52.0             274       67.0
#> 463          34.3             242         48.1             127       70.4
#> 464          35.6             294         50.2             206       68.4
#> 465          35.4             288         51.6             264       71.2
#> 466          35.0             275         51.0             245       66.2
#> 467          32.4             131         52.9             303       69.1
#> 468          30.7              51         44.8              25       68.8
#> 469          33.4             192         48.1             132       68.6
#> 470          34.3             244         50.7             231       71.2
#> 471          33.3             184         48.5             143       78.8
#> 472          34.0             226         51.6             266       63.5
#> 473          33.1             172         50.3             213       71.5
#> 474          32.1             114         44.9              29       71.8
#> 475          32.4             132         44.5              23       69.5
#> 476          33.0             166         43.5              12       71.9
#> 477          32.8             156         49.3             172       68.9
#> 478          33.2             182         52.8             299       71.9
#> 479          33.8             214         52.6             295       72.6
#> 480          28.6               7         50.6             228       73.2
#> 481          32.9             160         55.5             345       76.3
#> 482          34.9             274         50.0             203       72.5
#> 483          34.2             236         47.7             100       72.8
#> 484          34.3             243         46.3              64       71.1
#> 485          30.5              43         42.4               3       67.2
#> 486          32.4             128         49.4             178       69.6
#> 487          36.5             318         50.2             209       68.8
#> 488          36.1             306         51.5             260       73.6
#> 489          37.3             333         50.8             238       72.9
#> 490          33.1             177         55.1             340       68.5
#> 491          31.9             105         52.1             278       67.7
#> 492          31.9             103         50.5             222       69.9
#> 493          31.7              94         51.1             250       69.9
#> 494          32.3             127         46.3              60       69.3
#> 495          35.8             300         46.8              77       73.9
#> 496          30.8              54         48.0             120       72.4
#> 497          28.8              13         47.9             113       66.2
#> 498          34.6             259         53.3             313       71.5
#> 499          33.5             195         46.7              71       72.7
#> 500          36.3             311         46.3              66       75.8
#> 501          33.9             220         53.7             321       72.4
#> 502          30.7              50         45.4              41       70.7
#> 503          34.5             258         51.4             257       68.8
#> 504          37.8             341         53.0             304       72.4
#> 505          28.6               8         44.5              24       69.0
#> 506          31.7              92         48.7             150       71.4
#> 507          34.4             246         54.3             331       71.7
#> 508          30.1              32         54.9             336       72.1
#> 509          37.9             342         54.8             335       68.5
#> 510          30.0              30         50.5             221       71.6
#> 511          31.2              70         48.8             154       73.3
#> 512          35.8             301         50.6             230       68.7
#> 513          31.6              84         49.8             194       68.1
#> 514          36.3             310         47.0              81       73.6
#> 515          35.2             284         48.9             157       73.1
#> 516          33.8             219         49.6             184       69.6
#> 517          31.4              77         45.0              30       69.0
#> 518          32.0             106         44.4              21       70.1
#> 519          33.6             205         43.3               9       69.3
#> 520          37.6             336         47.7             103       71.9
#> 521          31.8             100         50.8             239       72.4
#> 522          32.2             118         46.3              67       66.0
#> 523          34.4             248         48.1             128       70.8
#> 524          34.0             227         54.0             326       69.4
#> 525          27.2               2         50.5             220       70.1
#> 526          35.0             276         49.9             199       69.3
#> 527          30.6              49         48.9             159       71.3
#> 528          34.1             231         51.9             272       73.8
#> 529          39.2             352         58.1             352       69.8
#> 530          35.1             280         52.7             297       73.8
#> 531          36.3             312         46.0              54       64.9
#> 532          30.0              29         53.5             317       73.7
#> 533          34.5             255         49.9             201       69.0
#> 534          32.6             142         53.4             316       69.0
#> 535          31.1              61         47.9             115       70.7
#> 536          33.8             216         49.8             193       68.9
#> 537          33.6             200         49.7             192       72.5
#> 538          38.1             344         53.4             314       70.7
#> 539          30.5              46         48.1             129       71.1
#> 540          31.6              86         47.0              80       68.9
#> 541          34.9             272         50.6             225       70.3
#> 542          34.9             270         48.0             123       72.6
#> 543          28.0               3         40.7               1       68.7
#> 544          32.2             116         48.3             138       73.0
#> 545          32.2             117         42.4               5       71.1
#> 546          33.0             168         51.7             268       69.5
#> 547          32.3             125         44.9              28       70.4
#> 548          33.7             209         45.5              42       70.1
#> 549          35.6             298         50.4             217       69.0
#> 550          30.2              35         43.9              14       69.6
#> 551          34.5             252         47.8             108       68.8
#> 552          33.3             185         46.3              65       68.6
#> 553          36.7             322         56.7             349       73.0
#> 554          34.7             262         47.7             104       69.5
#> 555          34.7             261         53.1             308       69.2
#> 556          34.3             238         45.9              48       71.9
#> 557          32.2             121         47.6              95       68.3
#> 558          32.5             135         45.2              36       68.3
#> 559          36.4             317         53.1             307       71.3
#> 560          31.2              69         42.4               4       71.9
#> 561          36.1             307         52.3             290       71.1
#> 562          34.7             265         47.9             110       73.4
#> 563          36.0             305         53.4             315       70.5
#> 564          34.7             266         57.1             350       70.6
#> 565          37.3             331         50.9             241       74.6
#> 566          34.6             260         54.2             329       65.7
#> 567          37.8             340         51.1             247       72.8
#> 568          33.0             165         45.0              31       73.8
#> 569          36.3             308         53.6             319       71.4
#> 570          32.6             145         52.1             280       72.7
#> 571          34.4             249         47.4              88       73.9
#> 572          31.7              93         48.0             121       74.9
#> 573          33.1             174         48.8             155       68.1
#> 574          35.9             304         51.8             269       73.0
#> 575          30.4              39         51.9             271       70.8
#> 576          36.3             309         52.2             281       72.3
#> 577          31.0              58         46.3              63       71.6
#> 578          34.2             235         49.5             182       73.7
#> 579          38.3             346         46.9              78       72.4
#> 580          29.9              23         48.2             136       71.3
#> 581          32.8             155         49.9             200       66.6
#> 582          32.4             133         54.4             333       76.1
#> 583          36.9             324         54.4             332       69.5
#> 584          31.7              91         48.7             148       68.2
#> 585          33.0             168         50.4             216       68.6
#> 586          32.5             136         49.5             180       68.1
#> 587          35.8             302         53.3             312       71.8
#> 588          37.6             337         55.6             346       70.5
#> 589          29.2              15         49.7             190       74.0
#> 590          33.9             221         52.0             273       73.8
#> 591          35.4             289         47.9             117       67.3
#> 592          33.5             197         48.5             142       72.1
#> 593          30.9              55         47.4              90       67.9
#> 594          35.6             299         52.5             294       74.7
#> 595          33.7             207         43.1               8       73.0
#> 596          35.2             283         54.0             327       71.1
#> 597          31.6              89         48.0             124       69.0
#> 598          30.1              34         49.7             189       65.9
#> 599          34.3             240         50.0             202       69.4
#> 600          33.7             210         53.8             324       71.5
#> 601          33.6             201         44.2              16       71.1
#> 602          33.1             176         50.4             218       69.5
#> 603          33.3             187         52.5             293       66.7
#> 604          31.1              65         45.4              40       70.8
#> 605          30.3              37         48.8             153       68.3
#> 606          32.1             110         46.2              57       71.8
#> 607          30.4              42         47.2              82       71.2
#> 608          33.9             222         49.8             196       71.2
#> 609          28.0               4         51.6             267       66.8
#> 610          34.0             229         48.1             125       70.6
#> 611          34.1             232         53.0             306       70.7
#> 612          38.9             349         53.2             309       68.9
#> 613          35.3             287         49.6             185       71.9
#> 614          33.6             202         44.3              18       69.3
#> 615          35.9             303         50.6             223       69.2
#> 616          34.2             233         46.8              74       77.2
#> 617          29.7              21         49.1             163       70.5
#> 618          32.5             138         54.2             330       69.2
#> 619          29.9              23         48.3             137       72.4
#> 620          32.6             143         47.9             114       71.5
#> 621          31.3              75         49.8             197       73.3
#> 622          32.1             109         48.4             140       70.2
#> 623          30.9              57         52.3             287       73.4
#> 624          32.8             153         52.2             282       68.5
#> 625          38.9             351         52.1             276       71.2
#> 626          37.1             327         47.7             101       73.3
#> 627          32.1             113         53.7             322       73.1
#> 628          31.8              98         49.1             166       68.4
#> 629          33.0             167         49.6             186       70.1
#> 630          33.1             171         44.0              15       70.6
#> 631          35.5             292         48.1             126       70.5
#> 632          34.0             225         47.9             111       70.6
#> 633          31.6              87         49.4             175       73.4
#> 634          34.3             241         49.4             177       69.8
#> 635          30.5              45         46.7              73       72.7
#> 636          37.8             339         49.9             198       71.7
#> 637          33.4             190         47.9             109       74.4
#> 638          32.4             129         49.7             188       64.2
#> 639          32.5             139         44.5              22       69.8
#> 640          28.3               5         45.7              45       71.5
#> 641          30.9              56         47.8             105       67.9
#> 642          29.6              19         45.7              44       73.0
#> 643          33.4             193         52.0             275       73.2
#> 644          34.5             254         45.4              38       68.3
#> 645          34.8             268         55.3             342       71.3
#> 646          33.4             194         51.6             265       68.4
#> 647          31.5              81         51.2             251       68.8
#> 648          31.2              72         43.8              13       71.7
#> 649          33.4             191         50.8             240       71.6
#> 650          34.3             245         47.6              97       69.5
#> 651          31.8              99         51.1             249       71.4
#> 652          30.4              41         49.3             173       70.4
#> 653          29.6              18         47.7              99       67.6
#> 654          32.5             140         46.2              58       71.7
#> 655          38.9             350         51.0             244       70.6
#> 656          34.9             273         49.2             168       72.0
#> 657          34.5             256         50.0             203       72.4
#> 658          40.6             353         55.4             343       73.8
#> 659          33.6             204         48.2             133       75.5
#> 660          33.5             198         49.4             176       72.1
#> 661          31.5              83         50.9             243       66.3
#> 662          29.6              17         48.2             135       68.4
#> 663          33.0             170         45.8              47       72.2
#> 664          29.3              16         42.5               6       68.8
#> 665          32.9             162         52.3             284       65.4
#> 666          28.7               9         50.6             227       69.6
#> 667          32.6             146         47.2              85       74.8
#> 668          34.8             267         51.6             263       70.5
#> 669          32.4             130         50.6             225       72.0
#> 670          37.3             334         50.3             215       72.4
#> 671          32.6             144         50.3             211       74.7
#> 672          32.0             107         52.1             279       66.2
#> 673          33.2             178         47.7             102       68.2
#> 674          32.9             158         56.1             348       75.0
#> 675          33.5             196         52.3             288       73.7
#> 676          29.9              27         48.8             156       70.8
#> 677          33.3             186         53.9             325       67.6
#> 678          37.1             328         51.3             254       72.5
#> 679          28.8              12         48.2             134       72.7
#> 680          33.0             164         53.7             323       73.2
#> 681          36.6             320         53.6             320       69.7
#> 682          29.2              14         50.2             208       63.7
#> 683          33.9             223         49.0             162       71.3
#> 684          32.7             151         49.2             169       75.0
#> 685          34.1             230         55.5             344       68.4
#> 686          32.8             154         49.5             181       67.2
#> 687          34.0             224         50.4             219       68.1
#> 688          33.8             218         46.0              52       71.9
#> 689          35.3             285         47.8             107       71.2
#> 690          35.0             277         53.2             311       76.1
#> 691          28.8              11         45.2              35       71.5
#> 692          35.0             278         45.9              49       71.5
#> 693          34.2             236         49.1             164       72.2
#> 694          30.5              47         54.5             334       67.8
#> 695          32.1             115         51.3             255       75.6
#> 696          33.4             189         47.5              94       68.3
#> 697          32.4             134         52.7             298       66.2
#> 698          33.2             179         54.2             328       67.4
#> 699          33.7             212         49.7             187       66.9
#> 700          31.1              64         47.9             112       71.5
#> 701          32.7             150         50.0             205       70.7
#> 702          34.3             239         47.9             116       70.2
#> 703          31.1              62         50.2             207       67.9
#> 704          33.8             217         47.7              98       71.6
#> 705          33.7             208         51.3             256       69.8
#> 706          37.1             329         55.0             338       65.9
#> 707          32.9             118         48.7             130       69.5
#> 708          35.5             265         49.9             171       79.4
#> 709          26.4               1         49.4             154       68.5
#> 710          33.6             155         53.9             303       74.7
#> 711          36.8             313         49.9             174       67.1
#> 712          35.2             251         47.5              88       70.7
#> 713          36.8             312         53.4             291       70.7
#> 714          35.4             258         47.3              87       73.8
#> 715          31.8              70         47.8             102       69.6
#> 716          34.8             232         46.6              58       67.6
#> 717          36.6             303         50.1             181       73.8
#> 718          30.7              35         55.1             323       69.9
#> 719          32.2              84         42.6               3       76.0
#> 720          39.7             345         52.5             268       71.0
#> 721          29.1               9         52.9             279       67.0
#> 722          29.2              11         48.7             128       71.2
#> 723          36.6             302         56.0             334       74.4
#> 724          34.2             199         50.4             202       76.4
#> 725          41.0             347         55.7             330       69.6
#> 726          34.4             212         49.4             153       70.1
#> 727          32.5             100         44.5              12       73.4
#> 728          31.3              50         49.8             170       75.4
#> 729          33.5             147         54.8             319       69.1
#> 730          33.9             182         46.2              45       74.9
#> 731          36.3             292         50.0             176       72.3
#> 732          35.2             250         47.9             106       73.6
#> 733          31.0              42         55.4             325       72.7
#> 734          38.9             337         52.8             277       71.8
#> 735          29.8              14         51.2             236       72.9
#> 736          32.9             122         45.1              20       68.7
#> 737          34.4             214         54.1             305       71.9
#> 738          31.7              63         47.5              89       70.7
#> 739          33.3             140         46.8              69       73.0
#> 740          32.1              81         48.7             127       63.4
#> 741          33.7             164         50.4             197       71.4
#> 742          32.6             105         45.1              22       72.7
#> 743          34.1             193         48.0             109       70.6
#> 744          39.0             340         52.5             269       68.3
#> 745          31.8              72         44.7              13       69.1
#> 746          32.0              78         51.2             237       74.4
#> 747          33.4             142         50.8             216       69.5
#> 748          30.6              28         44.8              14       70.1
#> 749          38.0             326         53.3             285       73.8
#> 750          33.9             175         44.8              18       73.5
#> 751          32.7             112         47.0              76       70.3
#> 752          36.6             306         48.5             125       73.2
#> 753          32.8             115         45.8              31       68.6
#> 754          32.4              93         50.2             184       66.9
#> 755          31.4              54         52.1             260       71.3
#> 756          32.7             110         50.1             179       69.3
#> 757          35.2             248         48.3             118       72.2
#> 758          38.9             338         52.4             267       72.0
#> 759          33.5             149         46.6              60       71.5
#> 760          33.9             176         47.7              99       69.2
#> 761          33.5             151         51.5             246       69.0
#> 762          29.7              12         46.8              68       68.8
#> 763          30.4              23         49.8             166       72.3
#> 764          27.7               2         46.2              43       68.1
#> 765          32.9             117         48.2             112       69.2
#> 766          35.3             252         51.1             229       70.8
#> 767          33.9             177         50.1             178       73.2
#> 768          31.7              62         46.7              64       70.1
#> 769          34.1             192         46.9              73       73.2
#> 770          33.2             139         51.4             243       69.0
#> 771          35.8             276         50.7             214       70.2
#> 772          33.3             140         42.1               2       73.4
#> 773          38.2             330         51.7             251       73.6
#> 774          34.0             184         47.2              85       70.8
#> 775          32.1              83         47.8             103       73.1
#> 776          35.9             280         47.7             101       66.6
#> 777          34.2             202         48.2             113       70.4
#> 778          34.3             205         51.2             238       72.3
#> 779          34.7             228         52.6             271       69.1
#> 780          33.0             124         51.8             254       73.4
#> 781          32.4              97         50.2             187       70.1
#> 782          33.7             165         49.7             163       73.0
#> 783          33.8             173         49.8             168       74.5
#> 784          33.0             128         54.4             313       71.3
#> 785          33.6             154         51.0             228       76.5
#> 786          31.7              64         45.3              25       68.4
#> 787          30.7              33         48.8             131       70.9
#> 788          34.9             237         46.7              61       74.0
#> 789          35.7             270         52.1             261       71.4
#> 790          34.5             221         52.2             264       68.1
#> 791          36.0             282         49.6             159       72.8
#> 792          32.7             113         49.4             155       69.1
#> 793          33.6             160         46.9              74       71.2
#> 794          35.4             260         47.7              95       70.6
#> 795          33.1             132         48.3             117       69.7
#> 796          34.3             205         52.2             265       70.9
#> 797          32.5             101         46.3              49       71.4
#> 798          34.2             197         45.5              28       68.1
#> 799          32.3              87         48.3             115       69.8
#> 800          34.3             207         50.8             215       69.3
#> 801          34.8             233         46.2              42       71.5
#> 802          36.7             309         47.5              93       70.8
#> 803          35.3             256         53.6             294       67.5
#> 804          30.8              37         50.9             223       63.6
#> 805          36.2             286         50.6             211       69.7
#> 806          35.6             268         50.3             194       70.6
#> 807          29.1              10         46.8              71       68.9
#> 808          32.4              90         49.4             152       66.6
#> 809          31.2              48         47.7              97       68.1
#> 810          36.5             300         50.9             225       70.8
#> 811          30.6              30         50.4             199       72.7
#> 812          33.5             148         49.1             143       74.1
#> 813          38.3             331         52.7             276       70.4
#> 814          35.2             247         43.9               9       68.0
#> 815          37.0             317         60.4             345       73.6
#> 816          33.0             126         46.4              51       69.6
#> 817          31.8              65         48.3             120       74.2
#> 818          33.8             174         52.9             278       71.4
#> 819          34.4             218         49.3             150       69.8
#> 820          33.1             134         48.9             133       72.7
#> 821          29.9              15         43.4               7       65.6
#> 822          36.8             313         50.8             220       70.5
#> 823          34.3             208         51.5             245       67.0
#> 824          31.8              67         54.9             320       69.8
#> 825          39.3             342         53.8             298       77.2
#> 826          30.7              34         46.5              54       71.5
#> 827          33.6             162         47.0              78       72.6
#> 828          30.3              21         50.3             190       71.7
#> 829          30.0              17         51.3             241       71.4
#> 830          34.0             186         48.2             114       67.9
#> 831          34.4             213         47.2              82       75.5
#> 832          32.8             116         55.8             332       69.1
#> 833          30.2              20         46.3              50       68.5
#> 834          31.6              61         48.9             134       71.7
#> 835          33.2             135         50.5             204       70.9
#> 836          33.9             178         55.9             333       69.9
#> 837          32.4              98         47.7              98       68.2
#> 838          31.0              43         56.1             336       72.8
#> 839          36.4             295         46.0              39       73.9
#> 840          37.9             325         48.1             111       72.7
#> 841          33.4             145         47.7              96       69.7
#> 842          34.1             194         47.2              83       69.6
#> 843          34.2             196         53.3             288       68.1
#> 844          31.2              46         47.1              81       70.1
#> 845          32.4              91         44.8              15       70.7
#> 846          30.5              26         56.5             339       73.4
#> 847          30.7              32         45.2              23       66.2
#> 848          33.1             131         47.0              77       75.9
#> 849          31.2              47         46.3              46       70.3
#> 850          32.5             104         45.8              36       74.7
#> 851          34.3             204         44.8              17       69.6
#> 852          31.0              44         50.4             200       68.6
#> 853          31.3              52         46.4              53       70.7
#> 854          35.7             269         46.3              47       74.9
#> 855          38.1             327         52.6             273       74.6
#> 856          33.7             168         49.5             157       71.1
#> 857          32.8             114         53.4             290       70.1
#> 858          32.9             123         44.5              11       71.6
#> 859          30.9              38         53.9             304       75.7
#> 860          30.3              22         43.1               5       68.9
#> 861          31.5              56         54.7             318       72.4
#> 862          32.6             109         50.1             182       74.9
#> 863          36.5             299         47.9             104       71.7
#> 864          28.6               6         48.0             107       76.3
#> 865          32.5             103         52.6             272       68.6
#> 866          34.7             230         54.6             316       69.9
#> 867          32.2              85         51.1             233       70.8
#> 868          31.1              45         47.2              84       68.7
#> 869          33.1             133         52.6             270       69.5
#> 870          34.5             219         53.9             302       72.9
#> 871          33.5             150         51.0             227       68.7
#> 872          34.9             236         49.4             151       71.4
#> 873          37.6             321         60.6             346       75.3
#> 874          34.5             222         50.3             196       71.8
#> 875          38.4             334         51.1             232       76.4
#> 876          34.5             223         51.1             230       69.1
#> 877          32.9             120         53.8             299       74.4
#> 878          31.2              49         46.6              56       74.1
#> 879          33.5             152         46.7              62       73.2
#> 880          38.4             333         51.2             234       73.7
#> 881          32.4              92         45.8              35       70.7
#> 882          36.4             294         54.2             311       77.0
#> 883          35.3             254         47.5              91       71.0
#> 884          30.6              29         45.2              24       76.9
#> 885          35.8             277         50.4             203       67.6
#> 886          31.6              59         49.3             146       72.0
#> 887          36.2             289         51.5             247       74.6
#> 888          34.2             198         43.9              10       67.1
#> 889          34.3             210         55.7             329       72.0
#> 890          32.6             107         50.3             189       74.8
#> 891          31.8              74         49.7             164       68.1
#> 892          34.4             217         51.7             253       74.7
#> 893          37.3             319         55.0             322       70.1
#> 894          36.9             315         54.5             314       68.1
#> 895          36.2             287         53.2             282       72.9
#> 896          35.6             266         54.6             315       69.3
#> 897          34.9             238         50.6             209       71.2
#> 898          33.8             170         48.3             119       69.6
#> 899          33.2             137         42.9               4       73.8
#> 900          37.4             320         58.2             342       69.9
#> 901          33.6             158         46.3              48       68.7
#> 902          31.3              51         52.1             262       72.5
#> 903          32.0              79         51.5             249       72.7
#> 904          31.8              71         46.7              65       72.1
#> 905          38.1             329         50.4             201       73.9
#> 906          32.4              95         50.4             198       66.5
#> 907          32.4              93         44.9              19       72.8
#> 908          34.2             201         50.9             221       73.3
#> 909          35.1             243         49.8             169       75.4
#> 910          36.6             307         49.6             160       71.7
#> 911          36.6             305         59.1             344       68.8
#> 912          35.4             259         56.8             340       71.2
#> 913          35.6             267         49.8             167       69.4
#> 914          36.0             283         47.5              90       76.7
#> 915          33.8             169         51.4             243       74.2
#> 916          32.9             121         51.3             242       69.9
#> 917          30.5              27         45.9              37       69.4
#> 918          29.9              16         50.2             186       71.7
#> 919          28.8               7         54.1             306       73.7
#> 920          37.9             324         51.1             231       72.6
#> 921          35.8             279         55.6             328       67.2
#> 922          32.9             119         43.2               6       70.7
#> 923          37.9             323         49.9             175       71.4
#> 924          31.6              60         55.8             331       77.5
#> 925          34.6             226         48.7             129       71.1
#> 926          30.1              18         49.1             144       68.6
#> 927          36.9             316         53.2             283       73.7
#> 928          31.8              66         52.9             280       77.2
#> 929          35.7             271         48.4             121       72.6
#> 930          33.6             158         53.7             297       68.0
#> 931          32.7             111         49.9             172       68.5
#> 932          35.8             275         49.9             173       74.5
#> 933          33.8             172         51.0             226       67.7
#> 934          32.0              77         55.5             326       70.9
#> 935          33.8             171         45.7              30       73.7
#> 936          33.2             138         47.9             105       71.3
#> 937          34.6             225         51.5             250       70.7
#> 938          36.3             293         50.3             193       72.8
#> 939          39.0             339         52.0             258       73.5
#> 940          35.2             245         54.6             317       69.7
#> 941          34.2             200         50.8             218       67.4
#> 942          33.4             144         48.1             110       71.7
#> 943          30.1              19         43.7               8       70.8
#> 944          34.2             195         53.3             286       69.8
#> 945          35.0             240         53.4             293       70.1
#> 946          33.0             130         46.2              44       68.9
#> 947          33.6             157         41.6               1       66.7
#> 948          29.0               8         50.6             208       66.6
#> 949          33.9             179         45.8              33       72.7
#> 950          36.7             310         50.6             210       73.3
#> 951          34.1             190         54.2             310       73.8
#> 952          34.5             220         50.5             205       74.1
#> 953          36.4             297         53.6             295       76.8
#> 954          33.6             156         46.9              72       74.9
#> 955          30.7              31         51.3             240       73.1
#> 956          35.3             257         56.0             335       70.5
#> 957          36.6             304         46.6              55       75.1
#> 958          32.1              82         48.0             108       71.6
#> 959          33.0             125         53.2             284       74.1
#> 960          34.4             215         48.5             124       78.5
#> 961          29.7              13         50.6             212       69.9
#> 962          31.8              68         50.5             207       71.0
#> 963          35.8             274         52.6             274       72.3
#> 964          36.0             281         53.4             289       67.0
#> 965          36.1             284         56.4             338       72.6
#> 966          34.8             231         47.5              92       69.8
#> 967          30.5              24         45.4              27       70.1
#> 968          35.0             242         47.0              75       69.7
#> 969          34.5             224         49.3             148       72.3
#> 970          39.5             343         51.8             255       72.7
#> 971          34.3             211         50.0             176       75.7
#> 972          34.1             191         48.6             126       71.7
#> 973          33.7             166         49.6             158       72.2
#> 974          32.5             102         49.0             136       69.6
#> 975          34.4             216         46.1              41       70.5
#> 976          33.4             143         51.5             248       71.1
#> 977          36.6             308         52.3             266       74.3
#> 978          32.2              86         55.3             324       72.0
#> 979          35.7             272         49.1             137       71.4
#> 980          32.6             108         49.3             147       66.3
#> 981          30.9              41         50.2             183       70.2
#> 982          30.9              39         49.1             141       71.9
#> 983          33.7             167         50.1             180       70.0
#> 984          38.1             328         46.4              52       67.2
#> 985          34.0             183         46.7              66       71.7
#> 986          35.1             244         54.1             307       70.6
#> 987          33.7             163         52.0             259       70.0
#> 988          28.5               5         50.8             217       65.6
#> 989          33.9             181         48.5             122       71.5
#> 990          34.9             239         49.7             161       72.7
#> 991          38.7             336         49.1             142       67.7
#> 992          33.0             127         46.8              70       69.3
#> 993          32.3              88         46.7              63       70.4
#> 994          34.2             203         53.4             292       69.1
#> 995          33.6             153         49.2             145       75.2
#> 996          35.5             261         55.6             327       71.2
#> 997          32.4              96         46.1              40       69.5
#> 998          34.3             209         50.3             188       65.7
#> 999          30.9              40         45.3              26       69.3
#> 1000         36.2             288         48.9             132       71.4
#> 1001         31.3              53         54.2             309       71.8
#> 1002         36.4             296         54.1             308       72.4
#> 1003         37.2             318         46.0              38       73.1
#> 1004         30.5              24         50.3             192       66.2
#> 1005         40.0             346         51.2             234       67.4
#> 1006         35.5             262         50.8             219       67.3
#> 1007         34.7             229         47.7             100       72.6
#> 1008         39.2             341         58.5             343       67.9
#> 1009         33.2             136         53.8             300       69.6
#> 1010         36.8             311         52.0             256       76.1
#> 1011         31.8              69         47.1              80       61.5
#> 1012         38.5             335         51.2             239       73.0
#> 1013         36.3             290         50.5             206       68.1
#> 1014         34.9             235         53.3             287       70.5
#> 1015         30.8              36         49.1             140       73.2
#> 1016         36.5             301         45.1              21       69.8
#> 1017         34.6             227         57.7             341       67.8
#> 1018         35.3             253         45.8              34       69.0
#> 1019         34.1             189         46.6              57       65.8
#> 1020         36.3             291         52.0             257       73.8
#> 1021         34.1             188         55.0             321       65.5
#> 1022         31.9              75         47.2              86       72.9
#> 1023         31.4              55         48.9             135       70.7
#> 1024         28.4               4         50.3             195       70.2
#> 1025         35.8             273         46.7              67       66.7
#> 1026         31.9              76         49.7             165       71.0
#> 1027         33.6             161         50.2             185       70.2
#> 1028         35.3             255         50.7             213       72.7
#> 1029         32.5              99         53.9             301       66.4
#> 1030         34.1             187         50.3             191       72.0
#> 1031         37.8             322         49.7             162       70.4
#> 1032         31.8              73         54.4             312       73.0
#> 1033         35.2             249         45.8              32       72.3
#> 1034         35.5             264         47.6              94       70.4
#> 1035         36.1             285         49.1             138       69.5
#> 1036         33.9             180         46.6              59       69.8
#> 1037         35.8             278         56.2             337       75.2
#> 1038         35.5             263         51.7             252       68.0
#> 1039         38.3             332         49.3             149       72.2
#> 1040         31.5              57         49.5             156       69.6
#> 1041         34.0             184         50.9             222       70.6
#> 1042         28.3               3         44.8              16       67.3
#> 1043         32.0              80         50.9             224       70.7
#> 1044         32.6             106         52.1             263       72.7
#> 1045         35.2             246         48.3             116       69.5
#> 1046         35.0             241         53.1             281       70.8
#> 1047         36.5             298         49.1             139       67.3
#> 1048         32.3              89         45.6              29       69.7
#> 1049         33.4             146         52.6             275       68.9
#> 1050         34.9             234         53.6             296       68.3
#> 1051         31.6              58         48.5             123       70.3
#> 1052         33.0             129         47.1              79       70.6
#> 1053         39.5             344         60.6             347       69.4
#> 1054        100.0             348        100.0             348      100.0
#> 1055        100.0             348        100.0             348      100.0
#> 1056        100.0             348        100.0             348      100.0
#> 1057        100.0             348        100.0             348      100.0
#> 1058        100.0             348        100.0             348      100.0
#> 1059        100.0             348        100.0             348      100.0
#> 1060        100.0             348        100.0             348      100.0
#> 1061        100.0             348        100.0             348      100.0
#> 1062        100.0             348        100.0             348      100.0
#> 1063        100.0             348        100.0             348      100.0
#>      def_ft_pct_rk def_blk_pct def_blk_pct_rk def_stl_pct def_stl_pct_rk
#> 1              302         6.3            309         7.5            281
#> 2              183         8.9            188         8.7            187
#> 3               54         6.1            316         8.3            225
#> 4               79        11.2             74         7.7            273
#> 5              136        10.5            117        10.6             45
#> 6              255         5.6            332         8.3            223
#> 7              192         9.7            147         9.0            154
#> 8               19        13.0             28         9.1            146
#> 9              264         8.4            205        10.4             57
#> 10             343         5.6            331         7.6            278
#> 11              11        10.2            127        11.2             26
#> 12              38        11.2             81         6.9            325
#> 13             149         9.3            171         9.0            147
#> 14             225         6.6            295         8.1            240
#> 15             216        11.0             97         7.1            312
#> 16              34        11.2             78         7.3            300
#> 17              49         9.4            164         8.5            212
#> 18             314         6.0            322         9.2            132
#> 19             282         6.2            314         9.8             85
#> 20             173        10.3            123        10.1             71
#> 21             200        15.5              5        13.1              2
#> 22             126        14.0             16        11.0             33
#> 23              42        11.5             65         7.2            304
#> 24             306         9.9            143         8.9            168
#> 25             245         4.8            343         8.4            220
#> 26             127         8.1            220         9.4            114
#> 27              67         5.1            340         7.4            294
#> 28             293         7.4            261         8.1            244
#> 29              55         7.3            266         9.5            108
#> 30             317         6.3            306         6.7            331
#> 31              39        13.7             21         7.5            282
#> 32             320         6.9            286         9.2            134
#> 33             265         7.4            260         8.9            172
#> 34             227        14.0             17        11.7             18
#> 35               5         5.2            337         7.4            289
#> 36             339         8.1            221         9.4            116
#> 37             279         7.5            256        12.0             14
#> 38             153         4.1            353         7.4            291
#> 39             204         4.8            344         5.6            352
#> 40             101         9.0            182         9.7             92
#> 41             348         8.1            219         9.1            139
#> 42             190         8.2            217        10.0             74
#> 43             122        11.7             56         9.9             78
#> 44             300        12.6             33         9.1            140
#> 45             133        10.9             99        10.1             69
#> 46             344        13.1             26         8.5            213
#> 47             143        12.3             39         9.6            102
#> 48             290        11.5             64         7.7            271
#> 49              64        10.8            103         8.2            228
#> 50             156         9.7            149         8.7            191
#> 51              24        11.9             47         8.1            245
#> 52             226         7.0            284         8.6            203
#> 53             262         7.0            283         6.8            328
#> 54              94         9.1            178         8.7            184
#> 55              58         7.1            275         9.5            106
#> 56             139        11.6             61         9.3            123
#> 57             201        10.1            131         7.2            306
#> 58              30         7.4            257         9.2            133
#> 59              36         4.5            350         6.0            346
#> 60             271         8.8            191         6.0            345
#> 61             171         7.2            271        10.1             73
#> 62             338         6.6            292         6.7            333
#> 63               7        14.8             10         8.4            219
#> 64             219         6.5            299         5.4            353
#> 65             276         7.6            248         9.0            148
#> 66             258         7.1            276         7.9            258
#> 67             336        12.1             43         8.6            195
#> 68             280         8.1            226         7.7            272
#> 69             103        15.4              8        10.8             37
#> 70              48         7.3            263         7.8            268
#> 71               3        12.6             34         8.5            211
#> 72             311        11.1             88         7.7            269
#> 73              81         9.0            180         8.5            209
#> 74             346         8.8            189         6.6            337
#> 75             158        11.2             79        10.6             44
#> 76               9         7.8            238         7.4            293
#> 77             114        13.8             18        10.5             48
#> 78             238         5.2            336         7.0            319
#> 79             145         6.2            313         8.4            215
#> 80             203         6.6            298         5.7            350
#> 81             239        12.5             35        10.3             61
#> 82             299         7.7            246         6.8            327
#> 83             212        10.7            105         8.6            196
#> 84              41         9.5            160         9.2            130
#> 85             172         9.1            177         7.1            313
#> 86             341         7.6            251         7.3            295
#> 87             166        11.1             86         8.1            243
#> 88             330        11.3             69         9.2            137
#> 89             351         7.3            267         8.4            217
#> 90             353         6.0            320         7.6            276
#> 91             278        11.1             92         8.5            214
#> 92              72        11.7             52        12.2              8
#> 93             307        11.7             56         8.0            252
#> 94             228        10.4            119         5.7            351
#> 95             125        11.8             51        10.4             53
#> 96             202        10.7            108         8.2            226
#> 97              21        11.0             94         7.9            260
#> 98             158         9.6            152        10.3             63
#> 99             121         7.6            250         9.2            125
#> 100            188         9.8            146        12.1             12
#> 101            142         9.6            158         7.5            284
#> 102            214        12.4             38         8.6            202
#> 103            291         7.0            280        10.9             34
#> 104            181         7.4            258         7.7            274
#> 105            195         8.4            208         7.3            299
#> 106            111        10.2            128         8.6            204
#> 107            194         8.1            227         7.5            286
#> 108            160         5.1            338         9.1            144
#> 109            257         6.3            307         9.5            103
#> 110            240        10.5            118         8.0            254
#> 111            144        10.7            106         7.9            261
#> 112            102        13.4             23         9.7             96
#> 113            268         9.0            181         8.9            160
#> 114            154        13.4             22         8.8            178
#> 115            220         7.6            247        10.3             60
#> 116            274         4.8            345         8.7            189
#> 117            298        12.4             36        11.1             29
#> 118            149         5.7            328         8.7            190
#> 119            206         9.4            163         8.2            227
#> 120            215         8.0            232         9.1            145
#> 121            289        10.5            114         7.3            301
#> 122            148        10.0            137         7.3            297
#> 123            157         7.7            241        10.4             56
#> 124            151        10.3            124         9.9             80
#> 125            230         6.8            288         9.0            149
#> 126            130         8.7            194         8.2            234
#> 127            333         6.6            296         9.0            158
#> 128             62         7.7            242         9.5            107
#> 129            138         8.9            185         7.3            296
#> 130            318         5.1            339         9.2            135
#> 131            266         8.9            186         7.2            307
#> 132            141        14.6             11        11.6             19
#> 133            349        11.6             62         7.1            310
#> 134            312         5.8            327         6.2            343
#> 135            152         6.0            318         9.6            100
#> 136            254         6.6            294         7.1            314
#> 137            187        16.3              4        13.3              1
#> 138             69        10.9            102         9.5            109
#> 139            303         8.0            228         7.0            321
#> 140            246        10.0            141        10.7             42
#> 141             35         5.9            324         7.2            308
#> 142            241        11.1             90        10.2             68
#> 143            272        13.4             24         6.5            338
#> 144             20        14.3             15         8.6            199
#> 145            249        10.6            111         8.7            182
#> 146            281         8.2            216         8.2            235
#> 147            209         6.4            304         6.1            344
#> 148            273         8.0            229         7.8            266
#> 149             85         8.4            209         7.1            315
#> 150            110        11.4             68         9.2            138
#> 151             37         7.1            274         9.0            155
#> 152            256         8.7            196         7.9            257
#> 153              8         7.2            270         9.0            157
#> 154             33        11.2             76         8.8            180
#> 155             83         6.3            305         9.6            101
#> 156             57         8.8            192        11.3             24
#> 157             45         4.6            348         6.3            341
#> 158            146         6.3            308         9.0            159
#> 159            304         5.2            335         5.8            349
#> 160             99         6.0            319         8.9            171
#> 161            208        11.5             66         9.8             82
#> 162             26         8.3            213         8.6            201
#> 163            310         7.7            243         7.9            262
#> 164             77        15.4              7        11.2             25
#> 165            313         7.3            268        10.3             59
#> 166             74         8.1            222         9.0            152
#> 167            250         9.3            169        10.3             64
#> 168             16        14.5             12         9.4            117
#> 169            184        10.5            116         9.2            126
#> 170            196         6.9            285         7.0            323
#> 171            301        11.9             49         8.7            188
#> 172            155         6.8            290         8.7            186
#> 173            296         9.7            148         8.8            179
#> 174            221         6.5            301         7.6            275
#> 175            244        11.2             77        11.8             16
#> 176             17        10.3            126         9.3            119
#> 177            107         7.9            234         6.3            340
#> 178            316         9.3            168         8.6            197
#> 179             46         6.8            289         8.0            253
#> 180            294         6.5            302         8.9            166
#> 181            186        11.7             54         9.0            153
#> 182             60        13.8             19         9.2            127
#> 183            177         8.9            184         9.5            104
#> 184            231         8.4            203         8.1            246
#> 185            328         7.0            279         8.8            177
#> 186             27        10.1            133        12.2              6
#> 187            352         6.2            311        12.2              7
#> 188            321         7.9            233        10.5             52
#> 189            275        11.3             72         8.9            165
#> 190            108         7.4            259        10.0             75
#> 191             87         7.0            281         7.8            264
#> 192             31         9.3            170         9.2            136
#> 193            198        11.6             60         6.6            336
#> 194            308         9.8            145         9.3            122
#> 195             25        11.9             45         8.0            248
#> 196             75         8.3            215         9.2            128
#> 197            129        10.9            100         8.0            250
#> 198            179         7.5            252         8.1            241
#> 199            235        12.1             42        10.4             55
#> 200            345         6.2            312         7.7            270
#> 201            140         9.4            162         6.9            326
#> 202             61         7.5            254         9.3            124
#> 203            167        11.1             83        11.7             17
#> 204            104         7.0            278         8.1            242
#> 205            322         9.2            173         9.0            150
#> 206             71        11.3             73        10.5             51
#> 207            305         7.1            273         9.7             91
#> 208             65        10.0            136         8.3            224
#> 209             90         9.6            151         8.5            205
#> 210            229         9.1            176         7.0            316
#> 211            309         6.6            297         9.1            141
#> 212            237         7.3            264        10.3             62
#> 213            165        10.0            138         9.7             95
#> 214             44         6.6            293         7.5            285
#> 215            164         9.6            153         8.5            208
#> 216            326        10.8            104         7.4            287
#> 217            232        10.5            113         9.3            120
#> 218             78        10.1            129         9.7             90
#> 219            236         9.6            157         8.0            255
#> 220            340         9.9            142         8.0            249
#> 221             29         7.7            244        11.6             20
#> 222            334         4.7            347         9.8             83
#> 223            182        11.2             75        10.5             49
#> 224             93        11.0             93        10.9             35
#> 225            163        10.5            115        10.9             36
#> 226            284         8.7            193         9.6             98
#> 227             70         9.6            155        11.5             21
#> 228            147        11.7             53         9.0            156
#> 229            267        16.8              2        12.1             11
#> 230            131        12.4             37         7.8            265
#> 231            161         7.0            282         7.4            288
#> 232            263        12.7             30        10.2             66
#> 233            180         8.9            183        11.0             31
#> 234            347         9.4            166        11.0             30
#> 235            247         6.0            317         8.6            200
#> 236            123        10.6            110         8.0            251
#> 237            233        11.1             85        10.0             76
#> 238            224         8.6            198        10.7             41
#> 239             28         4.5            351        10.2             65
#> 240            319         8.8            190         8.7            183
#> 241            113         9.5            159         8.7            192
#> 242            185         8.5            201         9.9             77
#> 243             43         6.2            310        12.1             13
#> 244             23         8.4            204         9.0            151
#> 245              6         5.0            342         5.8            347
#> 246            205         8.4            207         8.0            247
#> 247            248        11.1             87         8.0            256
#> 248            297        13.7             20         9.8             86
#> 249            223        10.7            109         7.6            280
#> 250             10        15.4              6         8.8            174
#> 251             66        14.4             14         9.9             79
#> 252            217         9.6            156         7.2            302
#> 253            329         9.6            154         7.0            317
#> 254             47         6.5            300         9.2            129
#> 255            100         7.7            245         7.4            290
#> 256            268         7.2            272         9.6             99
#> 257            288        11.3             71        10.6             43
#> 258             32        12.6             32         8.8            181
#> 259             86         7.7            240         9.6             97
#> 260            283         7.5            253         9.4            111
#> 261            120         5.3            334         5.8            348
#> 262            210        11.0             96        10.7             39
#> 263            193        10.1            134         9.4            113
#> 264            315         7.5            255         7.6            277
#> 265            295         7.8            237         9.4            118
#> 266            325        17.7              1         8.2            231
#> 267            170         5.0            341         6.7            334
#> 268            332        11.2             80         9.8             88
#> 269             53         5.9            325         7.0            318
#> 270            199         9.7            150         9.2            131
#> 271             73         8.3            211         9.4            112
#> 272             15         8.3            214         7.2            305
#> 273             95         4.6            349        12.2             10
#> 274            117         7.3            265         8.3            221
#> 275            207         7.4            262         8.4            218
#> 276            337        11.0             95         7.3            298
#> 277            342         8.7            197         8.7            185
#> 278             50        12.1             41        11.0             32
#> 279            285        10.1            130         8.2            233
#> 280            168         8.6            199         9.1            143
#> 281            137        11.0             98        10.5             47
#> 282            128        12.7             31         8.2            230
#> 283              4         6.7            291        10.5             50
#> 284            189         8.5            202         8.9            169
#> 285            260         8.1            225         8.7            193
#> 286             22        14.9              9         8.8            175
#> 287            174         8.3            210         6.9            324
#> 288            243        10.4            121        11.1             28
#> 289            286         7.7            239        11.9             15
#> 290             84        11.8             50        12.2              9
#> 291             14         7.8            236         6.7            330
#> 292             52         9.1            175         6.6            335
#> 293             56         4.5            352         8.4            216
#> 294            335         9.1            174         7.4            292
#> 295             51         8.0            231         8.9            164
#> 296            323         5.7            329         7.9            259
#> 297             40        10.7            107         8.3            222
#> 298            261         9.1            179         9.8             84
#> 299             13         8.7            195         8.2            236
#> 300             88        10.1            135         7.1            309
#> 301            350        10.3            125        11.2             27
#> 302            250         9.4            167         8.5            207
#> 303             90         6.9            287         7.6            279
#> 304            175        11.7             58         8.2            238
#> 305              1         4.7            346        10.7             40
#> 306            191         8.9            187         7.9            263
#> 307            213         8.6            200        11.5             23
#> 308             82         8.1            224        12.9              3
#> 309            221        11.1             84         8.2            237
#> 310            105         9.8            144         9.7             93
#> 311              2        12.1             44         9.3            121
#> 312             18        11.3             70         9.5            110
#> 313            259         9.3            172         6.4            339
#> 314            169        13.1             25         8.9            163
#> 315            233        10.4            120         7.0            322
#> 316             12         8.3            212         7.5            283
#> 317            331        11.1             82         7.2            303
#> 318            292        11.7             55        10.1             72
#> 319             96        10.3            122         6.8            329
#> 320            327        10.1            132         9.4            115
#> 321             90         5.5            333         7.8            267
#> 322            134         7.6            249         9.1            142
#> 323            324         7.8            235         6.7            332
#> 324            176         8.1            223         8.9            162
#> 325            211        10.6            112        10.7             38
#> 326             63         8.4            206         8.2            229
#> 327            112        16.4              3        12.4              5
#> 328            109         7.2            269         7.0            320
#> 329             68        12.8             29         9.7             94
#> 330             76        14.4             13        10.1             70
#> 331            115         6.4            303         6.2            342
#> 332             80        12.2             40        11.5             22
#> 333             98         8.2            218         8.9            167
#> 334            106         5.7            330         8.2            239
#> 335            270        11.9             46        10.6             46
#> 336            118         6.0            323         8.6            198
#> 337            132         9.4            165         8.2            232
#> 338            287         5.9            326         8.5            210
#> 339            218        11.9             48         8.8            176
#> 340             59        13.0             27        10.4             54
#> 341            197        11.5             63         9.8             87
#> 342            250         6.0            321         8.9            173
#> 343            178        10.0            139         8.9            170
#> 344            124        11.1             91         9.8             89
#> 345            162        10.9            101        12.4              4
#> 346            242         8.0            230         9.8             81
#> 347            253         6.1            315         8.9            161
#> 348            116         9.5            161         7.1            311
#> 349            119        10.0            140        10.2             67
#> 350             97        11.1             89         8.5            206
#> 351            277        11.4             67        10.3             58
#> 352             88         7.0            277         8.6            194
#> 353            135        11.6             59         9.5            105
#> 354            120         5.4            334         8.3            224
#> 355            300         9.6            120        11.4             25
#> 356            224         5.2            342         8.0            250
#> 357            311         6.6            289         5.8            352
#> 358            216         5.2            338         9.9            110
#> 359            132         6.6            285         9.2            147
#> 360            118         9.5            129        10.1             87
#> 361             55         6.4            296         6.9            321
#> 362            221        10.5             88         7.1            312
#> 363             20        10.6             83         7.1            315
#> 364            267         8.8            164        10.1             85
#> 365            139         8.2            195         6.7            335
#> 366             91         8.3            183         5.1            353
#> 367            277         8.5            174         8.6            198
#> 368            282         7.9            209         7.5            294
#> 369            128         9.9            111         8.2            237
#> 370             93         8.7            167         9.4            141
#> 371            146         5.5            329         7.3            302
#> 372            269         9.3            139        13.4              3
#> 373            263         5.5            327         9.9            105
#> 374            119        10.7             79         9.8            112
#> 375            246         8.3            182         7.5            293
#> 376             91        10.2             98         7.5            291
#> 377            339        10.2             97         8.4            213
#> 378            171         6.5            293        10.3             74
#> 379            338        12.6             32         7.0            318
#> 380              5         9.2            143         8.3            228
#> 381            262         5.4            336        11.6             17
#> 382            228         4.2            350         7.2            309
#> 383            298         9.2            142         8.8            180
#> 384            252         5.8            315         9.0            161
#> 385            280         4.9            346         6.9            325
#> 386            174         7.6            232         8.1            242
#> 387            147         8.4            179         7.7            279
#> 388             97        10.1            101         8.1            245
#> 389            341         7.8            226         8.3            222
#> 390            344         5.8            317         6.2            347
#> 391            240         8.9            156         8.9            170
#> 392            191        13.3             26         8.8            187
#> 393            324         5.1            343         7.2            308
#> 394             18         7.2            255         7.0            319
#> 395             43         7.3            249        11.6             19
#> 396            288         5.8            316         9.0            166
#> 397            239         7.4            241         9.7            122
#> 398             29         5.2            341        11.8             16
#> 399            141         6.5            292         8.3            225
#> 400            222         7.2            253         8.1            247
#> 401            261        11.0             72        10.2             81
#> 402            242        11.5             53         7.4            300
#> 403              7         7.9            216         8.6            201
#> 404             50         9.3            135         6.6            341
#> 405            131         4.1            352         6.7            336
#> 406            133         9.0            152         8.9            172
#> 407            176         9.6            122         9.1            157
#> 408            349         5.4            331         9.4            134
#> 409            173         6.8            282        10.4             73
#> 410            104        11.4             57        11.1             36
#> 411            180         8.2            190         8.3            223
#> 412            327         8.1            200         7.8            266
#> 413             44         8.4            177         6.9            326
#> 414             23        13.0             29        10.2             80
#> 415            190         7.7            229         9.3            145
#> 416            343         6.6            287         8.2            239
#> 417            157         8.3            185         9.1            158
#> 418             13         6.1            307        11.0             45
#> 419            296         5.6            324         9.4            138
#> 420            203        11.8             47         7.9            259
#> 421            294        10.6             81         9.5            128
#> 422             21         7.4            240         9.0            168
#> 423            249         5.5            330         6.7            338
#> 424             87         9.7            119         6.9            327
#> 425            351         9.3            136         7.7            277
#> 426             33         7.1            260         7.6            284
#> 427            328         5.6            323         6.7            334
#> 428            184         9.9            113         7.7            281
#> 429             28        13.6             17        11.2             32
#> 430             67         8.9            155         8.9            173
#> 431            199         9.9            112         6.0            350
#> 432            350         8.6            170        10.4             72
#> 433            207        10.1            103         8.4            212
#> 434            297        15.9              4        12.5             10
#> 435            111        10.5             85         9.8            115
#> 436            181         7.8            220         8.3            221
#> 437             69        12.5             34        12.1             12
#> 438            145         7.2            254         6.8            332
#> 439            127        13.3             25         9.4            131
#> 440            329         7.3            247        10.0             95
#> 441            255         8.3            180         9.2            148
#> 442            110         8.3            184         9.3            142
#> 443            321        11.8             44         7.8            267
#> 444            325        10.4             91         8.2            240
#> 445            134         7.6            233         7.4            296
#> 446            323         8.5            173        12.2             11
#> 447              4         7.6            231        10.3             76
#> 448            116         9.3            137         8.8            182
#> 449            144        13.4             23         7.4            297
#> 450            307         6.9            272         8.8            183
#> 451            326         9.2            141         7.9            262
#> 452            281        11.1             68         8.6            203
#> 453             82         9.0            154         7.3            304
#> 454            268        10.6             84         8.7            195
#> 455            175         8.3            181        10.4             71
#> 456            161        12.4             36        12.9              6
#> 457            305        11.5             56         8.7            193
#> 458            295         5.9            310         9.1            155
#> 459            125         6.6            288        10.2             82
#> 460            231         8.0            205        11.6             21
#> 461            241         9.2            146         8.5            207
#> 462             27         6.7            284         9.1            159
#> 463            150         8.2            192         8.8            184
#> 464             58         6.6            286         9.7            123
#> 465            188         5.8            312         7.8            268
#> 466             15         9.9            115         7.6            288
#> 467             90         9.4            131        10.2             79
#> 468             75        13.6             18         7.6            290
#> 469             66         5.9            311         7.4            299
#> 470            186         7.2            250         7.5            295
#> 471            353         6.8            281         9.3            143
#> 472              1         7.9            214         9.8            113
#> 473            209         8.2            191         8.9            178
#> 474            226        13.6             20        10.8             53
#> 475            106        12.7             31        10.7             56
#> 476            232         7.8            221         8.2            235
#> 477             81        10.8             78         8.2            233
#> 478            233         8.5            176         8.1            243
#> 479            270         7.4            245         9.8            116
#> 480            292        15.9              3        11.1             39
#> 481            348         5.8            318         6.4            345
#> 482            266         3.7            353         6.9            323
#> 483            278         9.9            110        10.2             83
#> 484            182        11.9             42         8.3            218
#> 485             31        13.7             16        11.1             38
#> 486            114         5.7            319        10.1             86
#> 487             76         9.0            150        10.7             57
#> 488            308         8.6            168         7.3            305
#> 489            279         6.8            278         9.0            167
#> 490             64         5.2            339         8.2            238
#> 491             37        10.5             87        11.3             30
#> 492            129         9.3            138        11.6             22
#> 493            130        10.3             95        11.0             42
#> 494             98        10.3             93         7.8            270
#> 495            320        11.2             63        10.6             61
#> 496            259         8.5            171         8.4            215
#> 497             16        12.1             39         8.2            234
#> 498            210         9.6            126        11.4             28
#> 499            273        11.0             73         9.1            154
#> 500            345        11.0             70         7.1            314
#> 501            257         6.9            273         7.6            286
#> 502            163        11.3             61         7.0            316
#> 503             77         7.0            264         7.8            269
#> 504            260         5.9            309         8.5            205
#> 505             89        15.1              7         7.7            272
#> 506            201         9.1            149         6.5            344
#> 507            218         6.3            300         9.4            130
#> 508            244         4.2            351         7.9            264
#> 509             62         9.1            147         8.8            191
#> 510            215         8.9            157        11.4             29
#> 511            302        14.0             13         8.3            219
#> 512             70         6.2            302         7.0            320
#> 513             42        10.9             76         7.2            310
#> 514            309         7.4            242         6.1            349
#> 515            290         7.2            256         8.0            256
#> 516            117         6.2            301         8.8            190
#> 517             85         8.7            165         9.6            125
#> 518            138        14.9              9         9.9            108
#> 519            101        13.2             28         9.4            133
#> 520            234         7.9            210        10.0             97
#> 521            256        10.1            105        13.0              5
#> 522             12        11.0             69         8.3            220
#> 523            172         8.5            175        11.1             41
#> 524            103         7.8            218        12.1             13
#> 525            136        10.2             99        10.9             50
#> 526             99        10.9             74        11.5             23
#> 527            197         7.8            219        14.5              1
#> 528            317         6.6            290         8.8            189
#> 529            124         6.7            283         6.8            330
#> 530            314         8.7            166        10.0             93
#> 531              6        10.4             89         9.9            107
#> 532            311        10.0            109         9.6            127
#> 533             83         6.8            279         9.4            135
#> 534             88         5.8            314         7.7            275
#> 535            166         9.6            125        11.9             14
#> 536             79         6.1            304         6.7            337
#> 537            265         8.1            201         9.7            121
#> 538            164         7.5            236         9.2            149
#> 539            183        11.3             60         9.8            114
#> 540             78         5.4            337         6.5            343
#> 541            143        11.4             58        11.2             31
#> 542            271         5.0            345         7.9            263
#> 543             71        15.3              6        10.6             60
#> 544            287        14.7             11        10.8             55
#> 545            177        10.5             86         8.7            196
#> 546            107         8.2            187         9.8            119
#> 547            149         9.1            148         8.5            209
#> 548            137        13.7             14         8.9            177
#> 549             84         4.5            349         7.7            273
#> 550            113        10.4             92         9.9            103
#> 551             72        10.6             80         8.8            186
#> 552             65         9.6            121         6.7            339
#> 553            286         5.4            335         9.9            109
#> 554            112         7.6            234         8.0            252
#> 555             96         7.8            225        11.2             33
#> 556            230         7.5            238         8.3            226
#> 557             51        12.6             33         8.1            248
#> 558             56        12.1             38        10.5             64
#> 559            198         5.5            326         8.3            229
#> 560            236        16.2              2        10.4             70
#> 561            185         7.9            212         9.6            124
#> 562            303        13.7             15         9.3            143
#> 563            154         9.0            153         6.2            348
#> 564            157         7.2            251         7.9            260
#> 565            331         5.4            332         6.3            346
#> 566              9         7.2            252         7.1            313
#> 567            276        10.3             96        10.9             48
#> 568            318        15.0              8        10.0            101
#> 569            200         8.1            197         9.9            106
#> 570            272         7.8            224         9.3            146
#> 571            319         9.6            124         8.7            197
#> 572            335         8.0            207         9.4            137
#> 573             47         9.4            133        10.9             49
#> 574            285         7.4            244         8.3            231
#> 575            169         9.5            128        10.0             92
#> 576            250         8.2            186         8.2            241
#> 577            214         8.8            163        10.8             54
#> 578            311         7.8            222         7.2            307
#> 579            257         9.9            114         9.9            104
#> 580            195         7.5            237        11.1             40
#> 581             22         6.3            299         8.1            244
#> 582            347         6.9            271         7.9            261
#> 583            108         5.7            320         7.6            287
#> 584             49        11.6             51        13.5              2
#> 585             68        10.1            102         7.9            257
#> 586             46         7.9            208         9.4            139
#> 587            227         7.0            267         7.7            280
#> 588            151         7.1            263         7.0            317
#> 589            322         8.0            206        10.3             75
#> 590            316         8.1            202         8.1            246
#> 591             32        13.6             19        12.7              8
#> 592            243         8.8            162         9.0            164
#> 593             41        11.1             66         8.9            176
#> 594            333         5.6            322         6.9            324
#> 595            283        12.5             35         9.2            150
#> 596            178         8.2            193        10.0             94
#> 597             86        11.6             49        10.8             52
#> 598             10        14.8             10        10.1             90
#> 599            102         5.8            313         9.8            117
#> 600            212         6.9            270         8.0            253
#> 601            179        11.6             52         8.8            188
#> 602            105         6.1            305         7.7            274
#> 603             24         6.1            306         9.4            136
#> 604            168        11.1             67         8.6            200
#> 605             52         9.2            140        10.7             58
#> 606            224         8.9            158         8.9            179
#> 607            189         8.0            203         7.6            283
#> 608            193         9.4            132         8.4            214
#> 609             25         6.3            298         9.0            160
#> 610            162         8.8            161         9.0            163
#> 611            165         7.5            235         7.6            289
#> 612             80        11.9             43         7.4            301
#> 613            229         8.2            194         8.1            249
#> 614            100        13.6             21        10.4             68
#> 615             95        11.3             62        10.5             65
#> 616            352        10.9             77        10.8             51
#> 617            153        10.3             94        11.6             18
#> 618             94         7.5            239         8.5            206
#> 619            251        12.1             40        10.0            102
#> 620            204         7.8            223        10.1             88
#> 621            299        10.9             75        10.0             96
#> 622            142         7.0            269         7.5            292
#> 623            304         7.9            217        12.6              9
#> 624             63         8.4            178         8.4            211
#> 625            192         6.8            275        11.4             24
#> 626            300         9.8            117         8.6            199
#> 627            289         5.5            325        11.6             20
#> 628             60         6.8            277         9.1            156
#> 629            135         7.9            213        12.8              7
#> 630            159        15.6              5         9.0            162
#> 631            152         9.2            144         7.3            303
#> 632            160         9.6            123         5.9            351
#> 633            306         7.9            215         8.3            230
#> 634            123         6.4            295         7.7            276
#> 635            275         9.4            130         8.9            174
#> 636            220        12.2             37         6.8            331
#> 637            330        14.7             12        11.1             37
#> 638              3         7.8            227         6.9            322
#> 639            126        11.8             45         6.8            333
#> 640            205        11.6             50         9.8            111
#> 641             40         7.0            266        10.4             69
#> 642            284        13.3             24        10.6             59
#> 643            293         8.5            172         7.7            278
#> 644             53        11.5             54        10.5             62
#> 645            196         6.2            303         8.5            204
#> 646             57         6.8            280        11.4             26
#> 647             74         6.8            274         9.5            129
#> 648            219        13.6             22         9.6            126
#> 649            213         7.1            261        11.0             46
#> 650            109        12.1             41         9.2            152
#> 651            202         8.2            188         8.0            251
#> 652            148         7.3            248        11.2             34
#> 653             36         5.0            344        11.2             35
#> 654            223        12.9             30         8.9            175
#> 655            156         7.1            262         8.4            217
#> 656            237         7.1            258         8.3            232
#> 657            253         8.1            199         8.5            208
#> 658            315         7.0            265         6.6            342
#> 659            340         9.9            116         7.8            271
#> 660            245        11.5             55         9.4            140
#> 661             19        13.2             27         9.0            169
#> 662             59         7.3            246         8.4            210
#> 663            248         7.1            257         6.8            328
#> 664             72        16.5              1         8.7            192
#> 665              8         6.0            308         8.8            185
#> 666            115         8.8            160        11.4             27
#> 667            334        11.8             46         7.6            285
#> 668            155         7.1            259        10.1             89
#> 669            238         6.5            294        10.5             63
#> 670            254         9.5            127         7.2            311
#> 671            332         7.7            228         7.9            265
#> 672             17         7.9            211         9.8            118
#> 673             48        10.1            104         9.4            132
#> 674            336         4.9            347        10.0             98
#> 675            310         7.7            230         8.2            236
#> 676            170         8.6            169         8.7            194
#> 677             35         8.0            204         7.7            282
#> 678            264         6.8            276         6.6            340
#> 679            274        10.0            106        10.0             99
#> 680            291         7.0            268         8.8            181
#> 681            121         8.2            196         8.6            202
#> 682              2        10.0            108        10.5             67
#> 683            194        10.2            100        11.8             15
#> 684            336        10.4             90         9.7            120
#> 685             61         6.6            291         9.2            151
#> 686             30         8.8            159         8.4            216
#> 687             45         5.4            333         8.0            254
#> 688            234         9.3            134        10.0            100
#> 689            187        11.6             48         8.9            171
#> 690            346         6.4            297        10.3             77
#> 691            208        10.6             82        11.0             44
#> 692            206         8.2            189         7.9            258
#> 693            247         7.4            243        11.0             47
#> 694             38         5.2            340        10.3             78
#> 695            342        11.2             64        10.1             91
#> 696             54         8.1            198         9.0            165
#> 697             14         5.7            321         8.3            227
#> 698             34         4.9            348         6.8            329
#> 699             26         9.2            145         9.2            153
#> 700            211        11.4             59         7.3            306
#> 701            167        11.1             65         8.0            255
#> 702            140        11.0             71        13.1              4
#> 703             39         9.7            118        10.5             66
#> 704            217        10.0            107        11.0             43
#> 705            122         9.0            151        10.2             84
#> 706             11         5.5            328         7.4            298
#> 707             92        10.3             85        12.8              6
#> 708            347         8.6            159         7.7            283
#> 709             57         8.3            177         9.6            128
#> 710            317         7.5            226         9.4            143
#> 711             23         5.8            312         6.4            332
#> 712            166         9.9            103        10.2             86
#> 713            168         7.2            240        10.0            102
#> 714            297         7.0            255         6.1            341
#> 715            101         7.4            228         6.3            337
#> 716             33        11.6             42         7.8            267
#> 717            293         9.0            138         8.1            250
#> 718            120         4.0            343         7.5            287
#> 719            333        10.1             93         6.3            336
#> 720            180         4.6            340         9.1            175
#> 721             20        11.4             50        10.3             74
#> 722            191         7.8            206         8.5            218
#> 723            308         6.2            296        10.2             88
#> 724            336        10.7             70        10.9             46
#> 725            100         6.3            289         7.7            277
#> 726            130         8.8            153         8.8            195
#> 727            280        14.3             12        10.3             72
#> 728            328         6.5            282         6.6            322
#> 729             79        10.4             81        10.4             66
#> 730            321        13.4             20         8.1            251
#> 731            234         8.9            150        10.2             82
#> 732            286         7.0            257         8.8            196
#> 733            250         7.0            249         9.2            168
#> 734            220         8.2            186        10.3             75
#> 735            264         6.5            279         8.6            213
#> 736             65         6.9            263         7.9            264
#> 737            222         5.6            318         9.3            155
#> 738            165         9.9            100         9.0            184
#> 739            265         7.8            211         7.9            265
#> 740              2         5.3            328         6.6            325
#> 741            198         7.9            203         7.3            300
#> 742            251         8.4            165        10.1             92
#> 743            158        11.2             61         8.5            220
#> 744             52         5.8            314         7.7            279
#> 745             77         6.2            292         7.8            271
#> 746            309         6.4            285         6.9            312
#> 747             95         8.2            185         6.7            319
#> 748            129         8.4            167         8.2            243
#> 749            295         4.2            342         8.2            241
#> 750            284         9.9            105        12.0             11
#> 751            143         6.9            262        10.6             57
#> 752            273         9.6            119         6.3            335
#> 753             61         7.1            242         6.4            334
#> 754             19         7.1            245         6.8            315
#> 755            192         7.4            229         9.7            122
#> 756             88         9.4            125         9.8            110
#> 757            231         7.9            201         8.8            200
#> 758            225         7.5            225         9.0            186
#> 759            206        10.7             71         8.5            216
#> 760             83        10.4             78         8.3            233
#> 761             73         7.7            217        10.6             55
#> 762             66         8.5            163        12.9              5
#> 763            233         7.9            202        10.1             94
#> 764             50        14.4             11        12.3              9
#> 765             82         9.8            108        10.9             43
#> 766            173         7.4            229         6.7            318
#> 767            272         7.5            223         6.5            329
#> 768            133         9.0            146         9.9            103
#> 769            276        14.7              7         8.8            203
#> 770             74         7.9            198         8.6            209
#> 771            137         5.5            323         7.8            273
#> 772            282        12.9             24         6.9            310
#> 773            287         6.7            271         6.7            321
#> 774            172         9.6            118         6.6            326
#> 775            269         7.1            244         6.6            323
#> 776             15        13.2             21        10.6             58
#> 777            146         7.4            233         8.2            244
#> 778            235        11.4             48        11.6             19
#> 779             75         6.7            274         9.6            132
#> 780            279         8.9            149        12.7              7
#> 781            134        10.6             76         9.8            107
#> 782            266         8.4            173         8.0            255
#> 783            312         3.7            345         7.7            282
#> 784            194         5.4            325         8.2            240
#> 785            338         5.6            317         8.8            198
#> 786             54        10.4             80         9.3            158
#> 787            178        14.1             14        10.2             85
#> 788            300        10.7             73         8.0            252
#> 789            202         9.7            111         9.6            126
#> 790             48         6.2            295         9.2            164
#> 791            258         9.2            129         8.0            258
#> 792             79         9.8            106        10.0             97
#> 793            188         9.1            136         7.9            260
#> 794            155         6.4            286         9.8            106
#> 795            108        11.5             47         7.1            306
#> 796            176         5.0            336         9.8            114
#> 797            202         6.9            261        11.1             34
#> 798             45        12.2             35        10.6             60
#> 799            118         5.8            313         9.1            178
#> 800             85         5.7            315         7.7            276
#> 801            207        10.0             96         7.7            275
#> 802            170        11.4             54        11.3             29
#> 803             32         6.0            303         7.4            299
#> 804              3         8.2            180         8.3            234
#> 805            110         6.7            270         9.6            124
#> 806            156        11.8             41        11.8             14
#> 807             69        10.6             74        11.3             23
#> 808             16         6.5            278        10.3             76
#> 809             49        14.1             13         6.5            328
#> 810            174         6.3            288        10.9             45
#> 811            247        10.2             90         8.4            228
#> 812            303        10.2             87         9.6            123
#> 813            144         6.4            284         9.1            180
#> 814             42        12.9             25         8.6            208
#> 815            285         5.2            329         8.3            236
#> 816            103         7.7            214         6.6            327
#> 817            305        14.7              8        11.7             18
#> 818            196         7.3            234        10.1             91
#> 819            119         8.6            161        10.6             61
#> 820            254         7.6            220         9.2            171
#> 821              5        14.6              9        11.8             15
#> 822            149         9.6            120        13.1              2
#> 823             22         9.5            124        11.2             31
#> 824            114         6.2            297        12.4              8
#> 825            344         7.1            241         8.1            246
#> 826            204         7.8            209         9.6            129
#> 827            244        10.0             98        10.8             49
#> 828            215         8.3            176        10.2             81
#> 829            201         8.2            183        10.6             56
#> 830             39         7.3            236        10.8             51
#> 831            329        11.6             44         6.8            316
#> 832             81         7.3            235         9.3            151
#> 833             55        12.5             31         9.8            113
#> 834            210        10.7             72         7.2            304
#> 835            177         7.7            218         8.9            192
#> 836            120        13.8             17         7.5            290
#> 837             51         9.8            110         6.9            314
#> 838            259         5.6            316         9.4            147
#> 839            299        12.9             26         9.3            157
#> 840            253         8.7            158         9.5            139
#> 841            107         9.2            130         9.3            150
#> 842             99        12.2             38         9.2            169
#> 843             46        10.2             88        12.1             10
#> 844            132         8.0            194         7.4            294
#> 845            159         8.4            173         8.4            231
#> 846            281         5.9            309         9.5            137
#> 847              9        12.5             29         9.0            187
#> 848            332         7.1            247        10.8             52
#> 849            141        10.7             69        10.3             73
#> 850            316        12.9             27         9.2            166
#> 851             98         6.7            272         6.1            340
#> 852             58         6.2            290         7.5            289
#> 853            164         9.0            140         8.8            204
#> 854            319         9.8            107        10.2             83
#> 855            314         5.5            322         7.3            302
#> 856            184         7.1            243         5.8            346
#> 857            134         5.9            311         8.5            219
#> 858            208         5.1            332         7.4            292
#> 859            330         8.4            166         7.7            278
#> 860             70         8.4            169        11.5             22
#> 861            239         9.0            141         8.4            230
#> 862            320         8.6            160        10.4             69
#> 863            213         8.1            190        10.9             44
#> 864            335         9.8            109        10.5             64
#> 865             60         6.8            267        10.3             77
#> 866            122         7.1            247         9.0            185
#> 867            175        11.2             60         8.8            197
#> 868             62         9.7            115         8.5            221
#> 869             94         8.0            195         9.5            136
#> 870            263         6.9            265        11.3             30
#> 871             64         9.1            137         8.9            190
#> 872            200         9.5            121         9.1            181
#> 873            326         7.3            237         7.8            270
#> 874            218         7.7            213         6.9            313
#> 875            337         5.3            326         7.4            298
#> 876             78         5.1            331         8.8            201
#> 877            310         9.0            144        10.6             63
#> 878            301        14.9              4         8.9            191
#> 879            275        10.8             68         9.7            116
#> 880            289         7.8            205         7.8            268
#> 881            161        14.6             10         9.3            154
#> 882            342         5.6            319         9.1            182
#> 883            183         8.5            164         9.1            174
#> 884            341        11.2             62         6.6            324
#> 885             34         7.4            227         8.4            227
#> 886            226         9.1            133         6.7            320
#> 887            313         8.8            151         9.9            104
#> 888             24         8.4            170        11.3             24
#> 889            223         9.3            128         9.3            149
#> 890            318         6.0            306         9.2            163
#> 891             43        11.4             55         7.6            286
#> 892            315         7.2            239         9.4            142
#> 893            136         5.0            335        11.3             25
#> 894             47         5.5            321         9.2            160
#> 895            261         9.3            127         7.9            261
#> 896             86         6.8            266         6.5            330
#> 897            189         8.9            148         8.6            214
#> 898            105        16.1              1         8.7            206
#> 899            296        14.9              3         9.3            152
#> 900            123         7.0            253        10.3             78
#> 901             63        13.0             23        10.4             67
#> 902            240         9.1            134         9.8            115
#> 903            248         5.2            330         6.1            342
#> 904            228        11.4             52        10.0             95
#> 905            298         8.9            147        10.9             47
#> 906             13         7.0            254         8.6            211
#> 907            257        14.1             15        10.6             62
#> 908            277         7.5            222         9.4            141
#> 909            327         8.2            181         7.8            274
#> 910            216         8.3            178         7.4            293
#> 911             67         8.0            197        11.1             37
#> 912            190        10.0             99        10.0            101
#> 913             90         9.1            132         7.2            305
#> 914            339         8.1            191         8.0            256
#> 915            306         7.9            198         9.5            134
#> 916            124         5.1            333         7.0            307
#> 917             89        14.8              5        13.1              3
#> 918            214        10.9             66         9.4            146
#> 919            291         8.0            193         8.8            202
#> 920            243         6.2            299         6.4            333
#> 921             25         7.0            251         6.2            338
#> 922            162        11.3             57        10.1             90
#> 923            199         6.0            305         8.4            229
#> 924            345        10.3             86         5.9            344
#> 925            185         7.0            256         8.6            212
#> 926             59         7.0            258         5.2            347
#> 927            288         9.7            114        10.2             84
#> 928            343         8.2            184         8.1            249
#> 929            245        11.3             56        10.2             80
#> 930             40         7.4            231        12.0             12
#> 931             56        14.8              6         8.4            226
#> 932            311         7.7            215         9.4            140
#> 933             35         9.9            102        10.0             99
#> 934            179         6.0            304        10.0             98
#> 935            290        10.3             82         9.8            112
#> 936            193         9.0            143         9.4            148
#> 937            160         8.8            155         7.7            280
#> 938            259         8.8            154        10.1             93
#> 939            283        10.1             92         8.5            215
#> 940            109         7.1            246         9.6            125
#> 941             31         7.0            252         9.1            183
#> 942            217        10.5             77         8.3            237
#> 943            169        11.2             59         7.6            285
#> 944            113         6.3            287        11.3             28
#> 945            131         6.0            307         8.4            224
#> 946             71         6.6            276        11.0             39
#> 947             18        16.0              2        11.8             13
#> 948             14         6.6            275        10.3             71
#> 949            248         9.9            104         7.4            296
#> 950            278         3.3            347         8.7            205
#> 951            292         7.5            224         8.9            193
#> 952            302         9.7            117        13.0              4
#> 953            340         7.9            204        10.2             87
#> 954            322         9.5            123        10.0            100
#> 955            271         7.8            207        10.0             96
#> 956            152         6.2            294         9.2            159
#> 957            323        11.4             51         9.2            172
#> 958            209        12.3             34         6.4            331
#> 959            304         8.1            192         9.2            162
#> 960            346         6.5            281         7.9            262
#> 961            125         7.7            216         8.3            238
#> 962            181         6.9            259         7.3            301
#> 963            236         7.8            210        10.2             79
#> 964             21         7.6            219         8.0            259
#> 965            241         7.8            212         8.1            245
#> 966            117         8.4            168        11.6             20
#> 967            128         8.3            179         6.2            339
#> 968            111        12.8             28         9.8            111
#> 969            237         8.2            187        10.8             50
#> 970            246         7.4            232         7.0            309
#> 971            331         8.4            171         9.2            165
#> 972            212         8.2            188         7.5            288
#> 973            230         9.5            122        11.0             41
#> 974            102         6.1            302         8.4            222
#> 975            150        10.1             91        11.7             17
#> 976            186         6.1            301         9.8            109
#> 977            307         5.6            320         8.3            232
#> 978            224         6.4            283         6.8            317
#> 979            196         8.8            152         9.1            179
#> 980             11         6.1            300         7.0            308
#> 981            140        13.5             19         8.7            207
#> 982            221        11.0             65         9.6            130
#> 983            126         6.9            260         8.4            223
#> 984             26        10.4             79         7.4            295
#> 985            211         9.0            139         6.9            311
#> 986            154         4.5            341         8.0            257
#> 987            126         6.7            272         9.7            117
#> 988              6         6.8            268         9.2            170
#> 989            205         6.2            291         8.9            188
#> 990            254         9.4            126         9.3            156
#> 991             36        11.1             63        10.1             89
#> 992             84        12.2             36         9.2            173
#> 993            145        13.9             16        11.1             36
#> 994             76        12.3             33         8.4            225
#> 995            325        10.3             84         9.5            138
#> 996            187         9.0            145         8.2            242
#> 997             96        11.6             43        11.5             21
#> 998              7        10.3             83         8.2            239
#> 999             87        12.4             32         8.0            253
#> 1000           195        11.5             46        11.3             27
#> 1001           219         5.9            310         8.1            248
#> 1002           238         3.8            344         7.8            272
#> 1003           270         5.1            334         8.9            194
#> 1004            10         5.5            324         7.2            303
#> 1005            30         9.9            101         9.1            176
#> 1006            29         4.6            339         9.6            127
#> 1007           242         8.7            156         9.5            133
#> 1008            38         6.0            308        10.5             65
#> 1009           106         6.2            298         9.7            119
#> 1010           334        10.0             97        11.1             35
#> 1011             1        12.2             37        13.6              1
#> 1012           268         8.5            162         9.2            161
#> 1013            43         6.5            280        10.9             48
#> 1014           151         6.9            264        10.3             70
#> 1015           274         8.0            196        10.8             53
#> 1016           114         8.4            172         6.1            343
#> 1017            37         5.0            337        10.7             54
#> 1018            72        11.6             45        11.1             32
#> 1019             8         6.2            293         9.3            153
#> 1020           294         4.9            338         8.1            247
#> 1021             4         6.7            269        10.4             68
#> 1022           262         9.7            116         5.9            345
#> 1023           163        11.9             40        10.6             59
#> 1024           139        13.0             22         9.8            108
#> 1025            17         9.7            112        11.0             40
#> 1026           182        10.1             95         8.5            217
#> 1027           138         9.2            131         8.6            210
#> 1028           252        10.2             89         9.4            145
#> 1029            12         5.3            327         9.1            177
#> 1030           227         8.7            156         7.8            266
#> 1031           148        10.9             67         9.7            120
#> 1032           267         6.6            277         7.5            291
#> 1033           232         7.8            208         9.2            167
#> 1034           147        11.4             49        11.1             33
#> 1035            93         8.2            182        11.7             16
#> 1036           116        13.5             18         7.9            263
#> 1037           324         7.3            238         9.5            135
#> 1038            41        12.5             30         9.7            118
#> 1039           229         7.9            200         7.4            297
#> 1040           104        11.1             64         9.6            131
#> 1041           156         9.0            142         9.9            105
#> 1042            27         9.1            135         7.7            281
#> 1043           167         9.7            113        11.3             26
#> 1044           254         8.4            173         7.8            269
#> 1045            96        11.4             53         8.8            199
#> 1046           171         7.6            221         8.9            189
#> 1047            28         8.1            189         8.3            235
#> 1048           112        12.0             39         9.4            144
#> 1049            68         7.0            250         9.7            121
#> 1050            53        11.2             58         8.0            254
#> 1051           142        10.1             94        11.0             42
#> 1052           153        10.6             75        11.1             38
#> 1053            91         3.7            346         7.7            284
#> 1054           348         0.0            348         0.0            348
#> 1055           348         0.0            348         0.0            348
#> 1056           348         0.0            348         0.0            348
#> 1057           348         0.0            348         0.0            348
#> 1058           348         0.0            348         0.0            348
#> 1059           348         0.0            348         0.0            348
#> 1060           348         0.0            348         0.0            348
#> 1061           348         0.0            348         0.0            348
#> 1062           348         0.0            348         0.0            348
#> 1063           348         0.0            348         0.0            348
#>      def_non_stl_pct def_non_stl_pct_rk def_a_pct def_a_pct_rk def_fg_3a_pct
#> 1                8.1                321      57.0          307          42.5
#> 2               10.5                 97      48.4           78          39.9
#> 3                7.3                343      48.8           87          48.1
#> 4               10.3                110      53.2          211          35.3
#> 5                9.6                168      52.3          189          38.5
#> 6                9.1                239      48.7           85          39.4
#> 7                8.8                256      51.8          172          40.9
#> 8                8.3                308      43.4           19          42.5
#> 9               11.2                 43      56.5          299          49.9
#> 10               9.2                220      48.0           73          43.2
#> 11               8.2                315      54.9          263          47.4
#> 12               9.7                165      51.0          148          35.6
#> 13               9.2                218      53.4          216          37.0
#> 14               8.5                289      51.5          161          35.9
#> 15               8.2                311      44.8           31          35.9
#> 16               7.2                347      46.2           52          37.4
#> 17               9.6                175      55.0          264          38.7
#> 18               7.5                340      45.3           38          35.9
#> 19               9.5                183      50.6          131          39.6
#> 20               9.4                195      51.8          170          41.0
#> 21              11.5                 23      52.2          185          43.5
#> 22              10.0                129      58.8          324          45.7
#> 23               8.2                318      41.0            5          34.9
#> 24               9.1                232      50.6          128          45.1
#> 25               9.5                184      49.9          115          41.6
#> 26              11.4                 27      55.2          268          39.2
#> 27               8.6                276      54.3          251          35.6
#> 28               9.0                242      55.6          279          36.7
#> 29               9.6                172      51.1          150          39.1
#> 30               8.2                319      51.8          173          38.3
#> 31               7.4                342      51.9          175          37.2
#> 32               7.2                349      43.1           13          31.6
#> 33               9.4                201      53.9          231          44.9
#> 34               7.8                329      50.6          129          36.6
#> 35               8.2                312      45.4           39          36.9
#> 36               9.9                138      45.0           32          36.1
#> 37              11.3                 38      48.7           82          33.1
#> 38               9.8                145      53.8          229          44.7
#> 39               7.8                332      58.3          318          43.6
#> 40              11.1                 53      52.0          179          37.5
#> 41              10.4                101      48.8           90          38.0
#> 42              11.2                 47      54.2          245          39.1
#> 43               9.1                230      51.0          146          39.6
#> 44               9.5                187      53.4          219          43.2
#> 45               8.0                322      53.8          227          44.0
#> 46               9.2                226      55.1          266          42.3
#> 47               7.6                336      47.7           67          39.2
#> 48              10.7                 78      53.2          209          39.4
#> 49              11.4                 30      54.1          238          36.8
#> 50               9.4                191      56.7          303          33.8
#> 51              12.6                  5      57.5          311          42.4
#> 52               9.4                192      53.6          223          44.9
#> 53               7.8                330      47.8           68          36.4
#> 54               7.3                344      44.4           25          34.5
#> 55               9.2                223      42.9           11          35.6
#> 56               9.9                135      57.4          310          41.5
#> 57              12.6                  4      53.6          225          39.2
#> 58              11.2                 42      45.9           50          37.0
#> 59               8.8                263      46.8           59          38.4
#> 60               9.9                141      41.3            6          33.3
#> 61              10.5                 95      51.3          155          38.5
#> 62               7.7                333      45.6           44          35.5
#> 63               9.6                171      51.3          153          40.2
#> 64              10.0                131      49.1           95          39.5
#> 65               7.3                345      53.4          218          35.6
#> 66               9.5                177      55.1          265          42.0
#> 67              11.7                 19      50.3          125          39.8
#> 68               9.2                227      55.5          277          39.8
#> 69              12.0                 13      49.5          100          40.3
#> 70              10.0                126      56.3          296          45.5
#> 71               9.5                178      53.5          222          38.4
#> 72               7.4                341      48.5           79          37.8
#> 73               9.8                148      57.8          314          41.2
#> 74               7.9                324      57.4          309          39.0
#> 75              11.1                 50      50.9          140          37.2
#> 76               9.7                166      53.2          210          41.7
#> 77               8.4                295      41.4            7          34.9
#> 78              11.1                 49      50.1          121          40.7
#> 79              10.9                 64      56.2          294          47.8
#> 80               9.7                160      47.6           66          35.3
#> 81               8.5                292      49.9          116          39.2
#> 82               8.9                253      52.1          183          43.4
#> 83               9.8                152      56.7          302          40.6
#> 84               9.1                236      54.2          247          43.8
#> 85               9.2                219      54.1          242          34.7
#> 86               7.7                334      53.1          206          37.1
#> 87               9.4                200      49.2           97          38.5
#> 88               7.9                327      52.2          184          36.1
#> 89               9.0                245      55.8          285          49.8
#> 90               9.7                162      42.4           10          32.7
#> 91               9.9                133      51.6          162          39.0
#> 92               7.8                328      46.1           51          38.9
#> 93              11.1                 51      46.7           57          37.7
#> 94              10.5                 96      50.8          137          37.3
#> 95              10.1                124      52.0          177          40.7
#> 96               8.4                299      43.3           17          33.4
#> 97               9.3                206      45.5           43          35.0
#> 98              10.3                117      55.3          272          34.5
#> 99               8.6                281      46.8           58          43.3
#> 100              9.1                235      54.2          244          42.2
#> 101              9.2                211      41.9            8          36.3
#> 102              8.8                262      50.8          138          39.8
#> 103              8.9                254      67.8          351          41.0
#> 104              9.0                243      55.5          278          43.8
#> 105              8.7                275      45.8           46          33.8
#> 106             10.2                119      54.1          239          41.9
#> 107             12.0                 12      54.3          250          43.3
#> 108             10.1                122      48.9           91          43.5
#> 109              9.8                146      51.7          164          36.4
#> 110              8.3                307      54.1          241          40.6
#> 111              7.2                350      60.5          338          41.4
#> 112              8.5                286      49.9          114          41.1
#> 113              8.3                309      43.3           16          33.4
#> 114              9.1                229      47.9           71          38.6
#> 115              8.6                283      47.2           62          40.9
#> 116              8.2                310      51.9          174          39.9
#> 117             11.0                 58      56.4          297          43.4
#> 118             10.3                113      49.7          105          39.4
#> 119              9.8                154      56.2          295          40.2
#> 120              7.9                325      50.9          143          39.1
#> 121              9.2                215      50.9          142          37.6
#> 122              8.5                290      45.2           36          32.8
#> 123             10.5                 91      50.9          144          36.0
#> 124             11.7                 20      52.1          182          34.3
#> 125              7.0                351      53.0          204          41.0
#> 126              9.9                139      56.1          292          39.7
#> 127              9.5                182      52.5          193          40.5
#> 128              9.1                237      55.4          276          42.4
#> 129              9.3                205      49.8          111          34.6
#> 130             10.5                 90      53.9          232          39.1
#> 131              7.8                331      52.1          181          39.2
#> 132              9.3                210      55.1          267          45.4
#> 133              8.4                296      48.1           74          36.3
#> 134              8.4                301      48.7           84          43.0
#> 135             11.8                 16      51.5          160          35.6
#> 136             11.1                 48      48.9           92          37.7
#> 137             10.9                 63      58.6          321          35.3
#> 138              8.7                274      52.7          198          41.8
#> 139              9.8                144      59.9          336          34.8
#> 140              9.8                149      55.3          271          41.8
#> 141             10.3                115      45.4           40          34.4
#> 142              9.2                228      45.4           41          35.8
#> 143              7.5                339      51.9          176          39.4
#> 144              9.9                137      52.9          203          40.5
#> 145              8.8                258      53.2          212          37.7
#> 146              9.3                204      44.4           26          32.3
#> 147              9.0                246      44.0           22          30.7
#> 148             10.8                 68      45.0           35          31.2
#> 149              9.5                180      46.2           53          35.5
#> 150              9.8                151      48.0           72          35.8
#> 151              9.0                247      50.1          117          37.2
#> 152              8.7                273      51.5          159          39.5
#> 153              9.6                173      56.8          306          39.1
#> 154             10.4                103      51.7          165          39.9
#> 155              9.4                193      40.5            3          32.5
#> 156              7.2                348      48.1           75          38.1
#> 157              8.4                302      47.6           64          34.3
#> 158              7.6                335      54.0          235          43.6
#> 159              9.5                189      52.6          196          40.2
#> 160             11.3                 41      44.6           30          38.3
#> 161              8.8                259      59.8          332          36.0
#> 162              8.7                272      49.8          108          41.3
#> 163              9.5                188      56.7          304          40.4
#> 164             11.3                 39      54.1          240          42.0
#> 165             11.4                 31      53.2          213          35.4
#> 166              9.2                224      55.9          287          34.1
#> 167             10.8                 73      56.0          289          42.3
#> 168             11.5                 25      50.7          132          42.8
#> 169              9.6                176      48.8           89          39.4
#> 170             10.4                102      46.2           54          33.8
#> 171             11.3                 37      52.9          201          33.7
#> 172              9.4                199      48.6           81          39.2
#> 173              9.0                248      52.2          187          43.2
#> 174             10.2                120      47.5           63          36.8
#> 175              9.0                241      44.4           27          35.3
#> 176              8.6                277      45.8           47          30.1
#> 177              9.8                153      47.9           70          37.2
#> 178              7.5                337      51.3          154          37.7
#> 179              9.1                231      44.5           28          31.2
#> 180              9.3                208      52.9          200          40.0
#> 181              9.5                181      48.7           83          32.7
#> 182              9.4                202      55.6          280          38.2
#> 183             11.2                 45      54.6          255          36.9
#> 184              8.2                316      51.3          156          40.0
#> 185              9.4                198      50.1          120          37.4
#> 186             10.5                 87      57.7          313          43.4
#> 187              8.3                306      56.0          291          35.5
#> 188             11.8                 18      49.7          104          38.3
#> 189              8.5                285      62.2          345          41.1
#> 190              9.3                209      59.6          328          41.8
#> 191              9.7                155      55.7          284          44.0
#> 192             10.6                 84      55.9          286          33.2
#> 193             10.3                112      43.1           14          32.7
#> 194             10.8                 75      45.9           48          35.7
#> 195              8.7                271      61.8          343          38.7
#> 196              8.8                264      43.5           20          35.9
#> 197              8.9                250      55.4          275          29.0
#> 198             10.8                 72      38.6            1          39.6
#> 199             11.4                 32      52.5          194          36.8
#> 200              9.7                157      45.5           42          36.0
#> 201              8.4                303      53.7          226          45.3
#> 202             10.8                 70      53.1          207          46.6
#> 203             10.5                 94      47.0           60          38.2
#> 204             10.8                 69      49.1           94          35.7
#> 205             10.5                 92      50.3          126          41.9
#> 206             10.5                 93      49.7          106          41.2
#> 207              9.3                203      51.4          157          42.9
#> 208             10.9                 61      54.8          261          39.2
#> 209              9.1                233      49.4           99          34.1
#> 210              9.8                142      49.6          103          38.2
#> 211             11.8                 17      46.5           56          35.3
#> 212              9.5                185      60.3          337          37.6
#> 213             10.7                 82      40.3            2          35.9
#> 214             12.9                  3      47.8           69          36.9
#> 215             10.4                 98      54.2          248          43.5
#> 216             10.3                116      50.7          135          36.6
#> 217              9.9                140      59.7          331          36.3
#> 218              9.2                217      50.9          141          37.4
#> 219              8.9                252      59.8          334          48.8
#> 220             11.2                 46      45.0           33          31.1
#> 221             11.2                 44      54.5          253          42.9
#> 222             10.4                105      53.8          228          33.7
#> 223              8.8                266      48.8           88          34.2
#> 224             11.5                 24      48.3           77          38.1
#> 225             11.6                 21      53.6          224          33.8
#> 226             10.1                123      53.4          217          39.4
#> 227             10.3                107      57.6          312          36.8
#> 228             12.6                  6      65.2          348          44.5
#> 229             11.0                 60      67.8          352          48.1
#> 230              9.2                222      49.5          101          38.4
#> 231              9.3                207      51.7          168          40.5
#> 232             10.1                125      43.8           21          38.8
#> 233             12.5                  8      59.7          330          41.8
#> 234             10.4                104      55.2          270          38.4
#> 235             10.7                 77      43.2           15          35.2
#> 236              8.2                314      55.7          282          42.2
#> 237             11.3                 40      58.8          323          40.6
#> 238              9.1                234      53.0          205          33.2
#> 239             13.7                  2      54.1          242          36.8
#> 240              8.9                251      51.1          152          36.6
#> 241             10.4                100      61.4          341          37.1
#> 242              9.7                159      53.4          215          39.3
#> 243              8.6                284      50.1          118          38.3
#> 244              9.2                213      49.8          107          39.1
#> 245              9.6                169      59.7          329          47.9
#> 246              9.4                194      44.3           24          34.6
#> 247              8.4                300      61.4          342          39.3
#> 248             10.0                132      44.5           29          39.6
#> 249             10.6                 86      59.8          333          45.2
#> 250             11.0                 57      51.5          158          43.0
#> 251              8.6                279      52.0          180          40.8
#> 252             10.9                 65      55.9          288          40.5
#> 253              8.2                317      59.9          335          46.0
#> 254             11.9                 14      51.6          163          37.5
#> 255             10.7                 80      50.1          122          40.6
#> 256             10.7                 83      45.9           49          35.0
#> 257              9.5                179      51.0          145          37.4
#> 258              9.8                143      52.0          177          42.0
#> 259             12.5                  9      50.7          134          35.6
#> 260              8.4                294      55.2          269          44.7
#> 261             11.1                 52      42.0            9          38.4
#> 262              7.0                352      50.2          123          30.4
#> 263             10.5                 88      48.9           93          38.7
#> 264             11.0                 55      54.8          259          38.1
#> 265             11.3                 36      48.2           76          39.6
#> 266             10.5                 89      53.4          220          40.5
#> 267             13.8                  1      50.6          130          39.6
#> 268             10.0                127      53.1          208          40.2
#> 269             10.8                 76      54.7          258          46.5
#> 270             11.3                 35      48.6           80          37.3
#> 271             10.3                114      56.0          290          35.4
#> 272             10.2                121      43.1           12          37.5
#> 273             12.5                  7      51.7          166          36.0
#> 274              8.3                304      49.3           98          40.9
#> 275              9.1                240      52.8          199          40.9
#> 276              9.8                150      50.8          139          36.3
#> 277             11.4                 29      58.4          320          40.4
#> 278             10.6                 85      55.4          274          34.6
#> 279              7.5                338      59.2          326          44.1
#> 280              8.7                268      45.6           45          34.7
#> 281             10.8                 74      58.1          317          39.4
#> 282              7.3                346      45.3           37          35.8
#> 283              9.4                197      55.7          281          35.4
#> 284             12.3                 10      54.1          236          36.0
#> 285              9.6                174      52.3          188          36.7
#> 286              8.8                265      52.2          186          37.4
#> 287              8.6                278      53.9          230          33.2
#> 288              8.5                287      49.9          112          33.3
#> 289              9.6                167      51.0          147          34.4
#> 290              7.9                326      45.0           33          40.0
#> 291             12.3                 11      49.5          102          37.0
#> 292              8.5                293      51.8          171          38.7
#> 293             10.3                108      52.3          190          40.3
#> 294              9.2                212      54.2          246          40.5
#> 295             10.9                 66      49.8          109          37.1
#> 296              8.7                267      62.0          344          42.9
#> 297              8.9                255      40.9            4          27.3
#> 298              8.4                298      66.8          350          44.7
#> 299             10.9                 67      44.2           23          38.0
#> 300              9.7                158      50.8          136          33.9
#> 301             10.4                 99      65.8          349          42.4
#> 302             10.0                130      50.3          124          36.2
#> 303              9.9                136      52.4          192          34.1
#> 304              8.2                313      49.1           96          36.7
#> 305             10.2                118      53.5          221          38.4
#> 306              9.2                214      56.4          298          37.1
#> 307             11.5                 22      53.9          233          49.3
#> 308             11.4                 33      58.0          316          34.7
#> 309              9.7                161      56.5          300          32.0
#> 310              8.5                291      61.4          340          37.0
#> 311              8.8                260      54.6          256          38.2
#> 312              7.9                323      51.1          151          38.1
#> 313             11.4                 28      54.4          252          38.6
#> 314              9.2                221      46.4           55          34.7
#> 315              9.4                196      47.2           61          35.6
#> 316              9.6                170      54.7          257          40.2
#> 317             10.7                 81      52.6          197          42.3
#> 318             10.4                106      48.7           86          41.4
#> 319             10.8                 71      49.8          110          37.3
#> 320             10.7                 79      55.7          283          40.7
#> 321              9.7                156      54.1          237          37.2
#> 322              8.8                257      57.0          308          41.0
#> 323             11.0                 54      56.8          305          41.0
#> 324             10.0                128      50.1          119          34.9
#> 325              8.4                297      64.8          347          48.1
#> 326              8.6                282      47.6           65          32.1
#> 327              7.0                353      49.9          113          34.9
#> 328              9.1                238      56.6          301          40.3
#> 329              8.8                261      58.3          319          42.8
#> 330              8.6                280      61.1          339          37.7
#> 331              9.0                249      50.3          127          38.2
#> 332             11.9                 15      50.7          133          33.2
#> 333              9.2                225      51.7          167          37.9
#> 334              8.5                288      56.1          293          43.8
#> 335              8.7                270      54.8          260          37.6
#> 336             10.3                111      54.0          234          37.3
#> 337              8.1                320      52.3          191          47.3
#> 338              8.7                269      43.4           18          36.3
#> 339             11.0                 59      54.6          254          41.1
#> 340              9.7                164      69.1          353          41.2
#> 341              9.0                244      53.3          214          36.0
#> 342              8.3                305      52.9          202          37.0
#> 343              9.5                186      51.7          169          39.5
#> 344             11.4                 26      58.8          322          51.4
#> 345             10.9                 62      51.1          149          35.7
#> 346              9.5                190      62.4          346          40.5
#> 347              9.9                134      58.9          325          39.5
#> 348              9.7                163      55.3          273          40.1
#> 349              9.2                216      54.3          249          37.1
#> 350             11.0                 56      57.8          315          37.3
#> 351              9.8                147      52.6          195          37.7
#> 352             10.3                109      59.2          327          44.0
#> 353             11.4                 34      54.9          262          36.6
#> 354              9.9                161      46.2           54          33.7
#> 355              8.4                309      53.2          229          40.6
#> 356             11.7                 26      58.3          317          38.2
#> 357              9.1                249      42.7           17          34.2
#> 358              7.8                338      39.3            4          31.9
#> 359              8.4                308      51.0          165          38.4
#> 360              8.3                318      43.4           26          34.1
#> 361              8.7                285      43.9           30          36.7
#> 362              8.0                333      51.0          164          44.3
#> 363              8.0                334      52.0          196          34.8
#> 364             11.1                 62      54.0          243          42.3
#> 365              9.0                256      52.3          203          24.5
#> 366              8.9                264      47.6           83          31.1
#> 367             10.5                114      51.4          182          34.6
#> 368              9.9                162      47.2           77          41.0
#> 369             10.9                 82      52.3          205          36.8
#> 370             11.3                 47      46.6           61          36.4
#> 371              9.5                208      33.3            1          23.5
#> 372             14.4                  1      53.9          240          37.9
#> 373              9.9                164      55.1          277          36.6
#> 374             12.6                  5      45.4           47          37.3
#> 375              9.8                179      54.5          259          40.8
#> 376             10.8                 85      49.1          109          39.5
#> 377              9.2                243      54.4          256          39.1
#> 378             10.3                126      62.1          344          41.0
#> 379             10.9                 81      53.1          225          43.6
#> 380             10.4                121      47.2           75          33.2
#> 381              8.1                330      43.1           22          38.1
#> 382              9.2                236      54.9          270          48.3
#> 383              7.7                342      50.4          149          40.1
#> 384              8.6                300      51.7          189          42.5
#> 385              9.6                197      45.8           51          41.2
#> 386              9.1                244      49.9          127          36.9
#> 387              8.6                299      44.5           36          37.1
#> 388             10.5                120      45.9           52          36.2
#> 389              9.8                170      52.2          202          39.3
#> 390              8.9                272      42.7           18          35.6
#> 391             11.6                 28      44.1           33          31.0
#> 392              8.8                277      55.9          287          42.2
#> 393              9.5                207      56.7          296          33.6
#> 394             11.5                 38      43.3           25          34.0
#> 395              8.3                324      47.4           80          41.0
#> 396             12.4                  9      50.1          133          36.2
#> 397              9.5                210      50.6          155          39.1
#> 398             11.8                 22      53.9          239          42.8
#> 399              8.6                301      47.6           82          31.8
#> 400             11.3                 50      53.4          233          39.1
#> 401             10.6                103      51.2          171          35.6
#> 402              9.8                178      45.4           48          37.7
#> 403              8.7                284      50.1          135          38.6
#> 404              7.5                350      54.9          271          35.8
#> 405             10.2                136      46.6           60          36.8
#> 406              9.1                246      56.4          291          39.8
#> 407              7.3                351      48.4           98          33.1
#> 408              7.8                341      42.5           15          30.7
#> 409             10.4                125      50.2          139          40.5
#> 410             11.9                 15      44.2           34          35.7
#> 411             10.6                 97      41.6           12          32.2
#> 412              9.3                225      45.0           42          34.8
#> 413              8.4                310      43.1           20          36.9
#> 414             10.7                 87      62.2          346          33.1
#> 415              8.9                270      46.9           69          38.7
#> 416              7.8                340      45.1           43          30.3
#> 417             11.5                 34      52.0          195          34.2
#> 418             11.5                 29      51.2          172          31.3
#> 419              9.1                251      52.4          207          36.9
#> 420             11.7                 25      58.7          320          40.0
#> 421             11.0                 67      51.3          176          37.7
#> 422              8.7                282      51.2          173          40.1
#> 423              7.9                336      37.9            2          30.7
#> 424             10.0                154      47.8           89          32.5
#> 425              9.0                259      50.2          144          38.7
#> 426              8.7                292      53.6          236          45.1
#> 427             10.7                 94      53.1          223          41.6
#> 428             10.1                148      55.0          273          34.9
#> 429              9.0                260      46.8           68          26.7
#> 430              8.7                289      53.3          231          42.5
#> 431              8.2                326      44.6           39          35.5
#> 432             10.7                 91      48.8          101          32.8
#> 433             10.6                101      57.4          307          36.5
#> 434             11.2                 58      44.5           38          40.2
#> 435              9.8                171      49.7          122          38.5
#> 436             11.0                 69      46.4           56          32.1
#> 437             10.6                100      52.7          215          35.0
#> 438              8.4                313      49.8          126          35.3
#> 439              8.7                286      51.0          167          39.4
#> 440              7.7                345      50.6          156          37.6
#> 441              9.8                184      50.1          136          32.5
#> 442             10.1                146      44.5           37          39.3
#> 443             10.1                152      49.1          110          39.5
#> 444             10.0                158      43.4           27          34.7
#> 445              8.7                290      50.2          138          32.6
#> 446             12.1                 14      54.3          250          42.3
#> 447              9.2                239      47.3           79          34.6
#> 448              9.2                242      55.8          285          39.7
#> 449              8.4                315      55.7          284          37.7
#> 450              8.7                287      54.3          253          39.9
#> 451              7.8                337      52.8          217          43.8
#> 452             10.6                 98      48.3           95          35.6
#> 453             11.3                 52      61.6          343          37.6
#> 454              8.8                275      58.7          320          40.0
#> 455              9.2                241      44.0           32          33.3
#> 456             11.6                 27      52.6          211          34.8
#> 457             10.1                149      58.1          315          41.9
#> 458             11.8                 19      47.0           71          36.9
#> 459              8.5                306      52.9          218          38.6
#> 460             11.5                 37      55.0          276          42.1
#> 461              8.3                321      50.7          159          36.2
#> 462             10.9                 78      50.3          147          37.5
#> 463              9.7                192      54.6          263          30.8
#> 464             10.7                 95      57.3          304          42.9
#> 465             10.3                130      49.0          106          39.6
#> 466             10.6                 96      59.8          333          39.6
#> 467              9.6                196      49.4          117          33.2
#> 468              9.8                180      46.7           66          38.3
#> 469              9.0                257      39.7            6          38.2
#> 470             11.5                 33      47.2           76          35.9
#> 471              8.8                276      47.6           84          40.5
#> 472              8.1                328      51.5          185          31.9
#> 473              9.8                175      51.4          181          36.0
#> 474             11.2                 57      54.1          244          36.0
#> 475              8.9                268      49.7          124          39.8
#> 476              9.7                193      52.2          201          37.9
#> 477              9.4                221      61.0          339          45.7
#> 478              9.7                191      50.9          163          43.7
#> 479             10.1                144      54.8          268          34.4
#> 480             10.2                135      49.3          116          35.7
#> 481              9.8                172      41.8           13          27.4
#> 482              9.1                247      54.9          272          40.1
#> 483             10.4                124      57.8          312          42.9
#> 484              9.8                181      40.6            9          35.2
#> 485              7.6                349      52.6          213          41.3
#> 486             10.9                 74      53.2          230          35.0
#> 487              9.3                231      51.9          194          34.8
#> 488              8.7                280      53.5          235          39.7
#> 489              9.4                222      55.5          282          35.5
#> 490              9.4                215      50.8          161          39.9
#> 491              9.0                254      50.1          137          39.9
#> 492              8.4                316      48.2           94          31.6
#> 493             11.2                 55      47.1           73          38.2
#> 494              8.3                320      39.4            5          28.3
#> 495             10.8                 84      50.5          154          32.3
#> 496              8.6                293      51.7          190          43.5
#> 497              9.5                213      56.5          293          38.6
#> 498              8.9                266      54.1          247          30.2
#> 499             10.3                134      51.2          170          36.6
#> 500              8.3                319      51.4          183          41.3
#> 501              9.4                223      56.0          289          42.0
#> 502              8.8                273      52.6          212          31.2
#> 503              9.8                168      49.2          113          40.9
#> 504              8.5                302      55.8          286          38.9
#> 505             10.4                122      54.1          246          39.5
#> 506             10.3                127      53.2          227          37.5
#> 507              9.1                245      48.9          103          36.1
#> 508             11.4                 42      45.3           45          39.0
#> 509              9.4                217      62.7          349          45.4
#> 510              8.9                271      55.0          275          37.3
#> 511              8.7                283      50.5          152          36.2
#> 512             10.9                 80      46.5           57          39.7
#> 513              7.2                352      43.8           29          35.8
#> 514             11.2                 56      51.7          192          38.0
#> 515              9.7                187      50.7          160          35.3
#> 516             10.6                104      43.2           23          34.1
#> 517             10.0                156      43.0           19          33.0
#> 518              9.6                198      48.5          100          34.5
#> 519              9.0                261      57.8          311          41.8
#> 520              8.5                304      42.5           16          29.3
#> 521             11.8                 18      54.2          249          33.2
#> 522             12.5                  7      43.7           28          28.2
#> 523             11.4                 44      51.2          175          40.5
#> 524             10.9                 76      62.9          350          43.3
#> 525             11.2                 60      41.9           14          33.3
#> 526             11.0                 66      53.1          224          37.5
#> 527             11.4                 45      57.8          312          31.1
#> 528              9.3                224      49.9          128          38.8
#> 529             10.2                140      60.7          336          41.5
#> 530              9.6                202      50.7          158          33.8
#> 531              8.8                279      58.4          318          39.2
#> 532              9.8                182      47.8           88          38.4
#> 533              8.2                325      61.0          338          47.8
#> 534              8.3                323      53.2          228          39.0
#> 535              9.6                203      51.3          180          36.9
#> 536              9.6                204      46.7           63          37.1
#> 537              8.6                295      57.4          306          44.5
#> 538             10.2                138      53.1          226          33.8
#> 539             10.6                110      59.3          325          42.0
#> 540              9.8                176      39.9            7          37.7
#> 541              8.9                267      57.0          300          47.5
#> 542             11.2                 54      38.1            3          26.7
#> 543              9.6                199      52.5          208          36.5
#> 544              9.6                200      72.7          353          47.9
#> 545             10.4                123      49.5          120          40.6
#> 546             10.5                112      55.7          283          31.8
#> 547              9.1                248      48.9          104          41.9
#> 548              8.7                291      43.9           31          35.3
#> 549              9.2                237      51.1          168          41.4
#> 550             10.1                147      46.9           70          35.2
#> 551              7.8                339      48.4           96          41.4
#> 552              9.0                255      55.4          280          34.3
#> 553             10.8                 86      56.3          290          33.6
#> 554             10.3                133      54.6          264          39.3
#> 555              8.7                281      58.8          322          42.8
#> 556              8.6                296      40.3            8          30.5
#> 557              9.7                189      51.3          178          38.6
#> 558              8.1                332      49.3          115          32.9
#> 559              8.6                298      54.5          260          44.3
#> 560              8.9                265      60.4          334          38.2
#> 561              8.7                288      54.7          267          40.8
#> 562              9.3                234      54.8          268          36.4
#> 563              9.0                263      54.0          242          39.1
#> 564              9.4                220      50.0          130          42.8
#> 565              8.9                269      44.5           35          30.9
#> 566              7.1                353      51.7          191          38.4
#> 567             12.6                  6      59.3          326          36.0
#> 568             11.9                 16      50.0          130          29.8
#> 569              9.7                190      59.7          332          37.1
#> 570              8.6                297      56.0          288          39.9
#> 571             10.0                155      59.6          329          43.0
#> 572             11.3                 51      58.0          314          36.8
#> 573             11.4                 43      50.5          151          38.2
#> 574              7.6                347      52.6          210          41.9
#> 575             10.7                 93      51.2          174          37.3
#> 576              8.8                274      62.2          345          39.2
#> 577              7.7                344      56.9          298          41.9
#> 578             11.0                 71      48.9          102          32.2
#> 579              9.5                211      47.7           87          38.0
#> 580             10.5                119      53.5          234          46.1
#> 581              9.1                252      45.9           53          36.0
#> 582              9.6                201      47.7           86          42.3
#> 583             11.0                 70      56.8          297          37.4
#> 584              9.2                240      57.6          309          42.2
#> 585              7.7                343      45.3           46          30.4
#> 586              9.7                185      52.7          214          43.9
#> 587             11.3                 53      48.1           91          39.5
#> 588              8.4                314      48.1           92          33.1
#> 589              9.2                235      55.2          278          34.7
#> 590             10.6                 99      50.3          145          36.8
#> 591             12.2                 13      50.2          142          39.5
#> 592              8.4                317      59.6          330          42.8
#> 593              7.6                348      49.5          118          35.9
#> 594             10.3                129      41.3           11          29.5
#> 595             10.6                106      50.7          157          34.7
#> 596              8.1                331      54.1          245          41.4
#> 597              9.3                232      43.3           24          32.8
#> 598             10.1                150      53.0          219          36.9
#> 599             10.9                 77      46.5           59          37.2
#> 600             10.6                105      54.3          254          36.6
#> 601              7.9                335      46.7           65          40.1
#> 602             11.1                 61      50.3          148          41.9
#> 603              9.3                230      52.0          198          38.9
#> 604              8.2                327      50.4          150          34.6
#> 605             10.3                128      61.5          342          47.1
#> 606             12.3                 10      50.0          130          35.9
#> 607              8.4                312      45.2           44          39.6
#> 608              9.2                238      54.6          265          34.7
#> 609             11.3                 48      50.1          134          34.5
#> 610              9.3                226      48.4           97          41.6
#> 611             12.4                  8      56.6          295          39.9
#> 612             10.5                118      61.1          341          46.6
#> 613             12.8                  3      50.5          153          35.4
#> 614              9.5                206      40.8           10          33.0
#> 615             10.1                143      49.5          119          36.8
#> 616             10.9                 75      48.1           93          28.4
#> 617              9.3                227      52.8          216          37.6
#> 618             10.9                 79      55.0          274          38.5
#> 619             10.6                102      56.9          299          44.4
#> 620              9.9                163      51.6          188          44.1
#> 621              9.1                253      47.1           72          34.2
#> 622              8.4                311      50.3          146          40.6
#> 623             13.5                  2      45.5           49          32.6
#> 624              9.5                209      50.2          140          38.2
#> 625              9.6                194      51.3          179          39.0
#> 626             10.7                 90      52.0          199          39.9
#> 627             11.8                 23      54.4          258          35.0
#> 628             10.6                107      43.1           21          31.7
#> 629             11.5                 35      53.0          222          40.1
#> 630             10.6                109      44.7           40          34.6
#> 631             10.1                153      51.5          184          36.7
#> 632              9.9                159      62.5          347          42.4
#> 633             10.5                115      49.2          111          34.0
#> 634              8.8                278      49.0          105          33.7
#> 635              9.7                188      49.6          121          36.3
#> 636             11.1                 65      53.8          237          36.9
#> 637             11.0                 72      57.6          310          41.3
#> 638              9.9                165      49.3          114          43.4
#> 639             10.5                116      54.7          266          38.1
#> 640              9.4                218      51.9          193          33.0
#> 641             11.2                 59      59.7          331          40.7
#> 642             10.7                 88      54.3          252          39.8
#> 643             10.6                108      61.1          340          40.5
#> 644             11.8                 20      57.1          303          33.1
#> 645             10.2                141      57.1          301          40.9
#> 646             11.8                 17      51.0          166          40.1
#> 647             11.4                 39      44.8           41          32.0
#> 648              9.3                233      54.6          262          41.6
#> 649              9.8                174      52.3          206          37.2
#> 650             10.7                 92      50.2          141          37.0
#> 651              9.9                166      47.2           74          31.7
#> 652             11.5                 36      52.2          200          38.6
#> 653              9.0                258      52.5          209          34.1
#> 654              9.8                173      45.6           50          36.3
#> 655             10.3                131      60.9          337          41.6
#> 656             11.3                 49      53.4          232          34.9
#> 657              9.8                169      52.3          204          34.6
#> 658              9.4                219      60.6          335          40.5
#> 659              8.3                322      54.0          241          41.2
#> 660             10.3                132      49.1          108          36.9
#> 661              9.9                160      49.9          129          38.1
#> 662              9.1                250      54.3          255          34.8
#> 663              9.8                183      46.5           58          32.5
#> 664             10.5                111      47.5           81          42.6
#> 665             11.5                 31      50.2          143          34.5
#> 666             12.3                 12      53.8          238          37.3
#> 667              9.4                214      46.6           62          29.9
#> 668             11.8                 21      47.3           78          36.0
#> 669              9.8                177      55.5          281          38.9
#> 670              9.5                212      53.0          220          32.6
#> 671             11.1                 64      51.1          169          45.3
#> 672              8.1                329      46.3           55          34.8
#> 673             10.5                113      59.5          328          38.4
#> 674             12.3                 11      58.4          319          35.9
#> 675              9.4                216      54.2          248          48.7
#> 676             10.5                117      48.5           99          36.4
#> 677              8.6                294      49.7          125          39.8
#> 678              7.7                346      49.7          123          33.2
#> 679             10.9                 83      49.1          107          37.9
#> 680              9.7                186      59.2          324          45.6
#> 681              9.0                262      62.6          348          34.3
#> 682             11.0                 73      53.0          221          38.7
#> 683             11.5                 30      59.0          323          39.6
#> 684             12.7                  4      63.9          351          50.3
#> 685              8.5                307      59.4          327          34.6
#> 686              9.3                228      57.1          302          42.7
#> 687             10.1                151      56.4          292          41.1
#> 688              8.5                305      54.5          261          45.3
#> 689             10.1                145      46.7           64          32.9
#> 690             10.2                139      58.2          316          33.9
#> 691             11.4                 41      47.6           85          37.5
#> 692             11.4                 40      51.5          185          36.8
#> 693              9.6                195      55.2          279          38.1
#> 694             11.3                 46      49.2          112          35.2
#> 695              8.5                303      54.3          251          45.4
#> 696             10.7                 89      57.3          305          40.7
#> 697              9.9                167      51.3          177          34.9
#> 698             11.0                 68      47.9           90          35.1
#> 699              9.6                205      56.6          294          42.7
#> 700             11.5                 32      50.9          162          39.7
#> 701              9.3                229      46.7           67          37.2
#> 702             10.0                157      65.3          352          46.8
#> 703             10.1                142      57.6          308          36.9
#> 704             11.7                 24      51.5          187          32.1
#> 705             10.2                137      54.4          257          38.7
#> 706             11.1                 63      52.0          197          37.7
#> 707             11.6                 37      51.8          177          34.3
#> 708              7.7                331      48.2           91          39.8
#> 709              6.8                343      42.2           12          36.2
#> 710              7.7                329      50.0          135          39.3
#> 711              9.7                167      53.0          203          31.8
#> 712             12.6                 11      53.3          208          40.7
#> 713              8.6                285      62.1          336          42.5
#> 714              9.3                212      42.5           18          38.9
#> 715             11.1                 63      41.4            6          35.7
#> 716              8.3                304      60.2          328          39.5
#> 717              9.7                177      51.7          174          40.0
#> 718             11.0                 66      55.3          259          33.4
#> 719              8.5                295      42.0           10          31.9
#> 720              9.5                195      57.9          305          33.5
#> 721              7.3                337      43.7           23          29.5
#> 722              8.9                262      54.0          228          38.8
#> 723              8.7                276      50.8          153          34.4
#> 724              9.3                216      54.8          249          38.9
#> 725             10.6                 86      43.4           19          29.2
#> 726              9.6                185      44.3           29          31.4
#> 727              9.2                232      51.4          168          39.5
#> 728              9.3                213      36.5            1          22.3
#> 729              8.9                261      58.4          309          38.5
#> 730              7.2                340      52.9          201          37.5
#> 731             13.1                  5      71.8          347          48.5
#> 732              8.7                274      51.4          167          33.5
#> 733             12.3                 17      45.2           43          37.7
#> 734             12.4                 14      57.7          301          47.5
#> 735              9.0                255      45.4           45          40.2
#> 736              8.2                311      45.1           38          32.6
#> 737              9.8                160      57.1          293          40.5
#> 738             11.4                 50      55.9          273          45.9
#> 739             11.9                 30      48.8          102          35.1
#> 740             10.9                 75      50.4          146          37.8
#> 741             10.2                122      49.6          122          37.7
#> 742             10.8                 77      44.3           28          35.4
#> 743              9.5                198      46.3           63          36.7
#> 744             10.0                140      55.3          256          37.1
#> 745              8.6                280      47.4           82          35.0
#> 746              9.0                253      42.5           17          33.1
#> 747              6.7                344      46.2           61          43.4
#> 748              8.5                292      44.2           27          32.9
#> 749             10.2                116      56.4          283          33.6
#> 750             10.3                107      60.1          326          45.8
#> 751              8.7                275      45.5           47          33.7
#> 752              6.4                346      49.3          116          35.9
#> 753              9.3                222      46.2           62          34.7
#> 754             11.5                 45      49.4          119          33.8
#> 755              7.1                341      45.1           39          38.4
#> 756              9.6                180      46.0           53          38.1
#> 757             10.1                126      52.1          180          35.3
#> 758              9.7                171      53.5          212          37.4
#> 759              8.8                266      52.8          200          33.5
#> 760              7.9                324      57.4          298          39.8
#> 761             10.3                112      52.7          197          37.9
#> 762             13.6                  2      49.9          131          34.5
#> 763              8.4                297      46.6           69          35.6
#> 764              9.8                159      50.8          154          39.4
#> 765             10.0                142      55.6          266          40.3
#> 766             11.4                 49      52.4          190          41.2
#> 767              9.7                164      55.6          268          30.1
#> 768              8.0                318      52.7          196          39.2
#> 769              9.4                201      55.9          272          40.7
#> 770              7.4                336      47.9           85          30.1
#> 771              9.4                204      53.1          207          35.1
#> 772             10.0                136      53.8          223          35.1
#> 773              8.8                270      57.3          297          38.2
#> 774              8.1                315      55.3          257          38.4
#> 775              9.5                197      44.5           31          35.8
#> 776              9.2                230      44.8           33          36.1
#> 777              9.6                183      50.3          142          38.1
#> 778              9.9                146      50.6          150          35.1
#> 779              7.8                325      55.2          255          37.6
#> 780             11.5                 42      57.2          295          35.6
#> 781              9.8                153      44.8           34          31.0
#> 782              8.1                312      47.3           81          40.4
#> 783              9.1                239      41.2            3          29.9
#> 784             10.0                139      45.5           50          31.1
#> 785             10.4                100      52.3          189          40.2
#> 786              8.5                289      41.5            7          33.1
#> 787             10.1                132      51.3          164          36.2
#> 788              9.2                231      53.9          224          30.1
#> 789              8.9                263      47.5           83          33.0
#> 790              9.4                205      49.0          110          41.8
#> 791             11.7                 35      51.3          166          35.6
#> 792              9.5                192      56.9          290          38.4
#> 793              9.9                150      60.6          331          43.5
#> 794              8.8                269      47.2           79          36.4
#> 795             10.8                 79      46.0           54          38.9
#> 796              9.1                245      49.1          114          35.7
#> 797             10.4                103      46.0           56          33.5
#> 798             13.2                  4      45.0           36          38.2
#> 799              8.1                314      45.9           52          31.6
#> 800             10.7                 85      48.9          107          40.6
#> 801              9.1                247      52.4          191          41.9
#> 802              8.3                302      57.7          299          33.4
#> 803              9.9                147      53.6          215          40.1
#> 804             11.6                 36      54.3          232          43.5
#> 805             10.1                133      54.8          245          35.7
#> 806              8.1                313      48.8          104          32.3
#> 807              9.2                235      44.0           25          34.3
#> 808             11.7                 33      43.6           22          36.8
#> 809             11.1                 61      49.9          128          40.9
#> 810             11.5                 43      54.0          227          34.7
#> 811              9.5                194      53.7          217          38.7
#> 812              9.7                168      58.9          315          49.8
#> 813              8.8                267      54.1          230          36.6
#> 814             11.6                 41      60.0          325          39.0
#> 815             10.1                127      56.8          285          44.1
#> 816              7.6                334      42.4           16          33.9
#> 817              8.5                293      68.5          345          44.2
#> 818              9.8                155      52.6          195          37.3
#> 819              9.3                220      56.2          277          45.4
#> 820             10.8                 81      46.2           60          34.9
#> 821              9.4                208      53.3          209          37.7
#> 822              9.6                186      55.1          253          35.3
#> 823              9.4                210      50.5          149          38.3
#> 824              9.2                227      46.8           73          36.8
#> 825             10.9                 74      42.4           15          37.8
#> 826              9.6                182      50.8          152          39.1
#> 827              9.1                244      51.8          178          38.2
#> 828             11.8                 31      55.8          271          36.4
#> 829              7.3                338      51.7          176          44.0
#> 830              9.6                179      50.4          145          36.5
#> 831              8.0                319      53.5          213          34.2
#> 832              8.7                273      56.0          276          34.4
#> 833              9.9                148      53.4          210          37.5
#> 834              9.1                242      42.1           11          36.3
#> 835              9.1                248      60.3          329          42.4
#> 836              5.1                347      65.0          341          46.1
#> 837              8.8                268      52.3          187          41.8
#> 838             11.0                 64      50.0          135          44.6
#> 839              9.6                184      49.9          129          39.4
#> 840              8.2                308      59.8          323          43.1
#> 841             12.2                 21      50.9          155          40.9
#> 842             10.6                 91      48.2           92          40.6
#> 843              9.8                157      52.2          186          36.9
#> 844             11.6                 40      43.9           24          40.0
#> 845              9.4                200      41.3            4          31.6
#> 846              9.4                206      47.1           76          34.7
#> 847             10.2                118      56.8          287          43.1
#> 848              9.7                169      45.5           49          31.4
#> 849              7.6                333      53.0          205          46.4
#> 850              8.0                317      59.2          318          41.0
#> 851              9.9                149      55.3          260          38.0
#> 852              9.7                175      47.1           78          37.9
#> 853              9.7                163      55.9          273          32.8
#> 854              8.3                306      47.6           84          38.4
#> 855              9.9                151      48.6           98          36.7
#> 856              8.0                322      48.1           88          36.7
#> 857             10.0                141      50.4          147          43.4
#> 858             10.5                 96      46.0           55          41.2
#> 859             11.2                 56      41.6            9          30.2
#> 860             10.6                 89      45.2           41          28.4
#> 861              8.3                303      58.6          312          40.7
#> 862              9.4                209      46.9           74          28.0
#> 863             10.4                105      52.4          192          36.5
#> 864              6.9                342      49.7          123          32.8
#> 865             10.9                 67      49.2          115          32.3
#> 866              9.7                162      52.2          184          36.8
#> 867              8.6                278      64.1          339          40.5
#> 868              9.8                156      51.5          172          38.1
#> 869             12.2                 20      54.6          244          38.0
#> 870              8.5                294      55.9          273          38.4
#> 871              8.2                310      58.9          316          34.7
#> 872             11.5                 44      56.3          282          40.6
#> 873             10.1                129      60.9          333          40.4
#> 874             10.5                 95      54.6          241          36.6
#> 875              9.6                187      46.7           72          31.9
#> 876             12.1                 25      48.8          100          36.9
#> 877              8.9                260      57.9          303          37.7
#> 878              9.1                249      49.0          112          34.5
#> 879             10.2                117      48.1           89          37.6
#> 880              9.0                257      49.6          120          36.3
#> 881             10.3                115      47.1           77          33.3
#> 882              9.5                190      54.8          247          39.7
#> 883              8.5                291      50.2          140          39.1
#> 884              9.4                207      41.3            5          32.5
#> 885              8.6                279      51.3          163          37.7
#> 886              9.8                158      46.1           58          33.7
#> 887             10.8                 80      55.6          267          36.3
#> 888              9.6                178      61.5          335          37.8
#> 889              9.3                218      52.8          199          38.3
#> 890             11.7                 34      55.4          262          45.8
#> 891              9.2                229      60.0          324          45.3
#> 892              9.9                144      59.3          319          34.5
#> 893              7.4                335      68.6          346          42.7
#> 894             13.1                  8      45.5           48          37.2
#> 895              9.0                254      44.9           35          34.3
#> 896              9.4                199      47.9           86          39.5
#> 897              8.7                277      57.2          294          33.1
#> 898              9.3                223      49.9          133          37.8
#> 899             10.1                125      51.9          179          39.8
#> 900             10.4                104      63.1          337          42.7
#> 901              9.7                172      48.3           93          37.7
#> 902              8.4                298      54.1          229          44.9
#> 903              8.2                309      42.3           14          38.8
#> 904              9.7                176      48.4           96          37.5
#> 905              9.0                251      52.1          181          34.0
#> 906              9.3                214      45.2           40          42.3
#> 907             12.3                 18      46.4           66          38.1
#> 908             11.4                 48      58.2          307          35.9
#> 909             10.3                108      50.4          143          37.9
#> 910              9.0                259      46.6           68          36.1
#> 911             10.7                 83      56.3          281          40.5
#> 912              8.5                290      50.1          139          36.0
#> 913             11.5                 46      46.7           70          43.1
#> 914              7.8                328      55.1          253          32.4
#> 915              7.8                326      60.4          330          38.1
#> 916              8.3                305      46.0           57          33.2
#> 917             10.6                 87      51.2          160          35.1
#> 918             12.7                  9      50.4          148          40.9
#> 919              9.3                219      53.0          204          37.7
#> 920             11.2                 60      51.3          162          32.4
#> 921              8.3                301      56.8          286          36.3
#> 922              8.1                316      54.6          242          39.6
#> 923             10.2                120      55.5          263          39.4
#> 924              8.0                320      44.7           32          35.6
#> 925             10.4                106      46.3           64          31.0
#> 926              9.0                256      44.5           30          26.7
#> 927             11.3                 54      45.7           51          31.3
#> 928             10.4                101      53.4          211          38.6
#> 929              9.1                246      45.0           37          36.7
#> 930             10.4                 99      53.7          216          38.8
#> 931             10.1                128      45.5           46          35.5
#> 932              9.5                196      46.3           65          37.2
#> 933             10.0                138      57.1          292          30.2
#> 934              9.8                154      49.0          109          33.3
#> 935              6.6                345      56.9          291          37.3
#> 936              8.6                281      45.3           44          32.7
#> 937             10.1                131      59.5          321          41.5
#> 938              8.8                272      55.4          261          37.3
#> 939              8.5                288      58.7          313          41.4
#> 940             10.5                 97      57.3          296          39.3
#> 941              7.6                332      54.4          238          36.5
#> 942              9.4                211      48.7           99          37.6
#> 943              9.6                189      50.7          151          34.4
#> 944             10.3                110      48.0           87          36.7
#> 945             10.2                121      54.5          240          37.6
#> 946              9.7                170      47.3           80          32.0
#> 947             10.7                 82      55.0          251          37.3
#> 948              9.7                165      48.4           95          40.9
#> 949              8.5                296      54.4          236          37.0
#> 950             10.7                 84      50.3          141          40.6
#> 951              7.9                323      52.4          193          42.2
#> 952             11.6                 39      54.4          237          34.2
#> 953              8.0                321      52.6          194          39.8
#> 954             10.3                114      51.1          158          39.8
#> 955             10.0                137      52.2          185          42.4
#> 956              8.9                264      63.1          338          38.4
#> 957             10.0                134      48.4           94          34.3
#> 958              8.8                271      53.5          214          33.7
#> 959              9.2                228      48.8          101          34.2
#> 960             10.9                 71      43.5           21          37.0
#> 961              8.5                286      48.8          105          33.8
#> 962             11.3                 52      50.4          144          35.9
#> 963             13.2                  3      53.1          206          34.8
#> 964              7.2                339      46.7           70          35.1
#> 965             14.5                  1      54.3          234          36.2
#> 966              9.1                243      49.3          117          36.1
#> 967             10.0                135      46.5           67          39.4
#> 968              9.2                226      51.2          159          38.4
#> 969             10.1                130      58.4          311          39.7
#> 970              9.1                241      51.0          157          34.3
#> 971             12.5                 13      53.8          220          35.9
#> 972             10.3                109      42.3           13          35.7
#> 973              8.9                265      49.6          121          37.6
#> 974             12.1                 23      49.8          126          31.9
#> 975             10.1                124      57.9          304          33.5
#> 976              9.2                236      49.0          111          39.2
#> 977              8.5                287      51.5          171          34.5
#> 978              7.7                330      51.4          169          39.1
#> 979              9.0                250      51.7          175          32.9
#> 980              9.3                221      49.8          125          33.4
#> 981             12.1                 26      51.4          170          39.1
#> 982             10.6                 90      55.7          270          40.6
#> 983             10.2                119      53.8          221          44.9
#> 984             10.5                 98      54.6          243          44.2
#> 985             10.3                111      43.4           20          32.3
#> 986              9.2                225      55.0          250          36.8
#> 987             11.1                 62      51.0          156          39.3
#> 988             12.3                 19      48.2           90          36.3
#> 989             11.2                 59      60.9          332          41.4
#> 990             10.8                 78      54.3          233          39.4
#> 991              9.8                152      56.2          279          35.5
#> 992              8.4                299      54.8          248          37.7
#> 993              7.8                327      56.3          280          35.5
#> 994             11.2                 57      58.8          314          37.9
#> 995              9.2                234      56.2          278          35.1
#> 996             10.5                 92      55.7          269          38.6
#> 997             11.3                 53      49.1          113          35.5
#> 998              9.4                202      49.9          132          37.1
#> 999              9.9                145      54.3          234          42.5
#> 1000            10.8                 76      45.2           42          39.3
#> 1001            10.5                 93      49.7          124          38.5
#> 1002            10.9                 72      53.0          202          38.4
#> 1003             9.1                240      49.3          118          40.4
#> 1004             9.4                203      49.8          127          40.6
#> 1005             9.2                224      59.4          320          33.3
#> 1006             9.3                217      53.8          222          37.3
#> 1007             9.7                166      51.3          165          37.0
#> 1008             8.6                284      64.2          340          43.0
#> 1009            11.2                 58      48.8          103          36.0
#> 1010            10.9                 73      54.8          246          37.2
#> 1011            12.1                 24      50.0          135          33.6
#> 1012             9.0                252      49.0          108          31.6
#> 1013            13.1                  7      59.7          322          37.8
#> 1014            11.9                 29      51.2          161          36.6
#> 1015             9.7                174      48.8          106          40.7
#> 1016            12.0                 28      47.0           75          29.7
#> 1017            11.5                 47      58.0          306          39.0
#> 1018            11.3                 55      58.4          310          36.5
#> 1019            12.4                 15      54.5          239          41.8
#> 1020            11.6                 38      55.1          252          40.6
#> 1021            12.5                 12      67.8          343          47.4
#> 1022            10.9                 69      51.7          173          35.4
#> 1023            10.5                 94      49.9          134          41.4
#> 1024             9.8                161      56.9          289          39.1
#> 1025            11.0                 65      68.2          344          43.0
#> 1026            12.0                 27      56.7          284          43.3
#> 1027             9.1                237      52.3          188          36.0
#> 1028             9.0                258      49.9          130          40.9
#> 1029            10.6                 88      54.1          231          36.4
#> 1030            12.4                 16      44.1           26          31.1
#> 1031             8.2                307      55.5          265          40.7
#> 1032             9.6                181      41.5            8          33.8
#> 1033             9.2                233      38.4            2          27.1
#> 1034             8.4                300      55.3          258          42.2
#> 1035            10.9                 68      53.9          226          33.0
#> 1036            10.9                 70      53.9          225          39.7
#> 1037            12.6                 10      57.7          300          39.3
#> 1038            10.4                102      58.2          308          45.0
#> 1039             8.6                282      48.5           97          40.9
#> 1040             9.3                215      46.2           59          37.8
#> 1041            12.2                 22      52.2          183          36.7
#> 1042            10.3                113      53.7          218          33.3
#> 1043             9.5                191      52.2          182          35.1
#> 1044             9.1                238      52.7          198          34.7
#> 1045            10.2                123      56.8          288          31.7
#> 1046             9.5                193      60.2          327          47.3
#> 1047             9.7                173      53.7          219          39.2
#> 1048             9.9                143      50.0          135          38.5
#> 1049             9.6                188      65.4          342          47.8
#> 1050            11.8                 32      57.8          302          40.9
#> 1051            13.1                  6      61.3          334          31.8
#> 1052            11.3                 51      55.5          264          33.0
#> 1053             8.6                283      59.0          317          36.7
#> 1054             0.0                348     100.0          348         100.0
#> 1055             0.0                348     100.0          348         100.0
#> 1056             0.0                348     100.0          348         100.0
#> 1057             0.0                348     100.0          348         100.0
#> 1058             0.0                348     100.0          348         100.0
#> 1059             0.0                348     100.0          348         100.0
#> 1060             0.0                348     100.0          348         100.0
#> 1061             0.0                348     100.0          348         100.0
#> 1062             0.0                348     100.0          348         100.0
#> 1063             0.0                348     100.0          348         100.0
#>      def_fg_3a_pct_rk adj_d adj_d_rk
#> 1                 298 109.7      272
#> 2                 229  97.4       56
#> 3                 348 105.3      183
#> 4                  63 104.4      165
#> 5                 180 110.7      295
#> 6                 211 109.6      271
#> 7                 261 105.9      201
#> 8                 299  89.2        5
#> 9                 352  94.0       20
#> 10                308 110.4      289
#> 11                343 102.2      127
#> 12                 76  96.7       45
#> 13                119 109.0      262
#> 14                 86 102.3      131
#> 15                 83 112.9      323
#> 16                140 108.5      256
#> 17                185 101.5      118
#> 18                 87 103.4      151
#> 19                223 110.9      297
#> 20                265  99.0       77
#> 21                315  95.9       36
#> 22                338 102.8      143
#> 23                 53  98.5       69
#> 24                333 104.4      164
#> 25                279 110.7      293
#> 26                198 105.6      194
#> 27                 72 113.4      331
#> 28                108 109.6      268
#> 29                197  99.3       83
#> 30                170 113.2      328
#> 31                131  90.2        9
#> 32                  9  97.4       55
#> 33                331 107.8      245
#> 34                104  97.6       61
#> 35                117 111.7      310
#> 36                 94 103.9      155
#> 37                 18 102.0      121
#> 38                329 115.4      346
#> 39                318 118.9      352
#> 40                146 106.8      226
#> 41                158  97.2       49
#> 42                195 107.2      229
#> 43                220 102.8      140
#> 44                307  95.6       34
#> 45                324 104.7      170
#> 46                293 101.3      110
#> 47                200 109.0      260
#> 48                213 101.4      113
#> 49                115 107.7      241
#> 50                 30 111.6      308
#> 51                297 105.7      196
#> 52                332 105.7      197
#> 53                103 108.9      257
#> 54                 42 101.5      117
#> 55                 71 106.1      206
#> 56                278 106.1      207
#> 57                199 113.9      334
#> 58                121  99.6       87
#> 59                177 111.2      303
#> 60                 24 102.8      142
#> 61                179 100.0       97
#> 62                 68 110.6      292
#> 63                239  96.5       42
#> 64                217 107.8      244
#> 65                 74 111.1      302
#> 66                287 110.0      281
#> 67                225  98.6       71
#> 68                227 111.6      309
#> 69                240  84.1        1
#> 70                337 105.3      185
#> 71                175  95.6       33
#> 72                156 102.8      141
#> 73                272 101.3      111
#> 74                191 114.2      336
#> 75                132 103.3      148
#> 76                280 110.2      284
#> 77                 52  91.6       12
#> 78                257  97.2       51
#> 79                344 109.8      277
#> 80                 59 109.7      275
#> 81                203  96.8       47
#> 82                312 113.0      325
#> 83                255 112.0      312
#> 84                320  92.0       15
#> 85                 50 103.9      154
#> 86                125 118.4      350
#> 87                181 100.4       99
#> 88                 95 112.5      318
#> 89                351 107.3      233
#> 90                 14 106.3      212
#> 91                190 102.3      130
#> 92                189  97.4       57
#> 93                152  99.6       88
#> 94                138 115.3      345
#> 95                256 101.4      115
#> 96                 26  98.2       65
#> 97                 57  88.5        4
#> 98                 43  99.2       80
#> 99                311 102.3      132
#> 100               290 101.0      106
#> 101                99 102.8      139
#> 102               226  97.2       52
#> 103               266 112.6      320
#> 104               322 100.4       98
#> 105                31 108.1      250
#> 106               286  99.0       78
#> 107               310 105.0      180
#> 108               316 104.6      166
#> 109               102 105.4      188
#> 110               254 102.5      133
#> 111               277 102.7      137
#> 112               271  91.2       11
#> 113                25 102.1      125
#> 114               183  90.1        8
#> 115               260 106.5      218
#> 116               230 112.7      321
#> 117               313 108.0      248
#> 118               208 102.1      123
#> 119               237 111.4      304
#> 120               194 113.5      332
#> 121               147 111.0      301
#> 122                17 106.7      222
#> 123                88 107.6      239
#> 124                39  98.1       62
#> 125               267 109.0      261
#> 126               224  99.2       81
#> 127               249 104.2      161
#> 128               296 109.7      276
#> 129                46 103.9      156
#> 130               192 120.6      353
#> 131               202 110.7      294
#> 132               336  91.7       13
#> 133                98 108.4      255
#> 134               305 114.7      339
#> 135                75 107.5      235
#> 136               155 102.7      136
#> 137                60  93.5       18
#> 138               284  92.3       17
#> 139                51 109.2      265
#> 140               281 110.3      286
#> 141                41 106.8      225
#> 142                80  98.6       73
#> 143               207  94.1       21
#> 144               251  96.0       38
#> 145               153 103.5      152
#> 146                12  98.3       67
#> 147                 5 108.9      258
#> 148                 8 104.9      178
#> 149                69 106.1      208
#> 150                82  94.4       26
#> 151               130 103.3      149
#> 152               214 107.6      240
#> 153               196 108.3      253
#> 154               228  95.9       35
#> 155                13  99.9       94
#> 156               160 110.3      287
#> 157                38 113.2      327
#> 158               319 112.6      319
#> 159               238 111.4      306
#> 160               171 102.0      122
#> 161                91  95.2       29
#> 162               275  94.1       23
#> 163               244 108.9      259
#> 164               289  97.2       53
#> 165                64 101.1      108
#> 166                34 105.9      202
#> 167               294 101.0      105
#> 168               300  94.8       28
#> 169               212 106.5      219
#> 170                32 109.7      274
#> 171                27 102.2      129
#> 172               204 104.3      163
#> 173               309 106.7      223
#> 174               113 112.4      317
#> 175                61 106.3      213
#> 176                 3  86.2        2
#> 177               129  94.4       24
#> 178               151 112.3      316
#> 179                 7 104.9      177
#> 180               232 110.4      288
#> 181                16 106.5      217
#> 182               166  98.8       75
#> 183               116 108.1      249
#> 184               233 108.2      251
#> 185               143  94.4       25
#> 186               314 105.9      203
#> 187                67 110.5      291
#> 188               169 104.9      176
#> 189               270 106.7      221
#> 190               283 115.3      344
#> 191               323 100.4      100
#> 192                22 109.7      273
#> 193                15  97.5       58
#> 194                79 107.9      246
#> 195               184 112.9      322
#> 196                84 109.1      263
#> 197                 2 104.8      173
#> 198               218  99.3       84
#> 199               114 104.0      158
#> 200                92 106.2      209
#> 201               335 109.6      269
#> 202               341 106.5      220
#> 203               164  98.8       74
#> 204                77 106.3      214
#> 205               285 109.8      278
#> 206               274  98.4       68
#> 207               304 103.7      153
#> 208               201 102.1      126
#> 209                35 106.4      215
#> 210               168 105.8      199
#> 211                62 105.5      192
#> 212               149 107.9      247
#> 213                85  95.4       31
#> 214               118  98.2       63
#> 215               317  98.2       64
#> 216               106 110.0      280
#> 217               101 104.7      171
#> 218               139 107.5      236
#> 219               349 114.5      337
#> 220                 6 105.6      195
#> 221               303  88.4        3
#> 222                28 112.9      324
#> 223                37  99.1       79
#> 224               161  92.2       16
#> 225                29 105.1      181
#> 226               209 100.8      104
#> 227               112  95.9       37
#> 228               327 108.4      254
#> 229               347  95.3       30
#> 230               174 110.4      290
#> 231               248 100.8      103
#> 232               188  90.4       10
#> 233               282 104.8      172
#> 234               173 106.0      205
#> 235                58 102.1      124
#> 236               291 100.5      102
#> 237               253  98.5       70
#> 238                21 105.4      189
#> 239               111 110.7      296
#> 240               106 104.3      162
#> 241               126 104.7      168
#> 242               205 105.8      200
#> 243               172  99.5       85
#> 244               193 104.0      157
#> 245               345 114.0      335
#> 246                44 104.9      179
#> 247               206 110.2      283
#> 248               221  91.8       14
#> 249               334 112.1      313
#> 250               306  97.2       50
#> 251               259  99.9       92
#> 252               247 104.8      175
#> 253               339 110.9      298
#> 254               144 104.1      159
#> 255               252  99.9       91
#> 256                56 109.6      270
#> 257               142  96.3       41
#> 258               288  99.9       95
#> 259                70 112.1      315
#> 260               328 105.4      187
#> 261               176 107.5      237
#> 262                 4 105.2      182
#> 263               186 102.2      128
#> 264               163 115.1      343
#> 265               222  98.8       76
#> 266               246 108.3      252
#> 267               219 116.8      348
#> 268               236  97.5       60
#> 269               340 107.7      242
#> 270               135 111.5      307
#> 271                66 105.5      191
#> 272               145  96.1       39
#> 273                89 106.2      210
#> 274               262 103.2      146
#> 275               263 105.6      193
#> 276               100 110.2      285
#> 277               243 104.8      174
#> 278                45 105.5      190
#> 279               326 107.2      231
#> 280                47  98.6       72
#> 281               210  97.4       54
#> 282                81 102.0      120
#> 283                65 107.5      238
#> 284                93 110.9      300
#> 285               109 111.4      305
#> 286               141 103.4      150
#> 287                20 114.9      342
#> 288                23  94.5       27
#> 289                40 106.0      204
#> 290               231  97.5       59
#> 291               121 101.4      114
#> 292               187 107.3      232
#> 293               241 103.2      147
#> 294               250 102.7      138
#> 295               124  99.3       82
#> 296               302 107.2      230
#> 297                 1  98.2       66
#> 298               330 117.0      349
#> 299               159  94.1       22
#> 300                33  97.0       48
#> 301               295  99.8       90
#> 302                96 102.7      135
#> 303                36 109.3      267
#> 304               110 101.1      107
#> 305               178 109.1      264
#> 306               127 110.9      299
#> 307               350 102.0      119
#> 308                48 101.1      109
#> 309                10  93.8       19
#> 310               120 113.4      330
#> 311               165  95.4       32
#> 312               162  96.8       46
#> 313               182 110.1      282
#> 314                49 106.5      216
#> 315                73 101.4      116
#> 316               235 106.2      211
#> 317               292 106.8      224
#> 318               276  99.6       86
#> 319               137  96.5       44
#> 320               258 107.7      243
#> 321               133 114.5      338
#> 322               268 113.3      329
#> 323               264 114.9      341
#> 324                54 103.1      145
#> 325               346 111.9      311
#> 326                11 102.5      134
#> 327                55  89.3        6
#> 328               242 105.3      186
#> 329               301  99.7       89
#> 330               154  96.5       43
#> 331               167 107.0      228
#> 332                19  89.5        7
#> 333               157  99.9       93
#> 334               321 118.6      351
#> 335               148  96.2       40
#> 336               134 113.1      326
#> 337               342 104.7      169
#> 338                97 100.0       96
#> 339               269 107.5      234
#> 340               273 103.0      144
#> 341                90 112.1      314
#> 342               123 105.3      184
#> 343               216 100.5      101
#> 344               353 104.1      160
#> 345                78 105.8      198
#> 346               245 116.1      347
#> 347               215 113.8      333
#> 348               234 109.3      266
#> 349               128 106.9      227
#> 350               136 110.0      279
#> 351               150 101.4      112
#> 352               325 114.8      340
#> 353               105 104.6      167
#> 354                65  95.6       60
#> 355               274  97.1       76
#> 356               197 109.4      311
#> 357                74 108.9      307
#> 358                32  98.5       96
#> 359               203  97.3       78
#> 360                71  94.4       43
#> 361               147  99.3      108
#> 362               333 101.0      141
#> 363                97  96.9       73
#> 364               310  90.6       10
#> 365                 2 111.6      324
#> 366                23 108.1      295
#> 367                87 106.0      257
#> 368               282  93.1       30
#> 369               149 101.2      145
#> 370               139 101.2      146
#> 371                 1 100.1      122
#> 372               188  97.1       75
#> 373               145 102.6      187
#> 374               170  90.3        7
#> 375               278 113.3      336
#> 376               236  92.0       19
#> 377               226 112.3      330
#> 378               281 111.6      325
#> 379               328 100.7      134
#> 380                57  94.1       38
#> 381               193 103.2      192
#> 382               351 110.3      316
#> 383               265  96.4       67
#> 384               313 102.1      172
#> 385               285 106.3      263
#> 386               155 101.9      163
#> 387               164 105.1      237
#> 388               135  99.3      110
#> 389               233 110.5      319
#> 390               117 115.0      343
#> 391                21 100.1      123
#> 392               307 106.7      270
#> 393                62 122.3      352
#> 394                69  98.9      103
#> 395               283  95.3       54
#> 396               134 103.8      205
#> 397               228 107.9      290
#> 398               320  96.8       72
#> 399                29  94.0       36
#> 400               225 102.9      190
#> 401               115 101.4      156
#> 402               185 104.6      222
#> 403               212 102.5      182
#> 404               120 108.3      300
#> 405               151 104.8      225
#> 406               248 112.4      331
#> 407                52  99.3      109
#> 408                17 105.5      243
#> 409               268  98.2       90
#> 410               118  90.5        9
#> 411                36 101.4      157
#> 412                98 105.1      236
#> 413               160 105.3      241
#> 414                55  96.1       66
#> 415               216 100.2      124
#> 416                14 106.7      271
#> 417                76 107.0      275
#> 418                25 110.3      318
#> 419               159 106.7      269
#> 420               258 105.3      238
#> 421               182  91.4       14
#> 422               261 102.7      188
#> 423                18 101.2      148
#> 424                40  91.9       17
#> 425               215 106.4      265
#> 426               337 106.8      272
#> 427               296 110.0      313
#> 428                99 107.1      278
#> 429                 3  91.1       12
#> 430               314  98.0       82
#> 431               113 105.5      244
#> 432                45 103.6      199
#> 433               141 104.4      217
#> 434               266  91.5       15
#> 435               208 102.5      184
#> 436                35  93.4       32
#> 437               102  88.1        4
#> 438               109 102.0      166
#> 439               234  92.0       18
#> 440               179 104.9      229
#> 441                41 101.3      154
#> 442               232  96.4       69
#> 443               239 101.3      155
#> 444                91  99.5      114
#> 445                43  99.8      118
#> 446               309 103.7      200
#> 447                85 100.5      132
#> 448               246 114.0      340
#> 449               186  91.2       13
#> 450               257 108.1      296
#> 451               330 104.8      226
#> 452               116  95.7       61
#> 453               180 119.7      350
#> 454               259  98.6       97
#> 455                60 105.3      239
#> 456                96  94.4       45
#> 457               299 100.2      125
#> 458               161  99.4      113
#> 459               211 101.1      144
#> 460               306  98.1       85
#> 461               132  98.6      100
#> 462               176 102.1      169
#> 463                19 101.1      142
#> 464               322 105.1      234
#> 465               242 108.0      293
#> 466               240 104.3      216
#> 467                58 102.9      189
#> 468               202  95.1       52
#> 469               199 104.0      210
#> 470               125 105.3      242
#> 471               267 103.3      195
#> 472                31 111.3      322
#> 473               128 106.1      259
#> 474               129  97.3       80
#> 475               249  94.4       44
#> 476               189  94.2       42
#> 477               343 102.2      174
#> 478               329 103.4      197
#> 479                79 107.5      284
#> 480               119 102.1      170
#> 481                 5 111.1      321
#> 482               263 112.1      327
#> 483               323 103.8      203
#> 484               106  99.1      107
#> 485               288  85.5        2
#> 486               103  98.6       99
#> 487                95 102.5      181
#> 488               244 107.7      286
#> 489               114 108.5      302
#> 490               252 108.4      301
#> 491               255  98.0       84
#> 492                26 104.0      212
#> 493               196  96.0       65
#> 494                 7  93.0       28
#> 495                38 104.5      220
#> 496               327 100.8      138
#> 497               209  99.5      115
#> 498                13 108.8      306
#> 499               143 102.1      167
#> 500               287 104.1      214
#> 501               304 108.8      305
#> 502                24  94.2       41
#> 503               279 108.0      292
#> 504               220 115.6      344
#> 505               238  92.3       21
#> 506               175 103.7      201
#> 507               131 113.6      337
#> 508               222  97.6       81
#> 509               340 112.6      332
#> 510               171 100.4      129
#> 511               133  99.8      119
#> 512               245 107.0      276
#> 513               121 105.5      246
#> 514               190 100.4      130
#> 515               111 100.8      135
#> 516                73 105.6      248
#> 517                51  94.0       37
#> 518                81  92.7       25
#> 519               298  99.4      111
#> 520                 9  98.2       88
#> 521                56 101.5      158
#> 522                 6  92.6       24
#> 523               270 101.8      162
#> 524               325 103.1      191
#> 525                61  95.5       57
#> 526               178 102.5      180
#> 527                22  98.8      101
#> 528               218 104.9      231
#> 529               293 122.9      353
#> 530                67 104.5      221
#> 531               229 106.1      260
#> 532               206 103.3      196
#> 533               349 108.3      299
#> 534               224 107.1      277
#> 535               157  92.8       27
#> 536               166 105.7      251
#> 537               336 106.2      261
#> 538                66 108.2      298
#> 539               305  90.8       11
#> 540               183 102.1      168
#> 541               348 103.9      209
#> 542                 4 101.0      140
#> 543               141  89.1        5
#> 544               350  99.6      116
#> 545               272  96.4       68
#> 546                30 102.5      185
#> 547               302  94.6       48
#> 548               110  99.0      105
#> 549               292 107.4      281
#> 550               108  90.4        8
#> 551               290 102.4      179
#> 552                77 104.8      227
#> 553                63 114.8      342
#> 554               231 103.9      208
#> 555               319 102.4      178
#> 556                16 100.8      137
#> 557               210  92.7       26
#> 558                47  92.4       23
#> 559               334 114.4      341
#> 560               201  93.1       31
#> 561               277 110.3      317
#> 562               138 102.0      165
#> 563               227 116.7      345
#> 564               318 112.2      328
#> 565                20 107.7      287
#> 566               205 116.9      346
#> 567               130 106.0      256
#> 568                11  95.6       59
#> 569               165 109.3      310
#> 570               254 109.1      309
#> 571               324 103.8      202
#> 572               150  98.6       98
#> 573               198  94.7       49
#> 574               301 111.6      323
#> 575               172  98.8      102
#> 576               230 111.7      326
#> 577               303  94.6       47
#> 578                37 104.5      218
#> 579               191  99.4      112
#> 580               344  93.6       34
#> 581               127 102.6      186
#> 582               311 106.8      274
#> 583               174 113.0      334
#> 584               308  95.2       53
#> 585                15 105.8      253
#> 586               331 102.1      171
#> 587               235 110.8      320
#> 588                54 117.3      348
#> 589                89  97.0       74
#> 590               153 106.2      262
#> 591               237  95.5       58
#> 592               321 100.6      133
#> 593               122 103.8      206
#> 594                10 107.4      280
#> 595                92  94.7       51
#> 596               291 103.8      204
#> 597                46  97.3       79
#> 598               154  99.0      104
#> 599               168 101.3      151
#> 600               144 109.1      308
#> 601               262  93.1       29
#> 602               300 100.9      139
#> 603               221 101.3      152
#> 604                83  98.1       86
#> 605               347  95.9       64
#> 606               123  98.3       93
#> 607               243 102.5      183
#> 608                90 101.3      149
#> 609                82 105.8      254
#> 610               297 102.1      173
#> 611               253 106.6      268
#> 612               345 113.6      338
#> 613               112 104.9      232
#> 614                50  99.1      106
#> 615               152 101.2      147
#> 616                 8  98.2       87
#> 617               181  94.2       39
#> 618               207 105.5      245
#> 619               335  94.5       46
#> 620               332  93.5       33
#> 621                75 102.3      175
#> 622               273 101.6      159
#> 623                44 100.2      126
#> 624               200 104.5      219
#> 625               223 106.4      264
#> 626               256 104.9      228
#> 627               104 104.9      230
#> 628                27 104.8      224
#> 629               264  94.2       40
#> 630                86  95.8       62
#> 631               146 107.5      283
#> 632               312 101.3      150
#> 633                70 105.5      247
#> 634                64 108.6      303
#> 635               137  92.2       20
#> 636               158 107.6      285
#> 637               289  95.5       56
#> 638               326  99.9      121
#> 639               194  92.4       22
#> 640                49  91.8       16
#> 641               276 101.9      164
#> 642               251  94.7       50
#> 643               271 110.0      314
#> 644                53 101.6      160
#> 645               280 117.2      347
#> 646               260  95.9       63
#> 647                33  98.0       83
#> 648               295  90.2        6
#> 649               167 100.3      128
#> 650               163 103.3      194
#> 651                28  99.8      117
#> 652               213 103.2      193
#> 653                72  99.8      120
#> 654               136  95.5       55
#> 655               294 113.9      339
#> 656               101 108.6      304
#> 657                88 105.8      255
#> 658               269 120.8      351
#> 659               286  98.4       94
#> 660               162 101.1      143
#> 661               192 101.3      153
#> 662                93  98.4       95
#> 663                39  93.7       35
#> 664               315  85.1        1
#> 665                80 103.4      198
#> 666               173 100.5      131
#> 667                12 104.2      215
#> 668               126 105.7      249
#> 669               219 100.2      127
#> 670                42 107.9      291
#> 671               339 105.7      252
#> 672                94 100.8      136
#> 673               204 105.1      235
#> 674               124 109.6      312
#> 675               352 103.8      207
#> 676               140  98.2       89
#> 677               250 106.5      267
#> 678                59 110.2      315
#> 679               187  96.7       71
#> 680               342 104.0      211
#> 681                78 107.8      289
#> 682               214 102.4      177
#> 683               241  98.3       91
#> 684               353  97.2       77
#> 685                84 117.6      349
#> 686               316 105.0      233
#> 687               284 106.0      258
#> 688               338  98.3       92
#> 689                48 106.5      266
#> 690                68 112.8      333
#> 691               177  87.1        3
#> 692               148 101.6      161
#> 693               195 105.7      250
#> 694               107 107.3      279
#> 695               341 106.8      273
#> 696               275 105.3      240
#> 697               100 108.2      297
#> 698               105 113.2      335
#> 699               317 104.0      213
#> 700               247 107.5      282
#> 701               169 108.1      294
#> 702               346  96.6       70
#> 703               156 104.6      223
#> 704                34 102.3      176
#> 705               217 107.8      288
#> 706               184 112.2      329
#> 707                78  91.1       22
#> 708               263 104.6      222
#> 709               132 101.0      148
#> 710               248 111.2      329
#> 711                27 110.6      321
#> 712               286 100.8      141
#> 713               314 108.8      299
#> 714               233 106.6      267
#> 715               119 101.2      153
#> 716               254  96.7       75
#> 717               267 108.6      297
#> 718                57 112.7      342
#> 719                28  87.9        4
#> 720                60 109.6      313
#> 721                 7 106.2      262
#> 722               228 104.7      223
#> 723                81 110.3      318
#> 724               231  95.4       55
#> 725                 6 109.9      315
#> 726                20 104.4      219
#> 727               256  92.8       33
#> 728                 1 105.1      231
#> 729               224 113.1      345
#> 730               176  93.3       36
#> 731               346 105.9      256
#> 732                61 107.0      276
#> 733               190 107.6      281
#> 734               344 108.3      293
#> 735               269 102.6      182
#> 736                38  88.9        7
#> 737               275 102.8      188
#> 738               339 103.6      199
#> 739                98  91.2       23
#> 740               196  98.6      109
#> 741               189  94.5       46
#> 742               107  95.0       48
#> 743               149  95.7       59
#> 744               166 114.5      353
#> 745                95  95.6       58
#> 746                47 105.8      248
#> 747               324 106.7      269
#> 748                42  96.6       73
#> 749                64 108.0      289
#> 750               338  91.1       21
#> 751                67  89.9       11
#> 752               123 103.7      203
#> 753                91  92.5       30
#> 754                69 101.2      154
#> 755               215 102.8      186
#> 756               208 103.5      195
#> 757               105 102.7      185
#> 758               175 110.6      323
#> 759                62  90.6       15
#> 760               265  95.0       49
#> 761               201  96.3       70
#> 762                85  91.6       26
#> 763               113  98.2      101
#> 764               251  86.4        1
#> 765               271 105.1      229
#> 766               299 105.3      234
#> 767                10 114.2      352
#> 768               243  92.8       32
#> 769               285 105.6      246
#> 770                11 112.0      335
#> 771               103 106.2      261
#> 772               102  88.1        6
#> 773               211 113.8      351
#> 774               220  97.1       82
#> 775               120 101.3      156
#> 776               129 100.3      133
#> 777               204 104.7      224
#> 778               101  97.4       87
#> 779               183 106.8      270
#> 780               112 101.5      160
#> 781                16 107.8      283
#> 782               272 101.8      164
#> 783                 9 103.9      208
#> 784                18 109.0      301
#> 785               270 100.9      145
#> 786                49  92.8       31
#> 787               131  94.1       41
#> 788                12 104.2      214
#> 789                44 109.8      314
#> 790               304 102.0      171
#> 791               114  97.0       78
#> 792               221  97.9       95
#> 793               325  99.9      125
#> 794               139 103.1      192
#> 795               232  95.3       53
#> 796               116 102.3      178
#> 797                59  87.0        2
#> 798               210  90.9       18
#> 799                23  98.6      108
#> 800               279  96.0       66
#> 801               307  94.1       42
#> 802                56 106.1      260
#> 803               268 113.7      350
#> 804               326  96.6       72
#> 805               118 105.5      242
#> 806                32  97.0       79
#> 807                79  87.8        3
#> 808               158  96.5       71
#> 809               292  97.4       88
#> 810                90 100.2      129
#> 811               227  95.7       60
#> 812               347 108.4      294
#> 813               146 101.9      169
#> 814               235  96.8       76
#> 815               328 112.7      344
#> 816                71  98.5      104
#> 817               330  96.9       77
#> 818               171 100.6      136
#> 819               336  99.2      117
#> 820                94  96.0       64
#> 821               185  89.6        9
#> 822               104  96.2       68
#> 823               213 101.1      151
#> 824               157  98.1       99
#> 825               194 112.6      341
#> 826               237  93.7       39
#> 827               209  96.0       65
#> 828               141 102.3      179
#> 829               327  99.8      124
#> 830               144 102.0      170
#> 831                75 104.3      215
#> 832                82 110.9      327
#> 833               177 101.0      146
#> 834               138 106.1      259
#> 835               312  93.4       37
#> 836               340 112.2      337
#> 837               306 104.5      220
#> 838               331 105.4      237
#> 839               249  98.0       97
#> 840               320 104.4      217
#> 841               296  90.9       19
#> 842               284 104.8      226
#> 843               160  98.9      112
#> 844               266 102.2      177
#> 845                22 101.8      163
#> 846                92 105.5      243
#> 847               319  91.0       20
#> 848                21  96.2       69
#> 849               341 100.2      130
#> 850               297  95.3       54
#> 851               203  98.8      110
#> 852               199 101.9      167
#> 853                41  91.3       24
#> 854               219  95.1       51
#> 855               154 113.6      349
#> 856               153 100.9      143
#> 857               323 107.7      282
#> 858               298 100.8      139
#> 859                13 109.5      309
#> 860                 5  97.7       92
#> 861               287 102.3      180
#> 862                 4  98.0       96
#> 863               145 105.4      239
#> 864                40  96.1       67
#> 865                34 108.1      290
#> 866               159 109.5      312
#> 867               277  99.5      122
#> 868               205  97.2       84
#> 869               202  97.3       85
#> 870               218  95.2       52
#> 871                88 101.9      166
#> 872               281 101.4      158
#> 873               274 111.8      334
#> 874               147  99.0      114
#> 875                30 108.1      291
#> 876               161 104.2      211
#> 877               188 105.6      245
#> 878                86  93.1       35
#> 879               182  90.2       12
#> 880               135 107.0      275
#> 881                52  92.5       29
#> 882               259 110.4      320
#> 883               239  99.5      121
#> 884                37 101.1      150
#> 885               186 105.4      240
#> 886                65 101.5      159
#> 887               136  98.5      106
#> 888               195 106.3      264
#> 889               212 111.4      331
#> 890               337 104.2      210
#> 891               335  92.9       34
#> 892                87 108.8      300
#> 893               316 109.2      306
#> 894               168 109.0      302
#> 895                77 110.6      324
#> 896               255 106.9      272
#> 897                48 100.4      134
#> 898               193 110.6      322
#> 899               262  89.5        8
#> 900               315 113.3      346
#> 901               187  89.6       10
#> 902               333  94.1       40
#> 903               229 105.2      233
#> 904               178  90.7       17
#> 905                72 113.4      347
#> 906               310 100.9      142
#> 907               206  88.1        5
#> 908               122 109.5      311
#> 909               200 105.9      252
#> 910               128 112.5      340
#> 911               276 110.9      326
#> 912               127 103.6      200
#> 913               321 105.2      232
#> 914                35 108.0      288
#> 915               207 108.4      295
#> 916                50 113.5      348
#> 917                99  90.2       14
#> 918               293 105.7      247
#> 919               191  99.3      120
#> 920                36  99.0      115
#> 921               137 120.7      357
#> 922               257  93.4       38
#> 923               250 106.9      271
#> 924               115 109.1      305
#> 925                15 100.2      131
#> 926                 2 104.5      221
#> 927                19 109.1      304
#> 928               226 103.8      206
#> 929               150  98.4      102
#> 930               230 103.7      201
#> 931               109  98.4      103
#> 932               169 102.2      176
#> 933                14 100.0      128
#> 934                51 103.9      207
#> 935               170  97.9       94
#> 936                39  95.5       57
#> 937               303 101.0      147
#> 938               172 108.7      298
#> 939               301 111.2      328
#> 940               245 112.0      336
#> 941               143 107.8      285
#> 942               180  94.2       43
#> 943                83 100.8      140
#> 944               151  99.2      118
#> 945               181  97.4       86
#> 946                31 104.3      216
#> 947               174  95.8       61
#> 948               291 100.0      127
#> 949               164  97.1       83
#> 950               283 101.6      161
#> 951               309 103.0      190
#> 952                73 102.2      174
#> 953               264 111.3      330
#> 954               261  92.2       28
#> 955               311 100.7      138
#> 956               217 109.9      316
#> 957                80  95.9       63
#> 958                66  94.2       45
#> 959                74 100.4      135
#> 960               163 103.6      198
#> 961                70  96.6       74
#> 962               124 102.7      184
#> 963                93 102.3      181
#> 964                96 109.3      307
#> 965               133 112.4      339
#> 966               130 103.7      204
#> 967               252  97.1       81
#> 968               214  91.7       27
#> 969               258 106.5      265
#> 970                76 109.4      308
#> 971               121 103.5      197
#> 972               117 105.8      249
#> 973               179 103.1      191
#> 974                29 110.3      319
#> 975                58 102.1      173
#> 976               242 101.9      168
#> 977                84 109.0      303
#> 978               238 112.3      338
#> 979                43 105.9      253
#> 980                55 107.8      284
#> 981               240 105.9      251
#> 982               278  94.8       47
#> 983               332 101.1      149
#> 984               329 101.7      162
#> 985                33 103.1      193
#> 986               156 105.1      230
#> 987               247 105.5      241
#> 988               134 100.9      144
#> 989               302 107.5      280
#> 990               253 105.3      235
#> 991               110 105.9      254
#> 992               184  97.5       89
#> 993               111  90.6       16
#> 994               198 107.4      279
#> 995               100  97.5       90
#> 996               225 115.4      355
#> 997               108  95.0       50
#> 998               165 108.3      292
#> 999               313 101.3      155
#> 1000              246 104.2      213
#> 1001              222 108.0      287
#> 1002              216 109.5      310
#> 1003              273 104.8      225
#> 1004              280  94.2       44
#> 1005               53 114.7      354
#> 1006              173 108.0      286
#> 1007              162 101.8      165
#> 1008              317 108.5      296
#> 1009              125 106.2      263
#> 1010              167  98.9      113
#> 1011               63 101.2      152
#> 1012               24 100.7      137
#> 1013              197 106.7      268
#> 1014              148 106.1      258
#> 1015              288 102.6      183
#> 1016                8 102.2      175
#> 1017              234 110.2      317
#> 1018              142  91.4       25
#> 1019              305  97.5       91
#> 1020              282  98.1      100
#> 1021              343  98.9      111
#> 1022              106  98.5      105
#> 1023              300  95.8       62
#> 1024              236  97.0       80
#> 1025              318  97.8       93
#> 1026              322  98.6      107
#> 1027              126  99.5      123
#> 1028              294  98.1       98
#> 1029              140 107.0      274
#> 1030               17 107.0      273
#> 1031              289  99.1      116
#> 1032               68 105.4      238
#> 1033                3  90.2       13
#> 1034              308  99.9      126
#> 1035               45 100.3      132
#> 1036              260 101.3      157
#> 1037              244 110.8      325
#> 1038              334 107.3      277
#> 1039              290 111.4      332
#> 1040              192 104.4      218
#> 1041              152 104.9      227
#> 1042               53 105.8      250
#> 1043               97 103.7      205
#> 1044               89 107.3      278
#> 1045               25  95.4       56
#> 1046              342 106.0      257
#> 1047              241 105.0      228
#> 1048              223 104.2      212
#> 1049              345  99.3      119
#> 1050              295 103.5      196
#> 1051               26 102.8      187
#> 1052               46 103.7      202
#> 1053              155 118.1      356
#> 1054              348 112.7      343
#> 1055              348 102.9      189
#> 1056              348 105.9      255
#> 1057              348 106.5      266
#> 1058              348 105.5      244
#> 1059              348 103.2      194
#> 1060              348 111.5      333
#> 1061              348 105.3      236
#> 1062              348 103.9      209
#> 1063              348 102.1      172
# }
```
