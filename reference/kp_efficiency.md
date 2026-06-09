# **Get KenPom Efficiency and Tempo Summary**

**Get KenPom Efficiency and Tempo Summary**

## Usage

``` r
kp_efficiency(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of efficiency and tempo ratings

|                        |           |                                     |
|------------------------|-----------|-------------------------------------|
| col_name               | types     | description                         |
| team                   | character | Team-side label or team identifier. |
| conf                   | character | character.                          |
| adj_t                  | numeric   | Adj t.                              |
| adj_t_rk               | numeric   | Adj t rk.                           |
| raw_t                  | numeric   | Raw t.                              |
| raw_t_rk               | numeric   | Raw t rk.                           |
| avg_poss_length_off    | numeric   | Avg poss length off.                |
| avg_poss_length_off_rk | numeric   | Avg poss length off rk.             |
| avg_poss_length_def    | numeric   | Avg poss length def.                |
| avg_poss_length_def_rk | numeric   | Avg poss length def rk.             |
| adj_o                  | numeric   | Adj o.                              |
| adj_o_rk               | numeric   | Adj o rk.                           |
| raw_o                  | numeric   | Raw o.                              |
| raw_o_rk               | numeric   | Raw o rk.                           |
| adj_d                  | numeric   | Adj d.                              |
| adj_d_rk               | numeric   | Adj d rk.                           |
| raw_d                  | numeric   | Raw d.                              |
| raw_d_rk               | numeric   | Raw d rk.                           |
| ncaa_seed              | numeric   | Ncaa seed.                          |
| year                   | numeric   | 4-digit year.                       |

## See also

Other KenPom Ratings Functions:
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
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
try(kp_efficiency(min_year = 2020, max_year = 2021))
#>                       team conf adj_t adj_t_rk raw_t raw_t_rk
#> 1               Coppin St. MEAC  76.8        1  79.4        1
#> 2         Eastern Kentucky  OVC  74.8        2  75.6        5
#> 3           South Carolina  SEC  74.6        3  75.3        7
#> 4              The Citadel   SC  74.2        4  74.5       11
#> 5                 Monmouth MAAC  74.2        5  74.4       12
#> 6                   Bryant  NEC  74.0        6  76.1        3
#> 7                  Gonzaga  WCC  73.8        7  74.3       14
#> 8           Long Beach St.   BW  73.7        8  74.3       15
#> 9                      LIU  NEC  73.7        9  74.5        9
#> 10              St. John's   BE  73.4       10  74.1       19
#> 11                 Alabama  SEC  73.3       11  74.5       10
#> 12            Delaware St. MEAC  73.3       12  77.2        2
#> 13                 Georgia  SEC  73.2       13  75.5        6
#> 14                Winthrop BSth  73.1       14  72.4       46
#> 15               Dixie St.  WAC  73.1       15  73.9       21
#> 16                 Buffalo  MAC  73.1       16  74.3       16
#> 17                 Samford   SC  72.7       17  74.4       13
#> 18         Houston Baptist Slnd  72.6       18  74.1       18
#> 19                Arkansas  SEC  72.6       19  75.0        8
#> 20                Marshall CUSA  72.6       20  73.1       32
#> 21             Arizona St.  P12  72.5       21  72.6       43
#> 22          St. Francis NY  NEC  72.5       22  73.6       26
#> 23             New Orleans Slnd  72.4       23  74.3       17
#> 24            Oklahoma St.  B12  72.4       24  73.0       34
#> 25         Bethune Cookman MEAC  72.3       25   0.0      348
#> 26                 Colgate  Pat  72.2       26  72.6       44
#> 27      Eastern Washington BSky  72.2       27  71.4       80
#> 28                   IUPUI Horz  72.1       28  72.7       39
#> 29        Central Michigan  MAC  72.1       29  73.8       22
#> 30          Saint Joseph's  A10  72.1       30  72.9       35
#> 31              Quinnipiac MAAC  72.0       31  72.0       58
#> 32              Morgan St. MEAC  71.9       32  75.6        4
#> 33               Weber St. BSky  71.9       33  71.5       78
#> 34                Bucknell  Pat  71.8       34  73.1       33
#> 35                Nebraska  B10  71.8       35  72.7       40
#> 36           James Madison  CAA  71.8       36  71.6       77
#> 37                    UTSA CUSA  71.8       37  72.1       57
#> 38            San Jose St.  MWC  71.8       38  71.7       73
#> 39       Cal St. Fullerton   BW  71.8       39  72.3       49
#> 40      South Carolina St. MEAC  71.6       40  72.4       45
#> 41           Massachusetts  A10  71.6       41  72.3       48
#> 42            Nicholls St. Slnd  71.6       42  73.9       20
#> 43          North Carolina  ACC  71.5       43  71.7       72
#> 44        Western Illinois  Sum  71.5       44  73.7       24
#> 45          Texas Southern SWAC  71.5       45  72.8       36
#> 46            Oral Roberts  Sum  71.4       46  72.7       38
#> 47              Pepperdine  WCC  71.4       47  71.8       66
#> 48                 Memphis Amer  71.3       48  72.1       56
#> 49           Tennessee St.  OVC  71.2       49  72.3       50
#> 50  Mississippi Valley St. SWAC  71.1       50  73.6       25
#> 51        Coastal Carolina   SB  71.1       51  71.9       61
#> 52              Wright St. Horz  71.1       52  72.1       53
#> 53              Washington  P12  71.0       53  71.0       93
#> 54                  Auburn  SEC  71.0       54  73.4       29
#> 55                Portland  WCC  71.0       55  72.7       37
#> 56               Louisiana   SB  71.0       56  71.3       85
#> 57         Sam Houston St. Slnd  70.9       57  73.4       28
#> 58          Boston College  ACC  70.9       58  71.8       64
#> 59        South Dakota St.  Sum  70.9       59  71.8       67
#> 60                  Denver  Sum  70.9       60  71.4       81
#> 61        Central Arkansas Slnd  70.9       61  73.8       23
#> 62        Northwestern St. Slnd  70.8       62  73.6       27
#> 63             Alabama St. SWAC  70.8       63  72.3       47
#> 64                 Belmont  OVC  70.7       64  71.9       63
#> 65          Nebraska Omaha  Sum  70.7       65  72.1       52
#> 66              Cincinnati Amer  70.7       66  71.1       91
#> 67                Ball St.  MAC  70.7       67  72.1       54
#> 68     Fairleigh Dickinson  NEC  70.6       68  71.9       60
#> 69      Florida Gulf Coast ASun  70.6       69  71.3       84
#> 70                     LSU  SEC  70.6       70  72.6       42
#> 71                Southern SWAC  70.6       71  72.6       41
#> 72                  DePaul   BE  70.6       72  70.6      105
#> 73      North Carolina A&T MEAC  70.6       73  73.2       30
#> 74                Canisius MAAC  70.6       74  71.5       79
#> 75           North Alabama ASun  70.6       75  70.1      126
#> 76             Cal Baptist  WAC  70.5       76  71.1       92
#> 77        Western Carolina   SC  70.5       77  72.1       55
#> 78             Georgia St.   SB  70.5       78  70.6      107
#> 79                Illinois  B10  70.5       79  71.2       88
#> 80                 Hampton BSth  70.4       80  70.0      130
#> 81             Santa Clara  WCC  70.4       81  71.8       68
#> 82                     FIU CUSA  70.3       82  71.6       75
#> 83     Central Connecticut  NEC  70.3       83  71.9       62
#> 84               San Diego  WCC  70.2       84  72.2       51
#> 85             Utah Valley  WAC  70.2       85  71.3       83
#> 86      Cal St. Northridge   BW  70.1       86  70.4      111
#> 87                  Lehigh  Pat  70.0       87  71.3       86
#> 88               Minnesota  B10  69.9       88  70.7      101
#> 89                     VMI   SC  69.9       89  71.6       74
#> 90             Florida St.  ACC  69.9       90  69.9      142
#> 91                Iowa St.  B12  69.9       91  70.5      108
#> 92           Southern Utah BSky  69.9       92  71.0       95
#> 93                    Iowa  B10  69.9       93  70.8       98
#> 94           Grambling St. SWAC  69.8       94  71.7       71
#> 95                  Nevada  MWC  69.8       95  70.1      129
#> 96           Bowling Green  MAC  69.8       96  71.8       69
#> 97               Milwaukee Horz  69.8       97  71.0       94
#> 98                Kent St.  MAC  69.8       98  70.7      102
#> 99            UC San Diego   BW  69.7       99  69.2      172
#> 100                  Brown  Ivy  69.7      100   0.0      348
#> 101             Georgetown   BE  69.7      101  70.3      119
#> 102      Stephen F. Austin Slnd  69.7      102  71.9       59
#> 103   UT Rio Grande Valley  WAC  69.6      103  71.8       70
#> 104                Oakland Horz  69.6      104  70.7      103
#> 105 Texas A&M Corpus Chris Slnd  69.6      105  70.9       97
#> 106    Charleston Southern BSth  69.6      106  70.2      123
#> 107                    VCU  A10  69.6      107  70.3      117
#> 108                 Albany   AE  69.6      108  69.7      148
#> 109      Purdue Fort Wayne Horz  69.5      109  69.6      152
#> 110                 Howard MEAC  69.5      110  73.1       31
#> 111             Alcorn St. SWAC  69.5      111  71.1       90
#> 112         Louisiana Tech CUSA  69.4      112  70.5      109
#> 113           Kennesaw St. ASun  69.3      113  69.3      169
#> 114                   Rice CUSA  69.3      114  70.6      106
#> 115      Abilene Christian Slnd  69.3      115  71.0       96
#> 116           Portland St. BSky  69.2      116  69.7      150
#> 117       Middle Tennessee CUSA  69.2      117  69.7      149
#> 118           UT Arlington   SB  69.2      118  70.3      118
#> 119               UC Davis   BW  69.2      119  70.3      114
#> 120               Stanford  P12  69.2      120  69.8      144
#> 121       Prairie View A&M SWAC  69.2      121  70.7      104
#> 122          West Virginia  B12  69.2      122  70.4      113
#> 123                   Ohio  MAC  69.2      123  71.3       87
#> 124                   Penn  Ivy  69.2      124   0.0      348
#> 125               Penn St.  B10  69.1      125  69.7      151
#> 126             Holy Cross  Pat  69.1      126  69.8      143
#> 127           Missouri St.  MVC  69.1      127  68.2      213
#> 128              Boise St.  MWC  69.1      128  69.9      138
#> 129                Wyoming  MWC  69.0      129  70.0      134
#> 130         UNC Wilmington  CAA  69.0      130  70.0      131
#> 131           UMass Lowell   AE  69.0      131  69.3      171
#> 132           Illinois St.  MVC  69.0      132  68.7      189
#> 133           Colorado St.  MWC  69.0      133  69.4      167
#> 134           Rhode Island  A10  69.0      134  70.2      122
#> 135               Duquesne  A10  69.0      135  68.4      203
#> 136           South Dakota  Sum  68.9      136  70.1      127
#> 137               Columbia  Ivy  68.9      137   0.0      348
#> 138       Eastern Illinois  OVC  68.9      138  70.1      128
#> 139          Northern Iowa  MVC  68.8      139  68.3      206
#> 140                Seattle  WAC  68.8      140  70.4      112
#> 141                    SMU Amer  68.8      141  70.8      100
#> 142         Tennessee Tech  OVC  68.8      142  70.2      125
#> 143                 Toledo  MAC  68.7      143  70.2      120
#> 144              Creighton   BE  68.7      144  69.5      157
#> 145              Lafayette  Pat  68.6      145  70.2      124
#> 146                  Texas  B12  68.6      146  69.4      165
#> 147             Vanderbilt  SEC  68.6      147  69.6      153
#> 148                 Temple Amer  68.6      148  68.3      208
#> 149               Utah St.  MWC  68.6      149  69.4      166
#> 150 Southeastern Louisiana Slnd  68.6      150  71.6       76
#> 151               Syracuse  ACC  68.6      151  69.1      178
#> 152                   Duke  ACC  68.5      152  69.1      177
#> 153                  Akron  MAC  68.5      153  69.9      140
#> 154         St. Francis PA  NEC  68.5      154  69.7      146
#> 155               La Salle  A10  68.5      155  69.5      163
#> 156            McNeese St. Slnd  68.5      156  71.4       82
#> 157                   Army  Pat  68.4      157  69.9      139
#> 158 Southeast Missouri St.  OVC  68.4      158  68.9      185
#> 159            Jackson St. SWAC  68.4      159  70.3      116
#> 160           Northwestern  B10  68.4      160  69.3      168
#> 161            Florida A&M MEAC  68.4      161  70.8       99
#> 162              Loyola MD  Pat  68.4      162  68.6      197
#> 163               Missouri  SEC  68.4      163  70.3      115
#> 164           Michigan St.  B10  68.3      164  68.9      181
#> 165             Pittsburgh  ACC  68.3      165  68.5      199
#> 166            USC Upstate BSth  68.3      166  68.7      191
#> 167                Florida  SEC  68.3      167  70.5      110
#> 168            Montana St. BSky  68.2      168  69.1      175
#> 169               Richmond  A10  68.2      169  69.5      156
#> 170          UNC Asheville BSth  68.2      170  69.9      141
#> 171                   NJIT   AE  68.2      171  68.1      214
#> 172       SIU Edwardsville  OVC  68.2      172  69.5      162
#> 173                   Troy   SB  68.2      173  69.5      158
#> 174                 Kansas  B12  68.2      174  69.5      160
#> 175       Illinois Chicago Horz  68.2      175  69.5      159
#> 176           George Mason  A10  68.1      176  69.2      173
#> 177       Florida Atlantic CUSA  68.1      177  69.1      179
#> 178       Eastern Michigan  MAC  68.1      178  69.9      137
#> 179                Hofstra  CAA  68.1      179  68.9      184
#> 180                Harvard  Ivy  68.1      180   0.0      348
#> 181               Kentucky  SEC  68.1      181  70.0      132
#> 182         William & Mary  CAA  68.1      182  67.2      265
#> 183         UNC Greensboro   SC  68.0      183  70.2      121
#> 184            Saint Louis  A10  68.0      184  68.6      195
#> 185                   Yale  Ivy  67.9      185   0.0      348
#> 186                 Xavier   BE  67.9      186  69.6      154
#> 187          East Carolina Amer  67.9      187  68.7      190
#> 188      George Washington  A10  67.8      188  68.9      182
#> 189      Northern Colorado BSky  67.8      189  68.5      198
#> 190               Miami FL  ACC  67.8      190  68.1      221
#> 191                   UTEP CUSA  67.8      191  68.1      220
#> 192 Maryland Eastern Shore MEAC  67.8      192   0.0      348
#> 193             N.C. State  ACC  67.8      193  68.1      215
#> 194                Stetson ASun  67.8      194  67.8      234
#> 195             New Mexico  MWC  67.7      195  68.4      204
#> 196                 Mercer   SC  67.7      196  69.5      161
#> 197          San Francisco  WCC  67.7      197  69.5      155
#> 198                Arizona  P12  67.7      198  68.3      209
#> 199                   Iona MAAC  67.7      199  69.7      147
#> 200                 Furman   SC  67.7      200  70.0      135
#> 201           Arkansas St.   SB  67.6      201  69.2      174
#> 202         Youngstown St. Horz  67.6      202  68.3      205
#> 203                   Utah  P12  67.6      203  67.7      243
#> 204           Jacksonville ASun  67.6      204  68.3      207
#> 205                  Rider MAAC  67.6      205  68.7      193
#> 206                    BYU  WCC  67.6      206  70.0      133
#> 207         Washington St.  P12  67.6      207  68.6      194
#> 208                   UMBC   AE  67.5      208  68.7      188
#> 209            Alabama A&M SWAC  67.5      209  70.0      136
#> 210                  Lamar Slnd  67.5      210  69.8      145
#> 211            Norfolk St. MEAC  67.5      211  71.8       65
#> 212            Chicago St.  WAC  67.5      212  71.2       89
#> 213                 Baylor  B12  67.4      213  69.3      170
#> 214                Rutgers  B10  67.4      214  68.1      216
#> 215               American  Pat  67.4      215  67.7      236
#> 216              Marquette   BE  67.4      216  68.4      202
#> 217           Old Dominion CUSA  67.4      217  68.2      212
#> 218          Southern Miss CUSA  67.4      218  68.2      211
#> 219       Western Kentucky CUSA  67.4      219  69.1      176
#> 220       Tennessee Martin  OVC  67.4      220  68.4      201
#> 221                 Tulane Amer  67.4      221  67.8      233
#> 222              UC Irvine   BW  67.4      222  68.1      219
#> 223           Georgia Tech  ACC  67.3      223  67.7      242
#> 224          Robert Morris Horz  67.3      224  68.4      200
#> 225                    UCF Amer  67.2      225  68.0      229
#> 226                 Oregon  P12  67.2      226  68.1      223
#> 227             Notre Dame  ACC  67.2      227  67.4      257
#> 228               Oklahoma  B12  67.1      228  69.1      180
#> 229           North Dakota  Sum  67.1      229  68.9      183
#> 230                Detroit Horz  67.1      230  68.1      218
#> 231       Louisiana Monroe   SB  67.1      231  67.6      247
#> 232              Tennessee  SEC  67.1      232  68.7      186
#> 233              Manhattan MAAC  67.1      233  67.5      253
#> 234            Wichita St. Amer  67.0      234  67.6      244
#> 235                    USC  P12  67.0      235  67.6      246
#> 236           Northeastern  CAA  67.0      236  68.3      210
#> 237                Pacific  WCC  67.0      237  68.7      192
#> 238                    UAB CUSA  67.0      238  67.8      231
#> 239             Valparaiso  MVC  67.0      239  67.1      276
#> 240            Little Rock   SB  67.0      240  68.0      226
#> 241            Wake Forest  ACC  67.0      241  67.2      272
#> 242    Arkansas Pine Bluff SWAC  67.0      242  69.4      164
#> 243               Hartford   AE  66.9      243  66.9      281
#> 244            Indiana St.  MVC  66.9      244  66.2      300
#> 245                 Hawaii   BW  66.9      245  67.3      260
#> 246                Cornell  Ivy  66.8      246   0.0      348
#> 247          South Florida Amer  66.8      247  67.7      241
#> 248               Cal Poly   BW  66.8      248  67.9      230
#> 249            Austin Peay  OVC  66.8      249  68.6      196
#> 250                  Idaho BSky  66.8      250  67.5      255
#> 251               Ohio St.  B10  66.7      251  67.6      245
#> 252           Gardner Webb BSth  66.7      252  67.0      278
#> 253          Saint Peter's MAAC  66.7      253  68.0      225
#> 254           UC Riverside   BW  66.7      254  66.8      282
#> 255       Georgia Southern   SB  66.6      255  67.3      262
#> 256               Michigan  B10  66.6      256  67.6      250
#> 257              Princeton  Ivy  66.6      257   0.0      348
#> 258                    TCU  B12  66.6      258  67.6      249
#> 259              Dartmouth  Ivy  66.6      259   0.0      348
#> 260          North Florida ASun  66.5      260  68.1      217
#> 261          South Alabama   SB  66.5      261  67.6      248
#> 262               Delaware  CAA  66.5      262  67.2      269
#> 263              Merrimack  NEC  66.5      263  68.0      228
#> 264             Seton Hall   BE  66.5      264  67.8      232
#> 265                   Elon  CAA  66.5      265  66.3      294
#> 266          New Hampshire   AE  66.4      266  67.3      258
#> 267                Vermont   AE  66.4      267  66.5      290
#> 268            Stony Brook   AE  66.4      268  67.5      252
#> 269            Chattanooga   SC  66.4      269  68.1      222
#> 270             Providence   BE  66.3      270  67.2      268
#> 271                  Drake  MVC  66.3      271  66.0      310
#> 272           Sacred Heart  NEC  66.2      272  68.0      227
#> 273                  Siena MAAC  66.2      273  66.2      301
#> 274      Southern Illinois  MVC  66.2      274  65.4      322
#> 275             Murray St.  OVC  66.2      275  67.2      270
#> 276               Colorado  P12  66.1      276  66.4      292
#> 277             High Point BSth  66.1      277  67.4      256
#> 278                 Purdue  B10  66.1      278  66.5      291
#> 279          Cleveland St. Horz  66.1      279  67.6      251
#> 280                 Marist MAAC  66.1      280  66.8      283
#> 281                   UNLV  MWC  66.1      281  66.7      285
#> 282               Lipscomb ASun  66.0      282  67.3      259
#> 283       Western Michigan  MAC  66.0      283  68.0      224
#> 284       Loyola Marymount  WCC  66.0      284  67.7      237
#> 285              Green Bay Horz  65.9      285  67.7      238
#> 286                   Navy  Pat  65.9      286  67.2      267
#> 287 North Carolina Central MEAC  65.9      287  68.7      187
#> 288                Bradley  MVC  65.9      288  65.9      313
#> 289                Indiana  B10  65.9      289  67.2      266
#> 290             Binghamton   AE  65.9      290  66.1      302
#> 291                Wofford   SC  65.9      291  67.3      263
#> 292       Jacksonville St.  OVC  65.8      292  67.7      239
#> 293               Miami OH  MAC  65.8      293  67.8      235
#> 294                 Towson  CAA  65.8      294  66.9      280
#> 295             Fresno St.  MWC  65.8      295  66.1      303
#> 296        Mississippi St.  SEC  65.8      296  67.2      264
#> 297           Presbyterian BSth  65.7      297  66.3      296
#> 298          Virginia Tech  ACC  65.7      298  66.4      293
#> 299                Montana BSky  65.7      299  67.1      275
#> 300             Louisville  ACC  65.7      300  66.0      307
#> 301       UC Santa Barbara   BW  65.6      301  66.6      288
#> 302      Boston University  Pat  65.6      302  67.7      240
#> 303                  Tulsa Amer  65.6      303  67.1      273
#> 304                 Wagner  NEC  65.5      304  66.8      284
#> 305                 Dayton  A10  65.5      305  66.2      299
#> 306             Oregon St.  P12  65.5      306  65.8      316
#> 307          San Diego St.  MWC  65.5      307  66.6      286
#> 308             Kansas St.  B12  65.5      308  66.3      295
#> 309            Connecticut   BE  65.5      309  66.1      305
#> 310        Appalachian St.   SB  65.5      310  66.1      306
#> 311     East Tennessee St.   SC  65.4      311  67.1      274
#> 312      Northern Illinois  MAC  65.4      312  67.5      254
#> 313         Sacramento St. BSky  65.3      313  66.0      309
#> 314           Morehead St.  OVC  65.2      314  67.0      277
#> 315             Bellarmine ASun  65.1      315  66.0      308
#> 316             Texas Tech  B12  65.1      316  67.0      279
#> 317               Longwood BSth  65.0      317  66.3      298
#> 318            Mississippi  SEC  64.9      318  67.3      261
#> 319           Grand Canyon  WAC  64.9      319  66.5      289
#> 320        St. Bonaventure  A10  64.8      320  65.3      326
#> 321               Maryland  B10  64.7      321  65.4      321
#> 322             California  P12  64.7      322  65.8      314
#> 323      Northern Kentucky Horz  64.7      323  66.3      297
#> 324         Incarnate Word Slnd  64.7      324  67.2      271
#> 325         New Mexico St.  WAC  64.6      325  65.5      320
#> 326                 Butler   BE  64.6      326  65.1      329
#> 327       North Dakota St.  Sum  64.6      327  66.6      287
#> 328              Wisconsin  B10  64.6      328  65.7      317
#> 329                Niagara MAAC  64.5      329  65.6      318
#> 330                  Maine   AE  64.5      330  65.3      325
#> 331           Tarleton St.  WAC  64.4      331  65.9      312
#> 332                Houston Amer  64.4      332  65.3      323
#> 333              Fairfield MAAC  64.3      333  65.3      328
#> 334              Texas A&M  SEC  64.3      334  66.1      304
#> 335              Idaho St. BSky  64.2      335  65.1      330
#> 336              Villanova   BE  64.2      336  65.5      319
#> 337                Clemson  ACC  64.0      337  64.8      332
#> 338               Campbell BSth  63.9      338  64.8      333
#> 339       Northern Arizona BSky  63.9      339  65.3      324
#> 340                 Drexel  CAA  63.9      340  66.0      311
#> 341                   UCLA  P12  63.8      341  65.0      331
#> 342         Loyola Chicago  MVC  63.7      342  63.3      345
#> 343                Fordham  A10  63.7      343  64.3      339
#> 344    Cal St. Bakersfield   BW  63.6      344  65.3      327
#> 345             Charleston  CAA  63.5      345  64.3      338
#> 346                Radford BSth  63.5      346  64.5      336
#> 347                Liberty ASun  63.1      347  64.7      334
#> 348           Saint Mary's  WCC  62.9      348  65.8      315
#> 349              Air Force  MWC  62.8      349  63.9      341
#> 350            North Texas CUSA  62.7      350  64.6      335
#> 351              Charlotte CUSA  62.7      351  64.3      337
#> 352                   UMKC  Sum  62.5      352  64.1      340
#> 353               Davidson  A10  62.5      353  63.4      344
#> 354              Texas St.   SB  62.4      354  63.6      343
#> 355             Evansville  MVC  62.0      355  62.3      346
#> 356       Mount St. Mary's  NEC  61.6      356  63.6      342
#> 357               Virginia  ACC  59.9      357  60.8      347
#> 358 Mississippi Valley St. SWAC  77.1        1  78.9        1
#> 359        Houston Baptist Slnd  76.1        2  77.9        2
#> 360               Marshall CUSA  74.9        3  75.2        7
#> 361                Alabama  SEC  74.8        4  76.1        4
#> 362           Delaware St. MEAC  74.7        5  76.2        3
#> 363       Eastern Kentucky  OVC  74.5        6  75.6        6
#> 364              Green Bay Horz  74.0        7  74.2       14
#> 365                Buffalo  MAC  73.9        8  74.6        8
#> 366     North Carolina A&T MEAC  73.7        9  74.6        9
#> 367            The Citadel   SC  73.7       10  74.3       13
#> 368       Central Michigan  MAC  73.6       11  74.4       11
#> 369             Coppin St. MEAC  73.4       12  74.4       10
#> 370           San Jose St.  MWC  73.3       13  74.0       19
#> 371            Arizona St.  P12  73.2       14  73.6       23
#> 372       Central Arkansas Slnd  73.2       15  75.9        5
#> 373               Nebraska  B10  73.1       16  72.8       33
#> 374         South Carolina  SEC  73.1       17  72.5       37
#> 375     Eastern Washington BSky  73.1       18  73.6       24
#> 376            Georgia St.   SB  73.0       19  73.7       21
#> 377        Bethune Cookman MEAC  73.0       20  74.0       18
#> 378             St. John's   BE  72.9       21  74.1       16
#> 379         Texas Southern SWAC  72.9       22  74.4       12
#> 380                    LIU  NEC  72.8       23  73.3       26
#> 381                   UTSA CUSA  72.8       24  73.0       30
#> 382                Samford   SC  72.8       25  74.0       17
#> 383       Coastal Carolina   SB  72.8       26  73.3       27
#> 384               Monmouth MAAC  72.6       27  72.0       44
#> 385                Memphis Amer  72.6       28  73.1       29
#> 386       Northwestern St. Slnd  72.4       29  74.1       15
#> 387                    FIU CUSA  72.2       30  72.5       38
#> 388             Wright St. Horz  72.1       31  73.1       28
#> 389          James Madison  CAA  72.1       32  71.6       57
#> 390 Southeastern Louisiana Slnd  72.1       33  73.9       20
#> 391                   Duke  ACC  72.0       34  72.8       31
#> 392                Gonzaga  WCC  71.9       35  72.6       36
#> 393               Winthrop BSth  71.9       36  71.7       55
#> 394              Louisiana   SB  71.8       37  72.4       39
#> 395             New Mexico  MWC  71.8       38  72.6       35
#> 396      Stephen F. Austin Slnd  71.8       39  73.7       22
#> 397           Portland St. BSky  71.8       40  71.8       50
#> 398       Georgia Southern   SB  71.8       41  72.7       34
#> 399            Santa Clara  WCC  71.6       42  72.8       32
#> 400       Western Carolina   SC  71.5       43  72.3       41
#> 401       Western Illinois  Sum  71.3       44  72.0       45
#> 402               Arkansas  SEC  71.2       45  71.4       61
#> 403           Rhode Island  A10  71.2       46  71.9       47
#> 404         Saint Joseph's  A10  71.2       47  71.2       66
#> 405        Sam Houston St. Slnd  71.1       48  73.4       25
#> 406                  Rider MAAC  71.1       49  71.8       52
#> 407                 Nevada  MWC  71.0       50  71.7       56
#> 408          UNC Asheville BSth  71.0       51  70.8       79
#> 409              Loyola MD  Pat  71.0       52  71.2       68
#> 410                 Denver  Sum  70.9       53  71.5       60
#> 411               Penn St.  B10  70.9       54  71.4       62
#> 412         Long Beach St.   BW  70.9       55  71.3       64
#> 413                Hampton BSth  70.9       56  70.7       86
#> 414             Pepperdine  WCC  70.8       57  71.8       51
#> 415                  IUPUI Horz  70.8       58  71.2       70
#> 416         Washington St.  P12  70.8       59  71.1       71
#> 417              Marquette   BE  70.7       60  71.4       63
#> 418       Prairie View A&M SWAC  70.7       61  72.4       40
#> 419          East Carolina Amer  70.6       62  70.7       87
#> 420                 DePaul   BE  70.6       63  71.7       53
#> 421                Georgia  SEC  70.5       64  71.9       48
#> 422                Belmont  OVC  70.5       65  72.3       42
#> 423   UT Rio Grande Valley  WAC  70.4       66  70.5       99
#> 424         North Carolina  ACC  70.4       67  70.4      106
#> 425           Oral Roberts  Sum  70.4       68  71.8       49
#> 426            Utah Valley  WAC  70.4       69  70.3      111
#> 427         St. Francis NY  NEC  70.3       70  70.6       92
#> 428                 Bryant  NEC  70.3       71  70.2      116
#> 429           UMass Lowell   AE  70.3       72  70.8       78
#> 430                 Temple Amer  70.3       73  70.6       89
#> 431     Cal St. Northridge   BW  70.3       74  70.9       74
#> 432                 Howard MEAC  70.2       75  71.9       46
#> 433                   Penn  Ivy  70.2       76  71.0       72
#> 434                   Iowa  B10  70.2       77  70.6       93
#> 435              San Diego  WCC  70.2       78  70.7       85
#> 436            Wake Forest  ACC  70.1       79  70.8       81
#> 437                   Rice CUSA  70.1       80  71.3       65
#> 438          Bowling Green  MAC  70.1       81  70.9       76
#> 439             Alcorn St. SWAC  70.1       82  72.1       43
#> 440          North Alabama ASun  70.1       83  69.8      124
#> 441                    LSU  SEC  70.0       84  70.8       80
#> 442           South Dakota  Sum  70.0       85  71.0       73
#> 443               Canisius MAAC  70.0       86  70.3      110
#> 444             Georgetown   BE  70.0       87  71.6       58
#> 445           Georgia Tech  ACC  70.0       88  70.5       96
#> 446            Florida St.  ACC  69.9       89  69.6      139
#> 447               Iowa St.  B12  69.9       90  70.4      102
#> 448                Seattle  WAC  69.9       91  70.4      103
#> 449            Stony Brook   AE  69.8       92  69.8      128
#> 450             Seton Hall   BE  69.8       93  70.9       75
#> 451            New Orleans Slnd  69.8       94  71.7       54
#> 452       Middle Tennessee CUSA  69.8       95  70.5       94
#> 453             Washington  P12  69.8       96  70.3      113
#> 454            Alabama St. SWAC  69.7       97  70.8       83
#> 455               Oklahoma  B12  69.6       98  69.7      135
#> 456                  Lamar Slnd  69.6       99  71.2       67
#> 457             Morgan St. MEAC  69.6      100  70.9       77
#> 458            Wichita St. Amer  69.5      101  70.6       88
#> 459              Milwaukee Horz  69.5      102  70.3      112
#> 460             N.C. State  ACC  69.5      103  70.6       91
#> 461    Central Connecticut  NEC  69.5      104  70.5       97
#> 462       Illinois Chicago Horz  69.5      105  70.6       90
#> 463                   Army  Pat  69.5      106  69.7      132
#> 464               Bucknell  Pat  69.5      107  69.8      126
#> 465                    BYU  WCC  69.5      108  69.7      133
#> 466             Vanderbilt  SEC  69.4      109  70.0      120
#> 467                  Akron  MAC  69.4      110  70.1      118
#> 468          North Florida ASun  69.4      111  69.2      161
#> 469          West Virginia  B12  69.4      112  69.4      148
#> 470                  Brown  Ivy  69.4      113  69.9      121
#> 471      Cal St. Fullerton   BW  69.3      114  69.2      168
#> 472                Arizona  P12  69.3      115  70.3      109
#> 473           Colorado St.  MWC  69.3      116  69.7      134
#> 474                Detroit Horz  69.3      117  70.5       95
#> 475          Southern Utah BSky  69.3      118  69.5      147
#> 476                   Troy   SB  69.3      119  70.4      108
#> 477         Boston College  ACC  69.3      120  69.6      138
#> 478          Tennessee St.  OVC  69.3      121  70.4      104
#> 479               Portland  WCC  69.3      122  70.2      115
#> 480             Valparaiso  MVC  69.3      123  69.2      164
#> 481               Richmond  A10  69.3      124  69.3      159
#> 482            Little Rock   SB  69.3      125  70.2      117
#> 483         Nebraska Omaha  Sum  69.2      126  70.8       82
#> 484                 Auburn  SEC  69.2      127  70.5      100
#> 485            USC Upstate BSth  69.2      128  69.3      156
#> 486       Eastern Illinois  OVC  69.1      129  70.4      101
#> 487           Michigan St.  B10  69.1      130  69.3      157
#> 488               La Salle  A10  69.1      131  69.7      129
#> 489               Columbia  Ivy  69.1      132  69.4      151
#> 490              Boise St.  MWC  69.1      133  69.7      131
#> 491                    VCU  A10  69.0      134  69.2      162
#> 492            Chicago St.  WAC  69.0      135  69.4      150
#> 493       SIU Edwardsville  OVC  69.0      136  69.9      122
#> 494            McNeese St. Slnd  69.0      137  71.2       69
#> 495         St. Francis PA  NEC  68.9      138  69.7      130
#> 496                    USC  P12  68.9      139  70.0      119
#> 497                  Idaho BSky  68.9      140  69.0      175
#> 498             Quinnipiac MAAC  68.9      141  68.9      184
#> 499    Fairleigh Dickinson  NEC  68.9      142  69.0      174
#> 500               Kent St.  MAC  68.9      143  69.6      140
#> 501             Murray St.  OVC  68.9      144  69.5      143
#> 502           North Dakota  Sum  68.9      145  70.2      114
#> 503       Florida Atlantic CUSA  68.8      146  69.6      141
#> 504              Air Force  MWC  68.8      147  68.9      183
#> 505                Harvard  Ivy  68.8      148  68.8      186
#> 506       Tennessee Martin  OVC  68.7      149  69.7      136
#> 507               Michigan  B10  68.7      150  69.4      152
#> 508          Grambling St. SWAC  68.7      151  70.5       98
#> 509           Sacred Heart  NEC  68.7      152  69.5      145
#> 510               Lipscomb ASun  68.7      153  68.1      232
#> 511                 Tulane Amer  68.7      154  69.4      154
#> 512          San Francisco  WCC  68.7      155  69.0      176
#> 513                   Iona MAAC  68.7      156  68.6      203
#> 514            Jackson St. SWAC  68.7      157  70.4      107
#> 515           Nicholls St. Slnd  68.7      158  71.5       59
#> 516               American  Pat  68.7      159  68.9      181
#> 517            Florida A&M MEAC  68.6      160  70.8       84
#> 518          Massachusetts  A10  68.6      161  69.2      169
#> 519            Cal Baptist  WAC  68.6      162  69.4      149
#> 520          New Hampshire   AE  68.6      163  69.5      146
#> 521             Binghamton   AE  68.6      164  68.9      182
#> 522         UNC Wilmington  CAA  68.5      165  68.4      216
#> 523                 Albany   AE  68.5      166  69.4      153
#> 524            Connecticut Amer  68.5      167  69.0      179
#> 525                Colgate  Pat  68.5      168  68.6      201
#> 526           Illinois St.  MVC  68.5      169  68.2      229
#> 527                 Hawaii   BW  68.4      170  69.1      172
#> 528             Providence   BE  68.4      171  69.6      142
#> 529      Abilene Christian Slnd  68.4      172  70.4      105
#> 530           Oklahoma St.  B12  68.4      173  68.4      214
#> 531                 Lehigh  Pat  68.4      174  68.7      199
#> 532               Cal Poly   BW  68.3      175  68.2      228
#> 533       Western Kentucky CUSA  68.3      176  69.5      144
#> 534             Holy Cross  Pat  68.3      177  68.7      195
#> 535              Creighton   BE  68.3      178  69.8      127
#> 536               Syracuse  ACC  68.3      179  68.4      220
#> 537               Miami FL  ACC  68.3      180  68.7      193
#> 538           Missouri St.  MVC  68.3      181  68.6      207
#> 539               Delaware  CAA  68.3      182  68.5      209
#> 540               Stanford  P12  68.3      183  68.7      194
#> 541               Hartford   AE  68.2      184  68.5      211
#> 542                Montana BSky  68.2      185  69.2      163
#> 543           Kennesaw St. ASun  68.2      186  68.1      230
#> 544                 Furman   SC  68.2      187  69.2      166
#> 545               Colorado  P12  68.2      188  68.1      231
#> 546       Jacksonville St.  OVC  68.1      189  69.1      171
#> 547             Notre Dame  ACC  68.1      190  69.0      177
#> 548                 Xavier   BE  68.1      191  69.2      167
#> 549                 Mercer   SC  68.1      192  69.8      125
#> 550                 Toledo  MAC  68.1      193  69.3      160
#> 551               UC Davis   BW  68.0      194  67.8      241
#> 552                   Ohio  MAC  68.0      195  68.8      189
#> 553            Mississippi  SEC  68.0      196  68.8      191
#> 554          Saint Peter's MAAC  68.0      197  68.6      204
#> 555           Grand Canyon  WAC  68.0      198  67.5      254
#> 556             Cincinnati Amer  68.0      199  68.8      185
#> 557               Ball St.  MAC  68.0      200  69.1      173
#> 558       South Dakota St.  Sum  68.0      201  69.8      123
#> 559                Hofstra  CAA  67.9      202  68.4      221
#> 560                    VMI   SC  67.9      203  68.7      196
#> 561                  Drake  MVC  67.9      204  67.3      262
#> 562      Purdue Fort Wayne  Sum  67.9      205  68.9      180
#> 563                Indiana  B10  67.9      206  68.7      200
#> 564               Longwood BSth  67.8      207  68.5      213
#> 565                    UCF Amer  67.8      208  68.7      197
#> 566            Austin Peay  OVC  67.8      209  69.1      170
#> 567         UNC Greensboro   SC  67.8      210  68.6      205
#> 568               Duquesne  A10  67.8      211  67.7      247
#> 569              UC Irvine   BW  67.7      212  68.4      218
#> 570            Alabama A&M SWAC  67.7      213  69.6      137
#> 571           UT Arlington   SB  67.7      214  68.7      198
#> 572               Kentucky  SEC  67.7      215  68.5      212
#> 573              Weber St. BSky  67.6      216  67.9      236
#> 574             Evansville  MVC  67.6      217  67.8      243
#> 575 Southeast Missouri St.  OVC  67.6      218  68.6      202
#> 576            Saint Louis  A10  67.6      219  68.4      215
#> 577                 Dayton  A10  67.6      220  68.0      233
#> 578 Maryland Eastern Shore MEAC  67.5      221  69.3      158
#> 579         William & Mary  CAA  67.5      222  67.9      239
#> 580                 Wagner  NEC  67.5      223  68.8      192
#> 581                   UTEP CUSA  67.5      224  68.4      219
#> 582            Norfolk St. MEAC  67.5      225  69.3      155
#> 583     South Carolina St. MEAC  67.4      226  69.2      165
#> 584                   Yale  Ivy  67.4      227  67.9      237
#> 585       Western Michigan  MAC  67.4      228  68.4      217
#> 586               Utah St.  MWC  67.4      229  68.0      234
#> 587              Idaho St. BSky  67.4      230  67.6      250
#> 588                Rutgers  B10  67.4      231  67.6      253
#> 589           Morehead St.  OVC  67.3      232  68.8      188
#> 590                 Kansas  B12  67.3      233  67.6      248
#> 591            Montana St. BSky  67.3      234  67.8      242
#> 592                 Drexel  CAA  67.3      235  67.7      244
#> 593             Texas Tech  B12  67.3      236  68.3      223
#> 594           Arkansas St.   SB  67.3      237  68.3      225
#> 595          Southern Miss CUSA  67.2      238  68.2      226
#> 596             Kansas St.  B12  67.2      239  67.3      267
#> 597        Appalachian St.   SB  67.2      240  68.3      222
#> 598          Cleveland St. Horz  67.1      241  69.0      178
#> 599             Louisville  ACC  67.1      242  67.2      269
#> 600               Miami OH  MAC  67.1      243  68.8      190
#> 601                Bradley  MVC  67.1      244  67.1      271
#> 602               Maryland  B10  67.0      245  67.6      249
#> 603           George Mason  A10  67.0      246  67.4      261
#> 604                   UNLV  MWC  67.0      247  67.3      266
#> 605            Chattanooga   SC  67.0      248  68.2      227
#> 606                   NJIT ASun  66.9      249  66.6      291
#> 607    Charleston Southern BSth  66.9      250  67.9      238
#> 608              Lafayette  Pat  66.9      251  67.5      255
#> 609         Tennessee Tech  OVC  66.9      252  68.5      210
#> 610           Presbyterian BSth  66.9      253  67.0      279
#> 611       Eastern Michigan  MAC  66.8      254  67.7      245
#> 612                   UMBC   AE  66.8      255  67.3      265
#> 613               Southern SWAC  66.8      256  68.5      208
#> 614              Minnesota  B10  66.8      257  67.3      264
#> 615                Wyoming  MWC  66.7      258  67.4      260
#> 616           Northwestern  B10  66.7      259  66.7      287
#> 617                   Utah  P12  66.7      260  67.6      252
#> 618                  Siena MAAC  66.7      261  67.2      270
#> 619           Jacksonville ASun  66.6      262  66.7      285
#> 620 North Carolina Central MEAC  66.6      263  68.8      187
#> 621      George Washington  A10  66.6      264  66.7      283
#> 622       Northern Arizona BSky  66.6      265  67.1      273
#> 623         Louisiana Tech CUSA  66.5      266  67.7      246
#> 624               Missouri  SEC  66.5      267  67.0      277
#> 625           Old Dominion CUSA  66.4      268  67.5      257
#> 626         Youngstown St. Horz  66.4      269  68.0      235
#> 627            Indiana St.  MVC  66.4      270  66.2      305
#> 628             High Point BSth  66.4      271  67.0      275
#> 629      Boston University  Pat  66.3      272  66.5      299
#> 630                Vermont   AE  66.3      273  66.5      298
#> 631              Princeton  Ivy  66.3      274  67.1      272
#> 632              Villanova   BE  66.2      275  67.6      251
#> 633        Mississippi St.  SEC  66.2      276  67.3      263
#> 634                 Baylor  B12  66.2      277  66.6      289
#> 635                   Elon  CAA  66.2      278  66.5      301
#> 636           Gardner Webb BSth  66.2      279  66.8      281
#> 637               Ohio St.  B10  66.2      280  66.7      286
#> 638     East Tennessee St.   SC  66.1      281  67.5      258
#> 639          Robert Morris  NEC  66.1      282  67.1      274
#> 640         Incarnate Word Slnd  66.1      283  68.6      206
#> 641    Arkansas Pine Bluff SWAC  66.1      284  67.5      259
#> 642                Oakland Horz  66.1      285  67.2      268
#> 643     Florida Gulf Coast ASun  66.1      286  66.2      307
#> 644       North Dakota St.  Sum  66.0      287  67.5      256
#> 645               Illinois  B10  66.0      288  67.0      278
#> 646                Niagara MAAC  66.0      289  66.5      300
#> 647                Clemson  ACC  66.0      290  66.6      294
#> 648           Northeastern  CAA  65.9      291  65.8      320
#> 649                  Texas  B12  65.9      292  66.2      310
#> 650                Wofford   SC  65.9      293  66.6      296
#> 651                  Maine   AE  65.9      294  66.0      317
#> 652             Charleston  CAA  65.9      295  66.6      288
#> 653              Manhattan MAAC  65.8      296  66.2      306
#> 654                  Tulsa Amer  65.8      297  67.0      276
#> 655              Dartmouth  Ivy  65.8      298  66.3      303
#> 656          Northern Iowa  MVC  65.8      299  65.7      323
#> 657                Houston Amer  65.7      300  66.8      282
#> 658        St. Bonaventure  A10  65.7      301  66.2      309
#> 659                    UAB CUSA  65.7      302  67.0      280
#> 660 Texas A&M Corpus Chris Slnd  65.7      303  68.3      224
#> 661      Northern Kentucky Horz  65.7      304  67.9      240
#> 662             Oregon St.  P12  65.6      305  66.6      295
#> 663               Campbell BSth  65.6      306  66.6      292
#> 664              Charlotte CUSA  65.5      307  66.6      290
#> 665             Pittsburgh  ACC  65.5      308  66.0      314
#> 666          Virginia Tech  ACC  65.5      309  66.1      311
#> 667          South Alabama   SB  65.3      310  66.7      284
#> 668         Loyola Chicago  MVC  65.3      311  65.5      328
#> 669              Texas St.   SB  65.2      312  66.6      293
#> 670              Tennessee  SEC  65.2      313  66.6      297
#> 671                Cornell  Ivy  65.2      314  65.8      319
#> 672             California  P12  65.2      315  65.7      322
#> 673                 Marist MAAC  65.2      316  65.5      327
#> 674                 Towson  CAA  65.1      317  65.4      332
#> 675                    TCU  B12  65.1      318  65.6      326
#> 676                 Oregon  P12  65.0      319  66.2      308
#> 677      Northern Colorado BSky  65.0      320  65.5      331
#> 678    Cal St. Bakersfield  WAC  64.9      321  65.5      330
#> 679       Louisiana Monroe   SB  64.9      322  66.1      313
#> 680                Pacific  WCC  64.9      323  65.9      318
#> 681          South Florida Amer  64.9      324  65.5      329
#> 682                   UCLA  P12  64.9      325  66.3      302
#> 683                Florida  SEC  64.9      326  66.2      304
#> 684                   UMKC  WAC  64.9      327  65.6      324
#> 685                Fordham  A10  64.8      328  65.2      333
#> 686      Northern Illinois  MAC  64.8      329  66.1      312
#> 687               Davidson  A10  64.8      330  65.6      325
#> 688                    SMU Amer  64.8      331  66.0      315
#> 689          San Diego St.  MWC  64.6      332  66.0      316
#> 690                 Purdue  B10  64.6      333  64.7      338
#> 691              Texas A&M  SEC  64.5      334  65.7      321
#> 692       UC Santa Barbara   BW  64.5      335  64.9      337
#> 693                Radford BSth  64.3      336  64.9      336
#> 694      Southern Illinois  MVC  64.2      337  64.1      346
#> 695             Fresno St.  MWC  64.2      338  65.0      334
#> 696           Saint Mary's  WCC  63.9      339  65.0      335
#> 697         Sacramento St. BSky  63.9      340  64.4      341
#> 698                 Butler   BE  63.7      341  64.5      339
#> 699              Wisconsin  B10  63.7      342  64.5      340
#> 700         New Mexico St.  WAC  63.5      343  64.3      342
#> 701                Stetson ASun  63.2      344  63.9      349
#> 702       Mount St. Mary's  NEC  63.2      345  64.3      344
#> 703              Fairfield MAAC  63.2      346  63.6      350
#> 704           UC Riverside   BW  63.2      347  64.1      347
#> 705              Merrimack  NEC  63.2      348  64.0      348
#> 706       Loyola Marymount  WCC  63.0      349  64.3      343
#> 707            North Texas CUSA  62.9      350  64.2      345
#> 708                   Navy  Pat  62.5      351  62.2      351
#> 709                Liberty ASun  61.5      352  61.3      352
#> 710               Virginia  ACC  59.4      353  60.3      353
#>     avg_poss_length_off avg_poss_length_off_rk avg_poss_length_def
#> 1                  14.0                      1                16.1
#> 2                  15.4                     16                16.1
#> 3                  15.2                     12                16.7
#> 4                  15.5                     18                16.7
#> 5                  14.6                      4                17.8
#> 6                  15.5                     17                16.0
#> 7                  14.4                      3                18.0
#> 8                  15.3                     14                17.1
#> 9                  14.9                      8                17.4
#> 10                 14.9                      9                17.3
#> 11                 14.2                      2                17.8
#> 12                 15.4                     15                15.7
#> 13                 15.6                     21                16.2
#> 14                 15.0                     10                18.0
#> 15                 14.7                      5                17.5
#> 16                 15.2                     11                17.2
#> 17                 15.7                     24                16.5
#> 18                 16.1                     47                16.1
#> 19                 16.0                     36                16.0
#> 20                 14.8                      6                17.8
#> 21                 16.1                     49                17.1
#> 22                 16.5                     79                16.3
#> 23                 16.1                     43                16.1
#> 24                 15.7                     26                17.2
#> 25                  0.0                      1                 0.0
#> 26                 16.0                     35                17.0
#> 27                 15.9                     31                17.8
#> 28                 16.5                     75                16.4
#> 29                 16.0                     34                16.6
#> 30                 16.4                     68                16.5
#> 31                 16.6                     90                16.9
#> 32                 15.8                     28                16.0
#> 33                 15.9                     32                17.6
#> 34                 15.2                     13                17.5
#> 35                 15.5                     19                17.4
#> 36                 16.1                     46                17.3
#> 37                 16.5                     73                16.6
#> 38                 16.4                     62                16.9
#> 39                 16.6                     98                16.5
#> 40                 16.6                     89                16.4
#> 41                 16.5                     71                16.6
#> 42                 15.6                     22                16.6
#> 43                 15.7                     25                17.7
#> 44                 16.6                    100                15.9
#> 45                 16.2                     57                16.4
#> 46                 16.1                     41                16.9
#> 47                 15.5                     20                17.7
#> 48                 16.3                     58                17.1
#> 49                 16.5                     84                16.6
#> 50                 16.6                    105                15.6
#> 51                 16.8                    116                16.4
#> 52                 16.3                     59                16.9
#> 53                 16.4                     69                17.4
#> 54                 16.5                     76                16.3
#> 55                 17.1                    154                15.9
#> 56                 16.2                     52                17.4
#> 57                 16.0                     39                16.5
#> 58                 16.8                    114                16.5
#> 59                 15.9                     33                17.4
#> 60                 16.6                     95                17.1
#> 61                 16.1                     42                16.2
#> 62                 16.5                     82                15.9
#> 63                 16.0                     38                16.8
#> 64                 15.7                     27                17.5
#> 65                 16.4                     67                16.8
#> 66                 16.7                    108                17.0
#> 67                 16.6                    101                16.6
#> 68                 16.5                     72                17.1
#> 69                 16.6                     96                16.9
#> 70                 16.2                     51                16.8
#> 71                 16.5                     78                16.7
#> 72                 15.8                     29                18.0
#> 73                 16.6                     97                16.2
#> 74                 16.2                     53                17.5
#> 75                 16.2                     55                17.8
#> 76                 16.2                     54                17.5
#> 77                 16.8                    125                16.7
#> 78                 15.9                     30                17.9
#> 79                 16.8                    112                17.1
#> 80                 16.5                     80                17.5
#> 81                 15.7                     23                17.7
#> 82                 16.4                     63                17.1
#> 83                 16.6                     99                16.9
#> 84                 16.9                    134                16.1
#> 85                 17.0                    139                16.7
#> 86                 16.3                     60                17.7
#> 87                 17.2                    164                16.6
#> 88                 16.7                    109                17.0
#> 89                 16.5                     83                17.0
#> 90                 16.2                     56                18.0
#> 91                 16.9                    135                17.0
#> 92                 17.0                    138                16.9
#> 93                 16.2                     50                17.6
#> 94                 16.5                     81                16.9
#> 95                 16.6                    104                17.4
#> 96                 16.1                     45                17.1
#> 97                 16.4                     66                17.2
#> 98                 17.4                    189                16.6
#> 99                 17.0                    142                17.6
#> 100                 0.0                      1                 0.0
#> 101                16.8                    121                17.0
#> 102                16.6                     93                16.5
#> 103                14.8                      7                18.4
#> 104                17.4                    191                16.6
#> 105                17.0                    143                16.7
#> 106                16.8                    128                17.3
#> 107                16.0                     37                18.0
#> 108                17.1                    156                17.7
#> 109                16.7                    106                17.8
#> 110                16.1                     40                16.5
#> 111                17.2                    167                16.4
#> 112                16.8                    119                17.2
#> 113                18.1                    258                16.6
#> 114                17.1                    152                16.7
#> 115                16.9                    129                16.7
#> 116                17.1                    159                17.0
#> 117                17.6                    210                16.7
#> 118                16.8                    113                17.3
#> 119                17.1                    147                16.9
#> 120                16.8                    117                17.7
#> 121                16.7                    107                16.9
#> 122                17.4                    179                16.8
#> 123                17.1                    148                16.6
#> 124                 0.0                      1                 0.0
#> 125                16.6                     92                18.0
#> 126                17.5                    200                16.8
#> 127                17.5                    198                17.6
#> 128                16.5                     70                17.6
#> 129                17.4                    188                16.8
#> 130                16.6                     94                17.7
#> 131                17.3                    176                17.4
#> 132                16.6                     87                18.3
#> 133                17.0                    137                17.4
#> 134                16.9                    132                17.2
#> 135                17.5                    195                17.6
#> 136                17.4                    180                16.9
#> 137                 0.0                      1                 0.0
#> 138                17.1                    149                17.0
#> 139                17.5                    197                17.6
#> 140                17.3                    171                17.0
#> 141                16.1                     48                17.6
#> 142                17.0                    144                17.1
#> 143                16.7                    111                17.2
#> 144                16.1                     44                18.2
#> 145                16.9                    133                17.3
#> 146                16.4                     64                18.1
#> 147                18.2                    267                16.0
#> 148                17.4                    185                17.7
#> 149                17.0                    145                17.5
#> 150                17.3                    177                16.3
#> 151                16.4                     61                18.0
#> 152                17.2                    169                17.3
#> 153                16.9                    130                17.4
#> 154                17.2                    162                17.1
#> 155                17.1                    158                17.2
#> 156                17.2                    161                16.2
#> 157                16.6                    102                17.3
#> 158                17.2                    168                17.3
#> 159                16.8                    120                17.2
#> 160                16.4                     65                18.1
#> 161                16.5                     77                17.1
#> 162                17.9                    244                17.1
#> 163                16.8                    122                17.1
#> 164                17.3                    174                17.4
#> 165                17.5                    205                17.4
#> 166                17.9                    242                17.0
#> 167                16.6                     88                17.4
#> 168                17.1                    150                17.8
#> 169                16.6                    103                17.8
#> 170                17.0                    136                17.1
#> 171                17.5                    196                17.8
#> 172                17.9                    247                16.6
#> 173                17.7                    223                16.8
#> 174                16.5                     74                18.0
#> 175                17.1                    153                17.4
#> 176                16.8                    124                17.8
#> 177                16.7                    110                17.8
#> 178                17.8                    231                16.4
#> 179                16.8                    123                18.0
#> 180                 0.0                      1                 0.0
#> 181                17.1                    151                17.2
#> 182                17.9                    241                17.5
#> 183                16.6                     91                17.4
#> 184                16.8                    127                17.9
#> 185                 0.0                      1                 0.0
#> 186                16.8                    118                17.6
#> 187                17.3                    175                17.4
#> 188                17.8                    233                17.1
#> 189                18.1                    262                17.2
#> 190                18.3                    279                16.8
#> 191                17.5                    206                17.7
#> 192                 0.0                      1                 0.0
#> 193                17.0                    141                18.2
#> 194                18.5                    299                16.7
#> 195                18.0                    249                17.1
#> 196                17.4                    187                17.0
#> 197                17.7                    220                16.8
#> 198                16.8                    126                18.3
#> 199                17.6                    213                17.0
#> 200                16.6                     86                17.4
#> 201                17.7                    222                16.9
#> 202                17.6                    217                17.4
#> 203                17.7                    221                17.7
#> 204                16.8                    115                17.9
#> 205                17.6                    209                17.6
#> 206                17.1                    157                17.0
#> 207                18.2                    266                16.7
#> 208                16.6                     85                18.1
#> 209                17.7                    225                16.5
#> 210                17.4                    184                16.7
#> 211                17.6                    211                16.2
#> 212                17.8                    235                15.9
#> 213                17.0                    140                17.6
#> 214                17.2                    166                17.9
#> 215                18.2                    275                17.1
#> 216                18.3                    278                16.7
#> 217                17.8                    238                17.4
#> 218                17.5                    208                17.3
#> 219                17.6                    216                16.9
#> 220                18.0                    252                16.8
#> 221                17.4                    181                18.1
#> 222                18.1                    257                17.1
#> 223                17.7                    229                17.6
#> 224                17.2                    163                17.7
#> 225                17.8                    234                17.4
#> 226                17.4                    182                17.8
#> 227                17.4                    193                18.1
#> 228                17.4                    186                17.4
#> 229                17.5                    199                17.3
#> 230                18.0                    250                17.2
#> 231                17.4                    192                17.9
#> 232                17.2                    165                17.4
#> 233                17.5                    202                18.0
#> 234                17.6                    214                17.8
#> 235                17.4                    190                18.3
#> 236                18.2                    272                16.8
#> 237                18.2                    274                17.1
#> 238                17.3                    173                17.9
#> 239                17.5                    201                18.3
#> 240                17.4                    183                17.6
#> 241                18.9                    315                16.7
#> 242                18.5                    298                16.0
#> 243                18.6                    303                17.2
#> 244                17.7                    219                18.2
#> 245                17.5                    204                18.0
#> 246                 0.0                      1                 0.0
#> 247                18.0                    253                17.2
#> 248                17.5                    203                17.6
#> 249                17.9                    245                16.9
#> 250                17.7                    227                17.6
#> 251                18.2                    277                17.3
#> 252                17.1                    160                18.2
#> 253                17.8                    240                17.4
#> 254                19.1                    325                16.8
#> 255                18.1                    261                17.4
#> 256                17.4                    194                18.1
#> 257                 0.0                      1                 0.0
#> 258                18.3                    280                17.0
#> 259                 0.0                      1                 0.0
#> 260                17.8                    232                17.2
#> 261                17.0                    146                18.3
#> 262                18.6                    304                17.0
#> 263                17.4                    178                17.8
#> 264                17.3                    170                18.0
#> 265                17.6                    215                18.5
#> 266                18.4                    293                17.2
#> 267                17.9                    243                17.9
#> 268                17.7                    224                17.7
#> 269                18.2                    273                16.8
#> 270                18.2                    269                17.3
#> 271                18.1                    264                18.2
#> 272                17.8                    239                17.4
#> 273                18.9                    314                17.6
#> 274                18.5                    297                17.9
#> 275                17.3                    172                18.1
#> 276                17.8                    237                18.4
#> 277                18.4                    292                17.1
#> 278                18.4                    295                17.8
#> 279                17.6                    212                17.8
#> 280                18.2                    276                17.4
#> 281                18.4                    290                17.3
#> 282                17.5                    207                17.9
#> 283                18.3                    281                16.5
#> 284                18.5                    300                17.0
#> 285                18.9                    313                16.6
#> 286                18.3                    282                17.1
#> 287                17.7                    228                17.2
#> 288                17.1                    155                19.1
#> 289                18.1                    259                17.5
#> 290                18.3                    284                17.7
#> 291                18.1                    263                17.4
#> 292                18.3                    283                16.8
#> 293                18.4                    288                16.7
#> 294                18.9                    318                16.9
#> 295                18.1                    254                18.0
#> 296                18.4                    287                17.2
#> 297                18.8                    312                17.2
#> 298                18.2                    270                18.0
#> 299                18.4                    286                17.3
#> 300                17.9                    246                18.2
#> 301                18.1                    255                17.9
#> 302                17.9                    248                17.3
#> 303                17.7                    230                18.0
#> 304                18.4                    294                17.5
#> 305                18.6                    307                17.4
#> 306                18.9                    316                17.6
#> 307                16.9                    131                18.8
#> 308                18.8                    309                17.3
#> 309                18.8                    310                17.4
#> 310                18.4                    296                17.8
#> 311                18.1                    256                17.5
#> 312                17.7                    226                17.7
#> 313                18.6                    305                17.8
#> 314                18.2                    271                17.2
#> 315                17.8                    236                18.3
#> 316                18.2                    268                17.9
#> 317                18.6                    302                17.4
#> 318                18.1                    260                17.1
#> 319                18.3                    285                17.4
#> 320                18.9                    317                18.0
#> 321                18.4                    289                18.3
#> 322                19.0                    321                17.3
#> 323                18.2                    265                17.9
#> 324                18.4                    291                16.7
#> 325                20.0                    343                16.7
#> 326                19.5                    337                17.3
#> 327                19.2                    330                16.6
#> 328                19.0                    320                17.4
#> 329                19.0                    323                17.7
#> 330                19.2                    326                17.4
#> 331                19.8                    341                16.0
#> 332                19.3                    334                17.3
#> 333                19.2                    328                17.4
#> 334                17.6                    218                18.5
#> 335                19.4                    336                17.5
#> 336                18.6                    301                17.6
#> 337                18.0                    251                18.7
#> 338                18.9                    319                17.7
#> 339                19.2                    327                17.3
#> 340                19.3                    333                16.8
#> 341                19.0                    324                17.9
#> 342                18.6                    306                19.0
#> 343                18.8                    311                18.2
#> 344                19.2                    329                17.4
#> 345                19.0                    322                18.1
#> 346                19.7                    339                17.4
#> 347                19.4                    335                17.6
#> 348                20.2                    345                16.2
#> 349                19.8                    340                17.5
#> 350                19.3                    331                17.6
#> 351                18.8                    308                18.1
#> 352                19.3                    332                17.8
#> 353                19.5                    338                18.3
#> 354                19.9                    342                17.4
#> 355                21.5                    347                16.4
#> 356                20.1                    344                17.4
#> 357                20.3                    346                18.8
#> 358                15.6                     21                14.7
#> 359                14.8                      3                16.0
#> 360                14.8                      2                17.1
#> 361                15.2                      6                16.4
#> 362                15.3                     10                16.2
#> 363                15.8                     27                15.8
#> 364                14.4                      1                17.9
#> 365                14.9                      4                17.3
#> 366                16.0                     37                15.9
#> 367                15.9                     35                16.4
#> 368                15.6                     18                16.6
#> 369                15.4                     13                16.9
#> 370                16.3                     53                16.1
#> 371                15.8                     29                16.6
#> 372                15.8                     28                15.9
#> 373                15.1                      5                17.6
#> 374                15.3                     11                17.7
#> 375                15.3                      9                17.4
#> 376                15.8                     24                16.9
#> 377                15.6                     20                16.7
#> 378                15.5                     16                16.8
#> 379                16.0                     39                16.6
#> 380                16.1                     41                16.7
#> 381                16.2                     48                16.6
#> 382                15.9                     34                16.7
#> 383                16.4                     62                16.3
#> 384                15.6                     19                17.6
#> 385                15.6                     17                17.1
#> 386                16.3                     58                16.1
#> 387                15.2                      8                17.6
#> 388                15.7                     23                17.1
#> 389                15.8                     25                17.6
#> 390                15.8                     32                16.7
#> 391                16.2                     49                16.6
#> 392                15.2                      7                17.7
#> 393                15.4                     14                17.9
#> 394                16.7                    101                16.6
#> 395                16.3                     59                16.7
#> 396                16.4                     65                16.0
#> 397                16.4                     68                16.9
#> 398                15.8                     26                17.1
#> 399                15.3                     12                17.5
#> 400                16.7                     96                16.4
#> 401                17.1                    143                16.2
#> 402                16.7                     94                17.0
#> 403                16.1                     44                17.3
#> 404                16.5                     74                17.1
#> 405                16.0                     40                16.9
#> 406                16.6                     85                16.9
#> 407                16.3                     57                17.3
#> 408                16.5                     72                17.2
#> 409                16.7                     92                16.7
#> 410                16.5                     73                16.9
#> 411                16.2                     50                17.4
#> 412                16.6                     81                17.2
#> 413                16.5                     77                17.1
#> 414                15.8                     30                17.7
#> 415                16.5                     71                17.2
#> 416                16.7                    102                17.0
#> 417                16.5                     76                17.4
#> 418                16.3                     56                16.8
#> 419                16.6                     78                17.5
#> 420                15.5                     15                17.8
#> 421                16.3                     60                16.9
#> 422                15.7                     22                17.3
#> 423                15.9                     33                17.9
#> 424                16.6                     90                17.3
#> 425                16.1                     43                17.1
#> 426                16.8                    106                17.1
#> 427                17.1                    150                16.7
#> 428                17.2                    155                16.8
#> 429                16.2                     47                17.3
#> 430                16.1                     45                17.9
#> 431                16.9                    125                16.8
#> 432                16.9                    124                16.1
#> 433                16.8                    112                17.0
#> 434                16.2                     52                17.6
#> 435                17.0                    139                17.1
#> 436                16.6                     86                17.1
#> 437                16.9                    118                16.7
#> 438                16.6                     88                17.0
#> 439                16.8                    103                16.5
#> 440                16.9                    116                17.5
#> 441                16.8                    111                17.0
#> 442                16.8                    114                17.0
#> 443                17.1                    152                17.0
#> 444                15.9                     36                17.6
#> 445                17.0                    140                17.0
#> 446                16.7                     95                17.9
#> 447                16.4                     64                17.5
#> 448                17.4                    179                17.0
#> 449                17.0                    128                17.6
#> 450                16.9                    119                16.9
#> 451                16.4                     66                17.0
#> 452                16.5                     70                17.4
#> 453                16.1                     46                18.1
#> 454                17.0                    126                17.1
#> 455                16.2                     51                18.1
#> 456                16.6                     84                16.9
#> 457                17.1                    146                16.7
#> 458                17.3                    165                16.6
#> 459                16.6                     87                17.4
#> 460                16.6                     80                17.3
#> 461                16.8                    115                16.9
#> 462                17.3                    171                16.7
#> 463                15.8                     31                18.3
#> 464                16.5                     75                17.9
#> 465                17.0                    131                17.4
#> 466                17.8                    236                16.2
#> 467                16.4                     63                17.7
#> 468                16.7                     91                17.9
#> 469                17.5                    197                17.1
#> 470                17.3                    164                16.9
#> 471                16.6                     82                18.1
#> 472                16.3                     54                17.9
#> 473                16.7                     98                17.5
#> 474                17.6                    214                16.2
#> 475                17.1                    147                17.6
#> 476                17.1                    142                17.1
#> 477                17.1                    149                17.2
#> 478                17.1                    145                16.8
#> 479                16.8                    110                17.2
#> 480                16.6                     83                17.9
#> 481                16.7                     99                17.5
#> 482                17.6                    213                16.6
#> 483                16.6                     89                17.1
#> 484                16.4                     67                17.5
#> 485                17.8                    233                16.6
#> 486                17.4                    176                16.6
#> 487                16.6                     79                18.0
#> 488                17.3                    175                17.0
#> 489                16.7                    100                17.9
#> 490                17.0                    130                17.5
#> 491                16.0                     38                18.4
#> 492                17.9                    253                16.6
#> 493                17.4                    189                16.7
#> 494                17.3                    166                16.5
#> 495                16.3                     55                18.0
#> 496                16.9                    123                17.5
#> 497                17.5                    203                17.3
#> 498                17.1                    154                17.7
#> 499                16.8                    109                17.8
#> 500                17.3                    174                17.2
#> 501                17.0                    138                17.4
#> 502                17.9                    239                16.2
#> 503                16.1                     42                18.1
#> 504                17.6                    219                17.2
#> 505                16.9                    121                17.8
#> 506                18.1                    263                16.3
#> 507                17.1                    148                17.4
#> 508                17.0                    129                17.3
#> 509                17.8                    234                16.6
#> 510                17.4                    182                17.8
#> 511                16.7                     97                17.6
#> 512                17.0                    136                17.5
#> 513                17.0                    141                17.8
#> 514                17.5                    191                16.8
#> 515                17.1                    144                16.5
#> 516                17.9                    242                16.9
#> 517                17.3                    172                16.6
#> 518                18.0                    262                16.6
#> 519                16.7                     93                17.5
#> 520                18.1                    269                16.3
#> 521                17.4                    178                17.1
#> 522                16.8                    113                18.1
#> 523                17.6                    217                17.1
#> 524                17.5                    190                17.2
#> 525                17.2                    156                17.7
#> 526                16.4                     61                18.8
#> 527                17.9                    251                17.1
#> 528                17.3                    167                17.1
#> 529                17.0                    133                17.2
#> 530                17.3                    170                17.5
#> 531                17.7                    223                17.1
#> 532                17.6                    208                17.3
#> 533                17.3                    162                17.1
#> 534                17.9                    254                16.9
#> 535                16.5                     69                17.8
#> 536                16.8                    104                18.2
#> 537                18.1                    266                16.7
#> 538                17.6                    216                17.3
#> 539                17.5                    193                17.6
#> 540                17.4                    181                17.4
#> 541                18.2                    292                16.7
#> 542                17.0                    134                17.5
#> 543                18.3                    297                16.8
#> 544                17.2                    158                17.4
#> 545                17.5                    196                17.7
#> 546                18.2                    286                16.5
#> 547                16.8                    107                17.9
#> 548                17.7                    227                17.1
#> 549                17.5                    201                16.9
#> 550                17.2                    160                17.0
#> 551                17.3                    173                18.0
#> 552                18.1                    265                16.8
#> 553                17.4                    186                17.3
#> 554                17.8                    235                17.1
#> 555                17.8                    228                17.7
#> 556                17.0                    137                17.7
#> 557                17.9                    240                16.9
#> 558                17.1                    153                17.2
#> 559                16.8                    105                18.3
#> 560                16.9                    122                17.8
#> 561                17.8                    231                17.7
#> 562                16.9                    117                17.7
#> 563                17.5                    195                17.5
#> 564                16.8                    108                18.0
#> 565                17.6                    220                17.1
#> 566                17.6                    207                16.9
#> 567                17.0                    135                17.9
#> 568                17.9                    244                17.9
#> 569                17.5                    204                17.3
#> 570                17.5                    198                17.0
#> 571                17.2                    161                17.6
#> 572                17.4                    183                17.7
#> 573                17.9                    246                17.5
#> 574                18.1                    267                17.0
#> 575                16.9                    120                17.7
#> 576                17.5                    194                17.3
#> 577                17.1                    151                18.1
#> 578                17.9                    247                16.5
#> 579                18.2                    280                17.0
#> 580                18.1                    278                16.9
#> 581                17.4                    177                17.7
#> 582                17.5                    199                16.9
#> 583                18.3                    296                16.7
#> 584                18.2                    281                17.1
#> 585                17.8                    230                17.1
#> 586                17.3                    168                17.8
#> 587                18.3                    298                17.2
#> 588                17.4                    180                17.9
#> 589                17.4                    188                17.3
#> 590                17.0                    132                18.2
#> 591                17.6                    206                17.9
#> 592                18.4                    306                16.8
#> 593                17.4                    187                17.8
#> 594                17.0                    127                18.1
#> 595                18.2                    293                16.6
#> 596                17.5                    192                18.0
#> 597                17.2                    159                17.6
#> 598                17.9                    245                16.6
#> 599                17.3                    169                18.1
#> 600                17.8                    229                17.0
#> 601                17.4                    184                18.0
#> 602                17.6                    209                17.9
#> 603                17.9                    238                17.4
#> 604                18.0                    259                17.4
#> 605                18.1                    277                16.8
#> 606                18.2                    288                17.5
#> 607                17.7                    225                17.3
#> 608                17.8                    232                17.7
#> 609                17.5                    200                17.4
#> 610                18.4                    304                17.2
#> 611                17.3                    163                18.0
#> 612                17.5                    205                17.9
#> 613                18.0                    260                17.1
#> 614                17.9                    241                17.6
#> 615                18.0                    258                17.4
#> 616                17.6                    210                18.1
#> 617                18.1                    264                17.3
#> 618                17.6                    218                18.2
#> 619                17.7                    222                18.2
#> 620                17.2                    157                17.7
#> 621                18.9                    331                17.2
#> 622                18.2                    279                17.7
#> 623                17.7                    221                17.6
#> 624                17.7                    226                17.8
#> 625                18.2                    290                17.1
#> 626                17.9                    252                17.3
#> 627                18.4                    307                17.6
#> 628                18.7                    318                16.7
#> 629                17.9                    250                18.1
#> 630                18.1                    276                17.8
#> 631                18.1                    268                17.3
#> 632                18.1                    270                17.1
#> 633                18.2                    285                17.0
#> 634                18.2                    282                17.7
#> 635                18.0                    255                18.0
#> 636                17.9                    249                17.9
#> 637                18.1                    274                17.6
#> 638                18.2                    287                17.1
#> 639                17.4                    185                18.0
#> 640                18.4                    305                16.5
#> 641                18.9                    332                16.9
#> 642                18.8                    322                16.8
#> 643                18.5                    309                17.7
#> 644                18.7                    320                16.8
#> 645                18.6                    316                16.9
#> 646                18.2                    289                17.6
#> 647                17.6                    211                18.2
#> 648                18.2                    284                18.3
#> 649                18.1                    271                17.9
#> 650                18.0                    257                18.2
#> 651                18.8                    327                17.4
#> 652                18.1                    273                17.8
#> 653                17.7                    224                18.1
#> 654                17.6                    215                18.0
#> 655                18.2                    283                17.4
#> 656                18.4                    302                17.9
#> 657                18.4                    303                17.3
#> 658                18.3                    294                17.8
#> 659                18.6                    315                17.0
#> 660                18.4                    301                16.4
#> 661                18.1                    275                17.1
#> 662                18.2                    291                17.8
#> 663                18.3                    295                17.4
#> 664                18.5                    311                17.2
#> 665                18.3                    299                17.7
#> 666                18.0                    256                18.1
#> 667                17.6                    212                18.2
#> 668                17.9                    243                18.3
#> 669                18.7                    319                17.1
#> 670                18.0                    261                17.9
#> 671                18.8                    325                17.5
#> 672                19.1                    335                17.4
#> 673                18.9                    330                17.5
#> 674                19.3                    338                17.3
#> 675                18.6                    312                17.9
#> 676                17.9                    248                18.3
#> 677                19.0                    334                17.6
#> 678                18.8                    326                17.6
#> 679                19.2                    337                16.9
#> 680                19.3                    339                17.2
#> 681                18.5                    308                18.0
#> 682                18.6                    313                17.3
#> 683                17.9                    237                18.2
#> 684                18.8                    323                17.7
#> 685                18.8                    328                17.6
#> 686                18.1                    272                17.9
#> 687                18.9                    329                17.6
#> 688                18.4                    300                18.0
#> 689                17.5                    202                18.5
#> 690                18.6                    314                18.4
#> 691                18.8                    321                17.9
#> 692                18.7                    317                18.1
#> 693                19.2                    336                17.5
#> 694                19.6                    342                17.3
#> 695                18.8                    324                17.9
#> 696                19.9                    348                17.1
#> 697                19.5                    340                17.5
#> 698                19.7                    344                17.4
#> 699                19.9                    346                17.0
#> 700                19.7                    343                17.7
#> 701                19.8                    345                17.5
#> 702                19.5                    341                17.5
#> 703                20.2                    351                17.3
#> 704                20.1                    349                17.1
#> 705                18.5                    310                18.7
#> 706                20.1                    350                17.6
#> 707                19.0                    333                17.9
#> 708                19.9                    347                18.3
#> 709                20.6                    352                18.3
#> 710                20.8                    353                18.6
#>     avg_poss_length_def_rk adj_o adj_o_rk raw_o raw_o_rk adj_d adj_d_rk raw_d
#> 1                       13  91.0      334  91.6      324 102.6      183 100.2
#> 2                       17 101.0      197 104.5      100 101.5      160  97.3
#> 3                       64 103.9      139  96.3      272  98.9      113 105.1
#> 4                       62 104.0      136 104.0      110 109.1      305 110.5
#> 5                      271  99.0      237 100.4      187 105.1      229  98.3
#> 6                       10 103.2      160 107.0       58 104.7      223  98.4
#> 7                      299 126.4        1 121.9        1  89.9       11  93.4
#> 8                      137  97.6      256  96.8      260 104.7      224 104.3
#> 9                      207  93.4      310  98.8      215 103.7      205  98.0
#> 10                     166 111.2       42 105.3       89  98.9      112 102.2
#> 11                     277 112.9       30 106.8       63  87.8        3  93.7
#> 12                       2  90.9      335  90.3      332 115.4      355 113.2
#> 13                      22 107.9       86 101.9      155  99.2      118 103.3
#> 14                     314 105.0      124 108.8       36  96.5       71  92.5
#> 15                     220  91.3      330  91.6      325 107.0      274 105.6
#> 16                     142 107.4       95 108.4       42  96.1       67  97.6
#> 17                      35  96.5      276  95.2      285 106.0      257 105.1
#> 18                      15  92.5      321  93.9      303 111.4      331 108.5
#> 19                       8 111.1       43 108.0       47  89.6       10  94.2
#> 20                     285 109.2       67 108.7       38 100.3      133  98.8
#> 21                     128 108.4       75 101.4      167  98.5      106 105.5
#> 22                      25 100.9      199 104.9       94 113.4      347 107.0
#> 23                      16  97.3      260 101.3      172 108.1      290 102.9
#> 24                     160 109.6       60 103.0      135  90.7       17  97.8
#> 25                       1  90.1      342   0.0      348 112.7      343 200.0
#> 26                     104 110.3       53 116.8        4 101.0      148  95.0
#> 27                     273 109.5       62 109.4       32 101.3      156  99.3
#> 28                      33  96.2      279  98.2      228 105.5      243 104.2
#> 29                      46 100.2      215 100.0      193 111.3      330 110.9
#> 30                      39 101.2      194  95.7      276 105.1      230 109.9
#> 31                     100  89.6      345  92.2      317 100.8      140  94.4
#> 32                      11 100.0      218 103.3      127 105.7      247  97.3
#> 33                     248 107.7       91 110.7       21 102.7      185  99.1
#> 34                     225  97.3      262 102.4      149 108.0      288 105.9
#> 35                     214 101.8      179  93.7      304  94.1       40 102.1
#> 36                     180 103.5      151 104.9       93 104.2      210 100.5
#> 37                      56 106.5      105 103.5      123 105.9      252 104.7
#> 38                      95  95.5      285  89.8      334 112.3      338 114.6
#> 39                      40 101.6      188 104.2      105 109.6      313 108.9
#> 40                      27  87.2      351  84.3      343 112.4      339 108.2
#> 41                      44 105.4      120 103.2      130 100.0      128  98.2
#> 42                      52 100.4      209 103.0      138 103.7      204  98.7
#> 43                     262 110.3       52 104.7       98  91.7       27  97.7
#> 44                       3  98.0      252  98.8      216 109.4      308 109.2
#> 45                      29  99.8      221  99.5      206 104.2      212  95.8
#> 46                     103 109.3       66 108.0       46 104.4      219 105.8
#> 47                     258 108.3       79 103.3      128  99.3      120 102.4
#> 48                     123 105.5      117 100.4      186  86.4        1  87.5
#> 49                      53  90.2      340  92.2      318 104.9      227 101.6
#> 50                       1  79.4      357  77.5      347 120.7      357 118.3
#> 51                      32  99.3      231 103.1      134 100.2      130  96.7
#> 52                      91 108.3       80 113.0        8  96.6       73  93.0
#> 53                     208 104.0      135  95.3      282 100.4      134 108.8
#> 54                      26 111.6       38 104.1      107  98.4      103 102.9
#> 55                       5  97.1      267  91.8      323 111.8      334 116.9
#> 56                     189 100.3      211 102.0      151 104.2      214 101.0
#> 57                      42 101.3      193 101.5      165 102.3      179  99.4
#> 58                      36 105.1      123  98.7      218 103.6      200 109.9
#> 59                     188 111.5       39 111.3       19 104.6      222 103.6
#> 60                     140  94.2      304  95.6      278 112.6      341 110.7
#> 61                      19  97.6      258  95.1      286 113.8      351 112.3
#> 62                       4  96.7      273  97.7      243 110.9      327 109.0
#> 63                      80  84.4      355  88.8      338 110.3      319  98.7
#> 64                     223 109.4       64 113.0        9 102.0      170  96.2
#> 65                      86  94.6      300  93.2      310 107.0      275 108.1
#> 66                     114 103.6      148  97.0      257  97.5       90 101.6
#> 67                      49 103.4      154 102.7      143 101.9      167 103.7
#> 68                     121 100.7      202 103.1      133 113.1      345 108.3
#> 69                      90  93.5      309  95.4      281 104.4      218  99.1
#> 70                      78 120.1        5 112.6       11  99.8      124 103.3
#> 71                      73  91.5      329  94.6      291 104.3      216  94.9
#> 72                     301  97.6      257  91.3      327  94.8       47 100.5
#> 73                      20  95.6      284  94.3      297 106.7      268 101.8
#> 74                     222  99.1      235  98.4      225 107.0      273  99.3
#> 75                     274  94.7      297  96.8      262 105.2      232 102.4
#> 76                     226 104.3      131 106.6       65 110.6      321 107.1
#> 77                      60  99.9      220 100.0      195 106.9      272 107.8
#> 78                     294 105.7      115 106.6       67 104.8      226 102.1
#> 79                     132 118.0        8 111.5       18  88.9        7  95.5
#> 80                     228  94.9      289  98.5      223 110.6      322 105.0
#> 81                     254 100.4      208  95.9      274  98.5      105  98.8
#> 82                     131  97.3      264  96.6      264 109.1      304 107.5
#> 83                      94  92.5      320  95.3      283 112.0      336 107.4
#> 84                      14  97.4      259  91.0      331 100.7      137 105.7
#> 85                      61 100.5      207 101.1      175 104.3      215 103.6
#> 86                     264 101.7      186 100.1      191 110.4      320 109.7
#> 87                      48  91.6      326  95.0      288 109.0      303 106.8
#> 88                     110 108.4       76 101.0      179  95.4       56 102.6
#> 89                     105 107.8       88 107.0       59 106.7      269 106.9
#> 90                     305 114.9       16 109.7       28  92.8       33  98.1
#> 91                     115 100.3      213  93.0      313 100.4      135 108.5
#> 92                      96 108.5       74 111.7       15 105.4      240 102.3
#> 93                     233 123.5        3 117.7        3  96.7       75 102.4
#> 94                      99  92.1      324  93.3      309 106.3      264  96.2
#> 95                     199 108.8       72 104.7       95  99.9      125  99.8
#> 96                     141 105.5      116 106.1       76 101.9      168 103.2
#> 97                     150 101.8      180 103.9      112 106.9      271 105.1
#> 98                      54 105.8      113 106.9       61  99.5      121 101.7
#> 99                     245 101.7      182  97.8      240 108.0      289 110.0
#> 100                      1  95.2      288   0.0      348 102.9      189 200.0
#> 101                    119 107.9       87 101.2      173  95.0       49 101.6
#> 102                     34 103.5      152 107.0       60 102.2      174  97.3
#> 103                    339  91.8      325  91.4      326 102.8      187  98.0
#> 104                     43 103.9      140 102.8      142 109.2      306 111.4
#> 105                     72  89.4      347  89.5      337 108.8      300 104.6
#> 106                    173  89.8      344  91.0      329 108.3      292 105.7
#> 107                    300 105.2      122 101.5      163  90.2       14  92.1
#> 108                    266  97.3      263  99.4      207 104.2      211  98.8
#> 109                    270 100.3      214 103.9      111 111.2      329 109.6
#> 110                     41  98.2      247  99.7      197 112.2      337 116.8
#> 111                     31  91.1      333  93.4      307 110.2      317 105.7
#> 112                    153 104.2      133 102.5      147  93.7       39  93.0
#> 113                     51  87.8      350  89.6      335 105.4      238 105.4
#> 114                     68 103.9      141 101.4      169 106.2      261 104.8
#> 115                     71 101.7      184 104.2      106  91.6       26  87.0
#> 116                    109  93.1      314  94.3      296 100.3      132  96.1
#> 117                     67  91.2      332  88.6      339 103.9      207 102.6
#> 118                    163  98.2      246  98.4      227 106.1      260 102.0
#> 119                    101  98.0      253  98.1      230 102.3      181 100.2
#> 120                    253 106.0      110  98.4      226  92.2       28  98.6
#> 121                    102  94.6      299 101.0      181 101.2      152  91.0
#> 122                     74 116.8       12 108.6       40  96.3       70 100.9
#> 123                     47 111.4       40 110.5       22 100.9      145 102.2
#> 124                      1 100.2      216   0.0      348 105.3      236 200.0
#> 125                    310 112.2       34 103.1      132  95.2       52 103.5
#> 126                     75  97.2      265 100.7      183 109.8      314 108.3
#> 127                    243 107.8       90 106.2       74  98.5      104  98.9
#> 128                    240 109.1       69 107.5       54  96.0       64  96.1
#> 129                     79 109.1       68 108.1       45 109.0      301 107.3
#> 130                    265 102.1      173 104.9       92 109.5      309 105.1
#> 131                    200  99.8      223  99.1      211 106.1      259 102.4
#> 132                    333  98.7      240  96.8      259 102.3      180 105.2
#> 133                    204 108.1       83 105.8       83  96.6       72  95.7
#> 134                    149 104.7      127  99.6      204  97.5       89  99.3
#> 135                    249 101.7      183  97.7      242  97.0       80  98.0
#> 136                     93 107.3       97 107.9       50 106.6      267 104.8
#> 137                      1  94.7      298   0.0      348 105.9      255 200.0
#> 138                    116  95.5      286  97.4      248 108.7      298 105.3
#> 139                    236 103.3      155  98.7      219 103.0      190 105.0
#> 140                    108  98.6      241  99.0      214 103.5      197 101.5
#> 141                    241 110.8       47 105.2       90  96.8       76  96.6
#> 142                    129  96.0      281  94.5      292 109.9      316 109.0
#> 143                    144 114.3       19 114.1        6 102.6      182 102.0
#> 144                    324 113.4       25 108.4       43  92.8       32  97.5
#> 145                    169 102.9      163 107.3       55 112.0      335 105.9
#> 146                    318 113.1       28 105.9       81  92.8       31  97.3
#> 147                     12 108.9       71 103.0      137 100.6      136 103.7
#> 148                    259 101.5      189  96.4      268  98.8      110 100.7
#> 149                    229 104.8      126 103.6      120  89.5        8  89.7
#> 150                     24  92.9      318  94.1      299 110.8      325 107.1
#> 151                    302 113.7       24 107.8       51  96.9       77 101.2
#> 152                    165 114.5       18 109.6       29  97.0       79 101.8
#> 153                    209 108.6       73 108.6       41 101.5      159 103.0
#> 154                    122  94.7      296  97.5      245 108.0      287 104.4
#> 155                    154 101.8      181  96.8      261 105.6      245 106.2
#> 156                     18  95.7      283  99.7      200 114.5      353 109.3
#> 157                    176  98.1      250 100.6      184 101.6      161 101.2
#> 158                    167  95.5      287  97.5      247 105.5      242 101.4
#> 159                    145  88.1      349  91.8      322  97.7       92  87.9
#> 160                    315 104.3      132  98.0      235  93.4       37 101.7
#> 161                    130  90.2      341  92.9      316 100.9      144  96.6
#> 162                    127  96.8      272 101.3      171 101.8      165  99.5
#> 163                    120 110.6       49 103.2      129  95.5       57 101.4
#> 164                    216 107.1       98  99.9      196  94.2       45 102.9
#> 165                    190 108.2       81 104.0      109  99.5      122 103.0
#> 166                    112  94.8      293  95.6      277 109.5      312 107.4
#> 167                    206 111.0       44 104.7       97  94.1       41  99.4
#> 168                    272  99.4      230 101.1      176 103.6      198 102.3
#> 169                    276 110.9       46 106.6       68  98.1       99 100.8
#> 170                    136 100.6      204 102.9      140 107.8      283 102.5
#> 171                    282  94.2      303  95.6      279 106.2      263 101.4
#> 172                     45  92.6      319  93.9      302 107.4      279 106.8
#> 173                     77  92.4      322  91.0      330 105.0      228 102.8
#> 174                    312 110.1       54 103.9      113  90.2       12  96.5
#> 175                    181  93.1      315  96.3      271 104.5      221 102.8
#> 176                    278 101.1      195 100.4      188  98.4      102  98.8
#> 177                    269 101.9      174 103.2      131 103.1      192  99.7
#> 178                     30  97.1      268  96.6      266 108.5      296 114.7
#> 179                    303 105.9      112 105.8       82 108.4      295 105.4
#> 180                      1 101.9      177   0.0      348 103.2      194 200.0
#> 181                    147 108.0       84  99.7      198  93.1       35  99.4
#> 182                    221  94.8      291  95.1      287 107.3      278 106.9
#> 183                    215 103.6      146 103.6      119  95.8       62  95.5
#> 184                    292 110.4       50 109.3       33  96.0       65  95.2
#> 185                      1 107.1       99   0.0      348 102.1      172 200.0
#> 186                    246 110.6       48 106.4       73  97.9       94  99.8
#> 187                    213  99.3      232  94.6      289  98.6      107  98.6
#> 188                    138 101.6      187  97.9      238 107.8      285 104.6
#> 189                    157  99.0      238  98.6      220 105.1      231 102.0
#> 190                     88 102.1      172  97.1      255  99.1      116 104.0
#> 191                    263 103.3      156 100.0      194 100.2      131 100.4
#> 192                      1  83.9      356   0.0      348 111.5      333 200.0
#> 193                    325 109.4       63 106.5       71  97.4       87 102.1
#> 194                     70 100.3      212 101.3      170 106.8      270 105.2
#> 195                    125  91.6      327  89.9      333 103.5      196 105.2
#> 196                    113 106.2      108 106.6       69 102.8      186 102.9
#> 197                     82 106.9      100 102.8      141  98.0       96 100.1
#> 198                    335 115.6       15 109.6       31  95.7       59  99.8
#> 199                    117 100.2      217 102.0      153 101.0      146  94.6
#> 200                    212 109.8       57 111.1       20 101.1      151 100.5
#> 201                     92  99.2      233  99.7      201 107.0      276 102.5
#> 202                    196 102.2      171 106.1       78 109.5      310 108.6
#> 203                    252 112.7       31 105.4       88  97.0       78 102.3
#> 204                    293  93.7      307  95.5      280 105.5      241 101.8
#> 205                    232  99.5      229  98.0      234 113.7      350 107.3
#> 206                    111 113.7       23 108.7       39  92.5       30  97.3
#> 207                     65 102.4      167  97.5      246  91.3       24  96.0
#> 208                    319 100.6      203 101.5      164 100.8      139  94.7
#> 209                     37  84.8      354  88.2      341 105.8      250  94.4
#> 210                     59  93.1      316  93.7      305 105.9      254 102.3
#> 211                     23  99.1      234 101.8      159 103.6      199  98.3
#> 212                      6  88.3      348  78.0      346 118.1      356 123.8
#> 213                    231 125.0        2 119.1        2  91.1       22  94.5
#> 214                    290 108.1       82 101.0      180  90.6       16  98.8
#> 215                    124  96.5      277  97.3      251 106.2      262 104.0
#> 216                     69 107.5       94 101.6      162  97.1       83 102.2
#> 217                    203 101.0      196  99.1      213  99.9      126  99.2
#> 218                    178  92.9      317  91.9      321 101.1      149  99.4
#> 219                     89 106.6      102 104.1      108  98.0       97  97.7
#> 220                     87  92.3      323  92.9      314 113.3      346 112.1
#> 221                    316  99.8      225  94.4      295  97.8       93  98.3
#> 222                    133 101.3      192  99.7      202  93.4       38  93.2
#> 223                    235 113.7       22 107.9       49  96.2       68 100.8
#> 224                    261  98.1      249 101.5      166 110.6      323 112.7
#> 225                    197 106.5      103  98.5      221  97.9       95 101.5
#> 226                    280 117.2       10 110.1       24  95.4       55 101.0
#> 227                    317 113.8       21 108.0       48 103.7      203 110.4
#> 228                    182 112.1       35 106.1       79  95.1       51  99.7
#> 229                    164  97.7      254  98.0      236 108.1      291 108.1
#> 230                    156 109.3       65 112.3       13 108.8      299 107.9
#> 231                    295  93.2      313  94.2      298 105.4      239 101.2
#> 232                    201 108.0       85 104.4      101  88.1        5  92.2
#> 233                    313  89.5      346  91.1      328 103.7      202  96.5
#> 234                    279 109.5       61 103.4      125  97.2       84  99.9
#> 235                    331 115.7       14 109.0       35  88.1        6  94.9
#> 236                     76  98.5      242  97.9      239  98.6      108  99.3
#> 237                    135 103.5      150  97.9      237  98.1       98 101.3
#> 238                    296 103.5      153 103.7      117  95.0       50  90.1
#> 239                    334  96.6      275  93.4      308  99.5      123 101.7
#> 240                    250  98.4      243  99.2      210 105.3      235 101.1
#> 241                     57 101.3      191  97.3      250 101.9      169 107.7
#> 242                      9  91.2      331  88.4      340 114.7      354 109.7
#> 243                    148  97.0      271  98.0      233 100.0      127  95.7
#> 244                    327 102.6      166  99.7      199  97.3       85  99.5
#> 245                    309 101.7      185 102.0      154 103.9      208 102.2
#> 246                      1 101.3      190   0.0      348 106.5      266 200.0
#> 247                    159 100.8      200  94.6      290 101.0      147 104.4
#> 248                    244  90.1      343  87.6      342 105.9      253 105.6
#> 249                     98 104.0      137 105.5       87 109.0      302 103.3
#> 250                    247  90.6      338  89.5      336 113.6      349 112.1
#> 251                    168 120.7        4 112.9       10  97.1       82 104.1
#> 252                    329 104.5      130 106.6       66 105.6      246 102.1
#> 253                    187  90.4      339  92.9      315  95.8       61  90.2
#> 254                     84 103.6      147 103.8      115  95.6       58  94.1
#> 255                    198  94.1      305  95.2      284 104.2      213 101.1
#> 256                    321 117.6        9 111.6       17  87.9        4  95.8
#> 257                      1 104.0      138   0.0      348 103.9      209 200.0
#> 258                    118 104.7      128  98.1      231 101.9      166 104.9
#> 259                      1  94.8      292   0.0      348 105.5      244 200.0
#> 260                    152 101.9      176 100.8      182 114.2      352 111.0
#> 261                    336 103.3      157 103.8      116 108.4      294 103.9
#> 262                    107  97.0      269  99.3      208 103.1      193  99.4
#> 263                    281  90.7      336  96.6      265 102.1      173  97.2
#> 264                    306 110.3       51 103.5      121  95.9       63 101.2
#> 265                    342  96.7      274  98.1      232 100.9      142  98.9
#> 266                    155  96.0      282  97.3      252 105.8      249  99.4
#> 267                    286 105.5      118 108.4       44 102.2      177  94.0
#> 268                    257  94.7      295  95.8      275 101.3      157  97.7
#> 269                     85 103.0      161 103.3      126 102.3      178 101.6
#> 270                    162 107.3       96 101.7      160  96.6       74 101.8
#> 271                    326 112.5       33 112.2       14  98.2      101  97.9
#> 272                    217  98.2      248 101.1      177 113.5      348 108.7
#> 273                    237  99.8      224 102.0      152 101.8      163  95.0
#> 274                    291 100.0      219  97.1      254 102.8      188 103.8
#> 275                    323 103.3      158 106.7       64 103.5      195  98.6
#> 276                    340 116.3       13 109.9       27  91.2       23  96.4
#> 277                    134  96.1      280  98.5      222 107.3      277 103.2
#> 278                    267 113.3       26 106.0       80  92.9       34  99.5
#> 279                    268 100.6      206 102.9      139 100.7      138 102.7
#> 280                    202  91.6      328  94.0      301 101.3      155  94.4
#> 281                    179 103.7      143 101.2      174 104.4      217 104.4
#> 282                    297 100.9      198 101.8      157 107.7      282 103.8
#> 283                     38  94.7      294  93.2      311 105.2      233 107.7
#> 284                    106 107.8       89 102.6      146  99.0      114 100.0
#> 285                     50 102.3      169 103.0      136 110.6      324 109.9
#> 286                    126 103.7      145 105.0       91 103.7      201  98.4
#> 287                    158  93.3      311  93.5      306 109.5      311 104.5
#> 288                    347 103.5      149 101.1      178 101.7      162 102.5
#> 289                    227 109.1       70 100.3      189  94.2       43 100.5
#> 290                    260  97.2      266  97.1      256 112.5      340 107.5
#> 291                    211 106.4      106 106.4       72 102.0      171 103.5
#> 292                     81 104.9      125 106.1       77 104.5      220 101.3
#> 293                     66 106.0      111 105.6       84 105.3      234 105.7
#> 294                     97  99.0      236  99.3      209 111.4      332 111.1
#> 295                    311  99.6      227  97.6      244 102.2      176 103.2
#> 296                    143 107.7       93 101.7      161  95.3       54  98.2
#> 297                    151  90.6      337  94.5      293 106.1      258 102.1
#> 298                    307 109.7       59 106.6       70  95.3       53  98.1
#> 299                    170  98.8      239  98.7      217 101.2      154 101.5
#> 300                    330 107.7       92 102.4      148  94.2       44 100.1
#> 301                    288 109.9       56 109.2       34  96.2       69  94.4
#> 302                    174 100.3      210 102.6      144 109.3      307 109.2
#> 303                    308 102.6      165  96.8      263  97.5       91  98.8
#> 304                    218 100.8      201 104.7       96 106.5      265 100.5
#> 305                    205 108.3       77 102.6      145  98.6      109  99.6
#> 306                    234 112.1       36 104.3      104  95.7       60 103.3
#> 307                    345 111.0       45 109.6       30  91.1       21  92.9
#> 308                    172  99.6      226  93.0      312  98.1      100 105.1
#> 309                    194 113.1       27 107.6       53  92.5       29  97.2
#> 310                    275  98.4      245  99.5      205 103.1      191 100.6
#> 311                    230 103.2      159 101.9      156  99.2      117 100.0
#> 312                    256  93.3      312  91.9      320 111.2      328 113.6
#> 313                    284 102.4      168 103.6      118 110.3      318 109.8
#> 314                    146 100.6      205 100.5      185  97.4       88  95.8
#> 315                    332 108.3       78 110.3       23 108.3      293 104.3
#> 316                    287 112.7       32 107.2       56  90.9       18  93.6
#> 317                    195  98.0      251 100.1      192 105.4      237 102.2
#> 318                    139 106.1      109 101.8      158  91.4       25  94.1
#> 319                    191 105.4      121 107.2       57  97.1       81  94.6
#> 320                    304 110.0       55 107.6       52  91.0       20  93.6
#> 321                    337 111.8       37 103.8      114  94.1       42 100.6
#> 322                    177 105.5      119  98.2      229  99.0      115 105.8
#> 323                    298 103.8      142 106.2       75 108.0      286 106.0
#> 324                     63  93.6      308  96.5      267 112.7      342 107.3
#> 325                     58 104.1      134 105.6       86 102.7      184 100.3
#> 326                    175 102.7      164  96.1      273  97.4       86 104.0
#> 327                     55 103.7      144 104.3      103 100.9      143 100.8
#> 328                    186 113.0       29 105.6       85  90.6       15  97.6
#> 329                    255  99.8      222  99.1      212 107.5      280  99.5
#> 330                    183  85.9      353  81.7      344 105.9      251  98.5
#> 331                      7  97.0      270  96.9      258 105.9      256 103.2
#> 332                    161 118.3        7 114.7        5  89.6        9  90.0
#> 333                    184  94.9      290  94.0      300 107.8      284 101.5
#> 334                    341 101.9      175  97.2      253  98.9      111 101.4
#> 335                    219  93.7      306  94.5      294 102.2      175  98.2
#> 336                    238 119.0        6 113.7        7  96.0       66 101.2
#> 337                    343 106.4      107  99.6      203  90.9       19  95.3
#> 338                    251 102.9      162 104.6       99 107.6      281 102.7
#> 339                    171  98.4      244  96.4      270 112.7      344 113.5
#> 340                     83 106.5      104 106.9       62 105.8      248 102.4
#> 341                    289 116.9       11 108.8       37  94.5       46 101.6
#> 342                    346 111.3       41 109.9       26  87.0        2  88.5
#> 343                    328  86.3      352  80.6      345  99.3      119 103.2
#> 344                    210 104.6      129 103.5      124 101.4      158 100.0
#> 345                    322 102.2      170 103.5      122 108.6      297 106.4
#> 346                    193  97.7      255 100.2      190 104.8      225 100.4
#> 347                    242 109.8       58 112.6       12 101.2      153  96.5
#> 348                     21 101.8      178  97.8      241  90.2       13  95.1
#> 349                    224  94.4      302  92.1      319 110.9      326 112.6
#> 350                    239 106.7      101 104.4      102  95.0       48  95.2
#> 351                    320  97.3      261  96.4      269 103.8      206 101.3
#> 352                    283  96.2      278  97.3      249 100.2      129 100.8
#> 353                    338 113.9       20 110.0       25 101.8      164 101.7
#> 354                    192  99.6      228 101.4      168 100.8      141  95.6
#> 355                     28 105.8      114 102.3      150 109.9      315 109.9
#> 356                    185  94.5      301  98.4      224 101.1      150  97.2
#> 357                    344 114.7       17 111.7       16  93.3       36  98.8
#> 358                      1  89.8      345  86.7      349 117.6      349 112.7
#> 359                      5 102.9      175 102.5      140 122.3      352 120.0
#> 360                    111 101.2      199 100.1      193  99.1      106  97.8
#> 361                     18 111.0       37 106.0       71  99.5      114 102.2
#> 362                     10  94.1      323  94.7      310 117.2      347 109.6
#> 363                      2  95.4      297  95.7      287 104.9      230 101.7
#> 364                    302 105.8      109 105.4       79 110.5      319 107.9
#> 365                    171 104.1      151 103.3      123 102.3      175 101.0
#> 366                      4  92.3      335  93.3      323 102.4      177  96.6
#> 367                     19  94.9      305  94.2      317 112.2      328 111.7
#> 368                     40 102.0      187 100.8      175 106.4      264 105.4
#> 369                     71  89.6      346  90.5      342 105.3      240  99.2
#> 370                      9  97.5      262  93.2      324 107.8      289 110.5
#> 371                     41 106.0      108 100.1      191  94.7       49  96.1
#> 372                      3  98.0      256  96.4      273 107.6      285 107.1
#> 373                    241 102.0      190  94.3      316 101.3      152 105.5
#> 374                    265 105.4      122 100.8      176  94.7       50  95.4
#> 375                    187 105.4      120 105.0       88 101.1      142  99.7
#> 376                     82 105.6      115 104.1      107 101.4      156  99.9
#> 377                     48  95.4      298  96.6      267 105.8      254  98.3
#> 378                     59 106.1      104 100.4      183  95.2       53  96.9
#> 379                     30  99.1      237  96.7      264 108.6      304 102.2
#> 380                     57  97.4      265 100.0      195 106.1      259 103.1
#> 381                     32 104.2      149 101.2      168 108.0      293 106.1
#> 382                     45  98.6      245  97.5      244 112.6      332 113.2
#> 383                     16 104.8      134 103.6      112 106.2      261 104.5
#> 384                    229  99.1      238  98.5      222 101.8      162  97.3
#> 385                    140 100.6      210  97.4      250  89.1        5  88.5
#> 386                      7  98.3      251 100.1      192 107.1      278 104.1
#> 387                    224 103.7      157 102.1      149 102.1      170  99.8
#> 388                    113 104.9      132 107.9       39 101.4      157  96.2
#> 389                    231  99.5      230  99.1      210 111.6      323 108.5
#> 390                     53  92.0      338  92.2      332 109.6      312 106.3
#> 391                     42 115.7        9 111.9        6  91.1       12  91.4
#> 392                    266 121.3        1 120.1        1  94.4       43  93.3
#> 393                    306 104.7      136 108.9       26 102.1      169  98.3
#> 394                     33 101.3      196  99.5      199 106.2      262 105.2
#> 395                     58 105.3      125 104.9       91 102.4      178 103.8
#> 396                      6 104.1      152 106.3       65  97.1       75  91.8
#> 397                     85 108.8       57 107.9       40 108.8      306 106.6
#> 398                    132 102.2      184 101.3      162  98.8      102  98.0
#> 399                    202 102.6      176 101.6      157 101.3      154  99.7
#> 400                     21 107.3       83 106.6       60 106.3      263 104.9
#> 401                     13  98.3      250  99.0      212 115.0      343 114.7
#> 402                    103 109.1       55 104.7       95  95.5       57  96.2
#> 403                    166 105.2      126 101.2      167  94.2       39  95.0
#> 404                    129 101.9      193  96.5      270 110.2      315 111.3
#> 405                     77  99.5      229 101.6      158 103.7      200  99.8
#> 406                     81 100.9      204 100.0      196 102.1      171  96.6
#> 407                    174 110.3       44 107.1       52 101.0      141 100.8
#> 408                    151  98.7      243 103.8      110 110.3      318 106.7
#> 409                     44 100.4      213 102.2      145 109.1      309 105.4
#> 410                     87  95.0      303  95.3      297 106.8      274 106.6
#> 411                    183 110.3       43 105.0       86  92.4       23  95.8
#> 412                    146  94.2      320  92.2      333 105.3      238 105.6
#> 413                    133 104.8      135 105.6       75 116.7      345 114.3
#> 414                    252 107.2       85 104.3      104 104.4      217 105.4
#> 415                    147  99.4      231  97.7      239 115.6      344 114.0
#> 416                     98 102.2      182  97.5      243  98.0       83  97.4
#> 417                    185 114.0       14 107.2       51  96.9       73  99.0
#> 418                     66  96.3      282  96.2      278 100.5      131  93.3
#> 419                    219  99.6      227  95.6      292 104.0      213 101.9
#> 420                    271 103.4      165  97.3      251  95.5       56  99.2
#> 421                     76 108.2       71 103.5      117 100.8      136 103.4
#> 422                    175 106.5       97 109.0       25 100.5      132  94.3
#> 423                    294  98.7      244  98.7      218 106.0      256 103.4
#> 424                    181 107.7       77 100.9      173  98.4       94 102.1
#> 425                    143 108.2       70 109.8       18 104.9      231 105.0
#> 426                    139  96.5      277  96.8      261 104.2      215 101.5
#> 427                     49  94.6      308  96.0      281 106.5      266 101.7
#> 428                     67  97.8      257  99.0      213 103.8      206  98.7
#> 429                    179 104.4      144 103.5      119 113.6      337 107.4
#> 430                    284 100.1      217  95.2      299  94.6       47  95.1
#> 431                     70 107.4       82 105.5       78 113.3      336 112.6
#> 432                      8  93.6      326  94.5      313 119.7      350 113.9
#> 433                     92 103.4      163 101.7      154 100.8      137  99.7
#> 434                    233 117.3        5 110.3       14  98.6       97 102.4
#> 435                    128  94.4      315  90.6      340  99.8      117 101.8
#> 436                    123 108.7       61 101.9      152 102.0      166 104.0
#> 437                     52 105.8      110 102.9      131 108.4      301 106.0
#> 438                     93 104.3      146 102.8      133 104.0      210 102.3
#> 439                     22  96.9      271  95.8      285 111.3      322 103.0
#> 440                    207  96.0      289  96.3      276 105.6      248 100.8
#> 441                    101 118.1        4 112.8        4 102.4      179 102.6
#> 442                     97 108.6       63 109.4       21 108.9      307 106.3
#> 443                    108  97.7      259  97.5      245 105.7      249 100.8
#> 444                    232 111.0       36 104.5      100 100.2      125 103.6
#> 445                     94 103.1      171  96.0      282  91.8       16  94.2
#> 446                    293 111.7       32 107.1       53  91.5       15  93.6
#> 447                    220 109.6       48 101.4      160 101.2      147 103.5
#> 448                     95 101.2      200 101.0      169 105.5      247 101.3
#> 449                    245  97.7      260  97.4      249  99.4      111  94.5
#> 450                     90 112.3       29 105.4       80  92.7       25  96.1
#> 451                    100  99.3      233  98.8      216 114.8      342 111.8
#> 452                    194  97.5      264  95.0      305 108.2      298 107.8
#> 453                    327 105.8      112  99.9      197  93.1       31  93.9
#> 454                    127  86.2      350  86.7      348 103.4      198 100.7
#> 455                    329 108.8       58 100.7      179  93.1       29  96.8
#> 456                     74  96.3      283  98.3      228 102.5      180  99.3
#> 457                     51  93.2      327  95.6      291 107.5      282 100.8
#> 458                     35 105.6      117 100.7      177  90.4        8  89.7
#> 459                    186  96.0      288  97.7      237 104.9      232 102.4
#> 460                    172 110.7       42 105.2       82  97.3       79  98.5
#> 461                     89  90.3      342  88.5      346 114.0      340 110.6
#> 462                     46  96.4      280  97.0      258  99.5      115  96.8
#> 463                    345  98.8      242 100.7      178 107.4      281 104.0
#> 464                    286  96.2      285  96.9      260 102.9      189 101.6
#> 465                    184 116.3        7 112.1        5  95.6       60  97.0
#> 466                     11 104.7      139 101.4      161 104.5      221 106.3
#> 467                    253 108.5       66 106.8       58  98.9      103  95.6
#> 468                    307 112.0       31 111.2        8 111.6      324 107.1
#> 469                    130 108.3       67 100.9      172  87.1        3  89.5
#> 470                     78  96.4      278  95.0      303 101.1      143  99.3
#> 471                    326  95.9      292  94.4      314 104.5      218 102.0
#> 472                    288 111.0       35 107.6       49  91.4       14  92.4
#> 473                    213 109.3       52 106.1       69 102.1      172 102.4
#> 474                     14  99.9      221  99.1      209 111.7      326 110.1
#> 475                    243  98.8      240  98.9      215  98.1       86  95.5
#> 476                    136  96.2      284  94.6      312 106.6      268 105.4
#> 477                    155  99.6      228  92.5      329 100.3      128 101.4
#> 478                     65  96.4      279  98.5      223 104.6      222 100.3
#> 479                    154  94.4      314  92.7      328 104.3      216 104.5
#> 480                    297 104.5      141 101.9      151 102.5      181 101.6
#> 481                    221 109.2       53 107.8       43  95.3       54  95.2
#> 482                     31 106.4       99 104.2      106 102.5      184  99.8
#> 483                    125 103.2      170 102.5      139 107.7      286 108.2
#> 484                    205 111.4       33 108.3       33  95.5       55  97.7
#> 485                     43  95.5      295  97.2      255 110.8      320 108.5
#> 486                     37  98.2      253 102.0      150 104.5      220  98.9
#> 487                    316 115.2       10 109.3       22  91.2       13  93.8
#> 488                    110  99.6      226  96.5      271 100.4      129  99.1
#> 489                    282  95.2      302  93.5      321 106.5      267 104.3
#> 490                    206 107.0       88 104.5       99  97.6       81  99.1
#> 491                    349 104.7      138 101.7      155  94.4       45  93.8
#> 492                     39  86.9      349  83.8      350 120.8      351 120.5
#> 493                     54  92.3      336  94.3      315 110.0      314 106.8
#> 494                     24 103.0      172 104.9       90 112.3      330 108.3
#> 495                    309 107.6       81 109.1       24 107.9      290 102.9
#> 496                    203 104.3      145  99.3      206  92.0       18  93.0
#> 497                    180  92.8      332  91.4      337 107.1      277 106.1
#> 498                    260 100.7      207 101.3      163 108.3      300 102.8
#> 499                    269 102.1      186 102.2      147 112.4      331 108.3
#> 500                    153 106.1      105 106.0       70 102.1      167 100.0
#> 501                    201 102.4      178 105.6       77  99.3      110  94.1
#> 502                     12 102.2      183 101.7      156 107.7      287 108.6
#> 503                    332  99.7      225  98.4      225 101.3      151  99.0
#> 504                    148 107.8       76 104.9       89 110.3      316 110.0
#> 505                    278 104.7      137 103.8      111  99.0      105  97.0
#> 506                     17 105.1      128 105.8       74 122.9      353 119.9
#> 507                    188 113.2       20 106.8       57  93.0       28  97.6
#> 508                    161  93.1      328  94.7      311 105.1      235  98.6
#> 509                     34 102.2      185 104.3      102 104.8      227 100.5
#> 510                    273 101.2      201 100.2      189 108.0      292 104.1
#> 511                    236 101.9      192  97.7      236 103.1      191 101.8
#> 512                    211 108.3       68 106.1       68  98.2       88  99.3
#> 513                    280 101.6      194 101.0      171 106.1      260 101.5
#> 514                     64  92.8      333  93.4      322 102.3      176  96.6
#> 515                     26  99.7      223 101.2      166 101.5      158  97.8
#> 516                     84 101.1      202 103.5      120 104.0      212 100.2
#> 517                     38  94.4      311  93.1      325 107.3      279 101.4
#> 518                     28 102.9      174  98.2      229 102.5      185 102.0
#> 519                    208 105.3      124 108.3       34 108.1      295 101.9
#> 520                     15  95.0      304  95.7      289 102.1      168  97.8
#> 521                    124  99.7      224  97.6      240 116.9      346 112.9
#> 522                    325  92.1      337  92.4      330 104.5      219 104.7
#> 523                    137  94.3      316  94.8      308 103.9      208  99.1
#> 524                    156 108.6       64 102.9      132  95.6       59  94.1
#> 525                    246 107.2       86 109.9       17 102.5      182  99.6
#> 526                    353  98.4      248  96.2      277 102.9      190 103.1
#> 527                    141  97.6      261  99.4      205 101.0      140  98.3
#> 528                    114 107.8       75 102.2      146  92.8       27  94.9
#> 529                    152  99.1      239 101.5      159 100.2      126  96.1
#> 530                    209 107.2       84  98.7      219  94.5       46  96.7
#> 531                    142  97.0      269  97.0      257 108.8      305 107.4
#> 532                    164  95.2      301  93.6      320 108.5      302 107.8
#> 533                    126 108.9       56 106.3       63 103.3      196 101.7
#> 534                     75  95.9      291  95.2      300 117.3      348 115.0
#> 535                    272 118.2        3 111.1       10  97.3       78 100.6
#> 536                    333 112.8       21 107.9       42  99.6      116 100.4
#> 537                     50 107.7       79 101.0      170 101.3      149 104.0
#> 538                    160 104.8      133 102.5      138 100.2      124  98.8
#> 539                    234 105.6      116 107.1       54 106.4      265 103.7
#> 540                    196 104.4      143 100.5      182  90.3        7  90.5
#> 541                     55  94.4      312  95.7      288 101.1      144  97.0
#> 542                    204 103.2      169 101.3      165 100.1      123  97.9
#> 543                     61  83.5      351  81.2      352 112.2      329 110.8
#> 544                    197 107.7       78 108.2       35  98.1       85  96.4
#> 545                    250 109.1       54 103.4      122  93.4       32  93.9
#> 546                     23  95.8      293  98.5      224 105.5      245 101.2
#> 547                    287 110.7       41 106.9       56  98.6      100  98.9
#> 548                    115 106.1      103 100.3      186  92.2       20  96.2
#> 549                     86 100.1      216 100.3      187 102.7      188 101.0
#> 550                    106 106.3      102 105.9       73 105.1      237 102.3
#> 551                    310 104.7      140 103.1      128 109.4      311 106.2
#> 552                     62 103.6      161 102.2      148 103.3      195 101.7
#> 553                    159 103.7      158  99.5      201  97.0       74  98.8
#> 554                    121  95.4      300  96.5      272  97.3       80  93.0
#> 555                    267 103.4      164 103.3      124 112.1      327 106.8
#> 556                    258 108.8       59 102.3      142  94.7       51  94.4
#> 557                     80  99.2      235 100.2      190  94.0       37  91.5
#> 558                    157 110.0       46 110.8       11 105.3      241 101.2
#> 559                    342 108.7       62 110.2       15 102.6      187 100.0
#> 560                    281 100.2      215 100.5      181 108.1      296 106.6
#> 561                    248 102.0      189 100.4      185 101.3      155 100.6
#> 562                    264  95.4      299  97.7      238 103.8      204 104.6
#> 563                    218 108.5       65 103.2      126  92.7       26  97.3
#> 564                    313  91.3      339  95.5      295 105.1      234 100.0
#> 565                    119 103.5      162  99.4      204  98.6       98  98.0
#> 566                     83 106.9       90 108.4       31 107.0      275 103.7
#> 567                    300 103.7      160 103.4      121  95.5       58  92.9
#> 568                    290 106.6       94 104.7       94  99.0      104  97.0
#> 569                    168 105.4      121 104.8       93  99.3      109  96.2
#> 570                     99  87.9      348  88.2      347 108.2      297 101.9
#> 571                    235 102.3      180 100.4      184  98.4       95  99.2
#> 572                    251 112.7       24 108.0       37  95.1       52  96.2
#> 573                    215  98.8      241  95.5      294 107.9      291 107.2
#> 574                    105  96.9      274  95.0      302 107.4      280 106.8
#> 575                    249  94.0      324  95.3      296 113.0      334 109.2
#> 576                    182 105.8      111 103.1      129  94.4       44  93.9
#> 577                    323 119.1        2 116.4        2  94.1       38  93.7
#> 578                     25  81.7      352  81.2      351 107.8      288 103.8
#> 579                    102 103.3      167 104.3      103 105.5      244 103.7
#> 580                     73  97.3      266  97.2      254 113.9      339 109.6
#> 581                    261  96.9      273  95.6      290  98.2       89  96.1
#> 582                     72  94.2      321  96.8      263 101.9      164  95.0
#> 583                     47  94.9      306  96.6      269 113.2      335 106.8
#> 584                    138 107.9       73 106.2       67  96.4       67  94.3
#> 585                    120  99.4      232  97.4      248 105.7      251 105.0
#> 586                    275 109.5       49 108.0       38  94.6       48  94.1
#> 587                    150 100.8      206  99.5      202 111.1      321 109.9
#> 588                    291 107.9       72 101.9      153  90.2        6  92.9
#> 589                    167  94.6      309  96.3      275 108.1      294 102.8
#> 590                    338 115.8        8 108.6       28  85.5        2  89.3
#> 591                    295  97.0      270  96.6      268 101.6      159 100.1
#> 592                     63 100.0      219  99.7      198 106.7      271 104.6
#> 593                    274 109.8       47 103.8      109  90.5        9  91.7
#> 594                    322 104.2      148 102.5      137 107.5      284 105.8
#> 595                     36  94.4      313  92.3      331 103.8      207 105.6
#> 596                    319 102.5      177  95.0      304  94.2       40  96.3
#> 597                    239  99.9      220  98.2      230 100.2      127  99.2
#> 598                     29  92.9      329  91.9      335 105.7      250 104.2
#> 599                    331 114.5       12 109.7       20  93.1       30  94.0
#> 600                     96 102.0      188 100.3      188 107.0      276 105.6
#> 601                    312 106.8       92 105.0       85 100.7      134  97.8
#> 602                    289 113.5       18 106.3       64  92.4       22  95.7
#> 603                    189 101.3      197  99.0      214 101.3      153 100.2
#> 604                    191 107.9       74 104.3      101 100.6      133 101.8
#> 605                     68 106.6       93 105.4       81 104.8      225 102.5
#> 606                    222  94.7      307  94.8      309 105.8      255 102.6
#> 607                    170  95.4      296  97.3      253 109.1      308 105.9
#> 608                    254 100.6      211 102.7      135 105.5      246 102.7
#> 609                    193  92.5      334  92.9      327 109.3      310 105.9
#> 610                    158  96.9      272  97.9      232 114.4      341 110.3
#> 611                    314  94.2      318  91.6      336  96.6       70  96.9
#> 612                    303  97.8      258  96.8      262 105.7      252 101.9
#> 613                    131  97.2      267  97.5      246 104.8      224  97.8
#> 614                    227 112.1       30 104.6       96  94.2       41  98.1
#> 615                    190  94.1      322  90.7      339 100.9      139 102.9
#> 616                    321 104.9      131  96.7      265 101.3      150 104.5
#> 617                    163 106.3      100 102.3      143 100.8      135 103.2
#> 618                    336 107.2       87 106.5       61 105.1      236  99.4
#> 619                    335  96.0      290  96.4      274 102.5      183  97.9
#> 620                    259  94.2      319  95.9      284 103.2      193  97.7
#> 621                    149  99.2      236  96.0      280 105.8      253 103.7
#> 622                    256 102.3      179 102.2      144 106.7      269 105.6
#> 623                    226 108.7       60 107.7       47  98.2       90  94.7
#> 624                    270 104.1      150  99.5      203  96.7       71  96.7
#> 625                    117  98.3      249  96.2      279  98.3       92  96.3
#> 626                    169 103.0      173 103.5      118 108.5      303 104.4
#> 627                    228 105.8      113 103.3      125 101.2      145 100.9
#> 628                     56  94.5      310  95.5      293 113.6      338 111.4
#> 629                    324 103.3      166 104.6       97 102.6      186  99.6
#> 630                    279 106.5       98 106.5       62  96.4       68  90.1
#> 631                    165 107.0       89 105.2       83 105.5      243 103.8
#> 632                    122 113.9       15 107.8       44  94.0       36  98.3
#> 633                    109 113.4       19 109.2       23  99.8      119 101.1
#> 634                    262 113.5       17 106.3       66  88.1        4  90.1
#> 635                    315 100.6      208 100.0      194 110.0      313 108.3
#> 636                    296 102.2      181 104.6       98 106.7      270 103.9
#> 637                    230 114.3       13 108.1       36  92.0       19  94.5
#> 638                    118 108.2       69 109.7       19  96.0       65  95.9
#> 639                    318 100.5      212 102.8      134 103.8      205 100.2
#> 640                     27  90.3      341  92.0      334 112.8      333 109.0
#> 641                     79  79.0      353  78.2      353 104.6      223 100.8
#> 642                     60  98.6      246  98.4      226 105.0      233 102.3
#> 643                    257  91.2      340  90.8      338 103.3      194  99.7
#> 644                     69 106.8       91 108.4       30 101.2      148  99.3
#> 645                     88 110.9       38 105.1       84  93.7       35  97.2
#> 646                    244 100.1      218  97.8      235 111.6      325 107.9
#> 647                    340 103.9      155  98.6      220  93.5       33  95.2
#> 648                    344 105.4      123 107.7       45 103.2      192 100.7
#> 649                    305 104.1      153  97.0      259  92.6       24  95.6
#> 650                    334 104.5      142 104.3      105 103.4      197 102.4
#> 651                    199  92.9      330  90.3      343 106.8      273 103.1
#> 652                    276 105.0      129 105.0       87 104.9      229 103.3
#> 653                    328  92.8      331  93.1      326 101.6      160  96.4
#> 654                    308 103.2      168  99.5      200  93.6       34  92.8
#> 655                    200  96.7      276  95.3      298  99.9      121  96.7
#> 656                    292 112.7       23 110.7       12  99.3      108  97.9
#> 657                    178 112.7       22 107.7       48  92.3       21  92.7
#> 658                    277 106.6       95 103.6      115 102.2      174 100.8
#> 659                    107 100.8      205  99.3      207 102.1      173  98.5
#> 660                     20  94.3      317  96.0      283 106.0      257 101.9
#> 661                    116 102.0      191 103.6      116  99.8      120  96.3
#> 662                    268 110.9       39 106.7       59 102.0      165 101.8
#> 663                    195  96.8      275 100.5      180 105.3      239 100.7
#> 664                    144  98.5      247  98.1      231  98.0       84  95.8
#> 665                    263 104.0      154  98.3      227  98.3       91  99.1
#> 666                    320 104.3      147 101.3      164  98.0       82  98.4
#> 667                    337 104.9      130 104.0      108 103.9      209 102.4
#> 668                    343 103.7      159 102.6      136  96.8       72  94.8
#> 669                    135 106.3      101 104.8       92  98.3       93  96.4
#> 670                    285 106.6       96 100.8      174  95.8       62  96.8
#> 671                    212 101.2      198  98.8      217 110.3      317 108.8
#> 672                    192 101.5      195  95.1      301 100.4      130 103.9
#> 673                    216  90.2      343  90.6      341 103.8      203  98.2
#> 674                    162 105.7      114 105.6       76 104.8      226 103.2
#> 675                    304 105.5      119  97.5      242  96.1       66  98.2
#> 676                    341 117.1        6 111.9        7  97.1       76  98.3
#> 677                    225 110.2       45 110.3       13 100.1      122  97.0
#> 678                    240  96.2      286  97.6      241 104.9      228 103.4
#> 679                     91  96.1      287  93.7      318 103.7      201 103.2
#> 680                    145 103.8      156 102.4      141  99.1      107  97.1
#> 681                    317 100.2      214  95.0      306  95.9       63  95.0
#> 682                    177 109.3       51 103.6      114  99.4      112 101.1
#> 683                    339 112.5       27 107.3       50  95.7       61  99.0
#> 684                    247  97.5      263  98.5      221 103.6      199 101.9
#> 685                    238  89.1      347  88.6      345  95.9       64  93.7
#> 686                    301  99.8      222  99.1      211 100.8      138  98.1
#> 687                    242 112.5       26 108.6       27 101.9      163 100.3
#> 688                    311 112.4       28 108.3       32 103.8      202 101.7
#> 689                    350 115.1       11 112.8        3  90.6       10  91.0
#> 690                    348 109.3       50 102.9      130  90.8       11  94.3
#> 691                    299 101.0      203  95.8      286  97.2       77  99.0
#> 692                    330 106.1      106 107.0       55 105.3      242 101.6
#> 693                    210 105.6      118 108.5       29 106.8      272 103.9
#> 694                    176  98.2      252  96.6      266  98.6       99  97.3
#> 695                    283 105.1      127 103.2      127 104.1      214 105.1
#> 696                    134 113.7       16 111.2        9  98.5       96 100.3
#> 697                    214  97.1      268  97.1      256  98.2       87  95.8
#> 698                    198 112.6       25 105.9       72  94.2       42  95.9
#> 699                    104 110.8       40 103.6      113  91.9       17  96.3
#> 700                    255 107.6       80 107.9       41  99.4      113  94.6
#> 701                    223  98.1      255  97.9      233 108.3      299 104.5
#> 702                    217  96.4      281  97.9      234 107.5      283 102.9
#> 703                    173  90.1      344  90.2      344 101.6      161  97.7
#> 704                    112  95.8      294  97.3      252  99.8      118  96.6
#> 705                    352  93.9      325  94.9      307  98.8      101  95.0
#> 706                    237 100.6      209  97.4      247 104.0      211 105.2
#> 707                    298 111.2       34 107.7       46 101.2      146  99.3
#> 708                    347  98.1      254  99.2      208 106.0      258 101.9
#> 709                    346 106.1      107 109.9       16  96.4       69  89.8
#> 710                    351  99.3      234  93.6      319  85.1        1  85.9
#>     raw_d_rk ncaa_seed year
#> 1        135        NA 2021
#> 2         67        NA 2021
#> 3        260        NA 2021
#> 4        328        NA 2021
#> 5         85        NA 2021
#> 6         89        NA 2021
#> 7         17         1 2021
#> 8        245        NA 2021
#> 9         78        NA 2021
#> 10       196        NA 2021
#> 11        20         2 2021
#> 12       339        NA 2021
#> 13       228        NA 2021
#> 14        12        12 2021
#> 15       271        NA 2021
#> 16        70        NA 2021
#> 17       259        NA 2021
#> 18       307        NA 2021
#> 19        24         3 2021
#> 20        99        NA 2021
#> 21       270        NA 2021
#> 22       288        NA 2021
#> 23       219        NA 2021
#> 24        75         4 2021
#> 25       348        NA 2021
#> 26        35        14 2021
#> 27       111        14 2021
#> 28       244        NA 2021
#> 29       330        NA 2021
#> 30       322        NA 2021
#> 31        27        NA 2021
#> 32        68        NA 2021
#> 33       106        NA 2021
#> 34       280        NA 2021
#> 35       190        NA 2021
#> 36       139        NA 2021
#> 37       253        NA 2021
#> 38       342        NA 2021
#> 39       312        NA 2021
#> 40       304        NA 2021
#> 41        83        NA 2021
#> 42        95        NA 2021
#> 43        73         8 2021
#> 44       315        NA 2021
#> 45        46        16 2021
#> 46       277        15 2021
#> 47       202        NA 2021
#> 48         2        NA 2021
#> 49       173        NA 2021
#> 50       346        NA 2021
#> 51        60        NA 2021
#> 52        15        NA 2021
#> 53       311        NA 2021
#> 54       217        NA 2021
#> 55       345        NA 2021
#> 56       153        NA 2021
#> 57       112        NA 2021
#> 58       323        NA 2021
#> 59       234        NA 2021
#> 60       329        NA 2021
#> 61       336        NA 2021
#> 62       313        NA 2021
#> 63        94        NA 2021
#> 64        52        NA 2021
#> 65       302        NA 2021
#> 66       176        NA 2021
#> 67       235        NA 2021
#> 68       305        NA 2021
#> 69       105        NA 2021
#> 70       227         8 2021
#> 71        33        NA 2021
#> 72       143        NA 2021
#> 73       181        NA 2021
#> 74       110        NA 2021
#> 75       203        NA 2021
#> 76       289        NA 2021
#> 77       300        NA 2021
#> 78       188        NA 2021
#> 79        41         1 2021
#> 80       257        NA 2021
#> 81        96        NA 2021
#> 82       296        NA 2021
#> 83       294        NA 2021
#> 84       274        NA 2021
#> 85       233        NA 2021
#> 86       319        NA 2021
#> 87       285        NA 2021
#> 88       211        NA 2021
#> 89       286        NA 2021
#> 90        80         4 2021
#> 91       308        NA 2021
#> 92       199        NA 2021
#> 93       205         2 2021
#> 94        53        NA 2021
#> 95       125        NA 2021
#> 96       222        NA 2021
#> 97       263        NA 2021
#> 98       178        NA 2021
#> 99       326        NA 2021
#> 100      348        NA 2021
#> 101      174        12 2021
#> 102       65        NA 2021
#> 103       77        NA 2021
#> 104      333        NA 2021
#> 105      251        NA 2021
#> 106      273        NA 2021
#> 107       10        10 2021
#> 108       97        NA 2021
#> 109      318        NA 2021
#> 110      344        NA 2021
#> 111      276        NA 2021
#> 112       14        NA 2021
#> 113      268        NA 2021
#> 114      254        NA 2021
#> 115        1        14 2021
#> 116       50        NA 2021
#> 117      210        NA 2021
#> 118      186        NA 2021
#> 119      134        NA 2021
#> 120       93        NA 2021
#> 121        9        NA 2021
#> 122      151         3 2021
#> 123      193        13 2021
#> 124      348        NA 2021
#> 125      232        NA 2021
#> 126      306        NA 2021
#> 127      103        NA 2021
#> 128       51        NA 2021
#> 129      293        NA 2021
#> 130      261        NA 2021
#> 131      204        NA 2021
#> 132      266        NA 2021
#> 133       45        NA 2021
#> 134      108        NA 2021
#> 135       79        NA 2021
#> 136      255        NA 2021
#> 137      348        NA 2021
#> 138      267        NA 2021
#> 139      258        NA 2021
#> 140      170        NA 2021
#> 141       59        NA 2021
#> 142      314        NA 2021
#> 143      187        NA 2021
#> 144       69         5 2021
#> 145      279        NA 2021
#> 146       64         3 2021
#> 147      236        NA 2021
#> 148      146        NA 2021
#> 149        5        11 2021
#> 150      290        NA 2021
#> 151      156        11 2021
#> 152      184        NA 2021
#> 153      221        NA 2021
#> 154      248        NA 2021
#> 155      282        NA 2021
#> 156      317        NA 2021
#> 157      157        NA 2021
#> 158      164        NA 2021
#> 159        3        NA 2021
#> 160      179        NA 2021
#> 161       58        NA 2021
#> 162      119        NA 2021
#> 163      165         9 2021
#> 164      218        11 2021
#> 165      220        NA 2021
#> 166      295        NA 2021
#> 167      114         7 2021
#> 168      201        NA 2021
#> 169      150        NA 2021
#> 170      207        NA 2021
#> 171      166        NA 2021
#> 172      284        NA 2021
#> 173      215        NA 2021
#> 174       55         3 2021
#> 175      214        NA 2021
#> 176      102        NA 2021
#> 177      123        NA 2021
#> 178      343        NA 2021
#> 179      269        NA 2021
#> 180      348        NA 2021
#> 181      113        NA 2021
#> 182      287        NA 2021
#> 183       42        13 2021
#> 184       38        NA 2021
#> 185      348        NA 2021
#> 186      127        NA 2021
#> 187       91        NA 2021
#> 188      252        NA 2021
#> 189      185        NA 2021
#> 190      241        NA 2021
#> 191      138        NA 2021
#> 192      348        NA 2021
#> 193      192        NA 2021
#> 194      265        NA 2021
#> 195      264        NA 2021
#> 196      216        NA 2021
#> 197      132        NA 2021
#> 198      126        NA 2021
#> 199       31        15 2021
#> 200      140        NA 2021
#> 201      209        NA 2021
#> 202      309        NA 2021
#> 203      198        NA 2021
#> 204      183        NA 2021
#> 205      292        NA 2021
#> 206       66         6 2021
#> 207       49        NA 2021
#> 208       32        NA 2021
#> 209       26        NA 2021
#> 210      200        NA 2021
#> 211       86        16 2021
#> 212      347        NA 2021
#> 213       29         1 2021
#> 214      100        10 2021
#> 215      242        NA 2021
#> 216      197        NA 2021
#> 217      107        NA 2021
#> 218      116        NA 2021
#> 219       74        NA 2021
#> 220      334        NA 2021
#> 221       87        NA 2021
#> 222       16        NA 2021
#> 223      148         9 2021
#> 224      338        NA 2021
#> 225      168        NA 2021
#> 226      152         7 2021
#> 227      327        NA 2021
#> 228      124         8 2021
#> 229      303        NA 2021
#> 230      301        NA 2021
#> 231      160        NA 2021
#> 232       11         5 2021
#> 233       56        NA 2021
#> 234      128        11 2021
#> 235       34         6 2021
#> 236      109        NA 2021
#> 237      162        NA 2021
#> 238        7        NA 2021
#> 239      180        NA 2021
#> 240      154        NA 2021
#> 241      298        NA 2021
#> 242      320        NA 2021
#> 243       44        16 2021
#> 244      120        NA 2021
#> 245      194        NA 2021
#> 246      348        NA 2021
#> 247      247        NA 2021
#> 248      272        NA 2021
#> 249      230        NA 2021
#> 250      335        NA 2021
#> 251      243         2 2021
#> 252      191        NA 2021
#> 253        8        NA 2021
#> 254       22        NA 2021
#> 255      155        NA 2021
#> 256       48         1 2021
#> 257      348        NA 2021
#> 258      256        NA 2021
#> 259      348        NA 2021
#> 260      331        NA 2021
#> 261      239        NA 2021
#> 262      117        NA 2021
#> 263       62        NA 2021
#> 264      158        NA 2021
#> 265      104        NA 2021
#> 266      115        NA 2021
#> 267       21        NA 2021
#> 268       72        NA 2021
#> 269      172        NA 2021
#> 270      182        NA 2021
#> 271       76        11 2021
#> 272      310        NA 2021
#> 273       36        NA 2021
#> 274      237        NA 2021
#> 275       92        NA 2021
#> 276       54         5 2021
#> 277      225        NA 2021
#> 278      121         4 2021
#> 279      212        15 2021
#> 280       25        NA 2021
#> 281      249        NA 2021
#> 282      238        NA 2021
#> 283      299        NA 2021
#> 284      131        NA 2021
#> 285      325        NA 2021
#> 286       88        NA 2021
#> 287      250        NA 2021
#> 288      208        NA 2021
#> 289      142        NA 2021
#> 290      297        NA 2021
#> 291      231        NA 2021
#> 292      161        NA 2021
#> 293      275        NA 2021
#> 294      332        NA 2021
#> 295      223        NA 2021
#> 296       82        NA 2021
#> 297      189        NA 2021
#> 298       81        10 2021
#> 299      171        NA 2021
#> 300      133        NA 2021
#> 301       28        12 2021
#> 302      316        NA 2021
#> 303       98        NA 2021
#> 304      141        NA 2021
#> 305      122        NA 2021
#> 306      229        12 2021
#> 307       13         6 2021
#> 308      262        NA 2021
#> 309       63         7 2021
#> 310      144        16 2021
#> 311      129        NA 2021
#> 312      341        NA 2021
#> 313      321        NA 2021
#> 314       47        14 2021
#> 315      246        NA 2021
#> 316       19         6 2021
#> 317      195        NA 2021
#> 318       23        NA 2021
#> 319       30        15 2021
#> 320       18         9 2021
#> 321      145        10 2021
#> 322      278        NA 2021
#> 323      281        NA 2021
#> 324      291        NA 2021
#> 325      136        NA 2021
#> 326      240        NA 2021
#> 327      147        NA 2021
#> 328       71         9 2021
#> 329      118        NA 2021
#> 330       90        NA 2021
#> 331      226        NA 2021
#> 332        6         2 2021
#> 333      169        NA 2021
#> 334      167        NA 2021
#> 335       84        NA 2021
#> 336      159         5 2021
#> 337       40         7 2021
#> 338      213        NA 2021
#> 339      340        NA 2021
#> 340      206        16 2021
#> 341      175        11 2021
#> 342        4         8 2021
#> 343      224        NA 2021
#> 344      130        NA 2021
#> 345      283        NA 2021
#> 346      137        NA 2021
#> 347       57        13 2021
#> 348       37        NA 2021
#> 349      337        NA 2021
#> 350       39        13 2021
#> 351      163        NA 2021
#> 352      149        NA 2021
#> 353      177        NA 2021
#> 354       43        NA 2021
#> 355      324        NA 2021
#> 356       61        16 2021
#> 357      101         4 2021
#> 358      343        NA 2020
#> 359      352        NA 2020
#> 360      107        NA 2020
#> 361      221        NA 2020
#> 362      329        NA 2020
#> 363      202        NA 2020
#> 364      317        NA 2020
#> 365      187        NA 2020
#> 366       83        NA 2020
#> 367      340        NA 2020
#> 368      283        NA 2020
#> 369      143        NA 2020
#> 370      335        NA 2020
#> 371       64        10 2020
#> 372      310        NA 2020
#> 373      287        NA 2020
#> 374       54        NA 2020
#> 375      156        15 2020
#> 376      162        NA 2020
#> 377      122        NA 2020
#> 378       91        NA 2020
#> 379      220        NA 2020
#> 380      241        NA 2020
#> 381      296        NA 2020
#> 382      345        NA 2020
#> 383      270        NA 2020
#> 384      101        NA 2020
#> 385        2        NA 2020
#> 386      265        NA 2020
#> 387      159        NA 2020
#> 388       71        NA 2020
#> 389      324        NA 2020
#> 390      300        NA 2020
#> 391       11         3 2020
#> 392       23         1 2020
#> 393      125        16 2020
#> 394      282        NA 2020
#> 395      256        NA 2020
#> 396       14        12 2020
#> 397      304        NA 2020
#> 398      115        NA 2020
#> 399      155        NA 2020
#> 400      277        NA 2020
#> 401      349        NA 2020
#> 402       68        NA 2020
#> 403       47        NA 2020
#> 404      338        NA 2020
#> 405      161        NA 2020
#> 406       80        NA 2020
#> 407      183        NA 2020
#> 408      305        NA 2020
#> 409      285        NA 2020
#> 410      302        NA 2020
#> 411       59         6 2020
#> 412      288        NA 2020
#> 413      348        NA 2020
#> 414      286        NA 2020
#> 415      347        NA 2020
#> 416      102        NA 2020
#> 417      137         9 2020
#> 418       22        16 2020
#> 419      213        NA 2020
#> 420      144        NA 2020
#> 421      249        NA 2020
#> 422       38        14 2020
#> 423      247        NA 2020
#> 424      219        NA 2020
#> 425      279        NA 2020
#> 426      197        NA 2020
#> 427      204        NA 2020
#> 428      130        NA 2020
#> 429      313        NA 2020
#> 430       51        NA 2020
#> 431      342        NA 2020
#> 432      346        NA 2020
#> 433      157        NA 2020
#> 434      225         6 2020
#> 435      206        NA 2020
#> 436      263        NA 2020
#> 437      295        NA 2020
#> 438      222        NA 2020
#> 439      239        NA 2020
#> 440      185        NA 2020
#> 441      231         8 2020
#> 442      299        NA 2020
#> 443      181        NA 2020
#> 444      251        NA 2020
#> 445       36        NA 2020
#> 446       24         2 2020
#> 447      250        NA 2020
#> 448      193        NA 2020
#> 449       42        NA 2020
#> 450       65         3 2020
#> 451      341        NA 2020
#> 452      315        NA 2020
#> 453       30        NA 2020
#> 454      178        NA 2020
#> 455       89        10 2020
#> 456      151        NA 2020
#> 457      182        NA 2020
#> 458        5        11 2020
#> 459      227        NA 2020
#> 460      127        11 2020
#> 461      336        NA 2020
#> 462       87        NA 2020
#> 463      262        NA 2020
#> 464      200        NA 2020
#> 465       92         5 2020
#> 466      301        NA 2020
#> 467       57        13 2020
#> 468      311        NA 2020
#> 469        4         6 2020
#> 470      148        NA 2020
#> 471      217        NA 2020
#> 472       15         7 2020
#> 473      229        NA 2020
#> 474      333        NA 2020
#> 475       55        NA 2020
#> 476      284        NA 2020
#> 477      195        NA 2020
#> 478      172        NA 2020
#> 479      272        NA 2020
#> 480      198        NA 2020
#> 481       52        11 2020
#> 482      160        15 2020
#> 483      319        NA 2020
#> 484      106         5 2020
#> 485      323        NA 2020
#> 486      133        NA 2020
#> 487       27         3 2020
#> 488      142        NA 2020
#> 489      268        NA 2020
#> 490      141        NA 2020
#> 491       28        NA 2020
#> 492      353        NA 2020
#> 493      307        NA 2020
#> 494      320        NA 2020
#> 495      236        NA 2020
#> 496       21         9 2020
#> 497      297        NA 2020
#> 498      234        NA 2020
#> 499      321        NA 2020
#> 500      163        NA 2020
#> 501       33        NA 2020
#> 502      325        NA 2020
#> 503      138        NA 2020
#> 504      332        NA 2020
#> 505       93        NA 2020
#> 506      351        NA 2020
#> 507      103         6 2020
#> 508      129        NA 2020
#> 509      174        NA 2020
#> 510      266        NA 2020
#> 511      209        NA 2020
#> 512      147        NA 2020
#> 513      196        NA 2020
#> 514       81        NA 2020
#> 515      111        NA 2020
#> 516      168        NA 2020
#> 517      194        NA 2020
#> 518      218        NA 2020
#> 519      214        NA 2020
#> 520      108        NA 2020
#> 521      344        NA 2020
#> 522      276        NA 2020
#> 523      139        NA 2020
#> 524       34        NA 2020
#> 525      153        NA 2020
#> 526      240        NA 2020
#> 527      123        NA 2020
#> 528       46         8 2020
#> 529       67        NA 2020
#> 530       86        NA 2020
#> 531      314        NA 2020
#> 532      316        NA 2020
#> 533      203        NA 2020
#> 534      350        NA 2020
#> 535      176         2 2020
#> 536      173        NA 2020
#> 537      264        NA 2020
#> 538      131        NA 2020
#> 539      255        NA 2020
#> 540        9        NA 2020
#> 541       95        NA 2020
#> 542      114        NA 2020
#> 543      337        NA 2020
#> 544       79        NA 2020
#> 545       31         8 2020
#> 546      191        NA 2020
#> 547      134        NA 2020
#> 548       69        NA 2020
#> 549      188        NA 2020
#> 550      223        NA 2020
#> 551      298        NA 2020
#> 552      201        NA 2020
#> 553      132        NA 2020
#> 554       20        NA 2020
#> 555      308        NA 2020
#> 556       40        12 2020
#> 557       12        NA 2020
#> 558      192        NA 2020
#> 559      165        14 2020
#> 560      303        NA 2020
#> 561      175        NA 2020
#> 562      275        NA 2020
#> 563       99        10 2020
#> 564      164        NA 2020
#> 565      116        NA 2020
#> 566      253        NA 2020
#> 567       18        NA 2020
#> 568       96        NA 2020
#> 569       72        14 2020
#> 570      216        NA 2020
#> 571      145        NA 2020
#> 572       70         4 2020
#> 573      312        NA 2020
#> 574      309        NA 2020
#> 575      328        NA 2020
#> 576       29        NA 2020
#> 577       25         1 2020
#> 578      257        NA 2020
#> 579      252        NA 2020
#> 580      330        NA 2020
#> 581       66        NA 2020
#> 582       48        NA 2020
#> 583      306        NA 2020
#> 584       37        12 2020
#> 585      278        NA 2020
#> 586       35        11 2020
#> 587      331        NA 2020
#> 588       19         9 2020
#> 589      235        NA 2020
#> 590        3         1 2020
#> 591      166        NA 2020
#> 592      274        NA 2020
#> 593       13        10 2020
#> 594      292        NA 2020
#> 595      290        NA 2020
#> 596       76        NA 2020
#> 597      146        NA 2020
#> 598      267        NA 2020
#> 599       32         4 2020
#> 600      289        NA 2020
#> 601      110        14 2020
#> 602       58         3 2020
#> 603      167        NA 2020
#> 604      207        NA 2020
#> 605      230        NA 2020
#> 606      232        NA 2020
#> 607      293        NA 2020
#> 608      233        NA 2020
#> 609      294        NA 2020
#> 610      334        NA 2020
#> 611       90        NA 2020
#> 612      211        NA 2020
#> 613      109        NA 2020
#> 614      118        NA 2020
#> 615      237        NA 2020
#> 616      273        NA 2020
#> 617      243        NA 2020
#> 618      152        16 2020
#> 619      112        NA 2020
#> 620      105        16 2020
#> 621      254        NA 2020
#> 622      291        NA 2020
#> 623       44        NA 2020
#> 624       85        NA 2020
#> 625       74        NA 2020
#> 626      269        NA 2020
#> 627      186        NA 2020
#> 628      339        NA 2020
#> 629      154        16 2020
#> 630        8        13 2020
#> 631      258        NA 2020
#> 632      121         2 2020
#> 633      189        NA 2020
#> 634        7         1 2020
#> 635      322        NA 2020
#> 636      260        NA 2020
#> 637       41         5 2020
#> 638       62        11 2020
#> 639      169        16 2020
#> 640      327        NA 2020
#> 641      180        NA 2020
#> 642      224        NA 2020
#> 643      158        NA 2020
#> 644      150        15 2020
#> 645       98         7 2020
#> 646      318        NA 2020
#> 647       53        NA 2020
#> 648      179        NA 2020
#> 649       56        NA 2020
#> 650      228        NA 2020
#> 651      242        NA 2020
#> 652      246        NA 2020
#> 653       78        NA 2020
#> 654       17        NA 2020
#> 655       84        NA 2020
#> 656      113        NA 2020
#> 657       16         7 2020
#> 658      184        NA 2020
#> 659      128        NA 2020
#> 660      210        NA 2020
#> 661       75        15 2020
#> 662      208        NA 2020
#> 663      177        NA 2020
#> 664       60        NA 2020
#> 665      140        NA 2020
#> 666      126        NA 2020
#> 667      226        NA 2020
#> 668       45        NA 2020
#> 669       77        NA 2020
#> 670       88        NA 2020
#> 671      326        NA 2020
#> 672      261        NA 2020
#> 673      119        NA 2020
#> 674      244        NA 2020
#> 675      120        NA 2020
#> 676      124         4 2020
#> 677       94        NA 2020
#> 678      248        NA 2020
#> 679      245        NA 2020
#> 680       97        NA 2020
#> 681       49        NA 2020
#> 682      190        11 2020
#> 683      136         9 2020
#> 684      215        NA 2020
#> 685       26        NA 2020
#> 686      117        NA 2020
#> 687      170        NA 2020
#> 688      205        NA 2020
#> 689       10         2 2020
#> 690       39        NA 2020
#> 691      135        NA 2020
#> 692      199        NA 2020
#> 693      259        NA 2020
#> 694      100        NA 2020
#> 695      280        NA 2020
#> 696      171         8 2020
#> 697       61        NA 2020
#> 698       63         5 2020
#> 699       73         4 2020
#> 700       43        13 2020
#> 701      271        NA 2020
#> 702      238        NA 2020
#> 703      104        NA 2020
#> 704       82        NA 2020
#> 705       50        NA 2020
#> 706      281        NA 2020
#> 707      149        13 2020
#> 708      212        NA 2020
#> 709        6        12 2020
#> 710        1         7 2020
# }
```
