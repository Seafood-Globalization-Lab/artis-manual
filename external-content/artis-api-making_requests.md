# How to make Requests to the ARTIS API

## Permission to use ARTIS API
All API users require an API key to submit requests to the ARTIS API. **Any requests not containing an API key will automatically be rejected.** Please place your API key in the HTTP request header under the name "X-API-KEY".

## Summary
<table>
    <tbody>
    <tr>
        <th>HTTP Request Type</th>
        <th>Endpoint</th>
        <th>Parameters</th>
        <th>Response</th>
    </tr>
    <tr>
        <td>GET</td>
        <td>/snet/query</td>
        <td>
        Required Parameters:
        <ul>
            <li>cols_wanted (at least one value required): "exporter_iso3c", "importer_iso3c", "source_country_iso3c", "hs6", "sciname", "habitat", "method", "dom_source", "year". </li>
            <li>weight_type (only one value can be selected): "product_weight_t" or "live_weight_t"</li>
            <li>start_year: year from 1996-2020 (inclusive)</li>
            <li>end_year: year from 1996-2020 (inclusive)</li>
            <li>search_criteria: Either 1 or 0. 1 notes that additional filtering criteria will be included, 0 notes no filter criteria is required.</li>
            <i>Note: start_year cannot be greater than end_year. For results for just 1 year, make start_year equal to end_year.</i>
        </ul>
        Optional Parameters:
        <ul>
            <li>Send in additional column names as parameters, with strings as values for the values you want to filter for.</li>
        </ul>
        </td>
        <td>
            <li>An ID number corresponding to the job that has been submitted containing your query request.</li>
            <li>A summary of the data request sent to the endpoint.</li>
        </td>
    </tr>
    <tr>
        <td>GET</td>
        <td>/consumption/query</td>
        <td>
        Required Parameters:
        <ul>
            <li>cols_wanted (at least one value required): "consumer_iso3c", "exporter_iso3c", "source_country_iso3", "year", "hs_version", "dom_source", "sciname", "habitat", "method", "consumption_source", "sciname_hs_modified"</li>
            <li>start_year: year from 1996-2020 (inclusive)</li>
            <li>end_year: year from 1996-2020 (inclusive)</li>
            <li>search_criteria: Either 1 or 0. 1 notes that additional filtering criteria will be included, 0 notes no filter criteria is required.</li>
        </ul>
        Optional Parameters:
        <ul><li>Send in additional column names as parameters, with strings as values for the values you want to filter for.</li></ul>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>GET</td>
        <td>/jobs/status</td>
        <td>
        Required Parameters:
        <ul>
            <li>id: Job id number returned from an snet or consumption query</li>
        </ul>
        </td>
        <td>
        <ul>
            <li>status: job status (wait/active/completed etc)</li>
            <li>result: a list of objects where each object would correspond to a row of results for the query submitted</li>
        </ul>
        </td>
    </tr>
    <tr>
        <td>GET</td>
        <td>/supplemental</td>
        <td>
        Required Parameters:
        <ul>
            <li>table: supplemental table name.</li>
            <li>variable: column name within supplemental table.</li>
        </ul>
        </td>
        <td>
        A list of strings representing unique values in the column requested.
        </td>
    </tr>
    <tr>
        <td>GET</td>
        <td>/supplemental/query</td>
        <td>
        Required Parameters:
        <ul>
            <li>table: supplemental table name you want information from.</li>
            <li>cols_wanted: columns include in the table requested.</li>
            <li>search_criteria: Either 1 or 0. 1 notes that additional filtering criteria will be included, 0 notes no filter criteria is required.</li>
        </ul>
        Optional Parameters:
        <ul>
            <li>Send in additional column names as parameters, with strings as values for the values you want to filter for.</li>
        <ul>
        </td>
        <td>
            A list of object where each object represents a row of data in the supplemental table requested.
        </td>
    </tr>
    </tbody>
</table>

An indepth review of the API requests and responses is available below.

## Getting updates on jobs that have been submitted

To get an update on jobs that have been submitted send a **GET** request to the `/jobs/status` endpoint.

**Note:** only requests to the `/snet/query`, `/consumption/query`, `/baci/query`, `/production/query` endpoints will generate a job ID. Requests to `/supplemental` endpoints will generate an immediate JSON response with data back to the requester.

A correct request to the `/jobs/status` endpoint consists of 1 query parameter:
- id **(REQUIRED)**: a job ID number. This job ID was provided by the `/snet/query` endpoint.

