# **Get Four Factors Data**

**Get Four Factors Data**

## Usage

``` r
kp_fourfactors(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of four factors ratings

|                 |           |                                             |
|-----------------|-----------|---------------------------------------------|
| col_name        | types     | description                                 |
| team            | character | Team-side label or team identifier.         |
| conf            | character | character.                                  |
| adj_t           | numeric   | Adj t.                                      |
| adj_t_rk        | numeric   | Adj t rk.                                   |
| adj_o           | numeric   | Adj o.                                      |
| adj_o_rk        | numeric   | Adj o rk.                                   |
| off_e_fg_pct    | numeric   | Off e field goals percentage (0-1 decimal). |
| off_e_fg_pct_rk | numeric   | Off e fg pct rk.                            |
| off_to_pct      | numeric   | Off to percentage (0-1 decimal).            |
| off_to_pct_rk   | numeric   | Off to pct rk.                              |
| off_or_pct      | numeric   | Off or percentage (0-1 decimal).            |
| off_or_pct_rk   | numeric   | Off or pct rk.                              |
| off_ft_rate     | numeric   | Off ft rate.                                |
| off_ft_rate_rk  | numeric   | Off ft rate rk.                             |
| adj_d           | numeric   | Adj d.                                      |
| adj_d_rk        | numeric   | Adj d rk.                                   |
| def_e_fg_pct    | numeric   | Def e field goals percentage (0-1 decimal). |
| def_e_fg_pct_rk | numeric   | Def e fg pct rk.                            |
| def_to_pct      | numeric   | Def to percentage (0-1 decimal).            |
| def_to_pct_rk   | numeric   | Def to pct rk.                              |
| def_or_pct      | numeric   | Def or percentage (0-1 decimal).            |
| def_or_pct_rk   | numeric   | Def or pct rk.                              |
| def_ft_rate     | numeric   | Def ft rate.                                |
| def_ft_rate_rk  | numeric   | Def ft rate rk.                             |
| ncaa_seed       | numeric   | Ncaa seed.                                  |
| year            | numeric   | 4-digit year.                               |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_fourfactors(min_year = 2020, max_year = 2021))
#>                       team conf adj_t adj_t_rk adj_o adj_o_rk off_e_fg_pct
#> 1                  Gonzaga  WCC  73.8        7 126.4        1         61.0
#> 2                   Baylor  B12  67.4      213 125.0        2         56.5
#> 3                     Iowa  B10  69.9       93 123.5        3         54.7
#> 4                 Ohio St.  B10  66.7      251 120.7        4         52.9
#> 5                      LSU  SEC  70.6       70 120.1        5         52.3
#> 6                Villanova   BE  64.2      336 119.0        6         53.2
#> 7                  Houston Amer  64.4      332 118.3        7         50.4
#> 8                 Illinois  B10  70.5       79 118.0        8         55.6
#> 9                 Michigan  B10  66.6      256 117.6        9         54.7
#> 10                  Oregon  P12  67.2      226 117.2       10         54.2
#> 11                    UCLA  P12  63.8      341 116.9       11         52.0
#> 12           West Virginia  B12  69.2      122 116.8       12         48.9
#> 13                Colorado  P12  66.1      276 116.3       13         52.4
#> 14                     USC  P12  67.0      235 115.7       14         52.7
#> 15                 Arizona  P12  67.7      198 115.6       15         50.5
#> 16             Florida St.  ACC  69.9       90 114.9       16         54.0
#> 17                Virginia  ACC  59.9      357 114.7       17         55.4
#> 18                    Duke  ACC  68.5      152 114.5       18         53.6
#> 19                  Toledo  MAC  68.7      143 114.3       19         54.0
#> 20                Davidson  A10  62.5      353 113.9       20         55.3
#> 21              Notre Dame  ACC  67.2      227 113.8       21         53.9
#> 22            Georgia Tech  ACC  67.3      223 113.7       22         54.1
#> 23                     BYU  WCC  67.6      206 113.7       23         54.9
#> 24                Syracuse  ACC  68.6      151 113.7       24         51.2
#> 25               Creighton   BE  68.7      144 113.4       25         55.0
#> 26                  Purdue  B10  66.1      278 113.3       26         51.0
#> 27             Connecticut   BE  65.5      309 113.1       27         49.0
#> 28                   Texas  B12  68.6      146 113.1       28         52.9
#> 29               Wisconsin  B10  64.6      328 113.0       29         49.9
#> 30                 Alabama  SEC  73.3       11 112.9       30         51.7
#> 31                    Utah  P12  67.6      203 112.7       31         53.1
#> 32              Texas Tech  B12  65.1      316 112.7       32         49.4
#> 33                   Drake  MVC  66.3      271 112.5       33         53.4
#> 34                Penn St.  B10  69.1      125 112.2       34         47.9
#> 35                Oklahoma  B12  67.1      228 112.1       35         50.8
#> 36              Oregon St.  P12  65.5      306 112.1       36         49.0
#> 37                Maryland  B10  64.7      321 111.8       37         53.2
#> 38                  Auburn  SEC  71.0       54 111.6       38         51.2
#> 39        South Dakota St.  Sum  70.9       59 111.5       39         56.5
#> 40                    Ohio  MAC  69.2      123 111.4       40         54.7
#> 41          Loyola Chicago  MVC  63.7      342 111.3       41         55.7
#> 42              St. John's   BE  73.4       10 111.2       42         50.4
#> 43                Arkansas  SEC  72.6       19 111.1       43         50.7
#> 44                 Florida  SEC  68.3      167 111.0       44         53.1
#> 45           San Diego St.  MWC  65.5      307 111.0       45         52.4
#> 46                Richmond  A10  68.2      169 110.9       46         53.1
#> 47                     SMU Amer  68.8      141 110.8       47         52.2
#> 48                  Xavier   BE  67.9      186 110.6       48         52.1
#> 49                Missouri  SEC  68.4      163 110.6       49         50.8
#> 50             Saint Louis  A10  68.0      184 110.4       50         51.6
#> 51              Seton Hall   BE  66.5      264 110.3       51         50.0
#> 52          North Carolina  ACC  71.5       43 110.3       52         48.3
#> 53                 Colgate  Pat  72.2       26 110.3       53         56.6
#> 54                  Kansas  B12  68.2      174 110.1       54         49.4
#> 55         St. Bonaventure  A10  64.8      320 110.0       55         49.8
#> 56        UC Santa Barbara   BW  65.6      301 109.9       56         52.6
#> 57                  Furman   SC  67.7      200 109.8       57         56.7
#> 58                 Liberty ASun  63.1      347 109.8       58         56.9
#> 59           Virginia Tech  ACC  65.7      298 109.7       59         52.3
#> 60            Oklahoma St.  B12  72.4       24 109.6       60         51.2
#> 61             Wichita St. Amer  67.0      234 109.5       61         47.1
#> 62      Eastern Washington BSky  72.2       27 109.5       62         54.2
#> 63              N.C. State  ACC  67.8      193 109.4       63         53.0
#> 64                 Belmont  OVC  70.7       64 109.4       64         56.3
#> 65                 Detroit Horz  67.1      230 109.3       65         55.1
#> 66            Oral Roberts  Sum  71.4       46 109.3       66         53.0
#> 67                Marshall CUSA  72.6       20 109.2       67         54.8
#> 68                 Wyoming  MWC  69.0      129 109.1       68         53.7
#> 69               Boise St.  MWC  69.1      128 109.1       69         52.3
#> 70                 Indiana  B10  65.9      289 109.1       70         48.5
#> 71              Vanderbilt  SEC  68.6      147 108.9       71         51.2
#> 72                  Nevada  MWC  69.8       95 108.8       72         51.3
#> 73                   Akron  MAC  68.5      153 108.6       73         51.5
#> 74           Southern Utah BSky  69.9       92 108.5       74         52.4
#> 75             Arizona St.  P12  72.5       21 108.4       75         49.2
#> 76               Minnesota  B10  69.9       88 108.4       76         45.0
#> 77                  Dayton  A10  65.5      305 108.3       77         55.5
#> 78              Bellarmine ASun  65.1      315 108.3       78         55.3
#> 79              Pepperdine  WCC  71.4       47 108.3       79         51.2
#> 80              Wright St. Horz  71.1       52 108.3       80         54.4
#> 81              Pittsburgh  ACC  68.3      165 108.2       81         48.8
#> 82                 Rutgers  B10  67.4      214 108.1       82         50.1
#> 83            Colorado St.  MWC  69.0      133 108.1       83         54.1
#> 84                Kentucky  SEC  68.1      181 108.0       84         47.1
#> 85               Tennessee  SEC  67.1      232 108.0       85         49.6
#> 86                 Georgia  SEC  73.2       13 107.9       86         50.7
#> 87              Georgetown   BE  69.7      101 107.9       87         49.4
#> 88                     VMI   SC  69.9       89 107.8       88         53.8
#> 89        Loyola Marymount  WCC  66.0      284 107.8       89         51.7
#> 90            Missouri St.  MVC  69.1      127 107.8       90         54.2
#> 91               Weber St. BSky  71.9       33 107.7       91         56.4
#> 92              Louisville  ACC  65.7      300 107.7       92         47.8
#> 93         Mississippi St.  SEC  65.8      296 107.7       93         50.2
#> 94               Marquette   BE  67.4      216 107.5       94         50.6
#> 95                 Buffalo  MAC  73.1       16 107.4       95         51.2
#> 96              Providence   BE  66.3      270 107.3       96         48.3
#> 97            South Dakota  Sum  68.9      136 107.3       97         53.2
#> 98            Michigan St.  B10  68.3      164 107.1       98         48.1
#> 99                    Yale  Ivy  67.9      185 107.1       99          0.0
#> 100          San Francisco  WCC  67.7      197 106.9      100         51.2
#> 101            North Texas CUSA  62.7      350 106.7      101         53.8
#> 102       Western Kentucky CUSA  67.4      219 106.6      102         50.5
#> 103                    UCF Amer  67.2      225 106.5      103         50.1
#> 104                 Drexel  CAA  63.9      340 106.5      104         53.3
#> 105                   UTSA CUSA  71.8       37 106.5      105         49.4
#> 106                Wofford   SC  65.9      291 106.4      106         54.9
#> 107                Clemson  ACC  64.0      337 106.4      107         50.0
#> 108                 Mercer   SC  67.7      196 106.2      108         54.3
#> 109            Mississippi  SEC  64.9      318 106.1      109         48.7
#> 110               Stanford  P12  69.2      120 106.0      110         51.4
#> 111               Miami OH  MAC  65.8      293 106.0      111         50.5
#> 112                Hofstra  CAA  68.1      179 105.9      112         50.8
#> 113               Kent St.  MAC  69.8       98 105.8      113         50.9
#> 114             Evansville  MVC  62.0      355 105.8      114         53.2
#> 115            Georgia St.   SB  70.5       78 105.7      115         51.3
#> 116          Bowling Green  MAC  69.8       96 105.5      116         47.6
#> 117                Memphis Amer  71.3       48 105.5      117         50.9
#> 118                Vermont   AE  66.4      267 105.5      118         53.3
#> 119             California  P12  64.7      322 105.5      119         49.4
#> 120          Massachusetts  A10  71.6       41 105.4      120         50.0
#> 121           Grand Canyon  WAC  64.9      319 105.4      121         52.5
#> 122                    VCU  A10  69.6      107 105.2      122         50.9
#> 123         Boston College  ACC  70.9       58 105.1      123         49.8
#> 124               Winthrop BSth  73.1       14 105.0      124         52.6
#> 125       Jacksonville St.  OVC  65.8      292 104.9      125         52.4
#> 126               Utah St.  MWC  68.6      149 104.8      126         49.8
#> 127           Rhode Island  A10  69.0      134 104.7      127         49.2
#> 128                    TCU  B12  66.6      258 104.7      128         49.9
#> 129    Cal St. Bakersfield   BW  63.6      344 104.6      129         48.4
#> 130           Gardner Webb BSth  66.7      252 104.5      130         52.4
#> 131            Cal Baptist  WAC  70.5       76 104.3      131         53.9
#> 132           Northwestern  B10  68.4      160 104.3      132         50.3
#> 133         Louisiana Tech CUSA  69.4      112 104.2      133         50.5
#> 134         New Mexico St.  WAC  64.6      325 104.1      134         49.4
#> 135             Washington  P12  71.0       53 104.0      135         48.9
#> 136            The Citadel   SC  74.2        4 104.0      136         51.8
#> 137            Austin Peay  OVC  66.8      249 104.0      137         50.4
#> 138              Princeton  Ivy  66.6      257 104.0      138          0.0
#> 139         South Carolina  SEC  74.6        3 103.9      139         46.7
#> 140                Oakland Horz  69.6      104 103.9      140         48.7
#> 141                   Rice CUSA  69.3      114 103.9      141         52.6
#> 142      Northern Kentucky Horz  64.7      323 103.8      142         50.6
#> 143                   UNLV  MWC  66.1      281 103.7      143         50.6
#> 144       North Dakota St.  Sum  64.6      327 103.7      144         50.4
#> 145                   Navy  Pat  65.9      286 103.7      145         50.0
#> 146         UNC Greensboro   SC  68.0      183 103.6      146         47.9
#> 147           UC Riverside   BW  66.7      254 103.6      147         52.5
#> 148             Cincinnati Amer  70.7       66 103.6      148         48.4
#> 149                Bradley  MVC  65.9      288 103.5      149         49.9
#> 150                Pacific  WCC  67.0      237 103.5      150         47.8
#> 151          James Madison  CAA  71.8       36 103.5      151         50.5
#> 152      Stephen F. Austin Slnd  69.7      102 103.5      152         55.0
#> 153                    UAB CUSA  67.0      238 103.5      153         48.6
#> 154               Ball St.  MAC  70.7       67 103.4      154         51.3
#> 155          Northern Iowa  MVC  68.8      139 103.3      155         50.0
#> 156                   UTEP CUSA  67.8      191 103.3      156         47.5
#> 157          South Alabama   SB  66.5      261 103.3      157         50.8
#> 158             Murray St.  OVC  66.2      275 103.3      158         54.7
#> 159     East Tennessee St.   SC  65.4      311 103.2      159         50.3
#> 160                 Bryant  NEC  74.0        6 103.2      160         53.3
#> 161            Chattanooga   SC  66.4      269 103.0      161         50.4
#> 162               Campbell BSth  63.9      338 102.9      162         55.7
#> 163              Lafayette  Pat  68.6      145 102.9      163         50.6
#> 164                 Butler   BE  64.6      326 102.7      164         47.5
#> 165                  Tulsa Amer  65.6      303 102.6      165         49.0
#> 166            Indiana St.  MVC  66.9      244 102.6      166         48.9
#> 167         Washington St.  P12  67.6      207 102.4      167         47.9
#> 168         Sacramento St. BSky  65.3      313 102.4      168         50.6
#> 169              Green Bay Horz  65.9      285 102.3      169         49.2
#> 170             Charleston  CAA  63.5      345 102.2      170         51.6
#> 171         Youngstown St. Horz  67.6      202 102.2      171         48.7
#> 172               Miami FL  ACC  67.8      190 102.1      172         47.4
#> 173         UNC Wilmington  CAA  69.0      130 102.1      173         48.6
#> 174       Florida Atlantic CUSA  68.1      177 101.9      174         51.4
#> 175              Texas A&M  SEC  64.3      334 101.9      175         47.6
#> 176          North Florida ASun  66.5      260 101.9      176         52.7
#> 177                Harvard  Ivy  68.1      180 101.9      177          0.0
#> 178           Saint Mary's  WCC  62.9      348 101.8      178         47.8
#> 179               Nebraska  B10  71.8       35 101.8      179         48.2
#> 180              Milwaukee Horz  69.8       97 101.8      180         49.5
#> 181               La Salle  A10  68.5      155 101.8      181         50.1
#> 182           UC San Diego   BW  69.7       99 101.7      182         55.0
#> 183               Duquesne  A10  69.0      135 101.7      183         47.6
#> 184      Abilene Christian Slnd  69.3      115 101.7      184         51.2
#> 185                 Hawaii   BW  66.9      245 101.7      185         50.6
#> 186     Cal St. Northridge   BW  70.1       86 101.7      186         48.4
#> 187      George Washington  A10  67.8      188 101.6      187         49.8
#> 188      Cal St. Fullerton   BW  71.8       39 101.6      188         51.2
#> 189                 Temple Amer  68.6      148 101.5      189         46.7
#> 190                Cornell  Ivy  66.8      246 101.3      190          0.0
#> 191            Wake Forest  ACC  67.0      241 101.3      191         49.0
#> 192              UC Irvine   BW  67.4      222 101.3      192         47.3
#> 193        Sam Houston St. Slnd  70.9       57 101.3      193         50.4
#> 194         Saint Joseph's  A10  72.1       30 101.2      194         48.6
#> 195           George Mason  A10  68.1      176 101.1      195         48.7
#> 196           Old Dominion CUSA  67.4      217 101.0      196         48.6
#> 197       Eastern Kentucky  OVC  74.8        2 101.0      197         51.2
#> 198               Lipscomb ASun  66.0      282 100.9      198         51.2
#> 199         St. Francis NY  NEC  72.5       22 100.9      199         49.5
#> 200          South Florida Amer  66.8      247 100.8      200         45.1
#> 201                 Wagner  NEC  65.5      304 100.8      201         49.1
#> 202    Fairleigh Dickinson  NEC  70.6       68 100.7      202         51.9
#> 203                   UMBC   AE  67.5      208 100.6      203         50.3
#> 204          UNC Asheville BSth  68.2      170 100.6      204         54.6
#> 205           Morehead St.  OVC  65.2      314 100.6      205         52.2
#> 206          Cleveland St. Horz  66.1      279 100.6      206         50.5
#> 207            Utah Valley  WAC  70.2       85 100.5      207         51.4
#> 208            Santa Clara  WCC  70.4       81 100.4      208         47.7
#> 209           Nicholls St. Slnd  71.6       42 100.4      209         51.0
#> 210      Boston University  Pat  65.6      302 100.3      210         49.7
#> 211              Louisiana   SB  71.0       56 100.3      211         50.3
#> 212                Stetson ASun  67.8      194 100.3      212         50.4
#> 213               Iowa St.  B12  69.9       91 100.3      213         48.0
#> 214      Purdue Fort Wayne Horz  69.5      109 100.3      214         58.2
#> 215       Central Michigan  MAC  72.1       29 100.2      215         48.7
#> 216                   Penn  Ivy  69.2      124 100.2      216          0.0
#> 217                   Iona MAAC  67.7      199 100.2      217         50.7
#> 218             Morgan St. MEAC  71.9       32 100.0      218         48.7
#> 219      Southern Illinois  MVC  66.2      274 100.0      219         52.2
#> 220       Western Carolina   SC  70.5       77  99.9      220         51.8
#> 221         Texas Southern SWAC  71.5       45  99.8      221         47.7
#> 222                Niagara MAAC  64.5      329  99.8      222         46.6
#> 223           UMass Lowell   AE  69.0      131  99.8      223         51.2
#> 224                  Siena MAAC  66.2      273  99.8      224         52.0
#> 225                 Tulane Amer  67.4      221  99.8      225         44.2
#> 226             Kansas St.  B12  65.5      308  99.6      226         47.2
#> 227             Fresno St.  MWC  65.8      295  99.6      227         48.8
#> 228              Texas St.   SB  62.4      354  99.6      228         51.8
#> 229                  Rider MAAC  67.6      205  99.5      229         48.3
#> 230            Montana St. BSky  68.2      168  99.4      230         49.7
#> 231       Coastal Carolina   SB  71.1       51  99.3      231         49.7
#> 232          East Carolina Amer  67.9      187  99.3      232         45.2
#> 233           Arkansas St.   SB  67.6      201  99.2      233         48.0
#> 234            Norfolk St. MEAC  67.5      211  99.1      234         48.7
#> 235               Canisius MAAC  70.6       74  99.1      235         47.0
#> 236                 Towson  CAA  65.8      294  99.0      236         45.4
#> 237               Monmouth MAAC  74.2        5  99.0      237         48.5
#> 238      Northern Colorado BSky  67.8      189  99.0      238         51.3
#> 239                Montana BSky  65.7      299  98.8      239         48.9
#> 240           Illinois St.  MVC  69.0      132  98.7      240         50.4
#> 241                Seattle  WAC  68.8      140  98.6      241         46.5
#> 242           Northeastern  CAA  67.0      236  98.5      242         51.6
#> 243            Little Rock   SB  67.0      240  98.4      243         50.4
#> 244       Northern Arizona BSky  63.9      339  98.4      244         48.0
#> 245        Appalachian St.   SB  65.5      310  98.4      245         46.9
#> 246           UT Arlington   SB  69.2      118  98.2      246         46.1
#> 247                 Howard MEAC  69.5      110  98.2      247         51.1
#> 248           Sacred Heart  NEC  66.2      272  98.2      248         48.0
#> 249          Robert Morris Horz  67.3      224  98.1      249         50.5
#> 250                   Army  Pat  68.4      157  98.1      250         51.8
#> 251               Longwood BSth  65.0      317  98.0      251         49.9
#> 252       Western Illinois  Sum  71.5       44  98.0      252         45.8
#> 253               UC Davis   BW  69.2      119  98.0      253         48.2
#> 254           North Dakota  Sum  67.1      229  97.7      254         49.4
#> 255                Radford BSth  63.5      346  97.7      255         50.5
#> 256         Long Beach St.   BW  73.7        8  97.6      256         50.6
#> 257                 DePaul   BE  70.6       72  97.6      257         46.1
#> 258       Central Arkansas Slnd  70.9       61  97.6      258         49.3
#> 259              San Diego  WCC  70.2       84  97.4      259         46.4
#> 260            New Orleans Slnd  72.4       23  97.3      260         52.3
#> 261              Charlotte CUSA  62.7      351  97.3      261         49.2
#> 262               Bucknell  Pat  71.8       34  97.3      262         52.0
#> 263                 Albany   AE  69.6      108  97.3      263         50.5
#> 264                    FIU CUSA  70.3       82  97.3      264         50.5
#> 265             Holy Cross  Pat  69.1      126  97.2      265         50.3
#> 266             Binghamton   AE  65.9      290  97.2      266         48.9
#> 267               Portland  WCC  71.0       55  97.1      267         46.3
#> 268       Eastern Michigan  MAC  68.1      178  97.1      268         46.7
#> 269               Delaware  CAA  66.5      262  97.0      269         49.5
#> 270           Tarleton St.  WAC  64.4      331  97.0      270         48.6
#> 271               Hartford   AE  66.9      243  97.0      271         49.9
#> 272              Loyola MD  Pat  68.4      162  96.8      272         51.1
#> 273       Northwestern St. Slnd  70.8       62  96.7      273         48.9
#> 274                   Elon  CAA  66.5      265  96.7      274         48.3
#> 275             Valparaiso  MVC  67.0      239  96.6      275         47.2
#> 276                Samford   SC  72.7       17  96.5      276         47.9
#> 277               American  Pat  67.4      215  96.5      277         52.6
#> 278                   UMKC  Sum  62.5      352  96.2      278         51.2
#> 279                  IUPUI Horz  72.1       28  96.2      279         49.0
#> 280             High Point BSth  66.1      277  96.1      280         45.8
#> 281         Tennessee Tech  OVC  68.8      142  96.0      281         50.1
#> 282          New Hampshire   AE  66.4      266  96.0      282         45.3
#> 283            McNeese St. Slnd  68.5      156  95.7      283         53.1
#> 284     North Carolina A&T MEAC  70.6       73  95.6      284         45.4
#> 285           San Jose St.  MWC  71.8       38  95.5      285         44.7
#> 286       Eastern Illinois  OVC  68.9      138  95.5      286         49.3
#> 287 Southeast Missouri St.  OVC  68.4      158  95.5      287         49.9
#> 288                  Brown  Ivy  69.7      100  95.2      288          0.0
#> 289                Hampton BSth  70.4       80  94.9      289         49.5
#> 290              Fairfield MAAC  64.3      333  94.9      290         45.4
#> 291         William & Mary  CAA  68.1      182  94.8      291         46.1
#> 292              Dartmouth  Ivy  66.6      259  94.8      292          0.0
#> 293            USC Upstate BSth  68.3      166  94.8      293         49.0
#> 294       Western Michigan  MAC  66.0      283  94.7      294         49.3
#> 295            Stony Brook   AE  66.4      268  94.7      295         46.0
#> 296         St. Francis PA  NEC  68.5      154  94.7      296         47.9
#> 297          North Alabama ASun  70.6       75  94.7      297         48.2
#> 298               Columbia  Ivy  68.9      137  94.7      298          0.0
#> 299       Prairie View A&M SWAC  69.2      121  94.6      299         50.3
#> 300         Nebraska Omaha  Sum  70.7       65  94.6      300         46.3
#> 301       Mount St. Mary's  NEC  61.6      356  94.5      301         48.6
#> 302              Air Force  MWC  62.8      349  94.4      302         52.1
#> 303                   NJIT   AE  68.2      171  94.2      303         45.9
#> 304                 Denver  Sum  70.9       60  94.2      304         49.8
#> 305       Georgia Southern   SB  66.6      255  94.1      305         48.0
#> 306              Idaho St. BSky  64.2      335  93.7      306         47.2
#> 307           Jacksonville ASun  67.6      204  93.7      307         48.8
#> 308         Incarnate Word Slnd  64.7      324  93.6      308         50.3
#> 309     Florida Gulf Coast ASun  70.6       69  93.5      309         47.7
#> 310                    LIU  NEC  73.7        9  93.4      310         47.3
#> 311 North Carolina Central MEAC  65.9      287  93.3      311         46.9
#> 312      Northern Illinois  MAC  65.4      312  93.3      312         44.4
#> 313       Louisiana Monroe   SB  67.1      231  93.2      313         48.2
#> 314           Portland St. BSky  69.2      116  93.1      314         44.4
#> 315       Illinois Chicago Horz  68.2      175  93.1      315         49.7
#> 316                  Lamar Slnd  67.5      210  93.1      316         46.0
#> 317          Southern Miss CUSA  67.4      218  92.9      317         47.3
#> 318 Southeastern Louisiana Slnd  68.6      150  92.9      318         45.4
#> 319       SIU Edwardsville  OVC  68.2      172  92.6      319         49.2
#> 320    Central Connecticut  NEC  70.3       83  92.5      320         48.5
#> 321        Houston Baptist Slnd  72.6       18  92.5      321         48.7
#> 322                   Troy   SB  68.2      173  92.4      322         44.4
#> 323       Tennessee Martin  OVC  67.4      220  92.3      323         45.6
#> 324          Grambling St. SWAC  69.8       94  92.1      324         47.8
#> 325   UT Rio Grande Valley  WAC  69.6      103  91.8      325         43.0
#> 326                 Lehigh  Pat  70.0       87  91.6      326         47.1
#> 327             New Mexico  MWC  67.7      195  91.6      327         43.9
#> 328                 Marist MAAC  66.1      280  91.6      328         49.1
#> 329               Southern SWAC  70.6       71  91.5      329         48.0
#> 330              Dixie St.  WAC  73.1       15  91.3      330         45.5
#> 331    Arkansas Pine Bluff SWAC  67.0      242  91.2      331         43.2
#> 332       Middle Tennessee CUSA  69.2      117  91.2      332         45.4
#> 333             Alcorn St. SWAC  69.5      111  91.1      333         44.4
#> 334             Coppin St. MEAC  76.8        1  91.0      334         48.6
#> 335           Delaware St. MEAC  73.3       12  90.9      335         45.7
#> 336              Merrimack  NEC  66.5      263  90.7      336         51.4
#> 337           Presbyterian BSth  65.7      297  90.6      337         46.7
#> 338                  Idaho BSky  66.8      250  90.6      338         48.5
#> 339          Saint Peter's MAAC  66.7      253  90.4      339         45.6
#> 340          Tennessee St.  OVC  71.2       49  90.2      340         47.0
#> 341            Florida A&M MEAC  68.4      161  90.2      341         48.6
#> 342        Bethune Cookman MEAC  72.3       25  90.1      342          0.0
#> 343               Cal Poly   BW  66.8      248  90.1      343         44.5
#> 344    Charleston Southern BSth  69.6      106  89.8      344         46.5
#> 345             Quinnipiac MAAC  72.0       31  89.6      345         46.9
#> 346              Manhattan MAAC  67.1      233  89.5      346         42.6
#> 347 Texas A&M Corpus Chris Slnd  69.6      105  89.4      347         46.9
#> 348            Chicago St.  WAC  67.5      212  88.3      348         41.3
#> 349            Jackson St. SWAC  68.4      159  88.1      349         44.5
#> 350           Kennesaw St. ASun  69.3      113  87.8      350         45.8
#> 351     South Carolina St. MEAC  71.6       40  87.2      351         44.9
#> 352                Fordham  A10  63.7      343  86.3      352         41.4
#> 353                  Maine   AE  64.5      330  85.9      353         45.1
#> 354            Alabama A&M SWAC  67.5      209  84.8      354         44.8
#> 355            Alabama St. SWAC  70.8       63  84.4      355         43.5
#> 356 Maryland Eastern Shore MEAC  67.8      192  83.9      356          0.0
#> 357 Mississippi Valley St. SWAC  71.1       50  79.4      357         43.6
#> 358                Gonzaga  WCC  71.9       35 121.3        1         57.5
#> 359                 Dayton  A10  67.6      220 119.1        2         59.7
#> 360              Creighton   BE  68.3      178 118.2        3         55.2
#> 361                    LSU  SEC  70.0       84 118.1        4         52.7
#> 362                   Iowa  B10  70.2       77 117.3        5         51.6
#> 363                 Oregon  P12  65.0      319 117.1        6         54.3
#> 364                    BYU  WCC  69.5      108 116.3        7         58.1
#> 365                 Kansas  B12  67.3      233 115.8        8         53.7
#> 366                   Duke  ACC  72.0       34 115.7        9         52.6
#> 367           Michigan St.  B10  69.1      130 115.2       10         52.6
#> 368          San Diego St.  MWC  64.6      332 115.1       11         54.6
#> 369             Louisville  ACC  67.1      242 114.5       12         52.5
#> 370               Ohio St.  B10  66.2      280 114.3       13         52.3
#> 371              Marquette   BE  70.7       60 114.0       14         51.6
#> 372              Villanova   BE  66.2      275 113.9       15         52.6
#> 373           Saint Mary's  WCC  63.9      339 113.7       16         54.1
#> 374                 Baylor  B12  66.2      277 113.5       17         49.4
#> 375               Maryland  B10  67.0      245 113.5       18         48.6
#> 376        Mississippi St.  SEC  66.2      276 113.4       19         51.5
#> 377               Michigan  B10  68.7      150 113.2       20         52.8
#> 378               Syracuse  ACC  68.3      179 112.8       21         50.5
#> 379                Houston Amer  65.7      300 112.7       22         48.0
#> 380          Northern Iowa  MVC  65.8      299 112.7       23         54.8
#> 381               Kentucky  SEC  67.7      215 112.7       24         50.7
#> 382                 Butler   BE  63.7      341 112.6       25         52.3
#> 383               Davidson  A10  64.8      330 112.5       26         53.4
#> 384                Florida  SEC  64.9      326 112.5       27         52.1
#> 385                    SMU Amer  64.8      331 112.4       28         52.1
#> 386             Seton Hall   BE  69.8       93 112.3       29         51.4
#> 387              Minnesota  B10  66.8      257 112.1       30         49.4
#> 388          North Florida ASun  69.4      111 112.0       31         54.6
#> 389            Florida St.  ACC  69.9       89 111.7       32         51.9
#> 390                 Auburn  SEC  69.2      127 111.4       33         50.0
#> 391            North Texas CUSA  62.9      350 111.2       34         55.3
#> 392                Arizona  P12  69.3      115 111.0       35         50.7
#> 393             Georgetown   BE  70.0       87 111.0       36         49.1
#> 394                Alabama  SEC  74.8        4 111.0       37         52.2
#> 395               Illinois  B10  66.0      288 110.9       38         48.3
#> 396             Oregon St.  P12  65.6      305 110.9       39         51.6
#> 397              Wisconsin  B10  63.7      342 110.8       40         50.3
#> 398             Notre Dame  ACC  68.1      190 110.7       41         50.4
#> 399             N.C. State  ACC  69.5      103 110.7       42         50.9
#> 400               Penn St.  B10  70.9       54 110.3       43         49.5
#> 401                 Nevada  MWC  71.0       50 110.3       44         52.9
#> 402      Northern Colorado BSky  65.0      320 110.2       45         54.7
#> 403       South Dakota St.  Sum  68.0      201 110.0       46         55.8
#> 404             Texas Tech  B12  67.3      236 109.8       47         51.7
#> 405               Iowa St.  B12  69.9       90 109.6       48         49.8
#> 406               Utah St.  MWC  67.4      229 109.5       49         51.8
#> 407                 Purdue  B10  64.6      333 109.3       50         47.8
#> 408                   UCLA  P12  64.9      325 109.3       51         48.4
#> 409           Colorado St.  MWC  69.3      116 109.3       52         53.9
#> 410               Richmond  A10  69.3      124 109.2       53         53.4
#> 411               Colorado  P12  68.2      188 109.1       54         50.5
#> 412               Arkansas  SEC  71.2       45 109.1       55         50.9
#> 413       Western Kentucky CUSA  68.3      176 108.9       56         51.3
#> 414           Portland St. BSky  71.8       40 108.8       57         49.6
#> 415               Oklahoma  B12  69.6       98 108.8       58         48.2
#> 416             Cincinnati Amer  68.0      199 108.8       59         50.3
#> 417         Louisiana Tech CUSA  66.5      266 108.7       60         53.3
#> 418            Wake Forest  ACC  70.1       79 108.7       61         49.0
#> 419                Hofstra  CAA  67.9      202 108.7       62         51.7
#> 420           South Dakota  Sum  70.0       85 108.6       63         54.6
#> 421            Connecticut Amer  68.5      167 108.6       64         47.8
#> 422                Indiana  B10  67.9      206 108.5       65         49.3
#> 423                  Akron  MAC  69.4      110 108.5       66         51.7
#> 424          West Virginia  B12  69.4      112 108.3       67         46.5
#> 425          San Francisco  WCC  68.7      155 108.3       68         51.3
#> 426     East Tennessee St.   SC  66.1      281 108.2       69         53.5
#> 427           Oral Roberts  Sum  70.4       68 108.2       70         50.9
#> 428                Georgia  SEC  70.5       64 108.2       71         50.9
#> 429                Rutgers  B10  67.4      231 107.9       72         48.9
#> 430                   Yale  Ivy  67.4      227 107.9       73         53.8
#> 431                   UNLV  MWC  67.0      247 107.9       74         49.7
#> 432             Providence   BE  68.4      171 107.8       75         47.3
#> 433              Air Force  MWC  68.8      147 107.8       76         52.9
#> 434         North Carolina  ACC  70.4       67 107.7       77         46.4
#> 435                 Furman   SC  68.2      187 107.7       78         54.6
#> 436               Miami FL  ACC  68.3      180 107.7       79         48.8
#> 437         New Mexico St.  WAC  63.5      343 107.6       80         52.7
#> 438         St. Francis PA  NEC  68.9      138 107.6       81         51.5
#> 439     Cal St. Northridge   BW  70.3       74 107.4       82         51.6
#> 440       Western Carolina   SC  71.5       43 107.3       83         54.6
#> 441           Oklahoma St.  B12  68.4      173 107.2       84         47.8
#> 442             Pepperdine  WCC  70.8       57 107.2       85         50.0
#> 443                Colgate  Pat  68.5      168 107.2       86         52.8
#> 444                  Siena MAAC  66.7      261 107.2       87         51.8
#> 445              Boise St.  MWC  69.1      133 107.0       88         51.1
#> 446              Princeton  Ivy  66.3      274 107.0       89         53.6
#> 447            Austin Peay  OVC  67.8      209 106.9       90         51.3
#> 448       North Dakota St.  Sum  66.0      287 106.8       91         51.9
#> 449                Bradley  MVC  67.1      244 106.8       92         49.5
#> 450            Chattanooga   SC  67.0      248 106.6       93         52.5
#> 451               Duquesne  A10  67.8      211 106.6       94         51.2
#> 452        St. Bonaventure  A10  65.7      301 106.6       95         49.1
#> 453              Tennessee  SEC  65.2      313 106.6       96         48.8
#> 454                Belmont  OVC  70.5       65 106.5       97         54.8
#> 455                Vermont   AE  66.3      273 106.5       98         51.6
#> 456            Little Rock   SB  69.3      125 106.4       99         52.8
#> 457                   Utah  P12  66.7      260 106.3      100         51.3
#> 458              Texas St.   SB  65.2      312 106.3      101         48.9
#> 459                 Toledo  MAC  68.1      193 106.3      102         50.9
#> 460                 Xavier   BE  68.1      191 106.1      103         49.0
#> 461             St. John's   BE  72.9       21 106.1      104         45.9
#> 462               Kent St.  MAC  68.9      143 106.1      105         52.3
#> 463       UC Santa Barbara   BW  64.5      335 106.1      106         51.1
#> 464                Liberty ASun  61.5      352 106.1      107         54.4
#> 465            Arizona St.  P12  73.2       14 106.0      108         48.8
#> 466              Green Bay Horz  74.0        7 105.8      109         50.8
#> 467                   Rice CUSA  70.1       80 105.8      110         51.5
#> 468            Saint Louis  A10  67.6      219 105.8      111         50.1
#> 469             Washington  P12  69.8       96 105.8      112         50.4
#> 470            Indiana St.  MVC  66.4      270 105.8      113         51.7
#> 471                 Towson  CAA  65.1      317 105.7      114         48.7
#> 472            Georgia St.   SB  73.0       19 105.6      115         50.3
#> 473               Delaware  CAA  68.3      182 105.6      116         54.4
#> 474            Wichita St. Amer  69.5      101 105.6      117         47.1
#> 475                Radford BSth  64.3      336 105.6      118         52.6
#> 476                    TCU  B12  65.1      318 105.5      119         49.4
#> 477     Eastern Washington BSky  73.1       18 105.4      120         52.0
#> 478              UC Irvine   BW  67.7      212 105.4      121         51.6
#> 479         South Carolina  SEC  73.1       17 105.4      122         48.6
#> 480           Northeastern  CAA  65.9      291 105.4      123         54.9
#> 481            Cal Baptist  WAC  68.6      162 105.3      124         50.8
#> 482             New Mexico  MWC  71.8       38 105.3      125         52.2
#> 483           Rhode Island  A10  71.2       46 105.2      126         46.9
#> 484             Fresno St.  MWC  64.2      338 105.1      127         49.8
#> 485       Tennessee Martin  OVC  68.7      149 105.1      128         50.9
#> 486             Charleston  CAA  65.9      295 105.0      129         51.1
#> 487          South Alabama   SB  65.3      310 104.9      130         51.4
#> 488           Northwestern  B10  66.7      259 104.9      131         46.9
#> 489             Wright St. Horz  72.1       31 104.9      132         51.0
#> 490           Missouri St.  MVC  68.3      181 104.8      133         49.8
#> 491       Coastal Carolina   SB  72.8       26 104.8      134         50.1
#> 492                Hampton BSth  70.9       56 104.8      135         50.2
#> 493               Winthrop BSth  71.9       36 104.7      136         53.0
#> 494                Harvard  Ivy  68.8      148 104.7      137         51.2
#> 495                    VCU  A10  69.0      134 104.7      138         49.7
#> 496             Vanderbilt  SEC  69.4      109 104.7      139         50.2
#> 497               UC Davis   BW  68.0      194 104.7      140         52.3
#> 498             Valparaiso  MVC  69.3      123 104.5      141         50.7
#> 499                Wofford   SC  65.9      293 104.5      142         53.3
#> 500               Stanford  P12  68.3      183 104.4      143         53.5
#> 501           UMass Lowell   AE  70.3       72 104.4      144         51.6
#> 502                    USC  P12  68.9      139 104.3      145         49.5
#> 503          Bowling Green  MAC  70.1       81 104.3      146         47.6
#> 504          Virginia Tech  ACC  65.5      309 104.3      147         50.3
#> 505           Arkansas St.   SB  67.3      237 104.2      148         48.9
#> 506                   UTSA CUSA  72.8       24 104.2      149         48.1
#> 507               Missouri  SEC  66.5      267 104.1      150         47.0
#> 508                Buffalo  MAC  73.9        8 104.1      151         48.8
#> 509      Stephen F. Austin Slnd  71.8       39 104.1      152         53.3
#> 510                  Texas  B12  65.9      292 104.1      153         49.9
#> 511             Pittsburgh  ACC  65.5      308 104.0      154         45.1
#> 512                Clemson  ACC  66.0      290 103.9      155         50.1
#> 513                Pacific  WCC  64.9      323 103.8      156         49.5
#> 514                    FIU CUSA  72.2       30 103.7      157         51.7
#> 515            Mississippi  SEC  68.0      196 103.7      158         48.6
#> 516         Loyola Chicago  MVC  65.3      311 103.7      159         54.9
#> 517         UNC Greensboro   SC  67.8      210 103.7      160         48.8
#> 518                   Ohio  MAC  68.0      195 103.6      161         51.3
#> 519                    UCF Amer  67.8      208 103.5      162         49.4
#> 520                   Penn  Ivy  70.2       76 103.4      163         52.3
#> 521           Grand Canyon  WAC  68.0      198 103.4      164         50.7
#> 522                 DePaul   BE  70.6       63 103.4      165         47.9
#> 523      Boston University  Pat  66.3      272 103.3      166         51.3
#> 524         William & Mary  CAA  67.5      222 103.3      167         53.5
#> 525                  Tulsa Amer  65.8      297 103.2      168         49.6
#> 526                Montana BSky  68.2      185 103.2      169         52.3
#> 527         Nebraska Omaha  Sum  69.2      126 103.2      170         49.9
#> 528           Georgia Tech  ACC  70.0       88 103.1      171         49.8
#> 529            McNeese St. Slnd  69.0      137 103.0      172         54.9
#> 530         Youngstown St. Horz  66.4      269 103.0      173         47.4
#> 531          Massachusetts  A10  68.6      161 102.9      174         49.2
#> 532        Houston Baptist Slnd  76.1        2 102.9      175         50.3
#> 533            Santa Clara  WCC  71.6       42 102.6      176         52.2
#> 534             Kansas St.  B12  67.2      239 102.5      177         47.5
#> 535             Murray St.  OVC  68.9      144 102.4      178         52.7
#> 536       Northern Arizona BSky  66.6      265 102.3      179         49.7
#> 537           UT Arlington   SB  67.7      214 102.3      180         47.3
#> 538           Gardner Webb BSth  66.2      279 102.2      181         51.8
#> 539         Washington St.  P12  70.8       59 102.2      182         45.8
#> 540           North Dakota  Sum  68.9      145 102.2      183         50.5
#> 541       Georgia Southern   SB  71.8       41 102.2      184         50.2
#> 542           Sacred Heart  NEC  68.7      152 102.2      185         49.1
#> 543    Fairleigh Dickinson  NEC  68.9      142 102.1      186         51.1
#> 544       Central Michigan  MAC  73.6       11 102.0      187         47.5
#> 545               Miami OH  MAC  67.1      243 102.0      188         48.4
#> 546                  Drake  MVC  67.9      204 102.0      189         51.7
#> 547               Nebraska  B10  73.1       16 102.0      190         46.8
#> 548      Northern Kentucky Horz  65.7      304 102.0      191         49.5
#> 549                 Tulane Amer  68.7      154 101.9      192         47.8
#> 550         Saint Joseph's  A10  71.2       47 101.9      193         46.6
#> 551                   Iona MAAC  68.7      156 101.6      194         51.0
#> 552             California  P12  65.2      315 101.5      195         46.9
#> 553              Louisiana   SB  71.8       37 101.3      196         48.0
#> 554           George Mason  A10  67.0      246 101.3      197         47.6
#> 555                Cornell  Ivy  65.2      314 101.2      198         49.8
#> 556               Marshall CUSA  74.9        3 101.2      199         50.2
#> 557                Seattle  WAC  69.9       91 101.2      200         45.3
#> 558               Lipscomb ASun  68.7      153 101.2      201         50.1
#> 559               American  Pat  68.7      159 101.1      202         51.6
#> 560              Texas A&M  SEC  64.5      334 101.0      203         46.4
#> 561                  Rider MAAC  71.1       49 100.9      204         49.1
#> 562                    UAB CUSA  65.7      302 100.8      205         49.7
#> 563              Idaho St. BSky  67.4      230 100.8      206         50.0
#> 564             Quinnipiac MAAC  68.9      141 100.7      207         50.9
#> 565                   Elon  CAA  66.2      278 100.6      208         49.5
#> 566       Loyola Marymount  WCC  63.0      349 100.6      209         51.0
#> 567                Memphis Amer  72.6       28 100.6      210         49.7
#> 568              Lafayette  Pat  66.9      251 100.6      211         52.1
#> 569          Robert Morris  NEC  66.1      282 100.5      212         51.4
#> 570              Loyola MD  Pat  71.0       52 100.4      213         52.7
#> 571          South Florida Amer  64.9      324 100.2      214         46.6
#> 572                    VMI   SC  67.9      203 100.2      215         50.4
#> 573                 Mercer   SC  68.1      192 100.1      216         51.0
#> 574                 Temple Amer  70.3       73 100.1      217         46.0
#> 575                Niagara MAAC  66.0      289 100.1      218         49.7
#> 576                 Drexel  CAA  67.3      235 100.0      219         50.5
#> 577        Appalachian St.   SB  67.2      240  99.9      220         48.4
#> 578                Detroit Horz  69.3      117  99.9      221         46.2
#> 579      Northern Illinois  MAC  64.8      329  99.8      222         47.2
#> 580           Nicholls St. Slnd  68.7      158  99.7      223         49.5
#> 581             Binghamton   AE  68.6      164  99.7      224         47.9
#> 582       Florida Atlantic CUSA  68.8      146  99.7      225         48.5
#> 583               La Salle  A10  69.1      131  99.6      226         48.4
#> 584          East Carolina Amer  70.6       62  99.6      227         46.7
#> 585         Boston College  ACC  69.3      120  99.6      228         46.5
#> 586        Sam Houston St. Slnd  71.1       48  99.5      229         50.7
#> 587          James Madison  CAA  72.1       32  99.5      230         48.2
#> 588                  IUPUI Horz  70.8       58  99.4      231         47.9
#> 589       Western Michigan  MAC  67.4      228  99.4      232         48.2
#> 590            New Orleans Slnd  69.8       94  99.3      233         48.4
#> 591               Virginia  ACC  59.4      353  99.3      234         46.9
#> 592               Ball St.  MAC  68.0      200  99.2      235         50.4
#> 593      George Washington  A10  66.6      264  99.2      236         49.0
#> 594         Texas Southern SWAC  72.9       22  99.1      237         45.9
#> 595               Monmouth MAAC  72.6       27  99.1      238         47.1
#> 596      Abilene Christian Slnd  68.4      172  99.1      239         49.6
#> 597          Southern Utah BSky  69.3      118  98.8      240         48.7
#> 598              Weber St. BSky  67.6      216  98.8      241         48.7
#> 599                   Army  Pat  69.5      106  98.8      242         52.9
#> 600          UNC Asheville BSth  71.0       51  98.7      243         52.5
#> 601   UT Rio Grande Valley  WAC  70.4       66  98.7      244         46.8
#> 602                Samford   SC  72.8       25  98.6      245         48.0
#> 603                Oakland Horz  66.1      285  98.6      246         48.1
#> 604              Charlotte CUSA  65.5      307  98.5      247         51.6
#> 605           Illinois St.  MVC  68.5      169  98.4      248         49.9
#> 606           Old Dominion CUSA  66.4      268  98.3      249         45.3
#> 607       Western Illinois  Sum  71.3       44  98.3      250         48.5
#> 608       Northwestern St. Slnd  72.4       29  98.3      251         49.7
#> 609      Southern Illinois  MVC  64.2      337  98.2      252         49.5
#> 610       Eastern Illinois  OVC  69.1      129  98.2      253         50.5
#> 611                   Navy  Pat  62.5      351  98.1      254         46.1
#> 612                Stetson ASun  63.2      344  98.1      255         49.6
#> 613       Central Arkansas Slnd  73.2       15  98.0      256         48.5
#> 614                 Bryant  NEC  70.3       71  97.8      257         47.9
#> 615                   UMBC   AE  66.8      255  97.8      258         48.3
#> 616               Canisius MAAC  70.0       86  97.7      259         48.5
#> 617            Stony Brook   AE  69.8       92  97.7      260         47.7
#> 618                 Hawaii   BW  68.4      170  97.6      261         48.8
#> 619           San Jose St.  MWC  73.3       13  97.5      262         45.2
#> 620                   UMKC  WAC  64.9      327  97.5      263         50.5
#> 621       Middle Tennessee CUSA  69.8       95  97.5      264         47.5
#> 622                    LIU  NEC  72.8       23  97.4      265         51.4
#> 623                 Wagner  NEC  67.5      223  97.3      266         46.5
#> 624               Southern SWAC  66.8      256  97.2      267         47.9
#> 625         Sacramento St. BSky  63.9      340  97.1      268         45.4
#> 626                 Lehigh  Pat  68.4      174  97.0      269         49.7
#> 627            Montana St. BSky  67.3      234  97.0      270         49.0
#> 628             Alcorn St. SWAC  70.1       82  96.9      271         47.3
#> 629           Presbyterian BSth  66.9      253  96.9      272         50.2
#> 630                   UTEP CUSA  67.5      224  96.9      273         47.3
#> 631             Evansville  MVC  67.6      217  96.9      274         48.6
#> 632               Campbell BSth  65.6      306  96.8      275         52.6
#> 633              Dartmouth  Ivy  65.8      298  96.7      276         49.6
#> 634            Utah Valley  WAC  70.4       69  96.5      277         49.2
#> 635                  Brown  Ivy  69.4      113  96.4      278         44.9
#> 636          Tennessee St.  OVC  69.3      121  96.4      279         53.0
#> 637       Illinois Chicago Horz  69.5      105  96.4      280         50.8
#> 638       Mount St. Mary's  NEC  63.2      345  96.4      281         46.2
#> 639       Prairie View A&M SWAC  70.7       61  96.3      282         47.4
#> 640                  Lamar Slnd  69.6       99  96.3      283         48.0
#> 641                   Troy   SB  69.3      119  96.2      284         46.1
#> 642               Bucknell  Pat  69.5      107  96.2      285         49.3
#> 643    Cal St. Bakersfield  WAC  64.9      321  96.2      286         46.5
#> 644       Louisiana Monroe   SB  64.9      322  96.1      287         47.7
#> 645              Milwaukee Horz  69.5      102  96.0      288         46.8
#> 646          North Alabama ASun  70.1       83  96.0      289         47.9
#> 647           Jacksonville ASun  66.6      262  96.0      290         48.0
#> 648             Holy Cross  Pat  68.3      177  95.9      291         49.3
#> 649      Cal St. Fullerton   BW  69.3      114  95.9      292         47.7
#> 650       Jacksonville St.  OVC  68.1      189  95.8      293         48.7
#> 651           UC Riverside   BW  63.2      347  95.8      294         49.8
#> 652            USC Upstate BSth  69.2      128  95.5      295         47.4
#> 653    Charleston Southern BSth  66.9      250  95.4      296         48.4
#> 654       Eastern Kentucky  OVC  74.5        6  95.4      297         46.5
#> 655        Bethune Cookman MEAC  73.0       20  95.4      298         46.4
#> 656      Purdue Fort Wayne  Sum  67.9      205  95.4      299         49.4
#> 657          Saint Peter's MAAC  68.0      197  95.4      300         46.0
#> 658               Cal Poly   BW  68.3      175  95.2      301         47.3
#> 659               Columbia  Ivy  69.1      132  95.2      302         46.1
#> 660                 Denver  Sum  70.9       53  95.0      303         49.1
#> 661          New Hampshire   AE  68.6      163  95.0      304         46.8
#> 662            The Citadel   SC  73.7       10  94.9      305         49.7
#> 663     South Carolina St. MEAC  67.4      226  94.9      306         46.1
#> 664                   NJIT ASun  66.9      249  94.7      307         45.3
#> 665         St. Francis NY  NEC  70.3       70  94.6      308         46.4
#> 666           Morehead St.  OVC  67.3      232  94.6      309         47.2
#> 667             High Point BSth  66.4      271  94.5      310         45.7
#> 668            Florida A&M MEAC  68.6      160  94.4      311         45.4
#> 669               Hartford   AE  68.2      184  94.4      312         48.6
#> 670          Southern Miss CUSA  67.2      238  94.4      313         47.8
#> 671               Portland  WCC  69.3      122  94.4      314         48.6
#> 672              San Diego  WCC  70.2       78  94.4      315         45.9
#> 673                 Albany   AE  68.5      166  94.3      316         48.0
#> 674 Texas A&M Corpus Chris Slnd  65.7      303  94.3      317         51.5
#> 675       Eastern Michigan  MAC  66.8      254  94.2      318         46.2
#> 676 North Carolina Central MEAC  66.6      263  94.2      319         50.2
#> 677         Long Beach St.   BW  70.9       55  94.2      320         48.2
#> 678            Norfolk St. MEAC  67.5      225  94.2      321         47.0
#> 679                Wyoming  MWC  66.7      258  94.1      322         48.0
#> 680           Delaware St. MEAC  74.7        5  94.1      323         47.0
#> 681 Southeast Missouri St.  OVC  67.6      218  94.0      324         47.0
#> 682              Merrimack  NEC  63.2      348  93.9      325         48.5
#> 683                 Howard MEAC  70.2       75  93.6      326         48.2
#> 684             Morgan St. MEAC  69.6      100  93.2      327         45.9
#> 685          Grambling St. SWAC  68.7      151  93.1      328         47.6
#> 686          Cleveland St. Horz  67.1      241  92.9      329         44.5
#> 687                  Maine   AE  65.9      294  92.9      330         46.3
#> 688              Manhattan MAAC  65.8      296  92.8      331         45.7
#> 689                  Idaho BSky  68.9      140  92.8      332         47.6
#> 690            Jackson St. SWAC  68.7      157  92.8      333         45.2
#> 691         Tennessee Tech  OVC  66.9      252  92.5      334         47.6
#> 692     North Carolina A&T MEAC  73.7        9  92.3      335         47.1
#> 693       SIU Edwardsville  OVC  69.0      136  92.3      336         46.9
#> 694         UNC Wilmington  CAA  68.5      165  92.1      337         45.8
#> 695 Southeastern Louisiana Slnd  72.1       33  92.0      338         46.8
#> 696               Longwood BSth  67.8      207  91.3      339         48.1
#> 697     Florida Gulf Coast ASun  66.1      286  91.2      340         47.2
#> 698         Incarnate Word Slnd  66.1      283  90.3      341         45.7
#> 699    Central Connecticut  NEC  69.5      104  90.3      342         44.7
#> 700                 Marist MAAC  65.2      316  90.2      343         45.9
#> 701              Fairfield MAAC  63.2      346  90.1      344         43.1
#> 702 Mississippi Valley St. SWAC  77.1        1  89.8      345         43.0
#> 703             Coppin St. MEAC  73.4       12  89.6      346         45.9
#> 704                Fordham  A10  64.8      328  89.1      347         45.0
#> 705            Alabama A&M SWAC  67.7      213  87.9      348         42.4
#> 706            Chicago St.  WAC  69.0      135  86.9      349         45.5
#> 707            Alabama St. SWAC  69.7       97  86.2      350         44.6
#> 708           Kennesaw St. ASun  68.2      186  83.5      351         39.3
#> 709 Maryland Eastern Shore MEAC  67.5      221  81.7      352         40.5
#> 710    Arkansas Pine Bluff SWAC  66.1      284  79.0      353         43.1
#>     off_e_fg_pct_rk off_to_pct off_to_pct_rk off_or_pct off_or_pct_rk
#> 1                 1       16.1            40       30.1           102
#> 2                 7       16.5            54       37.3             5
#> 3                24       13.3             1       30.8            81
#> 4                58       15.5            18       29.3           119
#> 5                73       15.6            19       31.4            66
#> 6                49       13.7             4       27.8           174
#> 7               154       16.2            43       39.8             2
#> 8                12       18.1           128       32.2            49
#> 9                25       16.6            58       29.6           113
#> 10               32       16.7            66       29.1           130
#> 11               82       15.7            25       30.5            92
#> 12              217       16.8            71       35.9             8
#> 13               69       17.1            82       30.8            79
#> 14               60       18.0           122       34.9            16
#> 15              138       17.2            89       34.3            24
#> 16               37       20.4           255       34.4            22
#> 17               14       15.0            10       22.7           308
#> 18               43       18.3           144       32.2            47
#> 19               36       15.6            21       29.7           111
#> 20               16       17.3            90       28.1           163
#> 21               39       15.7            26       22.0           318
#> 22               35       16.1            36       24.4           261
#> 23               22       19.0           175       28.7           145
#> 24              104       16.3            49       29.2           122
#> 25               19       15.7            28       24.6           258
#> 26              120       18.6           159       32.8            36
#> 27              216       17.5           101       37.4             4
#> 28               59       20.7           265       31.1            74
#> 29              174       13.6             3       23.8           280
#> 30               90       18.6           157       32.2            46
#> 31               54       18.4           147       23.6           289
#> 32              195       16.0            35       33.3            32
#> 33               44       15.3            13       32.0            55
#> 34              268       16.3            45       31.9            59
#> 35              126       15.7            24       27.0           192
#> 36              215       17.6           103       29.9           107
#> 37               51       16.7            64       20.6           330
#> 38              112       22.0           315       35.0            14
#> 39                6       17.3            95       24.0           276
#> 40               26       17.1            79       28.6           147
#> 41               10       18.3           137       27.1           187
#> 42              151       16.8            72       29.2           123
#> 43              128       17.1            81       31.7            63
#> 44               53       21.2           290       31.1            75
#> 45               70       16.7            61       30.1           103
#> 46               55       15.0             8       20.3           332
#> 47               79       19.8           222       30.1           101
#> 48               80       16.0            32       26.8           200
#> 49              127       18.7           165       28.5           151
#> 50               94       17.8           111       35.8             9
#> 51              171       18.9           171       29.6           114
#> 52              251       20.3           252       40.9             1
#> 53                5       14.7             5       28.2           159
#> 54              196       17.1            80       30.5            87
#> 55              184       16.4            52       32.8            38
#> 56               65       16.4            53       28.2           158
#> 57                4       17.9           117       27.1           188
#> 58                3       16.0            34       23.2           295
#> 59               76       17.2            84       27.8           171
#> 60              114       21.0           279       31.4            68
#> 61              290       15.8            29       29.8           109
#> 62               31       16.6            56       23.6           288
#> 63               57       18.8           166       29.6           112
#> 64                9       16.6            57       26.4           215
#> 65               17       16.8            70       27.2           186
#> 66               56       15.5            16       22.7           309
#> 67               23       16.3            44       23.8           278
#> 68               42       16.0            31       22.9           304
#> 69               74       16.8            68       26.8           198
#> 70              243       17.2            87       25.5           241
#> 71              108       19.9           226       28.3           156
#> 72              101       18.4           146       24.3           263
#> 73               95       17.0            77       30.1            99
#> 74               68       16.0            33       29.2           126
#> 75              206       15.0             7       21.3           325
#> 76              329       15.6            20       29.2           124
#> 77               13       21.2           292       23.0           300
#> 78               15       17.3            96       25.7           238
#> 79              106       17.7           108       23.7           286
#> 80               29       18.1           127       34.2            26
#> 81              223       18.3           140       34.5            21
#> 82              168       16.8            67       27.7           176
#> 83               34       19.7           212       24.2           270
#> 84              289       19.8           217       32.6            41
#> 85              189       18.2           131       31.3            71
#> 86              129       21.5           300       32.8            37
#> 87              194       21.5           301       32.2            52
#> 88               41       16.9            73       22.6           312
#> 89               91       23.4           336       32.5            43
#> 90               33       18.2           136       23.8           277
#> 91                8       17.2            85       22.4           314
#> 92              271       17.2            88       32.0            54
#> 93              164       22.1           318       35.8            10
#> 94              136       20.9           276       29.1           131
#> 95              116       18.5           152       37.3             6
#> 96              250       17.2            83       29.1           129
#> 97               48       15.3            14       21.7           323
#> 98              257       18.8           169       30.5            91
#> 99              348      100.0           348        0.0           348
#> 100             109       16.9            75       24.8           250
#> 101              40       19.8           220       27.9           167
#> 102             140       20.5           257       31.8            61
#> 103             167       21.6           306       28.2           160
#> 104              45       19.4           192       28.7           141
#> 105             200       15.7            27       26.5           210
#> 106              21       18.9           173       25.5           240
#> 107             173       19.4           191       26.6           206
#> 108              30       18.0           121       26.1           229
#> 109             229       20.7           268       34.7            19
#> 110              99       21.0           284       25.1           245
#> 111             146       16.3            46       27.9           168
#> 112             125       17.4            98       29.2           125
#> 113             123       19.3           188       34.2            25
#> 114              50       17.3            92       19.0           340
#> 115             102       16.9            74       30.9            78
#> 116             277       13.5             2       30.3            95
#> 117             121       21.7           308       33.6            30
#> 118              47       18.1           125       26.6           203
#> 119             197       19.3           185       24.3           266
#> 120             172       16.4            51       24.3           264
#> 121              67       20.0           227       33.6            29
#> 122             122       20.6           263       28.5           152
#> 123             182       19.2           182       25.4           243
#> 124              63       19.3           190       35.4            12
#> 125              71       19.9           224       32.3            45
#> 126             181       20.1           234       35.3            13
#> 127             207       19.7           213       30.0           105
#> 128             178       21.0           283       29.0           134
#> 129             246       19.6           206       38.5             3
#> 130              72       17.5            99       26.6           207
#> 131              38       19.7           214       27.4           182
#> 132             163       17.2            86       19.9           335
#> 133             139       18.2           133       26.9           194
#> 134             198       18.3           141       34.3            23
#> 135             219       19.2           184       23.4           293
#> 136              89       16.1            38       22.5           313
#> 137             155       21.2           289       35.6            11
#> 138             348      100.0           348        0.0           348
#> 139             298       19.8           223       32.2            51
#> 140             232       17.8           115       30.0           106
#> 141              62       20.3           251       26.2           225
#> 142             131       18.6           156       34.9            15
#> 143             132       19.5           204       28.7           143
#> 144             156       18.7           164       28.7           146
#> 145             169       18.2           134       32.2            47
#> 146             264       15.5            17       32.1            53
#> 147              66       17.8           112       26.2           221
#> 148             247       20.5           258       29.1           128
#> 149             175       18.9           172       28.0           166
#> 150             270       16.6            59       27.4           183
#> 151             144       16.7            63       27.9           170
#> 152              20       23.5           337       36.7             7
#> 153             238       15.6            22       29.0           135
#> 154             100       19.8           218       27.8           173
#> 155             170       19.1           179       26.4           216
#> 156             279       16.1            37       24.7           252
#> 157             124       17.7           110       26.4           212
#> 158              27       19.3           189       27.6           179
#> 159             158       20.3           246       30.5            89
#> 160              46       20.3           249       28.3           153
#> 161             150       15.9            30       22.6           310
#> 162              11       18.5           151       19.6           337
#> 163             134       15.0             9       23.7           285
#> 164             280       17.3            93       26.0           230
#> 165             211       20.0           229       26.5           209
#> 166             221       18.3           143       25.2           244
#> 167             265       21.6           304       30.7            84
#> 168             135       14.9             6       24.5           259
#> 169             208       15.4            15       26.0           231
#> 170              92       16.3            48       24.2           269
#> 171             228       16.7            65       32.9            33
#> 172             281       18.4           149       27.0           190
#> 173             237       16.1            39       26.5           211
#> 174              97       20.4           256       31.6            65
#> 175             278       22.3           319       32.8            35
#> 176              61       21.5           302       25.8           235
#> 177             348      100.0           348        0.0           348
#> 178             269       17.0            76       25.8           236
#> 179             253       19.6           205       23.1           299
#> 180             190       15.3            12       24.3           265
#> 181             165       20.7           267       26.8           197
#> 182              18       19.6           208       16.7           344
#> 183             276       19.5           201       31.0            76
#> 184             110       19.2           183       30.6            85
#> 185             137       19.8           219       29.1           127
#> 186             248       16.7            62       24.3           267
#> 187             183       19.7           216       24.5           260
#> 188             107       17.6           104       24.9           247
#> 189             297       19.5           199       25.9           232
#> 190             348      100.0           348        0.0           348
#> 191             212       20.0           231       26.2           227
#> 192             282       19.0           174       31.7            64
#> 193             153       20.3           244       29.3           118
#> 194             240       18.7           162       21.8           321
#> 195             227       17.7           109       30.3            97
#> 196             234       18.5           154       27.8           172
#> 197             105       16.6            60       26.8           201
#> 198             115       17.4            97       23.2           296
#> 199             192       16.3            47       30.2            98
#> 200             328       20.8           273       33.8            28
#> 201             209       18.1           126       34.8            18
#> 202              85       19.5           200       28.7           144
#> 203             162       18.8           168       25.8           233
#> 204              28       21.2           291       26.8           199
#> 205              78       23.1           333       31.4            67
#> 206             141       18.8           167       30.7            83
#> 207              98       21.2           293       31.7            62
#> 208             275       17.9           116       23.0           301
#> 209             119       17.7           107       28.9           136
#> 210             187       18.3           139       29.0           133
#> 211             161       20.4           253       32.2            50
#> 212             149       19.6           210       28.1           162
#> 213             260       21.1           285       24.3           262
#> 214               2       23.7           340       26.2           223
#> 215             231       17.9           119       26.6           204
#> 216             348      100.0           348        0.0           348
#> 217             130       22.5           326       32.6            42
#> 218             233       20.7           269       34.5            20
#> 219              77       18.5           153       16.6           345
#> 220              87       19.4           196       22.6           311
#> 221             273       20.8           270       32.4            44
#> 222             301       15.2            11       23.4           292
#> 223             111       21.0           281       27.0           191
#> 224              83       19.5           198       28.0           165
#> 225             339       16.6            55       22.9           305
#> 226             285       22.3           324       29.9           108
#> 227             224       21.5           303       30.5            90
#> 228              86       20.1           238       28.6           148
#> 229             252       18.3           142       26.2           224
#> 230             188       17.8           114       24.2           271
#> 231             185       21.8           312       34.8            17
#> 232             326       18.5           155       26.9           195
#> 233             258       19.4           195       30.8            80
#> 234             230       17.6           102       27.8           175
#> 235             292       16.8            69       26.6           202
#> 236             322       18.4           145       34.1            27
#> 237             245       17.7           106       25.7           238
#> 238             103       20.6           260       24.7           253
#> 239             222       19.4           197       22.8           307
#> 240             152       19.3           186       23.7           284
#> 241             303       15.7            23       26.3           219
#> 242              93       19.5           203       20.2           333
#> 243             148       22.4           325       31.1            73
#> 244             262       17.9           118       23.8           281
#> 245             293       17.7           105       28.2           161
#> 246             309       16.2            42       26.9           196
#> 247             118       18.5           150       20.4           331
#> 248             259       18.7           161       29.6           115
#> 249             145       19.0           176       29.5           117
#> 250              88       18.1           130       23.2           297
#> 251             179       19.8           221       27.7           177
#> 252             315       17.3            91       27.9           169
#> 253             255       20.3           247       26.9           193
#> 254             199       18.7           163       23.5           290
#> 255             143       23.3           335       33.4            31
#> 256             133       21.0           280       23.3           294
#> 257             307       22.1           317       31.8            60
#> 258             203       23.9           343       28.9           137
#> 259             304       18.0           124       20.9           327
#> 260              75       22.3           321       29.3           120
#> 261             205       20.1           237       21.7           322
#> 262              84       17.3            94       19.8           336
#> 263             142       18.0           123       22.3           315
#> 264             147       20.9           275       25.8           234
#> 265             160       18.3           138       26.4           212
#> 266             218       20.6           259       29.2           121
#> 267             306       19.0           177       17.8           343
#> 268             299       17.1            78       24.2           268
#> 269             193       21.2           288       28.3           155
#> 270             235       18.4           148       19.3           338
#> 271             176       19.6           207       24.7           255
#> 272             117       20.2           241       31.3            70
#> 273             220       19.5           202       26.2           226
#> 274             249       17.5           100       24.6           256
#> 275             286       18.0           120       20.9           328
#> 276             267       21.4           294       28.8           140
#> 277              64       22.3           320       24.1           272
#> 278             113       19.6           209       21.6           324
#> 279             213       19.1           180       25.4           242
#> 280             313       18.6           158       31.9            58
#> 281             166       22.6           330       26.5           208
#> 282             325       16.3            50       27.3           184
#> 283              52       23.0           332       27.0           189
#> 284             321       18.7           160       27.6           180
#> 285             332       17.8           113       20.0           334
#> 286             202       20.0           230       28.8           138
#> 287             177       21.7           311       27.6           178
#> 288             348      100.0           348        0.0           348
#> 289             191       18.2           132       22.2           316
#> 290             320       19.7           211       28.0           164
#> 291             308       20.2           240       28.6           150
#> 292             348      100.0           348        0.0           348
#> 293             214       20.8           271       24.0           275
#> 294             201       21.1           286       23.5           291
#> 295             310       20.2           239       30.3            96
#> 296             266       20.2           242       28.8           139
#> 297             256       20.3           245       26.1           228
#> 298             348      100.0           348        0.0           348
#> 299             159       19.4           193       30.9            77
#> 300             305       18.1           129       23.2           298
#> 301             239       20.1           235       31.3            69
#> 302              81       22.6           329       15.3           347
#> 303             312       16.2            41       24.1           273
#> 304             180       20.9           278       22.0           317
#> 305             263       21.4           297       30.4            93
#> 306             287       23.5           338       30.8            82
#> 307             225       20.0           233       24.7           251
#> 308             157       20.6           262       23.0           303
#> 309             274       20.3           250       28.6           149
#> 310             284       19.3           187       32.9            34
#> 311             295       21.4           295       26.4           214
#> 312             335       20.2           243       32.7            39
#> 313             254       19.1           181       22.9           306
#> 314             337       20.0           232       30.5            88
#> 315             186       18.8           170       23.7           287
#> 316             311       20.1           236       26.3           217
#> 317             283       20.7           264       23.8           282
#> 318             324       21.9           314       31.2            72
#> 319             204       22.9           331       26.6           205
#> 320             244       19.7           215       23.7           283
#> 321             226       22.6           328       25.8           237
#> 322             336       21.4           296       28.3           154
#> 323             318       21.0           282       28.7           142
#> 324             272       21.6           307       26.2           222
#> 325             344       19.0           178       30.0           104
#> 326             288       18.2           135       24.9           246
#> 327             340       21.6           305       32.0            56
#> 328             210       21.4           298       23.0           302
#> 329             261       22.0           316       29.8           110
#> 330             319       20.9           277       24.7           254
#> 331             343       22.5           327       27.2           185
#> 332             323       21.7           309       24.9           248
#> 333             338       20.4           254       30.1           100
#> 334             241       20.0           228       18.4           341
#> 335             316       22.3           322       26.3           218
#> 336              96       19.9           225       20.8           329
#> 337             300       23.1           334       32.6            40
#> 338             242       24.0           345       22.0           319
#> 339             317       21.8           313       30.4            94
#> 340             291       20.9           274       24.8           249
#> 341             236       23.9           342       30.6            86
#> 342             348      100.0           348        0.0           348
#> 343             334       20.3           248       22.0           320
#> 344             302       23.6           339       27.4           181
#> 345             296       19.4           194       21.2           326
#> 346             345       20.7           266       31.9            57
#> 347             294       23.8           341       24.6           257
#> 348             347       21.7           310       16.6           346
#> 349             333       21.1           287       29.1           132
#> 350             314       20.6           261       24.1           274
#> 351             330       23.9           344       26.2           220
#> 352             346       20.8           272       19.2           339
#> 353             327       25.0           347       23.8           279
#> 354             331       21.4           299       28.2           157
#> 355             342       22.3           323       29.5           116
#> 356             348      100.0           348        0.0           348
#> 357             341       24.3           346       18.1           342
#> 358               3       15.3            12       33.6            30
#> 359               1       18.0           109       26.4           225
#> 360               6       15.9            25       23.9           295
#> 361              43       17.6            83       35.1            15
#> 362              82       17.1            60       32.0            52
#> 363              20       17.5            79       32.7            39
#> 364               2       15.5            16       20.6           344
#> 365              24       18.7           166       32.6            41
#> 366              50       17.8            95       34.8            17
#> 367              47       18.1           116       32.8            37
#> 368              14       16.2            32       28.2           166
#> 369              53       17.9           105       32.0            55
#> 370              59       19.1           197       31.1            75
#> 371              86       18.8           176       30.0           113
#> 372              46       16.0            29       25.8           247
#> 373              21       14.9             6       25.2           266
#> 374             188       17.8            97       35.7             8
#> 375             217       16.7            49       31.5            66
#> 376              87       20.6           292       37.0             4
#> 377              40       15.3            11       25.0           273
#> 378             128       16.5            40       29.6           121
#> 379             249       17.8            90       38.7             2
#> 380              11       18.6           158       28.9           145
#> 381             123       18.1           122       30.8            81
#> 382              58       17.3            70       29.4           127
#> 383              29       16.5            42       24.6           285
#> 384              63       17.8            94       31.1            74
#> 385              65       19.8           243       34.1            23
#> 386              91       18.6           159       29.2           133
#> 387             186       16.7            48       31.3            70
#> 388              13       17.3            67       26.9           206
#> 389              68       18.9           187       33.5            31
#> 390             152       17.9            98       35.3            13
#> 391               5       20.5           284       29.3           130
#> 392             121       16.7            47       30.7            85
#> 393             199       18.9           190       32.5            42
#> 394              61       19.2           206       29.9           114
#> 395             235       17.9           102       35.6            11
#> 396              80       17.3            72       26.5           224
#> 397             138       15.4            13       24.1           291
#> 398             132       14.2             3       26.9           207
#> 399             113       16.9            53       28.7           149
#> 400             177       15.7            20       29.2           134
#> 401              37       16.7            50       25.2           263
#> 402              12       15.4            14       25.0           274
#> 403               4       18.4           141       28.2           162
#> 404              77       19.7           237       28.0           172
#> 405             158       18.7           167       29.2           131
#> 406              70       18.2           130       30.7            88
#> 407             261       17.4            73       34.9            16
#> 408             230       19.5           224       34.5            20
#> 409              22       18.6           157       26.3           229
#> 410              30       15.6            17       22.6           321
#> 411             129       19.2           208       30.3           101
#> 412             112       15.9            24       21.5           333
#> 413             100       17.7            88       25.5           258
#> 414             175       17.7            86       35.9             6
#> 415             237       16.0            26       23.3           306
#> 416             140       20.2           263       32.0            54
#> 417              33       18.5           148       30.2           105
#> 418             200       19.7           238       28.6           153
#> 419              73       16.5            41       29.8           116
#> 420              15       15.1             7       19.2           351
#> 421             259       19.9           249       34.1            25
#> 422             191       18.3           135       32.4            44
#> 423              72       17.9           108       27.4           195
#> 424             308       20.7           297       40.1             1
#> 425              97       17.3            71       29.0           137
#> 426              28       18.2           128       31.8            59
#> 427             114       13.9             2       29.0           138
#> 428             116       20.1           255       31.6            64
#> 429             204       17.9           104       32.0            53
#> 430              23       18.5           153       25.8           245
#> 431             169       19.3           217       34.0            26
#> 432             278       19.3           212       33.7            29
#> 433              38       18.1           117       22.5           322
#> 434             309       18.1           119       35.3            12
#> 435              16       16.6            46       23.5           302
#> 436             211       17.2            61       26.0           236
#> 437              45       20.6           290       34.5            21
#> 438              90       17.5            78       32.7            40
#> 439              79       16.3            34       25.2           267
#> 440              17       19.8           240       28.4           159
#> 441             260       19.5           222       29.5           123
#> 442             151       17.4            77       26.9           209
#> 443              41       15.7            21       27.9           173
#> 444              71       19.2           204       31.9            58
#> 445             104       17.8            89       25.5           256
#> 446              25       18.3           133       24.6           282
#> 447              99       18.4           139       32.9            35
#> 448              67       14.7             5       22.4           324
#> 449             182       17.3            68       31.5            65
#> 450              52       17.5            80       25.9           238
#> 451             102       18.5           146       29.5           122
#> 452             197       17.4            76       30.9            80
#> 453             207       20.5           280       30.5            96
#> 454              10       16.0            27       24.7           278
#> 455              78       17.2            63       27.5           187
#> 456              39       22.1           333       30.1           106
#> 457              95       19.7           236       29.0           139
#> 458             206       16.6            44       29.6           120
#> 459             111       17.6            82       27.8           180
#> 460             202       19.8           241       32.2            47
#> 461             323       15.1             9       30.2           102
#> 462              57       18.4           144       30.0           111
#> 463             103       18.3           134       31.3            68
#> 464              19       15.2            10       23.9           294
#> 465             209       17.9           101       26.5           223
#> 466             119       16.2            31       25.8           242
#> 467              89       18.8           174       24.6           284
#> 468             147       18.8           168       34.2            22
#> 469             135       21.3           314       27.4           192
#> 470              76       16.9            57       23.6           298
#> 471             216       18.1           123       32.4            45
#> 472             136       18.9           191       30.9            79
#> 473              18       18.6           160       23.8           296
#> 474             285       17.9           106       31.7            62
#> 475              49       16.4            38       30.4           100
#> 476             187       21.5           320       32.2            48
#> 477              66       17.7            85       27.3           199
#> 478              84       20.2           262       34.1            24
#> 479             218       18.1           118       32.1            51
#> 480               8       18.0           110       24.4           289
#> 481             120       17.8            93       31.0            77
#> 482              60       19.5           226       27.9           174
#> 483             294       16.4            36       30.4            99
#> 484             160       19.4           218       30.5            97
#> 485             117       18.5           150       30.4            98
#> 486             105       16.3            33       22.7           319
#> 487              92       18.3           137       25.5           255
#> 488             293       15.6            18       22.0           329
#> 489             107       16.6            45       31.9            56
#> 490             159       19.7           235       31.9            57
#> 491             148       21.9           328       35.9             7
#> 492             145       15.7            19       27.4           193
#> 493              35       19.1           196       34.8            18
#> 494             101       19.7           234       30.0           110
#> 495             170       17.8            96       27.5           190
#> 496             144       18.4           145       25.4           259
#> 497              56       18.8           178       22.9           313
#> 498             125       18.2           125       26.1           233
#> 499              32       17.9           103       25.2           265
#> 500              27       20.7           298       22.1           328
#> 501              81       18.9           188       27.6           185
#> 502             181       20.4           277       30.6            91
#> 503             268       15.1             8       28.2           163
#> 504             139       14.6             4       21.0           340
#> 505             205       19.0           194       28.9           141
#> 506             241       17.0            59       26.7           214
#> 507             287       20.9           302       31.4            67
#> 508             210       18.3           138       34.7            19
#> 509              31       23.6           349       37.3             3
#> 510             154       20.5           278       26.6           218
#> 511             342       18.4           140       32.8            38
#> 512             149       18.5           149       23.3           307
#> 513             179       18.2           126       33.0            33
#> 514              75       20.4           273       30.2           104
#> 515             221       18.9           183       26.4           226
#> 516               9       19.4           220       21.4           335
#> 517             208       16.5            43       33.0            34
#> 518              96       18.7           163       26.6           219
#> 519             189       19.9           251       28.8           146
#> 520              54       17.3            69       22.7           320
#> 521             122       16.9            54       23.2           308
#> 522             254       20.4           272       31.3            71
#> 523              98       16.9            56       29.4           125
#> 524              26       18.8           170       24.6           281
#> 525             176       19.7           239       26.3           230
#> 526              55       16.9            51       20.1           347
#> 527             156       17.0            58       27.2           202
#> 528             157       22.9           345       29.2           135
#> 529               7       22.7           342       30.1           108
#> 530             274       17.8            91       35.6             9
#> 531             193       18.8           179       25.8           243
#> 532             137       21.4           318       32.1            50
#> 533              62       18.7           164       21.2           338
#> 534             270       21.2           312       29.6           118
#> 535              42       19.9           248       28.9           144
#> 536             163       17.2            62       26.8           211
#> 537             280       16.1            30       26.5           222
#> 538              69       18.1           124       27.4           194
#> 539             330       17.2            64       27.8           179
#> 540             127       19.0           193       24.7           279
#> 541             141       18.3           136       26.0           237
#> 542             196       20.4           274       36.1             5
#> 543             106       18.5           155       26.5           221
#> 544             271       17.7            87       27.5           189
#> 545             229       16.4            37       25.1           272
#> 546              74       19.2           205       23.5           301
#> 547             297       16.0            28       22.3           327
#> 548             184       18.0           113       29.7           117
#> 549             258       16.9            55       22.3           326
#> 550             303       18.2           131       26.3           231
#> 551             108       20.5           279       25.1           270
#> 552             295       19.2           210       25.1           271
#> 553             248       19.1           198       28.6           152
#> 554             266       20.1           256       33.1            32
#> 555             161       17.9            99       24.5           287
#> 556             142       19.3           213       27.9           177
#> 557             339       13.6             1       26.8           212
#> 558             150       18.9           184       26.6           220
#> 559              85       17.9           100       26.7           216
#> 560             311       21.3           316       31.3            69
#> 561             198       19.6           232       30.6            93
#> 562             168       22.2           334       31.8            60
#> 563             152       20.3           269       29.2           136
#> 564             115       19.9           250       27.0           205
#> 565             180       17.3            66       22.8           316
#> 566             110       21.9           329       27.3           197
#> 567             164       22.3           338       30.0           112
#> 568              64       17.8            92       23.4           304
#> 569              94       18.7           165       28.2           161
#> 570              44       19.1           200       25.7           250
#> 571             302       22.2           335       32.4            43
#> 572             133       18.5           151       26.8           210
#> 573             109       21.0           308       30.5            95
#> 574             322       18.1           121       25.9           240
#> 575             167       15.8            22       17.7           352
#> 576             130       21.4           319       29.8           115
#> 577             233       19.5           223       26.9           208
#> 578             315       19.1           203       30.8            82
#> 579             283       18.0           112       30.5            94
#> 580             178       19.3           216       29.4           126
#> 581             256       17.7            84       25.7           249
#> 582             224       18.8           172       28.7           151
#> 583             232       20.8           301       28.9           143
#> 584             301       19.3           211       27.3           200
#> 585             307       19.6           230       25.4           261
#> 586             124       18.8           175       27.3           198
#> 587             236       17.2            65       25.8           246
#> 588             253       18.8           169       28.7           150
#> 589             239       18.8           180       24.8           277
#> 590             231       20.3           267       27.6           186
#> 591             291       20.1           257       26.4           228
#> 592             134       19.5           225       25.5           254
#> 593             201       19.4           219       23.0           311
#> 594             328       21.0           306       31.8            61
#> 595             284       17.6            81       25.5           257
#> 596             174       20.6           288       28.8           147
#> 597             215       19.2           207       27.3           196
#> 598             213       17.4            75       21.4           334
#> 599              36       16.9            52       20.2           346
#> 600              51       16.4            39       23.0           312
#> 601             298       18.0           111       27.6           183
#> 602             247       20.8           300       28.3           160
#> 603             243       19.9           254       28.5           155
#> 604              83       20.6           291       21.5           332
#> 605             155       21.0           307       25.2           264
#> 606             337       18.1           115       30.8            83
#> 607             225       15.5            15       21.2           339
#> 608             166       21.6           322       30.7            84
#> 609             183       19.4           221       20.6           345
#> 610             131       17.4            74       28.2           164
#> 611             317       18.8           182       33.8            28
#> 612             172       21.8           326       30.6            92
#> 613             223       23.0           346       28.8           148
#> 614             252       20.5           286       31.0            78
#> 615             234       18.5           147       25.6           253
#> 616             226       20.4           271       28.9           140
#> 617             262       20.7           294       28.4           156
#> 618             212       18.6           162       27.6           184
#> 619             341       18.5           154       24.5           286
#> 620             126       19.8           244       24.0           293
#> 621             272       20.5           283       27.1           203
#> 622              93       19.0           192       21.6           331
#> 623             306       19.6           231       30.1           109
#> 624             255       20.3           266       31.6            63
#> 625             335       19.1           202       32.2            49
#> 626             165       19.9           253       25.7           248
#> 627             203       20.6           293       22.4           325
#> 628             279       20.6           287       27.7           181
#> 629             146       21.9           327       26.4           227
#> 630             277       19.6           229       23.3           305
#> 631             219       18.4           142       19.9           349
#> 632              48       19.2           209       21.9           330
#> 633             173       18.9           189       21.3           337
#> 634             194       19.8           247       23.7           297
#> 635             344       21.2           313       32.8            36
#> 636              34       24.7           350       30.7            86
#> 637             118       22.5           339       27.7           182
#> 638             314       17.9           107       29.3           129
#> 639             275       20.2           264       27.9           175
#> 640             250       20.2           261       28.9           142
#> 641             319       19.9           252       29.5           124
#> 642             190       19.0           195       24.4           288
#> 643             305       20.8           299       35.2            14
#> 644             263       20.5           285       25.6           252
#> 645             296       18.8           181       29.2           132
#> 646             251       21.4           317       28.0           171
#> 647             246       20.3           270       29.4           128
#> 648             192       20.5           281       25.3           262
#> 649             264       18.5           152       22.8           317
#> 650             214       20.7           295       31.0            76
#> 651             162       20.5           282       26.8           213
#> 652             273       18.0           114       25.1           269
#> 653             228       18.8           173       22.8           318
#> 654             304       18.8           177       24.9           276
#> 655             310       20.1           258       29.6           119
#> 656             185       20.3           265       28.4           157
#> 657             321       23.4           348       35.6            10
#> 658             276       19.1           199       22.8           314
#> 659             320       15.9            23       20.1           348
#> 660             195       19.3           215       20.8           342
#> 661             300       18.4           143       28.2           167
#> 662             171       20.1           259       20.8           341
#> 663             318       20.4           276       30.6            89
#> 664             338       16.4            35       25.1           268
#> 665             312       18.2           127       27.2           201
#> 666             281       18.1           120       27.9           176
#> 667             332       21.6           321       31.2            73
#> 668             336       21.2           311       31.2            72
#> 669             220       19.6           227       22.8           315
#> 670             257       22.0           332       26.7           215
#> 671             222       19.8           246       19.3           350
#> 672             327       20.2           260       24.7           280
#> 673             244       19.6           233       24.2           290
#> 674              88       26.6           353       30.6            90
#> 675             316       21.7           325       25.4           260
#> 676             143       22.8           343       28.4           158
#> 677             240       22.0           331       24.6           283
#> 678             289       20.9           304       30.7            87
#> 679             245       18.6           156       14.2           353
#> 680             290       19.8           245       26.0           234
#> 681             288       19.6           228       25.9           241
#> 682             227       18.6           161       23.0           309
#> 683             238       20.7           296       25.7           251
#> 684             325       22.6           341       33.8            27
#> 685             267       20.3           268       28.1           169
#> 686             347       22.2           336       32.2            46
#> 687             313       22.9           344       28.2           165
#> 688             331       20.9           303       30.1           107
#> 689             265       21.0           309       24.0           292
#> 690             340       18.2           132       26.6           217
#> 691             269       21.6           323       28.1           168
#> 692             286       20.6           289       28.5           154
#> 693             292       19.8           242       27.5           188
#> 694             329       18.9           186       23.0           310
#> 695             299       22.2           337       28.0           170
#> 696             242       19.3           214       22.4           323
#> 697             282       23.3           347       27.8           178
#> 698             333       21.9           330       27.5           191
#> 699             345       20.4           275       23.4           303
#> 700             324       20.9           305       25.9           239
#> 701             348       21.3           315       30.2           103
#> 702             350       18.2           129       23.5           300
#> 703             326       19.1           201       23.6           299
#> 704             343       18.9           185       21.4           336
#> 705             351       18.8           171       24.9           275
#> 706             334       26.5           352       20.6           343
#> 707             346       22.6           340       26.0           235
#> 708             353       21.6           324       25.8           243
#> 709             352       21.1           310       26.2           232
#> 710             349       26.2           351       27.1           204
#>     off_ft_rate off_ft_rate_rk adj_d adj_d_rk def_e_fg_pct def_e_fg_pct_rk
#> 1          35.7             66  89.9       11         47.7              61
#> 2          26.5            295  91.1       22         48.9             121
#> 3          32.0            158  96.7       75         48.8             115
#> 4          37.2             40  97.1       82         48.7             108
#> 5          34.0            106  99.8      124         48.5              99
#> 6          30.0            210  96.0       66         51.0             216
#> 7          31.3            177  89.6        9         43.9               2
#> 8          37.9             30  88.9        7         46.5              29
#> 9          30.4            201  87.9        4         44.4               6
#> 10         26.0            306  95.4       55         50.8             200
#> 11         31.6            167  94.5       46         50.4             189
#> 12         37.9             31  96.3       70         51.0             217
#> 13         29.5            227  91.2       23         47.9              71
#> 14         36.3             59  88.1        6         44.9               7
#> 15         41.8              7  95.7       59         49.2             131
#> 16         32.4            152  92.8       33         46.1              24
#> 17         21.7            343  93.3       36         48.0              77
#> 18         23.4            336  97.0       79         51.3             226
#> 19         28.5            251 102.6      182         48.6             102
#> 20         26.9            290 101.8      164         50.0             174
#> 21         25.9            308 103.7      203         50.8             202
#> 22         28.4            253  96.2       68         52.4             269
#> 23         27.9            268  92.5       30         46.9              38
#> 24         28.3            255  96.9       77         48.0              78
#> 25         25.7            311  92.8       32         47.0              42
#> 26         31.7            163  92.9       34         48.8             116
#> 27         29.0            239  92.5       29         46.7              36
#> 28         33.9            111  92.8       31         46.0              23
#> 29         26.3            297  90.6       15         47.9              68
#> 30         28.8            243  87.8        3         45.8              16
#> 31         28.8            241  97.0       78         51.2             220
#> 32         37.9             32  90.9       18         47.7              60
#> 33         24.6            324  98.2      101         48.3              88
#> 34         27.8            272  95.2       52         53.0             294
#> 35         29.3            233  95.1       51         49.1             127
#> 36         34.9             79  95.7       60         48.6             106
#> 37         31.8            160  94.1       42         48.7             113
#> 38         36.2             62  98.4      103         49.6             147
#> 39         38.0             29 104.6      222         51.2             222
#> 40         29.3            234 100.9      145         50.7             198
#> 41         31.5            172  87.0        2         47.2              45
#> 42         28.6            247  98.9      112         52.6             277
#> 43         32.7            148  89.6       10         47.9              67
#> 44         33.9            110  94.1       41         47.8              64
#> 45         33.2            124  91.1       21         47.5              56
#> 46         31.3            174  98.1       99         52.2             263
#> 47         31.2            178  96.8       76         47.3              52
#> 48         25.9            307  97.9       94         47.6              57
#> 49         37.1             44  95.5       57         48.5             100
#> 50         29.8            222  96.0       65         48.3              91
#> 51         35.7             67  95.9       63         49.4             140
#> 52         34.2             98  91.7       27         49.1             128
#> 53         30.9            186 101.0      148         45.8              18
#> 54         29.8            220  90.2       12         48.0              79
#> 55         28.0            263  91.0       20         45.5              12
#> 56         35.3             76  96.2       69         47.8              66
#> 57         25.8            309 101.1      151         51.5             233
#> 58         25.4            315 101.2      153         47.8              63
#> 59         33.4            121  95.3       53         48.8             118
#> 60         37.6             36  90.7       17         47.1              44
#> 61         38.2             26  97.2       84         47.0              39
#> 62         30.5            199 101.3      156         48.0              75
#> 63         31.1            181  97.4       87         51.3             223
#> 64         27.9            266 102.0      170         49.3             135
#> 65         25.3            319 108.8      299         54.2             318
#> 66         27.9            270 104.4      219         50.1             175
#> 67         24.2            328 100.3      133         49.9             166
#> 68         35.3             75 109.0      301         52.9             287
#> 69         34.1             99  96.0       64         49.2             132
#> 70         41.5              8  94.2       43         48.8             117
#> 71         32.9            138 100.6      136         52.1             258
#> 72         38.9             18  99.9      125         48.4              96
#> 73         30.7            193 101.5      159         48.6             104
#> 74         39.4             17 105.4      240         51.7             241
#> 75         33.3            123  98.5      106         52.5             274
#> 76         36.7             50  95.4       56         49.7             160
#> 77         33.7            114  98.6      109         48.5              97
#> 78         28.2            259 108.3      293         55.4             335
#> 79         31.8            161  99.3      120         50.0             170
#> 80         34.5             88  96.6       73         45.1               9
#> 81         36.9             47  99.5      122         50.0             171
#> 82         27.1            281  90.6       16         47.3              49
#> 83         32.8            140  96.6       72         48.9             119
#> 84         34.5             90  93.1       35         46.7              33
#> 85         34.4             92  88.1        5         46.3              27
#> 86         34.4             93  99.2      118         52.5             273
#> 87         30.8            190  95.0       49         48.9             123
#> 88         28.8            242 106.7      269         50.5             190
#> 89         41.3              9  99.0      114         50.8             203
#> 90         30.6            196  98.5      104         47.5              54
#> 91         36.8             48 102.7      185         49.9             165
#> 92         32.1            157  94.2       44         48.4              95
#> 93         33.7            115  95.3       54         47.1              43
#> 94         35.0             78  97.1       83         47.7              58
#> 95         29.8            222  96.1       67         46.3              25
#> 96         31.6            168  96.6       74         48.6             103
#> 97         33.1            129 106.6      267         49.5             144
#> 98         31.3            176  94.2       45         48.1              82
#> 99          0.0            348 102.1      172        100.0             348
#> 100        21.4            344  98.0       96         49.8             162
#> 101        27.0            286  95.0       48         46.4              28
#> 102        35.5             70  98.0       97         49.4             138
#> 103        30.7            194  97.9       95         49.3             136
#> 104        27.3            278 105.8      248         50.1             177
#> 105        23.7            333 105.9      252         50.9             204
#> 106        24.3            325 102.0      171         52.0             254
#> 107        23.2            337  90.9       19         48.7             109
#> 108        24.8            322 102.8      186         50.2             179
#> 109        34.2             96  91.4       25         48.4              94
#> 110        36.5             54  92.2       28         48.3              87
#> 111        25.5            314 105.3      234         51.8             247
#> 112        33.2            128 108.4      295         51.1             218
#> 113        28.1            262  99.5      121         49.6             149
#> 114        25.4            316 109.9      315         57.4             342
#> 115        32.6            149 104.8      226         48.8             114
#> 116        27.9            269 101.9      168         51.0             210
#> 117        32.7            145  86.4        1         44.4               5
#> 118        33.0            137 102.2      177         47.0              40
#> 119        34.0            104  99.0      115         53.0             289
#> 120        34.2             95 100.0      128         50.9             207
#> 121        33.4            120  97.1       81         45.5              11
#> 122        34.0            103  90.2       14         45.8              19
#> 123        29.7            225 103.6      200         55.5             337
#> 124        35.6             69  96.5       71         49.1             126
#> 125        30.9            187 104.5      220         48.1              84
#> 126        29.2            236  89.5        8         45.6              14
#> 127        38.9             20  97.5       89         47.8              65
#> 128        32.4            153 101.9      166         50.8             199
#> 129        26.9            288 101.4      158         50.6             194
#> 130        30.0            212 105.6      246         48.6             107
#> 131        36.9             46 110.6      321         51.6             238
#> 132        26.8            292  93.4       37         50.2             178
#> 133        34.8             81  93.7       39         46.3              26
#> 134        31.0            184 102.7      184         49.5             142
#> 135        26.2            299 100.4      134         51.2             221
#> 136        33.5            119 109.1      305         52.8             285
#> 137        29.4            230 109.0      302         54.8             329
#> 138         0.0            348 103.9      209        100.0             348
#> 139        27.9            265  98.9      113         53.2             299
#> 140        33.2            125 109.2      306         55.4             334
#> 141        26.2            298 106.2      261         51.8             245
#> 142        27.8            274 108.0      286         51.7             244
#> 143        21.4            345 104.4      217         51.9             250
#> 144        33.6            117 100.9      143         49.9             168
#> 145        33.0            135 103.7      201         52.4             271
#> 146        23.7            332  95.8       62         48.2              86
#> 147        22.0            342  95.6       58         45.8              17
#> 148        33.0            136  97.5       90         49.6             146
#> 149        22.6            341 101.7      162         51.1             219
#> 150        26.8            291  98.1       98         51.6             239
#> 151        40.9             11 104.2      210         49.6             152
#> 152        44.0              1 102.2      174         50.9             205
#> 153        29.9            215  95.0       50         47.0              41
#> 154        28.7            244 101.9      167         48.9             122
#> 155        26.5            296 103.0      190         52.9             286
#> 156        29.9            214 100.2      131         49.7             159
#> 157        31.0            182 108.4      294         49.7             154
#> 158        26.1            303 103.5      195         49.7             155
#> 159        29.8            221  99.2      117         50.4             188
#> 160        33.9            108 104.7      223         46.8              37
#> 161        28.1            261 102.3      178         51.9             249
#> 162        33.8            112 107.6      281         52.0             257
#> 163        30.3            203 112.0      335         50.9             208
#> 164        29.4            229  97.4       86         53.0             295
#> 165        33.1            130  97.5       91         48.5              98
#> 166        36.3             57  97.3       85         51.5             234
#> 167        34.7             82  91.3       24         46.6              32
#> 168        31.5            173 110.3      318         55.6             339
#> 169        27.3            278 110.6      324         53.5             307
#> 170        27.1            284 108.6      297         52.0             256
#> 171        31.6            165 109.5      310         54.3             320
#> 172        32.8            141  99.1      116         52.5             275
#> 173        37.1             43 109.5      309         51.6             237
#> 174        30.1            207 103.1      192         49.7             157
#> 175        34.0            107  98.9      111         53.1             298
#> 176        25.4            317 114.2      352         50.3             182
#> 177         0.0            348 103.2      194        100.0             348
#> 178        27.7            276  90.2       13         47.7              62
#> 179        31.0            185  94.1       40         49.8             163
#> 180        33.2            126 106.9      271         52.6             281
#> 181        24.3            326 105.6      245         52.1             259
#> 182        20.8            346 108.0      289         54.5             324
#> 183        31.6            166  97.0       80         47.3              46
#> 184        32.7            143  91.6       26         46.0              22
#> 185        30.3            202 103.9      208         50.1             176
#> 186        31.7            164 110.4      320         54.3             321
#> 187        36.1             63 107.8      285         51.0             214
#> 188        35.6             68 109.6      313         54.9             331
#> 189        38.9             19  98.8      110         47.3              48
#> 190         0.0            348 106.5      266        100.0             348
#> 191        28.5            250 101.9      169         54.5             323
#> 192        29.1            238  93.4       38         45.6              13
#> 193        30.0            212 102.3      179         48.5             101
#> 194        26.7            294 105.1      230         53.6             308
#> 195        29.3            232  98.4      102         50.3             186
#> 196        31.3            175  99.9      126         50.0             171
#> 197        25.6            312 101.5      160         51.0             212
#> 198        36.5             53 107.7      282         51.5             236
#> 199        30.7            191 113.4      347         52.7             282
#> 200        34.5             87 101.0      147         51.7             242
#> 201        28.0            264 106.5      265         50.3             183
#> 202        31.1            180 113.1      345         53.0             293
#> 203        36.6             52 100.8      139         46.5              30
#> 204        30.2            204 107.8      283         49.7             161
#> 205        36.2             60  97.4       88         47.3              51
#> 206        32.5            150 100.7      138         49.1             125
#> 207        43.5              3 104.3      215         48.7             112
#> 208        39.9             16  98.5      105         47.4              53
#> 209        27.8            273 103.7      204         49.2             133
#> 210        28.6            246 109.3      307         53.6             309
#> 211        30.1            209 104.2      214         48.4              93
#> 212        28.1            260 106.8      270         52.4             267
#> 213        19.6            347 100.4      135         52.0             252
#> 214        30.2            205 111.2      329         52.5             272
#> 215        36.2             61 111.3      330         54.0             314
#> 216         0.0            348 105.3      236        100.0             348
#> 217        34.5             91 101.0      146         46.0              20
#> 218        37.5             37 105.7      247         48.0              80
#> 219        29.8            224 102.8      188         53.1             296
#> 220        32.2            156 106.9      272         54.1             317
#> 221        38.5             24 104.2      212         46.7              35
#> 222        34.6             85 107.5      280         49.5             141
#> 223        37.2             41 106.1      259         48.4              92
#> 224        37.2             38 101.8      163         46.0              21
#> 225        36.6             51  97.8       93         49.7             158
#> 226        27.9            267  98.1      100         53.0             292
#> 227        36.8             49 102.2      176         51.3             225
#> 228        27.1            283 100.8      141         49.7             153
#> 229        29.0            240 113.7      350         53.3             303
#> 230        40.3             14 103.6      198         49.7             156
#> 231        33.8            113 100.2      130         46.5              31
#> 232        33.1            133  98.6      107         48.9             120
#> 233        34.6             83 107.0      276         49.6             145
#> 234        37.1             45 103.6      199         47.5              55
#> 235        31.6            170 107.0      273         50.5             192
#> 236        33.4            122 111.4      332         52.6             279
#> 237        38.2             27 105.1      229         48.6             105
#> 238        32.3            155 105.1      231         49.2             130
#> 239        35.9             64 101.2      154         49.6             151
#> 240        23.7            334 102.3      180         51.6             240
#> 241        28.4            252 103.5      197         50.5             191
#> 242        26.1            304  98.6      108         48.3              90
#> 243        37.7             34 105.3      235         50.7             197
#> 244        30.4            200 112.7      344         58.2             344
#> 245        32.7            144 103.1      191         50.0             169
#> 246        26.2            300 106.1      260         50.0             173
#> 247        37.1             42 112.2      337         53.5             305
#> 248        33.6            118 113.5      348         50.7             195
#> 249        26.1            302 110.6      323         54.6             325
#> 250        29.4            231 101.6      161         52.4             270
#> 251        31.6            169 105.4      237         51.8             246
#> 252        36.5             55 109.4      308         54.4             322
#> 253        36.4             56 102.3      181         53.0             290
#> 254        34.6             84 108.1      291         53.2             301
#> 255        40.2             15 104.8      225         49.9             167
#> 256        37.7             35 104.7      224         49.4             139
#> 257        23.7            335  94.8       47         48.0              73
#> 258        32.4            154 113.8      351         53.9             311
#> 259        25.6            313 100.7      137         53.3             302
#> 260        33.1            132 108.1      290         51.4             229
#> 261        37.2             39 103.8      206         50.9             206
#> 262        36.3             58 108.0      288         49.6             148
#> 263        34.1            101 104.2      211         51.3             228
#> 264        24.0            329 109.1      304         53.9             312
#> 265        26.1            305 109.8      314         52.6             276
#> 266        23.2            338 112.5      340         51.5             235
#> 267        33.9            109 111.8      334         58.9             346
#> 268        26.9            287 108.5      296         58.7             345
#> 269        38.8             21 103.1      193         48.1              83
#> 270        38.1             28 105.9      256         52.1             261
#> 271        28.6            249 100.0      127         47.7              59
#> 272        35.4             73 101.8      165         49.3             137
#> 273        30.1            208 110.9      327         53.5             306
#> 274        23.2            339 100.9      142         49.6             150
#> 275        26.1            301  99.5      123         50.3             184
#> 276        27.1            282 106.0      257         52.8             284
#> 277        26.8            293 106.2      262         50.2             181
#> 278        30.5            197 100.2      129         52.3             265
#> 279        30.5            198 105.5      243         52.7             283
#> 280        38.3             25 107.3      277         52.4             268
#> 281        27.0            285 109.9      316         54.8             330
#> 282        32.8            142 105.8      249         49.5             143
#> 283        30.7            192 114.5      353         54.7             328
#> 284        35.8             65 106.7      268         52.0             253
#> 285        30.0            211 112.3      338         52.6             278
#> 286        25.7            310 108.7      298         51.9             248
#> 287        40.5             12 105.5      242         51.9             251
#> 288         0.0            348 102.9      189        100.0             348
#> 289        28.6            248 110.6      322         49.2             134
#> 290        34.1            102 107.8      284         49.1             129
#> 291        32.0            159 107.3      278         51.0             211
#> 292         0.0            348 105.5      244        100.0             348
#> 293        29.8            217 109.5      312         53.7             310
#> 294        24.2            327 105.2      233         50.2             180
#> 295        33.0            134 101.3      157         48.3              89
#> 296        33.7            116 108.0      287         51.4             230
#> 297        28.3            257 105.2      232         51.3             227
#> 298         0.0            348 105.9      255        100.0             348
#> 299        26.9            289 101.2      152         47.3              50
#> 300        29.2            235 107.0      275         53.5             304
#> 301        29.8            218 101.1      150         45.4              10
#> 302        30.9            188 110.9      326         57.4             343
#> 303        34.2             97 106.2      263         52.3             266
#> 304        34.1            100 112.6      341         55.8             340
#> 305        29.1            237 104.2      213         51.0             213
#> 306        38.7             22 102.2      175         48.0              76
#> 307        34.3             94 105.5      241         51.4             231
#> 308        32.5            151 112.7      342         52.1             260
#> 309        24.0            330 104.4      218         48.7             110
#> 310        31.2            179 103.7      205         49.9             164
#> 311        34.5             89 109.5      311         51.0             215
#> 312        23.9            331 111.2      328         54.7             327
#> 313        25.1            320 105.4      239         50.4             187
#> 314        34.6             86 100.3      132         50.8             201
#> 315        22.8            340 104.5      221         48.0              81
#> 316        30.8            189 105.9      254         52.3             264
#> 317        28.7            245 101.1      149         50.3             185
#> 318        41.0             10 110.8      325         55.2             333
#> 319        33.2            127 107.4      279         52.6             280
#> 320        28.4            254 112.0      336         53.9             313
#> 321        28.2            258 111.4      331         54.1             315
#> 322        33.1            131 105.0      228         51.3             224
#> 323        28.3            256 113.3      346         57.3             341
#> 324        41.8              6 106.3      264         46.7              34
#> 325        37.7             33 102.8      187         48.1              85
#> 326        27.9            271 109.0      303         53.2             300
#> 327        32.9            139 103.5      196         53.1             297
#> 328        31.5            171 101.3      155         45.7              15
#> 329        40.5             13 104.3      216         47.3              47
#> 330        35.4             72 107.0      274         52.0             255
#> 331        38.6             23 114.7      354         54.1             316
#> 332        24.9            321 103.9      207         53.0             291
#> 333        34.0            105 110.2      317         55.4             336
#> 334        43.8              2 102.6      183         47.9              72
#> 335        29.8            219 115.4      355         54.7             326
#> 336        31.0            183 102.1      173         48.0              74
#> 337        35.2             77 106.1      258         52.9             288
#> 338        29.6            226 113.6      349         54.3             319
#> 339        32.7            146  95.8       61         44.9               8
#> 340        32.7            147 104.9      227         50.9             209
#> 341        29.8            216 100.9      144         47.9              69
#> 342         0.0            348 112.7      343        100.0             348
#> 343        29.5            228 105.9      253         50.6             193
#> 344        30.1            206 108.3      292         50.7             196
#> 345        35.4             74 100.8      140         44.2               4
#> 346        35.5             71 103.7      202         47.9              70
#> 347        34.8             80 108.8      300         51.7             243
#> 348        25.4            318 118.1      356         60.1             347
#> 349        42.0              5  97.7       92         43.8               1
#> 350        30.6            195 105.4      238         52.2             262
#> 351        27.8            275 112.4      339         55.6             338
#> 352        27.5            277  99.3      119         51.4             232
#> 353        27.2            280 105.9      251         48.7             111
#> 354        31.8            162 105.8      250         44.0               3
#> 355        42.7              4 110.3      319         48.9             124
#> 356         0.0            348 111.5      333        100.0             348
#> 357        24.7            323 120.7      357         54.9             332
#> 358        38.8             43  94.4       43         47.6              88
#> 359        33.9            143  94.1       38         46.6              53
#> 360        28.8            274  97.3       78         48.4             122
#> 361        35.4            102 102.4      179         49.4             172
#> 362        34.4            128  98.6       97         49.4             171
#> 363        28.9            272  97.1       76         47.3              79
#> 364        23.4            343  95.6       60         49.0             143
#> 365        35.8             89  85.5        2         43.7               4
#> 366        35.6             99  91.1       12         45.7              26
#> 367        30.8            226  91.2       13         43.3               3
#> 368        28.3            284  90.6       10         45.3              18
#> 369        32.2            193  93.1       30         45.1              14
#> 370        36.7             73  92.0       19         46.2              35
#> 371        39.2             37  96.9       73         46.8              57
#> 372        26.9            309  94.0       36         48.2             114
#> 373        30.8            229  98.5       96         50.8             243
#> 374        30.8            228  88.1        4         45.2              15
#> 375        37.7             54  92.4       22         46.1              34
#> 376        39.5             34  99.8      119         48.1             107
#> 377        26.7            313  93.0       28         46.9              62
#> 378        35.7             93  99.6      116         48.3             116
#> 379        32.9            169  92.3       21         43.9               5
#> 380        27.6            295  99.3      108         48.5             123
#> 381        40.8             18  95.1       52         45.3              19
#> 382        29.4            254  94.2       42         45.8              27
#> 383        31.5            207 101.9      163         49.3             165
#> 384        34.0            139  95.7       61         47.9             102
#> 385        31.7            204 103.8      202         49.2             157
#> 386        34.8            117  92.7       25         45.7              23
#> 387        27.5            296  94.2       41         45.6              22
#> 388        28.6            279 111.6      324         50.3             223
#> 389        30.1            242  91.5       15         47.0              67
#> 390        43.8              4  95.5       55         47.1              70
#> 391        29.4            258 101.2      146         49.8             195
#> 392        36.7             76  91.4       14         45.3              17
#> 393        33.9            141 100.2      125         50.8             241
#> 394        36.8             69  99.5      114         47.9              99
#> 395        32.2            191  93.7       35         47.0              66
#> 396        38.8             42 102.0      165         49.4             169
#> 397        26.9            307  91.9       17         46.4              48
#> 398        25.0            334  98.6      100         47.5              85
#> 399        28.5            282  97.3       79         47.8              97
#> 400        31.0            221  92.4       23         46.4              42
#> 401        28.3            285 101.0      141         46.9              64
#> 402        25.3            332 100.1      122         48.5             126
#> 403        32.3            188 105.3      241         48.1             108
#> 404        34.5            127  90.5        9         46.2              37
#> 405        28.5            281 101.2      147         51.8             282
#> 406        36.3             77  94.6       48         46.4              45
#> 407        25.8            323  90.8       11         47.1              69
#> 408        37.6             56  99.4      112         50.9             248
#> 409        39.2             38 102.1      172         51.6             271
#> 410        27.8            293  95.3       54         47.7              92
#> 411        36.2             82  93.4       32         46.9              63
#> 412        42.5              5  95.5       57         47.3              78
#> 413        39.6             32 103.3      196         50.2             219
#> 414        30.8            227 108.8      306         52.9             313
#> 415        31.2            214  93.1       29         46.7              55
#> 416        39.6             33  94.7       51         45.7              25
#> 417        29.3            261  98.2       90         47.2              73
#> 418        41.0             15 102.0      166         49.7             191
#> 419        34.3            132 102.6      187         50.4             226
#> 420        40.8             20 108.9      307         52.2             289
#> 421        34.6            125  95.6       59         46.4              44
#> 422        39.2             36  92.7       26         47.9             101
#> 423        35.5            101  98.9      103         45.9              29
#> 424        40.5             23  87.1        3         44.5               8
#> 425        29.4            256  98.2       88         50.2             221
#> 426        36.9             68  96.0       65         49.8             194
#> 427        28.2            287 104.9      231         51.6             276
#> 428        33.6            151 100.8      136         50.7             237
#> 429        29.1            264  90.2        6         45.1              13
#> 430        31.2            215  96.4       67         46.5              49
#> 431        34.1            138 100.6      133         49.2             159
#> 432        35.9             88  92.8       27         47.4              83
#> 433        35.0            112 110.3      316         56.2             349
#> 434        33.5            154  98.4       94         49.1             148
#> 435        31.6            206  98.1       85         50.7             238
#> 436        28.1            288 101.3      149         50.2             220
#> 437        31.9            202  99.4      113         49.6             181
#> 438        32.6            175 107.9      290         50.9             246
#> 439        30.4            237 113.3      336         54.7             340
#> 440        38.4             47 106.3      263         50.5             231
#> 441        35.2            108  94.5       46         46.7              56
#> 442        33.0            166 104.4      217         52.8             311
#> 443        24.8            336 102.5      182         49.8             196
#> 444        36.3             80 105.1      236         48.4             121
#> 445        36.0             84  97.6       81         51.1             256
#> 446        27.8            292 105.5      243         52.3             293
#> 447        37.3             62 107.0      275         53.1             318
#> 448        33.3            162 101.2      148         49.2             160
#> 449        32.2            192 100.7      134         46.4              47
#> 450        29.2            263 104.8      225         51.1             255
#> 451        32.8            170  99.0      104         48.0             105
#> 452        27.2            303 102.2      174         49.3             161
#> 453        37.2             65  95.8       62         45.9              30
#> 454        22.9            346 100.5      132         47.8              95
#> 455        31.3            212  96.4       68         44.8              11
#> 456        45.3              2 102.5      184         49.0             144
#> 457        35.8             90 100.8      135         50.3             222
#> 458        35.2            107  98.3       93         46.9              60
#> 459        36.7             74 105.1      237         48.7             130
#> 460        30.9            225  92.2       20         46.4              41
#> 461        29.9            246  95.2       53         48.2             113
#> 462        28.9            271 102.1      167         48.0             103
#> 463        37.2             66 105.3      242         51.0             251
#> 464        32.0            201  96.4       69         45.6              20
#> 465        32.4            184  94.7       49         49.1             152
#> 466        31.6            205 110.5      319         51.4             261
#> 467        34.4            130 108.4      301         52.9             314
#> 468        39.8             29  94.4       44         46.2              36
#> 469        37.9             52  93.1       31         44.1               6
#> 470        32.3            189 101.2      145         50.6             234
#> 471        34.9            116 104.8      226         48.7             136
#> 472        31.3            213 101.4      156         46.9              59
#> 473        32.3            187 106.4      265         49.8             199
#> 474        33.7            145  90.4        8         44.4               7
#> 475        32.5            178 106.8      272         50.1             218
#> 476        27.1            304  96.1       66         49.3             163
#> 477        29.6            252 101.1      142         49.1             151
#> 478        28.0            290  99.3      109         44.9              12
#> 479        36.8             70  94.7       50         45.2              16
#> 480        25.6            329 103.2      192         51.7             278
#> 481        35.3            105 108.1      295         47.6              89
#> 482        37.2             63 102.4      178         52.7             306
#> 483        37.1             67  94.2       39         47.4              80
#> 484        29.5            253 104.1      214         49.7             190
#> 485        32.5            180 122.9      353         58.4             353
#> 486        32.3            186 104.9      229         49.1             150
#> 487        40.6             21 103.9      209         51.5             264
#> 488        25.8            322 101.3      150         49.2             156
#> 489        37.8             53 101.4      157         46.6              51
#> 490        28.8            276 100.2      124         49.6             183
#> 491        34.7            124 106.2      261         50.0             207
#> 492        41.0             16 116.7      345         53.6             326
#> 493        36.3             79 102.1      169         50.7             235
#> 494        32.6            176  99.0      105         47.3              77
#> 495        33.0            167  94.4       45         48.1             111
#> 496        41.4              9 104.5      221         52.7             305
#> 497        31.8            203 109.4      311         54.1             336
#> 498        26.8            312 102.5      181         51.8             281
#> 499        25.7            328 103.4      197         51.5             268
#> 500        31.0            220  90.3        7         45.6              21
#> 501        38.2             48 113.6      337         53.3             320
#> 502        35.4            104  92.0       18         44.6               9
#> 503        28.1            289 104.0      210         48.9             139
#> 504        22.9            347  98.0       82         48.5             125
#> 505        48.1              1 107.5      284         52.0             285
#> 506        26.4            317 108.0      293         52.2             288
#> 507        35.7             91  96.7       71         46.3              39
#> 508        27.4            298 102.3      175         48.9             140
#> 509        44.0              3  97.1       75         49.6             184
#> 510        22.0            350  92.6       24         46.9              61
#> 511        35.1            110  98.3       91         49.8             192
#> 512        28.9            270  93.5       33         48.3             118
#> 513        34.0            140  99.1      107         48.1             112
#> 514        29.3            259 102.1      170         47.9              98
#> 515        36.8             71  97.0       74         47.6              90
#> 516        38.9             40  96.8       72         52.2             291
#> 517        24.9            335  95.5       58         50.0             204
#> 518        29.6            251 103.3      195         49.1             147
#> 519        30.9            224  98.6       98         47.8              96
#> 520        24.6            337 100.8      137         47.6              86
#> 521        37.5             57 112.1      327         51.0             249
#> 522        33.3            159  95.5       56         48.8             138
#> 523        27.3            301 102.6      186         49.7             185
#> 524        30.6            233 105.5      244         49.5             177
#> 525        39.8             30  93.6       34         46.7              54
#> 526        26.1            319 100.1      123         48.7             135
#> 527        27.6            294 107.7      286         52.6             300
#> 528        34.8            119  91.8       16         44.7              10
#> 529        35.7             96 112.3      330         51.6             270
#> 530        30.0            245 108.5      303         50.1             213
#> 531        29.9            247 102.5      185         51.0             250
#> 532        38.0             49 122.3      352         58.1             352
#> 533        35.9             87 101.3      154         48.7             131
#> 534        34.7            123  94.2       40         49.6             180
#> 535        40.1             26  99.3      110         46.4              46
#> 536        31.3            211 106.7      269         53.5             324
#> 537        29.0            269  98.4       95         46.9              58
#> 538        34.8            121 106.7      270         49.4             167
#> 539        30.7            230  98.0       83         49.9             202
#> 540        36.7             75 107.7      287         52.4             297
#> 541        36.2             81  98.8      102         49.5             175
#> 542        34.8            120 104.8      227         47.6              87
#> 543        29.8            248 112.4      331         52.5             299
#> 544        33.7            149 106.4      264         54.5             338
#> 545        26.9            306 107.0      276         51.9             284
#> 546        30.4            238 101.3      155         50.1             210
#> 547        29.0            268 101.3      152         51.5             266
#> 548        33.4            156  99.8      120         46.5              50
#> 549        34.2            134 103.1      191         52.7             308
#> 550        29.1            265 110.2      315         52.7             309
#> 551        33.7            146 106.1      260         49.4             168
#> 552        36.0             83 100.4      130         49.9             200
#> 553        35.0            113 106.2      262         51.6             272
#> 554        34.4            129 101.3      153         49.6             179
#> 555        26.8            310 110.3      317         53.1             317
#> 556        28.6            280  99.1      106         46.3              40
#> 557        34.8            118 105.5      247         48.7             132
#> 558        28.7            277 108.0      292         51.6             273
#> 559        28.6            278 104.0      212         49.7             188
#> 560        41.1             14  97.2       77         49.2             154
#> 561        40.8             17 102.1      171         49.1             153
#> 562        35.1            111 102.1      173         49.3             164
#> 563        35.7             92 111.1      321         53.8             329
#> 564        28.2            286 108.3      300         48.8             137
#> 565        28.0            291 110.0      313         52.6             301
#> 566        34.8            122 104.0      211         51.8             283
#> 567        39.9             27  89.1        5         41.2               1
#> 568        23.8            341 105.5      246         48.9             142
#> 569        26.0            320 103.8      205         50.4             227
#> 570        42.5              6 109.1      309         50.9             244
#> 571        37.5             58  95.9       63         51.0             252
#> 572        21.8            352 108.1      296         50.8             239
#> 573        26.5            316 102.7      188         49.6             182
#> 574        33.3            161  94.6       47         46.4              43
#> 575        24.4            340 111.6      325         52.8             310
#> 576        28.8            273 106.7      271         50.1             212
#> 577        41.2             11 100.2      127         49.8             198
#> 578        32.1            199 111.7      326         53.1             316
#> 579        27.4            299 100.8      138         47.2              75
#> 580        25.8            324 101.5      158         49.8             197
#> 581        22.5            349 116.9      346         53.3             321
#> 582        26.9            308 101.3      151         50.5             230
#> 583        33.1            165 100.4      129         48.5             124
#> 584        36.8             72 104.0      213         50.1             211
#> 585        29.1            266 100.3      128         50.5             232
#> 586        32.1            197 103.7      200         50.5             229
#> 587        37.2             64 111.6      323         52.7             307
#> 588        32.2            195 115.6      344         54.4             337
#> 589        35.4            103 105.7      251         50.1             216
#> 590        40.3             25 114.8      342         56.1             348
#> 591        26.6            314  85.1        1         43.1               2
#> 592        30.9            223  94.0       37         45.7              24
#> 593        32.8            171 105.8      253         50.1             215
#> 594        41.1             12 108.6      304         50.3             224
#> 595        35.6            100 101.8      162         49.5             173
#> 596        41.1             13 100.2      126         50.4             225
#> 597        35.9             86  98.1       86         45.8              28
#> 598        26.5            315 107.9      291         52.2             290
#> 599        25.7            326 107.4      281         51.6             277
#> 600        35.2            106 110.3      318         56.9             350
#> 601        35.1            109 106.0      256         53.1             319
#> 602        34.9            115 112.6      332         55.7             346
#> 603        37.4             60 105.0      233         49.3             166
#> 604        38.0             50  98.0       84         50.4             228
#> 605        25.2            333 102.9      190         51.5             269
#> 606        28.8            275  98.3       92         48.1             110
#> 607        21.7            353 115.0      343         55.7             345
#> 608        33.9            142 107.1      278         48.1             109
#> 609        33.6            150  98.6       99         49.1             149
#> 610        29.4            255 104.5      220         49.1             145
#> 611        32.1            198 106.0      258         50.7             236
#> 612        39.1             39 108.3      299         50.8             242
#> 613        39.9             28 107.6      285         52.4             296
#> 614        31.0            219 103.8      206         47.0              68
#> 615        33.7            147 105.7      252         49.7             186
#> 616        30.2            241 105.7      249         51.8             280
#> 617        33.3            158  99.4      111         46.3              38
#> 618        32.2            194 101.0      140         49.2             155
#> 619        34.1            136 107.8      289         54.1             335
#> 620        30.3            240 103.6      199         49.5             176
#> 621        30.6            232 108.2      298         54.7             339
#> 622        33.4            157 106.1      259         50.0             208
#> 623        29.6            250 113.9      339         54.0             334
#> 624        34.5            126 104.8      224         48.7             133
#> 625        32.1            196  98.2       87         48.0             106
#> 626        26.1            318 108.8      305         52.5             298
#> 627        38.4             46 101.6      159         48.3             115
#> 628        31.1            216 111.3      322         51.4             263
#> 629        35.7             94 114.4      341         53.8             328
#> 630        33.0            168  98.2       89         47.4              82
#> 631        32.4            185 107.4      280         52.8             312
#> 632        25.3            331 105.3      239         49.8             193
#> 633        27.4            300  99.9      121         49.2             158
#> 634        34.1            137 104.2      215         47.8              93
#> 635        32.4            183 101.1      143         49.7             189
#> 636        32.0            200 104.6      222         47.0              65
#> 637        29.4            257  99.5      115         46.1              33
#> 638        32.6            174 107.5      283         50.0             205
#> 639        40.5             24 100.5      131         47.8              94
#> 640        34.9            114 102.5      180         50.9             247
#> 641        29.2            262 106.6      268         52.3             294
#> 642        28.4            283 102.9      189         51.5             265
#> 643        30.7            231 104.9      228         50.9             245
#> 644        32.2            190 103.7      201         48.3             117
#> 645        30.4            236 104.9      232         50.8             240
#> 646        39.7             31 105.6      248         50.0             203
#> 647        30.1            243 102.5      183         46.6              52
#> 648        24.6            338 117.3      348         55.9             347
#> 649        37.6             55 104.5      218         50.1             214
#> 650        29.1            267 105.5      245         52.1             287
#> 651        27.5            297  99.8      118         47.2              71
#> 652        34.2            133 110.8      320         53.5             323
#> 653        25.3            330 109.1      308         52.6             302
#> 654        32.5            179 104.9      230         51.7             279
#> 655        37.4             61 105.8      254         48.3             119
#> 656        24.5            339 103.8      204         53.5             325
#> 657        38.0             51  97.3       80         46.1              32
#> 658        33.7            148 108.5      302         52.6             303
#> 659        22.5            348 106.5      267         52.3             295
#> 660        36.3             78 106.8      274         52.0             286
#> 661        25.8            325 102.1      168         47.2              72
#> 662        30.9            222 112.2      328         54.9             342
#> 663        39.3             35 113.2      335         52.6             304
#> 664        31.1            218 105.8      255         50.6             233
#> 665        27.2            302 106.5      266         49.5             174
#> 666        31.5            208 108.1      294         49.7             187
#> 667        40.5             22 113.6      338         55.6             344
#> 668        38.7             44 107.3      279         51.4             262
#> 669        30.3            239 101.1      144         46.0              31
#> 670        23.5            342 103.8      207         51.3             260
#> 671        33.5            152 104.3      216         51.6             274
#> 672        31.4            210  99.8      117         50.1             209
#> 673        33.7            144 103.9      208         49.4             170
#> 674        33.4            155 106.0      257         48.7             134
#> 675        42.4              7  96.6       70         49.5             178
#> 676        35.6             98 103.2      193         47.9             100
#> 677        33.2            163 105.3      238         52.2             292
#> 678        33.3            160 101.9      164         47.2              76
#> 679        30.5            235 100.9      139         50.1             217
#> 680        33.5            153 117.2      347         54.0             333
#> 681        34.3            131 113.0      334         54.7             341
#> 682        25.9            321  98.8      101         48.0             104
#> 683        33.1            164 119.7      350         53.9             330
#> 684        40.8             19 107.5      282         47.4              81
#> 685        38.8             41 105.1      235         48.5             127
#> 686        38.7             45 105.7      250         50.0             206
#> 687        26.8            311 106.8      273         49.9             201
#> 688        34.1            135 101.6      160         47.5              84
#> 689        30.5            234 107.1      277         51.6             275
#> 690        35.6             97 102.3      176         48.6             129
#> 691        21.9            351 109.3      310         53.9             331
#> 692        41.4             10 102.4      177         47.7              91
#> 693        30.1            244 110.0      314         51.2             257
#> 694        32.4            182 104.5      219         51.0             254
#> 695        31.4            209 109.6      312         53.7             327
#> 696        32.6            177 105.1      234         51.5             267
#> 697        23.0            344 103.3      194         49.1             146
#> 698        31.1            217 112.8      333         53.0             315
#> 699        29.3            260 114.0      340         53.4             322
#> 700        29.7            249 103.8      203         49.3             162
#> 701        35.9             85 101.6      161         48.3             120
#> 702        22.9            345 117.6      349         54.0             332
#> 703        32.7            172 105.3      240         48.6             128
#> 704        27.0            305  95.9       64         47.2              74
#> 705        32.7            173 108.2      297         51.3             259
#> 706        42.2              8 120.8      351         57.6             351
#> 707        35.7             95 103.4      198         51.3             258
#> 708        32.5            181 112.2      329         55.3             343
#> 709        25.7            327 107.8      288         51.0             253
#> 710        37.4             59 104.6      223         48.9             141
#>     def_to_pct def_to_pct_rk def_or_pct def_or_pct_rk def_ft_rate
#> 1         19.3           137       23.8            31        25.7
#> 2         24.4             4       30.6           274        31.3
#> 3         16.1           314       29.1           220        22.2
#> 4         14.7           337       27.0           141        33.5
#> 5         17.9           231       32.1           312        29.8
#> 6         18.4           198       25.7            84        25.6
#> 7         21.1            55       27.9           169        41.2
#> 8         16.0           316       22.1            11        30.1
#> 9         14.8           336       24.7            54        24.3
#> 10        20.2            86       27.7           158        26.7
#> 11        17.5           257       25.1            64        28.2
#> 12        21.0            58       31.1           283        27.9
#> 13        19.8           112       25.6            81        29.1
#> 14        16.9           286       28.3           186        24.1
#> 15        18.0           223       24.4            45        32.4
#> 16        19.5           127       31.7           301        35.2
#> 17        15.3           332       22.6            14        24.8
#> 18        19.9           104       29.0           213        31.9
#> 19        17.6           253       30.8           276        23.7
#> 20        16.1           311       22.4            13        28.6
#> 21        12.7           346       29.8           247        19.7
#> 22        22.6            18       30.4           266        28.9
#> 23        15.7           327       23.4            23        29.4
#> 24        20.2            88       34.0           339        24.1
#> 25        18.0           224       28.3           189        25.5
#> 26        16.8           295       24.3            39        30.1
#> 27        19.6           125       29.5           235        36.8
#> 28        17.8           242       27.5           154        35.9
#> 29        17.3           266       25.2            68        28.4
#> 30        20.5            77       29.2           222        30.7
#> 31        19.6           122       29.5           236        27.3
#> 32        23.7             8       30.0           252        35.6
#> 33        18.4           191       25.2            70        29.9
#> 34        19.7           114       24.8            57        33.5
#> 35        18.5           189       27.7           162        23.7
#> 36        17.9           233       29.9           250        38.5
#> 37        16.8           289       26.5           115        25.0
#> 38        18.5           185       31.8           307        31.6
#> 39        15.3           330       21.1             4        26.3
#> 40        19.2           140       26.7           129        29.3
#> 41        21.5            50       20.9             3        22.7
#> 42        21.9            39       30.3           264        31.8
#> 43        20.1            91       26.5           116        29.0
#> 44        20.2            84       30.7           275        35.1
#> 45        22.4            25       24.3            42        32.5
#> 46        21.6            45       28.7           203        29.3
#> 47        20.2            87       29.2           225        35.2
#> 48        16.4           303       27.3           147        23.5
#> 49        18.0           219       28.8           209        36.7
#> 50        19.9           102       22.0             9        36.7
#> 51        19.2           143       29.8           246        27.3
#> 52        19.0           146       26.4           112        26.9
#> 53        16.3           304       25.3            73        26.3
#> 54        20.0            99       26.8           136        26.8
#> 55        19.2           142       29.1           218        28.6
#> 56        20.5            78       24.3            43        27.3
#> 57        20.5            76       27.4           152        28.7
#> 58        17.4           264       22.8            16        30.5
#> 59        17.9           232       24.4            44        31.9
#> 60        19.7           117       30.1           257        31.3
#> 61        18.2           205       33.3           332        29.2
#> 62        16.1           312       25.6            83        27.4
#> 63        21.6            47       31.6           298        28.6
#> 64        20.4            80       27.2           145        24.6
#> 65        18.5           184       29.1           221        22.4
#> 66        18.4           194       33.5           334        31.6
#> 67        19.8           106       28.3           184        27.5
#> 68        18.2           208       27.8           166        33.9
#> 69        19.9           101       23.5            24        28.0
#> 70        17.6           248       27.4           151        33.5
#> 71        19.8           108       28.6           199        33.7
#> 72        17.8           239       24.3            40        41.4
#> 73        16.4           300       28.8           208        27.3
#> 74        17.0           282       23.9            32        31.2
#> 75        20.7            70       30.1           254        36.1
#> 76        19.0           150       31.4           289        34.3
#> 77        17.5           259       29.0           216        26.3
#> 78        22.7            16       28.6           200        28.4
#> 79        18.1           215       26.5           122        34.0
#> 80        16.7           297       25.0            62        21.8
#> 81        17.5           260       26.1           101        33.2
#> 82        18.9           156       29.7           245        32.4
#> 83        20.0            98       26.7           130        26.3
#> 84        17.9           225       30.5           269        29.7
#> 85        22.8            13       28.8           206        30.6
#> 86        21.6            46       32.3           317        31.4
#> 87        16.2           308       26.9           139        25.9
#> 88        13.4           345       25.7            88        23.3
#> 89        17.4           265       20.7             2        34.8
#> 90        14.2           342       22.2            12        28.0
#> 91        18.9           154       24.5            49        32.2
#> 92        16.6           299       26.2           102        29.8
#> 93        17.2           269       27.5           155        24.8
#> 94        15.9           324       28.3           188        30.0
#> 95        17.5           258       27.1           144        28.5
#> 96        16.8           293       29.9           249        30.1
#> 97        15.4           328       24.4            47        35.3
#> 98        15.2           333       26.3           107        36.9
#> 99         0.0           348      100.0           348       100.0
#> 100       19.8           110       24.7            52        39.9
#> 101       20.9            65       27.7           160        30.6
#> 102       18.9           158       24.2            38        22.4
#> 103       19.5           126       31.5           292        33.6
#> 104       15.9           323       24.1            34        26.4
#> 105       18.1           214       26.9           138        38.3
#> 106       18.6           178       28.0           176        25.4
#> 107       21.5            48       26.9           140        28.9
#> 108       16.8           294       26.0            97        27.1
#> 109       22.4            24       27.3           148        33.7
#> 110       20.3            83       28.7           204        27.0
#> 111       18.1           211       29.0           215        27.4
#> 112       17.4           263       28.9           212        25.8
#> 113       17.6           249       28.6           201        27.9
#> 114       18.3           202       24.2            37        34.3
#> 115       19.7           113       32.5           322        34.6
#> 116       19.0           149       29.5           233        29.9
#> 117       22.1            35       23.7            30        35.3
#> 118       19.0           151       23.2            19        33.5
#> 119       17.6           254       25.1            66        34.0
#> 120       19.9           100       25.6            80        33.4
#> 121       16.2           310       23.2            20        30.1
#> 122       23.7             9       31.4           290        35.4
#> 123       18.5           188       28.7           202        29.1
#> 124       22.0            38       22.1            10        34.4
#> 125       15.7           326       27.9           173        25.5
#> 126       19.5           130       21.4             5        25.6
#> 127       17.5           255       26.6           127        33.5
#> 128       17.0           281       29.2           226        29.4
#> 129       20.6            74       25.7            87        42.2
#> 130       18.2           206       28.1           179        36.5
#> 131       16.1           313       28.0           178        37.2
#> 132       17.9           226       25.9            90        33.7
#> 133       19.2           144       24.1            36        27.3
#> 134       18.6           179       26.5           119        34.0
#> 135       17.2           271       34.4           341        34.7
#> 136       13.9           343       25.7            85        25.9
#> 137       22.3            26       29.6           241        32.9
#> 138        0.0           348      100.0           348       100.0
#> 139       22.0            36       31.3           287        39.0
#> 140       18.7           166       33.6           338        21.3
#> 141       17.2           276       27.2           146        22.0
#> 142       18.9           159       32.7           324        32.5
#> 143       17.7           246       24.9            60        33.7
#> 144       13.8           344       19.7             1        26.3
#> 145       22.4            22       25.0            61        32.5
#> 146       21.1            56       25.7            86        36.5
#> 147       16.4           301       23.7            27        28.5
#> 148       18.6           173       26.1            98        37.8
#> 149       17.9           238       26.2           103        30.2
#> 150       18.4           200       23.7            29        33.2
#> 151       20.9            63       28.1           182        33.4
#> 152       24.5             3       27.4           153        42.2
#> 153       22.8            14       25.4            74        27.1
#> 154       17.2           274       30.5           270        35.7
#> 155       16.8           290       21.9             6        27.7
#> 156       19.0           148       25.5            77        40.8
#> 157       19.4           133       33.0           328        24.6
#> 158       19.4           131       26.0            95        31.4
#> 159       19.8           107       26.5           120        31.6
#> 160       17.4           262       30.3           261        27.7
#> 161       18.8           160       25.1            65        23.4
#> 162       21.5            49       30.9           279        30.5
#> 163       16.0           319       28.5           195        33.7
#> 164       18.6           180       25.2            67        28.5
#> 165       21.7            43       32.1           313        35.1
#> 166       21.7            42       27.7           161        28.3
#> 167       18.5           186       26.0            93        32.7
#> 168       18.8           163       28.0           174        32.0
#> 169       16.9           284       29.3           227        31.9
#> 170       17.7           245       26.0            96        33.5
#> 171       18.7           171       29.0           214        26.3
#> 172       17.9           229       26.3           104        19.8
#> 173       18.9           152       31.5           294        31.7
#> 174       18.6           175       23.3            21        38.0
#> 175       22.9            12       30.2           259        29.6
#> 176       16.2           309       35.8           345        31.8
#> 177        0.0           348      100.0           348       100.0
#> 178       18.4           201       21.9             7        28.0
#> 179       18.1           212       28.9           210        28.4
#> 180       18.6           181       26.8           135        35.0
#> 181       19.5           128       29.4           231        36.1
#> 182       18.4           196       31.7           300        22.4
#> 183       19.6           123       30.1           255        35.5
#> 184       26.5             1       27.9           168        41.1
#> 185       16.8           292       26.5           113        27.7
#> 186       18.6           177       28.9           211        32.4
#> 187       16.7           296       28.5           197        25.0
#> 188       18.6           172       29.1           219        27.8
#> 189       16.0           318       28.1           181        31.7
#> 190        0.0           348      100.0           348       100.0
#> 191       17.9           235       25.9            92        32.1
#> 192       18.2           207       24.7            56        28.1
#> 193       22.0            37       32.7           325        39.5
#> 194       17.2           273       30.9           280        31.4
#> 195       19.3           138       22.9            17        28.6
#> 196       19.5           129       25.9            89        29.4
#> 197       24.3             5       30.2           260        32.2
#> 198       18.4           192       28.4           191        22.7
#> 199       19.9           103       30.3           263        39.1
#> 200       17.8           244       26.5           121        33.5
#> 201       20.9            62       28.1           180        44.3
#> 202       19.3           136       33.2           331        33.9
#> 203       17.9           236       24.3            41        25.6
#> 204       19.7           120       33.2           330        32.3
#> 205       17.6           250       25.3            72        23.1
#> 206       20.0            96       32.3           320        37.6
#> 207       14.8           335       24.0            33        34.6
#> 208       16.9           288       24.9            58        30.1
#> 209       20.7            71       28.4           192        34.3
#> 210       15.2           334       26.1            99        29.8
#> 211       17.2           268       27.9           170        30.3
#> 212       17.4           261       26.8           134        30.4
#> 213       18.4           195       33.0           329        36.2
#> 214       17.1           278       30.8           278        30.4
#> 215       18.2           209       32.2           316        27.5
#> 216        0.0           348      100.0           348       100.0
#> 217       19.7           118       26.9           137        46.1
#> 218       22.1            30       29.5           234        42.9
#> 219       19.0           147       25.6            78        23.9
#> 220       15.9           322       24.5            48        28.5
#> 221       19.3           135       26.5           114        34.3
#> 222       20.1            90       28.4           193        32.5
#> 223       16.3           305       26.6           126        39.5
#> 224       17.8           240       27.1           142        24.7
#> 225       22.1            33       30.6           272        30.0
#> 226       19.7           116       27.9           171        32.2
#> 227       18.9           155       25.0            63        33.6
#> 228       22.7            15       26.5           117        33.3
#> 229       17.3           267       26.7           132        36.0
#> 230       18.8           164       26.5           118        37.2
#> 231       17.9           227       26.4           111        29.5
#> 232       20.6            75       27.7           163        38.3
#> 233       17.5           256       28.0           175        27.9
#> 234       20.4            82       29.3           229        40.6
#> 235       20.2            85       26.8           133        31.6
#> 236       16.0           320       30.3           262        29.3
#> 237       20.9            61       28.5           198        38.4
#> 238       15.9           321       24.4            46        34.8
#> 239       18.3           203       29.2           223        40.4
#> 240       16.7           298       26.3           106        26.7
#> 241       21.7            44       30.1           256        40.4
#> 242       17.2           270       26.3           108        29.3
#> 243       20.1            94       28.0           177        27.8
#> 244       18.4           197       27.9           172        33.2
#> 245       19.8           105       30.2           258        23.7
#> 246       19.6           124       32.3           319        29.4
#> 247       12.6           347       31.2           285        27.1
#> 248       15.3           331       31.8           305        27.6
#> 249       18.7           169       33.5           335        34.6
#> 250       19.4           132       24.7            53        24.2
#> 251       20.4            81       27.3           149        33.5
#> 252       16.1           315       23.1            18        38.8
#> 253       23.4            10       27.6           156        40.6
#> 254       16.9           285       26.6           125        30.4
#> 255       18.0           218       24.5            50        25.1
#> 256       17.8           243       31.3           288        34.9
#> 257       20.1            89       31.5           293        35.3
#> 258       15.4           329       28.5           196        28.8
#> 259       18.2           204       25.6            82        33.8
#> 260       21.2            54       32.0           310        38.4
#> 261       18.5           190       24.7            55        23.4
#> 262       15.7           325       28.3           187        29.2
#> 263       20.9            60       27.3           150        29.3
#> 264       21.5            51       33.6           337        34.7
#> 265       18.5           187       31.5           295        35.2
#> 266       16.4           302       27.7           159        31.3
#> 267       17.9           234       30.8           277        23.2
#> 268       19.1           145       31.6           296        28.2
#> 269       17.2           272       26.0            93        32.4
#> 270       23.4            11       31.7           299        45.5
#> 271       20.1            95       29.0           217        24.4
#> 272       19.3           139       25.6            79        33.4
#> 273       18.0           217       31.7           302        35.1
#> 274       17.9           230       22.7            15        39.6
#> 275       17.8           241       26.3           109        28.8
#> 276       18.4           193       25.5            76        37.9
#> 277       17.6           251       29.9           251        38.4
#> 278       22.5            21       24.6            51        55.3
#> 279       18.9           157       25.3            71        35.1
#> 280       20.1            92       28.3           185        34.1
#> 281       18.1           213       27.8           165        26.7
#> 282       17.9           237       22.0             8        39.2
#> 283       17.7           247       28.1           183        30.7
#> 284       23.9             7       36.1           346        31.2
#> 285       14.5           339       35.1           342        27.6
#> 286       18.8           165       29.6           238        31.0
#> 287       19.7           119       23.6            26        38.9
#> 288        0.0           348      100.0           348       100.0
#> 289       17.9           228       31.9           309        35.4
#> 290       16.3           306       26.6           123        30.7
#> 291       16.9           283       31.8           303        23.6
#> 292        0.0           348      100.0           348       100.0
#> 293       18.7           167       29.6           242        35.2
#> 294       14.3           340       29.4           230        26.2
#> 295       18.8           162       27.1           143        29.6
#> 296       18.6           182       28.7           205        29.4
#> 297       18.7           170       24.1            35        35.7
#> 298        0.0           348      100.0           348       100.0
#> 299       25.7             2       31.4           290        46.3
#> 300       16.8           291       26.7           131        31.1
#> 301       16.0           317       24.9            59        25.0
#> 302       21.8            41       35.5           343        32.8
#> 303       20.9            59       29.2           224        29.4
#> 304       18.9           153       26.1           100        43.0
#> 305       22.1            29       31.0           281        31.4
#> 306       18.1           216       26.3           105        35.6
#> 307       20.8            67       30.5           268        27.8
#> 308       18.5           183       32.2           315        33.8
#> 309       18.8           161       29.6           239        26.7
#> 310       20.9            64       28.5           194        28.4
#> 311       20.8            66       33.6           336        38.3
#> 312       17.1           280       31.2           286        33.8
#> 313       21.3            53       32.0           311        34.0
#> 314       22.7            17       23.6            25        46.7
#> 315       14.2           341       27.6           157        33.9
#> 316       20.0            97       28.8           207        27.5
#> 317       18.6           174       23.4            22        29.5
#> 318       22.1            28       30.0           253        38.0
#> 319       19.6           121       31.9           308        33.7
#> 320       20.1            93       32.9           326        30.4
#> 321       18.6           176       31.1           282        28.2
#> 322       18.0           221       26.4           110        30.5
#> 323       20.6            72       32.9           327        36.5
#> 324       21.0            57       31.8           304        38.0
#> 325       24.1             6       34.1           340        43.5
#> 326       16.9           287       23.7            28        32.8
#> 327       19.8           109       29.7           244        35.7
#> 328       18.0           222       25.4            75        32.2
#> 329       20.7            69       26.6           124        40.8
#> 330       19.7           115       32.6           323        36.5
#> 331       18.4           199       32.2           314        38.3
#> 332       19.8           111       25.9            91        28.8
#> 333       22.1            31       30.5           271        50.1
#> 334       20.4            79       32.5           321        27.0
#> 335       18.7           168       32.3           318        45.5
#> 336       21.8            40       31.6           297        33.0
#> 337       22.3            27       28.4           190        41.7
#> 338       17.1           277       29.7           243        35.8
#> 339       22.5            20       27.8           164        39.5
#> 340       22.1            32       30.6           273        44.5
#> 341       21.5            52       31.8           306        33.9
#> 342        0.0           348      100.0           348       100.0
#> 343       18.1           210       29.9           248        36.5
#> 344       17.6           252       31.2           284        34.4
#> 345       17.2           275       27.8           167        32.7
#> 346       22.4            23       29.6           240        46.8
#> 347       19.3           134       29.3           228        31.2
#> 348       16.2           307       37.9           347        32.8
#> 349       22.1            34       26.6           128        41.2
#> 350       17.1           279       25.2            69        32.7
#> 351       22.6            19       33.4           333        35.7
#> 352       19.2           141       30.4           265        27.7
#> 353       20.8            68       30.5           267        30.9
#> 354       18.0           220       29.4           232        37.4
#> 355       20.6            73       29.6           237        36.9
#> 356        0.0           348      100.0           348       100.0
#> 357       14.5           338       35.8           344        32.5
#> 358       18.4           196       22.7            16        21.8
#> 359       18.7           167       26.6           115        30.9
#> 360       17.6           246       30.2           280        23.4
#> 361       16.6           302       28.5           197        26.4
#> 362       17.6           258       29.5           253        26.8
#> 363       19.8           109       31.1           307        29.5
#> 364       18.2           206       24.1            35        27.9
#> 365       18.6           178       26.4           108        23.2
#> 366       20.2            91       28.0           176        30.9
#> 367       15.8           331       26.0            91        29.3
#> 368       21.2            49       25.4            63        30.6
#> 369       17.4           265       25.0            50        29.0
#> 370       18.3           200       25.5            72        29.3
#> 371       15.1           345       26.0            92        34.8
#> 372       16.9           292       24.5            42        23.6
#> 373       17.7           242       23.6            22        28.0
#> 374       22.7            22       29.8           261        30.8
#> 375       17.3           274       26.6           116        24.2
#> 376       17.1           283       28.3           189        31.6
#> 377       16.1           320       25.5            70        26.4
#> 378       20.3            86       32.2           331        30.2
#> 379       18.2           209       25.3            61        41.6
#> 380       15.6           336       22.5            12        25.8
#> 381       17.3           268       28.5           196        32.1
#> 382       17.9           231       25.4            67        30.9
#> 383       17.3           272       24.9            48        32.6
#> 384       19.2           146       27.4           150        33.7
#> 385       18.7           175       29.0           227        28.2
#> 386       19.5           129       30.4           289        32.4
#> 387       15.8           330       27.9           169        28.0
#> 388       15.7           332       31.8           323        28.1
#> 389       23.7             9       30.2           281        34.4
#> 390       18.7           170       27.4           148        33.9
#> 391       20.7            68       27.7           155        38.8
#> 392       20.6            74       25.9            82        35.2
#> 393       18.8           164       28.7           209        26.6
#> 394       18.2           214       30.8           300        35.9
#> 395       16.6           304       25.7            80        23.9
#> 396       18.6           186       29.0           222        30.9
#> 397       16.9           291       25.9            88        25.3
#> 398       16.8           298       28.1           180        19.7
#> 399       20.1            96       30.9           302        35.4
#> 400       18.6           180       27.6           154        31.8
#> 401       15.2           341       24.4            41        36.5
#> 402       16.8           296       24.0            28        24.9
#> 403       15.3           339       27.1           140        26.0
#> 404       23.0            17       29.3           237        35.4
#> 405       20.6            70       31.6           314        28.0
#> 406       17.5           259       22.5            11        26.8
#> 407       20.4            80       27.2           142        31.9
#> 408       19.4           133       25.4            64        35.2
#> 409       17.6           255       23.8            24        24.1
#> 410       19.9           107       26.3           104        30.2
#> 411       19.4           137       23.9            27        26.1
#> 412       22.1            35       31.4           312        40.9
#> 413       19.3           141       31.1           306        21.0
#> 414       20.3            87       34.3           347        32.1
#> 415       16.7           300       27.4           147        19.7
#> 416       19.8           112       28.8           214        29.2
#> 417       20.7            65       26.8           127        32.6
#> 418       15.2           340       26.0            90        35.2
#> 419       19.8           111       29.4           242        20.3
#> 420       14.9           346       22.1            10        32.2
#> 421       21.9            37       29.4           247        34.6
#> 422       17.8           237       24.5            44        32.6
#> 423       18.4           195       29.2           233        29.1
#> 424       22.4            29       27.7           159        37.0
#> 425       18.5           190       24.1            33        31.9
#> 426       22.3            33       26.2            98        33.1
#> 427       18.1           215       26.8           132        31.7
#> 428       17.9           228       30.1           272        31.5
#> 429       18.9           163       25.4            68        27.5
#> 430       16.6           305       21.3             5        25.7
#> 431       17.4           266       24.0            30        40.6
#> 432       21.4            44       28.4           192        37.4
#> 433       16.4           309       22.8            17        29.8
#> 434       16.0           322       24.2            37        29.2
#> 435       23.0            19       28.4           191        26.8
#> 436       17.6           253       31.9           324        22.9
#> 437       20.9            57       21.7             8        32.0
#> 438       19.2           147       29.5           252        27.6
#> 439       17.3           271       32.0           327        29.0
#> 440       16.5           307       25.6            77        31.2
#> 441       20.5            76       29.0           223        33.1
#> 442       19.0           155       27.8           161        34.7
#> 443       17.3           269       26.3            99        23.8
#> 444       17.2           279       26.0            93        26.9
#> 445       19.2           144       22.6            13        29.8
#> 446       17.2           277       24.0            31        26.5
#> 447       20.5            75       27.9           175        32.5
#> 448       14.6           347       19.0             1        26.6
#> 449       17.9           230       25.9            87        31.2
#> 450       16.9           290       24.6            45        27.3
#> 451       20.2            94       30.5           291        29.2
#> 452       17.6           247       26.6           117        33.0
#> 453       19.6           126       30.1           279        35.3
#> 454       19.5           128       26.7           122        24.3
#> 455       19.1           152       22.6            14        31.4
#> 456       19.6           120       28.7           211        34.4
#> 457       17.7           239       26.9           136        23.0
#> 458       21.2            50       29.8           263        39.0
#> 459       16.3           315       27.8           162        26.5
#> 460       18.6           179       27.6           153        28.9
#> 461       22.7            21       31.4           313        36.2
#> 462       19.4           132       30.4           288        34.4
#> 463       19.0           157       25.7            78        30.1
#> 464       19.4           130       21.3             4        28.6
#> 465       22.3            31       28.6           204        34.2
#> 466       18.2           212       31.6           317        33.0
#> 467       17.6           250       26.7           124        29.8
#> 468       19.6           119       25.2            57        36.6
#> 469       19.3           140       31.8           320        31.4
#> 470       19.1           151       25.7            79        33.5
#> 471       15.7           333       26.8           133        31.0
#> 472       20.8            62       32.9           334        47.0
#> 473       16.7           301       26.8           130        29.0
#> 474       20.0            98       24.1            34        38.4
#> 475       16.3           314       26.6           118        34.3
#> 476       21.0            55       29.6           255        30.8
#> 477       18.5           189       27.0           138        33.7
#> 478       16.4           311       25.3            60        36.0
#> 479       21.3            47       28.6           200        53.1
#> 480       19.7           114       24.1            36        30.6
#> 481       14.0           353       25.6            75        30.6
#> 482       20.0           102       30.1           275        24.4
#> 483       20.9            58       28.6           205        28.5
#> 484       15.4           337       26.6           119        28.2
#> 485       16.9           288       34.4           348        28.2
#> 486       17.7           241       29.3           239        32.5
#> 487       20.1            95       29.6           256        26.6
#> 488       15.8           329       29.2           235        28.6
#> 489       19.0           156       29.4           246        27.2
#> 490       18.2           210       22.7            15        33.2
#> 491       18.4           199       27.8           163        45.8
#> 492       15.1           344       31.0           304        38.1
#> 493       20.0           103       24.1            32        41.9
#> 494       17.5           260       25.0            51        31.4
#> 495       24.5             6       30.1           273        35.9
#> 496       19.6           123       29.4           243        36.8
#> 497       19.7           113       27.8           164        35.9
#> 498       20.0           100       27.4           151        31.7
#> 499       17.8           236       24.3            39        31.8
#> 500       22.4            27       27.8           167        31.8
#> 501       18.6           183       29.5           251        28.8
#> 502       18.1           217       27.9           174        28.0
#> 503       16.4           310       26.8           128        33.5
#> 504       17.6           254       25.5            71        26.1
#> 505       19.9           106       29.1           229        43.1
#> 506       18.1           219       26.3           106        38.0
#> 507       20.9            59       27.7           160        47.8
#> 508       19.1           154       28.8           213        30.4
#> 509       27.8             1       26.8           129        44.6
#> 510       20.8            60       32.2           330        35.3
#> 511       23.3            14       34.5           349        26.0
#> 512       20.0            99       24.5            43        28.7
#> 513       18.1           220       21.3             3        41.6
#> 514       21.3            48       35.5           350        30.5
#> 515       19.6           125       27.8           165        40.6
#> 516       23.6            11       23.6            21        23.5
#> 517       24.9             4       27.0           139        36.8
#> 518       18.1           218       24.8            46        32.8
#> 519       20.6            69       30.5           292        29.4
#> 520       16.9           289       28.6           203        25.0
#> 521       16.1           319       28.6           206        29.9
#> 522       22.1            34       30.2           282        35.4
#> 523       17.2           278       25.1            52        26.1
#> 524       14.3           350       23.8            26        26.5
#> 525       21.5            42       28.0           177        28.3
#> 526       20.5            78       25.4            65        46.3
#> 527       16.0           323       26.7           121        29.5
#> 528       19.3           143       28.9           219        35.8
#> 529       17.6           257       31.6           316        29.6
#> 530       16.5           306       29.5           254        30.9
#> 531       20.3            89       30.3           284        33.5
#> 532       16.7           299       32.1           329        36.7
#> 533       18.9           158       26.5           114        37.8
#> 534       24.3             8       30.1           278        38.8
#> 535       18.5           187       24.8            47        32.2
#> 536       18.4           194       26.2            96        28.0
#> 537       17.5           262       29.0           226        35.8
#> 538       17.6           251       30.0           269        31.4
#> 539       20.9            56       25.9            89        32.3
#> 540       15.2           342       25.5            69        29.8
#> 541       20.7            64       28.7           207        27.6
#> 542       15.7           334       28.2           182        23.6
#> 543       18.0           222       31.7           318        31.9
#> 544       21.1            51       28.9           217        29.2
#> 545       17.9           229       28.1           181        36.9
#> 546       17.9           227       23.4            20        30.5
#> 547       18.7           173       33.0           335        21.8
#> 548       20.2            92       31.9           326        31.0
#> 549       23.0            18       31.2           311        29.6
#> 550       14.3           348       29.0           224        32.0
#> 551       18.7           177       31.7           319        34.2
#> 552       17.3           275       26.3           102        37.0
#> 553       18.7           171       29.8           264        32.8
#> 554       18.9           161       27.8           168        30.6
#> 555       18.3           201       29.9           266        31.8
#> 556       20.0           104       32.1           328        37.6
#> 557       18.8           165       27.9           173        41.7
#> 558       17.6           248       27.7           156        27.1
#> 559       19.9           105       29.4           248        36.6
#> 560       22.4            28       31.8           322        26.0
#> 561       19.1           149       24.0            29        30.3
#> 562       18.3           203       24.3            40        27.0
#> 563       16.2           317       28.6           201        26.0
#> 564       14.1           352       26.2            97        23.6
#> 565       17.4           264       25.9            83        42.1
#> 566       18.6           184       27.8           166        38.2
#> 567       20.2            93       29.4           244        35.0
#> 568       14.3           349       27.2           141        22.1
#> 569       21.4            46       29.3           241        31.7
#> 570       17.8           232       29.8           262        32.4
#> 571       23.3            15       25.2            56        34.5
#> 572       17.5           261       28.5           198        39.3
#> 573       17.7           240       26.9           135        35.3
#> 574       18.5           191       26.7           125        29.5
#> 575       20.7            66       35.8           351        27.6
#> 576       16.0           326       26.5           112        29.6
#> 577       20.3            88       27.7           157        27.3
#> 578       17.0           286       30.5           294        31.8
#> 579       17.0           284       24.3            38        32.2
#> 580       24.8             5       34.1           343        39.7
#> 581       14.2           351       31.6           315        30.3
#> 582       20.7            67       26.9           134        29.3
#> 583       20.3            90       28.4           190        40.1
#> 584       18.7           168       26.5           111        40.2
#> 585       20.7            63       30.7           296        29.9
#> 586       24.3             7       30.8           299        44.7
#> 587       15.9           328       26.0            94        29.3
#> 588       17.1           281       33.5           339        29.5
#> 589       16.2           316       29.3           240        31.7
#> 590       20.6            71       34.2           346        39.7
#> 591       19.3           142       23.3            18        21.6
#> 592       19.6           121       25.1            54        28.5
#> 593       15.7           335       26.7           126        31.1
#> 594       19.6           124       30.4           287        34.3
#> 595       22.4            26       28.8           215        41.7
#> 596       26.1             2       29.5           250        48.9
#> 597       16.8           294       23.3            19        37.0
#> 598       16.6           303       28.9           221        22.5
#> 599       17.0           287       25.9            84        23.9
#> 600       22.5            25       29.4           249        38.3
#> 601       23.5            12       30.0           268        44.2
#> 602       18.2           211       33.5           340        24.5
#> 603       17.7           244       30.3           283        26.2
#> 604       20.3            84       23.7            23        27.6
#> 605       19.4           134       27.3           144        31.0
#> 606       18.5           193       21.7             7        34.0
#> 607       15.1           343       26.2            95        35.0
#> 608       17.8           238       32.5           333        37.2
#> 609       21.0            53       29.9           265        25.3
#> 610       21.4            45       28.8           216        33.9
#> 611       18.1           221       25.9            81        30.1
#> 612       17.7           245       28.5           194        31.0
#> 613       17.8           233       28.9           220        34.8
#> 614       16.5           308       28.2           186        29.9
#> 615       18.9           160       27.6           152        33.7
#> 616       21.9            38       29.2           236        35.7
#> 617       18.4           197       27.3           143        27.4
#> 618       19.1           150       25.9            86        32.5
#> 619       17.6           256       30.4           286        34.4
#> 620       21.1            52       30.0           270        48.4
#> 621       19.4           135       28.2           187        39.7
#> 622       18.7           176       31.2           310        28.5
#> 623       18.7           174       29.2           234        45.9
#> 624       19.7           116       25.3            62        48.8
#> 625       21.7            39       25.9            85        35.3
#> 626       17.0           285       26.8           131        32.4
#> 627       15.9           327       25.0            49        30.8
#> 628       18.0           224       28.2           184        37.1
#> 629       16.9           293       27.4           149        37.1
#> 630       19.2           145       26.4           109        33.0
#> 631       17.2           276       25.5            74        33.3
#> 632       19.6           122       27.7           158        40.5
#> 633       16.8           295       20.8             2        29.7
#> 634       17.1           282       27.9           170        34.5
#> 635       19.7           118       26.4           110        29.3
#> 636       17.1           280       27.9           171        38.2
#> 637       17.7           243       28.2           183        36.6
#> 638       17.3           267       27.9           172        30.1
#> 639       23.7            10       28.2           185        49.2
#> 640       22.6            24       32.5           332        27.6
#> 641       20.0            97       29.9           267        37.4
#> 642       19.8           110       26.6           120        38.3
#> 643       19.3           139       25.3            59        49.1
#> 644       16.8           297       30.5           290        34.0
#> 645       20.8            61       29.7           257        43.8
#> 646       19.4           138       26.3           105        40.8
#> 647       16.0           321       26.5           113        28.7
#> 648       15.4           338       29.3           238        31.4
#> 649       18.2           208       26.7           123        35.4
#> 650       19.4           131       25.5            73        28.4
#> 651       16.1           318       21.8             9        32.2
#> 652       18.9           159       29.4           245        39.5
#> 653       18.6           182       30.1           276        28.8
#> 654       23.3            13       33.6           341        36.3
#> 655       20.4            82       30.9           301        38.8
#> 656       18.1           216       23.8            25        29.5
#> 657       22.0            36       27.4           146        40.8
#> 658       18.4           198       28.6           199        43.4
#> 659       16.3           313       25.1            55        25.7
#> 660       17.5           263       25.4            66        38.1
#> 661       16.3           312       21.4             6        39.1
#> 662       17.3           270       30.7           297        28.3
#> 663       17.8           234       28.0           178        38.6
#> 664       18.3           202       27.3           145        33.4
#> 665       19.1           153       29.1           231        36.5
#> 666       17.3           273       28.3           188        29.2
#> 667       17.8           235       28.7           210        36.0
#> 668       21.6            40       31.8           321        41.1
#> 669       18.7           172       31.0           305        29.5
#> 670       17.6           249       26.3           103        33.0
#> 671       18.2           207       30.6           295        31.2
#> 672       17.9           226       28.0           179        31.9
#> 673       18.3           204       25.6            76        28.2
#> 674       19.1           148       29.1           228        41.3
#> 675       23.1            16       30.5           293        30.9
#> 676       22.7            23       33.2           337        33.3
#> 677       19.7           117       31.2           309        29.9
#> 678       21.6            41       28.8           212        40.5
#> 679       18.9           162       28.6           202        36.8
#> 680       18.7           169       30.0           271        43.8
#> 681       18.6           181       28.9           218        34.6
#> 682       25.9             3       34.2           345        37.8
#> 683       18.5           188       36.9           353        34.7
#> 684       18.8           166       29.0           225        49.3
#> 685       20.0           101       29.2           232        36.4
#> 686       20.6            73       33.1           336        39.5
#> 687       18.6           185       28.4           193        32.8
#> 688       22.3            30       30.1           277        46.0
#> 689       16.0           325       26.3           107        29.4
#> 690       22.8            20       29.7           258        43.6
#> 691       19.6           127       28.5           195        28.5
#> 692       21.4            43       30.4           285        42.0
#> 693       18.3           205       29.8           259        40.6
#> 694       17.9           225       29.1           230        33.1
#> 695       22.3            32       34.0           342        42.5
#> 696       20.3            85       25.1            53        35.0
#> 697       19.8           108       30.1           274        29.8
#> 698       20.5            79       34.1           344        36.0
#> 699       18.0           223       33.4           338        33.2
#> 700       20.5            77       25.2            58        39.1
#> 701       19.4           136       26.3           100        31.1
#> 702       17.6           252       35.9           352        36.1
#> 703       19.7           115       28.7           208        30.2
#> 704       21.0            54       26.3           101        33.1
#> 705       18.2           213       27.0           137        35.2
#> 706       16.0           324       31.9           325        42.5
#> 707       20.4            83       29.8           260        38.3
#> 708       18.5           192       31.2           308        30.4
#> 709       20.4            81       31.0           303        36.6
#> 710       20.6            72       30.7           298        46.3
#>     def_ft_rate_rk ncaa_seed year
#> 1               43         1 2021
#> 2              167         1 2021
#> 3                6         2 2021
#> 4              219         2 2021
#> 5              135         8 2021
#> 6               40         5 2021
#> 7              329         2 2021
#> 8              142         1 2021
#> 9               26         1 2021
#> 10              55         7 2021
#> 11              92        11 2021
#> 12              87         3 2021
#> 13             115         5 2021
#> 14              24         6 2021
#> 15             195        NA 2021
#> 16             263         4 2021
#> 17              31         4 2021
#> 18             183        NA 2021
#> 19              20        NA 2021
#> 20             107        NA 2021
#> 21               1        NA 2021
#> 22             112         9 2021
#> 23             125         6 2021
#> 24              23        11 2021
#> 25              39         5 2021
#> 26             146         4 2021
#> 27             292         7 2021
#> 28             280         3 2021
#> 29              99         9 2021
#> 30             158         2 2021
#> 31              70        NA 2021
#> 32             273         6 2021
#> 33             139        11 2021
#> 34             223        NA 2021
#> 35              21         8 2021
#> 36             311        12 2021
#> 37              34        10 2021
#> 38             177        NA 2021
#> 39              53        NA 2021
#> 40             119        13 2021
#> 41              11         8 2021
#> 42             181        NA 2021
#> 43             114         3 2021
#> 44             261         7 2021
#> 45             199         6 2021
#> 46             121        NA 2021
#> 47             266        NA 2021
#> 48              17        NA 2021
#> 49             290         9 2021
#> 50             291        NA 2021
#> 51              66        NA 2021
#> 52              60         8 2021
#> 53              49        14 2021
#> 54              59         3 2021
#> 55             106         9 2021
#> 56              69        12 2021
#> 57             108        NA 2021
#> 58             154        13 2021
#> 59             184        10 2021
#> 60             168         4 2021
#> 61             117        11 2021
#> 62              71        14 2021
#> 63             104        NA 2021
#> 64              29        NA 2021
#> 65               9        NA 2021
#> 66             174        15 2021
#> 67              73        NA 2021
#> 68             236        NA 2021
#> 69              90        NA 2021
#> 70             222        NA 2021
#> 71             227        NA 2021
#> 72             331        NA 2021
#> 73              68        NA 2021
#> 74             164        NA 2021
#> 75             283        NA 2021
#> 76             245        NA 2021
#> 77              52        NA 2021
#> 78              96        NA 2021
#> 79             239        NA 2021
#> 80               4        NA 2021
#> 81             210        NA 2021
#> 82             194        10 2021
#> 83              51        NA 2021
#> 84             134        NA 2021
#> 85             156         5 2021
#> 86             171        NA 2021
#> 87              45        12 2021
#> 88              14        NA 2021
#> 89             256        NA 2021
#> 90              88        NA 2021
#> 91             190        NA 2021
#> 92             136        NA 2021
#> 93              32        NA 2021
#> 94             141        NA 2021
#> 95             103        NA 2021
#> 96             145        NA 2021
#> 97             269        NA 2021
#> 98             293        11 2021
#> 99             348        NA 2021
#> 100            321        NA 2021
#> 101            157        13 2021
#> 102              8        NA 2021
#> 103            225        NA 2021
#> 104             54        16 2021
#> 105            307        NA 2021
#> 106             37        NA 2021
#> 107            113         7 2021
#> 108             65        NA 2021
#> 109            229        NA 2021
#> 110             61        NA 2021
#> 111             72        NA 2021
#> 112             44        NA 2021
#> 113             86        NA 2021
#> 114            246        NA 2021
#> 115            250        NA 2021
#> 116            138        NA 2021
#> 117            267        NA 2021
#> 118            216        NA 2021
#> 119            240        NA 2021
#> 120            213        NA 2021
#> 121            144        15 2021
#> 122            270        10 2021
#> 123            116        NA 2021
#> 124            248        12 2021
#> 125             38        NA 2021
#> 126             41        11 2021
#> 127            220        NA 2021
#> 128            124        NA 2021
#> 129            334        NA 2021
#> 130            286        NA 2021
#> 131            296        NA 2021
#> 132            228        NA 2021
#> 133             67        NA 2021
#> 134            242        NA 2021
#> 135            253        NA 2021
#> 136             46        NA 2021
#> 137            207        NA 2021
#> 138            348        NA 2021
#> 139            314        NA 2021
#> 140              3        NA 2021
#> 141              5        NA 2021
#> 142            196        NA 2021
#> 143            230        NA 2021
#> 144             50        NA 2021
#> 145            198        NA 2021
#> 146            289        13 2021
#> 147            102        NA 2021
#> 148            299        NA 2021
#> 149            147        NA 2021
#> 150            211        NA 2021
#> 151            214        NA 2021
#> 152            333        NA 2021
#> 153             63        NA 2021
#> 154            275        NA 2021
#> 155             80        NA 2021
#> 156            326        NA 2021
#> 157             28        NA 2021
#> 158            173        NA 2021
#> 159            176        NA 2021
#> 160             78        NA 2021
#> 161             16        NA 2021
#> 162            155        NA 2021
#> 163            231        NA 2021
#> 164            100        NA 2021
#> 165            259        NA 2021
#> 166             95        NA 2021
#> 167            203        NA 2021
#> 168            185        NA 2021
#> 169            182        NA 2021
#> 170            221        NA 2021
#> 171             48        NA 2021
#> 172              2        NA 2021
#> 173            179        NA 2021
#> 174            303        NA 2021
#> 175            133        NA 2021
#> 176            180        NA 2021
#> 177            348        NA 2021
#> 178             89        NA 2021
#> 179             98        NA 2021
#> 180            258        NA 2021
#> 181            282        NA 2021
#> 182              7        NA 2021
#> 183            272        NA 2021
#> 184            328        14 2021
#> 185             79        NA 2021
#> 186            192        NA 2021
#> 187             33        NA 2021
#> 188             83        NA 2021
#> 189            178        NA 2021
#> 190            348        NA 2021
#> 191            186        NA 2021
#> 192             91        NA 2021
#> 193            318        NA 2021
#> 194            170        NA 2021
#> 195            105        NA 2021
#> 196            126        NA 2021
#> 197            187        NA 2021
#> 198             10        NA 2021
#> 199            315        NA 2021
#> 200            217        NA 2021
#> 201            338        NA 2021
#> 202            237        NA 2021
#> 203             42        NA 2021
#> 204            191        NA 2021
#> 205             12        14 2021
#> 206            298        15 2021
#> 207            251        NA 2021
#> 208            143        NA 2021
#> 209            247        NA 2021
#> 210            137        NA 2021
#> 211            148        NA 2021
#> 212            149        NA 2021
#> 213            284        NA 2021
#> 214            152        NA 2021
#> 215             75        NA 2021
#> 216            348        NA 2021
#> 217            342        15 2021
#> 218            335        NA 2021
#> 219             22        NA 2021
#> 220            101        NA 2021
#> 221            244        16 2021
#> 222            197        NA 2021
#> 223            317        NA 2021
#> 224             30        NA 2021
#> 225            140        NA 2021
#> 226            188        NA 2021
#> 227            224        NA 2021
#> 228            212        NA 2021
#> 229            281        NA 2021
#> 230            295        NA 2021
#> 231            131        NA 2021
#> 232            304        NA 2021
#> 233             85        NA 2021
#> 234            325        16 2021
#> 235            175        NA 2021
#> 236            123        NA 2021
#> 237            310        NA 2021
#> 238            255        NA 2021
#> 239            323        NA 2021
#> 240             58        NA 2021
#> 241            322        NA 2021
#> 242            122        NA 2021
#> 243             84        NA 2021
#> 244            209        NA 2021
#> 245             19        16 2021
#> 246            129        NA 2021
#> 247             64        NA 2021
#> 248             77        NA 2021
#> 249            252        NA 2021
#> 250             25        NA 2021
#> 251            218        NA 2021
#> 252            312        NA 2021
#> 253            324        NA 2021
#> 254            151        NA 2021
#> 255             36        NA 2021
#> 256            257        NA 2021
#> 257            268        NA 2021
#> 258            109        NA 2021
#> 259            234        NA 2021
#> 260            309        NA 2021
#> 261             15        NA 2021
#> 262            118        NA 2021
#> 263            120        NA 2021
#> 264            254        NA 2021
#> 265            265        NA 2021
#> 266            169        NA 2021
#> 267             13        NA 2021
#> 268             93        NA 2021
#> 269            193        NA 2021
#> 270            340        NA 2021
#> 271             27        16 2021
#> 272            215        NA 2021
#> 273            260        NA 2021
#> 274            320        NA 2021
#> 275            110        NA 2021
#> 276            300        NA 2021
#> 277            308        NA 2021
#> 278            347        NA 2021
#> 279            262        NA 2021
#> 280            243        NA 2021
#> 281             56        NA 2021
#> 282            316        NA 2021
#> 283            159        NA 2021
#> 284            166        NA 2021
#> 285             76        NA 2021
#> 286            162        NA 2021
#> 287            313        NA 2021
#> 288            348        NA 2021
#> 289            271        NA 2021
#> 290            160        NA 2021
#> 291             18        NA 2021
#> 292            348        NA 2021
#> 293            264        NA 2021
#> 294             47        NA 2021
#> 295            132        NA 2021
#> 296            128        NA 2021
#> 297            277        NA 2021
#> 298            348        NA 2021
#> 299            343        NA 2021
#> 300            163        NA 2021
#> 301             35        16 2021
#> 302            206        NA 2021
#> 303            127        NA 2021
#> 304            336        NA 2021
#> 305            172        NA 2021
#> 306            274        NA 2021
#> 307             82        NA 2021
#> 308            233        NA 2021
#> 309             57        NA 2021
#> 310             97        NA 2021
#> 311            305        NA 2021
#> 312            232        NA 2021
#> 313            241        NA 2021
#> 314            344        NA 2021
#> 315            238        NA 2021
#> 316             74        NA 2021
#> 317            130        NA 2021
#> 318            302        NA 2021
#> 319            226        NA 2021
#> 320            150        NA 2021
#> 321             94        NA 2021
#> 322            153        NA 2021
#> 323            285        NA 2021
#> 324            301        NA 2021
#> 325            337        NA 2021
#> 326            204        NA 2021
#> 327            278        NA 2021
#> 328            189        NA 2021
#> 329            327        NA 2021
#> 330            288        NA 2021
#> 331            306        NA 2021
#> 332            111        NA 2021
#> 333            346        NA 2021
#> 334             62        NA 2021
#> 335            341        NA 2021
#> 336            208        NA 2021
#> 337            332        NA 2021
#> 338            279        NA 2021
#> 339            319        NA 2021
#> 340            339        NA 2021
#> 341            235        NA 2021
#> 342            348        NA 2021
#> 343            287        NA 2021
#> 344            249        NA 2021
#> 345            201        NA 2021
#> 346            345        NA 2021
#> 347            165        NA 2021
#> 348            205        NA 2021
#> 349            330        NA 2021
#> 350            202        NA 2021
#> 351            275        NA 2021
#> 352             81        NA 2021
#> 353            161        NA 2021
#> 354            297        NA 2021
#> 355            294        NA 2021
#> 356            348        NA 2021
#> 357            200        NA 2021
#> 358              7         1 2020
#> 359            149         1 2020
#> 360             13         2 2020
#> 361             42         8 2020
#> 362             49         6 2020
#> 363            109         4 2020
#> 364             65         5 2020
#> 365             12         1 2020
#> 366            145         3 2020
#> 367            100         3 2020
#> 368            140         2 2020
#> 369             91         4 2020
#> 370            101         5 2020
#> 371            238         9 2020
#> 372             16         2 2020
#> 373             68         8 2020
#> 374            141         1 2020
#> 375             22         3 2020
#> 376            165        NA 2020
#> 377             41         6 2020
#> 378            128        NA 2020
#> 379            324         7 2020
#> 380             32        NA 2020
#> 381            181         4 2020
#> 382            148         5 2020
#> 383            196        NA 2020
#> 384            218         9 2020
#> 385             74        NA 2020
#> 386            190         3 2020
#> 387             66        NA 2020
#> 388             71        NA 2020
#> 389            229         2 2020
#> 390            219         5 2020
#> 391            300        13 2020
#> 392            242         7 2020
#> 393             46        NA 2020
#> 394            257        NA 2020
#> 395             20         7 2020
#> 396            144        NA 2020
#> 397             29         4 2020
#> 398              2        NA 2020
#> 399            252        11 2020
#> 400            172         6 2020
#> 401            268        NA 2020
#> 402             26        NA 2020
#> 403             34        NA 2020
#> 404            250        10 2020
#> 405             67        NA 2020
#> 406             50        11 2020
#> 407            178        NA 2020
#> 408            245        11 2020
#> 409             21        NA 2020
#> 410            129        11 2020
#> 411             37         8 2020
#> 412            320        NA 2020
#> 413              4        NA 2020
#> 414            182        NA 2020
#> 415              1        10 2020
#> 416             97        12 2020
#> 417            194        NA 2020
#> 418            244        NA 2020
#> 419              3        14 2020
#> 420            186        NA 2020
#> 421            234        NA 2020
#> 422            195        10 2020
#> 423             93        13 2020
#> 424            280         6 2020
#> 425            175        NA 2020
#> 426            206        11 2020
#> 427            166        NA 2020
#> 428            164        NA 2020
#> 429             59         9 2020
#> 430             31        12 2020
#> 431            316        NA 2020
#> 432            284         8 2020
#> 433            119        NA 2020
#> 434             94        NA 2020
#> 435             51        NA 2020
#> 436             10        NA 2020
#> 437            180        13 2020
#> 438             64        NA 2020
#> 439             92        NA 2020
#> 440            157        NA 2020
#> 441            205        NA 2020
#> 442            235        NA 2020
#> 443             18        NA 2020
#> 444             52        16 2020
#> 445            118        NA 2020
#> 446             45        NA 2020
#> 447            191        NA 2020
#> 448             47        15 2020
#> 449            156        14 2020
#> 450             57        NA 2020
#> 451             98        NA 2020
#> 452            200        NA 2020
#> 453            248        NA 2020
#> 454             23        14 2020
#> 455            163        13 2020
#> 456            230        15 2020
#> 457             11        NA 2020
#> 458            302        NA 2020
#> 459             43        NA 2020
#> 460             89        NA 2020
#> 461            264        NA 2020
#> 462            228        NA 2020
#> 463            127        NA 2020
#> 464             83        12 2020
#> 465            224        10 2020
#> 466            202        NA 2020
#> 467            117        NA 2020
#> 468            269        NA 2020
#> 469            159        NA 2020
#> 470            214        NA 2020
#> 471            150        NA 2020
#> 472            345        NA 2020
#> 473             90        NA 2020
#> 474            297        11 2020
#> 475            225        NA 2020
#> 476            142        NA 2020
#> 477            216        15 2020
#> 478            261        14 2020
#> 479            353        NA 2020
#> 480            138        NA 2020
#> 481            139        NA 2020
#> 482             24        NA 2020
#> 483             79        NA 2020
#> 484             75        NA 2020
#> 485             72        NA 2020
#> 486            193        NA 2020
#> 487             48        NA 2020
#> 488             84        NA 2020
#> 489             55        NA 2020
#> 490            208        NA 2020
#> 491            340        NA 2020
#> 492            291        NA 2020
#> 493            327        16 2020
#> 494            160        NA 2020
#> 495            258        NA 2020
#> 496            276        NA 2020
#> 497            259        NA 2020
#> 498            167        NA 2020
#> 499            171        NA 2020
#> 500            173        NA 2020
#> 501             87        NA 2020
#> 502             69         9 2020
#> 503            215        NA 2020
#> 504             38        NA 2020
#> 505            332        NA 2020
#> 506            289        NA 2020
#> 507            346        NA 2020
#> 508            133        NA 2020
#> 509            338        12 2020
#> 510            246        NA 2020
#> 511             33        NA 2020
#> 512             85        NA 2020
#> 513            323        NA 2020
#> 514            136        NA 2020
#> 515            317        NA 2020
#> 516             14        NA 2020
#> 517            275        NA 2020
#> 518            198        NA 2020
#> 519            104        NA 2020
#> 520             27        NA 2020
#> 521            121        NA 2020
#> 522            251        NA 2020
#> 523             39        16 2020
#> 524             44        NA 2020
#> 525             77        NA 2020
#> 526            343        NA 2020
#> 527            107        NA 2020
#> 528            255        NA 2020
#> 529            113        NA 2020
#> 530            146        NA 2020
#> 531            213        NA 2020
#> 532            273        NA 2020
#> 533            288        NA 2020
#> 534            299        NA 2020
#> 535            185        NA 2020
#> 536             70        NA 2020
#> 537            256        NA 2020
#> 538            162        NA 2020
#> 539            187        NA 2020
#> 540            116        NA 2020
#> 541             63        NA 2020
#> 542             17        NA 2020
#> 543            177        NA 2020
#> 544             95        NA 2020
#> 545            277        NA 2020
#> 546            135        NA 2020
#> 547              6        NA 2020
#> 548            151        15 2020
#> 549            114        NA 2020
#> 550            179        NA 2020
#> 551            223        NA 2020
#> 552            278        NA 2020
#> 553            197        NA 2020
#> 554            137        NA 2020
#> 555            174        NA 2020
#> 556            286        NA 2020
#> 557            325        NA 2020
#> 558             54        NA 2020
#> 559            272        NA 2020
#> 560             36        NA 2020
#> 561            131        NA 2020
#> 562             53        NA 2020
#> 563             35        NA 2020
#> 564             15        NA 2020
#> 565            329        NA 2020
#> 566            292        NA 2020
#> 567            240        NA 2020
#> 568              8        NA 2020
#> 569            169        16 2020
#> 570            188        NA 2020
#> 571            231        NA 2020
#> 572            305        NA 2020
#> 573            247        NA 2020
#> 574            108        NA 2020
#> 575             62        NA 2020
#> 576            112        NA 2020
#> 577             56        NA 2020
#> 578            170        NA 2020
#> 579            183        NA 2020
#> 580            310        NA 2020
#> 581            132        NA 2020
#> 582            103        NA 2020
#> 583            311        NA 2020
#> 584            312        NA 2020
#> 585            122        NA 2020
#> 586            339        NA 2020
#> 587             99        NA 2020
#> 588            111        NA 2020
#> 589            168        NA 2020
#> 590            309        NA 2020
#> 591              5         7 2020
#> 592             82        NA 2020
#> 593            155        NA 2020
#> 594            226        NA 2020
#> 595            326        NA 2020
#> 596            349        NA 2020
#> 597            279        NA 2020
#> 598              9        NA 2020
#> 599             19        NA 2020
#> 600            294        NA 2020
#> 601            337        NA 2020
#> 602             25        NA 2020
#> 603             40        NA 2020
#> 604             61        NA 2020
#> 605            152        NA 2020
#> 606            221        NA 2020
#> 607            241        NA 2020
#> 608            283        NA 2020
#> 609             28        NA 2020
#> 610            220        NA 2020
#> 611            125        NA 2020
#> 612            153        NA 2020
#> 613            237        NA 2020
#> 614            123        NA 2020
#> 615            217        NA 2020
#> 616            254        NA 2020
#> 617             58        NA 2020
#> 618            192        NA 2020
#> 619            227        NA 2020
#> 620            347        NA 2020
#> 621            308        NA 2020
#> 622             80        NA 2020
#> 623            341        NA 2020
#> 624            348        NA 2020
#> 625            249        NA 2020
#> 626            189        NA 2020
#> 627            143        NA 2020
#> 628            282        NA 2020
#> 629            281        NA 2020
#> 630            201        NA 2020
#> 631            210        NA 2020
#> 632            313        NA 2020
#> 633            115        NA 2020
#> 634            232        NA 2020
#> 635            102        NA 2020
#> 636            293        NA 2020
#> 637            271        NA 2020
#> 638            126        NA 2020
#> 639            351        16 2020
#> 640             60        NA 2020
#> 641            285        NA 2020
#> 642            295        NA 2020
#> 643            350        NA 2020
#> 644            222        NA 2020
#> 645            336        NA 2020
#> 646            319        NA 2020
#> 647             86        NA 2020
#> 648            161        NA 2020
#> 649            253        NA 2020
#> 650             78        NA 2020
#> 651            184        NA 2020
#> 652            306        NA 2020
#> 653             88        NA 2020
#> 654            265        NA 2020
#> 655            301        NA 2020
#> 656            110        NA 2020
#> 657            318        NA 2020
#> 658            333        NA 2020
#> 659             30        NA 2020
#> 660            290        NA 2020
#> 661            303        NA 2020
#> 662             76        NA 2020
#> 663            298        NA 2020
#> 664            212        NA 2020
#> 665            267        NA 2020
#> 666             96        NA 2020
#> 667            262        NA 2020
#> 668            321        NA 2020
#> 669            106        NA 2020
#> 670            203        NA 2020
#> 671            158        NA 2020
#> 672            176        NA 2020
#> 673             73        NA 2020
#> 674            322        NA 2020
#> 675            147        NA 2020
#> 676            211        16 2020
#> 677            124        NA 2020
#> 678            314        NA 2020
#> 679            274        NA 2020
#> 680            335        NA 2020
#> 681            233        NA 2020
#> 682            287        NA 2020
#> 683            236        NA 2020
#> 684            352        NA 2020
#> 685            266        NA 2020
#> 686            307        NA 2020
#> 687            199        NA 2020
#> 688            342        NA 2020
#> 689            105        NA 2020
#> 690            334        NA 2020
#> 691             81        NA 2020
#> 692            328        NA 2020
#> 693            315        NA 2020
#> 694            204        NA 2020
#> 695            330        NA 2020
#> 696            239        NA 2020
#> 697            120        NA 2020
#> 698            260        NA 2020
#> 699            209        NA 2020
#> 700            304        NA 2020
#> 701            154        NA 2020
#> 702            263        NA 2020
#> 703            130        NA 2020
#> 704            206        NA 2020
#> 705            243        NA 2020
#> 706            330        NA 2020
#> 707            296        NA 2020
#> 708            134        NA 2020
#> 709            270        NA 2020
#> 710            344        NA 2020
# }
```
