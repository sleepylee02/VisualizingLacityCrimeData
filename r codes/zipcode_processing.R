library(tidyverse);library(data.table);library(dplyr);library(readr)

acs_stat <- read.csv("acs_stat.csv")

areas <- list(
  TOPANGA = c("91304", "91307", "91367", "91364", "91303", "91306"),
  DEVONSHIRE = c("91311", "91324", "91330", "91325", "91343", "91344", "91326"),
  MISSION = c("91342", "91345", "91402", "91340"),
  FOOTHILL = c("91331", "91352", "91042", "91040"),
  WEST_VALLEY = c("91335", "91356", "91316", "91436", "91406"),
  VAN_NUYS = c("91405", "91411", "91403", "91423", "91401"),
  NORTH_HOLLYWOOD = c("91605", "91606", "91607", "91604", "91602", "91601", "91522"),
  WEST_LOS_ANGELES = c("90272", "90049", "90077", "90210", "90095", "90024", "90025", "90064", "90035", "90034", "90067"),
  PACIFIC = c("90232", "90066", "90291", "90094", "90293", "90045"),
  HOLLYWOOD = c("90069", "90046", "90068", "90028", "90038"),
  NORTHEAST = c("90027", "90039", "90065", "90041", "90042"),
  WILSHIRE = c("90048", "90036", "90019"),
  OLYMPIC = c("90004", "90020", "90010", "90005", "90006"),
  RAMPART = c("90029", "90057", "90017", "90026"),
  CENTRAL = c("90071", "90012", "90013", "90014", "90015"),
  HOLLENBECK = c("90031", "90032", "90033", "90063", "90023", "91030"),
  SOUTHWEST = c("90016", "90018", "90007", "90089", "90008", "90062"),
  "77TH_STREET" = c("90043", "90047", "90037", "90044"),
  NEWTON = c("90021", "90011", "90001", "90058"),
  SOUTHEAST = c("90003", "90002", "90059", "90061", "90247", "90248"),
  HARBOR = c("90501", "90710", "90744", "90731", "90732")
)

names(areas) <- gsub("_", " ", names(areas))

zipcodes_data <- data.frame(
  zipcode = unlist(areas)
)

zipcodes_data
acs_stat %>% select(c(ZCTA5A, AQNFE001)) %>% slice(2:n()) %>% head()

zipcodes_data <- zipcodes_data %>%
  rename(ZCTA5A = zipcode) %>%  # Rename `zipcode` to match with `ZCTA5A`
  left_join(acs_stat, by = "ZCTA5A") # Match and join with `acs_stat`

zipcodes_data <- zipcodes_data %>% 
  select(c("ZCTA5A","AQNFE001", "AQNGE002", "AQNGE003", "AQNGE005", "AQP6E001", 
           "AQR8E004", "AQR8E005", "AQR8E007", "AQPKE002", 
           "AQPKE003", "AQPKE004", "AQPKE005", "AQPKE006", "AQPKE007", 
           "AQPKE008", "AQPKE009", "AQPKE010", "AQPKE011", "AQPKE012", 
           "AQPKE013", "AQPKE014", "AQPKE015", "AQPKE016", "AQPKE017", 
           "AQPKE019", "AQPKE020", "AQPKE021", "AQPKE022", "AQPKE023", 
           "AQPKE024", "AQPKE025", "AQPZE002", "AQPZE003", "AQPZE004", 
           "AQPZE005", "AQPZE006", "AQPZE007", "AQPZE008"))

