### 데이터 출처 ### <<~\data\raw data>>
1. Crime 데이터 가져오기
  <- Crime_Data_from_2020_to_Present.csv

https://catalog.data.gov/dataset/crime-data-from-2020-to-present
그중 2023년 데이터만 따로 가져왔는데, 용량 문제로 인해 따로 첨부하지 않았습니다.

2. Police station, sheriff 데이터
  <- Sheriff_and_Police_Stations.csv

https://geohub.lacity.org/datasets/lacounty::sheriff-and-police-stations/explore
파일 첨부가 되어있습니다.

3. ACS 데이터
  <- acs_stat.csv

https://data.census.gov/all?q=acs
파일 첨부가 되어있습니다.

4. boundary (LAPD Divisons)
  <- LAPD_Div folder

https://geohub.lacity.org/datasets/lapd-divisions/explore?location=33.580405%2C-118.120395%2C9.93
파일 첨부가 되어있습니다.

5. Zipcode
  <- Los_Angeles_City_Zip_Codes folder

https://visionzero.geohub.lacity.org/datasets/los-angeles-city-zip-codes/explore
파일 첨부가 되어있습니다.

-----------------------------------------------------------------------------------

### 코드 실행 방법, 순서 ###
1. data_prep.R 파일 실행 (데이터 전처리)
    ㄴ Crime_data를 제외한 모든 파일이 첨부되어 있습니다.
    ㄴ 전처리 후에 만들어진 파일(.rds)들도 첨부하였습니다. 따로 실행할 필요는 없습니다.

2. ModelTrain.R 파일 실행 (로지스틱 등 머신러닝 모델)
    ㄴ 학습 시간이 다소 걸릴 수 있습니다.
    ㄴ 학습된 후 예측값에 관한 파일(.rds)을 첨부하였습니다.

3. ModelPrediction.R 파일 실행 (웹 배포를 위해 모든 입력에 대한 예측치만 따로 만드는 파일)
    ㄴ 코드 실행 후 all_predictions.rds 파일이 생성됩니다.

4. app.R 실행
    ㄴ 필요한 파일은 다음과 같습니다.
       1) CD.rds
       2) Geo_CD.rds
       3) Mosaic_CD.rds
       4) all_predictions.rds
       5) Sheriff_and_Police_Stations.csv
       6) zipcodes_final.csv
    **** 1 ~ 3번 r 코드 실행 없이 첨부된 파일로 충분히 실행될 수 있습니다. ****

<추가 코드>
1. zipcode_processing.R
Crime_Data_from_2020_to_Present.csv에 있는 지역과 acs_stat.csv에 해당하는 지역을 호환시키고 이를 바탕으로 acs_stat.csv에 들어 있는 다양한 지표를 연결합니다.
이 코드를 실행하면 zipcodes_final.csv 파일이 만들어집니다.

2. zipcode_district_visualization.R
발표 자료로 사용되는 코드입니다. <추가 코드> 1에서 어떤 노력이 있었는지 표시하는 코드입니다.
(해당 발표 자료): ~\presentation\divide_map_to_zipcode

-----------------------------------------------------------------------------------

Shinyapp 사용 방법은 따로 첨부해두었습니다.
