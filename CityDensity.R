pop = read.csv("population.csv")
area = read.csv("regionarea.csv")


city_den = aggregate(pop$CityProvince,by=list(pop$Region), FUN = unique)
city_den

len = 1:18
for (i in 1:18) {
  len[i] = length(city_den$x[[i]])
}

data = data.frame(city_den$Group.1, len, city_area = area$Area/len)


city_pop = aggregate(pop$Population,by=list(pop$CityProvince), FUN = sum)
city_pop


final = merge(pop, data, by.x = "Region", by.y = "city_den.Group.1", all.x=TRUE)
final = merge(final, city_pop, by.x = "CityProvince", by.y = "Group.1", all.x=TRUE)
final = data.frame(final$Region, final$CityProvince, City_Density = final$x/final$city_area)
final = final[!duplicated(final$final.CityProvince), ]
final = final[order(final$City_Density, decreasing = TRUE), ]
CityDensity = head(final, n=5)
CityDensity

write.csv(CityDensity, file = "CityDensity.csv", row.names = FALSE)
