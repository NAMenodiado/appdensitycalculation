population = read.csv('population.csv')
region = read.csv('regionarea.csv')

pop_region = merge(population, region, by = 'Region',all.x=TRUE)
pop_region

barangay_count = aggregate(pop_region$Barangay,by=list(pop_region$Region),FUN = length)
barangay_count

pop_region_count = merge(pop_region, barangay_count, by.x = 'Region',
                         by.y = 'Group.1',all.x=TRUE)
pop_region_count

pop_region_count$BarangayArea = pop_region_count$Area/pop_region_count$x

pop_region_count$BarangayDensity = pop_region_count$Population/
                                    pop_region_count$BarangayArea

pop_region_count = pop_region_count[order(pop_region_count$BarangayDensity, 
                                          decreasing = TRUE),]
pop_region_count

barangay_density_df = head(select(pop_region_count,Barangay,BarangayDensity), n = 5)
barangay_density_df

write.csv(barangay_density_df, file='barangay_density.csv',row.names=FALSE)