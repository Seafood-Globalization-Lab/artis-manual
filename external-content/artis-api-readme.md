# ARTIS Aquatic Resource Trade in Species API

This API processes requests for the ARTIS database.

## About ARTIS

Food systems have become increasingly globalized, with over a quarter of all food now traded internationally. Seafood is among the most highly traded foods and it is becoming increasingly globalized, with trade doubling in recent decades. At the same time, seafood is now widely recognized as a critical source of nutrition. Thus, social and environmental threats to local seafood production, including environmental extremes, price impacts of market integration, networked risks, and increased availability of processed foods, must be evaluated in the context of global trade. These issues are paralleled by similar questions for other natural resources and are central to global food systems research. However, our collective understanding of the environmental and human outcomes of food system globalization is limited by a fundamental gap between production and trade data. We bridge this gap in the Aquatic Resource Trade in Species (ARTIS) database by providing the first global estimates of seafood species and nutrient trade flows from 1996–2020.

*(Taken from https://artisdata.weebly.com/)*

---

## Description Files
The files below contain the documentation for what types of requests (examples and sample responses) can be made to the ARTIS API.

- [table_outlines.md](documentation/table_outlines.md)
    - Formats and structures for all tables accessible from the ARTIS API
- [making_requests.md](documentation/making_requests.md)
    - Structure for how to make requests
    - Sample requests
    - Sample responses

---

## ARTIS Database Tables
- Main ARTIS snet
- Supplemental Tables
    - sciname *(species taxonomic information)*
    - production *(FAO production data)*
    - products *(HS code descriptions and classification)*
    - countries *(country metadata ie iso3 codes, regions)*
    - baci *(BACI trade bilateral trade data)*



