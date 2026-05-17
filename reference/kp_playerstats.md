# **Get Player Stats Leaders by Metric**

**Get Player Stats Leaders by Metric**

## Usage

``` r
kp_playerstats(
  metric = "eFG",
  conf = NULL,
  conf_only = FALSE,
  year = most_recent_mbb_season()
)
```

## Arguments

- metric:

  Used to get leaders for different metrics. Available values are:  
  'ORtg', 'Min', 'eFG', 'Poss', Shots', 'OR', 'DR', 'TO', 'ARate',
  'Blk',  
  'FTRate', 'Stl', 'TS', 'FC40', 'FD40', '2P', '3P', 'FT'.  
  Default is 'eFG'. 'ORtg' returns a list of four dataframes, as there
  are four tables:  
  players that used more than 28 percent of possessions, more than 24
  percent of possessions, more than 20 percent of possessions, and with
  no possession restriction.

- conf:

  Used to limit to players in a specific conference. Allowed values are:
  'A10', 'ACC', 'AE', 'AMER',  
  'ASUN', 'B10', 'B12', 'BE', 'BSKY', 'BSTH', 'BW', 'CAA', 'CUSA',
  'HORZ', 'IND', IVY',  
  'MAAC', 'MAC', 'MEAC', 'MVC', 'MWC', 'NEC', 'OVC', 'P12', 'PAT', 'SB',
  'SC', 'SEC', 'SLND',  
  'SUM', 'SWAC', 'WAC', 'WCC'.  
  If you try to use a conference that doesn't exist for a given season,
  like 'IND' and '2018',  
  you'll get an empty table, as kenpom.com doesn't serve 404 pages for
  invalid table queries like that.  
  No filter applied by default.

- conf_only:

  Used to define whether stats should reflect conference games only.  
  Only available if specific conference is defined. Only available for
  season after 2013, FALSE by default.

- year:

  Year of data to pull (earliest year of data available: 2004)

## Value

Returns a tibble of player stats

|          |           |                                     |
|----------|-----------|-------------------------------------|
| col_name | types     | description                         |
| rk       | character | Rk.                                 |
| player   | character | Player.                             |
| team     | character | Team-side label or team identifier. |
| e_fg     | character | E fg.                               |
| hgt      | character | Hgt.                                |
| wgt      | character | Wgt.                                |
| yr       | character | Yr.                                 |
| year     | numeric   | 4-digit year.                       |

## See also

