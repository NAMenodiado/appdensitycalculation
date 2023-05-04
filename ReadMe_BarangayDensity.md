# Barangay Density

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

# City Density

`pop = read.csv("population.csv") area = read.csv("regionarea.csv") city_den = aggregate(pop$CityProvince,by=list(pop$Region), FUN = unique) city_den`

-   The code creates an aggregated table that lists down the different unique cities for each region.

`len = 1:18 for (i in 1:18) { len[i] = length(city_den\$x[[i]]) } data = data.frame(city_den$Group.1, len, city_area = area$Area/len)`

-   A for loop was created to be able to count the number of cities that each region have. The result was then used to calculate the area of each city. The resulting data frame shows the Region Name, Number of Cities, and the approximate area of each city in the region.

`city_pop = aggregate(pop$Population,by=list(pop$CityProvince), FUN = sum) city_pop`

-   Another aggregate table was created to be able to get the total number of people in each city.

`final = merge(pop, data, by.x = "Region", by.y = "city_den.Group.1", all.x=TRUE)  final = merge(final, city_pop, by.x = "CityProvince", by.y = "Group.1", all.x=TRUE)`

-   The table 'data' merged with the table 'pop' while matching their corresponding columns as stated by the "by.x" and "by.y" statements. The result is the calculated city area being appended according to the city.
-   The second merge statement was used to be able to append the corresponding sum of the population corresponding to each city.

`final = data.frame(final$Region, final$CityProvince, City_Density = final$x/final$city_area)`

-   A data frame was created consisting of the Region, City, and the calculated City Density.

`final = final[!duplicated(final$final.CityProvince), ] final = final[order(final$City_Density, decreasing = TRUE), ] CityDensity = head(final, n=5)`

-   Duplicating cities are removed since the population and city area stays the same. The duplicates are due to the merges done and the number of barangays under that city. With this, the top populous cities in the Philippines are Quezon City, City of Manila, Caloocan City, Taguig City, and City of Pasig!