A response to the `/jobs/status` endpoint consists of 2 fields:
- status: a string describing the status of the job submitted. Possible return values include:
    - completed: Job has been completed.
    - active: Job is currently being executed.
    - wait: Job is on the queue and is waiting to be executed by the server.
    - delayed: Job has been delayed due to current server constraints, and will be submitted into the job queue as soon as possible.
    - failed: Job has failed. Please review request that has been made and modify as appropriate.
- results: an array of objects where each object corresponds to a row of results from the query provided. Note, only when the status is "completed" will results be a non-empty array. The specifics as to how each object is structured are outlined below.

Example successful response:
```json
{
    status: "completed",
    results: [
        {year: 2018, live_weight_t: 180}
        {year: 2019, live_weight_t: 250},
        {year: 2020, live_weight_t: 100}
    ]
}
```

Example job is currently in being executed:
```json
{
    status: "active",
    results: []
}
```

Example job is currently waiting to be executed:
```json
{
    status: "wait",
    results: []
}
```

Example job failed:
```json
{
    status: "failed",
    results: []
}
```

## Requests for Main ARTIS snet data

Note: ***The `/snet/query` endpoint only submits a job request and will not provide results from the ARTIS seafood trade network table.*** All requests to the `/snet/query` endpoint provide an immediate response with a job id, along with information about the API request that was submitted. You will still need to request the `/jobs/status` endpoint to get an update on the job submitted and if completed the results of the database request. **Please refer to the `/jobs` endpoint documentation for more detail.**

This section outlines how to make requests for data within the ARTIS snet table. Note that all requests require some kind of filtering criteria, if you would like to request the complete ARTIS snet data please send an email to [ENTER EMAIL HERE].

A request for the main ARTIS snet table consists of 5 fields:
- cols_wanted **(REQUIRED)**: A string containing the names of the columns, comma separated without spaces, used to summarize the ARTIS data you are requesting.
- weight_type **(REQUIRED)**: A string either "live_weight_t" or "product_weight_t", denoting what mass measurement you would like to use. Note you can only choose ONE weight_type.
- start_year **(REQUIRED)**: A year between 1996-2020
- end_year **(REQUIRED)**: A year between 1996-2020 must be greater than or equal to start_year
- search_criteria **(REQUIRED)**: Either 1 or 0. 1 notes that additional filtering criteria will be included, 0 notes no filter criteria is required. Note all optional parameters sent will be treated as filtering criteria if search_criteria is set to 1. If search_criteria is set to 0, then all optional parameters will be ignored.

### Examples

If you wanted to send a request for all ARTIS snet data summarize by year you would send a GET request to the `/snet/query` endpoint, with the following parameters:

*Note:* In this request we are NOT performing any filtering on the ARTIS snet (with exception of the start and end years).

```json
{
    "cols_wanted": "year",
    "weight_type": "live_weight_t",
    "start_year": 2015,
    "end_year": 2020,
    "search_criteria": 0
}
```
The endpoint with parameters would look like this:

`/snet/query?cols_wanted=year&weight_t=live_weight_t&start_year=2015&end_year=2020&search_criteria=0`

Here is a sample of the results list that would be returned:
```json
[
    {
        "year": 2020,
        "live_weight_t": 44166033.00951629
    },
    {
        "year": 2015,
        "live_weight_t": 40891197.02143691
    },
    {
        "year": 2018,
        "live_weight_t": 46537958.721290946
    },
    {
        "year": 2017,
        "live_weight_t": 44763794.736794
    },
    {
        "year": 2019,
        "live_weight_t": 45180309.70194027
    },
    {
        "year": 2016,
        "live_weight_t": 41962089.008993454
    }
]
```


If you wanted to send the same request but only for US and China capture trade from 2017 - 2019 you would include the following parameters:
```json
{
    "cols_wanted": "exporter_iso3c,year",
    "weight_type": "live_weight_t",
    "start_year": 2017,
    "end_year": 2019,
    "search_criteria": 1,
    "exporter_iso3c": "CHN,USA",
    "method": "capture"
}
```

The final url would look like this:

`/snet/query?cols_wanted=exporter_iso3c,year&weight_type=live_weight_t&start_year=2017&end_year=2019&search_criteria=1&exporter_iso3c=CHN,USA&method=capture`

Here is a sample of the results list that would be returned:
```json
[
    {
        "exporter_iso3c": "USA",
        "year": 2017,
        "live_weight_t": 1975004.9836222837
    },
    {
        "exporter_iso3c": "CHN",
        "year": 2018,
        "live_weight_t": 3086899.0878980905
    },
    {
        "exporter_iso3c": "USA",
        "year": 2019,
        "live_weight_t": 1699555.4157051465
    },
    {
        "exporter_iso3c": "CHN",
        "year": 2019,
        "live_weight_t": 2960335.342349926
    },
    {
        "exporter_iso3c": "CHN",
        "year": 2017,
        "live_weight_t": 3256231.7707880796
    },
    {
        "exporter_iso3c": "USA",
        "year": 2018,
        "live_weight_t": 1807505.2796781566
    }
]
```

