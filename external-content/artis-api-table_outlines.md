# Table Structures and References

## Main ARTIS snet
Main table linking trade records with production.

| Column Name | Description |
| ----------- | ----------- |
| exporter_iso3c| ISO3C code for direct ***exporter*** country |
| importer_iso3c| ISO3C code for direct ***importer*** country |
| source_country_iso3c | ISO3C code for the country that produced the specific product |
| dom_source | Defines whether trade record was a "domestic export", "foreign export" or "error export". |
| hs6 | HS 6 digit code used to identify what product is being traded. |
| sciname | species name traded under the specific HS product and 6-digit code. |
| habitat | classifies whether the specific species' habitat *(marine/inland/unknown)*. |
| method | defines method of production *(aquaculture/capture/unknown)*. |
| product_weight_t | product weight in tonnes. |
| live_weight_t | live weight in tonnes. |
| year | year in which trade occured. |


### Sample Table Entry
| exporter_iso3c | importer_iso3c | source_country_iso3c | dom_source | hs6 | sciname | habitat | method | product_weight_t | live_weight_t | year |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| CAN | USA | CAN | domestic export | 030212 | oncorhynchus keta | marine | capture | 870.34 | 1131.45 | 2017 |
| CHL | ITA | PER | foreign export | 230120 | engraulis ringens | marine | capture | 344.889 | 1026.11 | 2017 |

***Note:***
- ***Domestic Export:*** An export where the specific product was produced in the same country as it was exported from.
- ***Foreign Export:*** An export where a specific product is imported from a source country and then re-exported by another country.
- ***Error Export:*** An export that cannot be explained by domestic or foreign export records nor production records.

## Consumption table
| Column Name | Description |
| ----------- | ----------- |
| source_country_iso3c | ISO3C code for the country that produced the specific species |
| exporter_iso3c | ISO3C code for the country that was the final exporter of the species before it arrived at the consuming country |
| consumer_iso3c | ISO3C code for the country consuming the species |
| consumption_source | "domestic" or "foreign", domestic consumption is when the country consumes species it produced itself. Foreign consumption is when a country consumes species imported from another country |
| year | year 1996-2020 |
| dom_source | specifies whether trade flow was "domestic" (exporting country produced the good that it is sending to the consuming country) or "foreign" (exporting country imported the good that it is sending to the consuming country) |
| sciname | species/species group name |
| sciname_hs_modified | most resolved version of the species/species group name based on the underlying HS code that it was traded under |
| habitat | production habitat |
| method | production method |
| consumption_live_t | consumption in live weight equivalent tonnes |

### Sample Table Entry
| source_country_iso3c | exporter_iso3c  | consumer_iso3c | consumption_source | year | dom_source | sciname | sciname_hs_modified | habitat | method | consumption_live_t |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| CAN | CAN | USA | foreign | 2020 | domestic | salmo salar | marine | capture | 200.00 |
| USA | NA | USA | domestic | 2020 | NA | salmo salar | marine | capture | 350.00 |

---

## Supplemental Tables

## sciname table
This table holds all the taxonomic information for all the species traded in the main ARTIS table.

| Column Name | Description |
| ----------- | ----------- |
| sciname | Species name |
| common_name | Common name to refer to species. |
| genus | Taxonomic genus |
| subfamily | Taxonomic subfamily |
| family | Taxonomic family |
| order | Taxonomic order |
| class | Taxonomic class |
| superclass | Taxonomic superclass |
| phylum | Taxonomic phylum |
| kingdom | Taxonomic kingdom |
| isscaap | ISSCAAP group |


### Sample Sciname Table Entry
| sciname | common_name | genus | subfamily | family | order | class | superclass | phylum | kingdom | isscaap group |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| salmo salar | atlantic salmon | salmo | salmoninae | salmonidae | salmoniformes | actinopteri | osteichthyes | chordata | animalia | Salmons, trouts, smelts |
---

## production Table
This table has all FAO production records for all countries in ARTIS for 1996 - 2020.

| Column Name | Description |
| ----------- | ----------- |
| iso3c | ISO3C code for the producin country |
| sciname | species produced (matches with sciname column in sciname table) |
| method | production method *(aquaculture/capture/unknown)* |
| habitat | habitat where species resides *(marine/inland/unknown)* |
| live_weight_t | Live weight in tonnes. |
| year | Year species was produced. |

### Sample production table entry
| iso3c | sciname | method | habitat | live_weight_t | year |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| SWE | abramis brama | capture | inland | 7 | 2006 |

---

## products Table
This table contains information about what each HS 6-digit code represents.

| Column Name | Description |
| ----------- | ----------- |
| hs6 | HS 6-digit product code |
| description | Product description |
| presentation | Product form ***(fillet, whole, fats and oils, non-fish, non-fmp form, other body parts, other meat, livers and roes)*** |
| state | Product state ***(live, frozen, preserved, fresh, not for humans, reduced)*** |


### Sample products table entry
| hs6 | description | presentation | state |
| ----------- | ----------- | ----------- | ----------- |
| 030212 | Fish; Pacific salmon (oncorhynchus spp.), Atlantic salmon (salmo salar), Danube salmon (hucho hucho), fresh or chilled (excluding fillets, livers, roes and other fish meat of heading no. 0304)| whole | fresh |

