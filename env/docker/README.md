## Docker環境建置

##### 步驟要點

1. war檔必須與tomcat(docker)環境相同，Tomcat7 + JRE8
2. 不必預先建立所有的volume目錄（例如：mysql/data）
3. docker啟動前，必須先create tcs schema and import data

##### 若tomcat啟動失敗，可試試以下方式
- docker-compose down + up
- rm web app and redeploy
- logs

