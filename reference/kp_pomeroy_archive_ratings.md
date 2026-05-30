# **Get KenPom's ratings archive pages**

**Get KenPom's ratings archive pages**

## Usage

``` r
kp_pomeroy_archive_ratings(date)
```

## Arguments

- date:

  Date (YYYY-MM-DD)

## Value

A data frame with 22 columns:

|                |           |                                     |
|----------------|-----------|-------------------------------------|
| col_name       | types     | description                         |
| adj_em_rk      | numeric   | Adj em rk.                          |
| team           | character | Team-side label or team identifier. |
| conf           | character | character.                          |
| adj_em         | numeric   | Adj em.                             |
| adj_o          | numeric   | Adj o.                              |
| adj_o_rk       | numeric   | Adj o rk.                           |
| adj_d          | numeric   | Adj d.                              |
| adj_d_rk       | numeric   | Adj d rk.                           |
| adj_t          | numeric   | Adj t.                              |
| adj_t_rk       | numeric   | Adj t rk.                           |
| final_rk       | numeric   | Final rk.                           |
| final_adj_em   | numeric   | Final adj em.                       |
| final_adj_o    | numeric   | Final adj o.                        |
| final_adj_o_rk | numeric   | Final adj o rk.                     |
| final_adj_d    | numeric   | Final adj d.                        |
| final_adj_d_rk | numeric   | Final adj d rk.                     |
| final_adj_t    | numeric   | Final adj t.                        |
| final_adj_t_rk | numeric   | Final adj t rk.                     |
| rk_chg         | numeric   | Rk chg.                             |
| em_chg         | numeric   | Em chg.                             |
| adj_t_chg      | numeric   | Adj t chg.                          |
| ncaa_seed      | numeric   | Ncaa seed.                          |

## See also