zipcodes_data <- zipcodes_data %>%
  rename(
    zipcode = ZCTA5A,
    total_population = AQNFE001,
    white_population = AQNGE002,
    black_population = AQNGE003,
    asian_population = AQNGE005,
    median_household_income = AQP6E001,
    employed = AQR8E004,
    unemployed = AQR8E005,
    not_in_labor_force = AQR8E007,
    under_elementary_1 = AQPKE002, under_elementary_2 = AQPKE003,
    under_elementary_3 = AQPKE004, under_elementary_4 = AQPKE005,
    under_elementary_5 = AQPKE006, under_elementary_6 = AQPKE007,
    under_elementary_7 = AQPKE008, under_elementary_8 = AQPKE009,
    under_elementary_9 = AQPKE010,
    middle_school_1 = AQPKE011, middle_school_2 = AQPKE012,
    middle_school_3 = AQPKE013,
    high_school_1 = AQPKE014, high_school_2 = AQPKE015,
    high_school_3 = AQPKE016, high_school_4 = AQPKE017,
    over_college_1 = AQPKE019, over_college_2 = AQPKE020,
    over_college_3 = AQPKE021, over_college_4 = AQPKE022,
    over_college_5 = AQPKE023, over_college_6 = AQPKE024,
    over_college_7 = AQPKE025,
    poverty_under_50 = AQPZE002, poverty_50_to_99 = AQPZE003,
    poverty_100_to_124 = AQPZE004, poverty_125_to_149 = AQPZE005,
    poverty_150_to_184 = AQPZE006, poverty_185_to_199 = AQPZE007,
    poverty_200_and_over = AQPZE008
  )

zipcodes_data <- zipcodes_data %>%
  filter(!zipcode %in% c(91522, 91330, 90095, 90071, 90089))

zipcodes_data[] <- apply(zipcodes_data, 2, function(x) as.numeric(as.character(x)))

# 정보들 합쳐주기
zipcodes_data <- zipcodes_data %>%
  mutate(
    across(starts_with("under_elementary"), as.numeric),  # Ensure numeric columns
    across(starts_with("middle_school"), as.numeric),
    across(starts_with("high_school"), as.numeric),
    across(starts_with("over_college"), as.numeric)
  ) %>%
  mutate(
    total_underelementary = rowSums(select(., starts_with("under_elementary")), na.rm = TRUE),
    total_middleschool = rowSums(select(., starts_with("middle_school")), na.rm = TRUE),
    total_highschool = rowSums(select(., starts_with("high_school")), na.rm = TRUE),
    total_overcollege = rowSums(select(., starts_with("over_college")), na.rm = TRUE)
  ) %>%
  select(
    -starts_with("under_elementary"),
    -starts_with("middle_school"),
    -starts_with("high_school"),
    -starts_with("over_college")
  )

area_mapping <- bind_rows(
  lapply(names(areas), function(area) {
    data.frame(AREA.NAME = area, zipcode = (areas[[area]]))
  })
)

area_mapping$zipcode <- area_mapping$zipcode %>% as.numeric()

area_data_intermediate <- zipcodes_data %>%
  inner_join(area_mapping, by = "zipcode") %>%  # Join to map zipcodes to areas
  group_by(AREA.NAME) %>%
  summarise(
    Total_population = sum(total_population, na.rm = TRUE),
    Total_employed = sum(employed, na.rm = TRUE),
    Total_unemployed = sum(unemployed, na.rm = TRUE),
    Total_not_in_labor_force = sum(not_in_labor_force, na.rm = TRUE),
    Total_underelementary = sum(total_underelementary, na.rm = TRUE),
    Total_overcollege = sum(total_overcollege, na.rm = TRUE),
    poverty_under_50 = sum(poverty_under_50, na.rm = TRUE),              
    poverty_50_to_99 = sum(poverty_50_to_99, na.rm = TRUE),
    poverty_100_to_124 = sum(poverty_100_to_124, na.rm = TRUE),
    poverty_125_to_149 = sum(poverty_125_to_149, na.rm = TRUE),
    poverty_150_to_184 = sum(poverty_150_to_184, na.rm = TRUE),
    poverty_185_to_199 = sum(poverty_185_to_199, na.rm = TRUE),
    poverty_200_and_over = sum(poverty_200_and_over, na.rm = TRUE),
    weighted_income_sum = sum(median_household_income * total_population, na.rm = TRUE)
  )

zipcodes_data <- area_data_intermediate %>%
  mutate(median_household_income = as.integer(weighted_income_sum / Total_population)) %>%
  select(-starts_with("weighted_"))  # Remove intermediate weighted sum columns

zipcodes_final <- zipcodes_data %>% rename("AREA NAME" = AREA.NAME)

write_csv(zipcodes_final,"zipcodes_final.csv")
