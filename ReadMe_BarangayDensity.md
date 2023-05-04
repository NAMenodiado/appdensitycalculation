#### Combining the Population and Region CSVs

`pop_region = merge(population, region, by = 'Region',all.x=TRUE)`

This code merges the *population* and *region* CSVs through their mutual attribute 'Region'.

#### Count of Barangays per Region

`barangay_count = aggregate(pop_region$Barangay,by=list(pop_region$Region),FUN = length)`

This creates a new DataFrame summarizing the total number of barangays per region.

#### Combining the Barangay DataFrame with the Main Dataset

`pop_region_count = merge(pop_region, barangay_count, by.x = 'Region',                          by.y = 'Group.1',all.x=TRUE)`

This code merges the newly-formed *barangay_count* DataFrame with *pop_region*.

#### Calculating the Barangay Area and Barangay Density

`pop_region_count$BarangayArea = pop_region_count$Area/pop_region_count$x`

`pop_region_count$BarangayDensity = pop_region_count$Population/                                     pop_region_count$BarangayArea`

The first line of code adds a new column BarangayArea which calculates for the area of each barangay by dividing the area of the region that the barangay belongs to by the total number of barangays in that region.

Afterwards, the second line of code then adds a new column BarangayDensity which calculates the density of each barangay by dividing that barangay's population by that barangay's area.

#### Getting the Top 5 Barangays with the Highest Densities

`pop_region_count = pop_region_count[order(pop_region_count$BarangayDensity,                                            decreasing = TRUE),]`

`barangay_density_df = head(select(pop_region_count,Barangay,BarangayDensity), n = 5)`

After finding the density of each barangay, the first line of code orders the DataFrame by decreasing density.

In line with this, the next line of code then creates a new DataFrame which selects only the rows with the top 5 highest barangay densities, as well as disregards the other attributes that are unrelated to the main problem being discussed.

#### Output into CSV

`write.csv(barangay_density_df, file='barangay_density.csv',row.names=FALSE)`

Finally, this turns the *barangay_density_df* DataFrame into a CSV which will be saved in the working directory.