Other KenPom Historical Functions:
[`kp_coach_history()`](https://hoopR.sportsdataverse.org/reference/kp_coach_history.md),
[`kp_confhistory()`](https://hoopR.sportsdataverse.org/reference/kp_confhistory.md),
[`kp_confstats()`](https://hoopR.sportsdataverse.org/reference/kp_confstats.md),
[`kp_conf()`](https://hoopR.sportsdataverse.org/reference/kp_conf.md),
[`kp_program_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_program_ratings.md),
[`kp_team_history()`](https://hoopR.sportsdataverse.org/reference/kp_team_history.md)

## Examples

``` r
# \donttest{
  try(kp_pomeroy_archive_ratings(date='2018-11-22'))
#>     adj_em_rk                       team conf adj_em adj_o adj_o_rk adj_d
#> 1           1                   Duke  E8  ACC  28.79 119.5        1  90.8
#> 2           2                 Kansas  R2  B12  28.04 117.1        4  89.1
#> 3           3        North Carolina  S16  ACC  26.47 116.8        5  90.3
#> 4           4               Virginia  CH  ACC  26.40 113.7       13  87.3
#> 5           5                 Nevada  R1  MWC  25.31 117.2        3  91.8
#> 6           6                Gonzaga  E8  WCC  24.97 117.8        2  92.8
#> 7           7              Michigan  S16  B10  23.13 109.9       37  86.7
#> 8           8                 Auburn  F4  SEC  22.62 114.1        9  91.5
#> 9           9           Florida St.  S16  ACC  22.17 114.1       10  91.9
#> 10         10             Tennessee  S16  SEC  22.14 113.5       14  91.3
#> 11         11           Michigan St.  F4  B10  20.97 113.9       11  93.0
#> 12         12            Texas Tech  2nd  B12  20.97 109.6       42  88.6
#> 13         13                 Purdue  E8  B10  20.79 115.9        7  95.1
#> 14         14              Wisconsin  R1  B10  20.56 112.4       19  91.8
#> 15         15               Kentucky  E8  SEC  20.55 115.1        8  94.6
#> 16         16             Kansas St.  R1  B12  19.85 109.7       41  89.8
#> 17         17               Syracuse  R1  ACC  19.79 109.9       36  90.1
#> 18         18         Virginia Tech  S16  ACC  19.76 116.1        6  96.4
#> 19         19               Iowa St.  R1  B12  19.63 113.1       18  93.4
#> 20         20                    Indiana  B10  18.90 111.2       24  92.3
#> 21         21                Oregon  S16  P12  18.77 111.5       22  92.8
#> 22         22                   Miami FL  ACC  18.57 111.3       23  92.7
#> 23         23              Villanova  R2   BE  18.37 113.1       17  94.7
#> 24         24              West Virginia  B12  18.34 110.5       29  92.2
#> 25         25                    Clemson  ACC  18.15 110.1       33  91.9
#> 26         26        Mississippi St.  R1  SEC  18.09 110.0       34  91.9
#> 27         27                      Texas  B12  17.74 108.9       47  91.1
#> 28         28               Ohio St.  R2  B10  17.57 110.2       30  92.6
#> 29         29                 N.C. State  ACC  17.05 113.7       12  96.7
#> 30         30                Florida  R2  SEC  16.90 108.2       55  91.3
#> 31         31                   Nebraska  B10  16.78 109.8       40  93.0
#> 32         32                   Iowa  R2  B10  16.40 113.4       15  97.0
#> 33         33                  Creighton   BE  15.84 111.9       21  96.0
#> 34         34              Marquette  R1   BE  15.78 112.0       20  96.2
#> 35         35                     Butler   BE  15.48 111.1       25  95.6
#> 36         36                   Penn St.  B10  15.44 106.7       79  91.2
#> 37         37               Maryland  R2  B10  14.91 110.5       28  95.6
#> 38         38               Oklahoma  R2  B12  14.09 108.4       51  94.3
#> 39         39                       UCLA  P12  13.75 110.1       31  96.3
#> 40         40               Houston  S16 Amer  13.58 110.0       35  96.4
#> 41         41            Arizona St.  R1  P12  13.55 109.5       44  95.9
#> 42         42                Buffalo  R2  MAC  13.44 109.8       38  96.4
#> 43         43             St. John's  R0   BE  13.20 110.1       32  96.9
#> 44         44                    UCF  R2 Amer  13.16 106.1       89  92.9
#> 45         45              Minnesota  R2  B10  13.13 109.0       45  95.9
#> 46         46             Cincinnati  R1 Amer  13.06 106.5       83  93.4
#> 47         47                   LSU  S16  SEC  12.83 113.1       16 100.3
#> 48         48               Northwestern  B10  12.83 106.0       90  93.2
#> 49         49             Washington  R2  P12  12.64 108.1       56  95.5
#> 50         50                        TCU  B12  12.26 108.3       53  96.1
#> 51         51                 Baylor  R2  B12  12.02 108.4       50  96.4
#> 52         52                   Arkansas  SEC  11.98 106.7       80  94.7
#> 53         53                        BYU  WCC  11.83 106.8       76  94.9
#> 54         54             South Carolina  SEC  11.41 105.0      102  93.6
#> 55         55                        USC  P12  11.22 108.9       46  97.7
#> 56         56                 Vanderbilt  SEC  11.20 108.2       54  97.0
#> 57         57             Louisville  R1  ACC  11.17 109.8       39  98.6
#> 58         58           Saint Mary's  R1  WCC  11.00 109.5       43  98.5
#> 59         59             Seton Hall  R1   BE  10.95 107.2       69  96.3
#> 60         60                    Arizona  P12  10.89 107.3       68  96.4
#> 61         61               Oklahoma St.  B12  10.79 106.3       85  95.5
#> 62         62                 Providence   BE  10.79 107.1       71  96.4
#> 63         63                    Alabama  SEC  10.57 105.9       92  95.4
#> 64         64                 Notre Dame  ACC  10.45 107.3       67  96.9
#> 65         65                     Xavier   BE  10.04 111.1       26 101.1
#> 66         66                     DePaul   BE   9.84 105.6       95  95.8
#> 67         67             Loyola Chicago  MVC   9.76 104.2      114  94.4
#> 68         68                  Texas A&M  SEC   9.49 106.7       78  97.2
#> 69         69                       Utah  P12   9.19 107.4       65  98.2
#> 70         70             Boston College  ACC   9.03 107.0       73  98.0
#> 71         71                Montana  R1 BSky   8.94 108.0       57  99.1
#> 72         72               Georgia Tech  ACC   8.81 100.9      185  92.1
#> 73         73                 Oregon St.  P12   8.69 106.2       88  97.5
#> 74         74              San Diego St.  MWC   8.65 107.2       70  98.6
#> 75         75            Mississippi  R1  SEC   8.43 107.5       63  99.0
#> 76         76                 Georgetown   BE   8.31 105.3       98  97.0
#> 77         77            Saint Louis  R1  A10   8.25 102.4      154  94.2
#> 78         78              San Francisco  WCC   8.21 102.2      158  94.0
#> 79         79           Western Kentucky CUSA   8.14 106.9       75  98.7
#> 80         80              UC Irvine  R2   BW   8.02 102.4      155  94.4
#> 81         81                        SMU Amer   7.98 108.9       48 100.9
#> 82         82                   Missouri  SEC   7.91 103.8      120  95.9
#> 83         83                   Davidson  A10   7.85 106.6       82  98.8
#> 84         84                   Marshall CUSA   7.76 107.8       61 100.1
#> 85         85                 Temple  R0 Amer   7.68 104.7      107  97.0
#> 86         86           South Dakota St.  Sum   7.68 110.9       27 103.2
#> 87         87             UNC Greensboro   SC   7.65 105.8       93  98.1
#> 88         88                Connecticut Amer   7.53 106.7       81  99.1
#> 89         89                Wichita St. Amer   7.53 107.8       62 100.2
#> 90         90             Saint Joseph's  A10   7.51 107.9       58 100.4
#> 91         91                     Dayton  A10   7.47 106.3       84  98.9
#> 92         92                Belmont  R1  OVC   7.44 108.3       52 100.9
#> 93         93                   Illinois  B10   7.42 106.7       77  99.3
#> 94         94               Utah St.  R1  MWC   7.30 105.2       99  97.9
#> 95         95            Georgia St.  R1   SB   7.28 106.3       86  99.0
#> 96         96           Northeastern  R1  CAA   7.17 107.9       59 100.8
#> 97         97                   Colorado  P12   7.16 106.0       91  98.8
#> 98         98                Bradley  R1  MVC   7.13 102.6      151  95.5
#> 99         99                     Toledo  MAC   7.10 108.9       49 101.7
#> 100       100                   Stanford  P12   6.96 103.1      142  96.1
#> 101       101                    Harvard  Ivy   6.70 103.7      121  97.0
#> 102       102                  San Diego  WCC   6.65 104.8      104  98.2
#> 103       103          Southern Illinois  MVC   6.63 103.0      144  96.3
#> 104       104           Old Dominion  R1 CUSA   6.33 100.7      192  94.4
#> 105       105         New Mexico St.  R1  WAC   5.89 105.2      100  99.3
#> 106       106                    VCU  R1  A10   5.36 100.1      208  94.7
#> 107       107                   Ball St.  MAC   5.34 105.6       96 100.2
#> 108       108                 Charleston  CAA   5.31 104.6      108  99.2
#> 109       109                    Rutgers  B10   5.29  99.8      219  94.5
#> 110       110                      Rider MAAC   5.27 104.9      103  99.7
#> 111       111                    Memphis Amer   5.24 105.5       97 100.3
#> 112       112               Rhode Island  A10   5.17 103.2      138  98.1
#> 113       113                   Lipscomb ASun   5.16 104.4      111  99.3
#> 114       114                Wake Forest  ACC   5.16 106.3       87 101.1
#> 115       115                 Fresno St.  MWC   5.16 103.3      133  98.1
#> 116       116           Loyola Marymount  WCC   5.13 103.5      128  98.3
#> 117       117                   Yale  R1  Ivy   4.96 104.8      105  99.8
#> 118       118                Wofford  R2   SC   4.94 107.3       66 102.4
#> 119       119             Murray St.  R2  OVC   4.87 104.5      109  99.7
#> 120       120             Louisiana Tech CUSA   4.76 103.1      141  98.3
#> 121       121                Vermont  R1   AE   4.75 107.1       72 102.3
#> 122       122                     Furman   SC   4.55 103.1      140  98.5
#> 123       123                  Louisiana   SB   4.48 105.1      101 100.6
#> 124       124                    Georgia  SEC   4.39 102.2      159  97.8
#> 125       125                 Pittsburgh  ACC   4.29 103.4      129  99.2
#> 126       126                  Boise St.  MWC   4.25 103.1      139  98.9
#> 127       127               Illinois St.  MVC   3.96 105.7       94 101.7
#> 128       128                      Tulsa Amer   3.81 104.5      110 100.7
#> 129       129                       UNLV  MWC   3.71 103.4      131  99.7
#> 130       130           Georgia Southern   SB   3.32 104.7      106 101.4
#> 131       131               Grand Canyon  WAC   3.32 101.9      165  98.6
#> 132       132                 Wright St. Horz   3.16 103.6      125 100.4
#> 133       133                      Akron  MAC   3.14 103.7      122 100.5
#> 134       134      Northern Kentucky  R1 Horz   3.13 103.3      132 100.2
#> 135       135                Liberty  R2 ASun   3.13 103.7      123 100.6
#> 136       136                    Radford BSth   2.95 103.9      119 100.9
#> 137       137                 New Mexico  MWC   2.94 107.0       74 104.0
#> 138       138                North Texas CUSA   2.93 104.3      113 101.3
#> 139       139                    Hofstra  CAA   2.47 107.5       64 105.0
#> 140       140         East Tennessee St.   SC   2.47 102.7      150 100.2
#> 141       141          Cal St. Fullerton   BW   2.39 100.8      189  98.4
#> 142       142                       Penn  Ivy   2.32 101.1      178  98.8
#> 143       143                     Lehigh  Pat   2.18 104.1      115 101.9
#> 144       144           Eastern Michigan  MAC   1.90 100.1      207  98.2
#> 145       145              Northern Iowa  MVC   1.70  99.7      221  98.0
#> 146       146              Southern Miss CUSA   1.62 101.9      166 100.2
#> 147       147                  Weber St. BSky   1.43 103.3      135 101.8
#> 148       148               George Mason  A10   1.25 103.4      130 102.1
#> 149       149                   Richmond  A10   1.24 103.9      118 102.7
#> 150       150                 Valparaiso  MVC   1.21 100.7      191  99.5
#> 151       151              Massachusetts  A10   1.17 103.6      124 102.5
#> 152       152                   Duquesne  A10   0.80 102.8      148 102.0
#> 153       153               South Dakota  Sum   0.77 100.2      204  99.5
#> 154       154          Stephen F. Austin Slnd   0.64 100.8      188 100.1
#> 155       155                    Pacific  WCC   0.64 104.4      112 103.8
#> 156       156                Indiana St.  MVC   0.59 100.9      184 100.3
#> 157       157          Northern Colorado BSky   0.52 102.8      147 102.2
#> 158       158             William & Mary  CAA   0.39 107.9       60 107.5
#> 159       159                   Iona  R1 MAAC   0.27 104.0      116 103.7
#> 160       160                 Holy Cross  Pat   0.14 101.3      177 101.2
#> 161       161                        UAB CUSA   0.03 102.2      160 102.2
#> 162       162                Utah Valley  WAC  -0.15  99.9      215 100.0
#> 163       163           Jacksonville St.  OVC  -0.32 100.5      194 100.8
#> 164       164            St. Bonaventure  A10  -0.33 100.3      200 100.7
#> 165       165                   Winthrop BSth  -0.53 102.1      162 102.6
#> 166       166                 California  P12  -0.55 100.8      186 101.3
#> 167       167           Middle Tennessee CUSA  -0.57  99.7      222 100.3
#> 168       168              James Madison  CAA  -0.59 100.7      190 101.3
#> 169       169           Central Michigan  MAC  -0.71 104.0      117 104.7
#> 170       170             St. Francis PA  NEC  -1.08 103.0      143 104.1
#> 171       171                       Ohio  MAC  -1.14  98.7      240  99.8
#> 172       172                   Miami OH  MAC  -1.17 103.6      127 104.7
#> 173       173                   Kent St.  MAC  -1.21 101.6      171 102.8
#> 174       174                     Tulane Amer  -1.29 101.0      183 102.2
#> 175       175           Illinois Chicago Horz  -1.52 102.5      153 104.0
#> 176       176                   Canisius MAAC  -1.63 102.9      145 104.6
#> 177       177                Colgate  R1  Pat  -1.65 102.3      157 103.9
#> 178       178            Appalachian St.   SB  -1.66 102.8      146 104.4
#> 179       179             Washington St.  P12  -1.69 103.2      137 104.9
#> 180       180           UC Santa Barbara   BW  -1.73 102.7      149 104.5
#> 181       181                   Delaware  CAA  -1.78 100.3      201 102.1
#> 182       182                  Princeton  Ivy  -1.83 101.1      179 102.9
#> 183       183          Northern Illinois  MAC  -1.86 102.2      161 104.0
#> 184       184               Missouri St.  MVC  -1.91  99.7      220 101.7
#> 185       185                    Wyoming  MWC  -2.10 101.6      175 103.7
#> 186       186                       Troy   SB  -2.15 103.2      136 105.4
#> 187       187                   American  Pat  -2.18  98.4      249 100.5
#> 188       188                       UTSA CUSA  -2.19 100.5      193 102.7
#> 189       189              Bowling Green  MAC  -2.22 101.0      182 103.2
#> 190       190                  Texas St.   SB  -2.50  97.5      268 100.0
#> 191       191                     Mercer   SC  -2.53 100.4      196 103.0
#> 192       192                      Brown  Ivy  -2.69  99.8      218 102.5
#> 193       193                   La Salle  A10  -2.92 101.6      173 104.5
#> 194       194                  Green Bay Horz  -3.04  99.5      224 102.6
#> 195       195          Purdue Fort Wayne  Sum  -3.08 101.7      168 104.8
#> 196       196       North Dakota St.  R1  Sum  -3.08 101.6      172 104.7
#> 197       197           Coastal Carolina   SB  -3.15 100.1      206 103.3
#> 198       198               Colorado St.  MWC  -3.31 101.7      170 105.0
#> 199       199              North Florida ASun  -3.38 103.6      126 107.0
#> 200       200                 Evansville  MVC  -3.41  96.8      279 100.2
#> 201       201                Stony Brook   AE  -3.43 100.0      209 103.5
#> 202       202        Cal St. Bakersfield  WAC  -3.44  96.5      284  99.9
#> 203       203                       UMBC   AE  -3.45  95.7      295  99.1
#> 204       204              South Alabama   SB  -3.62  97.5      269 101.1
#> 205       205                Austin Peay  OVC  -3.81 101.7      169 105.5
#> 206       206                 Pepperdine  WCC  -3.86 101.9      167 105.7
#> 207       207      Abilene Christian  R1 Slnd  -4.01  99.2      235 103.2
#> 208       208                     Hawaii   BW  -4.04  98.0      256 102.1
#> 209       209                   Hartford   AE  -4.13 100.0      212 104.1
#> 210       210             Nebraska Omaha  Sum  -4.16 101.0      180 105.2
#> 211       211               Morehead St.  OVC  -4.19 102.0      163 106.2
#> 212       212                     Denver  Sum  -4.25  98.6      245 102.8
#> 213       213                        FIU CUSA  -4.33  99.5      223 103.9
#> 214       214                Cal Baptist  WAC  -4.34  99.3      231 103.6
#> 215       215           Western Michigan  MAC  -4.40  99.9      214 104.3
#> 216       216         Eastern Washington BSky  -4.43  98.3      250 102.8
#> 217       217             UNC Wilmington  CAA  -4.48 101.6      174 106.1
#> 218       218               UT Arlington   SB  -4.49  98.2      251 102.7
#> 219       219                       NJIT ASun  -4.51 100.0      210 104.5
#> 220       220             Long Beach St.   BW  -4.54 100.0      211 104.5
#> 221       221                       Elon  CAA  -4.56 100.4      197 105.0
#> 222       222                   Bucknell  Pat  -4.65  99.5      225 104.2
#> 223       223                   Portland  WCC  -4.84 101.4      176 106.3
#> 224       224           Louisiana Monroe   SB  -4.86  98.1      253 103.0
#> 225       225                      Drake  MVC  -5.05  98.6      243 103.7
#> 226       226           Gardner Webb  R1 BSth  -5.10  99.3      232 104.4
#> 227       227                  Air Force  MWC  -5.21  97.3      272 102.5
#> 228       228          Boston University  Pat  -5.37 100.3      203 105.6
#> 229       229              South Florida Amer  -5.40  95.6      297 101.0
#> 230       230        Charleston Southern BSth  -5.43  98.6      242 104.1
#> 231       231              Saint Peter's MAAC  -5.46  96.8      280 102.3
#> 232       232                    Niagara MAAC  -5.50  99.5      226 105.0
#> 233       233           Western Illinois  Sum  -5.55  98.5      247 104.0
#> 234       234                The Citadel   SC  -5.55 103.3      134 108.8
#> 235       235                   Campbell BSth  -5.59 102.6      152 108.1
#> 236       236                     Wagner  NEC  -5.83  97.8      262 103.6
#> 237       237                    Seattle  WAC  -5.88  97.8      258 103.7
#> 238       238               North Dakota  Sum  -5.93  97.6      266 103.6
#> 239       239               Portland St. BSky  -5.95  99.5      227 105.4
#> 240       240                     Albany   AE  -6.02  97.6      267 103.6
#> 241       241         Florida Gulf Coast ASun  -6.03  98.6      241 104.7
#> 242       242          George Washington  A10  -6.16  98.1      255 104.2
#> 243       243                Santa Clara  WCC  -6.18  97.8      260 104.0
#> 244       244                    Oakland Horz  -6.28 100.1      205 106.4
#> 245       245             Sacramento St. BSky  -6.29  96.4      285 102.7
#> 246       246                 High Point BSth  -6.32  98.8      238 105.1
#> 247       247                    Fordham  A10  -6.38  95.8      294 102.2
#> 248       248        Central Connecticut  NEC  -6.46 102.4      156 108.8
#> 249       249                      IUPUI Horz  -6.54  97.0      276 103.5
#> 250       250                     Marist MAAC  -6.56 100.4      199 106.9
#> 251       251                      Lamar Slnd  -6.58  98.1      252 104.7
#> 252       252                  Fairfield MAAC  -6.67  98.1      254 104.7
#> 253       253                   UC Davis   BW  -6.67  93.6      321 100.3
#> 254       254                  Idaho St. BSky  -6.67 101.0      181 107.7
#> 255       255    Fairleigh Dickinson  R1  NEC  -6.76 100.5      195 107.2
#> 256       256                   Monmouth MAAC  -6.79  96.4      286 103.2
#> 257       257              Southern Utah BSky  -6.82  97.6      265 104.5
#> 258       258                      Siena MAAC  -6.87 100.3      202 107.2
#> 259       259                  Dartmouth  Ivy  -6.93 100.4      198 107.3
#> 260       260                Little Rock   SB  -6.95  95.4      301 102.4
#> 261       261                     Drexel  CAA  -7.10 100.8      187 107.9
#> 262       262                    Samford   SC  -7.13  99.4      228 106.6
#> 263       263                   Columbia  Ivy  -7.15 102.0      164 109.2
#> 264       264                    Cornell  Ivy  -7.22  99.4      229 106.6
#> 265       265                       Army  Pat  -7.28  99.2      234 106.5
#> 266       266           Florida Atlantic CUSA  -7.41  98.6      244 106.0
#> 267       267                      Idaho BSky  -7.53  99.8      216 107.4
#> 268       268                  Milwaukee Horz  -7.54  96.4      287 103.9
#> 269       269           Eastern Kentucky  OVC  -7.57  99.2      233 106.8
#> 270       270                    Hampton BSth  -7.64  96.8      278 104.5
#> 271       271              East Carolina Amer  -7.81  94.0      317 101.8
#> 272       272              Robert Morris  NEC  -7.90  94.2      314 102.1
#> 273       273                 Quinnipiac MAAC  -7.91  97.5      271 105.4
#> 274       274             Texas Southern SWAC  -7.97  96.9      277 104.9
#> 275       275               Oral Roberts  Sum  -8.15  97.7      263 105.8
#> 276       276            Sam Houston St. Slnd  -8.74  97.3      273 106.0
#> 277       277       Prairie View A&M  R0 SWAC  -8.76  97.5      270 106.3
#> 278       278                  Manhattan MAAC  -8.82  91.0      343  99.8
#> 279       279                       Rice CUSA  -9.10  99.1      236 108.2
#> 280       280               LIU Brooklyn  NEC  -9.27  99.9      213 109.2
#> 281       281     Southeast Missouri St.  OVC  -9.39  96.2      290 105.6
#> 282       282           Tennessee Martin  OVC  -9.54  97.7      264 107.2
#> 283       283           Eastern Illinois  OVC  -9.58  92.5      330 102.1
#> 284       284              Tennessee St.  OVC  -9.60  94.2      315 103.8
#> 285       285                       UMKC  WAC  -9.63  96.5      282 106.1
#> 286       286               Presbyterian BSth  -9.94  97.0      274 107.0
#> 287       287                    Detroit Horz  -9.97  98.9      237 108.8
#> 288       288           Central Arkansas Slnd  -9.99  97.0      275 107.0
#> 289       289               Jacksonville ASun -10.16  95.3      304 105.5
#> 290       290                Norfolk St. MEAC -10.26  94.9      309 105.2
#> 291       291               Nicholls St. Slnd -10.29  95.5      298 105.8
#> 292       292               Arkansas St.   SB -10.32  98.5      246 108.8
#> 293       293                       UTEP CUSA -10.33  95.0      308 105.3
#> 294       294                     Towson  CAA -10.34  95.5      299 105.8
#> 295       295               UMass Lowell   AE -10.40  99.8      217 110.2
#> 296       296                     Howard MEAC -10.42  98.0      257 108.4
#> 297       297     Southeastern Louisiana Slnd -10.43  92.7      328 103.1
#> 298       298            Houston Baptist Slnd -10.44  98.8      239 109.2
#> 299       299 North Carolina Central  R0 MEAC -10.60  96.5      283 107.1
#> 300       300                 Binghamton   AE -10.65  94.1      316 104.8
#> 301       301           Northern Arizona BSky -10.82  95.6      296 106.4
#> 302       302                  Loyola MD  Pat -10.90  95.5      300 106.4
#> 303       303       UT Rio Grande Valley  WAC -10.97  93.9      319 104.8
#> 304       304                Montana St. BSky -11.02  99.4      230 110.4
#> 305       305                  Charlotte CUSA -11.10  94.7      311 105.8
#> 306       306                New Orleans Slnd -11.12  95.3      305 106.4
#> 307       307              Grambling St. SWAC -11.33  95.2      306 106.5
#> 308       308            Bethune Cookman MEAC -11.43  95.9      293 107.3
#> 309       309     Texas A&M Corpus Chris Slnd -11.77  93.4      322 105.2
#> 310       310                        VMI   SC -11.80  96.7      281 108.5
#> 311       311                       Navy  Pat -11.80  93.3      324 105.1
#> 312       312                  Lafayette  Pat -11.83  98.4      248 110.2
#> 313       313              Cleveland St. Horz -11.84  96.1      291 107.9
#> 314       314             St. Francis NY  NEC -11.92  96.2      288 108.2
#> 315       315               UC Riverside   BW -12.28  92.5      331 104.8
#> 316       316                   Longwood BSth -12.51  91.5      337 104.0
#> 317       317               San Jose St.  MWC -12.70  92.4      332 105.1
#> 318       318               Sacred Heart  NEC -12.74  97.8      261 110.5
#> 319       319           SIU Edwardsville  OVC -12.99  95.4      303 108.3
#> 320       320                Alabama St. SWAC -13.30  95.1      307 108.4
#> 321       321             Youngstown St. Horz -13.34  96.1      292 109.4
#> 322       322                   Cal Poly   BW -13.71  93.2      325 106.9
#> 323       323                USC Upstate BSth -13.72  95.4      302 109.1
#> 324       324              UNC Asheville BSth -13.81  91.4      338 105.2
#> 325       325                     Bryant  NEC -14.05  97.8      259 111.9
#> 326       326             Tennessee Tech  OVC -14.10  91.4      340 105.5
#> 327       327               Kennesaw St. ASun -14.38  91.7      335 106.1
#> 328       328                Chattanooga   SC -14.39  91.6      336 106.0
#> 329       329              New Hampshire   AE -14.89  92.2      333 107.1
#> 330       330           Western Carolina   SC -14.91  92.5      329 107.4
#> 331       331         Cal St. Northridge   BW -15.30  94.2      313 109.5
#> 332       332              North Alabama ASun -15.40  93.9      318 109.3
#> 333       333                McNeese St. Slnd -15.51  94.4      312 109.9
#> 334       334                      Maine   AE -15.68  91.4      339 107.1
#> 335       335                 Morgan St. MEAC -15.95  92.0      334 107.9
#> 336       336           Mount St. Mary's  NEC -15.96  93.0      327 108.9
#> 337       337         North Carolina A&T MEAC -16.02  96.2      289 112.2
#> 338       338                    Stetson ASun -17.57  93.3      323 110.9
#> 339       339                   Southern SWAC -17.76  91.2      341 108.9
#> 340       340             Incarnate Word Slnd -18.01  94.8      310 112.8
#> 341       341           Northwestern St. Slnd -18.49  90.2      345 108.7
#> 342       342               Savannah St. MEAC -18.74  93.8      320 112.5
#> 343       343                 Alcorn St. SWAC -19.27  89.5      347 108.8
#> 344       344        Arkansas Pine Bluff SWAC -19.40  91.1      342 110.5
#> 345       345         South Carolina St. MEAC -19.88  93.1      326 112.9
#> 346       346     Mississippi Valley St. SWAC -20.17  91.0      344 111.1
#> 347       347     Maryland Eastern Shore MEAC -20.48  89.1      348 109.6
#> 348       348                Florida A&M MEAC -20.58  88.5      351 109.0
#> 349       349                Chicago St.  WAC -21.71  90.0      346 111.7
#> 350       350                 Coppin St. MEAC -22.10  88.1      352 110.2
#> 351       351                Alabama A&M SWAC -22.63  89.0      349 111.6
#> 352       352                Jackson St. SWAC -22.99  84.8      353 107.8
#> 353       353               Delaware St. MEAC -26.04  88.5      350 114.5
#>     adj_d_rk adj_t adj_t_rk final_rk final_adj_em final_adj_o final_adj_o_rk
#> 1          8  72.9       65        4        30.62       120.0              7
#> 2          4  73.4       48       17        21.57       113.9             27
#> 3          7  75.6       11        7        27.69       119.7              8
#> 4          2  64.0      352        1        34.22       123.4              2
#> 5         15  72.5       89       27        18.18       114.0             26
#> 6         25  73.8       35        2        32.85       124.5              1
#> 7          1  67.3      338        6        28.32       114.5             24
#> 8         13  71.4      146       11        25.00       120.9              6
#> 9         17  72.8       70       14        22.39       112.8             36
#> 10        12  70.1      227       10        26.24       122.7              3
#> 11        27  73.4       45        3        30.81       121.0              5
#> 12         3  68.3      313        5        30.03       114.1             25
#> 13        45  69.8      245        9        26.81       122.5              4
#> 14        14  66.8      346       16        21.94       110.4             62
#> 15        40  72.3       95        8        27.57       117.6             14
#> 16         5  69.3      270       20        20.06       108.4             98
#> 17         6  70.1      230       39        15.13       110.5             59
#> 18        65  69.9      237       13        24.07       118.1             11
#> 19        30  70.4      214       15        22.09       118.9              9
#> 20        21  71.6      132       52        13.73       109.1             82
#> 21        24  69.4      268       28        17.86       109.5             74
#> 22        23  69.2      273       75         9.03       109.9             68
#> 23        43  69.7      253       30        17.33       116.5             16
#> 24        20  71.7      127       95         7.15       109.8             71
#> 25        18  70.3      217       36        16.14       108.0            106
#> 26        16  69.2      276       21        20.04       117.7             13
#> 27         9  69.8      250       25        19.11       113.5             29
#> 28        22  67.8      330       44        14.66       109.1             84
#> 29        69  73.4       46       41        14.98       113.1             34
#> 30        11  69.8      248       26        18.30       110.5             61
#> 31        28  70.2      221       47        14.35       113.5             30
#> 32        75  73.7       37       37        16.02       117.4             15
#> 33        56  72.9       69       55        12.67       112.0             47
#> 34        59  70.9      172       33        16.52       113.2             32
#> 35        51  69.5      259       72         9.24       111.3             53
#> 36        10  69.5      257       43        14.89       109.4             77
#> 37        50  70.6      189       24        19.29       113.4             31
#> 38        35  74.7       17       32        16.94       111.1             57
#> 39        61  75.3       12      102         6.34       109.0             88
#> 40        64  68.3      310       12        24.13       115.3             19
#> 41        55  73.7       36       57        11.55       109.7             73
#> 42        67  74.5       23       22        19.85       115.2             21
#> 43        70  73.3       50       88         7.61       108.6             92
#> 44        26  68.4      306       34        16.51       112.1             44
#> 45        53  71.6      131       46        14.35       111.4             52
#> 46        31  66.9      344       29        17.50       112.3             42
#> 47       136  71.6      129       19        20.22       117.7             12
#> 48        29  68.2      316       74         9.06       102.9            204
#> 49        47  69.9      238       48        14.28       107.7            110
#> 50        57  70.6      187       40        15.04       110.3             64
#> 51        68  67.8      329       35        16.48       115.3             20
#> 52        41  74.1       33       54        12.92       110.1             66
#> 53        44  74.5       20       86         7.72       112.0             46
#> 54        32  72.8       72       70         9.55       108.1            104
#> 55        79  73.3       49       82         8.25       109.8             72
#> 56        73  72.2      104      155         0.81       102.2            215
#> 57        97  72.5       85       23        19.35       113.7             28
#> 58        93  65.8      350       31        17.31       114.7             23
#> 59        60  71.2      159       60        11.50       109.0             87
#> 60        66  70.4      208       94         7.35       105.5            153
#> 61        48  71.6      130       83         8.16       109.5             75
#> 62        63  70.1      228       79         8.65       105.0            164
#> 63        46  69.8      247       64        10.68       108.2            103
#> 64        71  67.6      334       97         6.95       108.0            105
#> 65       152  70.3      216       65        10.60       111.1             56
#> 66        52  70.5      199      118         5.02       111.7             49
#> 67        38  70.2      223      131         4.18       104.2            180
#> 68        77  71.4      147       91         7.49       107.2            120
#> 69        89  69.4      267      109         5.85       114.8             22
#> 70        82  71.0      164      127         4.52       107.2            119
#> 71       106  70.5      204      137         3.53       107.4            114
#> 72        19  71.4      145      115         5.26       101.7            228
#> 73        78  68.1      319       81         8.33       111.7             48
#> 74        95  69.5      258      125         4.83       103.9            184
#> 75       105  71.4      144       50        13.98       113.2             33
#> 76        74  73.1       57      100         6.45       108.9             90
#> 77        34  69.1      282      106         6.02       102.2            214
#> 78        33  70.5      200       67         9.93       112.0             45
#> 79        98  70.7      182      116         5.20       105.1            162
#> 80        37  68.1      320       73         9.16       107.4            118
#> 81       148  67.0      342      107         5.98       112.7             38
#> 82        54  68.3      311       68         9.78       107.0            127
#> 83        99  68.5      301       85         7.78       108.2            102
#> 84       125  77.7        4      157         0.56       106.9            128
#> 85        72  70.9      176       69         9.72       109.2             80
#> 86       199  71.4      140       92         7.46       112.7             37
#> 87        86  69.3      269       87         7.63       106.4            141
#> 88       108  72.2       97       98         6.78       109.0             85
#> 89       130  70.5      202       66        10.10       106.6            135
#> 90       138  70.4      210      189        -1.89       105.4            159
#> 91       102  68.5      304       62        11.27       112.1             43
#> 92       150  74.1       31       49        14.09       115.6             18
#> 93       113  73.5       42       84         7.97       109.1             83
#> 94        81  74.4       25       38        15.41       112.6             39
#> 95       104  70.5      198      124         4.85       107.7            111
#> 96       146  67.7      332       89         7.59       111.0             58
#> 97       101  70.9      173       63        10.75       106.8            131
#> 98        49  68.4      308      161         0.09       101.5            234
#> 99       162  70.7      183       61        11.29       109.8             70
#> 100       58  72.2       98      112         5.47       103.7            187
#> 101       76  70.2      225      114         5.32       105.7            150
#> 102       87  69.1      281       90         7.58       105.9            147
#> 103       62  68.2      315      146         1.79       104.6            172
#> 104       36  67.0      340      113         5.45       101.4            238
#> 105      112  70.4      205       53        13.62       113.0             35
#> 106       42  72.2       99       42        14.89       104.3            177
#> 107      131  70.9      171      133         3.91       102.5            209
#> 108      110  67.4      337      123         4.87       108.5             93
#> 109       39  70.4      213       78         8.76       105.6            152
#> 110      117  76.2        7      212        -4.44       101.5            236
#> 111      134  72.4       92       56        11.78       109.2             81
#> 112       84  71.2      157      142         2.44       103.8            185
#> 113      111  77.4        6       45        14.55       111.7             50
#> 114      153  70.3      215      174        -0.93       104.4            175
#> 115       85  71.3      152       71         9.36       108.4            100
#> 116       91  68.1      318      134         3.84       103.6            191
#> 117      121  72.6       81       77         8.79       111.6             51
#> 118      179  67.5      335       18        20.69       118.1             10
#> 119      116  69.3      271       51        13.83       112.5             41
#> 120       90  70.8      178      141         2.88       105.0            163
#> 121      177  67.9      328       76         8.86       108.5             97
#> 122       94  70.5      197       59        11.52       108.9             89
#> 123      143  72.6       83      178        -1.21       106.7            133
#> 124       80  72.0      109      132         4.13       106.1            143
#> 125      109  70.0      233      101         6.35       104.9            168
#> 126      103  70.5      203      139         3.13       107.4            116
#> 127      161  70.6      193      205        -3.45       101.4            240
#> 128      145  71.1      162      119         4.94       105.4            158
#> 129      118  70.6      186      165        -0.29       106.1            146
#> 130      159  74.9       15      103         6.33       108.5             94
#> 131       96  71.6      137      111         5.49       107.6            113
#> 132      139  70.6      192      117         5.02       107.1            122
#> 133      140  68.5      302      108         5.87       100.0            259
#> 134      128  70.7      180       96         7.14       109.4             76
#> 135      142  67.8      331       58        11.54       111.1             54
#> 136      149  67.5      336      122         4.88       109.3             79
#> 137      220  74.7       16      188        -1.85       104.1            183
#> 138      157  67.0      341      158         0.53        99.8            265
#> 139      252  70.3      220       93         7.37       116.4             17
#> 140      127  69.0      287       80         8.48       109.9             67
#> 141       92  72.5       86      210        -4.15        98.3            286
#> 142      100  71.7      126      130         4.21       104.1            181
#> 143      165  73.0       58      169        -0.79       108.9             91
#> 144       88  68.3      309      159         0.47       103.4            195
#> 145       83  68.9      292      177        -1.15       101.5            235
#> 146      132  68.0      323      120         4.93       107.1            121
#> 147      164  72.7       75      224        -5.03       101.7            229
#> 148      171  71.7      122      156         0.56       104.6            173
#> 149      187  69.6      256      203        -3.31       107.0            125
#> 150      115  68.0      324      220        -4.89        98.2            291
#> 151      180  71.0      166      236        -6.29       102.9            203
#> 152      166  69.1      280      173        -0.90       104.6            171
#> 153      114  70.9      175      229        -5.61       100.6            253
#> 154      126  71.7      123      311       -12.94        95.5            320
#> 155      211  69.0      283      216        -4.56       100.0            256
#> 156      137  71.9      116      208        -3.99       101.4            239
#> 157      174  72.8       73      193        -2.27       102.6            206
#> 158      307  71.0      165      219        -4.79       103.6            190
#> 159      209  74.5       24      198        -2.88       106.9            129
#> 160      155  65.5      351      239        -6.81       101.2            244
#> 161      173  71.2      158      147         1.70       107.1            123
#> 162      123  71.7      119      104         6.22       108.5             96
#> 163      147  70.7      181      110         5.81       105.4            157
#> 164      144  69.2      272      121         4.92       102.1            218
#> 165      184  75.6       10      168        -0.74       107.0            126
#> 166      158  69.2      274      241        -6.84       103.5            192
#> 167      133  73.6       39      246        -7.28        98.3            288
#> 168      156  69.8      249      285       -10.03       101.1            247
#> 169      237  71.9      115      129         4.27       110.4             63
#> 170      224  71.6      135      261        -8.04       105.5            155
#> 171      120  73.4       47      184        -1.55        98.9            278
#> 172      241  68.8      294      148         1.62       104.8            169
#> 173      191  71.9      114      143         2.38       109.9             69
#> 174      175  71.4      143      283        -9.99        97.3            300
#> 175      221  73.6       40      196        -2.78       100.8            249
#> 176      236  71.7      124      282        -9.91       101.6            230
#> 177      215  68.6      298      126         4.60       110.5             60
#> 178      229  73.2       54      206        -3.53       106.2            142
#> 179      248  72.5       84      207        -3.79       106.4            140
#> 180      230  68.6      300      172        -0.86       105.3            160
#> 181      169  69.0      288      265        -8.28       104.9            165
#> 182      192  67.6      333      175        -1.06        98.9            279
#> 183      217  69.2      275      136         3.72       109.0             86
#> 184      160  72.1      105      171        -0.85       103.1            199
#> 185      208  72.2      102      317       -13.86        95.1            325
#> 186      261  69.1      279      249        -7.49       102.9            202
#> 187      141  68.0      325      200        -3.12       102.1            220
#> 188      185  72.9       63      149         1.54       105.8            148
#> 189      197  72.2      100      105         6.04       108.4             99
#> 190      124  66.9      345      138         3.53       102.4            212
#> 191      193  68.2      314      199        -3.06       103.4            193
#> 192      182  74.5       22      153         1.24        99.6            269
#> 193      235  71.4      141      228        -5.39       100.0            257
#> 194      183  75.8        8      185        -1.56       104.9            166
#> 195      245  75.2       13      192        -2.17       106.8            130
#> 196      239  68.2      317      202        -3.20       107.4            117
#> 197      200  71.0      167      154         1.03       106.8            132
#> 198      249  70.7      184      180        -1.39       107.6            112
#> 199      294  74.3       27      167        -0.69       104.1            182
#> 200      129  72.5       87      227        -5.20        99.7            268
#> 201      201  70.7      185      166        -0.42        99.5            271
#> 202      122  69.0      284      226        -5.13       102.6            207
#> 203      107  70.6      195      230        -5.75        96.2            313
#> 204      154  72.2       96      214        -4.52       103.1            200
#> 205      266  71.7      121      128         4.29       111.1             55
#> 206      269  75.1       14      151         1.43       107.0            124
#> 207      196  69.8      244      152         1.35       103.4            196
#> 208      168  69.8      242      201        -3.12       103.7            188
#> 209      223  70.2      224      194        -2.32       108.5             95
#> 210      256  72.9       66      164        -0.20       110.2             65
#> 211      280  71.7      120      245        -7.27       102.7            205
#> 212      190  68.0      321      312       -13.05        99.9            261
#> 213      213  78.5        2      204        -3.41       102.4            211
#> 214      205  71.6      136      197        -2.82       106.1            144
#> 215      227  71.2      155      255        -7.82        99.2            275
#> 216      189  69.9      240      237        -6.36       101.3            242
#> 217      277  72.7       74      272        -9.31       105.4            156
#> 218      186  72.1      106      150         1.45       101.3            241
#> 219      233  67.3      339      183        -1.54       101.8            227
#> 220      234  74.6       19      225        -5.08       101.3            243
#> 221      250  71.3      149      309       -12.41        99.0            277
#> 222      225  71.3      150      145         1.85       105.8            149
#> 223      281  69.7      252      326       -15.64        94.6            329
#> 224      194  68.6      297      140         2.90       112.5             40
#> 225      207  72.9       64      135         3.76       106.5            137
#> 226      228  70.6      196      163        -0.04       107.8            109
#> 227      181  68.5      303      243        -7.06       100.6            252
#> 228      268  70.0      234      231        -5.96       104.4            176
#> 229      151  69.4      262       99         6.63       102.6            208
#> 230      222  71.6      134      160         0.17       101.1            246
#> 231      176  68.4      307      316       -13.63        94.7            327
#> 232      251  73.3       51      315       -13.52       101.8            225
#> 233      218  71.6      128      294       -10.86        97.6            296
#> 234      322  78.2        3      257        -7.83       106.7            134
#> 235      313  69.4      264      181        -1.49       108.3            101
#> 236      204  69.8      251      314       -13.51        93.9            331
#> 237      210  71.6      133      190        -1.99       100.8            248
#> 238      203  72.9       62      271        -8.76        97.6            297
#> 239      263  74.5       21      286       -10.21       101.9            224
#> 240      206  67.9      327      279        -9.86        98.4            285
#> 241      238  72.6       78      213        -4.52       101.6            233
#> 242      226  70.1      226      293       -10.81        95.4            321
#> 243      216  69.8      246      186        -1.77       102.1            217
#> 244      285  70.6      191      187        -1.77       107.8            107
#> 245      188  70.1      231      274        -9.44        96.6            309
#> 246      254  66.3      348      223        -5.00        99.7            267
#> 247      172  67.9      326      260        -8.00        96.7            306
#> 248      323  68.9      290      321       -14.89        97.2            301
#> 249      202  71.1      161      191        -2.07       103.8            186
#> 250      293  66.3      347      276        -9.52       100.2            254
#> 251      240  70.9      170      217        -4.66       103.3            197
#> 252      242  70.4      212      301       -11.43        96.0            317
#> 253      135  69.2      277      252        -7.61        96.5            310
#> 254      308  70.6      188      329       -16.18       102.2            216
#> 255      302  72.6       82      211        -4.22       106.5            139
#> 256      198  72.6       80      295       -10.89        93.2            336
#> 257      232  73.0       60      273        -9.40        96.4            311
#> 258      300  63.5      353      267        -8.38       100.7            251
#> 259      304  70.1      229      218        -4.70       103.4            194
#> 260      178  72.7       77      222        -4.99       100.0            260
#> 261      310  72.2      101      251        -7.57       105.6            151
#> 262      289  72.6       79      144         1.88       106.6            136
#> 263      330  73.2       56      215        -4.55       101.9            222
#> 264      290  72.4       94      221        -4.99        99.9            264
#> 265      287  73.0       59      242        -6.89        96.3            312
#> 266      274  70.0      235      162         0.03        99.9            263
#> 267      305  69.4      265      348       -23.78        95.2            324
#> 268      214  69.5      260      296       -11.00        98.6            283
#> 269      291  77.6        5      235        -6.23        99.8            266
#> 270      231  74.3       28      170        -0.85       107.4            115
#> 271      163  74.6       18      264        -8.24        98.7            282
#> 272      170  71.0      163      269        -8.72        96.1            314
#> 273      262  69.6      255      234        -6.21       105.5            154
#> 274      247  75.7        9      195        -2.35       105.2            161
#> 275      273  70.7      179      290       -10.54       103.7            189
#> 276      275  68.9      293      176        -1.09       106.1            145
#> 277      282  72.4       90      209        -4.13       102.1            219
#> 278      119  66.2      349      323       -15.15        89.6            346
#> 279      315  72.4       93      248        -7.45       103.2            198
#> 280      331  73.6       38      263        -8.20        98.3            290
#> 281      267  71.4      142      308       -12.22        97.8            294
#> 282      301  70.9      177      289       -10.35       104.9            167
#> 283      167  70.5      201      307       -11.94       100.0            258
#> 284      212  72.4       91      292       -10.73        98.9            280
#> 285      279  72.0      113      238        -6.45       101.1            245
#> 286      295  68.6      299      179        -1.32       109.3             78
#> 287      324  72.1      108      233        -6.11       106.5            138
#> 288      296  74.4       26      302       -11.44        99.9            262
#> 289      264  71.8      117      247        -7.41        99.1            276
#> 290      257  70.4      209      244        -7.23        98.5            284
#> 291      271  72.7       76      310       -12.85        98.7            281
#> 292      325  73.2       55      254        -7.80       102.4            210
#> 293      260  71.3      151      299       -11.31        90.1            343
#> 294      272  69.0      285      291       -10.67       100.2            255
#> 295      340  73.9       34      258        -7.86       104.5            174
#> 296      317  72.9       68      305       -11.89       102.0            221
#> 297      195  70.0      236      232        -6.07        99.5            272
#> 298      332  74.1       32      281        -9.88       103.0            201
#> 299      299  66.9      343      303       -11.55        97.8            295
#> 300      244  72.0      110      332       -16.74        96.1            316
#> 301      286  72.5       88      304       -11.83       100.8            250
#> 302      283  71.0      168      270        -8.72       101.8            226
#> 303      246  73.6       41      182        -1.50        99.6            270
#> 304      341  71.4      148      250        -7.57       107.8            108
#> 305      270  68.5      305      297       -11.16        95.6            319
#> 306      284  68.9      289      262        -8.10        97.0            302
#> 307      288  73.5       44      268        -8.56        95.9            318
#> 308      303  74.2       29      306       -11.92        93.6            332
#> 309      258  68.0      322      287       -10.25        94.6            328
#> 310      319  71.2      156      288       -10.30       102.4            213
#> 311      253  68.7      295      280        -9.88        97.3            299
#> 312      339  71.6      138      298       -11.27       101.6            231
#> 313      311  70.2      222      278        -9.70       101.9            223
#> 314      314  71.3      154      275        -9.50        96.1            315
#> 315      243  69.5      261      322       -15.09        98.3            289
#> 316      219  69.9      241      256        -7.83        99.5            274
#> 317      255  71.1      160      343       -21.99        92.0            339
#> 318      343  72.0      112      240        -6.81       104.2            179
#> 319      316  71.5      139      330       -16.21        96.9            304
#> 320      318  70.6      190      328       -15.77        95.2            323
#> 321      334  73.5       43      259        -7.97       104.3            178
#> 322      292  68.7      296      334       -17.86        97.0            303
#> 323      329  71.3      153      336       -18.10        93.3            334
#> 324      259  69.4      266      347       -23.64        93.3            333
#> 325      348  71.7      125      327       -15.64        99.5            273
#> 326      265  74.2       30      320       -14.87        89.9            345
#> 327      278  69.7      254      339       -18.91        92.0            338
#> 328      276  70.3      218      266        -8.29       101.5            237
#> 329      297  70.4      206      345       -23.05        84.4            353
#> 330      306  73.2       52      277        -9.58       101.6            232
#> 331      335  73.2       53      253        -7.74       104.8            170
#> 332      333  72.9       67      284       -10.02        95.3            322
#> 333      337  69.4      263      331       -16.74        98.1            292
#> 334      298  68.3      312      338       -18.68        93.3            335
#> 335      312  72.2      103      333       -17.85        92.8            337
#> 336      327  70.9      174      324       -15.28        94.8            326
#> 337      349  69.1      278      300       -11.32        96.8            305
#> 338      344  72.1      107      325       -15.46        97.9            293
#> 339      326  70.4      211      335       -17.91        94.2            330
#> 340      351  69.0      286      346       -23.06        97.5            298
#> 341      320  72.8       71      341       -19.81        90.1            342
#> 342      350  83.2        1      340       -19.45        96.6            307
#> 343      321  70.0      232      349       -24.07        89.3            348
#> 344      342  70.3      219      313       -13.14        96.6            308
#> 345      352  70.4      207      337       -18.50        98.3            287
#> 346      345  71.7      118      350       -24.63        89.9            344
#> 347      336  68.9      291      353       -29.42        85.4            351
#> 348      328  69.9      239      318       -13.89        89.4            347
#> 349      347  73.0       61      351       -28.26        90.4            340
#> 350      338  72.0      111      342       -20.33        88.9            349
#> 351      346  69.8      243      344       -22.17        87.0            350
#> 352      309  70.6      194      319       -14.40        90.2            341
#> 353      353  71.0      169      352       -29.31        84.5            352
#>     final_adj_d final_adj_d_rk final_adj_t final_adj_t_rk rk_chg em_chg
#> 1          89.3              6        72.1             20     -3   1.83
#> 2          92.3             17        70.1             66    -15  -6.47
#> 3          92.0             15        74.3              6     -4   1.22
#> 4          89.2              5        59.4            353      3   7.81
#> 5          95.9             35        69.3             91    -22  -7.12
#> 6          91.6             12        70.2             62      4   7.88
#> 7          86.2              2        64.8            317      1   5.19
#> 8          95.9             36        67.9            155     -3   2.38
#> 9          90.4             10        68.6            121     -5   0.22
#> 10         96.5             42        67.8            164     NA   4.10
#> 11         90.2              9        66.9            211      8   9.83
#> 12         84.1              1        66.6            231      7   9.07
#> 13         95.6             34        65.9            268      4   6.02
#> 14         88.5              4        63.9            331     -2   1.38
#> 15         90.1              8        65.6            284      7   7.02
#> 16         88.4              3        63.4            339     -4   0.21
#> 17         95.3             30        66.1            257    -22  -4.66
#> 18         94.0             20        63.7            334      5   4.31
#> 19         96.8             47        67.7            171      4   2.46
#> 20         95.4             32        66.9            215    -32  -5.17
#> 21         91.7             13        64.2            328     -7  -0.91
#> 22        100.8            104        67.0            208    -53  -9.54
#> 23         99.2             81        63.6            335     -7  -1.04
#> 24        102.7            135        70.6             49    -71 -11.19
#> 25         91.8             14        66.2            252    -11  -2.01
#> 26         97.6             61        67.8            161      5   1.94
#> 27         94.4             26        64.7            320      2   1.37
#> 28         94.4             25        65.8            274    -16  -2.91
#> 29         98.1             62        71.0             39    -12  -2.07
#> 30         92.2             16        62.9            344      4   1.40
#> 31         99.1             79        66.4            238    -16  -2.43
#> 32        101.3            111        69.5             84     -5  -0.38
#> 33         99.3             83        68.7            118    -22  -3.16
#> 34         96.7             45        68.8            116      1   0.74
#> 35        102.1            123        66.0            263    -37  -6.24
#> 36         94.5             27        67.6            172     -7  -0.56
#> 37         94.1             21        66.0            264     13   4.37
#> 38         94.1             23        68.6            123      6   2.85
#> 39        102.7            137        72.5             17    -63  -7.41
#> 40         91.2             11        66.1            260     28  10.55
#> 41         98.2             64        70.8             47    -16  -2.01
#> 42         95.4             31        73.6             11     20   6.41
#> 43        101.0            106        70.8             46    -45  -5.59
#> 44         95.6             33        65.0            309     10   3.35
#> 45         97.0             48        67.4            186     -1   1.22
#> 46         94.8             28        63.4            338     17   4.44
#> 47         97.5             59        70.0             67     28   7.39
#> 48         93.8             19        66.0            265    -26  -3.77
#> 49         93.5             18        66.0            262      1   1.64
#> 50         95.2             29        68.9            107     10   2.78
#> 51         98.8             75        65.2            297     16   4.47
#> 52         97.2             53        70.4             57     -2   0.94
#> 53        104.3            162        70.9             44    -33  -4.10
#> 54         98.6             71        70.2             61    -16  -1.87
#> 55        101.5            118        69.6             83    -27  -2.97
#> 56        101.4            116        67.3            194    -99 -10.39
#> 57         94.4             24        67.2            199     34   8.18
#> 58         97.4             55        62.7            348     27   6.31
#> 59         97.5             60        69.1            100     -1   0.55
#> 60         98.2             63        66.7            227    -34  -3.54
#> 61        101.3            110        66.1            261    -22  -2.63
#> 62         96.3             41        67.9            158    -17  -2.14
#> 63         97.5             58        68.7            117     -1   0.11
#> 64        101.1            107        65.2            298    -33  -3.50
#> 65        100.5            102        65.2            302     NA   0.57
#> 66        106.7            223        70.1             64    -52  -4.82
#> 67        100.0             97        62.7            346    -64  -5.58
#> 68         99.7             89        67.4            187    -23  -2.01
#> 69        108.9            257        66.4            240    -40  -3.34
#> 70        102.7            138        67.3            192    -57  -4.51
#> 71        103.9            155        66.9            220    -66  -5.40
#> 72         96.5             43        66.8            225    -43  -3.55
#> 73        103.4            150        65.7            280     -8  -0.36
#> 74         99.0             78        66.7            229    -51  -3.82
#> 75         99.2             80        68.5            131     25   5.55
#> 76        102.5            133        71.9             25    -24  -1.86
#> 77         96.2             40        66.4            239    -29  -2.24
#> 78        102.1            125        66.6            232     11   1.72
#> 79         99.9             92        67.7            168    -37  -2.94
#> 80         98.2             65        65.3            293      7   1.13
#> 81        106.7            221        65.0            310    -26  -2.00
#> 82         97.2             51        64.8            318     14   1.87
#> 83        100.4             98        64.7            319     -2  -0.07
#> 84        106.3            213        74.3              5    -73  -7.19
#> 85         99.5             85        68.9            110     16   2.03
#> 86        105.3            183        71.0             40     -6  -0.22
#> 87         98.8             74        67.8            159     NA  -0.02
#> 88        102.2            129        68.6            122    -10  -0.75
#> 89         96.5             44        68.3            142     23   2.57
#> 90        107.2            231        68.5            127    -99  -9.40
#> 91        100.8            103        64.7            322     29   3.80
#> 92        101.5            117        71.3             34     43   6.66
#> 93        101.1            108        70.6             52      9   0.56
#> 94         97.2             52        68.1            145     56   8.11
#> 95        102.8            143        70.0             69    -29  -2.43
#> 96        103.4            151        66.2            253      7   0.43
#> 97         96.1             39        68.1            147     34   3.59
#> 98        101.4            113        65.3            292    -63  -7.04
#> 99         98.5             69        67.8            165     38   4.19
#> 100        98.2             66        69.9             71    -12  -1.49
#> 101       100.4             99        67.3            193    -13  -1.38
#> 102        98.3             67        66.9            213     12   0.93
#> 103       102.8            140        65.8            275    -43  -4.84
#> 104        96.0             38        64.5            324     -9  -0.88
#> 105        99.3             84        65.9            269     52   7.73
#> 106        89.5              7        68.4            136     64   9.53
#> 107        98.6             72        70.3             59    -26  -1.43
#> 108       103.7            153        65.4            289    -15  -0.44
#> 109        96.8             46        67.7            170     31   3.48
#> 110       105.9            203        73.9              8   -102  -9.71
#> 111        97.4             54        74.2              7     55   6.54
#> 112       101.4            112        67.5            180    -30  -2.73
#> 113        97.2             49        73.3             12     68   9.39
#> 114       105.3            186        67.6            179    -60  -6.09
#> 115        99.0             77        67.9            157     44   4.20
#> 116        99.8             90        62.7            347    -18  -1.29
#> 117       102.8            141        71.0             41     40   3.84
#> 118        97.4             56        65.7            278    100  15.75
#> 119        98.6             73        69.4             89     68   8.96
#> 120       102.1            126        65.4            288    -21  -1.88
#> 121        99.6             88        65.5            285     45   4.11
#> 122        97.4             57        66.6            230     63   6.97
#> 123       107.9            246        72.1             21    -55  -5.68
#> 124       102.0            120        68.4            134     -8  -0.26
#> 125        98.5             70        67.0            206     24   2.05
#> 126       104.2            161        65.5            286    -13  -1.13
#> 127       104.8            175        66.7            226    -78  -7.41
#> 128       100.4            100        68.8            114      9   1.13
#> 129       106.4            215        67.5            182    -36  -4.00
#> 130       102.2            128        73.2             14     27   3.01
#> 131       102.1            124        67.8            162     20   2.17
#> 132       102.0            122        65.2            305     15   1.86
#> 133        94.1             22        66.2            254     25   2.72
#> 134       102.3            130        68.2            143     38   4.00
#> 135        99.6             87        62.3            349     77   8.42
#> 136       104.4            164        64.4            326     14   1.93
#> 137       105.9            202        72.8             15    -51  -4.78
#> 138        99.3             82        65.3            294    -20  -2.41
#> 139       109.0            262        67.5            181     46   4.90
#> 140       101.4            115        67.2            201     60   6.01
#> 141       102.5            134        69.9             72    -69  -6.55
#> 142        99.9             94        66.9            217     12   1.89
#> 143       109.7            272        71.6             29    -26  -2.97
#> 144       103.0            144        62.9            345    -15  -1.44
#> 145       102.7            136        64.4            327    -32  -2.85
#> 146       102.2            127        64.8            316     26   3.30
#> 147       106.7            222        71.1             37    -77  -6.47
#> 148       104.0            157        67.7            167     -8  -0.69
#> 149       110.3            287        65.9            266    -54  -4.55
#> 150       103.1            145        65.2            300    -70  -6.11
#> 151       109.2            265        67.3            191    -85  -7.46
#> 152       105.5            190        69.8             73    -21  -1.69
#> 153       106.2            209        67.0            210    -76  -6.39
#> 154       108.4            254        68.8            112   -157 -13.58
#> 155       104.6            166        65.1            308    -61  -5.20
#> 156       105.4            188        68.9            106    -52  -4.59
#> 157       104.9            178        66.5            236    -36  -2.79
#> 158       108.4            255        68.6            120    -61  -5.19
#> 159       109.7            276        70.6             51    -39  -3.15
#> 160       108.0            248        63.6            336    -79  -6.95
#> 161       105.4            187        65.2            299     14   1.67
#> 162       102.3            131        68.8            115     58   6.37
#> 163        99.6             86        67.6            173     53   6.13
#> 164        97.2             50        64.0            330     43   5.25
#> 165       107.8            244        72.7             16     -3  -0.21
#> 166       110.3            286        66.6            234    -75  -6.29
#> 167       105.6            193        67.6            175    -79  -6.70
#> 168       111.1            302        65.2            301   -117  -9.43
#> 169       106.1            206        71.3             33     40   4.98
#> 170       113.5            332        68.4            137    -91  -6.95
#> 171       100.5            101        69.2             95    -13  -0.42
#> 172       103.2            146        66.3            245     24   2.79
#> 173       107.5            236        67.5            183     30   3.59
#> 174       107.3            232        69.7             78   -109  -8.70
#> 175       103.5            152        70.0             68    -21  -1.25
#> 176       111.5            307        67.7            169   -106  -8.28
#> 177       105.9            201        66.4            237     51   6.25
#> 178       109.7            274        71.6             28    -28  -1.88
#> 179       110.2            284        70.6             50    -28  -2.11
#> 180       106.1            208        64.7            321      8   0.87
#> 181       113.2            328        63.3            341    -84  -6.51
#> 182       100.0             96        67.6            177      7   0.77
#> 183       105.3            185        65.9            267     47   5.58
#> 184       104.0            158        65.4            287     13   1.06
#> 185       108.9            259        68.4            133   -132 -11.76
#> 186       110.4            290        67.0            207    -63  -5.34
#> 187       105.2            182        66.6            233    -13  -0.95
#> 188       104.3            163        72.1             19     39   3.73
#> 189       102.3            132        70.5             54     84   8.26
#> 190        98.8             76        65.1            306     52   6.04
#> 191       106.5            220        66.8            224     -8  -0.53
#> 192        98.4             68        71.1             36     39   3.93
#> 193       105.4            189        68.9            108    -35  -2.47
#> 194       106.5            219        73.2             13      9   1.47
#> 195       109.0            260        71.6             26      3   0.90
#> 196       110.6            292        65.0            312     -6  -0.11
#> 197       105.7            197        69.8             76     43   4.18
#> 198       109.0            261        67.1            204     18   1.92
#> 199       104.8            173        71.9             24     32   2.68
#> 200       104.9            177        69.5             86    -27  -1.79
#> 201        99.9             95        69.3             90     35   3.01
#> 202       107.7            243        65.2            303    -24  -1.70
#> 203       102.0            119        65.0            311    -27  -2.30
#> 204       107.7            241        66.3            241    -10  -0.90
#> 205       106.8            226        69.0            105     77   8.11
#> 206       105.6            194        70.3             58     55   5.29
#> 207       102.0            121        66.1            256     55   5.36
#> 208       106.8            225        66.3            243      7   0.92
#> 209       110.8            297        66.7            228     15   1.81
#> 210       110.4            289        67.9            153     46   3.96
#> 211       110.0            280        67.2            200    -34  -3.08
#> 212       113.0            325        67.1            203   -100  -8.80
#> 213       105.8            198        77.6              1      9   0.92
#> 214       108.9            258        67.9            156     17   1.51
#> 215       107.0            228        69.2             97    -40  -3.42
#> 216       107.6            240        67.8            163    -21  -1.94
#> 217       114.7            339        69.3             93    -55  -4.83
#> 218        99.9             93        66.3            251     68   5.94
#> 219       103.3            149        66.9            216     36   2.96
#> 220       106.3            214        71.5             30     -5  -0.54
#> 221       111.4            306        68.0            150    -88  -7.85
#> 222       103.9            156        70.7             48     77   6.50
#> 223       110.2            283        66.8            222   -103 -10.80
#> 224       109.6            271        66.3            244     84   7.76
#> 225       102.8            139        69.3             94     90   8.81
#> 226       107.8            245        67.4            189     63   5.06
#> 227       107.7            242        66.6            235    -16  -1.85
#> 228       110.4            288        66.3            247     -3  -0.59
#> 229        95.9             37        67.5            184    130  12.02
#> 230       101.0            105        69.5             87     70   5.60
#> 231       108.3            252        63.2            342    -85  -8.17
#> 232       115.3            345        69.7             81    -83  -8.02
#> 233       108.5            256        67.3            190    -61  -5.31
#> 234       114.5            337        73.6             10    -23  -2.28
#> 235       109.8            278        65.7            281     54   4.10
#> 236       107.5            234        63.8            332    -78  -7.68
#> 237       102.8            142        67.2            198     47   3.89
#> 238       106.3            212        69.7             79    -33  -2.82
#> 239       112.1            314        69.1            104    -47  -4.25
#> 240       108.3            253        65.9            270    -39  -3.83
#> 241       106.1            207        67.9            152     28   1.51
#> 242       106.2            211        67.2            197    -51  -4.65
#> 243       103.9            154        66.3            242     57   4.41
#> 244       109.6            268        68.7            119     57   4.51
#> 245       106.0            205        68.1            146    -29  -3.15
#> 246       104.7            169        63.7            333     23   1.32
#> 247       104.7            168        65.2            304    -13  -1.61
#> 248       112.1            313        69.1            101    -73  -8.43
#> 249       105.8            200        68.9            111     58   4.48
#> 250       109.8            277        64.5            323    -26  -2.97
#> 251       107.9            247        68.3            141     34   1.93
#> 252       107.5            235        67.8            160    -49  -4.76
#> 253       104.1            159        65.9            272      1  -0.94
#> 254       118.4            350        66.8            221    -75  -9.51
#> 255       110.7            295        66.8            223     44   2.54
#> 256       104.1            160        67.5            185    -39  -4.10
#> 257       105.8            199        71.2             35    -16  -2.58
#> 258       109.1            263        60.6            352     -9  -1.51
#> 259       108.1            250        65.9            271     41   2.23
#> 260       105.0            180        70.4             55     38   1.95
#> 261       113.2            327        69.1            102     10  -0.47
#> 262       104.7            170        69.2             99    118   9.02
#> 263       106.5            218        67.6            178     48   2.60
#> 264       104.9            179        67.9            154     43   2.24
#> 265       103.2            147        69.8             75     23   0.39
#> 266        99.9             91        67.4            188    104   7.44
#> 267       118.9            352        65.4            290    -81 -16.25
#> 268       109.6            269        66.1            259    -28  -3.46
#> 269       106.0            204        76.6              2     34   1.35
#> 270       108.2            251        71.3             32    100   6.79
#> 271       106.9            227        68.1            148      7  -0.43
#> 272       104.9            176        66.3            250      3  -0.81
#> 273       111.7            310        66.9            218     39   1.70
#> 274       107.5            238        74.7              4     79   5.62
#> 275       114.2            336        66.9            219    -15  -2.39
#> 276       107.2            229        66.3            249    100   7.65
#> 277       106.2            210        71.1             38     68   4.64
#> 278       104.8            172        61.8            351    -45  -6.34
#> 279       110.7            294        70.1             63     31   1.65
#> 280       106.5            217        70.8             45     17   1.06
#> 281       110.0            281        67.6            174    -27  -2.83
#> 282       115.3            344        68.5            132     -7  -0.81
#> 283       112.0            312        66.9            214    -24  -2.37
#> 284       109.6            270        69.4             88     -8  -1.12
#> 285       107.6            239        66.3            248     47   3.18
#> 286       110.7            293        67.8            166    107   8.61
#> 287       112.6            320        68.6            125     54   3.86
#> 288       111.4            304        70.5             53    -14  -1.45
#> 289       106.5            216        70.9             42     42   2.75
#> 290       105.7            196        69.2             98     46   3.03
#> 291       111.6            308        68.5            129    -19  -2.55
#> 292       110.2            285        68.3            140     38   2.52
#> 293       101.4            114        68.0            151     -6  -0.97
#> 294       110.9            298        63.5            337      3  -0.33
#> 295       112.4            317        69.8             74     37   2.54
#> 296       113.9            334        71.3             31     -9  -1.47
#> 297       105.5            192        65.3            295     65   4.36
#> 298       112.9            324        73.9              9     17   0.57
#> 299       109.3            267        65.3            291     -4  -0.94
#> 300       112.9            322        65.8            273    -32  -6.09
#> 301       112.6            319        68.5            130     -3  -1.01
#> 302       110.5            291        68.5            128     32   2.19
#> 303       101.1            109        70.4             56    121   9.48
#> 304       115.4            346        70.0             70     54   3.45
#> 305       106.8            224        64.5            325      8  -0.06
#> 306       105.1            181        68.6            126     44   3.02
#> 307       104.4            165        69.6             82     39   2.77
#> 308       105.5            191        72.2             18      2  -0.48
#> 309       104.8            174        64.9            315     22   1.52
#> 310       112.7            321        71.6             27     22   1.50
#> 311       107.2            230        66.9            212     31   1.93
#> 312       112.9            323        68.9            109     14   0.56
#> 313       111.6            309        69.1            103     35   2.13
#> 314       105.6            195        68.3            138     39   2.42
#> 315       113.4            331        63.3            340     -7  -2.81
#> 316       107.3            233        67.2            195     60   4.68
#> 317       114.0            335        69.3             92    -26  -9.29
#> 318       111.0            301        72.0             23     78   5.93
#> 319       113.1            326        69.7             80    -11  -3.22
#> 320       110.9            300        67.2            196     -8  -2.47
#> 321       112.3            316        67.0            205     62   5.37
#> 322       114.9            342        66.2            255    -12  -4.15
#> 323       111.4            305        68.0            149    -13  -4.38
#> 324       117.0            349        61.9            350    -23  -9.83
#> 325       115.1            343        67.6            176     -2  -1.59
#> 326       104.7            171        68.3            139      6  -0.77
#> 327       110.9            299        68.2            144    -12  -4.52
#> 328       109.7            275        66.1            258     62   6.10
#> 329       107.5            237        65.6            283    -16  -8.17
#> 330       111.2            303        69.5             85     53   5.33
#> 331       112.5            318        70.9             43     78   7.56
#> 332       105.3            184        68.4            135     48   5.37
#> 333       114.9            341        66.3            246      2  -1.23
#> 334       111.9            311        64.0            329     -4  -3.00
#> 335       110.7            296        72.1             22      2  -1.90
#> 336       110.1            282        67.1            202     12   0.68
#> 337       108.1            249        65.7            279     37   4.71
#> 338       113.3            329        68.8            113     13   2.11
#> 339       112.1            315        65.7            277      4  -0.14
#> 340       120.6            353        64.9            313     -6  -5.05
#> 341       110.0            279        68.6            124     NA  -1.32
#> 342       116.1            347        74.9              3      2  -0.71
#> 343       113.4            330        65.8            276     -6  -4.81
#> 344       109.7            273        65.3            296     31   6.26
#> 345       116.8            348        67.0            209      8   1.38
#> 346       114.5            338        69.2             96     -4  -4.46
#> 347       114.8            340        63.1            343     -6  -8.94
#> 348       103.3            148        64.9            314     30   6.69
#> 349       118.6            351        70.1             65     -2  -6.56
#> 350       109.3            266        70.2             60      8   1.78
#> 351       109.1            264        65.7            282      7   0.46
#> 352       104.6            167        65.1            307     33   8.59
#> 353       113.8            333        69.7             77      1  -3.27
#>     adj_t_chg ncaa_seed
#> 1        -0.8        18
#> 2        -3.3        42
#> 3        -1.3       116
#> 4        -4.6         1
#> 5        -3.2        71
#> 6        -3.7        18
#> 7        -2.5       216
#> 8        -3.5        54
#> 9        -4.2       416
#> 10       -2.3       216
#> 11       -6.5        24
#> 12       -1.7        32
#> 13       -3.9        38
#> 14       -2.9        51
#> 15       -6.7        28
#> 16       -5.9        41
#> 17       -3.9        81
#> 18       -6.3       416
#> 19       -2.7        61
#> 20       -4.7        NA
#> 21       -5.2      1216
#> 22       -2.2        NA
#> 23       -6.1        62
#> 24       -1.0        NA
#> 25       -4.1        NA
#> 26       -1.4        51
#> 27       -5.0        NA
#> 28       -2.0       112
#> 29       -2.4        NA
#> 30       -6.9       102
#> 31       -3.8        NA
#> 32       -4.2       102
#> 33       -4.2        NA
#> 34       -2.1        51
#> 35       -3.5        NA
#> 36       -1.9        NA
#> 37       -4.7        62
#> 38       -6.1        92
#> 39       -2.8        NA
#> 40       -2.3       316
#> 41       -2.9       111
#> 42       -0.9        62
#> 43       -2.5       110
#> 44       -3.5        92
#> 45       -4.2       102
#> 46       -3.5        71
#> 47       -1.6       316
#> 48       -2.3        NA
#> 49       -4.0        92
#> 50       -1.7        NA
#> 51       -2.6        92
#> 52       -3.7        NA
#> 53       -3.6        NA
#> 54       -2.6        NA
#> 55       -3.8        NA
#> 56       -4.9        NA
#> 57       -5.3        71
#> 58       -3.2       111
#> 59       -2.1       101
#> 60       -3.7        NA
#> 61       -5.6        NA
#> 62       -2.2        NA
#> 63       -1.1        NA
#> 64       -2.4        NA
#> 65       -5.1        NA
#> 66       -0.4        NA
#> 67       -7.5        NA
#> 68       -4.0        NA
#> 69       -3.0        NA
#> 70       -3.7        NA
#> 71       -3.6       151
#> 72       -4.6        NA
#> 73       -2.4        NA
#> 74       -2.9        NA
#> 75       -2.9        81
#> 76       -1.3        NA
#> 77       -2.7       131
#> 78       -3.9        NA
#> 79       -3.0        NA
#> 80       -2.8       132
#> 81       -2.0        NA
#> 82       -3.5        NA
#> 83       -3.8        NA
#> 84       -3.4        NA
#> 85       -2.0       110
#> 86       -0.4        NA
#> 87       -1.4        NA
#> 88       -3.6        NA
#> 89       -2.2        NA
#> 90       -1.8        NA
#> 91       -3.8        NA
#> 92       -2.9       111
#> 93       -3.0        NA
#> 94       -6.3        81
#> 95       -0.5       141
#> 96       -1.5       131
#> 97       -2.8        NA
#> 98       -3.1       151
#> 99       -2.9        NA
#> 100      -2.3        NA
#> 101      -2.9        NA
#> 102      -2.2        NA
#> 103      -2.4        NA
#> 104      -2.5       141
#> 105      -4.5       121
#> 106      -3.8        81
#> 107      -0.7        NA
#> 108      -2.0        NA
#> 109      -2.7        NA
#> 110      -2.3        NA
#> 111       1.8        NA
#> 112      -3.7        NA
#> 113      -4.1        NA
#> 114      -2.7        NA
#> 115      -3.4        NA
#> 116      -5.5        NA
#> 117      -1.7       141
#> 118      -1.8        72
#> 119       0.1       122
#> 120      -5.4        NA
#> 121      -2.3       131
#> 122      -3.9        NA
#> 123      -0.5        NA
#> 124      -3.6        NA
#> 125      -3.0        NA
#> 126      -5.0        NA
#> 127      -3.9        NA
#> 128      -2.3        NA
#> 129      -3.1        NA
#> 130      -1.7        NA
#> 131      -3.8        NA
#> 132      -5.4        NA
#> 133      -2.3        NA
#> 134      -2.5       141
#> 135      -5.5       122
#> 136      -3.1        NA
#> 137      -1.9        NA
#> 138      -1.7        NA
#> 139      -2.7        NA
#> 140      -1.8        NA
#> 141      -2.6        NA
#> 142      -4.8        NA
#> 143      -1.5        NA
#> 144      -5.5        NA
#> 145      -4.5        NA
#> 146      -3.2        NA
#> 147      -1.6        NA
#> 148      -4.0        NA
#> 149      -3.6        NA
#> 150      -2.8        NA
#> 151      -3.7        NA
#> 152       0.7        NA
#> 153      -3.9        NA
#> 154      -2.9        NA
#> 155      -4.0        NA
#> 156      -2.9        NA
#> 157      -6.3        NA
#> 158      -2.4        NA
#> 159      -3.9       161
#> 160      -1.9        NA
#> 161      -6.0        NA
#> 162      -2.9        NA
#> 163      -3.1        NA
#> 164      -5.3        NA
#> 165      -2.9        NA
#> 166      -2.6        NA
#> 167      -6.0        NA
#> 168      -4.6        NA
#> 169      -0.6        NA
#> 170      -3.2        NA
#> 171      -4.1        NA
#> 172      -2.4        NA
#> 173      -4.4        NA
#> 174      -1.7        NA
#> 175      -3.5        NA
#> 176      -4.0        NA
#> 177      -2.2       151
#> 178      -1.6        NA
#> 179      -2.0        NA
#> 180      -3.9        NA
#> 181      -5.7        NA
#> 182        NA        NA
#> 183      -3.2        NA
#> 184      -6.7        NA
#> 185      -3.8        NA
#> 186      -2.1        NA
#> 187      -1.4        NA
#> 188      -0.8        NA
#> 189      -1.7        NA
#> 190      -1.7        NA
#> 191      -1.4        NA
#> 192      -3.4        NA
#> 193      -2.5        NA
#> 194      -2.6        NA
#> 195      -3.5        NA
#> 196      -3.2       161
#> 197      -1.3        NA
#> 198      -3.6        NA
#> 199      -2.5        NA
#> 200      -3.0        NA
#> 201      -1.4        NA
#> 202      -3.9        NA
#> 203      -5.6        NA
#> 204      -5.9        NA
#> 205      -2.7        NA
#> 206      -4.8        NA
#> 207      -3.7       151
#> 208      -3.5        NA
#> 209      -3.5        NA
#> 210      -5.0        NA
#> 211      -4.5        NA
#> 212      -0.9        NA
#> 213      -0.9        NA
#> 214      -3.7        NA
#> 215      -2.0        NA
#> 216      -2.1        NA
#> 217      -3.4        NA
#> 218      -5.8        NA
#> 219      -0.4        NA
#> 220      -3.1        NA
#> 221      -3.4        NA
#> 222      -0.7        NA
#> 223      -2.9        NA
#> 224      -2.3        NA
#> 225      -3.7        NA
#> 226      -3.2       161
#> 227      -2.0        NA
#> 228      -3.7        NA
#> 229      -1.9        NA
#> 230      -2.1        NA
#> 231      -5.2        NA
#> 232      -3.6        NA
#> 233      -4.3        NA
#> 234      -4.5        NA
#> 235      -3.7        NA
#> 236      -6.0        NA
#> 237      -4.4        NA
#> 238      -3.3        NA
#> 239      -5.5        NA
#> 240      -2.0        NA
#> 241      -4.7        NA
#> 242      -2.9        NA
#> 243      -3.5        NA
#> 244      -2.0        NA
#> 245      -2.0        NA
#> 246      -2.6        NA
#> 247      -2.8        NA
#> 248       0.2        NA
#> 249      -2.2        NA
#> 250      -1.8        NA
#> 251      -2.7        NA
#> 252      -2.5        NA
#> 253      -3.3        NA
#> 254      -3.8        NA
#> 255      -5.8       161
#> 256      -5.2        NA
#> 257      -1.8        NA
#> 258      -2.9        NA
#> 259      -4.2        NA
#> 260      -2.2        NA
#> 261      -3.1        NA
#> 262      -3.5        NA
#> 263      -5.6        NA
#> 264      -4.5        NA
#> 265      -3.3        NA
#> 266      -2.6        NA
#> 267      -4.0        NA
#> 268      -3.4        NA
#> 269      -1.0        NA
#> 270      -3.0        NA
#> 271      -6.6        NA
#> 272      -4.8        NA
#> 273      -2.8        NA
#> 274      -1.0        NA
#> 275      -3.9        NA
#> 276      -2.6        NA
#> 277      -1.4       160
#> 278      -4.4        NA
#> 279      -2.3        NA
#> 280      -2.8        NA
#> 281      -3.8        NA
#> 282      -2.4        NA
#> 283      -3.6        NA
#> 284      -3.0        NA
#> 285      -5.7        NA
#> 286      -0.8        NA
#> 287      -3.5        NA
#> 288      -3.9        NA
#> 289      -0.9        NA
#> 290      -1.2        NA
#> 291      -4.2        NA
#> 292      -4.9        NA
#> 293      -3.3        NA
#> 294      -5.5        NA
#> 295      -4.1        NA
#> 296      -1.5        NA
#> 297      -4.7        NA
#> 298      -0.2        NA
#> 299      -1.6       160
#> 300      -6.2        NA
#> 301      -4.0        NA
#> 302      -2.5        NA
#> 303      -3.2        NA
#> 304      -1.4        NA
#> 305      -3.9        NA
#> 306      -0.4        NA
#> 307      -3.8        NA
#> 308      -2.0        NA
#> 309      -3.1        NA
#> 310       0.4        NA
#> 311      -1.8        NA
#> 312      -2.6        NA
#> 313      -1.2        NA
#> 314      -2.9        NA
#> 315      -6.2        NA
#> 316      -2.6        NA
#> 317      -1.8        NA
#> 318        NA        NA
#> 319      -1.8        NA
#> 320      -3.4        NA
#> 321      -6.4        NA
#> 322      -2.5        NA
#> 323      -3.3        NA
#> 324      -7.5        NA
#> 325      -4.1        NA
#> 326      -5.8        NA
#> 327      -1.5        NA
#> 328      -4.2        NA
#> 329      -4.8        NA
#> 330      -3.7        NA
#> 331      -2.3        NA
#> 332      -4.5        NA
#> 333      -3.1        NA
#> 334      -4.3        NA
#> 335      -0.1        NA
#> 336      -3.7        NA
#> 337      -3.5        NA
#> 338      -3.3        NA
#> 339      -4.6        NA
#> 340      -4.1        NA
#> 341      -4.2        NA
#> 342      -8.3        NA
#> 343      -4.3        NA
#> 344      -5.0        NA
#> 345      -3.4        NA
#> 346      -2.5        NA
#> 347      -5.8        NA
#> 348      -5.0        NA
#> 349      -2.9        NA
#> 350      -1.8        NA
#> 351      -4.2        NA
#> 352      -5.5        NA
#> 353      -1.3        NA
# }
```
