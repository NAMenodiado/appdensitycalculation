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