Other KenPom Ratings Functions:
[`kp_efficiency()`](https://hoopR.sportsdataverse.org/reference/kp_efficiency.md),
[`kp_foul_trouble()`](https://hoopR.sportsdataverse.org/reference/kp_foul_trouble.md),
[`kp_fourfactors()`](https://hoopR.sportsdataverse.org/reference/kp_fourfactors.md),
[`kp_height()`](https://hoopR.sportsdataverse.org/reference/kp_height.md),
[`kp_kpoy()`](https://hoopR.sportsdataverse.org/reference/kp_kpoy.md),
[`kp_pointdist()`](https://hoopR.sportsdataverse.org/reference/kp_pointdist.md),
[`kp_pomeroy_ratings()`](https://hoopR.sportsdataverse.org/reference/kp_pomeroy_ratings.md),
[`kp_teamstats()`](https://hoopR.sportsdataverse.org/reference/kp_teamstats.md)

## Examples

``` r
# \donttest{
try(kp_playerstats(metric = "eFG", conf_only = FALSE, year = 2021))
#>     rk                 player                   team e_fg  hgt wgt yr year
#> 1    1             Aher Uguak         Loyola Chicago 69.8  6-7 225 Sr 2021
#> 2    1         Osinachi Smart             Charleston 66.7  6-8 240 Sr 2021
#> 3    1        Ahsan Asadullah               Lipscomb 62.6  6-8 260 Jr 2021
#> 4    1      Asbjorn Midtgaard           Grand Canyon 69.7  7-0 270 Sr 2021
#> 5    1         Darien Jackson                  Tulsa 63.0  6-3 203 Sr 2021
#> 6    1       David Kachelries      Stephen F. Austin 64.0  6-1 170 Sr 2021
#> 7    1          Dwight Wilson                   Ohio 74.6  6-8 250 Sr 2021
#> 8    1        Jeremiah Tilmon               Missouri 63.1 6-10 260 Sr 2021
#> 9    1        Matt Dentlinger       South Dakota St. 68.3  6-8 240 Jr 2021
#> 10   1          Mitch Ballock              Creighton 65.8  6-5 205 Sr 2021
#> 11   1             Nick Finke                   Army 63.4  6-7 223 Sr 2021
#> 12   1          Flynn Cameron           UC Riverside 64.2  6-5 210 Jr 2021
#> 13   1         Nate Laszewski             Notre Dame 67.0 6-10 227 Jr 2021
#> 14   1           Jared Butler                 Baylor 62.7  6-3 195 Jr 2021
#> 15   1           Kyle Cardaci             Coppin St. 65.3  6-2 190 So 2021
#> 16   1          Adrian Nelson      Northern Kentucky 72.0  6-7 220 Jr 2021
#> 17   1            DJ Mitchell               Hartford 64.8  6-0 160 Jr 2021
#> 18   1         Jayden Saddler               Southern 67.9  6-1 195 Jr 2021
#> 19   1         Jamison Battle      George Washington 61.5  6-7 225 So 2021
#> 20   1          Kofi Cockburn               Illinois 66.4  7-0 285 So 2021
#> 21   1           Jubrile Belo            Montana St. 66.0  6-9 240 Jr 2021
#> 22   1            Isiah Small              Texas St. 66.9  6-8 170 Sr 2021
#> 23   1           Seth Pinkney             Quinnipiac 79.2  7-1 200 So 2021
#> 24   1            Max Fiedler                   Rice 73.8 6-11 235 So 2021
#> 25   1         Michael Moreno       Eastern Kentucky 69.3  6-7 220 So 2021
#> 26   1           Chris Duarte                 Oregon 63.5  6-6 190 Sr 2021
#> 27   1          Chris Shelton                Hampton 70.9  6-4 190 So 2021
#> 28   1           Caleb Lohner                    BYU 70.2  6-8 230 Fr 2021
#> 29   1           Jaron Rillie                Samford 76.5  6-3 175 Fr 2021
#> 30   1          Xavier DuSell                Wyoming 65.9  6-4 190 Fr 2021
#> 31   1          Mike Sixsmith           Sacred Heart 77.1  6-0 170 Fr 2021
#> 32   2          Brendan Barry                 Temple 59.9  6-2 180 Sr 2021
#> 33   2       Damien Jefferson              Creighton 61.2  6-5 220 Sr 2021
#> 34   2             Gorjok Gak            Cal Baptist 59.6 6-11 235 Sr 2021
#> 35   2           Jeriah Horne               Colorado 62.0  6-7 220 Sr 2021
#> 36   2          Romello White            Mississippi 62.4  6-8 235 Sr 2021
#> 37   2      Spencer Littleson                 Toledo 71.7  6-4 200 Sr 2021
#> 38   2            Alex Hunter                 Furman 63.3 5-11 180 Sr 2021
#> 39   2           Ayo Akinwole         Nebraska Omaha 63.1  6-0 165 Sr 2021
#> 40   2      Da'Monte Williams               Illinois 65.6  6-3 215 Sr 2021
#> 41   2        Davion Mitchell                 Baylor 60.9  6-2 205 Jr 2021
#> 42   2            Gabe Hadley           UC San Diego 66.2  6-4 200 Sr 2021
#> 43   2          Gavin Kensmil      Stephen F. Austin 63.5  6-7 260 Sr 2021
#> 44   2         Grayson Murphy                Belmont 65.2  6-2 175 Jr 2021
#> 45   2           Jamir Harris               American 61.7  6-2 198 Sr 2021
#> 46   2         Jordan Schakel          San Diego St. 65.8  6-6 200 Sr 2021
#> 47   2          Lewis Djonkam                Radford 66.4  6-9 245 Jr 2021
#> 48   2          Tanner Groves     Eastern Washington 62.1  6-9 235 Jr 2021
#> 49   2        Zachary Simmons            North Texas 69.2 6-10 239 Sr 2021
#> 50   2         Jackson Stormo                  Siena 64.8  6-9 247 Jr 2021
#> 51   2            Theo Akwuba              Louisiana 61.6 6-11 225 Jr 2021
#> 52   2           Grant Basile             Wright St. 65.1  6-9 225 So 2021
#> 53   2            Zach Walton                 Drexel 64.5  6-6 205 Sr 2021
#> 54   2        Jayden Martinez          New Hampshire 58.9  6-7 215 Jr 2021
#> 55   2           Matthew Hurt                   Duke 66.0  6-9 235 So 2021
#> 56   2           Hyunjung Lee               Davidson 60.9  6-7 210 So 2021
#> 57   2             Drew Timme                Gonzaga 69.5 6-10 235 So 2021
#> 58   2           Cyrus Largie     Florida Gulf Coast 61.8  6-3 204 So 2021
#> 59   2         Justin Webster                 Hawaii 61.5  6-3 180 So 2021
#> 60   2         Jawaun Daniels       Prairie View A&M 66.2  6-7 190 Jr 2021
#> 61   2           Hall Elisias                 Bryant 63.6  6-8 230 Sr 2021
#> 62   2        Lagio Grantsaan             Morgan St. 59.9  6-8 235 Sr 2021
#> 63   3         Bobby Planutis      Purdue Fort Wayne 64.0  6-8 200 Jr 2021
#> 64   3          Corey Kispert                Gonzaga 62.3  6-7 220 Sr 2021
#> 65   3             John Petty                Alabama 61.7  6-5 184 Sr 2021
#> 66   3          Keaton Hervey           Missouri St. 61.5  6-7 200 Jr 2021
#> 67   3           Kevin Samuel                    TCU 59.6 6-11 255 Jr 2021
#> 68   3              Matt Pile         Nebraska Omaha 60.8  6-8 240 Sr 2021
#> 69   3          Myles Johnson                Rutgers 64.3 6-11 255 Jr 2021
#> 70   3            Nate Watson             Providence 59.5 6-10 260 Sr 2021
#> 71   3         Nelly Cummings                Colgate 59.5  6-0 180 Jr 2021
#> 72   3            Prince Moss          Grambling St. 61.0  6-7 180 Sr 2021
#> 73   3           Tajion Jones          UNC Asheville 61.8  6-5 190 Jr 2021
#> 74   3            Manny Bates             N.C. State 64.9 6-11 230 So 2021
#> 75   3            Jose Placer          North Florida 61.0  6-1 174 So 2021
#> 76   3       Adam Thistlewood           Colorado St. 65.0  6-6 212 Jr 2021
#> 77   3            Andre Kelly             California 60.8  6-8 255 Jr 2021
#> 78   3            KJ Williams             Murray St. 60.5 6-10 245 Jr 2021
#> 79   3          Jalen Slawson                 Furman 62.6  6-7 218 Jr 2021
#> 80   3          Andrew Taylor               Marshall 67.6  6-3 188 So 2021
#> 81   3           Darius Brown     Cal St. Northridge 61.2  6-2 195 Jr 2021
#> 82   3        Lester Quinones                Memphis 58.7  6-5 205 So 2021
#> 83   3            Elijah Ford                 Wagner 61.5  6-5 205 Sr 2021
#> 84   3           Kvonn Cramer                Hofstra 63.5  6-6 205 Fr 2021
#> 85   3           Jalen Thomas            Georgia St. 59.3 6-10 235 So 2021
#> 86   3   Seikou Sisoho Jawara              Weber St. 61.1  6-3 195 So 2021
#> 87   3         Miroslav Stafl               Hartford 57.7 6-10 235 So 2021
#> 88   3          Rodney Carson            New Orleans 62.6  6-3 180 So 2021
#> 89   3    Nelly Junior Joseph                   Iona 62.9  6-9 230 Fr 2021
#> 90   3             JT Shumate                 Toledo 68.8  6-7 210 Jr 2021
#> 91   3           Nendah Tarke             Coppin St. 57.1  6-4 190 Fr 2021
#> 92   3         Montre' Gipson           Tarleton St. 58.5 5-11 200 Jr 2021
#> 93   3         Mustapha Amzil                 Dayton 59.0 6-10 220 Fr 2021
#> 94   4          Anthony Tarke             Coppin St. 56.9  6-6 220 Sr 2021
#> 95   4          Elijah Thomas            Cal Baptist 57.4  6-5 220 Sr 2021
#> 96   4            Isaiah Ross                   Iona 59.6  6-3 200 Sr 2021
#> 97   4            Isiah Brown              Weber St. 59.1  6-2 185 Sr 2021
#> 98   4               Jay Huff               Virginia 64.1  7-1 240 Sr 2021
#> 99   4          Ross Cummings                 Mercer 62.4  6-3 180 Sr 2021
#> 100  4         Carter Collins               Davidson 58.8  6-3 190 Sr 2021
#> 101  4        Elyjah Williams    Fairleigh Dickinson 59.8  6-7 220 Sr 2021
#> 102  4           Evan Kuhlman             Evansville 61.0  6-8 220 Sr 2021
#> 103  4            James Lewis        Appalachian St. 58.3  6-8 215 Jr 2021
#> 104  4           Jason Strong           Northeastern 62.4  6-8 210 Jr 2021
#> 105  4             Joel Ayayi                Gonzaga 62.0  6-5 180 Jr 2021
#> 106  4        Justin Mazzulla                Vermont 57.4  6-3 195 Sr 2021
#> 107  4             Sean Price    Charleston Southern 60.5  6-4 210 Jr 2021
#> 108  4              Alex King                   Army 59.4  6-8 200 Sr 2021
#> 109  4             Feron Hunt                    SMU 57.8  6-8 195 Jr 2021
#> 110  4            Darius Days                    LSU 61.3  6-7 245 Jr 2021
#> 111  4          Kyler Edwards             Texas Tech 58.1  6-4 195 Jr 2021
#> 112  4           Joe Wieskamp                   Iowa 62.1  6-6 212 Jr 2021
#> 113  4          Spencer Jones               Stanford 59.5  6-7 225 So 2021
#> 114  4            Thomas Bell            North Texas 65.8  6-6 190 Sr 2021
#> 115  4           Ben Roderick                   Ohio 60.8  6-5 205 So 2021
#> 116  4       Terrell Williams               Southern 58.2  6-5 200 Fr 2021
#> 117  4            David Roddy           Colorado St. 59.6  6-5 252 So 2021
#> 118  4              Max Abmas           Oral Roberts 60.7  6-1 165 So 2021
#> 119  4           Ben Sheppard                Belmont 60.1  6-6 185 So 2021
#> 120  4            Qudus Wahab             Georgetown 57.5 6-11 237 So 2021
#> 121  4         Carlos Rosario            McNeese St. 62.4  6-8 220 Sr 2021
#> 122  4          Micah Parrish                Oakland 63.1  6-6 188 Fr 2021
#> 123  4            Jadon Jones         Long Beach St. 61.2  6-5 170 Fr 2021
#> 124  5               DJ Jones            Florida A&M 54.8  6-9 200 Sr 2021
#> 125  5          Justin Gorham                Houston 57.1  6-7 225 Sr 2021
#> 126  5             Mark Crowe               Cal Poly 59.3  6-5 205 Sr 2021
#> 127  5             Mark Vital                 Baylor 57.4  6-5 250 Sr 2021
#> 128  5           Michael Henn               Portland 61.7  6-8 225 Sr 2021
#> 129  5             Peter Kiss                 Bryant 58.8  6-5 200 Jr 2021
#> 130  5             Sam Hauser               Virginia 64.1  6-8 218 Sr 2021
#> 131  5       Alessandro Lever           Grand Canyon 57.1 6-10 235 Sr 2021
#> 132  5       Brandon McKissic                   UMKC 60.2  6-3 195 Sr 2021
#> 133  5           Donald Carey             Georgetown 57.0  6-5 187 Sr 2021
#> 134  5              Dre Marin          Southern Utah 58.9  6-0 175 Sr 2021
#> 135  5          Jalon Pipkins      Purdue Fort Wayne 61.7  6-4 195 Sr 2021
#> 136  5             Kyle Young               Ohio St. 60.9  6-8 225 Sr 2021
#> 137  5          Maxwell Evans             Vanderbilt 59.8  6-2 190 Sr 2021
#> 138  5           Tervell Beck               Kent St. 60.5  6-7 230 Sr 2021
#> 139  5         Dominick Welch        St. Bonaventure 57.7  6-5 200 Jr 2021
#> 140  5        Elijah McCadden       Georgia Southern 57.8  6-4 210 Jr 2021
#> 141  5      Berrick JeanLouis                   Iona 58.0  6-4 195 Jr 2021
#> 142  5         Charles Bassey       Western Kentucky 64.9 6-11 235 Jr 2021
#> 143  5             Nevin Zink            USC Upstate 60.0  6-9 230 Jr 2021
#> 144  5          Neemias Queta               Utah St. 58.4  7-0 245 Jr 2021
#> 145  5             Gaige Prim           Missouri St. 60.7  6-8 235 Sr 2021
#> 146  5           Chico Carter             Murray St. 59.8  6-2 190 So 2021
#> 147  5          Isaiah Powell                Vermont 56.8  6-6 220 Jr 2021
#> 148  5       Demarkus Lampley        Sam Houston St. 60.0  6-2 170 Sr 2021
#> 149  5            Xander Rice               Bucknell 58.8  6-3 184 So 2021
#> 150  5           Justin Amadi          James Madison 61.0  6-7 220 Fr 2021
#> 151  5            Trey Bonham                    VMI 60.9  6-0 170 Fr 2021
#> 152  5          Alex Peterson           Kennesaw St. 59.0  6-7 217 Jr 2021
#> 153  5     Bennedict Mathurin                Arizona 57.8  6-7 195 Fr 2021
#> 154  5           Samkelo Cele               Southern 54.8  6-5 210 Jr 2021
#> 155  6         Ethan Claycomb             Bellarmine 56.8  6-7 205 Sr 2021
#> 156  6        Jordan Bohannon                   Iowa 59.9  6-1 175 Sr 2021
#> 157  6           MaCio Teague                 Baylor 56.6  6-4 195 Sr 2021
#> 158  6        Shandon Goldman         Tennessee Tech 58.9 6-10 225 Sr 2021
#> 159  6           Travis Atson         St. Francis NY 58.8  6-5 200 Sr 2021
#> 160  6          Bryan Trimble                  Akron 59.7  6-2 185 Jr 2021
#> 161  6          Bryce Moragne            Florida A&M 52.8  6-5 220 Sr 2021
#> 162  6    Cheikh Mbacke Diong                   UNLV 58.3 6-11 235 Sr 2021
#> 163  6          Josh Nicholas       Louisiana Monroe 57.6  6-3 190 Sr 2021
#> 164  6              Kim Aiken     Eastern Washington 58.7  6-7 215 Jr 2021
#> 165  6              LJ Thorpe          UNC Asheville 59.3  6-5 215 Jr 2021
#> 166  6            Taylor Funk         Saint Joseph's 57.5  6-8 215 Jr 2021
#> 167  6              Theo John              Marquette 56.5  6-9 245 Sr 2021
#> 168  6              Trey Wade            Wichita St. 54.7  6-6 221 Sr 2021
#> 169  6           George Papas               Monmouth 57.9  6-5 175 Sr 2021
#> 170  6        Colin Castleton                Florida 58.1 6-11 231 Jr 2021
#> 171  6        Michael Forrest       Florida Atlantic 61.4  6-0 175 Jr 2021
#> 172  6            Trey Murphy               Virginia 62.5  6-9 206 Jr 2021
#> 173  6       Guglielmo Caruso            Santa Clara 58.2 6-11 210 Jr 2021
#> 174  6             Amadou Sow       UC Santa Barbara 58.6  6-9 235 Jr 2021
#> 175  6         Josh Alexander               American 57.8  6-8 243 Jr 2021
#> 176  6      Jayveous McKinnis            Jackson St. 54.0  6-7 220 Jr 2021
#> 177  6           Ebby Asamoah               Delaware 60.9  6-4 200 So 2021
#> 178  6          Keith Clemons         Loyola Chicago 60.7  6-1 180 Sr 2021
#> 179  6            Dan Petcash             Binghamton 56.2  6-4 190 So 2021
#> 180  6        Trenton Massner       Northwestern St. 59.4  6-2 170 Jr 2021
#> 181  6         Daniel Oladapo                Oakland 61.5  6-7 222 Jr 2021
#> 182  6            Xavier Cork       Western Carolina 60.1  6-9 235 So 2021
#> 183  6          Pelle Larsson                   Utah 57.4  6-5 215 Fr 2021
#> 184  6          Xavier Fuller           South Dakota 59.5  6-4 170 Jr 2021
#> 185  6           Emeka Udenyi                Seattle 55.6  6-6 225 Jr 2021
#> 186  7        Carson Williams       Western Kentucky 60.0  6-5 240 Sr 2021
#> 187  7           Grant Golden               Richmond 57.1 6-10 255 Sr 2021
#> 188  7           James Butler                 Drexel 60.5  6-8 242 Sr 2021
#> 189  7               Ty Groce       Eastern Michigan 57.6  6-8 215 Sr 2021
#> 190  7          Austin Butler             Holy Cross 56.6  6-5 212 Sr 2021
#> 191  7       Cameron Christon          Grambling St. 53.4  6-6 190 Jr 2021
#> 192  7       Greg Kuakumensah                Niagara 56.6  6-6 200 Sr 2021
#> 193  7           Joe Quintana       Loyola Marymount 57.5  6-2 170 Jr 2021
#> 194  7          Jose Alvarado           Georgia Tech 61.0  6-0 179 Sr 2021
#> 195  7              Nik Mains       Northern Arizona 58.6  6-9 205 Jr 2021
#> 196  7         Oscar da Silva               Stanford 57.1  6-9 230 Sr 2021
#> 197  7              Eral Penn                    LIU 58.4  6-7 210 Jr 2021
#> 198  7      Marcus Zegarowski              Creighton 56.1  6-2 180 Jr 2021
#> 199  7            Tray Maddox      Cal St. Fullerton 57.2  6-6 200 Jr 2021
#> 200  7               LJ Owens                   UMBC 56.2  6-3 165 Jr 2021
#> 201  7       Sherwyn Devonish             Morgan St. 52.6  6-1 192 Jr 2021
#> 202  7               Bul Kuol                Detroit 61.1  6-7 205 Sr 2021
#> 203  7            Sean McNeil          West Virginia 56.3  6-3 210 Jr 2021
#> 204  7       Messiah Thompson               Campbell 59.0  5-8 165 So 2021
#> 205  7          Caleb Asberry              Texas St. 57.3  6-3 170 Jr 2021
#> 206  7          Stephen Clark            The Citadel 58.7  6-8 200 So 2021
#> 207  7             Ralph Agee           San Jose St. 58.2  6-8 235 Sr 2021
#> 208  7           Franz Wagner               Michigan 57.7  6-9 220 So 2021
#> 209  7          Josiah Allick                   UMKC 59.4  6-8 225 So 2021
#> 210  7           Reed Nottage            Cal Baptist 55.2  6-6 215 So 2021
#> 211  7        Jaylin Williams                 Auburn 57.1  6-8 230 So 2021
#> 212  7             Rienk Mast                Bradley 60.1  6-9 240 Fr 2021
#> 213  7              Eric Reed Southeast Missouri St. 58.7  6-2 190 Jr 2021
#> 214  7           Donte Powers        Sam Houston St. 59.3  6-2 180 Jr 2021
#> 215  7             Sion James                 Tulane 54.4  6-5 205 Fr 2021
#> 216  7             CJ Fleming             Bellarmine 55.0  6-0 180 Sr 2021
#> 217  8         Johnny McCants         New Mexico St. 55.2  6-7 235 Sr 2021
#> 218  8            Marcus Burk                  IUPUI 57.9  6-3 195 Sr 2021
#> 219  8            Alex Arians       South Dakota St. 58.5  6-4 210 Jr 2021
#> 220  8         Casdon Jardine                 Hawaii 56.1  6-7 215 Sr 2021
#> 221  8        De'Vondre Perry                 Temple 53.5  6-7 220 Sr 2021
#> 222  8             Jamal Cain              Marquette 55.4  6-7 200 Sr 2021
#> 223  8            James Baker           Morehead St. 58.4  6-6 205 Sr 2021
#> 224  8        Jhivvan Jackson                   UTSA 58.4  6-0 170 Sr 2021
#> 225  8       Ledarrius Brewer     East Tennessee St. 57.9  6-5 190 Jr 2021
#> 226  8           Matt Johnson      Northern Colorado 58.5  6-2 180 Jr 2021
#> 227  8               PJ Horne                Georgia 57.1  6-6 230 Sr 2021
#> 228  8           Trevor Moore             Morgan St. 52.4  6-5 195 Jr 2021
#> 229  8        Sukhmail Mathon      Boston University 55.7 6-10 225 Sr 2021
#> 230  8           Umoja Gibson               Oklahoma 55.7  6-1 176 Jr 2021
#> 231  8        Warren Williams              Manhattan 56.0  6-9 240 Jr 2021
#> 232  8        Antonio Rizzuto                 Albany 53.6  6-3 195 Jr 2021
#> 233  8         Luka Brajkovic               Davidson 56.7 6-10 250 Jr 2021
#> 234  8          Dravon Mangum                Radford 58.7  6-8 200 So 2021
#> 235  8          Nolan Bertain Texas A&M Corpus Chris 58.8  6-4 185 Sr 2021
#> 236  8           Ivan Alipiev       Loyola Marymount 57.2  6-8 215 Jr 2021
#> 237  8         Tremell Murphy                  Drake 59.6  6-6 210 Sr 2021
#> 238  8              AJ Walker              Air Force 57.5  6-2 191 Jr 2021
#> 239  8         TJ Bickerstaff                 Drexel 60.0  6-9 207 So 2021
#> 240  8           Brandon Rush    Fairleigh Dickinson 58.1  6-3 175 So 2021
#> 241  8        Donovan Gregory        Appalachian St. 55.4  6-5 190 So 2021
#> 242  8          Jalen Johnson            Alabama A&M 53.3  6-7 230 So 2021
#> 243  8      Giovanni Santiago               Kent St. 57.5  6-1 155 So 2021
#> 244  8         Hunter Cattoor          Virginia Tech 60.4  6-3 200 So 2021
#> 245  8            Evan Mobley                    USC 57.0  7-0 215 Fr 2021
#> 246  8       Hunter Dickinson               Michigan 56.9  7-1 255 Fr 2021
#> 247  9           Austin Phyfe          Northern Iowa 59.5  6-9 250 Jr 2021
#> 248  9           Brock Miller               Utah St. 56.2  6-5 200 Jr 2021
#> 249  9         Cedric Russell              Louisiana 55.4  6-2 190 Sr 2021
#> 250  9            Jabari Rice         New Mexico St. 53.7  6-4 180 Jr 2021
#> 251  9           Jalen Adaway        St. Bonaventure 56.4  6-5 210 Jr 2021
#> 252  9       Jermaine Samuels              Villanova 55.3  6-7 230 Sr 2021
#> 253  9           Matt Coleman                  Texas 55.4  6-2 180 Sr 2021
#> 254  9           Pedro Castro        Houston Baptist 58.3  6-6 185 Jr 2021
#> 255  9             Stef Smith                Vermont 53.4  6-2 190 Sr 2021
#> 256  9        Tydus Verhoeven                   UTEP 57.7  6-9 225 Jr 2021
#> 257  9             Tyree Eady       North Dakota St. 58.3  6-5 210 Jr 2021
#> 258  9           Melik Martin               Monmouth 53.8  6-6 200 Sr 2021
#> 259  9        Andrew Nembhard                Gonzaga 56.9  6-5 193 Jr 2021
#> 260  9            LJ Figueroa                 Oregon 56.5  6-6 200 Sr 2021
#> 261  9           Miles Norris       UC Santa Barbara 56.0 6-10 220 Jr 2021
#> 262  9             Myja White               Miami OH 56.9  6-1 185 So 2021
#> 263  9      Maurice Commander       Illinois Chicago 57.8  6-0 175 Jr 2021
#> 264  9          Ricky Clemons               Campbell 58.3  6-2 205 Jr 2021
#> 265  9            Ryan Larson                Wofford 57.7  6-1 175 Jr 2021
#> 266  9        Malik Jefferson       Mount St. Mary's 56.0  6-9 230 Jr 2021
#> 267  9         Cameron Parker                Montana 56.3  6-2 170 Jr 2021
#> 268  9      Jeremiah Gambrell       Prairie View A&M 52.5  6-3 180 So 2021
#> 269  9             Tolu Smith        Mississippi St. 56.8 6-10 245 So 2021
#> 270  9        Jae'Lyn Withers             Louisville 58.2  6-8 230 Fr 2021
#> 271  9          Quirin Emanga           Northeastern 59.5  6-5 220 So 2021
#> 272  9         Chase Johnston                Stetson 54.5  6-2 185 Fr 2021
#> 273  9           Santi Aldama              Loyola MD 55.7 6-11 215 So 2021
#> 274  9            Donta Scott               Maryland 56.4  6-7 230 So 2021
#> 275  9        Rahsaan Edwards     South Carolina St. 52.3  6-0 200 So 2021
#> 276  9     Jeremiah Davenport             Cincinnati 53.2  6-7 205 So 2021
#> 277  9           Johni Broome           Morehead St. 58.0 6-10 235 Fr 2021
#> 278  9         Jace Roquemore           UC San Diego 60.0  6-5 160 Fr 2021
#> 279 10             Jalen Tate               Arkansas 56.7  6-6 175 Sr 2021
#> 280 10         Justin Hopkins         Texas Southern 52.2  6-5 205 Sr 2021
#> 281 10             Tahj Eaddy                    USC 55.7  6-2 165 Sr 2021
#> 282 10            Aamir Simms                Clemson 57.8  6-8 245 Sr 2021
#> 283 10       Collin Gillespie              Villanova 54.9  6-3 190 Sr 2021
#> 284 10         Darnell Brodie                  Drake 59.3 6-10 275 Jr 2021
#> 285 10      Garrett Covington         Youngstown St. 57.8  6-5 200 Sr 2021
#> 286 10           Jacob Rigoni             Quinnipiac 53.6  6-6 190 Sr 2021
#> 287 10        Jaheam Cornwall           Gardner Webb 58.1  6-0 175 Sr 2021
#> 288 10            James Reese            North Texas 57.6  6-4 167 Sr 2021
#> 289 10           Javon Greene           George Mason 56.4  6-2 190 Sr 2021
#> 290 10        David McCormack                 Kansas 53.9 6-10 250 Jr 2021
#> 291 10          RJ Eytle-Rock                   UMBC 52.5  6-3 225 Jr 2021
#> 292 10             Pete Nance           Northwestern 56.1 6-10 225 Jr 2021
#> 293 10           Kendle Moore           Colorado St. 56.2 5-10 151 Jr 2021
#> 294 10          Finn Sullivan              San Diego 56.9  6-4 175 Jr 2021
#> 295 10       DeAndre Williams                Memphis 53.0  6-9 190 Jr 2021
#> 296 10         Pedro Bradshaw             Bellarmine 53.9  6-7 185 Jr 2021
#> 297 10       Derek St Hilaire            New Orleans 58.1  6-0 180 Sr 2021
#> 298 10         Maizen Fausett          Southern Utah 56.1  6-6 225 Jr 2021
#> 299 10           Kevin Obanor           Oral Roberts 58.2  6-8 225 Jr 2021
#> 300 10           Walter Ellis               Bucknell 55.1  6-5 190 Jr 2021
#> 301 10          B Artis White       Western Michigan 56.8  6-0 150 So 2021
#> 302 10          Charles Pride                 Bryant 55.4  6-4 185 So 2021
#> 303 10          Ruot Monyyong            Little Rock 55.2 6-10 215 Sr 2021
#> 304 10         Kamdyn Curfman                    VMI 56.6  6-1 186 So 2021
#> 305 10         Jaron Williams       Tennessee Martin 57.6  6-6 210 Jr 2021
#> 306 10         Darius Burford                   Elon 58.6  6-0 160 Fr 2021
#> 307 10       Alex Merkviladze     Cal St. Northridge 54.7  6-9 225 Fr 2021
#> 308 10       Hunter Schofield              Dixie St. 53.3  6-8 225 Sr 2021
#> 309 10            Jalen Speer            Florida A&M 52.3  6-1 172 Fr 2021
#> 310 11         Derrick Alston              Boise St. 56.0  6-9 190 Sr 2021
#> 311 11             Ibi Watson                 Dayton 56.1  6-5 195 Sr 2021
#> 312 11     JaQuori McLaughlin       UC Santa Barbara 52.8  6-4 190 Sr 2021
#> 313 11       Michael Weathers         Texas Southern 51.8  6-3 175 Sr 2021
#> 314 11        Cameron Krutwig         Loyola Chicago 57.6  6-9 255 Sr 2021
#> 315 11          Dalonte Brown               Miami OH 56.2  6-7 205 Sr 2021
#> 316 11              Evan Cole            Utah Valley 52.6 6-10 230 Sr 2021
#> 317 11              MJ Walker            Florida St. 56.7  6-5 213 Sr 2021
#> 318 11             Myles Cale             Seton Hall 54.8  6-6 210 Sr 2021
#> 319 11           Storm Murphy                Wofford 56.5  6-0 180 Sr 2021
#> 320 11            Tevin Brown             Murray St. 55.4  6-5 175 Jr 2021
#> 321 11       Jordan Whitfield               Campbell 57.8  6-1 175 Sr 2021
#> 322 11          Brandon Mahan                    UCF 53.0  6-5 205 Sr 2021
#> 323 11            Eli Parquet               Colorado 55.2  6-3 195 Jr 2021
#> 324 11            John Knight          Southern Utah 55.6  6-3 205 Sr 2021
#> 325 11          Bentiu Panoam           North Dakota 57.5  6-2 168 Sr 2021
#> 326 11         Jarred Godfrey      Purdue Fort Wayne 57.0  6-5 185 Jr 2021
#> 327 11      Tucker Richardson                Colgate 54.7  6-5 205 Jr 2021
#> 328 11          Dwight Murray                  Rider 52.5  6-0 180 Jr 2021
#> 329 11        Nick Guadarrama          New Hampshire 52.0  6-5 250 Jr 2021
#> 330 11           Malik Miller             Morgan St. 52.2  6-4 191 Jr 2021
#> 331 11         De'Vion Harmon               Oklahoma 53.7  6-2 198 So 2021
#> 332 11          Dru Kuxhausen            McNeese St. 57.1  6-0 180 Sr 2021
#> 333 11           Paul Mulcahy                Rutgers 56.1  6-6 210 So 2021
#> 334 11            Marko Lukic            Little Rock 54.9  6-7 195 So 2021
#> 335 11            Joe Pridgen         UNC Wilmington 58.3  6-5 210 So 2021
#> 336 11        Isaiah Crawford         Louisiana Tech 57.1  6-6 220 So 2021
#> 337 11       Pierre Crockrell                Pacific 55.6  6-0 175 So 2021
#> 338 11         Emanuel Miller              Texas A&M 55.0  6-7 208 So 2021
#> 339 11          Mykel Derring              Merrimack 55.1  6-2 180 So 2021
#> 340 11            Juston Betz             Bellarmine 53.8  6-3 190 Jr 2021
#> 341 12              Abdul Ado        Mississippi St. 54.0 6-11 255 Sr 2021
#> 342 12             Ben Coupet            Little Rock 54.7  6-7 185 Sr 2021
#> 343 12          DeJon Jarreau                Houston 52.9  6-5 185 Sr 2021
#> 344 12             Jock Perry           UC Riverside 52.6  7-1 250 Sr 2021
#> 345 12             Mike Smith               Michigan 55.4 5-11 185 Sr 2021
#> 346 12           Jon Williams          Robert Morris 57.0  6-1 185 Sr 2021
#> 347 12           Kellan Grady               Davidson 55.7  6-5 205 Sr 2021
#> 348 12      Shaquille Walters           Northeastern 58.2  6-6 200 Jr 2021
#> 349 12          Terrell Gomez          San Diego St. 55.2  5-8 165 Sr 2021
#> 350 12        Tristan Jarrett            Jackson St. 50.9  6-4 195 Sr 2021
#> 351 12           Ochai Agbaji                 Kansas 52.7  6-5 215 Jr 2021
#> 352 12          Jawaun Newton             Evansville 57.3  6-3 170 Jr 2021
#> 353 12         Uche Dibiamaka   UT Rio Grande Valley 51.6  6-4 195 Jr 2021
#> 354 12           Dalvin White            USC Upstate 56.8 5-10 170 Jr 2021
#> 355 12          Tyler Bertram             Binghamton 51.1  6-3 185 So 2021
#> 356 12          Kyonze Chavis            Norfolk St. 51.2  6-4 195 Sr 2021
#> 357 12          Al-Amir Dawes                Clemson 56.4  6-2 180 So 2021
#> 358 12          Gabe Quinnett                  Idaho 55.6  6-4 201 So 2021
#> 359 12              Ty Gordon           Nicholls St. 57.0  6-1 200 Sr 2021
#> 360 12        Alfonso Plummer                   Utah 55.0  6-1 182 Sr 2021
#> 361 12            Travis Evee                   Rice 55.8  6-1 180 So 2021
#> 362 12            Sean Conway                    VMI 56.2  6-5 215 So 2021
#> 363 12        Tasos Kamateros           South Dakota 57.0  6-8 240 So 2021
#> 364 12            Jordan King                  Siena 51.7  6-0 175 So 2021
#> 365 12          Keli Leaupepe       Loyola Marymount 54.4  6-6 248 So 2021
#> 366 12            Carlos Paez            Austin Peay 54.6 5-10 180 So 2021
#> 367 12          Mikey Watkins              Merrimack 53.3 5-11 175 Jr 2021
#> 368 12        Romeao Ferguson               Lipscomb 53.5  6-5 195 Sr 2021
#> 369 12          Dawson Garcia              Marquette 54.1 6-11 235 Fr 2021
#> 370 12           Kyle Jenkins              Lafayette 54.0  6-7 213 Fr 2021
#> 371 13    Jalen Coleman-Lands               Iowa St. 52.7  6-4 187 Sr 2021
#> 372 13             Ben Shungu                Vermont 51.0  6-2 200 Sr 2021
#> 373 13      Cainan McClelland            Jackson St. 50.6  6-4 180 Sr 2021
#> 374 13              Dru Smith               Missouri 53.1  6-3 203 Sr 2021
#> 375 13              Eli Scott       Loyola Marymount 54.1  6-6 232 Sr 2021
#> 376 13            Greg Parham                    VMI 56.1  6-4 176 Sr 2021
#> 377 13          Isaiah Livers               Michigan 54.9  6-7 230 Sr 2021
#> 378 13        Justin Jaworski              Lafayette 53.4  6-3 196 Sr 2021
#> 379 13           Mladen Armus              Boise St. 54.8 6-10 232 Jr 2021
#> 380 13               PJ Pipes              Green Bay 56.9  6-2 190 Sr 2021
#> 381 13              TJ Starks     Cal St. Northridge 52.3  6-2 196 Jr 2021
#> 382 13            Alex Watson           Sacred Heart 52.7  6-3 170 Sr 2021
#> 383 13      Payton Youngblood          North Alabama 53.5  6-5 200 Sr 2021
#> 384 13          Michael Devoe           Georgia Tech 56.2  6-5 197 Jr 2021
#> 385 13              Jamal Bey             Washington 54.9  6-6 210 Jr 2021
#> 386 13          Fardaws Aimaq            Utah Valley 50.8 6-11 245 So 2021
#> 387 13         Skyelar Potter           Morehead St. 54.6  6-3 198 Jr 2021
#> 388 13         Eddy Kayouloud       Central Arkansas 56.8  6-7 220 Jr 2021
#> 389 13         Landers Nolley                Memphis 52.6  6-7 220 So 2021
#> 390 13            Kobi Nwandu                Niagara 50.8  6-6 210 Sr 2021
#> 391 13        Luke Bumbalough               Ball St. 54.8  6-1 180 So 2021
#> 392 13               DJ Horne           Illinois St. 56.5  6-1 175 So 2021
#> 393 13           Tyler Burton               Richmond 55.7  6-7 215 So 2021
#> 394 13             Kyle Owens                Montana 55.2  6-8 205 So 2021
#> 395 13              DJ Carton              Marquette 52.1  6-2 200 So 2021
#> 396 13         Brice Williams              Charlotte 55.3  6-7 215 So 2021
#> 397 13          AJ Plitzuweit           South Dakota 56.8  6-2 170 So 2021
#> 398 13          Garrick Green       Coastal Carolina 54.4  6-6 215 Sr 2021
#> 399 13          Davion Warren                Hampton 54.6  6-6 210 Sr 2021
#> 400 13            Andrew Carr               Delaware 58.2  6-9 210 Fr 2021
#> 401 13             Bryce Pope           UC San Diego 55.6  6-3 185 Fr 2021
#> 402 13           Themus Fulks     South Carolina St. 50.0  6-1 185 Fr 2021
#> 403 14           Andrew Jones                  Texas 52.6  6-4 192 Jr 2021
#> 404 14    David Jean-Baptiste            Chattanooga 56.0  6-1 193 Sr 2021
#> 405 14           Josh Parrish              San Diego 54.0  6-4 215 Sr 2021
#> 406 14            Loudon Love             Wright St. 56.3  6-8 260 Sr 2021
#> 407 14           Tareq Coburn                Hofstra 55.9  6-5 205 Sr 2021
#> 408 14         Dajour Dickens                Hampton 53.8  7-0 215 Jr 2021
#> 409 14         Jalen Crutcher                 Dayton 55.4  6-1 175 Sr 2021
#> 410 14           Jordan Usher           Georgia Tech 55.7  6-7 213 Sr 2021
#> 411 14       Keyshawn Feazell            McNeese St. 56.5  6-9 235 Sr 2021
#> 412 14              Lat Mayen               Nebraska 54.0  6-9 205 Jr 2021
#> 413 14          Mike Adewunmi       SIU Edwardsville 53.9  6-5 205 Sr 2021
#> 414 14        Troymain Crosby             Alcorn St. 50.3  6-4 200 Sr 2021
#> 415 14             Tyreke Key            Indiana St. 56.2  6-3 205 Sr 2021
#> 416 14          Tyrese Martin            Connecticut 52.0  6-6 215 Jr 2021
#> 417 14            Jake Wojcik              Fairfield 50.3  6-5 190 Jr 2021
#> 418 14             Noah Locke                Florida 52.5  6-3 203 Jr 2021
#> 419 14            Tavin Lovan                    UAB 55.1  6-4 210 Jr 2021
#> 420 14            Kur Jockuch      Northern Colorado 54.5  6-9 220 Jr 2021
#> 421 14          Mason Harrell              Texas St. 53.9  5-9 145 Jr 2021
#> 422 14             Joe Bryant            Norfolk St. 49.6  6-1 225 Jr 2021
#> 423 14          Josh Caldwell                   Army 53.3  6-2 185 Jr 2021
#> 424 14          Dae Dae Grant               Miami OH 54.7  6-2 185 So 2021
#> 425 14          Will Martinez                 Wagner 52.7  6-5 190 Sr 2021
#> 426 14            Darin Green                    UCF 52.4  6-4 185 So 2021
#> 427 14         Connor Withers           UMass Lowell 50.8  6-7 195 So 2021
#> 428 14           Jaime Jaquez                   UCLA 53.7  6-6 220 So 2021
#> 429 14      Baylor Scheierman       South Dakota St. 56.2  6-6 180 So 2021
#> 430 14          Elijah Pepper               UC Davis 52.2  6-4 200 So 2021
#> 431 14          Tre Armstrong            Cal Baptist 50.4  6-5 210 So 2021
#> 432 14            Tre Coleman                 Nevada 54.6  6-7 185 Fr 2021
#> 433 15          Dylan Painter               Delaware 55.9 6-10 235 Sr 2021
#> 434 15            Troy Baxter             Morgan St. 49.4  6-9 200 Sr 2021
#> 435 15        Ben Vander Plas                   Ohio 54.2  6-8 232 Jr 2021
#> 436 15           Darius Perry                    UCF 51.3  6-2 185 Sr 2021
#> 437 15       Dominick Pickett           UC Riverside 52.2  6-3 210 Sr 2021
#> 438 15           RaiQuan Gray            Florida St. 55.4  6-8 260 Jr 2021
#> 439 15           Terry Taylor            Austin Peay 53.6  6-5 230 Sr 2021
#> 440 15       Trevion Williams                 Purdue 53.9 6-10 265 Jr 2021
#> 441 15   Tyreek Scott-Grayson                    UAB 54.8  6-5 180 Sr 2021
#> 442 15          Trey Woodbury            Utah Valley 50.4  6-4 200 Jr 2021
#> 443 15          Jake Stephens                    VMI 55.9 6-10 266 Jr 2021
#> 444 15           Koreem Ozier       Louisiana Monroe 52.5  6-1 180 Jr 2021
#> 445 15          Brandon Swaby         Incarnate Word 55.8  6-3 170 So 2021
#> 446 15           Tykei Greene            Stony Brook 50.4  6-4 205 Jr 2021
#> 447 15               KC Ndefo          Saint Peter's 50.0  6-7 195 Jr 2021
#> 448 15             KJ Johnson               Lipscomb 52.6  6-2 170 So 2021
#> 449 15      Julian Champagnie             St. John's 51.8  6-8 220 So 2021
#> 450 15          Christian Ray               La Salle 54.9  6-6 215 So 2021
#> 451 15            Golden Dike              Loyola MD 53.0 6-10 250 So 2021
#> 452 15      Kruz Perrott-Hunt           South Dakota 56.2  6-3 195 So 2021
#> 453 15         Allen Flanigan                 Auburn 52.5  6-6 215 So 2021
#> 454 15         Isaiah Stevens           Colorado St. 53.8  6-0 180 So 2021
#> 455 15       Terreon Randolph          Grambling St. 50.0  6-8 220 Sr 2021
#> 456 15           Zahir Porter              Weber St. 54.3  6-6 180 Jr 2021
#> 457 15        Cade Cunningham           Oklahoma St. 51.8  6-8 220 Fr 2021
#> 458 15         Demarcus Sharp           Missouri St. 56.1  6-3 170 Jr 2021
#> 459 15        Marques Warrick      Northern Kentucky 55.7  6-2 170 Fr 2021
#> 460 15     D'Maurian Williams           Gardner Webb 53.6  6-5 195 Fr 2021
#> 461 15            Josh Reaves       Mount St. Mary's 52.3  6-4 205 Fr 2021
#> 462 15        Azuolas Tubelis                Arizona 52.7 6-11 245 Fr 2021
#> 463 15          Latrell Jones               Portland 53.9  6-5 175 Jr 2021
#> 464 16           Darian Adams       Jacksonville St. 53.1  6-3 200 Sr 2021
#> 465 16     Justin Edler-Davis    Cal St. Bakersfield 52.0  6-4 220 Sr 2021
#> 466 16        Austin Williams               Hartford 50.3  6-4 200 Sr 2021
#> 467 16        Galen Alexander         Texas Southern 49.5  6-6 220 Sr 2021
#> 468 16            Isaac Kante                Hofstra 55.1  6-7 240 Jr 2021
#> 469 16          Isaiah Whaley            Connecticut 51.7  6-9 230 Sr 2021
#> 470 16            Jarrod West               Marshall 53.8 5-11 181 Sr 2021
#> 471 16            John Harrar               Penn St. 53.9  6-9 240 Sr 2021
#> 472 16            Justin Bean               Utah St. 53.2  6-7 210 Jr 2021
#> 473 16           Luke Johnson              Loyola MD 52.3  6-3 180 Sr 2021
#> 474 16        Marreon Jackson                 Toledo 54.0  6-1 200 Sr 2021
#> 475 16          Reggie Miller      Abilene Christian 55.4  6-0 150 Sr 2021
#> 476 16           Stefan Kenic            Chattanooga 55.3  6-9 223 Sr 2021
#> 477 16          Logan Johnson           Saint Mary's 53.5  6-2 170 Jr 2021
#> 478 16         Quentin Grimes                Houston 50.5  6-5 205 Jr 2021
#> 479 16           Alan Griffin               Syracuse 55.0  6-5 190 Jr 2021
#> 480 16          Jules Bernard                   UCLA 52.0  6-6 205 Jr 2021
#> 481 16        Michael Meadows     Eastern Washington 53.9  6-2 175 So 2021
#> 482 16        Spencer Rodgers           Kennesaw St. 51.9  6-4 178 Jr 2021
#> 483 16          Javonte Smart                    LSU 52.4  6-4 205 Jr 2021
#> 484 16        Majesty Brandon               Canisius 49.6  6-0 170 Sr 2021
#> 485 16         Deonte Billups      Purdue Fort Wayne 55.6  6-4 200 So 2021
#> 486 16        Jamison Overton            Utah Valley 50.0  6-6 190 Sr 2021
#> 487 16           Jaren Holmes        St. Bonaventure 54.7  6-4 215 Jr 2021
#> 488 16            Sam Griffin           UT Arlington 52.5  6-3 180 So 2021
#> 489 16      Ville Tahvanainen                Bradley 54.9  6-4 210 So 2021
#> 490 16           Omar Croskey     South Carolina St. 49.3  6-5 200 So 2021
#> 491 16           Chris Childs                 Bryant 52.0  6-2 180 Jr 2021
#> 492 16          Rondel Walker           Oklahoma St. 51.5  6-4 170 Fr 2021
#> 493 16           Jordan Sears           Gardner Webb 53.5 5-11 175 Fr 2021
#> 494 16            Will Carius       Western Illinois 56.1  6-7 225 Sr 2021
#> 495 17              Bryce Nze                 Butler 50.9  6-7 230 Sr 2021
#> 496 17        Jeremy Sheppard           Rhode Island 54.7  6-1 165 Sr 2021
#> 497 17           Oscar Frayer           Grand Canyon 49.3  6-6 195 Sr 2021
#> 498 17             Ty Flowers                    LIU 51.5  6-9 200 Sr 2021
#> 499 17          Alex Barcello                    BYU 53.5  6-2 180 Sr 2021
#> 500 17        Brandon Horvath                   UMBC 50.0 6-10 210 Sr 2021
#> 501 17          Elijah Joiner                  Tulsa 50.0  6-3 201 Sr 2021
#> 502 17          Marcus Shaver              Boise St. 52.9  6-2 185 Jr 2021
#> 503 17           Moses Wright           Georgia Tech 54.6  6-9 233 Sr 2021
#> 504 17            Noah Gurley                 Furman 54.3  6-8 210 Jr 2021
#> 505 17              Yves Pons              Tennessee 52.1  6-6 215 Sr 2021
#> 506 17      Riley Abercrombie                   Rice 53.0 6-10 210 So 2021
#> 507 17        De'Torrion Ware             Morgan St. 49.0  6-4 200 Jr 2021
#> 508 17                Jr Clay         Tennessee Tech 52.7  6-0 170 Jr 2021
#> 509 17          Jalen Pickett                  Siena 49.3  6-4 202 Jr 2021
#> 510 17           Greg Summers                   Navy 52.1  6-4 200 Jr 2021
#> 511 17        Christian Braun                 Kansas 51.0  6-6 210 So 2021
#> 512 17         Brayden Parker              Idaho St. 53.1  6-8 250 So 2021
#> 513 17       Cedric Henderson               Campbell 53.1  6-6 190 Jr 2021
#> 514 17          Tanner Holden             Wright St. 55.5  6-6 185 So 2021
#> 515 17             EJ Liddell               Ohio St. 53.8  6-7 240 So 2021
#> 516 17         Douglas Wilson       South Dakota St. 53.7  6-7 210 Sr 2021
#> 517 17        Cameron Johnson      Stephen F. Austin 54.7  6-4 216 Sr 2021
#> 518 17             Ben Krikke             Valparaiso 54.8  6-9 230 So 2021
#> 519 17            Jonas James            Jackson St. 49.0  6-0 160 Sr 2021
#> 520 17            Zyon Pullin           UC Riverside 52.0  6-4 195 So 2021
#> 521 17         Kayo Goncalves          South Alabama 52.4  6-8 212 Sr 2021
#> 522 17      Michael O'Connell               Stanford 51.9  6-2 185 Fr 2021
#> 523 17         Meikkel Murray       Central Michigan 53.4  6-6 190 Jr 2021
#> 524 17         Connor Kochera         William & Mary 55.0  6-5 200 Fr 2021
#> 525 17             Dylan Penn             Bellarmine 51.8  6-3 190 Jr 2021
#> 526 18            Clay Mounce                 Furman 54.3  6-7 210 Sr 2021
#> 527 18            Corey Allen            Georgia St. 52.2  6-2 210 Sr 2021
#> 528 18         John Fulkerson              Tennessee 51.9  6-9 215 Sr 2021
#> 529 18            Jordan Bell                Pacific 52.8  6-8 221 Sr 2021
#> 530 18       Chauncey Hawkins         St. Francis NY 51.1  5-8 172 Sr 2021
#> 531 18         Darnell Rogers                   UMBC 49.5  5-2 150 Sr 2021
#> 532 18          David Jenkins                   UNLV 51.3  6-2 195 Jr 2021
#> 533 18          Elijah Cuffee                Liberty 51.1  6-4 185 Sr 2021
#> 534 18          Holland Woods            Arizona St. 51.5  6-1 180 Sr 2021
#> 535 18           Justyn Mutts          Virginia Tech 54.4  6-7 230 Jr 2021
#> 536 18          Kamron Reaves            Florida A&M 48.0  6-2 170 Sr 2021
#> 537 18             Luka Garza                   Iowa 53.7 6-11 265 Sr 2021
#> 538 18               Matt Faw             Holy Cross 51.9  6-9 223 Sr 2021
#> 539 18           Paul Scruggs                 Xavier 50.7  6-4 196 Sr 2021
#> 540 18          Rocky Kreuser       North Dakota St. 53.2 6-10 245 Sr 2021
#> 541 18            Taj Benning              Fairfield 48.3  6-4 202 Sr 2021
#> 542 18            Collin Welp              UC Irvine 51.8  6-9 225 Jr 2021
#> 543 18         Taevion Kinsey               Marshall 52.9  6-5 185 Jr 2021
#> 544 18             Bodie Hume      Northern Colorado 52.6  6-7 190 Jr 2021
#> 545 18            Mekhi Lairy               Miami OH 53.2  5-8 140 Jr 2021
#> 546 18       Chandler Vaudrin               Winthrop 52.2  6-7 210 Sr 2021
#> 547 18 Tremont Robinson-White          East Carolina 50.0  6-1 190 Jr 2021
#> 548 18              Roti Ware      Stephen F. Austin 54.3  6-3 187 Sr 2021
#> 549 18       Terrence Shannon             Texas Tech 51.0  6-6 210 So 2021
#> 550 18       Charles Thompson                 Towson 54.9  6-7 235 So 2021
#> 551 18         Brandon Battle            Alabama St. 47.6  6-8 215 Sr 2021
#> 552 18         Craig Beaudion          Cleveland St. 55.1  6-3 170 Sr 2021
#> 553 18     Steven Verplancken      Southern Illinois 54.8  6-4 205 So 2021
#> 554 18       Darrion Trammell                Seattle 46.9 5-10 165 So 2021
#> 555 18            Tyler Kolek           George Mason 54.6  6-3 190 Fr 2021
#> 556 18       Damaria Franklin         Tennessee Tech 52.0  6-4 210 Jr 2021
#> 557 19              KJ Walton               Ball St. 52.9  6-3 200 Sr 2021
#> 558 19            Brad Greene              UC Irvine 51.7 6-11 270 Sr 2021
#> 559 19         DeJuan Clayton             Coppin St. 47.1  6-2 185 Sr 2021
#> 560 19       Jannson Williams               Marshall 52.9  6-9 219 Sr 2021
#> 561 19          Solomon Young               Iowa St. 50.4  6-8 255 Sr 2021
#> 562 19          Damion Rosser            New Orleans 53.7  6-4 220 Jr 2021
#> 563 19           Devon Cooper           Morehead St. 51.9  6-4 201 Jr 2021
#> 564 19         Justice Sueing               Ohio St. 53.3  6-7 215 Jr 2021
#> 565 19             Ryan Allen               Delaware 53.7  6-2 200 Sr 2021
#> 566 19  Sandro Mamukelashvili             Seton Hall 50.0 6-11 240 Sr 2021
#> 567 19          Stacy Beckton               American 51.5  6-4 186 Sr 2021
#> 568 19            Alex Rivera                    LIU 51.1  6-1 185 So 2021
#> 569 19        Brandon Younger           Presbyterian 51.9  6-7 190 Jr 2021
#> 570 19            Jarius Cook       North Dakota St. 53.1  6-3 180 So 2021
#> 571 19          Malachi Smith            Chattanooga 54.2  6-4 205 So 2021
#> 572 19         DeVante' Jones       Coastal Carolina 52.0  6-1 200 Jr 2021
#> 573 19            Jamie Ahale       Illinois Chicago 54.9  6-5 205 Sr 2021
#> 574 19              Rob Perry                Stetson 50.8  6-4 210 So 2021
#> 575 19     Samuell Williamson             Louisville 54.2  6-7 210 So 2021
#> 576 19          Isiaih Mosley           Missouri St. 54.8  6-5 201 So 2021
#> 577 19         Dylan van Eyck                   Iona 48.2  6-8 210 Sr 2021
#> 578 19          Jordan Wright             Vanderbilt 51.7  6-6 226 So 2021
#> 579 19           Kwane Marble                Wyoming 51.3  6-6 195 So 2021
#> 580 19        Nah'Shon Hyland                    VCU 54.0  6-3 173 So 2021
#> 581 19          Broc Finstuen                Pacific 52.3  6-4 200 Sr 2021
#> 582 19            Jarod Lucas             Oregon St. 51.0  6-3 195 So 2021
#> 583 19          Khalid Thomas           Portland St. 52.6 6-10 210 Sr 2021
#> 584 19           Caleb Hunter Mississippi Valley St. 47.1 5-10 185 So 2021
#> 585 19       Mika Adams-Woods             Cincinnati 50.0  6-3 185 So 2021
#> 586 19           Jamel Horton                 Albany 49.5  6-4 190 Jr 2021
#> 587 19         Cameron Gooden              Dixie St. 46.2 5-11 175 Jr 2021
#> 588 20           John Pettway          South Alabama 52.0  6-3 189 Sr 2021
#> 589 20          Keon Clergeot Southeastern Louisiana 52.5  6-1 190 Sr 2021
#> 590 20            Caleb Green              Fairfield 48.1 5-10 175 Jr 2021
#> 591 20            Colbey Ross             Pepperdine 52.3  6-1 185 Sr 2021
#> 592 20         Darryl Morsell               Maryland 52.4  6-5 200 Sr 2021
#> 593 20           Felipe Haase                 Mercer 54.1  6-9 253 Jr 2021
#> 594 20        Kimani Lawrence            Arizona St. 50.9  6-8 210 Sr 2021
#> 595 20        Kameron Langley     North Carolina A&T 46.8  6-2 165 Sr 2021
#> 596 20              Tae Hardy          Southern Miss 51.9  6-3 175 Jr 2021
#> 597 20           Tevian Jones          Southern Utah 52.5  6-7 190 Jr 2021
#> 598 20        Dontarius James           Jacksonville 50.6  6-8 228 Jr 2021
#> 599 20         Garrett Sturtz                  Drake 54.8  6-3 175 Jr 2021
#> 600 20          Taelyr Gatlin                 Denver 52.5  6-3 180 Jr 2021
#> 601 20              Nic Lynch                 Lehigh 51.3 6-11 250 Jr 2021
#> 602 20          Riley Grigsby                Seattle 45.9  6-6 220 Jr 2021
#> 603 20             Shaun Doss    Arkansas Pine Bluff 45.8  6-5 185 Jr 2021
#> 604 20          Miles McBride          West Virginia 49.8  6-2 200 So 2021
#> 605 20      Justin Champagnie             Pittsburgh 53.5  6-6 200 So 2021
#> 606 20          Tyson Etienne            Wichita St. 49.7  6-2 200 So 2021
#> 607 20           Tyson Walker           Northeastern 53.6  6-0 170 So 2021
#> 608 20          Cameron Brown         Saint Joseph's 54.0  6-5 220 So 2021
#> 609 20          Chance Hunter         Long Beach St. 50.5  6-6 190 Jr 2021
#> 610 20        Devan Cambridge                 Auburn 51.6  6-6 215 So 2021
#> 611 20        Keondre Kennedy                   UMBC 48.6  6-6 180 Jr 2021
#> 612 20             Ziggy Reid              Merrimack 50.9  6-6 235 So 2021
#> 613 20           Winston Hill           Presbyterian 51.4  6-7 230 Jr 2021
#> 614 20            Jalen Finch       Jacksonville St. 51.8  6-1 165 Jr 2021
#> 615 20           Chuck Harris                 Butler 50.0  6-2 190 Fr 2021
#> 616 20           Ryan Rollins                 Toledo 52.7  6-4 180 Fr 2021
#> 617 20          Trey Townsend                Oakland 54.5  6-6 222 Fr 2021
#> 618 20        Glen McClintock              Air Force 50.8  6-2 185 Fr 2021
#> 619 21       Brandon Averette                    BYU 52.3 5-11 185 Sr 2021
#> 620 21         Eugene Omoruyi                 Oregon 50.5  6-6 235 Sr 2021
#> 621 21            Jacob Young                Rutgers 52.2  6-2 185 Sr 2021
#> 622 21          Payton Willis             Charleston 53.3  6-4 190 Sr 2021
#> 623 21      Desmond Cambridge                 Nevada 50.6  6-4 180 Jr 2021
#> 624 21      Isaiah Washington         Long Beach St. 48.6  6-1 195 Sr 2021
#> 625 21         Jahlil Jenkins    Fairleigh Dickinson 50.6  6-0 160 Sr 2021
#> 626 21          Javante McCoy      Boston University 50.9  6-5 180 Sr 2021
#> 627 21             Javon Levi   UT Rio Grande Valley 45.5 5-11 175 Sr 2021
#> 628 21            Koby Thomas             Coppin St. 46.7  6-6 190 Sr 2021
#> 629 21          Marek Dolezaj               Syracuse 52.9 6-10 201 Sr 2021
#> 630 21         Matt Halvorsen       Western Carolina 54.0  6-1 183 Sr 2021
#> 631 21          Stanley Umude           South Dakota 52.3  6-6 210 Sr 2021
#> 632 21             Troy Green            New Orleans 52.4  6-3 215 Sr 2021
#> 633 21          Tyree Appleby                Florida 51.5  6-1 170 Jr 2021
#> 634 21          Kendric Davis                    SMU 49.7 5-11 180 Jr 2021
#> 635 21         Shamar Givance             Evansville 54.3 5-10 155 Jr 2021
#> 636 21         Jordan Gilliam         Texas Southern 45.3  6-5 175 Jr 2021
#> 637 21          Antoine Davis                Detroit 54.4  6-1 165 Jr 2021
#> 638 21          Bryce Workman           Jacksonville 49.5  6-7 230 Jr 2021
#> 639 21         Micheal Anumba               Winthrop 50.6  6-4 220 Jr 2021
#> 640 21         Avery Anderson           Oklahoma St. 49.7  6-3 170 So 2021
#> 641 21        Tyler Robertson     Eastern Washington 52.4  6-6 200 So 2021
#> 642 21      Keishawn Davidson         Tennessee Tech 51.7  6-2 175 So 2021
#> 643 21 Jeremiah Robinson-Earl              Villanova 50.0  6-9 230 So 2021
#> 644 21            Malik Curry           Old Dominion 51.2  6-1 180 Sr 2021
#> 645 21            Matthew Lee          Saint Peter's 48.0  6-0 160 So 2021
#> 646 21             Duke Miles                   Troy 51.9  6-2 175 Fr 2021
#> 647 21          Ronnie DeGray          Massachusetts 54.0  6-7 220 Fr 2021
#> 648 21         LeChaun DuHart                  Maine 48.6 5-11 175 Fr 2021
#> 649 21             Mark Sears                   Ohio 51.8  6-1 185 Fr 2021
#> 650 22        Brandon Johnson              Minnesota 51.7  6-8 220 Sr 2021
#> 651 22          Chyree Walker                Radford 50.5  6-5 200 Jr 2021
#> 652 22         Ethan Igbanugo           North Dakota 51.5  6-3 191 Jr 2021
#> 653 22        Ishmael El-Amin               Ball St. 50.9  6-3 180 Sr 2021
#> 654 22         Marcus Garrett                 Kansas 49.7  6-5 205 Sr 2021
#> 655 22          Matt Mitchell          San Diego St. 50.3  6-6 235 Sr 2021
#> 656 22            Remy Martin            Arizona St. 50.4  6-0 175 Sr 2021
#> 657 22    San Antonio Brinson                   NJIT 47.8  6-8 210 Sr 2021
#> 658 22       Steffon Mitchell         Boston College 52.6  6-8 220 Sr 2021
#> 659 22         Tray Hollowell                Wofford 54.0  6-3 185 Sr 2021
#> 660 22           Myles Carter           Delaware St. 46.1  6-1 170 Sr 2021
#> 661 22               Tre King       Eastern Kentucky 51.5  6-9 225 Jr 2021
#> 662 22       DeAndre Gholston              Milwaukee 54.0  6-5 215 Jr 2021
#> 663 22           Tyrone Perry              Lafayette 50.5  6-2 165 Jr 2021
#> 664 22             Dre Fuller                    UCF 48.5  6-5 215 So 2021
#> 665 22             Trey Sides           Jacksonville 49.2  6-1 170 So 2021
#> 666 22           Alex Morales                 Wagner 50.4  6-6 180 Sr 2021
#> 667 22            Noah Carter          Northern Iowa 54.1  6-6 229 So 2021
#> 668 22         Noah Fernandes          Massachusetts 53.9 5-11 175 So 2021
#> 669 22               Tre Mann                Florida 51.4  6-5 190 So 2021
#> 670 22         Bryan Greenlee       Florida Atlantic 51.0  6-0 195 So 2021
#> 671 22           Allen Powell                  Rider 47.4  6-2 165 So 2021
#> 672 22         Sedrick Altman             Pepperdine 51.9  6-2 180 So 2021
#> 673 22    William FitzPatrick         Sacramento St. 51.2  6-3 200 Sr 2021
#> 674 22          Jamaure Gregg       Northwestern St. 52.3  6-7 232 Sr 2021
#> 675 22           Jason Gibson                 Towson 53.2  6-1 165 So 2021
#> 676 22           Junior Madut                 Hawaii 47.1  6-6 180 Jr 2021
#> 677 22       Gedi Juozapaitis       Georgia Southern 51.4  6-4 210 Jr 2021
#> 678 22         Posh Alexander             St. John's 50.0  6-0 190 Fr 2021
#> 679 22          Shamir Bogues           Tarleton St. 44.9  6-4 190 Fr 2021
#> 680 22          Terry Collins Mississippi Valley St. 44.6  6-3 180 Jr 2021
#> 681 23           Traci Carter               Hartford 47.8  6-1 175 Sr 2021
#> 682 23              Josh Hall      Cal St. Fullerton 44.6  6-7 213 Sr 2021
#> 683 23        Marcus Weathers               Duquesne 53.7  6-5 215 Sr 2021
#> 684 23              Abu Kigab              Boise St. 50.3  6-7 220 Sr 2021
#> 685 23             Nana Opoku       Mount St. Mary's 49.6  6-9 210 Jr 2021
#> 686 23          Torrey Patton          Cleveland St. 53.9  6-5 195 Sr 2021
#> 687 23             Tyler Maye     North Carolina A&T 45.5  6-1 175 Sr 2021
#> 688 23     Carter Hendricksen          North Florida 49.0  6-7 217 Jr 2021
#> 689 23          Isaiah Mucius            Wake Forest 52.6  6-8 200 Jr 2021
#> 690 23            Ayo Dosunmu               Illinois 51.1  6-5 200 Jr 2021
#> 691 23         Luis Rodriguez            Mississippi 51.0  6-6 210 So 2021
#> 692 23            Mac McClung             Texas Tech 49.3  6-2 185 Jr 2021
#> 693 23            Sam Griesel       North Dakota St. 50.7  6-6 215 Jr 2021
#> 694 23           Adrian Delph        Appalachian St. 50.9  6-3 185 Jr 2021
#> 695 23          Camren Wynter                 Drexel 52.6  6-2 175 Jr 2021
#> 696 23        Neftali Alvarez                 Mercer 53.4  6-2 165 So 2021
#> 697 23     Jeenathan Williams                Buffalo 50.8  6-5 206 Jr 2021
#> 698 23        Warith Alatishe             Oregon St. 50.3  6-7 200 Jr 2021
#> 699 23        Tyler Stevenson          Southern Miss 51.0  6-8 225 Jr 2021
#> 700 23              Ty Rowell            Cal Baptist 44.9  6-2 190 Jr 2021
#> 701 23           Josh Vazquez                Montana 50.5  6-3 180 So 2021
#> 702 23            Evan Taylor                 Lehigh 50.0  6-6 200 So 2021
#> 703 23          Garrett Hicks            Alabama A&M 44.0  6-0 160 So 2021
#> 704 23          Joseph Yesufu                  Drake 54.1  6-0 180 So 2021
#> 705 23     Emmanuel Bandoumel                    SMU 48.2  6-4 180 Jr 2021
#> 706 23             Luke Smith                Belmont 51.4  6-0 175 Jr 2021
#> 707 23            Colby Jones                 Xavier 49.3  6-5 195 Fr 2021
#> 708 23            Jacob Falko           Gardner Webb 50.3  6-2 180 Jr 2021
#> 709 23         Ricardo Wright                 Marist 46.9  6-4 185 Fr 2021
#> 710 23            Jalen Suggs                Gonzaga 51.7  6-4 205 Fr 2021
#> 711 23         Kasen Harrison                  Lamar 52.1  6-1 190 Fr 2021
#> 712 24            Andre Jones           Nicholls St. 51.6  6-4 200 Sr 2021
#> 713 24         Michael Hughes               Duquesne 52.9  6-8 240 Sr 2021
#> 714 24            Mikey Dixon           Grand Canyon 43.8  6-2 165 Sr 2021
#> 715 24          Unique McLean         St. Francis NY 49.5  6-2 182 Sr 2021
#> 716 24               DJ Heath            Alabama St. 43.7  6-0 185 Sr 2021
#> 717 24            EJ Stephens              Lafayette 49.7  6-3 176 Sr 2021
#> 718 24           Hayden Brown            The Citadel 53.2  6-5 225 Jr 2021
#> 719 24         Jamaree Bouyea          San Francisco 51.3  6-2 180 Sr 2021
#> 720 24      Keaton Van Soelen              Air Force 50.0  6-7 190 Sr 2021
#> 721 24             Matt Lewis          James Madison 52.2  6-5 200 Sr 2021
#> 722 24           Nana Akenten Southeast Missouri St. 51.2  6-6 215 Jr 2021
#> 723 24           Trey Jemison                    UAB 50.9  7-0 260 Jr 2021
#> 724 24        Emanuel Littles          North Alabama 48.1  6-7 215 Jr 2021
#> 725 24           DeShaun Wade               Longwood 50.3  6-2 200 Jr 2021
#> 726 24            Bryce Daley           UMass Lowell 47.4  6-4 190 So 2021
#> 727 24       Duane Washington               Ohio St. 51.0  6-3 210 Jr 2021
#> 728 24           Rasir Bolton               Iowa St. 49.2  6-3 185 Jr 2021
#> 729 24           Bryce Golden                 Butler 49.0  6-9 260 Jr 2021
#> 730 24          Daylen Kountz      Northern Colorado 50.0  6-4 191 Jr 2021
#> 731 24         Jaiden Delaire               Stanford 49.8  6-9 210 Jr 2021
#> 732 24          Jase Townsend                 Denver 50.5  6-3 175 Jr 2021
#> 733 24        Keyshawn Bryant         South Carolina 50.8  6-6 195 Jr 2021
#> 734 24           Ronaldo Segu                Buffalo 50.3  6-0 160 Jr 2021
#> 735 24            MJ Randolph            Florida A&M 44.0  6-4 170 Jr 2021
#> 736 24           Nikola Maric            Little Rock 50.8 6-10 250 Jr 2021
#> 737 24          Marcus Sasser                Houston 48.0  6-1 190 So 2021
#> 738 24             Tarik Cool              Idaho St. 50.0  6-4 180 Sr 2021
#> 739 24           Tre Williams            Indiana St. 53.3  6-7 250 So 2021
#> 740 24            Josh Thomas              Milwaukee 53.6  6-4 205 Sr 2021
#> 741 24            Ezra Manjon               UC Davis 43.7 5-11 170 So 2021
#> 742 24           Jeremy Roach                   Duke 52.5  6-1 175 Fr 2021
#> 743 25              CJ Keyser North Carolina Central 43.7  6-3 190 Sr 2021
#> 744 25         Devearl Ramsey       UC Santa Barbara 42.8  6-0 185 Sr 2021
#> 745 25           Najee Garvin           Nicholls St. 51.1  6-7 210 Jr 2021
#> 746 25          Caleb Daniels              Villanova 48.6  6-4 210 Jr 2021
#> 747 25          Jamal Johnson                 Auburn 50.6  6-4 195 Jr 2021
#> 748 25         Keaton Wallace                   UTSA 50.0  6-4 195 Sr 2021
#> 749 25       Sasha Stefanovic                 Purdue 51.0  6-5 200 Jr 2021
#> 750 25         Lonnie Grayson                   Army 48.7  6-0 180 Sr 2021
#> 751 25         Jayden Gardner          East Carolina 47.8  6-7 235 Jr 2021
#> 752 25        Jeremiah Bailey                Pacific 50.9  6-6 220 Sr 2021
#> 753 25          Filip Rebraca           North Dakota 50.4  6-9 222 Jr 2021
#> 754 25           Matt Herasme                 Marist 46.2  6-3 180 Jr 2021
#> 755 25              Tim Finke             Wright St. 53.5  6-6 215 So 2021
#> 756 25          Buddy Boeheim               Syracuse 52.2  6-6 195 Jr 2021
#> 757 25         Courtney Ramey                  Texas 48.5  6-3 185 Jr 2021
#> 758 25           Joel Soriano                Fordham 52.8 6-11 250 So 2021
#> 759 25            Trent Brown      Southern Illinois 52.8  6-2 175 So 2021
#> 760 25        Grant Sherfield                 Nevada 48.9  6-2 189 So 2021
#> 761 25          Ta'lon Cooper           Morehead St. 50.0  6-4 190 So 2021
#> 762 25               Cam Mack       Prairie View A&M 41.9  6-2 170 Jr 2021
#> 763 25          Nick Stampley                   Troy 50.6  6-6 210 Sr 2021
#> 764 25         Owen McCormack           Presbyterian 50.0  6-9 230 So 2021
#> 765 25        Damari Monsanto     East Tennessee St. 52.7  6-6 215 Fr 2021
#> 766 25           Jalen Warren     Florida Gulf Coast 47.9  6-3 162 Sr 2021
#> 767 25          Johnny Juzang                   UCLA 49.5  6-6 210 So 2021
#> 768 25           Devin Jensen              Merrimack 49.2  6-5 220 Sr 2021
#> 769 25   Juan Felix Rodriguez            Stony Brook 47.2  6-0 190 Jr 2021
#> 770 25          Kaden Metheny          Bowling Green 50.0 5-11 180 Fr 2021
#> 771 25         Jamahri Harvey         UNC Wilmington 52.0  6-5 175 Fr 2021
#> 772 25           Frank Staine              Dixie St. 43.4  6-6 205 So 2021
# }
```
