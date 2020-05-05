---
title: "APPLYING DATA SYNTHESIS FOR LONGITUDINALBUSINESS DATA ACROSS THREE COUNTRIES"
authors: "M. Jahangir Alam, Benoit Dostie, Jörg Drechsler, Lars Vilhuber"
date: "2020-05-04"
---

Also see [https://labordynamicsinstitute.github.io/SyntheticLEAP](https://labordynamicsinstitute.github.io/SyntheticLEAP).

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3785744.svg)](https://doi.org/10.5281/zenodo.3785744)


## Abstract

Data on businesses collected by statistical agencies are challenging to protect. Many businesses have unique characteristics, and distributions of employment, sales, and profits are highly skewed. Attackers wishing to conduct identification attacks often have access to much more information than for any individual. As a consequence, most disclosure avoidance mechanisms  fail to strike an acceptable balance between usefulness and confidentiality protection. Detailed aggregate statistics by geography or detailed industry classes  are rare, public-use microdata on businesses are virtually inexistant, and access to confidential microdata can be burdensome. 
Synthetic microdata have been proposed as a secure mechanism to publish microdata, as part of a broader discussion of how  to provide broader access to such datasets to researchers.

In this article, we document an experiment to create analytically valid synthetic data, using the exact same model and methods previously employed for the United States, for data from two different countries: Canada (\ac{LEAP}) and Germany (\ac{BHP}). We assess utility and protection, and provide an assessment of the feasibility of extending such an approach in a cost-effective way to other data.

- [Working paper](pdfs/AlamDostieDrechslerVilhuber_20200504.pdf)
- [Online appendix](pdfs/AlamDostieDrechslerVilhuber-online-appendix.pdf) to accompany Alam, Dostie, Drechsler, Vilhuber (SiT, 2020 forthcoming)


## Data Availability Statement

The key data sources used in the article are described and cited in the article. All source data is confidential, available on restricted-access servers.


### LEAP

- Confidential LEAP: Access to the [LEAP](https://www.statcan.gc.ca/eng/cder/data#a6) can be requested at Statistics Canada/ CDER ([https://www.statcan.gc.ca/eng/cder/index](https://www.statcan.gc.ca/eng/cder/index)). 
 - Synthetic LEAP: Release of the data was not requested; data are thus still considered to be confidential. The data were generated on internal servers, and accessed by one of the authors during his stay at Statistics Canada. None of the authors currently have access to the data. Data may be accessible through the CDER access process outlined above. The Canadian LEAP is accessible at CRDE. 
 - Applicants need to be Canadian residents, and a security check is conducted. Access is only at Statistics Canada offices in Ottawa, ON, Canada.

### BHP

- Access to the BHP (in English: Establishment History Panel) is possible through the Research Data Center of the IAB ([https://fdz.iab.de/en.aspx](https://fdz.iab.de/en.aspx)). One of the authors, as an IAB employee, had access to the internal version of the data not available to researchers. Release of the data was not requested; data are thus still considered to be confidential.

A 50% sample of the BHP is accessible to external researchers through the FDZ (Research Data Center) of the IAB. Applicants must fill out a form, subject to approval, and can access the data via the various access mechanisms of the FDZ, including physical locations in Germany, elsewhere in Europe, and North America.

### Synthetic data

Synthetic data from both confidential data were never released to the public, and are accessible only via the same access mechanisms as above. A related synthetic LEAP was made available through the Canadian Research Data Center system, as part of a pilot program, to prepare access to the confidential data. We are not aware of current access. The outcomes of the pilot program have not been made public yet.


### NAICS data

As a small part of the post-processing, we count the (theoretical) number of Canadian NAICS industry groups (Statistics Canada, 2012). The file can be downloaded from [https://www.statcan.gc.ca/eng/subjects/standard/naics/2012/index](https://www.statcan.gc.ca/eng/subjects/standard/naics/2012/index).


## Analytic outcomes

The analytic outcomes described in the article were released through the respective disclosure avoidance mechanisms, subject to disclosure avoidance procedures of each statistical institution. These outcomes, as figures, CSV files, and others, are available in this repository. Some were extracted from figures or released tables by the programs in this directory.

## Files 

### Data directory

The [data](data/README.md) directory contains materials released from Statistics Canada and the IAB. It is mostly highly aggregated synthetic data, as well as regression coefficients. All data releases were authorized by the respective statistical agencies.

### graphs directory

The [graphs](graphs/) contains mostly pre-rendered figures released as part of the agency data releases.  The programs to generate these figures can be found in [programs/Canada](programs/Canada), and were run on the confidential data.



### stata-graphs directory

The [graphs](graphs/) contains   GPH (Stata) format files, the source for the PDFs in the [graphs](graphs/) directory. The programs to generate these figures can be found in [programs/Canada](programs/Canada), and were run on the confidential data.



### Programs

Programs for analysis ([programs/Canada](programs/Canada), used for both Canada and Germany), and post-processing ([programs/Post](programs/Post)) are provided.


### Derived graphs

Graphs generated through post-processing ([programs/Post](programs/Post)) are available in [r-graphs](r-graphs/). 



### Tables

Tables generated both by tabulation of confidential data ([programs/Canada](programs/Canada), used for both Canada and Germany), and post-processing ([programs/Post](programs/Post))  can be found in the [tables](tables/) directory.


## Computation

### Computational Requirements

- R (for post-processing)
- Stata (for analysis of synthetic and confidential data)
- bash shell (optional, to execute all programs in order)
- SAS (for the synthetic data generation)

### Synthetic generation

The software used to generate the synthetic data is described in Kinney et al (2011b). A copy of the code can be obtained by request.

### Intra-mural Analysis

The raw synthetic and confidential data served as input to the various analyses described in the paper. These analyses occurred within the secure environments of the respective agencies. The code for the analysis is common to both countries (with minor adjustments to account for different variable names). The code used in the Canadian context is provided as a single Stata file in the `[programs/Canada](programs/Canada)` directory.



### Execution of programs

Numbered programs should be executed in the natural order. Other programs define locations and/or subroutines, and should not be executed. A convenience bash script `run_all.sh` is provided.

## Funding

Vilhuber acknowledges funding through NSF Grants SES-1131848 and SES-1042181, and a grant from Alfred P. Sloan Grant (G-2015-13903). Alam and Dostie acknowledge funding through SSHRC Partnership Grant "Productivity, Firms and Incomes". The creation of the Synthetic LBD  was funded by NSF Grant SES-0427889.


## License

These data are licensed under a [Creative Commons Attribution-NonCommercial 4.0 International](https://creativecommons.org/licenses/by-nc/4.0/) license. See [citation] for attribution.




