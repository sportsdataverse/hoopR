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
#> ✖ 2026-06-13 03:07:45.132227: Invalid arguments or no efficiency data for 2020 - 2021 available!
#> ✖ Args: min_year = 2020, max_year = 2021
#> ✖ Error: subscript out of bounds
#>                       Team Conf AdjT AdjT.Rk RawT RawT.Rk AvgPossLengthOff
#> 1   Mississippi Valley St. SWAC 77.1       1 78.9       1             15.6
#> 2          Houston Baptist Slnd 76.1       2 77.9       2             14.8
#> 3                 Marshall CUSA 74.9       3 75.2       7             14.8
#> 4                  Alabama  SEC 74.8       4 76.1       4             15.2
#> 5             Delaware St. MEAC 74.7       5 76.2       3             15.3
#> 6         Eastern Kentucky  OVC 74.5       6 75.6       6             15.8
#> 7                Green Bay Horz 74.0       7 74.2      14             14.4
#> 8                  Buffalo  MAC 73.9       8 74.6       8             14.9
#> 9       North Carolina A&T MEAC 73.7       9 74.6       9             16.0
#> 10             The Citadel   SC 73.7      10 74.3      13             15.9
#> 11        Central Michigan  MAC 73.6      11 74.4      11             15.6
#> 12              Coppin St. MEAC 73.4      12 74.4      10             15.4
#> 13            San Jose St.  MWC 73.3      13 74.0      19             16.3
#> 14             Arizona St.  P12 73.2      14 73.6      23             15.8
#> 15        Central Arkansas Slnd 73.2      15 75.9       5             15.8
#> 16                Nebraska  B10 73.1      16 72.8      33             15.1
#> 17          South Carolina  SEC 73.1      17 72.5      37             15.3
#> 18      Eastern Washington BSky 73.1      18 73.6      24             15.3
#> 19             Georgia St.   SB 73.0      19 73.7      21             15.8
#> 20         Bethune Cookman MEAC 73.0      20 74.0      18             15.6
#> 21              St. John's   BE 72.9      21 74.1      16             15.5
#> 22          Texas Southern SWAC 72.9      22 74.4      12             16.0
#> 23                     LIU  NEC 72.8      23 73.3      26             16.1
#> 24                    UTSA CUSA 72.8      24 73.0      30             16.2
#> 25                 Samford   SC 72.8      25 74.0      17             15.9
#> 26        Coastal Carolina   SB 72.8      26 73.3      27             16.4
#> 27                Monmouth MAAC 72.6      27 72.0      44             15.6
#> 28                 Memphis Amer 72.6      28 73.1      29             15.6
#> 29        Northwestern St. Slnd 72.4      29 74.1      15             16.3
#> 30                     FIU CUSA 72.2      30 72.5      38             15.2
#> 31              Wright St. Horz 72.1      31 73.1      28             15.7
#> 32           James Madison  CAA 72.1      32 71.6      57             15.8
#> 33  Southeastern Louisiana Slnd 72.1      33 73.9      20             15.8
#> 34                    Duke  ACC 72.0      34 72.8      31             16.2
#> 35                 Gonzaga  WCC 71.9      35 72.6      36             15.2
#> 36                Winthrop BSth 71.9      36 71.7      55             15.4
#> 37               Louisiana   SB 71.8      37 72.4      39             16.7
#> 38              New Mexico  MWC 71.8      38 72.6      35             16.3
#> 39       Stephen F. Austin Slnd 71.8      39 73.7      22             16.4
#> 40            Portland St. BSky 71.8      40 71.8      50             16.4
#> 41        Georgia Southern   SB 71.8      41 72.7      34             15.8
#> 42             Santa Clara  WCC 71.6      42 72.8      32             15.3
#> 43        Western Carolina   SC 71.5      43 72.3      41             16.7
#> 44        Western Illinois  Sum 71.3      44 72.0      45             17.1
#> 45                Arkansas  SEC 71.2      45 71.4      61             16.7
#> 46            Rhode Island  A10 71.2      46 71.9      47             16.1
#> 47          Saint Joseph's  A10 71.2      47 71.2      66             16.5
#> 48         Sam Houston St. Slnd 71.1      48 73.4      25             16.0
#> 49                   Rider MAAC 71.1      49 71.8      52             16.6
#> 50                  Nevada  MWC 71.0      50 71.7      56             16.3
#> 51           UNC Asheville BSth 71.0      51 70.8      79             16.5
#> 52               Loyola MD  Pat 71.0      52 71.2      68             16.7
#> 53                  Denver  Sum 70.9      53 71.5      60             16.5
#> 54                Penn St.  B10 70.9      54 71.4      62             16.2
#> 55          Long Beach St.   BW 70.9      55 71.3      64             16.6
#> 56                 Hampton BSth 70.9      56 70.7      86             16.5
#> 57              Pepperdine  WCC 70.8      57 71.8      51             15.8
#> 58                   IUPUI Horz 70.8      58 71.2      70             16.5
#> 59          Washington St.  P12 70.8      59 71.1      71             16.7
#> 60               Marquette   BE 70.7      60 71.4      63             16.5
#> 61        Prairie View A&M SWAC 70.7      61 72.4      40             16.3
#> 62           East Carolina Amer 70.6      62 70.7      87             16.6
#> 63                  DePaul   BE 70.6      63 71.7      53             15.5
#> 64                 Georgia  SEC 70.5      64 71.9      48             16.3
#> 65                 Belmont  OVC 70.5      65 72.3      42             15.7
#> 66    UT Rio Grande Valley  WAC 70.4      66 70.5      99             15.9
#> 67          North Carolina  ACC 70.4      67 70.4     106             16.6
#> 68            Oral Roberts  Sum 70.4      68 71.8      49             16.1
#> 69             Utah Valley  WAC 70.4      69 70.3     111             16.8
#> 70          St. Francis NY  NEC 70.3      70 70.6      92             17.1
#> 71                  Bryant  NEC 70.3      71 70.2     116             17.2
#> 72            UMass Lowell   AE 70.3      72 70.8      78             16.2
#> 73                  Temple Amer 70.3      73 70.6      89             16.1
#> 74      Cal St. Northridge   BW 70.3      74 70.9      74             16.9
#> 75                  Howard MEAC 70.2      75 71.9      46             16.9
#> 76                    Penn  Ivy 70.2      76 71.0      72             16.8
#> 77                    Iowa  B10 70.2      77 70.6      93             16.2
#> 78               San Diego  WCC 70.2      78 70.7      85             17.0
#> 79             Wake Forest  ACC 70.1      79 70.8      81             16.6
#> 80                    Rice CUSA 70.1      80 71.3      65             16.9
#> 81           Bowling Green  MAC 70.1      81 70.9      76             16.6
#> 82              Alcorn St. SWAC 70.1      82 72.1      43             16.8
#> 83           North Alabama ASun 70.1      83 69.8     124             16.9
#> 84                     LSU  SEC 70.0      84 70.8      80             16.8
#> 85            South Dakota  Sum 70.0      85 71.0      73             16.8
#> 86                Canisius MAAC 70.0      86 70.3     110             17.1
#> 87              Georgetown   BE 70.0      87 71.6      58             15.9
#> 88            Georgia Tech  ACC 70.0      88 70.5      96             17.0
#> 89             Florida St.  ACC 69.9      89 69.6     139             16.7
#> 90                Iowa St.  B12 69.9      90 70.4     102             16.4
#> 91                 Seattle  WAC 69.9      91 70.4     103             17.4
#> 92             Stony Brook   AE 69.8      92 69.8     128             17.0
#> 93              Seton Hall   BE 69.8      93 70.9      75             16.9
#> 94             New Orleans Slnd 69.8      94 71.7      54             16.4
#> 95        Middle Tennessee CUSA 69.8      95 70.5      94             16.5
#> 96              Washington  P12 69.8      96 70.3     113             16.1
#> 97             Alabama St. SWAC 69.7      97 70.8      83             17.0
#> 98                Oklahoma  B12 69.6      98 69.7     135             16.2
#> 99                   Lamar Slnd 69.6      99 71.2      67             16.6
#> 100             Morgan St. MEAC 69.6     100 70.9      77             17.1
#> 101            Wichita St. Amer 69.5     101 70.6      88             17.3
#> 102              Milwaukee Horz 69.5     102 70.3     112             16.6
#> 103             N.C. State  ACC 69.5     103 70.6      91             16.6
#> 104    Central Connecticut  NEC 69.5     104 70.5      97             16.8
#> 105       Illinois Chicago Horz 69.5     105 70.6      90             17.3
#> 106                   Army  Pat 69.5     106 69.7     132             15.8
#> 107               Bucknell  Pat 69.5     107 69.8     126             16.5
#> 108                    BYU  WCC 69.5     108 69.7     133             17.0
#> 109             Vanderbilt  SEC 69.4     109 70.0     120             17.8
#> 110                  Akron  MAC 69.4     110 70.1     118             16.4
#> 111          North Florida ASun 69.4     111 69.2     161             16.7
#> 112          West Virginia  B12 69.4     112 69.4     148             17.5
#> 113                  Brown  Ivy 69.4     113 69.9     121             17.3
#> 114      Cal St. Fullerton   BW 69.3     114 69.2     168             16.6
#> 115                Arizona  P12 69.3     115 70.3     109             16.3
#> 116           Colorado St.  MWC 69.3     116 69.7     134             16.7
#> 117                Detroit Horz 69.3     117 70.5      95             17.6
#> 118          Southern Utah BSky 69.3     118 69.5     147             17.1
#> 119                   Troy   SB 69.3     119 70.4     108             17.1
#> 120         Boston College  ACC 69.3     120 69.6     138             17.1
#> 121          Tennessee St.  OVC 69.3     121 70.4     104             17.1
#> 122               Portland  WCC 69.3     122 70.2     115             16.8
#> 123             Valparaiso  MVC 69.3     123 69.2     164             16.6
#> 124               Richmond  A10 69.3     124 69.3     159             16.7
#> 125            Little Rock   SB 69.3     125 70.2     117             17.6
#> 126         Nebraska Omaha  Sum 69.2     126 70.8      82             16.6
#> 127                 Auburn  SEC 69.2     127 70.5     100             16.4
#> 128            USC Upstate BSth 69.2     128 69.3     156             17.8
#> 129       Eastern Illinois  OVC 69.1     129 70.4     101             17.4
#> 130           Michigan St.  B10 69.1     130 69.3     157             16.6
#> 131               La Salle  A10 69.1     131 69.7     129             17.3
#> 132               Columbia  Ivy 69.1     132 69.4     151             16.7
#> 133              Boise St.  MWC 69.1     133 69.7     131             17.0
#> 134                    VCU  A10 69.0     134 69.2     162             16.0
#> 135            Chicago St.  WAC 69.0     135 69.4     150             17.9
#> 136       SIU Edwardsville  OVC 69.0     136 69.9     122             17.4
#> 137            McNeese St. Slnd 69.0     137 71.2      69             17.3
#> 138         St. Francis PA  NEC 68.9     138 69.7     130             16.3
#> 139                    USC  P12 68.9     139 70.0     119             16.9
#> 140                  Idaho BSky 68.9     140 69.0     175             17.5
#> 141             Quinnipiac MAAC 68.9     141 68.9     184             17.1
#> 142    Fairleigh Dickinson  NEC 68.9     142 69.0     174             16.8
#> 143               Kent St.  MAC 68.9     143 69.6     140             17.3
#> 144             Murray St.  OVC 68.9     144 69.5     143             17.0
#> 145           North Dakota  Sum 68.9     145 70.2     114             17.9
#> 146       Florida Atlantic CUSA 68.8     146 69.6     141             16.1
#> 147              Air Force  MWC 68.8     147 68.9     183             17.6
#> 148                Harvard  Ivy 68.8     148 68.8     186             16.9
#> 149       Tennessee Martin  OVC 68.7     149 69.7     136             18.1
#> 150               Michigan  B10 68.7     150 69.4     152             17.1
#> 151          Grambling St. SWAC 68.7     151 70.5      98             17.0
#> 152           Sacred Heart  NEC 68.7     152 69.5     145             17.8
#> 153               Lipscomb ASun 68.7     153 68.1     232             17.4
#> 154                 Tulane Amer 68.7     154 69.4     154             16.7
#> 155          San Francisco  WCC 68.7     155 69.0     176             17.0
#> 156                   Iona MAAC 68.7     156 68.6     203             17.0
#> 157            Jackson St. SWAC 68.7     157 70.4     107             17.5
#> 158           Nicholls St. Slnd 68.7     158 71.5      59             17.1
#> 159               American  Pat 68.7     159 68.9     181             17.9
#> 160            Florida A&M MEAC 68.6     160 70.8      84             17.3
#> 161          Massachusetts  A10 68.6     161 69.2     169             18.0
#> 162            Cal Baptist  WAC 68.6     162 69.4     149             16.7
#> 163          New Hampshire   AE 68.6     163 69.5     146             18.1
#> 164             Binghamton   AE 68.6     164 68.9     182             17.4
#> 165         UNC Wilmington  CAA 68.5     165 68.4     216             16.8
#> 166                 Albany   AE 68.5     166 69.4     153             17.6
#> 167            Connecticut Amer 68.5     167 69.0     179             17.5
#> 168                Colgate  Pat 68.5     168 68.6     201             17.2
#> 169           Illinois St.  MVC 68.5     169 68.2     229             16.4
#> 170                 Hawaii   BW 68.4     170 69.1     172             17.9
#> 171             Providence   BE 68.4     171 69.6     142             17.3
#> 172      Abilene Christian Slnd 68.4     172 70.4     105             17.0
#> 173           Oklahoma St.  B12 68.4     173 68.4     214             17.3
#> 174                 Lehigh  Pat 68.4     174 68.7     199             17.7
#> 175               Cal Poly   BW 68.3     175 68.2     228             17.6
#> 176       Western Kentucky CUSA 68.3     176 69.5     144             17.3
#> 177             Holy Cross  Pat 68.3     177 68.7     195             17.9
#> 178              Creighton   BE 68.3     178 69.8     127             16.5
#> 179               Syracuse  ACC 68.3     179 68.4     220             16.8
#> 180               Miami FL  ACC 68.3     180 68.7     193             18.1
#> 181           Missouri St.  MVC 68.3     181 68.6     207             17.6
#> 182               Delaware  CAA 68.3     182 68.5     209             17.5
#> 183               Stanford  P12 68.3     183 68.7     194             17.4
#> 184               Hartford   AE 68.2     184 68.5     211             18.2
#> 185                Montana BSky 68.2     185 69.2     163             17.0
#> 186           Kennesaw St. ASun 68.2     186 68.1     230             18.3
#> 187                 Furman   SC 68.2     187 69.2     166             17.2
#> 188               Colorado  P12 68.2     188 68.1     231             17.5
#> 189       Jacksonville St.  OVC 68.1     189 69.1     171             18.2
#> 190             Notre Dame  ACC 68.1     190 69.0     177             16.8
#> 191                 Xavier   BE 68.1     191 69.2     167             17.7
#> 192                 Mercer   SC 68.1     192 69.8     125             17.5
#> 193                 Toledo  MAC 68.1     193 69.3     160             17.2
#> 194               UC Davis   BW 68.0     194 67.8     241             17.3
#> 195                   Ohio  MAC 68.0     195 68.8     189             18.1
#> 196            Mississippi  SEC 68.0     196 68.8     191             17.4
#> 197          Saint Peter's MAAC 68.0     197 68.6     204             17.8
#> 198           Grand Canyon  WAC 68.0     198 67.5     254             17.8
#> 199             Cincinnati Amer 68.0     199 68.8     185             17.0
#> 200               Ball St.  MAC 68.0     200 69.1     173             17.9
#> 201       South Dakota St.  Sum 68.0     201 69.8     123             17.1
#> 202                Hofstra  CAA 67.9     202 68.4     221             16.8
#> 203                    VMI   SC 67.9     203 68.7     196             16.9
#> 204                  Drake  MVC 67.9     204 67.3     262             17.8
#> 205      Purdue Fort Wayne  Sum 67.9     205 68.9     180             16.9
#> 206                Indiana  B10 67.9     206 68.7     200             17.5
#> 207               Longwood BSth 67.8     207 68.5     213             16.8
#> 208                    UCF Amer 67.8     208 68.7     197             17.6
#> 209            Austin Peay  OVC 67.8     209 69.1     170             17.6
#> 210         UNC Greensboro   SC 67.8     210 68.6     205             17.0
#> 211               Duquesne  A10 67.8     211 67.7     247             17.9
#> 212              UC Irvine   BW 67.7     212 68.4     218             17.5
#> 213            Alabama A&M SWAC 67.7     213 69.6     137             17.5
#> 214           UT Arlington   SB 67.7     214 68.7     198             17.2
#> 215               Kentucky  SEC 67.7     215 68.5     212             17.4
#> 216              Weber St. BSky 67.6     216 67.9     236             17.9
#> 217             Evansville  MVC 67.6     217 67.8     243             18.1
#> 218 Southeast Missouri St.  OVC 67.6     218 68.6     202             16.9
#> 219            Saint Louis  A10 67.6     219 68.4     215             17.5
#> 220                 Dayton  A10 67.6     220 68.0     233             17.1
#> 221 Maryland Eastern Shore MEAC 67.5     221 69.3     158             17.9
#> 222         William & Mary  CAA 67.5     222 67.9     239             18.2
#> 223                 Wagner  NEC 67.5     223 68.8     192             18.1
#> 224                   UTEP CUSA 67.5     224 68.4     219             17.4
#> 225            Norfolk St. MEAC 67.5     225 69.3     155             17.5
#> 226     South Carolina St. MEAC 67.4     226 69.2     165             18.3
#> 227                   Yale  Ivy 67.4     227 67.9     237             18.2
#> 228       Western Michigan  MAC 67.4     228 68.4     217             17.8
#> 229               Utah St.  MWC 67.4     229 68.0     234             17.3
#> 230              Idaho St. BSky 67.4     230 67.6     250             18.3
#> 231                Rutgers  B10 67.4     231 67.6     253             17.4
#> 232           Morehead St.  OVC 67.3     232 68.8     188             17.4
#> 233                 Kansas  B12 67.3     233 67.6     248             17.0
#> 234            Montana St. BSky 67.3     234 67.8     242             17.6
#> 235                 Drexel  CAA 67.3     235 67.7     244             18.4
#> 236             Texas Tech  B12 67.3     236 68.3     223             17.4
#> 237           Arkansas St.   SB 67.3     237 68.3     225             17.0
#> 238          Southern Miss CUSA 67.2     238 68.2     226             18.2
#> 239             Kansas St.  B12 67.2     239 67.3     267             17.5
#> 240        Appalachian St.   SB 67.2     240 68.3     222             17.2
#> 241          Cleveland St. Horz 67.1     241 69.0     178             17.9
#> 242             Louisville  ACC 67.1     242 67.2     269             17.3
#> 243               Miami OH  MAC 67.1     243 68.8     190             17.8
#> 244                Bradley  MVC 67.1     244 67.1     271             17.4
#> 245               Maryland  B10 67.0     245 67.6     249             17.6
#> 246           George Mason  A10 67.0     246 67.4     261             17.9
#> 247                   UNLV  MWC 67.0     247 67.3     266             18.0
#> 248            Chattanooga   SC 67.0     248 68.2     227             18.1
#> 249                   NJIT ASun 66.9     249 66.6     291             18.2
#> 250    Charleston Southern BSth 66.9     250 67.9     238             17.7
#> 251              Lafayette  Pat 66.9     251 67.5     255             17.8
#> 252         Tennessee Tech  OVC 66.9     252 68.5     210             17.5
#> 253           Presbyterian BSth 66.9     253 67.0     279             18.4
#> 254       Eastern Michigan  MAC 66.8     254 67.7     245             17.3
#> 255                   UMBC   AE 66.8     255 67.3     265             17.5
#> 256               Southern SWAC 66.8     256 68.5     208             18.0
#> 257              Minnesota  B10 66.8     257 67.3     264             17.9
#> 258                Wyoming  MWC 66.7     258 67.4     260             18.0
#> 259           Northwestern  B10 66.7     259 66.7     287             17.6
#> 260                   Utah  P12 66.7     260 67.6     252             18.1
#> 261                  Siena MAAC 66.7     261 67.2     270             17.6
#> 262           Jacksonville ASun 66.6     262 66.7     285             17.7
#> 263 North Carolina Central MEAC 66.6     263 68.8     187             17.2
#> 264      George Washington  A10 66.6     264 66.7     283             18.9
#> 265       Northern Arizona BSky 66.6     265 67.1     273             18.2
#> 266         Louisiana Tech CUSA 66.5     266 67.7     246             17.7
#> 267               Missouri  SEC 66.5     267 67.0     277             17.7
#> 268           Old Dominion CUSA 66.4     268 67.5     257             18.2
#> 269         Youngstown St. Horz 66.4     269 68.0     235             17.9
#> 270            Indiana St.  MVC 66.4     270 66.2     305             18.4
#> 271             High Point BSth 66.4     271 67.0     275             18.7
#> 272      Boston University  Pat 66.3     272 66.5     299             17.9
#> 273                Vermont   AE 66.3     273 66.5     298             18.1
#> 274              Princeton  Ivy 66.3     274 67.1     272             18.1
#> 275              Villanova   BE 66.2     275 67.6     251             18.1
#> 276        Mississippi St.  SEC 66.2     276 67.3     263             18.2
#> 277                 Baylor  B12 66.2     277 66.6     289             18.2
#> 278                   Elon  CAA 66.2     278 66.5     301             18.0
#> 279           Gardner Webb BSth 66.2     279 66.8     281             17.9
#> 280               Ohio St.  B10 66.2     280 66.7     286             18.1
#> 281     East Tennessee St.   SC 66.1     281 67.5     258             18.2
#> 282          Robert Morris  NEC 66.1     282 67.1     274             17.4
#> 283         Incarnate Word Slnd 66.1     283 68.6     206             18.4
#> 284    Arkansas Pine Bluff SWAC 66.1     284 67.5     259             18.9
#> 285                Oakland Horz 66.1     285 67.2     268             18.8
#> 286     Florida Gulf Coast ASun 66.1     286 66.2     307             18.5
#> 287       North Dakota St.  Sum 66.0     287 67.5     256             18.7
#> 288               Illinois  B10 66.0     288 67.0     278             18.6
#> 289                Niagara MAAC 66.0     289 66.5     300             18.2
#> 290                Clemson  ACC 66.0     290 66.6     294             17.6
#> 291           Northeastern  CAA 65.9     291 65.8     320             18.2
#> 292                  Texas  B12 65.9     292 66.2     310             18.1
#> 293                Wofford   SC 65.9     293 66.6     296             18.0
#> 294                  Maine   AE 65.9     294 66.0     317             18.8
#> 295             Charleston  CAA 65.9     295 66.6     288             18.1
#> 296              Manhattan MAAC 65.8     296 66.2     306             17.7
#> 297                  Tulsa Amer 65.8     297 67.0     276             17.6
#> 298              Dartmouth  Ivy 65.8     298 66.3     303             18.2
#> 299          Northern Iowa  MVC 65.8     299 65.7     323             18.4
#> 300                Houston Amer 65.7     300 66.8     282             18.4
#> 301        St. Bonaventure  A10 65.7     301 66.2     309             18.3
#> 302                    UAB CUSA 65.7     302 67.0     280             18.6
#> 303 Texas A&M Corpus Chris Slnd 65.7     303 68.3     224             18.4
#> 304      Northern Kentucky Horz 65.7     304 67.9     240             18.1
#> 305             Oregon St.  P12 65.6     305 66.6     295             18.2
#> 306               Campbell BSth 65.6     306 66.6     292             18.3
#> 307              Charlotte CUSA 65.5     307 66.6     290             18.5
#> 308             Pittsburgh  ACC 65.5     308 66.0     314             18.3
#> 309          Virginia Tech  ACC 65.5     309 66.1     311             18.0
#> 310          South Alabama   SB 65.3     310 66.7     284             17.6
#> 311         Loyola Chicago  MVC 65.3     311 65.5     328             17.9
#> 312              Texas St.   SB 65.2     312 66.6     293             18.7
#> 313              Tennessee  SEC 65.2     313 66.6     297             18.0
#> 314                Cornell  Ivy 65.2     314 65.8     319             18.8
#> 315             California  P12 65.2     315 65.7     322             19.1
#> 316                 Marist MAAC 65.2     316 65.5     327             18.9
#> 317                 Towson  CAA 65.1     317 65.4     332             19.3
#> 318                    TCU  B12 65.1     318 65.6     326             18.6
#> 319                 Oregon  P12 65.0     319 66.2     308             17.9
#> 320      Northern Colorado BSky 65.0     320 65.5     331             19.0
#> 321    Cal St. Bakersfield  WAC 64.9     321 65.5     330             18.8
#> 322       Louisiana Monroe   SB 64.9     322 66.1     313             19.2
#> 323                Pacific  WCC 64.9     323 65.9     318             19.3
#> 324          South Florida Amer 64.9     324 65.5     329             18.5
#> 325                   UCLA  P12 64.9     325 66.3     302             18.6
#> 326                Florida  SEC 64.9     326 66.2     304             17.9
#> 327                   UMKC  WAC 64.9     327 65.6     324             18.8
#> 328                Fordham  A10 64.8     328 65.2     333             18.8
#> 329      Northern Illinois  MAC 64.8     329 66.1     312             18.1
#> 330               Davidson  A10 64.8     330 65.6     325             18.9
#> 331                    SMU Amer 64.8     331 66.0     315             18.4
#> 332          San Diego St.  MWC 64.6     332 66.0     316             17.5
#> 333                 Purdue  B10 64.6     333 64.7     338             18.6
#> 334              Texas A&M  SEC 64.5     334 65.7     321             18.8
#> 335       UC Santa Barbara   BW 64.5     335 64.9     337             18.7
#> 336                Radford BSth 64.3     336 64.9     336             19.2
#> 337      Southern Illinois  MVC 64.2     337 64.1     346             19.6
#> 338             Fresno St.  MWC 64.2     338 65.0     334             18.8
#> 339           Saint Mary's  WCC 63.9     339 65.0     335             19.9
#> 340         Sacramento St. BSky 63.9     340 64.4     341             19.5
#> 341                 Butler   BE 63.7     341 64.5     339             19.7
#> 342              Wisconsin  B10 63.7     342 64.5     340             19.9
#> 343         New Mexico St.  WAC 63.5     343 64.3     342             19.7
#> 344                Stetson ASun 63.2     344 63.9     349             19.8
#> 345       Mount St. Mary's  NEC 63.2     345 64.3     344             19.5
#> 346              Fairfield MAAC 63.2     346 63.6     350             20.2
#> 347           UC Riverside   BW 63.2     347 64.1     347             20.1
#> 348              Merrimack  NEC 63.2     348 64.0     348             18.5
#> 349       Loyola Marymount  WCC 63.0     349 64.3     343             20.1
#> 350            North Texas CUSA 62.9     350 64.2     345             19.0
#> 351                   Navy  Pat 62.5     351 62.2     351             19.9
#> 352                Liberty ASun 61.5     352 61.3     352             20.6
#> 353               Virginia  ACC 59.4     353 60.3     353             20.8
#>     AvgPossLengthOff.Rk AvgPossLengthDef AvgPossLengthDef.Rk  AdjO AdjO.Rk
#> 1                    21             14.7                   1  89.8     345
#> 2                     3             16.0                   5 102.9     175
#> 3                     2             17.1                 111 101.2     199
#> 4                     6             16.4                  18 111.0      37
#> 5                    10             16.2                  10  94.1     323
#> 6                    27             15.8                   2  95.4     297
#> 7                     1             17.9                 302 105.8     109
#> 8                     4             17.3                 171 104.1     151
#> 9                    37             15.9                   4  92.3     335
#> 10                   35             16.4                  19  94.9     305
#> 11                   18             16.6                  40 102.0     187
#> 12                   13             16.9                  71  89.6     346
#> 13                   53             16.1                   9  97.5     262
#> 14                   29             16.6                  41 106.0     108
#> 15                   28             15.9                   3  98.0     256
#> 16                    5             17.6                 241 102.0     190
#> 17                   11             17.7                 265 105.4     122
#> 18                    9             17.4                 187 105.4     120
#> 19                   24             16.9                  82 105.6     115
#> 20                   20             16.7                  48  95.4     298
#> 21                   16             16.8                  59 106.1     104
#> 22                   39             16.6                  30  99.1     237
#> 23                   41             16.7                  57  97.4     265
#> 24                   48             16.6                  32 104.2     149
#> 25                   34             16.7                  45  98.6     245
#> 26                   62             16.3                  16 104.8     134
#> 27                   19             17.6                 229  99.1     238
#> 28                   17             17.1                 140 100.6     210
#> 29                   58             16.1                   7  98.3     251
#> 30                    8             17.6                 224 103.7     157
#> 31                   23             17.1                 113 104.9     132
#> 32                   25             17.6                 231  99.5     230
#> 33                   32             16.7                  53  92.0     338
#> 34                   49             16.6                  42 115.7       9
#> 35                    7             17.7                 266 121.3       1
#> 36                   14             17.9                 306 104.7     136
#> 37                  101             16.6                  33 101.3     196
#> 38                   59             16.7                  58 105.3     125
#> 39                   65             16.0                   6 104.1     152
#> 40                   68             16.9                  85 108.8      57
#> 41                   26             17.1                 132 102.2     184
#> 42                   12             17.5                 202 102.6     176
#> 43                   96             16.4                  21 107.3      83
#> 44                  143             16.2                  13  98.3     250
#> 45                   94             17.0                 103 109.1      55
#> 46                   44             17.3                 166 105.2     126
#> 47                   74             17.1                 129 101.9     193
#> 48                   40             16.9                  77  99.5     229
#> 49                   85             16.9                  81 100.9     204
#> 50                   57             17.3                 174 110.3      44
#> 51                   72             17.2                 151  98.7     243
#> 52                   92             16.7                  44 100.4     213
#> 53                   73             16.9                  87  95.0     303
#> 54                   50             17.4                 183 110.3      43
#> 55                   81             17.2                 146  94.2     320
#> 56                   77             17.1                 133 104.8     135
#> 57                   30             17.7                 252 107.2      85
#> 58                   71             17.2                 147  99.4     231
#> 59                  102             17.0                  98 102.2     182
#> 60                   76             17.4                 185 114.0      14
#> 61                   56             16.8                  66  96.3     282
#> 62                   78             17.5                 219  99.6     227
#> 63                   15             17.8                 271 103.4     165
#> 64                   60             16.9                  76 108.2      71
#> 65                   22             17.3                 175 106.5      97
#> 66                   33             17.9                 294  98.7     244
#> 67                   90             17.3                 181 107.7      77
#> 68                   43             17.1                 143 108.2      70
#> 69                  106             17.1                 139  96.5     277
#> 70                  150             16.7                  49  94.6     308
#> 71                  155             16.8                  67  97.8     257
#> 72                   47             17.3                 179 104.4     144
#> 73                   45             17.9                 284 100.1     217
#> 74                  125             16.8                  70 107.4      82
#> 75                  124             16.1                   8  93.6     326
#> 76                  112             17.0                  92 103.4     163
#> 77                   52             17.6                 233 117.3       5
#> 78                  139             17.1                 128  94.4     315
#> 79                   86             17.1                 123 108.7      61
#> 80                  118             16.7                  52 105.8     110
#> 81                   88             17.0                  93 104.3     146
#> 82                  103             16.5                  22  96.9     271
#> 83                  116             17.5                 207  96.0     289
#> 84                  111             17.0                 101 118.1       4
#> 85                  114             17.0                  97 108.6      63
#> 86                  152             17.0                 108  97.7     259
#> 87                   36             17.6                 232 111.0      36
#> 88                  140             17.0                  94 103.1     171
#> 89                   95             17.9                 293 111.7      32
#> 90                   64             17.5                 220 109.6      48
#> 91                  179             17.0                  95 101.2     200
#> 92                  128             17.6                 245  97.7     260
#> 93                  119             16.9                  90 112.3      29
#> 94                   66             17.0                 100  99.3     233
#> 95                   70             17.4                 194  97.5     264
#> 96                   46             18.1                 327 105.8     112
#> 97                  126             17.1                 127  86.2     350
#> 98                   51             18.1                 329 108.8      58
#> 99                   84             16.9                  74  96.3     283
#> 100                 146             16.7                  51  93.2     327
#> 101                 165             16.6                  35 105.6     117
#> 102                  87             17.4                 186  96.0     288
#> 103                  80             17.3                 172 110.7      42
#> 104                 115             16.9                  89  90.3     342
#> 105                 171             16.7                  46  96.4     280
#> 106                  31             18.3                 345  98.8     242
#> 107                  75             17.9                 286  96.2     285
#> 108                 131             17.4                 184 116.3       7
#> 109                 236             16.2                  11 104.7     139
#> 110                  63             17.7                 253 108.5      66
#> 111                  91             17.9                 307 112.0      31
#> 112                 197             17.1                 130 108.3      67
#> 113                 164             16.9                  78  96.4     278
#> 114                  82             18.1                 326  95.9     292
#> 115                  54             17.9                 288 111.0      35
#> 116                  98             17.5                 213 109.3      52
#> 117                 214             16.2                  14  99.9     221
#> 118                 147             17.6                 243  98.8     240
#> 119                 142             17.1                 136  96.2     284
#> 120                 149             17.2                 155  99.6     228
#> 121                 145             16.8                  65  96.4     279
#> 122                 110             17.2                 154  94.4     314
#> 123                  83             17.9                 297 104.5     141
#> 124                  99             17.5                 221 109.2      53
#> 125                 213             16.6                  31 106.4      99
#> 126                  89             17.1                 125 103.2     170
#> 127                  67             17.5                 205 111.4      33
#> 128                 233             16.6                  43  95.5     295
#> 129                 176             16.6                  37  98.2     253
#> 130                  79             18.0                 316 115.2      10
#> 131                 175             17.0                 110  99.6     226
#> 132                 100             17.9                 282  95.2     302
#> 133                 130             17.5                 206 107.0      88
#> 134                  38             18.4                 349 104.7     138
#> 135                 253             16.6                  39  86.9     349
#> 136                 189             16.7                  54  92.3     336
#> 137                 166             16.5                  24 103.0     172
#> 138                  55             18.0                 309 107.6      81
#> 139                 123             17.5                 203 104.3     145
#> 140                 203             17.3                 180  92.8     332
#> 141                 154             17.7                 260 100.7     207
#> 142                 109             17.8                 269 102.1     186
#> 143                 174             17.2                 153 106.1     105
#> 144                 138             17.4                 201 102.4     178
#> 145                 239             16.2                  12 102.2     183
#> 146                  42             18.1                 332  99.7     225
#> 147                 219             17.2                 148 107.8      76
#> 148                 121             17.8                 278 104.7     137
#> 149                 263             16.3                  17 105.1     128
#> 150                 148             17.4                 188 113.2      20
#> 151                 129             17.3                 161  93.1     328
#> 152                 234             16.6                  34 102.2     185
#> 153                 182             17.8                 273 101.2     201
#> 154                  97             17.6                 236 101.9     192
#> 155                 136             17.5                 211 108.3      68
#> 156                 141             17.8                 280 101.6     194
#> 157                 191             16.8                  64  92.8     333
#> 158                 144             16.5                  26  99.7     223
#> 159                 242             16.9                  84 101.1     202
#> 160                 172             16.6                  38  94.4     311
#> 161                 262             16.6                  28 102.9     174
#> 162                  93             17.5                 208 105.3     124
#> 163                 269             16.3                  15  95.0     304
#> 164                 178             17.1                 124  99.7     224
#> 165                 113             18.1                 325  92.1     337
#> 166                 217             17.1                 137  94.3     316
#> 167                 190             17.2                 156 108.6      64
#> 168                 156             17.7                 246 107.2      86
#> 169                  61             18.8                 353  98.4     248
#> 170                 251             17.1                 141  97.6     261
#> 171                 167             17.1                 114 107.8      75
#> 172                 133             17.2                 152  99.1     239
#> 173                 170             17.5                 209 107.2      84
#> 174                 223             17.1                 142  97.0     269
#> 175                 208             17.3                 164  95.2     301
#> 176                 162             17.1                 126 108.9      56
#> 177                 254             16.9                  75  95.9     291
#> 178                  69             17.8                 272 118.2       3
#> 179                 104             18.2                 333 112.8      21
#> 180                 266             16.7                  50 107.7      79
#> 181                 216             17.3                 160 104.8     133
#> 182                 193             17.6                 234 105.6     116
#> 183                 181             17.4                 196 104.4     143
#> 184                 292             16.7                  55  94.4     312
#> 185                 134             17.5                 204 103.2     169
#> 186                 297             16.8                  61  83.5     351
#> 187                 158             17.4                 197 107.7      78
#> 188                 196             17.7                 250 109.1      54
#> 189                 286             16.5                  23  95.8     293
#> 190                 107             17.9                 287 110.7      41
#> 191                 227             17.1                 115 106.1     103
#> 192                 201             16.9                  86 100.1     216
#> 193                 160             17.0                 106 106.3     102
#> 194                 173             18.0                 310 104.7     140
#> 195                 265             16.8                  62 103.6     161
#> 196                 186             17.3                 159 103.7     158
#> 197                 235             17.1                 121  95.4     300
#> 198                 228             17.7                 267 103.4     164
#> 199                 137             17.7                 258 108.8      59
#> 200                 240             16.9                  80  99.2     235
#> 201                 153             17.2                 157 110.0      46
#> 202                 105             18.3                 342 108.7      62
#> 203                 122             17.8                 281 100.2     215
#> 204                 231             17.7                 248 102.0     189
#> 205                 117             17.7                 264  95.4     299
#> 206                 195             17.5                 218 108.5      65
#> 207                 108             18.0                 313  91.3     339
#> 208                 220             17.1                 119 103.5     162
#> 209                 207             16.9                  83 106.9      90
#> 210                 135             17.9                 300 103.7     160
#> 211                 244             17.9                 290 106.6      94
#> 212                 204             17.3                 168 105.4     121
#> 213                 198             17.0                  99  87.9     348
#> 214                 161             17.6                 235 102.3     180
#> 215                 183             17.7                 251 112.7      24
#> 216                 246             17.5                 215  98.8     241
#> 217                 267             17.0                 105  96.9     274
#> 218                 120             17.7                 249  94.0     324
#> 219                 194             17.3                 182 105.8     111
#> 220                 151             18.1                 323 119.1       2
#> 221                 247             16.5                  25  81.7     352
#> 222                 280             17.0                 102 103.3     167
#> 223                 278             16.9                  73  97.3     266
#> 224                 177             17.7                 261  96.9     273
#> 225                 199             16.9                  72  94.2     321
#> 226                 296             16.7                  47  94.9     306
#> 227                 281             17.1                 138 107.9      73
#> 228                 230             17.1                 120  99.4     232
#> 229                 168             17.8                 275 109.5      49
#> 230                 298             17.2                 150 100.8     206
#> 231                 180             17.9                 291 107.9      72
#> 232                 188             17.3                 167  94.6     309
#> 233                 132             18.2                 338 115.8       8
#> 234                 206             17.9                 295  97.0     270
#> 235                 306             16.8                  63 100.0     219
#> 236                 187             17.8                 274 109.8      47
#> 237                 127             18.1                 322 104.2     148
#> 238                 293             16.6                  36  94.4     313
#> 239                 192             18.0                 319 102.5     177
#> 240                 159             17.6                 239  99.9     220
#> 241                 245             16.6                  29  92.9     329
#> 242                 169             18.1                 331 114.5      12
#> 243                 229             17.0                  96 102.0     188
#> 244                 184             18.0                 312 106.8      92
#> 245                 209             17.9                 289 113.5      18
#> 246                 238             17.4                 189 101.3     197
#> 247                 259             17.4                 191 107.9      74
#> 248                 277             16.8                  68 106.6      93
#> 249                 288             17.5                 222  94.7     307
#> 250                 225             17.3                 170  95.4     296
#> 251                 232             17.7                 254 100.6     211
#> 252                 200             17.4                 193  92.5     334
#> 253                 304             17.2                 158  96.9     272
#> 254                 163             18.0                 314  94.2     318
#> 255                 205             17.9                 303  97.8     258
#> 256                 260             17.1                 131  97.2     267
#> 257                 241             17.6                 227 112.1      30
#> 258                 258             17.4                 190  94.1     322
#> 259                 210             18.1                 321 104.9     131
#> 260                 264             17.3                 163 106.3     100
#> 261                 218             18.2                 336 107.2      87
#> 262                 222             18.2                 335  96.0     290
#> 263                 157             17.7                 259  94.2     319
#> 264                 331             17.2                 149  99.2     236
#> 265                 279             17.7                 256 102.3     179
#> 266                 221             17.6                 226 108.7      60
#> 267                 226             17.8                 270 104.1     150
#> 268                 290             17.1                 117  98.3     249
#> 269                 252             17.3                 169 103.0     173
#> 270                 307             17.6                 228 105.8     113
#> 271                 318             16.7                  56  94.5     310
#> 272                 250             18.1                 324 103.3     166
#> 273                 276             17.8                 279 106.5      98
#> 274                 268             17.3                 165 107.0      89
#> 275                 270             17.1                 122 113.9      15
#> 276                 285             17.0                 109 113.4      19
#> 277                 282             17.7                 262 113.5      17
#> 278                 255             18.0                 315 100.6     208
#> 279                 249             17.9                 296 102.2     181
#> 280                 274             17.6                 230 114.3      13
#> 281                 287             17.1                 118 108.2      69
#> 282                 185             18.0                 318 100.5     212
#> 283                 305             16.5                  27  90.3     341
#> 284                 332             16.9                  79  79.0     353
#> 285                 322             16.8                  60  98.6     246
#> 286                 309             17.7                 257  91.2     340
#> 287                 320             16.8                  69 106.8      91
#> 288                 316             16.9                  88 110.9      38
#> 289                 289             17.6                 244 100.1     218
#> 290                 211             18.2                 340 103.9     155
#> 291                 284             18.3                 344 105.4     123
#> 292                 271             17.9                 305 104.1     153
#> 293                 257             18.2                 334 104.5     142
#> 294                 327             17.4                 199  92.9     330
#> 295                 273             17.8                 276 105.0     129
#> 296                 224             18.1                 328  92.8     331
#> 297                 215             18.0                 308 103.2     168
#> 298                 283             17.4                 200  96.7     276
#> 299                 302             17.9                 292 112.7      23
#> 300                 303             17.3                 178 112.7      22
#> 301                 294             17.8                 277 106.6      95
#> 302                 315             17.0                 107 100.8     205
#> 303                 301             16.4                  20  94.3     317
#> 304                 275             17.1                 116 102.0     191
#> 305                 291             17.8                 268 110.9      39
#> 306                 295             17.4                 195  96.8     275
#> 307                 311             17.2                 144  98.5     247
#> 308                 299             17.7                 263 104.0     154
#> 309                 256             18.1                 320 104.3     147
#> 310                 212             18.2                 337 104.9     130
#> 311                 243             18.3                 343 103.7     159
#> 312                 319             17.1                 135 106.3     101
#> 313                 261             17.9                 285 106.6      96
#> 314                 325             17.5                 212 101.2     198
#> 315                 335             17.4                 192 101.5     195
#> 316                 330             17.5                 216  90.2     343
#> 317                 338             17.3                 162 105.7     114
#> 318                 312             17.9                 304 105.5     119
#> 319                 248             18.3                 341 117.1       6
#> 320                 334             17.6                 225 110.2      45
#> 321                 326             17.6                 240  96.2     286
#> 322                 337             16.9                  91  96.1     287
#> 323                 339             17.2                 145 103.8     156
#> 324                 308             18.0                 317 100.2     214
#> 325                 313             17.3                 177 109.3      51
#> 326                 237             18.2                 339 112.5      27
#> 327                 323             17.7                 247  97.5     263
#> 328                 328             17.6                 238  89.1     347
#> 329                 272             17.9                 301  99.8     222
#> 330                 329             17.6                 242 112.5      26
#> 331                 300             18.0                 311 112.4      28
#> 332                 202             18.5                 350 115.1      11
#> 333                 314             18.4                 348 109.3      50
#> 334                 321             17.9                 299 101.0     203
#> 335                 317             18.1                 330 106.1     106
#> 336                 336             17.5                 210 105.6     118
#> 337                 342             17.3                 176  98.2     252
#> 338                 324             17.9                 283 105.1     127
#> 339                 348             17.1                 134 113.7      16
#> 340                 340             17.5                 214  97.1     268
#> 341                 344             17.4                 198 112.6      25
#> 342                 346             17.0                 104 110.8      40
#> 343                 343             17.7                 255 107.6      80
#> 344                 345             17.5                 223  98.1     255
#> 345                 341             17.5                 217  96.4     281
#> 346                 351             17.3                 173  90.1     344
#> 347                 349             17.1                 112  95.8     294
#> 348                 310             18.7                 352  93.9     325
#> 349                 350             17.6                 237 100.6     209
#> 350                 333             17.9                 298 111.2      34
#> 351                 347             18.3                 347  98.1     254
#> 352                 352             18.3                 346 106.1     107
#> 353                 353             18.6                 351  99.3     234
#>      RawO RawO.Rk  AdjD AdjD.Rk  RawD RawD.Rk NCAA_Seed Year
#> 1    86.7     349 117.6     349 112.7     343        NA 2020
#> 2   102.5     140 122.3     352 120.0     352        NA 2020
#> 3   100.1     193  99.1     106  97.8     107        NA 2020
#> 4   106.0      71  99.5     114 102.2     221        NA 2020
#> 5    94.7     310 117.2     347 109.6     329        NA 2020
#> 6    95.7     287 104.9     230 101.7     202        NA 2020
#> 7   105.4      79 110.5     319 107.9     317        NA 2020
#> 8   103.3     123 102.3     175 101.0     187        NA 2020
#> 9    93.3     323 102.4     177  96.6      83        NA 2020
#> 10   94.2     317 112.2     328 111.7     340        NA 2020
#> 11  100.8     175 106.4     264 105.4     283        NA 2020
#> 12   90.5     342 105.3     240  99.2     143        NA 2020
#> 13   93.2     324 107.8     289 110.5     335        NA 2020
#> 14  100.1     191  94.7      49  96.1      64        10 2020
#> 15   96.4     273 107.6     285 107.1     310        NA 2020
#> 16   94.3     316 101.3     152 105.5     287        NA 2020
#> 17  100.8     176  94.7      50  95.4      54        NA 2020
#> 18  105.0      88 101.1     142  99.7     156        15 2020
#> 19  104.1     107 101.4     156  99.9     162        NA 2020
#> 20   96.6     267 105.8     254  98.3     122        NA 2020
#> 21  100.4     183  95.2      53  96.9      91        NA 2020
#> 22   96.7     264 108.6     304 102.2     220        NA 2020
#> 23  100.0     195 106.1     259 103.1     241        NA 2020
#> 24  101.2     168 108.0     293 106.1     296        NA 2020
#> 25   97.5     244 112.6     332 113.2     345        NA 2020
#> 26  103.6     112 106.2     261 104.5     270        NA 2020
#> 27   98.5     222 101.8     162  97.3     101        NA 2020
#> 28   97.4     250  89.1       5  88.5       2        NA 2020
#> 29  100.1     192 107.1     278 104.1     265        NA 2020
#> 30  102.1     149 102.1     170  99.8     159        NA 2020
#> 31  107.9      39 101.4     157  96.2      71        NA 2020
#> 32   99.1     210 111.6     323 108.5     324        NA 2020
#> 33   92.2     332 109.6     312 106.3     300        NA 2020
#> 34  111.9       6  91.1      12  91.4      11         3 2020
#> 35  120.1       1  94.4      43  93.3      23         1 2020
#> 36  108.9      26 102.1     169  98.3     125        16 2020
#> 37   99.5     199 106.2     262 105.2     282        NA 2020
#> 38  104.9      91 102.4     178 103.8     256        NA 2020
#> 39  106.3      65  97.1      75  91.8      14        12 2020
#> 40  107.9      40 108.8     306 106.6     304        NA 2020
#> 41  101.3     162  98.8     102  98.0     115        NA 2020
#> 42  101.6     157 101.3     154  99.7     155        NA 2020
#> 43  106.6      60 106.3     263 104.9     277        NA 2020
#> 44   99.0     212 115.0     343 114.7     349        NA 2020
#> 45  104.7      95  95.5      57  96.2      68        NA 2020
#> 46  101.2     167  94.2      39  95.0      47        NA 2020
#> 47   96.5     270 110.2     315 111.3     338        NA 2020
#> 48  101.6     158 103.7     200  99.8     161        NA 2020
#> 49  100.0     196 102.1     171  96.6      80        NA 2020
#> 50  107.1      52 101.0     141 100.8     183        NA 2020
#> 51  103.8     110 110.3     318 106.7     305        NA 2020
#> 52  102.2     145 109.1     309 105.4     285        NA 2020
#> 53   95.3     297 106.8     274 106.6     302        NA 2020
#> 54  105.0      86  92.4      23  95.8      59         6 2020
#> 55   92.2     333 105.3     238 105.6     288        NA 2020
#> 56  105.6      75 116.7     345 114.3     348        NA 2020
#> 57  104.3     104 104.4     217 105.4     286        NA 2020
#> 58   97.7     239 115.6     344 114.0     347        NA 2020
#> 59   97.5     243  98.0      83  97.4     102        NA 2020
#> 60  107.2      51  96.9      73  99.0     137         9 2020
#> 61   96.2     278 100.5     131  93.3      22        16 2020
#> 62   95.6     292 104.0     213 101.9     213        NA 2020
#> 63   97.3     251  95.5      56  99.2     144        NA 2020
#> 64  103.5     117 100.8     136 103.4     249        NA 2020
#> 65  109.0      25 100.5     132  94.3      38        14 2020
#> 66   98.7     218 106.0     256 103.4     247        NA 2020
#> 67  100.9     173  98.4      94 102.1     219        NA 2020
#> 68  109.8      18 104.9     231 105.0     279        NA 2020
#> 69   96.8     261 104.2     215 101.5     197        NA 2020
#> 70   96.0     281 106.5     266 101.7     204        NA 2020
#> 71   99.0     213 103.8     206  98.7     130        NA 2020
#> 72  103.5     119 113.6     337 107.4     313        NA 2020
#> 73   95.2     299  94.6      47  95.1      51        NA 2020
#> 74  105.5      78 113.3     336 112.6     342        NA 2020
#> 75   94.5     313 119.7     350 113.9     346        NA 2020
#> 76  101.7     154 100.8     137  99.7     157        NA 2020
#> 77  110.3      14  98.6      97 102.4     225         6 2020
#> 78   90.6     340  99.8     117 101.8     206        NA 2020
#> 79  101.9     152 102.0     166 104.0     263        NA 2020
#> 80  102.9     131 108.4     301 106.0     295        NA 2020
#> 81  102.8     133 104.0     210 102.3     222        NA 2020
#> 82   95.8     285 111.3     322 103.0     239        NA 2020
#> 83   96.3     276 105.6     248 100.8     185        NA 2020
#> 84  112.8       4 102.4     179 102.6     231         8 2020
#> 85  109.4      21 108.9     307 106.3     299        NA 2020
#> 86   97.5     245 105.7     249 100.8     181        NA 2020
#> 87  104.5     100 100.2     125 103.6     251        NA 2020
#> 88   96.0     282  91.8      16  94.2      36        NA 2020
#> 89  107.1      53  91.5      15  93.6      24         2 2020
#> 90  101.4     160 101.2     147 103.5     250        NA 2020
#> 91  101.0     169 105.5     247 101.3     193        NA 2020
#> 92   97.4     249  99.4     111  94.5      42        NA 2020
#> 93  105.4      80  92.7      25  96.1      65         3 2020
#> 94   98.8     216 114.8     342 111.8     341        NA 2020
#> 95   95.0     305 108.2     298 107.8     315        NA 2020
#> 96   99.9     197  93.1      31  93.9      30        NA 2020
#> 97   86.7     348 103.4     198 100.7     178        NA 2020
#> 98  100.7     179  93.1      29  96.8      89        10 2020
#> 99   98.3     228 102.5     180  99.3     151        NA 2020
#> 100  95.6     291 107.5     282 100.8     182        NA 2020
#> 101 100.7     177  90.4       8  89.7       5        11 2020
#> 102  97.7     237 104.9     232 102.4     227        NA 2020
#> 103 105.2      82  97.3      79  98.5     127        11 2020
#> 104  88.5     346 114.0     340 110.6     336        NA 2020
#> 105  97.0     258  99.5     115  96.8      87        NA 2020
#> 106 100.7     178 107.4     281 104.0     262        NA 2020
#> 107  96.9     260 102.9     189 101.6     200        NA 2020
#> 108 112.1       5  95.6      60  97.0      92         5 2020
#> 109 101.4     161 104.5     221 106.3     301        NA 2020
#> 110 106.8      58  98.9     103  95.6      57        13 2020
#> 111 111.2       8 111.6     324 107.1     311        NA 2020
#> 112 100.9     172  87.1       3  89.5       4         6 2020
#> 113  95.0     303 101.1     143  99.3     148        NA 2020
#> 114  94.4     314 104.5     218 102.0     217        NA 2020
#> 115 107.6      49  91.4      14  92.4      15         7 2020
#> 116 106.1      69 102.1     172 102.4     229        NA 2020
#> 117  99.1     209 111.7     326 110.1     333        NA 2020
#> 118  98.9     215  98.1      86  95.5      55        NA 2020
#> 119  94.6     312 106.6     268 105.4     284        NA 2020
#> 120  92.5     329 100.3     128 101.4     195        NA 2020
#> 121  98.5     223 104.6     222 100.3     172        NA 2020
#> 122  92.7     328 104.3     216 104.5     272        NA 2020
#> 123 101.9     151 102.5     181 101.6     198        NA 2020
#> 124 107.8      43  95.3      54  95.2      52        11 2020
#> 125 104.2     106 102.5     184  99.8     160        15 2020
#> 126 102.5     139 107.7     286 108.2     319        NA 2020
#> 127 108.3      33  95.5      55  97.7     106         5 2020
#> 128  97.2     255 110.8     320 108.5     323        NA 2020
#> 129 102.0     150 104.5     220  98.9     133        NA 2020
#> 130 109.3      22  91.2      13  93.8      27         3 2020
#> 131  96.5     271 100.4     129  99.1     142        NA 2020
#> 132  93.5     321 106.5     267 104.3     268        NA 2020
#> 133 104.5      99  97.6      81  99.1     141        NA 2020
#> 134 101.7     155  94.4      45  93.8      28        NA 2020
#> 135  83.8     350 120.8     351 120.5     353        NA 2020
#> 136  94.3     315 110.0     314 106.8     307        NA 2020
#> 137 104.9      90 112.3     330 108.3     320        NA 2020
#> 138 109.1      24 107.9     290 102.9     236        NA 2020
#> 139  99.3     206  92.0      18  93.0      21         9 2020
#> 140  91.4     337 107.1     277 106.1     297        NA 2020
#> 141 101.3     163 108.3     300 102.8     234        NA 2020
#> 142 102.2     147 112.4     331 108.3     321        NA 2020
#> 143 106.0      70 102.1     167 100.0     163        NA 2020
#> 144 105.6      77  99.3     110  94.1      33        NA 2020
#> 145 101.7     156 107.7     287 108.6     325        NA 2020
#> 146  98.4     225 101.3     151  99.0     138        NA 2020
#> 147 104.9      89 110.3     316 110.0     332        NA 2020
#> 148 103.8     111  99.0     105  97.0      93        NA 2020
#> 149 105.8      74 122.9     353 119.9     351        NA 2020
#> 150 106.8      57  93.0      28  97.6     103         6 2020
#> 151  94.7     311 105.1     235  98.6     129        NA 2020
#> 152 104.3     102 104.8     227 100.5     174        NA 2020
#> 153 100.2     189 108.0     292 104.1     266        NA 2020
#> 154  97.7     236 103.1     191 101.8     209        NA 2020
#> 155 106.1      68  98.2      88  99.3     147        NA 2020
#> 156 101.0     171 106.1     260 101.5     196        NA 2020
#> 157  93.4     322 102.3     176  96.6      81        NA 2020
#> 158 101.2     166 101.5     158  97.8     111        NA 2020
#> 159 103.5     120 104.0     212 100.2     168        NA 2020
#> 160  93.1     325 107.3     279 101.4     194        NA 2020
#> 161  98.2     229 102.5     185 102.0     218        NA 2020
#> 162 108.3      34 108.1     295 101.9     214        NA 2020
#> 163  95.7     289 102.1     168  97.8     108        NA 2020
#> 164  97.6     240 116.9     346 112.9     344        NA 2020
#> 165  92.4     330 104.5     219 104.7     276        NA 2020
#> 166  94.8     308 103.9     208  99.1     139        NA 2020
#> 167 102.9     132  95.6      59  94.1      34        NA 2020
#> 168 109.9      17 102.5     182  99.6     153        NA 2020
#> 169  96.2     277 102.9     190 103.1     240        NA 2020
#> 170  99.4     205 101.0     140  98.3     123        NA 2020
#> 171 102.2     146  92.8      27  94.9      46         8 2020
#> 172 101.5     159 100.2     126  96.1      67        NA 2020
#> 173  98.7     219  94.5      46  96.7      86        NA 2020
#> 174  97.0     257 108.8     305 107.4     314        NA 2020
#> 175  93.6     320 108.5     302 107.8     316        NA 2020
#> 176 106.3      63 103.3     196 101.7     203        NA 2020
#> 177  95.2     300 117.3     348 115.0     350        NA 2020
#> 178 111.1      10  97.3      78 100.6     176         2 2020
#> 179 107.9      42  99.6     116 100.4     173        NA 2020
#> 180 101.0     170 101.3     149 104.0     264        NA 2020
#> 181 102.5     138 100.2     124  98.8     131        NA 2020
#> 182 107.1      54 106.4     265 103.7     255        NA 2020
#> 183 100.5     182  90.3       7  90.5       9        NA 2020
#> 184  95.7     288 101.1     144  97.0      95        NA 2020
#> 185 101.3     165 100.1     123  97.9     114        NA 2020
#> 186  81.2     352 112.2     329 110.8     337        NA 2020
#> 187 108.2      35  98.1      85  96.4      79        NA 2020
#> 188 103.4     122  93.4      32  93.9      31         8 2020
#> 189  98.5     224 105.5     245 101.2     191        NA 2020
#> 190 106.9      56  98.6     100  98.9     134        NA 2020
#> 191 100.3     186  92.2      20  96.2      69        NA 2020
#> 192 100.3     187 102.7     188 101.0     188        NA 2020
#> 193 105.9      73 105.1     237 102.3     223        NA 2020
#> 194 103.1     128 109.4     311 106.2     298        NA 2020
#> 195 102.2     148 103.3     195 101.7     201        NA 2020
#> 196  99.5     201  97.0      74  98.8     132        NA 2020
#> 197  96.5     272  97.3      80  93.0      20        NA 2020
#> 198 103.3     124 112.1     327 106.8     308        NA 2020
#> 199 102.3     142  94.7      51  94.4      40        12 2020
#> 200 100.2     190  94.0      37  91.5      12        NA 2020
#> 201 110.8      11 105.3     241 101.2     192        NA 2020
#> 202 110.2      15 102.6     187 100.0     165        14 2020
#> 203 100.5     181 108.1     296 106.6     303        NA 2020
#> 204 100.4     185 101.3     155 100.6     175        NA 2020
#> 205  97.7     238 103.8     204 104.6     275        NA 2020
#> 206 103.2     126  92.7      26  97.3      99        10 2020
#> 207  95.5     295 105.1     234 100.0     164        NA 2020
#> 208  99.4     204  98.6      98  98.0     116        NA 2020
#> 209 108.4      31 107.0     275 103.7     253        NA 2020
#> 210 103.4     121  95.5      58  92.9      18        NA 2020
#> 211 104.7      94  99.0     104  97.0      96        NA 2020
#> 212 104.8      93  99.3     109  96.2      72        14 2020
#> 213  88.2     347 108.2     297 101.9     216        NA 2020
#> 214 100.4     184  98.4      95  99.2     145        NA 2020
#> 215 108.0      37  95.1      52  96.2      70         4 2020
#> 216  95.5     294 107.9     291 107.2     312        NA 2020
#> 217  95.0     302 107.4     280 106.8     309        NA 2020
#> 218  95.3     296 113.0     334 109.2     328        NA 2020
#> 219 103.1     129  94.4      44  93.9      29        NA 2020
#> 220 116.4       2  94.1      38  93.7      25         1 2020
#> 221  81.2     351 107.8     288 103.8     257        NA 2020
#> 222 104.3     103 105.5     244 103.7     252        NA 2020
#> 223  97.2     254 113.9     339 109.6     330        NA 2020
#> 224  95.6     290  98.2      89  96.1      66        NA 2020
#> 225  96.8     263 101.9     164  95.0      48        NA 2020
#> 226  96.6     269 113.2     335 106.8     306        NA 2020
#> 227 106.2      67  96.4      67  94.3      37        12 2020
#> 228  97.4     248 105.7     251 105.0     278        NA 2020
#> 229 108.0      38  94.6      48  94.1      35        11 2020
#> 230  99.5     202 111.1     321 109.9     331        NA 2020
#> 231 101.9     153  90.2       6  92.9      19         9 2020
#> 232  96.3     275 108.1     294 102.8     235        NA 2020
#> 233 108.6      28  85.5       2  89.3       3         1 2020
#> 234  96.6     268 101.6     159 100.1     166        NA 2020
#> 235  99.7     198 106.7     271 104.6     274        NA 2020
#> 236 103.8     109  90.5       9  91.7      13        10 2020
#> 237 102.5     137 107.5     284 105.8     292        NA 2020
#> 238  92.3     331 103.8     207 105.6     290        NA 2020
#> 239  95.0     304  94.2      40  96.3      76        NA 2020
#> 240  98.2     230 100.2     127  99.2     146        NA 2020
#> 241  91.9     335 105.7     250 104.2     267        NA 2020
#> 242 109.7      20  93.1      30  94.0      32         4 2020
#> 243 100.3     188 107.0     276 105.6     289        NA 2020
#> 244 105.0      85 100.7     134  97.8     110        14 2020
#> 245 106.3      64  92.4      22  95.7      58         3 2020
#> 246  99.0     214 101.3     153 100.2     167        NA 2020
#> 247 104.3     101 100.6     133 101.8     207        NA 2020
#> 248 105.4      81 104.8     225 102.5     230        NA 2020
#> 249  94.8     309 105.8     255 102.6     232        NA 2020
#> 250  97.3     253 109.1     308 105.9     293        NA 2020
#> 251 102.7     135 105.5     246 102.7     233        NA 2020
#> 252  92.9     327 109.3     310 105.9     294        NA 2020
#> 253  97.9     232 114.4     341 110.3     334        NA 2020
#> 254  91.6     336  96.6      70  96.9      90        NA 2020
#> 255  96.8     262 105.7     252 101.9     211        NA 2020
#> 256  97.5     246 104.8     224  97.8     109        NA 2020
#> 257 104.6      96  94.2      41  98.1     118        NA 2020
#> 258  90.7     339 100.9     139 102.9     237        NA 2020
#> 259  96.7     265 101.3     150 104.5     273        NA 2020
#> 260 102.3     143 100.8     135 103.2     243        NA 2020
#> 261 106.5      61 105.1     236  99.4     152        16 2020
#> 262  96.4     274 102.5     183  97.9     112        NA 2020
#> 263  95.9     284 103.2     193  97.7     105        16 2020
#> 264  96.0     280 105.8     253 103.7     254        NA 2020
#> 265 102.2     144 106.7     269 105.6     291        NA 2020
#> 266 107.7      47  98.2      90  94.7      44        NA 2020
#> 267  99.5     203  96.7      71  96.7      85        NA 2020
#> 268  96.2     279  98.3      92  96.3      74        NA 2020
#> 269 103.5     118 108.5     303 104.4     269        NA 2020
#> 270 103.3     125 101.2     145 100.9     186        NA 2020
#> 271  95.5     293 113.6     338 111.4     339        NA 2020
#> 272 104.6      97 102.6     186  99.6     154        16 2020
#> 273 106.5      62  96.4      68  90.1       8        13 2020
#> 274 105.2      83 105.5     243 103.8     258        NA 2020
#> 275 107.8      44  94.0      36  98.3     121         2 2020
#> 276 109.2      23  99.8     119 101.1     189        NA 2020
#> 277 106.3      66  88.1       4  90.1       7         1 2020
#> 278 100.0     194 110.0     313 108.3     322        NA 2020
#> 279 104.6      98 106.7     270 103.9     260        NA 2020
#> 280 108.1      36  92.0      19  94.5      41         5 2020
#> 281 109.7      19  96.0      65  95.9      62        11 2020
#> 282 102.8     134 103.8     205 100.2     169        16 2020
#> 283  92.0     334 112.8     333 109.0     327        NA 2020
#> 284  78.2     353 104.6     223 100.8     180        NA 2020
#> 285  98.4     226 105.0     233 102.3     224        NA 2020
#> 286  90.8     338 103.3     194  99.7     158        NA 2020
#> 287 108.4      30 101.2     148  99.3     150        15 2020
#> 288 105.1      84  93.7      35  97.2      98         7 2020
#> 289  97.8     235 111.6     325 107.9     318        NA 2020
#> 290  98.6     220  93.5      33  95.2      53        NA 2020
#> 291 107.7      45 103.2     192 100.7     179        NA 2020
#> 292  97.0     259  92.6      24  95.6      56        NA 2020
#> 293 104.3     105 103.4     197 102.4     228        NA 2020
#> 294  90.3     343 106.8     273 103.1     242        NA 2020
#> 295 105.0      87 104.9     229 103.3     246        NA 2020
#> 296  93.1     326 101.6     160  96.4      78        NA 2020
#> 297  99.5     200  93.6      34  92.8      17        NA 2020
#> 298  95.3     298  99.9     121  96.7      84        NA 2020
#> 299 110.7      12  99.3     108  97.9     113        NA 2020
#> 300 107.7      48  92.3      21  92.7      16         7 2020
#> 301 103.6     115 102.2     174 100.8     184        NA 2020
#> 302  99.3     207 102.1     173  98.5     128        NA 2020
#> 303  96.0     283 106.0     257 101.9     210        NA 2020
#> 304 103.6     116  99.8     120  96.3      75        15 2020
#> 305 106.7      59 102.0     165 101.8     208        NA 2020
#> 306 100.5     180 105.3     239 100.7     177        NA 2020
#> 307  98.1     231  98.0      84  95.8      60        NA 2020
#> 308  98.3     227  98.3      91  99.1     140        NA 2020
#> 309 101.3     164  98.0      82  98.4     126        NA 2020
#> 310 104.0     108 103.9     209 102.4     226        NA 2020
#> 311 102.6     136  96.8      72  94.8      45        NA 2020
#> 312 104.8      92  98.3      93  96.4      77        NA 2020
#> 313 100.8     174  95.8      62  96.8      88        NA 2020
#> 314  98.8     217 110.3     317 108.8     326        NA 2020
#> 315  95.1     301 100.4     130 103.9     261        NA 2020
#> 316  90.6     341 103.8     203  98.2     119        NA 2020
#> 317 105.6      76 104.8     226 103.2     244        NA 2020
#> 318  97.5     242  96.1      66  98.2     120        NA 2020
#> 319 111.9       7  97.1      76  98.3     124         4 2020
#> 320 110.3      13 100.1     122  97.0      94        NA 2020
#> 321  97.6     241 104.9     228 103.4     248        NA 2020
#> 322  93.7     318 103.7     201 103.2     245        NA 2020
#> 323 102.4     141  99.1     107  97.1      97        NA 2020
#> 324  95.0     306  95.9      63  95.0      49        NA 2020
#> 325 103.6     114  99.4     112 101.1     190        11 2020
#> 326 107.3      50  95.7      61  99.0     136         9 2020
#> 327  98.5     221 103.6     199 101.9     215        NA 2020
#> 328  88.6     345  95.9      64  93.7      26        NA 2020
#> 329  99.1     211 100.8     138  98.1     117        NA 2020
#> 330 108.6      27 101.9     163 100.3     170        NA 2020
#> 331 108.3      32 103.8     202 101.7     205        NA 2020
#> 332 112.8       3  90.6      10  91.0      10         2 2020
#> 333 102.9     130  90.8      11  94.3      39        NA 2020
#> 334  95.8     286  97.2      77  99.0     135        NA 2020
#> 335 107.0      55 105.3     242 101.6     199        NA 2020
#> 336 108.5      29 106.8     272 103.9     259        NA 2020
#> 337  96.6     266  98.6      99  97.3     100        NA 2020
#> 338 103.2     127 104.1     214 105.1     280        NA 2020
#> 339 111.2       9  98.5      96 100.3     171         8 2020
#> 340  97.1     256  98.2      87  95.8      61        NA 2020
#> 341 105.9      72  94.2      42  95.9      63         5 2020
#> 342 103.6     113  91.9      17  96.3      73         4 2020
#> 343 107.9      41  99.4     113  94.6      43        13 2020
#> 344  97.9     233 108.3     299 104.5     271        NA 2020
#> 345  97.9     234 107.5     283 102.9     238        NA 2020
#> 346  90.2     344 101.6     161  97.7     104        NA 2020
#> 347  97.3     252  99.8     118  96.6      82        NA 2020
#> 348  94.9     307  98.8     101  95.0      50        NA 2020
#> 349  97.4     247 104.0     211 105.2     281        NA 2020
#> 350 107.7      46 101.2     146  99.3     149        13 2020
#> 351  99.2     208 106.0     258 101.9     212        NA 2020
#> 352 109.9      16  96.4      69  89.8       6        12 2020
#> 353  93.6     319  85.1       1  85.9       1         7 2020
# }
```