If you wanted to explore bilateral trade relationships for a specific species (salmo salar) in 2019, you would send the following request:
```json
{
    "cols_wanted": "exporter_iso3c,importer_iso3c,year",
    "weight_type": "live_weight_t",
    "start_year": 2019,
    "end_year": 2019,
    "search_criteria": 1,
    "sciname": "salmo salar"
}
```

The final URL would look like this:
`/snet/query?cols_wanted=exporter_iso3c,importer_iso3c,year&weight_type=live_weight_t&start_year=2019&end_year=2019&search_criteria=1&sciname=salmo salar`

Here is a sample of the results list that would be returned:

```json
[
    {
        "exporter_iso3c": "AUS",
        "importer_iso3c": "CHN",
        "year": 2019,
        "live_weight_t": 7919.87229991926
    },
    {
        "exporter_iso3c": "BEL",
        "importer_iso3c": "COG",
        "year": 2019,
        "live_weight_t": 5205.84567743523
    },
    {
        "exporter_iso3c": "BEL",
        "importer_iso3c": "NLD",
        "year": 2019,
        "live_weight_t": 2997.68945007121
    },
```
## Requests for Consumption data
Note: ***The `/consumption/query` endpoint only submits a job request and will not provide results from the ARTIS consumption table.*** All requests to the `/consumption/query` endpoint provide an immediate response with a job id, along with information about the API request that was submitted. You will still need to request the `/jobs/status` endpoint to get an update on the job submitted and, if completed, the results of the database request. **Please refer to the `/jobs` endpoint documentation for more detail.**

This section outlines how to make requests for data within the ARTIS consumption table. Note that all requests require some kind of filtering criteria, if you would like to request the complete ARTIS consumption data please send an email to [ENTER EMAIL HERE].

A request for the main ARTIS consumption table consists of 4 fields:
- cols_wanted **(REQUIRED)**: A string containing the names of the columns, comma separated without spaces, used to summarize the ARTIS data you are requesting. Note that all consumption results are returned in live weight equivalent tonnes.
- start_year **(REQUIRED)**: A year between 1996-2020
- end_year **(REQUIRED)**: A year between 1996-2020 must be greater than or equal to start_year
- search_criteria **(REQUIRED)**: Either 1 or 0. 1 notes that additional filtering criteria will be included, 0 notes no filter criteria is required. Note all optional parameters sent will be treated as filtering criteria if search_criteria is set to 1. If search_criteria is set to 0, then all optional parameters will be ignored. 


### Examples
If you wanted to send a request for all ARTIS consumption data summarized by year you would send a GET request to the `/consumption/query` endpoint, with the following parameters:

*Note:* In this request we are NOT performing any filtering on the ARTIS snet (with exception of the start and end years).

```json
{
    "cols_wanted": "year",
    "start_year": 2015,
    "end_year": 2020,
    "search_criteria": 0
}
```
The endpoint with parameters would look like this:

`/consumption/query?cols_wanted=year&start_year=2015&end_year=2020&search_criteria=0`

```json
[
    {
        "year": 2015,
        "consumption_live_t": 150051627.61692697
    },
    {
        "year": 2016,
        "consumption_live_t": 152188217.6477852
    },
    {
        "year": 2017,
        "consumption_live_t": 156667487.22123533
    },
    {
        "year": 2018,
        "consumption_live_t": 162506861.25704896
    },
    {
        "year": 2019,
        "consumption_live_t": 161828981.64790905
    },
    {
        "year": 2020,
        "consumption_live_t": 160382274.5401494
    }
]
```

If you wanted to explore consumption of a specific species (salmo salar) in 2019, you would send the following request:
```json
{
    "cols_wanted": "consumer_iso3c,year",
    "start_year": 2019,
    "end_year": 2019,
    "search_criteria": 1,
    "sciname": "salmo salar"
}
```

The final URL would look like this:
`/consumption/query?cols_wanted=consumer_iso3c,year&start_year=2019&end_year=2019&search_criteria=1&sciname=salmo%20salar`

Here is a sample of the results list that would be returned:
```json
[
    {
        "consumer_iso3c": "URY",
        "year": 2019,
        "consumption_live_t": 1268.9479577486022
    },
    {
        "consumer_iso3c": "USA",
        "year": 2019,
        "consumption_live_t": 479888.35767397494
    },
    {
        "consumer_iso3c": "UZB",
        "year": 2019,
        "consumption_live_t": 179.3410667585069
    },
    {
        "consumer_iso3c": "VCT",
        "year": 2019,
        "consumption_live_t": 98.57772699218599
    },
    {
        "consumer_iso3c": "VEN",
        "year": 2019,
        "consumption_live_t": 117.01599593460986
    },
    {
        "consumer_iso3c": "VNM",
        "year": 2019,
        "consumption_live_t": 15550.574977568014
    }
]
```
---
## Requests for Supplemental data

