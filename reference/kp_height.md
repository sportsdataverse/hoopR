# **Get Heights, Experience, Bench and Continuity Data**

**Get Heights, Experience, Bench and Continuity Data**

## Usage

``` r
kp_height(min_year, max_year = most_recent_mbb_season())
```

## Arguments

- min_year:

  First year of data to pull

- max_year:

  Last year of data to pull

## Value

Returns a tibble of heights

|               |           |                                     |
|---------------|-----------|-------------------------------------|
| col_name      | types     | description                         |
| team          | character | Team-side label or team identifier. |
| conf          | character | character.                          |
| avg_hgt       | numeric   | Avg hgt.                            |
| avg_hgt_rk    | numeric   | Avg hgt rk.                         |
| eff_hgt       | numeric   | Eff hgt.                            |
| eff_hgt_rk    | numeric   | Eff hgt rk.                         |
| c_hgt         | numeric   | C hgt.                              |
| c_hgt_rk      | numeric   | C hgt rk.                           |
| pf_hgt        | numeric   | Pf hgt.                             |
| pf_hgt_rk     | numeric   | Pf hgt rk.                          |
| sf_hgt        | numeric   | Sf hgt.                             |
| sf_hgt_rk     | numeric   | Sf hgt rk.                          |
| sg_hgt        | numeric   | Sg hgt.                             |
| sg_hgt_rk     | numeric   | Sg hgt rk.                          |
| pg_hgt        | numeric   | Pg hgt.                             |
| pg_hgt_rk     | numeric   | Pg hgt rk.                          |
| experience    | numeric   | Years of professional experience.   |
| experience_rk | numeric   | Experience rk.                      |
| bench         | numeric   | Bench.                              |
| bench_rk      | numeric   | Bench rk.                           |
| continuity    | numeric   | Continuity.                         |
| continuity_rk | numeric   | Continuity rk.                      |
| ncaa_seed     | numeric   | Ncaa seed.                          |
| year          | integer   | 4-digit year.                       |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_playerstats()`](https://hoopR.sportsdataverse.org/reference/kp_playerstats.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_height(min_year = 2020, max_year = 2021))
#> ✖ 2026-05-17 16:11:27.900365: Invalid arguments or no height data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: subscript out of bounds
#>                       Team Conf Avg.Hgt Avg.Hgt.Rk Eff.Hgt Eff.Hgt.Rk C.Hgt
#> 1              Florida St.  ACC    79.0          1     1.4         27   1.6
#> 2         Eastern Michigan  MAC    78.8          2     2.3          4   2.4
#> 3                  Gonzaga  WCC    78.8          3     2.0          7   1.7
#> 4               Washington  P12    78.7          4     1.4         33   0.5
#> 5               Seton Hall   BE    78.7          5     3.2          1   4.6
#> 6             Northwestern  B10    78.7          6     1.9         14   1.0
#> 7          Mississippi St.  SEC    78.7          7     1.9         15   1.7
#> 8                Villanova   BE    78.6          8     0.8         67   0.0
#> 9         Central Arkansas Slnd    78.6          9     1.6         20   2.5
#> 10                Utah St.  MWC    78.4         10     0.9         59   2.0
#> 11                Syracuse  ACC    78.4         11     1.5         24   1.1
#> 12                 Arizona  P12    78.3         12     1.9          9   2.1
#> 13              Oregon St.  P12    78.3         13     1.4         30   2.8
#> 14                  Purdue  B10    78.3         14     2.2          5   2.8
#> 15                 Harvard  Ivy    78.3         15     1.2         41   1.1
#> 16              Notre Dame  ACC    78.3         16     1.5         22   1.4
#> 17             Santa Clara  WCC    78.3         17     1.3         39   0.9
#> 18              Cincinnati Amer    78.3         18     2.1          6   3.2
#> 19                 Indiana  B10    78.3         19     1.3         38   1.2
#> 20          North Carolina  ACC    78.3         20     1.2         44   0.6
#> 21                   Maine   AE    78.2         21     0.3        112  -0.5
#> 22                    Duke  ACC    78.2         22     1.1         50   0.9
#> 23                  Xavier   BE    78.2         23     0.7         75   0.0
#> 24                  Kansas  B12    78.2         24     1.3         37   2.4
#> 25          South Carolina  SEC    78.2         25     0.9         63   2.0
#> 26          Long Beach St.   BW    78.2         26     1.9         12   1.9
#> 27        Loyola Marymount  WCC    78.2         27    -0.3        227  -1.0
#> 28                    Utah  P12    78.1         28     1.6         21   1.7
#> 29                     USC  P12    78.1         29     2.0          8   1.7
#> 30              New Mexico  MWC    78.1         30     0.8         69   0.3
#> 31                Kentucky  SEC    78.0         31     1.8         17   1.7
#> 32                Davidson  A10    78.0         32     0.4        103   0.4
#> 33                    UCLA  P12    78.0         33     1.5         26   0.8
#> 34                 Rutgers  B10    78.0         34     0.3        110   1.0
#> 35               Boise St.  MWC    78.0         35     0.7         76   0.8
#> 36            San Jose St.  MWC    77.9         36     0.5         97   0.5
#> 37            Oklahoma St.  B12    77.9         37     0.4        108   0.5
#> 38               Tennessee  SEC    77.9         38    -0.3        222  -0.2
#> 39          Boston College  ACC    77.9         39     0.7         79   0.4
#> 40                Delaware  CAA    77.9         40     0.6         91   1.2
#> 41           East Carolina Amer    77.9         41     0.1        140   0.1
#> 42                Missouri  SEC    77.9         42     1.0         57   1.0
#> 43                  Hawaii   BW    77.8         43     1.3         35   1.5
#> 44           San Francisco  WCC    77.8         44     1.9         11   2.1
#> 45         St. Bonaventure  A10    77.8         45     0.9         61   0.8
#> 46        Tennessee Martin  OVC    77.8         46     0.5         95   1.0
#> 47               Minnesota  B10    77.8         47     1.1         45   0.8
#> 48                     TCU  B12    77.8         48     0.4        101   1.4
#> 49                Oklahoma  B12    77.8         49     0.2        120   0.2
#> 50                Virginia  ACC    77.8         50     2.4          3   2.9
#> 51                Stanford  P12    77.8         51     0.8         68   0.3
#> 52             Montana St. BSky    77.7         52     1.0         56   1.0
#> 53                    Iowa  B10    77.7         53     1.6         19   1.8
#> 54                  Oregon  P12    77.7         54     0.1        147  -0.2
#> 55          William & Mary  CAA    77.7         55     1.9         10   2.6
#> 56                   Texas  B12    77.7         56     1.1         48   1.0
#> 57           James Madison  CAA    77.7         57    -0.4        238  -1.0
#> 58                 Wyoming  MWC    77.7         58    -0.3        220  -0.3
#> 59                    UTEP CUSA    77.7         59     0.8         70   0.8
#> 60           Grambling St. SWAC    77.7         60     1.5         23   1.9
#> 61                    Ohio  MAC    77.6         61     0.9         60   0.9
#> 62           West Virginia  B12    77.6         62     0.8         66   0.9
#> 63                     UCF Amer    77.6         63     0.4        104   1.8
#> 64            UC Riverside   BW    77.6         64     1.9         13   2.8
#> 65                Michigan  B10    77.6         65     2.6          2   3.2
#> 66               Fairfield MAAC    77.6         66     0.2        133  -0.2
#> 67            North Dakota  Sum    77.6         67     0.6         92   0.0
#> 68        Northern Arizona BSky    77.6         68    -0.1        172  -0.2
#> 69            Missouri St.  MVC    77.6         69    -0.1        178  -1.0
#> 70              Georgetown   BE    77.5         70     1.6         18   2.6
#> 71            Michigan St.  B10    77.5         71     0.3        116  -0.2
#> 72              Coppin St. MEAC    77.5         72     1.1         46   2.3
#> 73               Idaho St. BSky    77.5         73    -0.8        287  -1.2
#> 74                     BYU  WCC    77.5         74    -0.3        223  -0.7
#> 75        UC Santa Barbara   BW    77.5         75     1.4         34   1.0
#> 76              Providence   BE    77.5         76     0.4        107   0.3
#> 77           Southern Utah BSky    77.5         77     0.4        105   0.4
#> 78                     LSU  SEC    77.5         78    -0.7        271  -0.6
#> 79       Purdue Fort Wayne  Sum    77.5         79     0.1        152   0.6
#> 80                  Lehigh  Pat    77.5         80     0.2        125   0.5
#> 81                 Clemson  ACC    77.5         81     0.0        164  -0.2
#> 82        Louisiana Monroe   SB    77.5         82     1.4         28   1.7
#> 83                    Rice CUSA    77.5         83     0.2        122  -0.5
#> 84                Illinois  B10    77.4         84     1.0         55   2.1
#> 85           Massachusetts  A10    77.4         85     0.5         96   0.2
#> 86          Saint Joseph's  A10    77.4         86    -0.1        181  -0.1
#> 87                  Toledo  MAC    77.4         87     0.8         71   1.9
#> 88                 Florida  SEC    77.4         88     0.1        149   1.1
#> 89                   Siena MAAC    77.4         89    -0.2        205  -0.6
#> 90                 Belmont  OVC    77.4         90     1.0         54   1.8
#> 91            Georgia Tech  ACC    77.4         91     1.4         29   1.0
#> 92                Marshall CUSA    77.4         92     1.0         51   0.7
#> 93          Washington St.  P12    77.4         93    -0.1        173   0.3
#> 94              Pittsburgh  ACC    77.4         94    -0.2        194   0.3
#> 95                     SMU Amer    77.4         95     0.6         94  -0.1
#> 96                 Houston Amer    77.4         96    -0.3        213  -0.3
#> 97                Maryland  B10    77.4         97     0.3        119   0.7
#> 98                  Towson  CAA    77.3         98     0.1        146  -0.4
#> 99               Texas A&M  SEC    77.3         99     0.1        144   0.0
#> 100                 DePaul   BE    77.3        100     0.9         62   0.4
#> 101                Oakland Horz    77.3        101     0.3        114   0.4
#> 102               Colorado  P12    77.3        102     0.5         98   0.5
#> 103           Old Dominion CUSA    77.3        103    -0.2        198  -0.4
#> 104                 Auburn  SEC    77.3        104     0.0        161   0.1
#> 105      Boston University  Pat    77.3        105     0.1        155   0.0
#> 106              San Diego  WCC    77.3        106    -0.1        190  -0.5
#> 107              UC Irvine   BW    77.3        107     1.4         32   1.1
#> 108                   Yale  Ivy    77.3        108     1.2         40   0.8
#> 109                   UMBC   AE    77.3        109     1.1         49   0.8
#> 110             N.C. State  ACC    77.3        110     1.0         53   1.4
#> 111             St. John's   BE    77.3        111    -0.5        249  -0.6
#> 112             Holy Cross  Pat    77.2        112     0.2        137   0.2
#> 113               Penn St.  B10    77.2        113     0.4        109   0.0
#> 114                 Butler   BE    77.2        114     0.0        163  -0.1
#> 115            Wake Forest  ACC    77.2        115     1.4         31   1.9
#> 116                 Temple Amer    77.2        116     0.4        102   0.0
#> 117                  Tulsa Amer    77.2        117    -0.2        195  -0.5
#> 118                Pacific  WCC    77.2        118     0.0        159   1.0
#> 119          Northern Iowa  MVC    77.2        119     0.2        136   0.5
#> 120            Mississippi  SEC    77.2        120     0.2        128   0.2
#> 121                 Marist MAAC    77.2        121    -0.5        250  -0.7
#> 122             Quinnipiac MAAC    77.2        122     0.6         93   0.4
#> 123             Kansas St.  B12    77.2        123     0.3        115   0.0
#> 124              Marquette   BE    77.2        124     0.7         73   0.8
#> 125                   Iona MAAC    77.1        125     0.7         88   0.2
#> 126                Vermont   AE    77.1        126    -0.5        239  -0.1
#> 127              Wisconsin  B10    77.1        127     1.2         43   1.6
#> 128         UNC Greensboro   SC    77.1        128     1.0         52   0.8
#> 129             California  P12    77.1        129     0.9         65   0.6
#> 130              Air Force  MWC    77.1        130    -0.6        256  -1.3
#> 131            Arizona St.  P12    77.1        131     0.3        118  -0.6
#> 132      Cal St. Fullerton   BW    77.1        132    -0.5        245  -0.6
#> 133               Bucknell  Pat    77.1        133    -0.8        281  -0.8
#> 134                    VCU  A10    77.1        134    -1.1        312  -1.5
#> 135           Saint Mary's  WCC    77.1        135     0.0        167  -0.5
#> 136                Alabama  SEC    77.1        136     0.2        126   0.0
#> 137       Illinois Chicago Horz    77.1        137     0.5        100   0.1
#> 138            Cal Baptist  WAC    77.1        138     0.5         99   0.9
#> 139              Lafayette  Pat    77.0        139     0.7         77   0.4
#> 140           Illinois St.  MVC    77.0        140    -0.2        196  -0.4
#> 141              Milwaukee Horz    77.0        141     0.1        148  -0.4
#> 142               Nebraska  B10    77.0        142    -0.4        233  -0.5
#> 143      George Washington  A10    77.0        143     0.1        151  -0.2
#> 144               Iowa St.  B12    77.0        144     0.4        106   0.4
#> 145         Loyola Chicago  MVC    77.0        145    -0.1        184  -0.1
#> 146            Connecticut Amer    77.0        146     1.2         42   1.0
#> 147       Central Michigan  MAC    77.0        147    -0.6        260  -1.2
#> 148             Evansville  MVC    77.0        148     0.0        162  -0.7
#> 149             Louisville  ACC    77.0        149     0.7         85   1.1
#> 150           Nicholls St. Slnd    77.0        150    -0.3        221  -0.8
#> 151       Florida Atlantic CUSA    77.0        151     1.1         47   1.4
#> 152               Miami FL  ACC    77.0        152     1.8         16   2.1
#> 153                Colgate  Pat    77.0        153     1.5         25   1.0
#> 154                    UAB CUSA    77.0        154     0.9         64   1.0
#> 155                Hampton BSth    77.0        155    -0.9        291  -1.2
#> 156             Texas Tech  B12    76.9        156    -1.3        326  -1.8
#> 157           UMass Lowell   AE    76.9        157    -1.1        311  -2.0
#> 158                 Drexel  CAA    76.9        158    -0.2        203  -0.4
#> 159                Cornell  Ivy    76.9        159     0.1        143  -0.7
#> 160             Vanderbilt  SEC    76.9        160     0.7         86   0.5
#> 161          South Florida Amer    76.9        161     0.7         82   2.0
#> 162                 Albany   AE    76.9        162    -0.1        182  -0.4
#> 163         St. Francis PA  NEC    76.9        163    -0.1        183   0.1
#> 164                Stetson ASun    76.9        164     0.1        141   0.3
#> 165       South Dakota St.  Sum    76.9        165    -0.5        241  -1.2
#> 166                 Tulane Amer    76.9        166     0.3        117   0.5
#> 167          North Florida ASun    76.9        167    -0.8        278  -1.8
#> 168             Fresno St.  MWC    76.9        168     0.2        132   0.4
#> 169    Cal St. Bakersfield  WAC    76.9        169    -0.2        201  -0.3
#> 170                 Nevada  MWC    76.9        170     0.7         74   0.8
#> 171              Princeton  Ivy    76.9        171    -0.1        189  -0.5
#> 172                   Elon  CAA    76.9        172    -1.3        329  -1.9
#> 173                 Howard MEAC    76.9        173    -0.5        246  -0.6
#> 174          New Hampshire   AE    76.9        174    -1.9        349  -2.3
#> 175           Rhode Island  A10    76.9        175    -0.1        176  -1.0
#> 176          Tennessee St.  OVC    76.9        176     0.7         87   0.0
#> 177             Murray St.  OVC    76.9        177     0.0        168   0.1
#> 178     Florida Gulf Coast ASun    76.9        178    -1.0        303  -0.8
#> 179                 Denver  Sum    76.9        179     0.7         83   0.6
#> 180               La Salle  A10    76.8        180    -0.6        259  -0.4
#> 181                 Baylor  B12    76.8        181     0.1        150   0.4
#> 182          Bowling Green  MAC    76.8        182    -0.1        191   0.3
#> 183            Wichita St. Amer    76.8        183     0.2        123   1.3
#> 184          Saint Peter's MAAC    76.8        184    -0.4        230  -0.6
#> 185               Ohio St.  B10    76.8        185    -0.3        215  -0.2
#> 186                   UNLV  MWC    76.8        186     0.0        166   1.0
#> 187                   UTSA CUSA    76.8        187     0.2        127   0.8
#> 188       Jacksonville St.  OVC    76.8        188     0.2        130   0.4
#> 189         Sacramento St. BSky    76.8        189    -0.9        290  -1.2
#> 190            Little Rock   SB    76.8        190     0.8         72   1.0
#> 191                 Dayton  A10    76.8        191     0.0        160   0.4
#> 192                  Rider MAAC    76.8        192     0.0        165  -0.4
#> 193   UT Rio Grande Valley  WAC    76.8        193    -0.5        240  -0.8
#> 194              Green Bay Horz    76.8        194    -0.3        217  -0.3
#> 195        Appalachian St.   SB    76.8        195     0.7         80   0.0
#> 196               Cal Poly   BW    76.8        196    -0.7        276  -0.1
#> 197              Manhattan MAAC    76.8        197    -0.2        207  -0.7
#> 198               Winthrop BSth    76.8        198    -0.1        187  -0.6
#> 199               Kent St.  MAC    76.7        199     0.0        169  -0.3
#> 200          San Diego St.  MWC    76.7        200     0.2        131   1.0
#> 201       Coastal Carolina   SB    76.7        201    -0.2        192  -0.6
#> 202          Southern Miss CUSA    76.7        202    -0.5        243  -0.7
#> 203       Middle Tennessee CUSA    76.7        203    -1.0        300  -0.8
#> 204                Montana BSky    76.7        204    -1.4        333  -1.1
#> 205            Stony Brook   AE    76.7        205    -0.2        199   0.8
#> 206          UNC Asheville BSth    76.7        206    -0.9        297  -0.2
#> 207               Monmouth MAAC    76.7        207    -0.5        251  -0.5
#> 208                Bradley  MVC    76.7        208     0.7         84   1.8
#> 209            Chicago St.  WAC    76.7        209    -0.1        180  -0.1
#> 210       North Dakota St.  Sum    76.7        210    -0.3        224   0.2
#> 211     South Carolina St. MEAC    76.6        211    -0.1        175  -1.0
#> 212              Charlotte CUSA    76.6        212    -0.3        218  -0.1
#> 213                Seattle  WAC    76.6        213     0.1        154   0.3
#> 214                Georgia  SEC    76.6        214     0.2        129   0.1
#> 215             Morgan St. MEAC    76.6        215     0.0        158  -0.1
#> 216                    FIU CUSA    76.6        216    -0.6        258  -0.1
#> 217                 Wagner  NEC    76.6        217    -1.1        309  -1.0
#> 218                Detroit Horz    76.6        218    -0.7        275  -1.4
#> 219               American  Pat    76.6        219    -0.6        257  -0.1
#> 220               Hartford   AE    76.6        220     0.7         81   0.6
#> 221             Valparaiso  MVC    76.6        221    -0.2        197  -0.7
#> 222              Weber St. BSky    76.5        222    -0.1        179   0.1
#> 223                Memphis Amer    76.5        223     0.7         78   0.2
#> 224     Eastern Washington BSky    76.5        224    -0.3        214  -0.8
#> 225            North Texas CUSA    76.5        225    -0.3        219   0.2
#> 226      Southern Illinois  MVC    76.5        226    -0.5        247  -0.2
#> 227                  Akron  MAC    76.5        227     1.0         58   0.5
#> 228            Chattanooga   SC    76.5        228    -0.2        209  -0.7
#> 229                   Penn  Ivy    76.5        229    -0.8        288  -1.0
#> 230 Southeastern Louisiana Slnd    76.5        230     0.0        170  -0.3
#> 231                 Mercer   SC    76.5        231    -0.8        282   0.4
#> 232            Utah Valley  WAC    76.5        232     0.3        113   0.4
#> 233           Portland St. BSky    76.5        233    -1.0        305  -1.5
#> 234      Stephen F. Austin Slnd    76.5        234    -0.8        289  -1.4
#> 235              Creighton   BE    76.5        235    -1.5        340  -1.3
#> 236               Lipscomb ASun    76.5        236    -1.1        315  -1.3
#> 237       Eastern Kentucky  OVC    76.5        237     0.2        121  -0.3
#> 238 Southeast Missouri St.  OVC    76.5        238    -0.2        211  -1.0
#> 239             Alcorn St. SWAC    76.4        239    -0.7        273   0.6
#> 240        Houston Baptist Slnd    76.4        240    -0.8        283  -0.3
#> 241           Kennesaw St. ASun    76.4        241     0.3        111   0.0
#> 242       Georgia Southern   SB    76.4        242    -1.4        332  -1.2
#> 243                  Brown  Ivy    76.4        243    -1.0        301  -0.8
#> 244               Campbell BSth    76.4        244    -0.9        294  -0.8
#> 245               Ball St.  MAC    76.4        245    -0.3        226  -1.0
#> 246              Texas St.   SB    76.3        246    -0.3        225  -1.0
#> 247            Florida A&M MEAC    76.3        247    -0.9        293  -0.3
#> 248             Charleston  CAA    76.3        248    -0.6        255  -0.4
#> 249             Binghamton   AE    76.3        249    -0.6        266  -0.3
#> 250       Western Illinois  Sum    76.3        250    -0.1        188  -0.4
#> 251            Georgia St.   SB    76.3        251    -0.2        202   0.2
#> 252           South Dakota  Sum    76.3        252    -0.3        228   0.3
#> 253         Youngstown St. Horz    76.3        253    -1.1        317  -1.2
#> 254     North Carolina A&T MEAC    76.3        254    -0.1        186  -0.5
#> 255              Loyola MD  Pat    76.3        255    -0.2        206   0.7
#> 256           Grand Canyon  WAC    76.3        256     0.2        134   0.5
#> 257                   UMKC  WAC    76.3        257    -0.7        272  -0.5
#> 258              Louisiana   SB    76.3        258     0.2        135  -0.1
#> 259        Bethune Cookman MEAC    76.2        259    -0.7        270  -0.6
#> 260             Wright St. Horz    76.2        260    -0.7        274  -0.7
#> 261                  Lamar Slnd    76.2        261    -0.2        200  -0.2
#> 262         New Mexico St.  WAC    76.2        262    -0.4        229  -0.9
#> 263              Dartmouth  Ivy    76.2        263    -1.5        338  -2.0
#> 264      Northern Colorado BSky    76.2        264    -0.6        254  -0.1
#> 265         Texas Southern SWAC    76.2        265     0.0        156  -0.1
#> 266            Norfolk St. MEAC    76.2        266    -0.4        231  -0.2
#> 267           Arkansas St.   SB    76.2        267    -0.1        174  -0.5
#> 268                Samford   SC    76.2        268    -0.2        193  -1.0
#> 269         UNC Wilmington  CAA    76.2        269    -1.1        308  -1.5
#> 270     East Tennessee St.   SC    76.1        270    -0.5        242   0.9
#> 271    Arkansas Pine Bluff SWAC    76.1        271    -0.2        210  -0.4
#> 272             Pepperdine  WCC    76.1        272    -0.4        236  -0.6
#> 273               Columbia  Ivy    76.1        273    -0.9        295  -1.0
#> 274          Cleveland St. Horz    76.1        274    -0.6        263  -0.5
#> 275               Canisius MAAC    76.1        275     0.6         90   0.2
#> 276               Portland  WCC    76.1        276     1.3         36   1.7
#> 277                   Navy  Pat    76.1        277    -0.7        268  -1.3
#> 278               Arkansas  SEC    76.1        278    -1.8        346  -1.9
#> 279             High Point BSth    76.1        279     0.0        171  -0.7
#> 280                Fordham  A10    76.1        280    -0.1        185   0.9
#> 281           George Mason  A10    76.1        281    -0.4        235  -0.9
#> 282           Jacksonville ASun    76.0        282    -0.4        234  -0.2
#> 283 Texas A&M Corpus Chris Slnd    76.0        283    -0.3        216  -0.2
#> 284            McNeese St. Slnd    76.0        284    -0.9        296  -1.0
#> 285       Western Kentucky CUSA    76.0        285    -1.9        348  -1.9
#> 286           Sacred Heart  NEC    76.0        286    -0.6        261   0.2
#> 287               Duquesne  A10    76.0        287    -0.1        177   0.8
#> 288           Presbyterian BSth    76.0        288    -0.6        264  -0.7
#> 289         Nebraska Omaha  Sum    76.0        289    -0.7        269  -1.0
#> 290       SIU Edwardsville  OVC    76.0        290    -0.9        292  -2.0
#> 291         Tennessee Tech  OVC    76.0        291    -1.3        330  -1.2
#> 292           Northeastern  CAA    75.9        292    -1.1        316  -1.5
#> 293      Northern Illinois  MAC    75.9        293    -0.2        204  -0.3
#> 294            Indiana St.  MVC    75.9        294    -0.8        279  -1.4
#> 295                   Troy   SB    75.9        295    -1.2        322  -1.1
#> 296                    VMI   SC    75.9        296    -1.2        319   0.0
#> 297                  Drake  MVC    75.9        297    -0.4        237   1.5
#> 298            The Citadel   SC    75.9        298    -1.5        341  -1.3
#> 299    Fairleigh Dickinson  NEC    75.9        299    -0.8        286  -1.1
#> 300    Central Connecticut  NEC    75.9        300    -1.6        344  -2.0
#> 301               Richmond  A10    75.8        301     0.2        124   0.5
#> 302                  Idaho BSky    75.8        302    -1.2        323  -0.3
#> 303           Oral Roberts  Sum    75.8        303    -0.3        212  -1.0
#> 304          South Alabama   SB    75.8        304    -2.1        352  -3.0
#> 305                Hofstra  CAA    75.8        305    -1.4        335  -1.4
#> 306                Buffalo  MAC    75.8        306    -1.3        327  -1.2
#> 307       Prairie View A&M SWAC    75.8        307    -1.6        345  -1.6
#> 308                Wofford   SC    75.8        308    -1.2        324  -1.0
#> 309               Southern SWAC    75.8        309     0.1        142   0.5
#> 310       Western Michigan  MAC    75.8        310    -0.2        208  -0.7
#> 311           Colorado St.  MWC    75.8        311     0.1        153   1.3
#> 312           UT Arlington   SB    75.7        312    -1.0        307  -0.9
#> 313           Morehead St.  OVC    75.7        313    -0.8        285  -0.7
#> 314            Saint Louis  A10    75.7        314    -0.8        284  -0.9
#> 315            Jackson St. SWAC    75.7        315    -1.4        334  -2.0
#> 316           Gardner Webb BSth    75.7        316    -0.8        280  -0.7
#> 317    Charleston Southern BSth    75.7        317    -0.9        298  -0.7
#> 318                 Furman   SC    75.7        318    -0.5        248  -1.2
#> 319            USC Upstate BSth    75.7        319    -0.7        267  -0.5
#> 320       Mount St. Mary's  NEC    75.7        320     0.6         89   0.0
#> 321       Western Carolina   SC    75.7        321    -1.2        321  -1.4
#> 322          Robert Morris  NEC    75.7        322    -0.6        253  -1.0
#> 323                 Bryant  NEC    75.7        323    -0.6        262  -0.5
#> 324               Longwood BSth    75.6        324    -1.0        306  -0.9
#> 325           Delaware St. MEAC    75.6        325    -1.0        302  -1.3
#> 326            New Orleans Slnd    75.6        326    -1.4        336  -2.0
#> 327         Louisiana Tech CUSA    75.6        327    -1.1        314  -0.9
#> 328                Liberty ASun    75.5        328    -1.0        299  -1.4
#> 329                  IUPUI Horz    75.5        329    -1.1        310  -1.1
#> 330                    LIU  NEC    75.5        330     0.2        138   0.4
#> 331            Alabama St. SWAC    75.5        331    -1.8        347  -1.9
#> 332                   Army  Pat    75.5        332     0.1        145  -0.2
#> 333       Eastern Illinois  OVC    75.5        333    -2.4        353  -3.1
#> 334     Cal St. Northridge   BW    75.5        334    -0.5        244  -0.8
#> 335               UC Davis   BW    75.4        335    -1.4        337  -0.5
#> 336            Austin Peay  OVC    75.4        336    -1.2        320  -0.6
#> 337                Radford BSth    75.4        337    -0.6        265  -0.8
#> 338                   NJIT ASun    75.4        338     0.1        139   0.0
#> 339               Miami OH  MAC    75.4        339    -1.0        304  -0.8
#> 340 North Carolina Central MEAC    75.4        340    -1.3        325  -1.7
#> 341            Alabama A&M SWAC    75.3        341    -0.4        232  -0.6
#> 342      Abilene Christian Slnd    75.3        342     0.0        157   0.8
#> 343         Incarnate Word Slnd    75.3        343    -1.5        342  -0.7
#> 344          Virginia Tech  ACC    75.3        344    -1.3        331  -1.3
#> 345       Northwestern St. Slnd    75.3        345    -0.6        252  -0.7
#> 346              Merrimack  NEC    75.2        346    -2.1        350  -2.4
#> 347        Sam Houston St. Slnd    75.2        347    -1.6        343  -1.0
#> 348      Northern Kentucky Horz    75.2        348    -1.5        339  -1.9
#> 349          North Alabama ASun    75.1        349    -1.2        318  -1.6
#> 350 Maryland Eastern Shore MEAC    75.0        350    -1.3        328  -1.8
#> 351         St. Francis NY  NEC    74.9        351    -1.1        313  -1.1
#> 352 Mississippi Valley St. SWAC    74.9        352    -0.7        277  -1.0
#> 353                Niagara MAAC    74.1        353    -2.1        351  -1.2
#>     C.Hgt.Rk PF.Hgt PF.Hgt.Rk SF.Hgt SF.Hgt.Rk SG.Hgt SG.Hgt.Rk PG.Hgt
#> 1         36    1.2        46    2.3         3    2.4         5    3.4
#> 2         11    2.2         4    1.4        32    1.9        20    2.2
#> 3         35    2.4         2    1.6        23    1.5        39    2.6
#> 4        106    2.2         5    2.7         1    2.9         3    1.2
#> 5          1    1.9        13    0.8        68    0.8        95    1.4
#> 6         58    2.7         1    2.2         6    1.8        23    1.7
#> 7         32    2.0         8    1.8        18    1.7        30    2.0
#> 8        156    1.7        20    2.5         2    2.2         9    2.5
#> 9         10    0.7        92    2.2         6    3.2         1    0.1
#> 10        20   -0.1       187    1.1        55    2.1        10    3.1
#> 11        50    1.9        12    1.3        35    2.7         4    0.7
#> 12        16    1.8        17    0.9        60    1.3        52    1.4
#> 13         7    0.0       172    0.5       100    2.1        10    2.2
#> 14         5    1.5        26    0.7        86    1.0        85    1.5
#> 15        49    1.4        40    1.8        17    1.8        27    1.4
#> 16        42    1.6        22    1.2        38    0.7       100    2.4
#> 17        68    1.6        24    1.9        11    1.7        31    1.2
#> 18         2    1.1        59    0.2       128    1.2        58    1.6
#> 19        47    1.4        35    2.2         6    1.1        65    1.4
#> 20        95    1.7        18    1.9        12    1.1        64    1.9
#> 21       231    1.2        46    2.2         5    1.8        21    2.3
#> 22        69    1.2        51    1.3        34    1.8        28    1.8
#> 23       156    1.5        27    1.9        10    1.1        66    2.3
#> 24        12    0.2       157    0.2       128    2.1        10    1.9
#> 25        19   -0.1       196    1.1        51    1.3        51    2.3
#> 26        22    1.9        10    0.8        74    1.0        83    1.0
#> 27       283    0.3       120    1.4        33    3.1         2    2.8
#> 28        33    1.4        32    1.2        38    2.4         6   -0.3
#> 29        34    2.3         3    1.2        36    0.6       118    0.6
#> 30       132    1.3        42    0.9        63    1.6        33    2.1
#> 31        31    1.9        11    0.0       194    0.1       168    2.4
#> 32       110    0.4       112    0.2       128    2.1        10    3.0
#> 33        88    2.2         5    1.4        31    1.8        22   -0.4
#> 34        54   -0.3       222    1.2        38    1.5        37    2.4
#> 35        84    0.7        95    1.9         9    1.5        38    0.9
#> 36       101    0.5       109    1.2        38    1.6        34    1.7
#> 37       100    0.2       152    1.2        38    1.2        57    2.4
#> 38       190   -0.4       229    1.2        38    2.4         7    2.5
#> 39       113    1.0        61    1.1        52    0.4       132    2.4
#> 40        46    0.0       173    0.2       128    2.1        10    1.8
#> 41       151    0.2       135    1.7        22    2.2         8    1.0
#> 42        58    1.0        66    0.2       128    1.2        56    1.8
#> 43        38    1.1        56    0.0       187    0.1       168    2.4
#> 44        17    1.8        16    0.2       126    0.1       165    0.9
#> 45        82    1.1        60    0.1       183    0.7       103    2.4
#> 46        66    0.1       165    0.3       115    1.5        42    2.0
#> 47        75    1.4        29   -0.1       200    1.1        66    1.6
#> 48        43   -0.5       240    0.4       108    1.6        36    1.9
#> 49       136    0.3       129    0.7        85    2.1        10    1.6
#> 50         4    1.8        14    2.2         4    1.0        77   -3.3
#> 51       133    1.4        34    1.5        28    0.0       188    1.4
#> 52        67    1.0        63    0.0       195    1.1        66    1.6
#> 53        25    1.4        38    0.7        87    0.4       133    0.3
#> 54       192    0.4       111    1.0        57    1.6        35    1.6
#> 55         9    1.3        41   -0.8       272    1.1        66    0.2
#> 56        53    1.1        55    0.1       173    0.5       123    1.6
#> 57       283    0.1       159    0.2       128    1.8        24    3.1
#> 58       205   -0.3       211    0.9        61    2.1        10    1.9
#> 59        86    0.8        78   -0.2       211    0.4       134    2.4
#> 60        21    1.1        54    1.5        29    0.2       148   -0.6
#> 61        72    1.0        64   -0.3       232    0.4       125    2.0
#> 62        74    0.8        74    1.8        20    0.2       156    0.4
#> 63        27   -1.0       295    0.2       128    1.1        63    1.9
#> 64         6    0.9        67   -0.7       265    0.2       146    0.6
#> 65         3    2.0         7    1.6        26   -2.3       346   -0.6
#> 66       183    0.6       102    0.2       128    1.4        44    1.9
#> 67       156    1.2        50    0.4       109    0.2       155    2.1
#> 68       187    0.1       168    0.7        80    1.5        41    1.6
#> 69       283    0.8        75    0.6        94    1.6        32    1.6
#> 70         8    0.7        94   -1.2       311    0.1       168    1.6
#> 71       182    0.7        88    1.7        21    1.1        62    0.2
#> 72        13   -0.1       186    1.0        56    0.4       136    0.0
#> 73       312   -0.5       238    0.8        75    2.0        18    2.4
#> 74       259    0.1       164    0.7        84    1.4        46    1.8
#> 75        58    1.7        19    0.1       181    0.7        96   -0.1
#> 76       127    0.4       113    1.4        30    1.4        45   -0.3
#> 77       114    0.4       118    0.8        71    1.4        49    0.4
#> 78       241   -0.8       269    0.3       119    1.2        55    3.2
#> 79        94   -0.5       239    0.2       128    1.7        29    1.2
#> 80       107    0.0       174    0.4       112    1.0        79    1.4
#> 81       188    0.2       130    0.4       106    1.0        78    1.7
#> 82        30    1.1        53    0.4       107   -0.3       219    0.2
#> 83       224    1.0        65    0.1       166    0.4       127    2.1
#> 84        15   -0.2       200    0.1       170   -0.4       229    1.4
#> 85       140    0.8        77    0.1       172    0.6       114    1.3
#> 86       179    0.0       181    0.2       128    1.4        48    1.7
#> 87        24   -0.3       213    0.3       120    1.4        50   -0.2
#> 88        51   -0.9       290    0.2       128    1.5        43    1.2
#> 89       244    0.1       158    0.6        90    1.3        54    1.6
#> 90        28    0.2       131    0.1       180    0.1       158    0.8
#> 91        58    1.8        15    1.6        25    0.4       128   -1.9
#> 92        91    1.4        33    1.1        53    1.0        80   -1.3
#> 93       128   -0.5       235    0.8        76    0.8        90    1.3
#> 94       126   -0.7       255    0.6        96    0.7       107    1.8
#> 95       170    1.2        46    0.8        70    1.1        66   -0.3
#> 96       207   -0.2       207    0.2       128    1.8        25    1.2
#> 97        90   -0.2       199    0.6        92    1.9        19   -0.3
#> 98       215    0.6        98    0.2       128    1.4        47    0.8
#> 99       153    0.2       135    1.2        49    0.7       105    0.5
#> 100      116    1.5        28    1.8        19    0.5       122   -1.6
#> 101      119    0.2       135    0.5        97    0.6       117    0.8
#> 102      102    0.5       108    1.9        15   -0.1       193   -0.3
#> 103      211    0.0       176    0.8        66    2.0        17    0.0
#> 104      146   -0.1       188    0.9        59    1.1        59    0.2
#> 105      155    0.1       167    0.6        93    0.2       143    1.4
#> 106      222    0.2       153    0.9        64    0.4       131    1.3
#> 107       52    1.6        23   -0.4       247   -0.8       256    0.8
#> 108       80    1.7        21    0.2       128   -0.1       201   -0.3
#> 109       87    1.4        39   -0.1       205    0.1       168    0.2
#> 110       41    0.6        99    0.2       128    0.2       157   -0.2
#> 111      237   -0.5       237    1.0        58    0.5       124    1.8
#> 112      144    0.1       161    0.2       128    0.9        88    0.6
#> 113      165    0.8        86   -0.5       252    0.8        94    1.1
#> 114      177    0.2       154    1.2        48    0.2       145    0.6
#> 115       23    0.8        76   -0.7       268    0.1       168   -0.2
#> 116      166    0.9        69    1.5        27    1.1        60   -1.6
#> 117      225    0.1       162    0.8        69    0.5       120    0.9
#> 118       57   -0.9       289   -0.4       246    1.1        66    1.1
#> 119      109   -0.1       195    0.0       196    1.1        66    0.5
#> 120      137    0.2       135    0.9        62   -0.9       271    1.4
#> 121      258   -0.4       228   -0.5       254    1.0        82    2.4
#> 122      121    0.8        85    0.1       176    0.1       168    0.4
#> 123      156    0.6       100   -0.3       226    0.9        87    0.4
#> 124       83    0.7        93    0.2       123    0.6       109   -0.8
#> 125      134    1.1        57    0.2       125    0.3       138   -0.4
#> 126      176   -0.8       269    0.8        67    0.7        97    0.8
#> 127       37    0.8        81   -0.8       272    0.1       161   -0.2
#> 128       77    1.2        45   -0.1       199   -0.3       211   -0.3
#> 129       96    1.2        46   -0.3       235   -0.1       200    0.0
#> 130      322    0.2       150   -0.1       203    1.1        66    1.5
#> 131      242    1.1        52    1.1        54    0.1       163   -0.3
#> 132      246   -0.4       230    0.4       113    0.6       110    1.3
#> 133      266   -0.8       279    0.2       128    0.3       141    2.4
#> 134      330   -0.7       254    0.2       127    1.3        53    1.9
#> 135      230    0.5       104    1.2        38   -0.4       225    0.4
#> 136      156    0.5       107   -0.3       229    0.1       168    1.0
#> 137      149    0.8        80    0.5        99    0.5       119   -0.8
#> 138       70    0.0       171   -0.6       263    0.1       168    0.8
#> 139      122    1.1        58    0.7        83   -1.4       309    0.4
#> 140      209    0.0       177   -0.2       215    0.9        89    0.8
#> 141      212    0.6       101    0.3       117   -0.5       235    1.1
#> 142      223   -0.3       218    0.0       189    0.5       121    1.4
#> 143      189    0.3       121    0.5       101    0.1       167    0.4
#> 144      117    0.4       119   -0.4       239   -0.2       207    0.9
#> 145      175   -0.1       193    0.1       167    0.7        99    0.4
#> 146       55    1.4        36   -0.8       271   -0.7       252    0.1
#> 147      305    0.0       175    0.2       128    0.6       116    1.4
#> 148      250    0.7        90    0.1       164    1.0        84   -0.2
#> 149       48    0.2       135    0.5        98   -0.4       221   -0.6
#> 150      267    0.2       149    0.1       177    1.1        66    0.4
#> 151       40    0.7        89    0.8        72   -1.5       310   -0.6
#> 152       14    1.5        25   -0.3       227    0.1       166   -2.6
#> 153       58    2.0         9    0.0       193   -1.5       318   -0.6
#> 154       58    0.8        73    0.1       160    0.1       159   -1.4
#> 155      309   -0.6       244    1.2        38    1.1        61    0.1
#> 156      338   -0.8       269   -0.3       237    1.1        66    2.4
#> 157      344   -0.1       197    0.2       128    1.0        81    1.5
#> 158      210   -0.1       190    1.2        38    0.2       154   -0.4
#> 159      251    0.9        68    0.4       110   -0.9       260    0.7
#> 160       98    0.8        79   -0.6       261   -0.9       271    0.7
#> 161       18   -0.6       251   -0.5       253   -0.9       259    0.4
#> 162      217    0.2       132   -0.1       208    0.1       168    0.7
#> 163      150   -0.3       219    0.0       185    0.1       185    0.6
#> 164      131    0.0       179   -0.2       214    0.4       129   -0.1
#> 165      306    0.2       135    0.8        77    1.1        66   -0.4
#> 166      108    0.1       166    0.1       174    0.6       108   -0.9
#> 167      337    0.2       135    1.9        13   -0.5       236    0.6
#> 168      115    0.0       180   -0.4       248    0.0       191    0.4
#> 169      196   -0.2       203   -0.2       220    0.6       115    0.4
#> 170       81    0.7        96   -0.3       225    0.7       106   -1.6
#> 171      227    0.2       135    1.2        37   -0.1       198   -0.6
#> 172      340   -0.8       269    0.3       122    0.8        93    1.9
#> 173      235   -0.5       234    1.2        38    0.8        91   -0.8
#> 174      350   -1.4       325    0.2       128    1.8        26    2.0
#> 175      283    0.9        72    1.6        24    0.8        92   -2.0
#> 176      156    1.4        37    1.9        14   -0.4       228   -2.6
#> 177      145   -0.2       205    0.1       162   -0.6       244    0.7
#> 178      269   -1.2       311   -0.3       228    0.7        98    1.7
#> 179       97    0.8        82   -0.1       204    0.1       168   -1.2
#> 180      208   -0.8       266    0.7        88    0.7       101   -0.2
#> 181      123   -0.2       210   -1.8       336    0.1       168    1.6
#> 182      125   -0.7       253    0.0       188   -0.6       247    1.0
#> 183       45   -0.8       277   -0.5       250   -0.3       217    0.3
#> 184      245   -0.1       194   -0.4       241    0.4       135    0.8
#> 185      193   -0.3       217   -0.1       202   -0.1       199    0.7
#> 186       56   -1.0       298   -0.4       240   -0.8       254    0.9
#> 187       85   -0.3       223   -0.5       251    0.1       168   -0.2
#> 188      124    0.1       169    0.2       128    0.2       144   -1.1
#> 189      315   -0.5       236    0.1       161   -0.1       196    1.4
#> 190       58    0.5       103    1.8        16    0.6       112   -4.2
#> 191      112   -0.4       227    0.2       128   -0.9       264    0.4
#> 192      213    0.4       110    0.6        91   -0.5       234   -0.4
#> 193      271   -0.1       189    0.3       116    0.7       102   -0.4
#> 194      201   -0.3       215   -0.7       266   -0.5       233    1.4
#> 195      156    1.4        30   -0.1       206   -0.5       239   -1.1
#> 196      173   -1.4       323    0.0       184    0.3       142    0.8
#> 197      256    0.2       135    0.5       102   -0.1       195   -0.3
#> 198      239    0.3       122    0.4       105    0.2       150   -0.8
#> 199      199    0.2       134   -0.3       230    0.2       149   -0.3
#> 200       58   -0.6       250    0.0       191   -1.3       295    0.4
#> 201      243    0.3       125    0.7        82   -0.5       240   -0.4
#> 202      252   -0.3       216   -0.2       219    0.1       160    0.5
#> 203      268   -1.1       308    0.2       128    0.4       126    0.7
#> 204      302   -1.7       336   -0.3       223    0.7       104    1.7
#> 205       76   -1.2       318   -0.5       257   -0.2       206    0.4
#> 206      195   -1.6       335    0.1       182   -0.3       213    1.4
#> 207      229   -0.6       246   -0.4       243    0.2       151    0.5
#> 208       26   -0.5       233    0.8        78   -0.9       261   -2.1
#> 209      169   -0.1       192   -0.1       201    0.1       168   -0.7
#> 210      142   -0.8       269    0.5       103    0.2       147   -1.0
#> 211      283    0.9        71    0.8        65   -0.4       223   -1.2
#> 212      178   -0.4       232   -0.7       269    0.0       192    0.4
#> 213      129   -0.2       208   -0.2       217   -0.8       258   -0.1
#> 214      148    0.3       123    0.2       128   -0.1       197   -1.6
#> 215      174    0.2       155   -0.2       213   -1.3       301    0.4
#> 216      167   -1.1       305    0.2       128    0.3       137   -0.5
#> 217      298   -1.1       304    0.2       128    1.5        40   -0.8
#> 218      325    0.0       182    1.1        50   -0.4       224   -0.6
#> 219      180   -1.0       293   -0.9       291   -0.6       243    1.4
#> 220       92    0.8        83   -0.2       212   -1.4       308   -1.0
#> 221      248    0.3       128    0.2       128    0.3       139   -1.4
#> 222      147   -0.3       220   -1.3       312   -0.5       238    0.6
#> 223      143    1.3        44   -0.3       236   -0.3       218   -2.2
#> 224      265    0.2       133   -0.6       260   -0.9       271    0.7
#> 225      141   -0.8       278   -0.8       272    0.0       187   -0.1
#> 226      194   -0.8       269   -0.2       218   -0.9       271    0.8
#> 227       99    1.4        31    0.4       111    0.2       152   -4.0
#> 228      257    0.2       135    0.1       163   -0.8       255   -0.3
#> 229      283   -0.7       256    0.6        89    0.0       189   -0.5
#> 230      202    0.2       135    0.1       169   -1.6       323    0.1
#> 231      118   -2.0       345   -0.9       292   -0.5       231    1.4
#> 232      111    0.2       135    0.5       104   -1.2       292   -1.4
#> 233      329   -0.6       248    0.2       159   -0.2       209    0.5
#> 234      324   -0.3       224    0.6        95    0.1       162   -0.5
#> 235      316   -1.8       338    0.1       179    0.6       113    0.8
#> 236      317   -1.0       291    0.2       128    0.0       190    0.4
#> 237      198    0.8        84   -0.9       293   -0.9       269   -0.3
#> 238      283    0.5       105    0.1       165   -0.9       267   -0.6
#> 239       93   -2.0       346   -1.3       315    0.1       168    0.7
#> 240      197   -1.3       321   -0.7       264    0.3       140    0.0
#> 241      164    0.7        87    0.4       114   -0.4       230   -2.6
#> 242      307   -1.5       332   -0.8       272    0.9        86    0.6
#> 243      272   -1.1       307   -0.3       233   -0.4       220    0.6
#> 244      264   -1.1       302   -0.6       259    0.6       111   -0.3
#> 245      283    0.4       117    0.2       158   -1.9       332    0.0
#> 246      283    0.4       114   -0.1       198   -0.2       203   -1.6
#> 247      206   -1.5       330   -0.8       285   -0.4       222    0.6
#> 248      216   -0.7       257   -1.3       316   -0.6       246    0.6
#> 249      204   -1.0       292   -0.9       297    0.1       168   -0.3
#> 250      214    0.1       163   -0.3       231   -1.5       312   -0.4
#> 251      138   -0.7       258   -0.8       287   -0.4       227   -0.9
#> 252      130   -1.0       297   -0.6       262   -0.2       205   -1.1
#> 253      313   -1.1       303    0.2       128    0.4       130   -0.9
#> 254      232    0.3       126   -0.7       267   -0.9       271   -0.8
#> 255       89   -1.2       313   -0.8       272   -0.1       194   -1.3
#> 256      103   -0.1       198   -0.9       294   -0.9       271   -1.2
#> 257      220   -0.9       288   -1.1       306    0.1       168   -0.3
#> 258      168    0.4       115   -0.9       296   -1.0       280   -1.2
#> 259      240   -0.8       267    0.8        79    0.1       164   -2.4
#> 260      260   -0.7       259    0.8        73   -0.1       202   -2.2
#> 261      181   -0.3       214    0.1       171   -0.5       237   -2.2
#> 262      276    0.1       160    0.2       124   -1.4       305   -1.2
#> 263      348   -0.9       285   -0.5       249    0.2       153    0.2
#> 264      172   -1.0       299   -1.7       332   -0.9       266    0.6
#> 265      171    0.2       156    0.1       168   -1.5       314   -1.9
#> 266      186   -0.6       245   -1.7       331   -1.2       289    0.4
#> 267      219    0.3       124   -1.5       322   -1.2       290   -0.4
#> 268      283    0.7        91    0.3       118   -0.7       249   -2.6
#> 269      331   -0.6       252   -0.8       270   -0.3       210   -0.2
#> 270       73   -1.8       344   -1.0       298   -1.3       298   -0.2
#> 271      218   -0.1       184    0.0       186   -0.7       251   -2.3
#> 272      236   -0.3       212    0.3       121   -1.3       299   -1.6
#> 273      282   -0.8       282    0.2       128   -0.3       214   -1.6
#> 274      228   -0.8       264   -1.0       305   -0.6       241   -0.7
#> 275      139    1.0        62   -0.2       210   -2.0       339   -2.6
#> 276       29    0.9        70   -0.8       272   -1.5       316   -3.9
#> 277      318   -0.1       183   -1.6       326   -0.3       216   -0.3
#> 278      341   -1.6       333   -0.4       238   -0.3       215    0.6
#> 279      262    0.7        97   -0.2       216   -1.7       327   -1.5
#> 280       71   -1.2       310   -1.4       321   -0.7       248   -1.2
#> 281      275    0.0       170    0.1       175   -1.4       303   -1.6
#> 282      185   -0.6       249   -0.8       272   -0.6       242   -1.7
#> 283      191   -0.3       221   -0.9       289   -1.9       335   -0.6
#> 284      283   -0.8       281   -0.1       207   -1.5       313   -0.6
#> 285      343   -1.8       338   -0.4       244   -0.6       245    0.7
#> 286      135   -1.4       327   -1.8       338   -1.4       306    0.3
#> 287       79   -1.0       294   -0.1       197   -1.1       283   -2.9
#> 288      253   -0.6       247   -0.8       272   -1.0       281   -1.1
#> 289      283   -0.3       225   -1.0       300   -1.3       293   -0.6
#> 290      344    0.2       135    0.7        81   -1.1       284   -2.1
#> 291      311   -1.5       329   -0.2       209   -0.9       262   -0.6
#> 292      332   -0.8       269    0.1       178   -1.9       333   -0.3
#> 293      203   -0.2       202   -2.2       348   -1.2       288   -0.6
#> 294      323   -0.2       206   -0.3       222   -0.7       250   -2.1
#> 295      303   -1.3       322   -1.0       301   -0.9       263   -0.3
#> 296      154   -2.4       350   -0.8       272   -0.9       268   -0.6
#> 297       39   -2.4       349   -1.9       342   -0.9       271   -1.0
#> 298      321   -1.8       337   -1.8       338   -0.3       212    0.4
#> 299      304   -0.6       243   -1.2       310   -1.4       304   -0.6
#> 300      344   -1.2       316   -0.8       272   -0.4       226   -0.4
#> 301      104    0.0       178   -0.8       272   -1.2       291   -3.3
#> 302      200   -2.2       348   -1.0       304   -0.8       257   -0.6
#> 303      283    0.5       106   -1.6       328   -1.9       334   -0.9
#> 304      352   -1.2       317   -0.8       272    0.0       186    0.0
#> 305      326   -1.4       328    0.0       190   -0.7       253   -1.5
#> 306      308   -1.4       324   -1.9       341   -0.9       271    0.3
#> 307      333   -1.6       334   -1.4       318   -0.9       265    0.3
#> 308      297   -1.5       331   -0.8       288   -1.5       315   -0.4
#> 309      105   -0.2       209   -2.0       344   -1.5       319   -2.0
#> 310      255    0.2       151   -1.0       302   -1.9       336   -1.8
#> 311       44   -1.2       315   -0.4       242   -2.9       351   -2.1
#> 312      277   -1.2       314   -1.0       303   -0.2       208   -2.1
#> 313      261   -0.9       286   -1.0       299   -1.5       317   -1.3
#> 314      278   -0.7       262   -1.4       319   -1.1       287   -1.4
#> 315      347   -0.8       269   -0.4       245   -0.2       204   -2.2
#> 316      249   -0.9       287   -0.9       290   -1.5       311   -1.8
#> 317      247   -1.2       319   -1.2       308   -1.7       325   -1.0
#> 318      314    0.2       135   -0.3       224   -2.9       350   -1.6
#> 319      233   -0.8       268   -1.5       325   -1.6       322   -1.4
#> 320      156    1.3        43   -1.3       314   -1.7       328   -4.1
#> 321      327   -1.0       296   -1.9       343   -1.9       336    0.4
#> 322      283   -0.1       191   -2.4       350   -1.8       329   -0.6
#> 323      226   -0.8       263   -1.2       309   -2.2       345   -1.2
#> 324      279   -1.1       309   -1.8       337   -1.3       297   -0.8
#> 325      319   -0.7       261   -1.5       323   -1.0       282   -1.6
#> 326      349   -0.8       280   -0.8       284    0.1       168   -2.6
#> 327      280   -1.2       320   -1.4       317   -1.1       286   -1.6
#> 328      328   -0.5       241   -0.3       234   -1.1       285   -3.1
#> 329      301   -1.0       301   -2.2       347   -1.4       307   -0.7
#> 330      120   -0.1       185   -2.0       345   -2.9       351   -2.0
#> 331      339   -1.8       338    0.0       192   -0.9       270   -2.1
#> 332      184    0.4       116   -2.8       352   -2.7       348   -1.6
#> 333      353   -1.8       338   -0.5       258   -0.5       232   -1.0
#> 334      270   -0.2       204   -0.2       221   -1.3       294   -4.3
#> 335      221   -2.4       352   -1.3       313   -1.4       302   -1.4
#> 336      234   -1.8       343   -1.4       320   -1.3       300   -1.9
#> 337      274   -0.4       231   -1.7       334   -1.9       336   -2.1
#> 338      152    0.3       127   -1.7       333   -2.2       343   -3.4
#> 339      273   -1.2       312   -0.9       295   -1.6       321   -2.7
#> 340      335   -0.9       284   -1.6       327   -1.3       296   -1.9
#> 341      238   -0.2       201   -3.7       353   -2.4       347   -0.6
#> 342       78   -0.8       265   -2.2       349   -2.2       344   -3.2
#> 343      254   -2.4       351   -1.9       340   -2.1       341   -0.6
#> 344      320   -1.4       326   -1.8       335   -1.8       331   -1.5
#> 345      263   -0.3       226   -1.1       307   -0.9       271   -4.6
#> 346      351   -1.8       338   -0.5       255   -2.1       342   -1.3
#> 347      299   -2.1       347   -2.1       346   -1.6       320   -1.2
#> 348      342   -1.0       300   -0.8       286   -1.8       330   -2.7
#> 349      334   -0.7       260   -1.5       324   -1.7       326   -2.9
#> 350      336   -0.9       283   -0.5       256   -2.1       340   -3.9
#> 351      300   -1.1       306   -1.6       330   -1.6       324   -4.1
#> 352      281   -0.5       242   -1.6       329   -2.8       349   -3.7
#> 353      310   -3.0       353   -2.7       351   -3.6       353   -3.1
#>     PG.Hgt.Rk Experience Experience.Rk Bench Bench.Rk Continuity Continuity.Rk
#> 1           1       1.41           210  38.5       24       41.4           222
#> 2          26       0.96           313  30.9      155       24.4           323
#> 3           7       2.06            50  23.6      313       23.4           331
#> 4          91       0.90           319  28.4      222       25.3           315
#> 5          70       2.17            30  33.0      107       68.9            23
#> 6          48       1.03           303  32.2      127       31.7           297
#> 7          33       1.65           138  22.6      320       55.3           115
#> 8           8       1.10           288  18.9      345       46.5           183
#> 9         177       1.37           222  30.8      156       48.3           173
#> 10          4       1.94            65  27.6      247       66.4            37
#> 11        116       1.34           232  18.0      349       40.7           231
#> 12         68       1.36           228  31.0      153       25.1           317
#> 13         25       2.18            28  24.7      295       68.3            25
#> 14         67       1.71           117  35.7       72       49.6           158
#> 15         83       2.15            36  36.6       53       75.4            10
#> 16         13       2.39            13  21.8      333       85.4             2
#> 17         90       1.51           180  32.5      121       57.5            87
#> 18         55       2.05            55  29.2      203       44.8           192
#> 19         69       1.44           202  37.1       42       53.0           133
#> 20         38       1.56           166  31.5      140       24.3           325
#> 21         24       1.57           164  32.6      118       42.5           209
#> 22         44       0.83           328  35.6       75       41.3           224
#> 23         23       2.42            10  25.2      290       55.5           114
#> 24         41       1.61           153  23.6      312       43.1           200
#> 25         22       1.54           170  35.8       67       40.2           236
#> 26         97       0.76           333  36.1       62       22.9           334
#> 27          6       0.99           309  34.4       87       19.2           340
#> 28        205       0.70           339  29.5      194       33.5           284
#> 29        129       2.03            58  32.1      129       38.0           249
#> 30         27       1.88            81  32.8      114       49.8           157
#> 31         13       1.12           284  25.7      281       36.8           259
#> 32          5       2.08            48  27.9      238       62.6            55
#> 33        217       1.06           297  35.8       68       54.2           122
#> 34         21       1.79            96  36.5       55       58.8            79
#> 35        101       2.13            40  30.2      171       63.1            54
#> 36         50       0.81           329  36.0       65       44.9           191
#> 37         12       2.08            47  32.3      125       66.8            33
#> 38          9       1.42           205  25.7      280       32.6           291
#> 39         13       1.73           113  33.9       94       42.5           211
#> 40         46       1.68           132  17.8      350       34.6           279
#> 41         96       0.49           347  31.9      133       16.8           346
#> 42         45       1.41           209  36.4       57       54.7           117
#> 43         13       1.53           175  22.4      325       56.3           102
#> 44        103       1.94            68  30.4      167       60.3            69
#> 45         13       1.16           275  28.1      235       46.2           184
#> 46         30       0.96           312  22.9      316       29.6           303
#> 47         63       1.60           155  21.9      330       32.8           289
#> 48         34       2.08            46  31.2      149       38.4           245
#> 49         62       1.59           159  22.5      323       41.5           221
#> 50        342       1.47           191  22.5      322       39.3           240
#> 51         70       1.36           225  25.0      293       51.9           142
#> 52         64       1.44           199  28.2      231       40.6           232
#> 53        168       1.66           136  29.0      204       46.5           182
#> 54         56       1.87            82  31.2      146       36.3           267
#> 55        172       1.54           172  29.4      196       35.6           273
#> 56         58       1.61           149  32.8      113       53.3           130
#> 57          3       1.82            91  27.1      257       66.9            32
#> 58         36       1.14           280  30.6      162       57.4            88
#> 59         13       1.50           183  30.5      165       24.4           322
#> 60        233       1.50           182  37.5       34       49.2           163
#> 61         31       1.41           208  22.8      317       28.8           306
#> 62        163       1.01           305  42.8        5       49.6           159
#> 63         37       1.87            83  37.5       36       21.6           337
#> 64        131       1.76           105  43.2        3       46.8           180
#> 65        233       1.47           192  30.0      181       52.9           134
#> 66         39       1.58           161  33.0      108       56.6            98
#> 67         29       1.61           151  17.7      351       56.9            94
#> 68         60       1.69           126  25.6      283       68.4            24
#> 69         54       1.60           154  38.9       21       32.3           293
#> 70         61       2.32            19  21.4      334       39.3           241
#> 71        171       1.44           200  32.0      132       54.5           119
#> 72        184       1.83            88  27.6      249       28.9           305
#> 73         11       1.16           273  27.0      260       36.4           263
#> 74         43       2.53             4  27.7      244       51.6           146
#> 75        189       2.15            35  27.8      243       66.6            34
#> 76        201       2.40            11  30.7      159       65.4            43
#> 77        161       1.62           144  32.5      122       56.7            97
#> 78          2       1.52           176  22.6      321       55.8           109
#> 79         89       1.48           186  31.7      137       49.0           165
#> 80         70       1.41           212  30.1      176       44.5           193
#> 81         53       1.46           195  29.5      195       32.9           288
#> 82        173       1.37           223  36.1       61       40.3           234
#> 83         28       1.57           165  31.9      135       71.1            17
#> 84         70       1.59           160  26.9      261       75.5             9
#> 85         85       1.11           286  27.6      250       38.6           244
#> 86         52       1.24           261  32.8      115       18.0           342
#> 87        193       1.94            67  18.8      347       51.2           150
#> 88         92       1.39           216  24.2      300       42.4           212
#> 89         59       1.27           252  25.6      282       32.1           294
#> 90        109       1.75           107  29.7      185       59.7            73
#> 91        312       2.06            52  26.5      267       64.5            49
#> 92        282       1.36           227  29.5      193       51.0           151
#> 93         86       1.09           290  32.9      110       43.0           205
#> 94         42       1.24           259  24.0      303       51.7           145
#> 95        204       1.31           242  27.8      242       41.0           228
#> 96         88       1.25           256  36.9       47       39.1           243
#> 97        215       2.05            54  18.8      346       77.1             7
#> 98        113       1.47           194  33.6       98       58.6            80
#> 99        140       1.52           177  32.5      120       50.3           156
#> 100       301       1.66           137  22.4      324       32.4           292
#> 101       111       1.11           287  30.1      174       37.4           254
#> 102       213       2.03            57  31.2      147       83.9             3
#> 103       185       1.23           263  32.2      128       47.4           176
#> 104       170       1.36           224  29.4      199       36.4           264
#> 105        70       1.62           146  33.5      100       67.7            28
#> 106        87       1.29           246  28.4      223       28.4           307
#> 107       112       1.84            87  37.5       35       44.1           195
#> 108       207       1.55           167  21.8      332       44.3           194
#> 109       174       1.42           207  30.1      177       47.4           177
#> 110       196       2.44             8  27.0      259       65.7            41
#> 111        47       1.79            99  36.9       46       28.3           308
#> 112       127       0.97           310  28.8      211       31.8           296
#> 113        95       2.02            59  34.4       89       63.1            53
#> 114       130       2.34            16  27.4      252       61.9            60
#> 115       190       2.29            22  35.7       71       59.7            74
#> 116       295       2.24            24  29.6      189       65.1            47
#> 117       102       1.70           121  33.2      103       51.6           147
#> 118        93       1.40           214  47.0        2       27.2           309
#> 119       142       2.16            32  19.9      342       67.4            30
#> 120        70       1.65           140  25.5      287       56.2           103
#> 121        13       0.66           342  31.9      134       16.9           345
#> 122       147       1.72           114  30.2      169       51.2           149
#> 123       148       1.62           148  33.1      105       48.6           168
#> 124       257       2.34            17  31.2      145       54.2           123
#> 125       218       2.13            39  25.1      292       50.9           153
#> 126       105       1.80            95  34.6       83       65.7            42
#> 127       195       2.17            31  28.9      209       68.1            27
#> 128       209       1.73           112  36.6       54       59.9            70
#> 129       181       1.90            76  26.6      265       47.6           175
#> 130        65       2.05            56  28.5      220       86.0             1
#> 131       203       1.87            84  34.0       92       57.2            90
#> 132        84       2.13            42  28.6      218       45.7           186
#> 133        13       1.50           181  30.1      179       57.7            84
#> 134        35       2.01            60  38.2       29       70.0            21
#> 135       146       2.12            43  23.8      310       75.8             8
#> 136        98       1.55           169  28.7      212       52.0           140
#> 137       258       2.42             9  33.9       93       63.5            52
#> 138       110       1.90            75  30.7      161       48.6           169
#> 139       149       1.88            79  34.5       86       66.2            38
#> 140       107       1.25           257  35.9       66       23.6           328
#> 141        94       1.28           249  28.1      232       39.9           238
#> 142        70       1.33           236  30.1      178        4.1           352
#> 143       149       1.38           218  28.1      234       36.1           269
#> 144       104       1.83            90  34.9       80       33.1           287
#> 145       149       1.18           269  29.0      205       38.3           246
#> 146       178       1.58           162  38.5       25       53.8           124
#> 147        70       1.72           116  28.6      216       55.7           110
#> 148       194       1.71           118  37.7       32       60.6            68
#> 149       233       2.14            37  32.9      111       65.7            40
#> 150       164       1.75           108  31.0      152       41.2           225
#> 151       233       1.16           276  36.5       56       52.4           137
#> 152       334       1.82            92  32.4      123       42.4           213
#> 153       233       2.10            45  20.2      341       70.5            19
#> 154       286       0.83           327  32.6      117       39.9           239
#> 155       176       1.48           189  22.3      326       34.0           283
#> 156        10       1.54           173  27.3      253       25.5           313
#> 157        66       1.73           110  22.7      318       52.6           136
#> 158       223       0.96           311  26.3      271       46.9           179
#> 159       118       1.37           221  34.4       88       45.2           190
#> 160       125       1.19           268  31.5      141       39.2           242
#> 161       149       1.83            89  28.7      213       69.1            22
#> 162       117       1.32           239  30.2      170       65.3            44
#> 163       134       2.50             6  31.3      143       64.3            50
#> 164       187       0.85           324  28.3      227       35.1           277
#> 165       225       0.60           345  28.9      208       23.5           330
#> 166       262       1.69           127  23.9      304       10.2           349
#> 167       137       2.31            20  26.4      269       72.3            14
#> 168       149       1.09           289  31.2      148       41.3           223
#> 169       144       1.40           215  38.3       28       35.9           271
#> 170       294       2.14            38  30.7      160       15.7           348
#> 171       231       1.15           277  30.4      166       57.5            86
#> 172        40       1.03           302  30.1      172       36.7           261
#> 173       254       1.58           163  31.8      136       43.2           199
#> 174        32       1.24           260  21.9      329       56.9            95
#> 175       315       2.18            29  23.8      307       73.0            12
#> 176       330       0.92           317  31.7      138       17.8           343
#> 177       121       0.93           316  24.1      301       36.3           266
#> 178        49       0.72           336  35.7       70       24.1           327
#> 179       273       1.07           296  27.9      239       42.6           208
#> 180       191       1.31           241  39.5       17       50.5           155
#> 181        57       1.76           104  26.1      274       57.1            93
#> 182        99       1.73           111  35.6       76       62.4            59
#> 183       165       0.88           321  38.4       26       49.3           162
#> 184       115       1.09           291  49.1        1       37.9           251
#> 185       124       1.61           152  30.5      163       59.7            72
#> 186       100       1.74           109  35.1       79       40.1           237
#> 187       198       1.98            63  31.0      154       59.2            77
#> 188       269       0.75           334  39.6       15       26.4           311
#> 189        70       2.06            51  28.9      210       75.1            11
#> 190       351       0.91           318  26.2      272       37.6           252
#> 191       149       2.13            41  25.9      278       63.8            51
#> 192       224       2.30            21  27.9      241       56.4           101
#> 193       221       1.33           235  39.6       14       44.0           196
#> 194        70       1.77           103  29.8      184       53.2           131
#> 195       270       2.05            53  25.9      277       61.6            62
#> 196       106       1.22           265  42.6        8       25.6           312
#> 197       200       1.27           250  34.7       81       68.2            26
#> 198       253       1.07           294  36.7       52       41.5           219
#> 199       206       1.63           142  26.4      270       42.4           214
#> 200       149       2.20            26  24.7      296       37.9           250
#> 201       220       0.71           337  39.2       18       35.7           272
#> 202       143       0.89           320  20.4      340       35.4           274
#> 203       122       1.79            97  30.1      175       53.5           128
#> 204        51       1.69           129  24.3      298       37.1           257
#> 205       149       1.53           174  27.9      240       53.4           129
#> 206        70       1.29           245  21.1      338       58.8            78
#> 207       141       1.70           122  37.2       41       72.3            15
#> 208       319       2.15            34  29.6      192       54.6           118
#> 209       251       0.08           352  40.3       13        5.9           351
#> 210       264       1.98            62  32.1      130       79.4             5
#> 211       276       2.36            14  35.8       69       57.2            91
#> 212       149       1.40           213  25.6      284       32.0           295
#> 213       188       2.15            33  27.7      246       81.0             4
#> 214       300       1.28           247  33.8       95       34.3           282
#> 215       149       1.55           168  29.3      201       55.7           111
#> 216       229       1.38           219  33.1      106       57.6            85
#> 217       255       1.35           231  29.3      200       20.6           339
#> 218       232       1.11           285  35.2       77       36.5           262
#> 219        70       1.99            61  28.1      233       61.3            64
#> 220       268       1.12           283  25.7      279        7.5           350
#> 221       288       1.29           244  35.6       74       41.5           220
#> 222       133       2.11            44  26.5      266       48.7           167
#> 223       323       0.46           350  37.3       40       23.5           329
#> 224       123       1.38           220  26.8      262       42.0           216
#> 225       186       1.35           229  28.5      221       43.0           204
#> 226       114       1.21           267  28.5      219       18.8           341
#> 227       348       1.61           150  23.9      305       53.1           132
#> 228       211       1.59           158  28.3      225       43.1           202
#> 229       228       1.94            66  23.8      308       40.8           229
#> 230       179       1.00           307  34.6       82       40.8           230
#> 231        70       1.28           248  33.1      104       38.2           247
#> 232       289       1.08           292  33.3      101       21.4           338
#> 233       139       1.91            73  34.5       84       37.2           256
#> 234       230       1.23           262  37.3       39       36.4           265
#> 235       108       1.88            80  19.4      343       55.5           113
#> 236       145       1.17           271  29.6      188       30.2           301
#> 237       202       1.16           272  30.8      157       37.5           253
#> 238       233       1.05           299  33.0      109       51.5           148
#> 239       119       1.75           106  29.2      202       50.9           152
#> 240       182       1.41           211  37.4       37       52.9           135
#> 241       330       1.33           234  37.5       33       46.6           181
#> 242       136       1.92            72  27.1      255       67.6            29
#> 243       138       2.06            49  29.7      187       57.3            89
#> 244       216       1.44           201  36.2       60       45.3           188
#> 245       183       1.70           123  27.2      254       48.4           172
#> 246       296       1.68           134  34.0       91       49.4           161
#> 247       135       1.24           258  29.4      197       51.7           143
#> 248       126       1.86            85  27.5      251       61.4            63
#> 249       208       0.74           335  22.1      327       25.2           316
#> 250       227       1.95            64  24.5      297       58.3            82
#> 251       261       1.39           217  30.5      164       33.3           285
#> 252       271       2.56             3  21.1      336       65.2            45
#> 253       263       1.91            74  29.7      186       70.7            18
#> 254       256       1.25           254  33.6       96       34.3           281
#> 255       284       1.78           100  32.8      116       66.6            35
#> 256       277       1.44           203  21.9      331       25.0           318
#> 257       214       1.68           131  37.3       38       48.8           166
#> 258       278       1.32           237  26.8      263       30.9           299
#> 259       328       1.51           178  29.0      206       48.6           170
#> 260       326       1.70           124  27.9      237       43.8           197
#> 261       324       0.79           330  22.6      319       24.9           319
#> 262       274       1.69           128  36.9       48       54.4           120
#> 263       175       1.65           139  28.2      230       65.1            46
#> 264       132       1.93            69  26.1      276       65.0            48
#> 265       309       0.99           308  39.6       16       37.4           255
#> 266       149       1.06           298  34.1       90       22.0           336
#> 267       222       1.30           243  32.6      119       41.2           226
#> 268       330       1.70           125  29.0      207       55.9           105
#> 269       197       0.70           340  32.9      112       22.7           335
#> 270       192       1.60           156  29.6      190       67.2            31
#> 271       327       0.84           326  38.7       23       36.7           260
#> 272       298       1.70           120  24.2      299       56.1           104
#> 273       297       1.64           141  25.5      286       43.3           198
#> 274       250       1.07           295  35.1       78       29.7           302
#> 275       330       1.60           157  26.1      273       43.1           201
#> 276       346       1.46           196  36.1       63       40.2           235
#> 277       212       1.35           230  28.7      214       55.0           116
#> 278       128       2.18            27  23.7      311       65.8            39
#> 279       293       0.84           325  36.8       50       31.1           298
#> 280       280       1.44           204  41.6       10       53.7           125
#> 281       299       1.34           233  25.5      285       48.2           174
#> 282       306       0.68           341  33.6       97       36.0           270
#> 283       233       1.13           281  36.9       45       42.5           210
#> 284       233       1.16           274  26.4      268       29.5           304
#> 285       120       2.51             5  19.2      344       53.6           126
#> 286       167       1.62           147  25.4      289       71.8            16
#> 287       337       1.49           185  28.0      236       55.8           108
#> 288       272       1.00           306  36.8       51       38.1           248
#> 289       233       1.88            78  26.7      264       59.9            71
#> 290       317       1.22           266  36.8       49       47.1           178
#> 291       233       0.70           338  37.9       31       33.1           286
#> 292       210       1.92            71  23.8      309       42.1           215
#> 293       233       1.72           115  28.3      226       49.4           160
#> 294       318       1.92            70  28.3      224       60.8            66
#> 295       199       0.63           344  41.8        9       30.7           300
#> 296       233       1.45           198  31.4      142       57.1            92
#> 297       267       1.15           279  26.1      275       50.8           154
#> 298       162       1.47           193  29.9      182       25.4           314
#> 299       233       1.90            77  24.0      302       62.6            56
#> 300       226       0.47           349  42.7        7       24.4           321
#> 301       343       2.39            12  29.4      198       66.5            36
#> 302       249       1.26           253  40.6       12       32.6           290
#> 303       260       1.77           102  29.8      183       42.0           217
#> 304       180       2.88             1  21.1      337       54.4           121
#> 305       291       2.32            18  14.2      353       60.8            65
#> 306       169       1.48           188  25.4      288       35.3           275
#> 307       166       0.87           322  42.8        4       49.1           164
#> 308       219       1.85            86  34.5       85       51.7           144
#> 309       313       0.86           323  39.0       20       16.4           347
#> 310       308       1.15           278  33.3      102       34.8           278
#> 311       321       1.71           119  28.7      215       59.3            76
#> 312       320       0.93           315  37.1       43       55.6           112
#> 313       283       1.77           101  32.4      124       41.9           218
#> 314       290       1.42           206  24.9      294       36.2           268
#> 315       325       1.12           282  31.3      144       40.3           233
#> 316       307       1.62           145  27.1      256       62.6            57
#> 317       266       1.51           179  28.2      228       55.9           106
#> 318       301       1.80            94  20.8      339       72.5            13
#> 319       285       0.78           331  32.3      126       45.3           189
#> 320       350       1.54           171  21.1      335       79.3             6
#> 321       149       1.79            98  25.1      291       56.6            99
#> 322       233       1.68           133  27.7      245       58.5            81
#> 323       279       1.67           135  33.6       99       35.2           276
#> 324       259       1.32           238  38.8       22       53.6           127
#> 325       301       1.46           197  27.0      258       42.8           206
#> 326       329       1.69           130  31.1      150       52.3           138
#> 327       301       2.35            15  32.0      131       56.8            96
#> 328       339       2.48             7  23.5      314       70.1            20
#> 329       252       1.62           143  18.2      348       36.9           258
#> 330       314       2.71             2  23.9      306       61.8            61
#> 331       322       1.22           264  38.1       30       48.5           171
#> 332       301       2.23            25  17.2      352       59.4            75
#> 333       265       1.27           251  30.2      168       58.0            83
#> 334       352       1.49           184  29.6      191       60.7            67
#> 335       287       1.02           304  36.2       58       45.3           187
#> 336       311       1.05           300  23.1      315       24.4           324
#> 337       316       2.25            23  30.0      180       62.6            58
#> 338       344       1.80            93  22.1      328       51.9           141
#> 339       335       1.48           187  40.8       11       55.9           107
#> 340       310       1.25           255  35.6       73       23.4           332
#> 341       233       0.77           332  30.1      173       27.1           310
#> 342       341       1.17           270  38.3       27       42.7           207
#> 343       233       0.49           348  31.6      139       23.0           333
#> 344       292       0.64           343  30.8      158       24.9           320
#> 345       353       0.56           346  39.1       19       24.2           326
#> 346       281       0.00           353  28.2      229        0.0             0
#> 347       275       1.32           240  36.2       59       41.2           227
#> 348       336       1.47           190  31.0      151       56.4           100
#> 349       338       0.94           314  27.6      248       52.0           139
#> 350       347       1.04           301  42.8        6       43.1           203
#> 351       349       1.36           226  28.6      217       45.9           185
#> 352       345       0.40           351  37.0       44       17.5           344
#> 353       340       1.07           293  36.0       64       34.5           280
#>     NCAA_Seed Year
#> 1           2 2020
#> 2          NA 2020
#> 3           1 2020
#> 4          NA 2020
#> 5           3 2020
#> 6          NA 2020
#> 7          NA 2020
#> 8           2 2020
#> 9          NA 2020
#> 10         11 2020
#> 11         NA 2020
#> 12          7 2020
#> 13         NA 2020
#> 14         NA 2020
#> 15         NA 2020
#> 16         NA 2020
#> 17         NA 2020
#> 18         12 2020
#> 19         10 2020
#> 20         NA 2020
#> 21         NA 2020
#> 22          3 2020
#> 23         NA 2020
#> 24          1 2020
#> 25         NA 2020
#> 26         NA 2020
#> 27         NA 2020
#> 28         NA 2020
#> 29          9 2020
#> 30         NA 2020
#> 31          4 2020
#> 32         NA 2020
#> 33         11 2020
#> 34          9 2020
#> 35         NA 2020
#> 36         NA 2020
#> 37         NA 2020
#> 38         NA 2020
#> 39         NA 2020
#> 40         NA 2020
#> 41         NA 2020
#> 42         NA 2020
#> 43         NA 2020
#> 44         NA 2020
#> 45         NA 2020
#> 46         NA 2020
#> 47         NA 2020
#> 48         NA 2020
#> 49         10 2020
#> 50          7 2020
#> 51         NA 2020
#> 52         NA 2020
#> 53          6 2020
#> 54          4 2020
#> 55         NA 2020
#> 56         NA 2020
#> 57         NA 2020
#> 58         NA 2020
#> 59         NA 2020
#> 60         NA 2020
#> 61         NA 2020
#> 62          6 2020
#> 63         NA 2020
#> 64         NA 2020
#> 65          6 2020
#> 66         NA 2020
#> 67         NA 2020
#> 68         NA 2020
#> 69         NA 2020
#> 70         NA 2020
#> 71          3 2020
#> 72         NA 2020
#> 73         NA 2020
#> 74          5 2020
#> 75         NA 2020
#> 76          8 2020
#> 77         NA 2020
#> 78          8 2020
#> 79         NA 2020
#> 80         NA 2020
#> 81         NA 2020
#> 82         NA 2020
#> 83         NA 2020
#> 84          7 2020
#> 85         NA 2020
#> 86         NA 2020
#> 87         NA 2020
#> 88          9 2020
#> 89         16 2020
#> 90         14 2020
#> 91         NA 2020
#> 92         NA 2020
#> 93         NA 2020
#> 94         NA 2020
#> 95         NA 2020
#> 96          7 2020
#> 97          3 2020
#> 98         NA 2020
#> 99         NA 2020
#> 100        NA 2020
#> 101        NA 2020
#> 102         8 2020
#> 103        NA 2020
#> 104         5 2020
#> 105        16 2020
#> 106        NA 2020
#> 107        14 2020
#> 108        12 2020
#> 109        NA 2020
#> 110        11 2020
#> 111        NA 2020
#> 112        NA 2020
#> 113         6 2020
#> 114         5 2020
#> 115        NA 2020
#> 116        NA 2020
#> 117        NA 2020
#> 118        NA 2020
#> 119        NA 2020
#> 120        NA 2020
#> 121        NA 2020
#> 122        NA 2020
#> 123        NA 2020
#> 124         9 2020
#> 125        NA 2020
#> 126        13 2020
#> 127         4 2020
#> 128        NA 2020
#> 129        NA 2020
#> 130        NA 2020
#> 131        10 2020
#> 132        NA 2020
#> 133        NA 2020
#> 134        NA 2020
#> 135         8 2020
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
#> 149         4 2020
#> 150        NA 2020
#> 151        NA 2020
#> 152        NA 2020
#> 153        NA 2020
#> 154        NA 2020
#> 155        NA 2020
#> 156        10 2020
#> 157        NA 2020
#> 158        NA 2020
#> 159        NA 2020
#> 160        NA 2020
#> 161        NA 2020
#> 162        NA 2020
#> 163        NA 2020
#> 164        NA 2020
#> 165        NA 2020
#> 166        NA 2020
#> 167        NA 2020
#> 168        NA 2020
#> 169        NA 2020
#> 170        NA 2020
#> 171        NA 2020
#> 172        NA 2020
#> 173        NA 2020
#> 174        NA 2020
#> 175        NA 2020
#> 176        NA 2020
#> 177        NA 2020
#> 178        NA 2020
#> 179        NA 2020
#> 180        NA 2020
#> 181         1 2020
#> 182        NA 2020
#> 183        11 2020
#> 184        NA 2020
#> 185         5 2020
#> 186        NA 2020
#> 187        NA 2020
#> 188        NA 2020
#> 189        NA 2020
#> 190        15 2020
#> 191         1 2020
#> 192        NA 2020
#> 193        NA 2020
#> 194        NA 2020
#> 195        NA 2020
#> 196        NA 2020
#> 197        NA 2020
#> 198        16 2020
#> 199        NA 2020
#> 200         2 2020
#> 201        NA 2020
#> 202        NA 2020
#> 203        NA 2020
#> 204        NA 2020
#> 205        NA 2020
#> 206        NA 2020
#> 207        NA 2020
#> 208        14 2020
#> 209        NA 2020
#> 210        15 2020
#> 211        NA 2020
#> 212        NA 2020
#> 213        NA 2020
#> 214        NA 2020
#> 215        NA 2020
#> 216        NA 2020
#> 217        NA 2020
#> 218        NA 2020
#> 219        NA 2020
#> 220        NA 2020
#> 221        NA 2020
#> 222        NA 2020
#> 223        NA 2020
#> 224        15 2020
#> 225        13 2020
#> 226        NA 2020
#> 227        13 2020
#> 228        NA 2020
#> 229        NA 2020
#> 230        NA 2020
#> 231        NA 2020
#> 232        NA 2020
#> 233        NA 2020
#> 234        12 2020
#> 235         2 2020
#> 236        NA 2020
#> 237        NA 2020
#> 238        NA 2020
#> 239        NA 2020
#> 240        NA 2020
#> 241        NA 2020
#> 242        NA 2020
#> 243        NA 2020
#> 244        NA 2020
#> 245        NA 2020
#> 246        NA 2020
#> 247        NA 2020
#> 248        NA 2020
#> 249        NA 2020
#> 250        NA 2020
#> 251        NA 2020
#> 252        NA 2020
#> 253        NA 2020
#> 254        NA 2020
#> 255        NA 2020
#> 256        NA 2020
#> 257        NA 2020
#> 258        NA 2020
#> 259        NA 2020
#> 260        NA 2020
#> 261        NA 2020
#> 262        13 2020
#> 263        NA 2020
#> 264        NA 2020
#> 265        NA 2020
#> 266        NA 2020
#> 267        NA 2020
#> 268        NA 2020
#> 269        NA 2020
#> 270        11 2020
#> 271        NA 2020
#> 272        NA 2020
#> 273        NA 2020
#> 274        NA 2020
#> 275        NA 2020
#> 276        NA 2020
#> 277        NA 2020
#> 278        NA 2020
#> 279        NA 2020
#> 280        NA 2020
#> 281        NA 2020
#> 282        NA 2020
#> 283        NA 2020
#> 284        NA 2020
#> 285        NA 2020
#> 286        NA 2020
#> 287        NA 2020
#> 288        NA 2020
#> 289        NA 2020
#> 290        NA 2020
#> 291        NA 2020
#> 292        NA 2020
#> 293        NA 2020
#> 294        NA 2020
#> 295        NA 2020
#> 296        NA 2020
#> 297        NA 2020
#> 298        NA 2020
#> 299        NA 2020
#> 300        NA 2020
#> 301        11 2020
#> 302        NA 2020
#> 303        NA 2020
#> 304        NA 2020
#> 305        14 2020
#> 306        NA 2020
#> 307        16 2020
#> 308        NA 2020
#> 309        NA 2020
#> 310        NA 2020
#> 311        NA 2020
#> 312        NA 2020
#> 313        NA 2020
#> 314        NA 2020
#> 315        NA 2020
#> 316        NA 2020
#> 317        NA 2020
#> 318        NA 2020
#> 319        NA 2020
#> 320        NA 2020
#> 321        NA 2020
#> 322        16 2020
#> 323        NA 2020
#> 324        NA 2020
#> 325        NA 2020
#> 326        NA 2020
#> 327        NA 2020
#> 328        12 2020
#> 329        NA 2020
#> 330        NA 2020
#> 331        NA 2020
#> 332        NA 2020
#> 333        NA 2020
#> 334        NA 2020
#> 335        NA 2020
#> 336        NA 2020
#> 337        NA 2020
#> 338        NA 2020
#> 339        NA 2020
#> 340        16 2020
#> 341        NA 2020
#> 342        NA 2020
#> 343        NA 2020
#> 344        NA 2020
#> 345        NA 2020
#> 346        NA 2020
#> 347        NA 2020
#> 348        15 2020
#> 349        NA 2020
#> 350        NA 2020
#> 351        NA 2020
#> 352        NA 2020
#> 353        NA 2020
# }
```
