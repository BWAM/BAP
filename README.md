
# BAP

<!-- badges: start -->
<!-- badges: end -->

The BAP package calculates Biological Assessment Profile scores according to the SMAS Biomonitoring QAPP. 

To be updated in 2021 to reflect new database structures and incoming data.

## Installation

You can install the released version of BAP from GITHUB.

``` r
devtools::install_github("BWAM/BAP")
```

## Example

This is a basic example which shows you how to run the script.

``` r
library(BAP)
#Run BAP and create BAP entry for table
library(BAP)

#run BAP's data prep on the raw file, note, you will need the correct column headers
#see the template file: Mosher_Request_1_6_17.csv

new.df<-BAP::data_prep(raw.df)

## this is a function to run the correct BAP based on the collection method

apply_bap<-function(df){
  kick.standard<-df %>% 
  subset(COLLECT==1)#normal kick sample

mp.nav<-df %>% 
  subset(COLLECT==2)#multiplate navigable

mp.nn<-df %>% 
  subset(COLLECT==5)#multiplate non-navigable

sandy.jab<-df %>% 
  subset(COLLECT==6)#sandy kick

ponar<-df %>% 
  subset(COLLECT==3)#ponars

riff_df<-if(nrow(kick.standard!=0)){BAP::bap_riffle(Long = kick.standard)}
mp.nav_df<-if(nrow(mp.nav!=0)){BAP::bap_mp_nav_waters(Long = mp.nav)}
mp.nn_df<-if(nrow(mp.nn!=0)){BAP::bap_mp_non_nav_water(Long=mp.nn)}
sandy.jab_df<-if(nrow(sandy.jab!=0)){BAP::bap_jab(Long = sandy.jab)}
ponar_df<-if(nrow(ponar!=0)){BAP::bap_ponar(long = ponar)}
#this set of ifs looks to see if the df's are populated and then runs the appropriate #metrics

bap.final<-bind_rows(riff_df,mp.nav_df,mp.nn_df,sandy.jab_df,ponar_df) #binds them all

.GlobalEnv$bap.final <- bap.final #makes available in teh environment
}

#call the function to run the scripts
bap.final<-apply_bap(new.df)



```