This is section outline how to make requests for any of the supplemental data tables:
- baci
- countries
- production
- products
- sciname

You can make 2 kinds of requests for data in supplemental tables:
1. Getting all the unique values for a specific table. These requests are made to the url: ```/supplemental/```
    - This type of request has two REQUIRED parameters:
        - table: A string corresponding to the name of the supplemental table you want information from.
        - variable: A string corresponding to the name of the column. Will return all unique values in this column.
2. Getting all rows based on a filtered search criteria. These requests are made to the url: ```/supplemental/query/```
    - This type of the request has the uses the following parameters:
        - table **(REQUIRED)**: A string corresponding to the name of the supplemental table you want information from.
        - cols_wanted **(REQUIRED)**: A string corresponding to the columns, comma separated, that will be returned for each row.
        - search_criteria **(REQUIRED)**: Either 1 or 0. 1 notes that additional filtering criteria will be included, 0 notes no filter criteria is required. Note all optional parameters sent will be treated as filtering criteria if search_criteria is set to 1. If search_criteria is set to 0, then all optional parameters will be ignored.

### Examples

If you wanted to get all scientific names for all the species / species groups in ARTIS you would send a request to the `/supplemental` endpoint with the following parameters:
```json
{
    "table": "sciname",
    "variable": "sciname"
}
```

The final URL would be:
`/supplemental/?table=sciname&variable=sciname`

Here is sample response:
```json
{
    "sciname": [
        "eucinostomus melanopterus",
        "nassarius",
        "merlucciidae",
        "stellifer minor",
        "malacocephalus occidentalis",
        "patagonotothen ramsayi",
        "pomadasys kaakan",
        "carangoides malabaricus"
    ]
}
```

If you wanted to get all common names for all the species / species groups in ARTIS, you would send a request to the `/supplemental` endpoint with the following parameters:

```json
{
    "table": "sciname",
    "variable": "common_name"
}
```

The final URL would be:
`/supplemental/?table=sciname&variable=common_name`

Here is a sample response:
```json
"common_name": [
        "scomber mackerels nei",
        "mango tilapia",
        "ocellated wedge sole",
        "spotted porcupinefish",
        "shi drum",
        "leopard fish",
        "globose clam",
        "geelbek croaker"
]
```

If you wanted to get all scientific, common names and ISSCAAP groups for a specific genus (for example thunnus) you would send a request to the `/supplemental/query` endpoint with the following parameters:

```json
{
    "table": "sciname",
    "cols_wanted": "sciname,common_name,isscaap",
    "search_criteria": 1,
    "genus": "thunnus"
}
```
The final URL would be:
`/supplemental/query?table=sciname&cols_wanted=sciname,common_name,isscaap&search_criteria=1&genus=thunnus`

Here is a sample response:
```json
[
    {
        "sciname": "thunnus",
        "common_name": "tunas nei",
        "isscaap": "Tunas, bonitos, billfishes"
    },
    {
        "sciname": "thunnus alalunga",
        "common_name": "albacore",
        "isscaap": "Tunas, bonitos, billfishes"
    }
]
```

If you wanted to get production of all USA and Chilean salmo salar by production method and year, you would send a request to the `/supplemental/query` endpoint with the following parameters:

```json
{
    "table": "production",
    "cols_wanted": "iso3c,method,year,live_weight_t",
    "search_criteria": 1,
    "sciname": "salmo salar",
    "iso3c": "USA,CHL"
}
```
The final URL would be:
`/supplemental/query?table=production&cols_wanted=iso3c,method,year,live_weight_t&search_criteria=1&sciname=salmo salar&iso3c=USA,CHL`

Here is a sample response:
```json
[
    {
        "iso3c": "CHL",
        "sciname": "salmo salar",
        "method": "aquaculture",
        "habitat": "inland",
        "live_weight_t": 493.49,
        "year": 2018
    },
    {
        "iso3c": "CHL",
        "sciname": "salmo salar",
        "method": "aquaculture",
        "habitat": "marine",
        "live_weight_t": 660644.9,
        "year": 2018
    },
    {
        "iso3c": "USA",
        "sciname": "salmo salar",
        "method": "aquaculture",
        "habitat": "marine",
        "live_weight_t": 16107,
        "year": 2018
    }
]
```


