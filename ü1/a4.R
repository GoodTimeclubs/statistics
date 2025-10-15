sex <- c("male","female","female","male","male")

#factor
sex <- factor(sex)

#frequency table
table(sex)

#proportion table
prop.table(table(sex))