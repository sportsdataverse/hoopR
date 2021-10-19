# nba_pbp

##### Endpoint URL
>[https://data.nba.com/prod/v1/{season}/schedule.json](https://data.nba.com/prod/v1/2021/schedule.json)

##### Valid URL
>[https://data.nba.com/prod/v1/2021/schedule.json](https://data.nba.com/prod/v1/2021/schedule.json)

## Parameters
API Parameter Name | Parameter | Pattern | Required | Nullable
------------ | ------------ | :-----------: | :---: | :---:
_**season**_ | season |  | `Y` |  | 
_**league_name*_ | league | `NBA` | `Y` |  | 

## Data Sets

#### Schedule `schedule`
```text
['gameId', 'seasonStageId', 'gameUrlCode', 'statusNum', 'extendedStatusNum', 'isStartTimeTBD', 'startTimeUTC', 'startDateEastern', 'isNeutralVenue', 'startTimeEastern', 'isBuzzerBeater', 'period', 'nugget', 'hTeam', 'vTeam', 'watch', 'playoffs', 'tags']
```


## JSON
```json
{
    "gameId": "0042000405",
    "seasonStageId": 4,
    "gameUrlCode": "20210717/MILPHX",
    "statusNum": 3,
    "extendedStatusNum": 0,
    "isStartTimeTBD": false,
    "startTimeUTC": "2021-07-18T01:00:00.000Z",
    "startDateEastern": "20210717",
    "isNeutralVenue": false,
    "startTimeEastern": "9:00 PM ET",
    "isBuzzerBeater": false,
    "period": {
        "current": 4,
        "type": 0,
        "maxRegular": 4
    },
    "playoffs": {
        "roundNum": "4",
        "confName": "",
        "seriesId": "40",
        "seriesSummaryText": "MIL leads 3-2",
        "isSeriesCompleted": false,
        "gameNumInSeries": "5",
        "isIfNecessary": false,
        "vTeam": {
            "seedNum": "3",
            "seriesWin": "3",
            "isSeriesWinner": false
        },
        "hTeam": {
            "seedNum": "2",
            "seriesWin": "2",
            "isSeriesWinner": false
        }
    },
    "nugget": {
        "text": ""
    },
    "tags": [
        "Finals2020"
    ],
    "hTeam": {
        "teamId": "1610612756",
        "score": "119",
        "win": "51",
        "loss": "21"
    },
    "vTeam": {
        "teamId": "1610612749",
        "score": "123",
        "win": "46",
        "loss": "26"
    },
    "watch": {
        "broadcast": {
            "video": {
                "regionalBlackoutCodes": "",
                "isLeaguePass": true,
                "isNationalBlackout": false,
                "isTNTOT": false,
                "canPurchase": false,
                "isVR": false,
                "isNextVR": false,
                "isNBAOnTNTVR": false,
                "isMagicLeap": false,
                "isOculusVenues": false,
                "national": {
                    "broadcasters": [
                        {
                            "shortName": "ABC",
                            "longName": "ABC"
                        }
                    ]
                },
                "canadian": [
                    {
                        "shortName": "SN",
                        "longName": "Sportsnet"
                    }
                ],
                "spanish_national": [

                ]
            }
        }
    }
},
```

Last validated 2020-08-16
