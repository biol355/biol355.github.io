Processed OTU table and environmental metadata for analyses described in:

Zimmerman, N. B., and P. M. Vitousek. 2012. Fungal endophyte communities reflect environmental structuring across a Hawaiian landscape. Proceedings of the National Academy of Sciences of the United States of America 109:13022-13027. doi:10.1073/pnas.1209872109

Point of contact: Naupaka Zimmerman 
Email: naupaka@gmail.com
Archive date: November 17, 2015

Four files are included (in addition to this readme). Descriptions of each column in each file are listed below. The initial data in the name is when the data were initially saved to this format. QC stands for Quality Checked, followed by the initials of the person performing the check (in this case Naupaka B Zimmerman). Line breaks in each file are Unix line feeds (\n). The files are:

2011-02-06_OTU_counts_per_tree_QC_NBZ.csv
2011-02-06_site_metadata_QC_NBZ.csv
2011-02-06_tree_metadata_QC_NBZ.csv
2011-02-06_OTU_counts_and_metadata_QC_NBZ.csv



2011-02-06_OTU_counts_per_tree_QC_NBZ.csv
####################################################
This is an OTU count matrix. Numbers are counts of sequences within each fungal Operational Taxonomic Unit (OTU) within each tree. OTUs are based on clustering at 95% ITS1 similarity of environmental sequences amplified with ITS1F and ITS2 and sequenced on a Roche 454 sequencer using Titanium reagents. The sample for each tree was derived from a pool of 10 asymptomatic, surface sterilized leaves. 

Columns include:
================
Tree_ID
    Unique ID for each tree. Can be used to join to metadata.

OTU0001...OTU4583
    Counts of sequences within each OTU, as described above.



2011-02-06_site_metadata_QC_NBZ.csv
##############################################
This file includes environmental metadata for each of the 13 sites sampled.

Columns include:
================
site_ID	
    Unique id for each site.

side_of_island	
    Side of the Island of Hawaii. Can be Wet (windward) or Dry (leeward).

flow_age	
    Age of flow. Can be either young (ca. 100 yrs bp) or old (ca. 3500 years bp).

site_elevation_m	
    Approximate elevation of the site in meters above sea level. Can be used as a categorical variable.

approx_annual_rainfall_mm	
    Approximate annual rainfall of the site in mm/yr.

approx_mean_annual_temp_deg_C	
    Mean annual temperature of the site in degrees C.

flow_type
    Lava flow type. Either aa (clinker-type) or pahoehoe (solid, ropey).




2011-02-06_tree_metadata_QC_NBZ.csv
##############################################
This file includes metadata for each of the 130 trees sampled. All trees are individuals of the Hawaiian endemic tree Metrosideros polymorpha (Myrtaceae).

Columns include:
================
Tree_ID
    Unique ID for each tree. Used to join to OTU matrix.

site_ID
    Unique ID for each site. Can be used to join to site metadata.

date_collected
    Date of field collection as YYYY-MM-DD.

UTM_zone
    Projection.

Easting
    In meters.

Northing
    In meters.

elevation_m
    Field-recorded GPS elevation in meters above sea level for each tree.
    
    
    
2011-02-06_OTU_counts_and_metadata_QC_NBZ.csv
#############################################
This file is the joined combination of all three of the above files and includes both OTU counts as well as all site and tree metadata. The column names and descriptions are as above.
