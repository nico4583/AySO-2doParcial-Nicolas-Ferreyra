mkdir -p AppHomeBanking
echo "<html><body><h1>Bienvenido al Home Banking</h1></body></html>" > appHomeBanking/index.html
echo "<html><body><h1>Contacto</h1></body></html>" > appHomeBanking/contacto.html
vim dockerfile
FROM nginx:latest
COPY /appHomeBanking /usr/share/nginx/html
docker login -u nico3863
docker build -t nico3863/2parcial-ayso:v1.0 .
docker image list
docker push nico3863/2parcial-ayso:v1.0
docker run -d -p 80:80 nico3863/2parcial-ayso:v1.0
docker container ls
http://192.168.56.8:80/index.html
http://192.168.56.8:80/contacto.html

#docker hub: nico3863/2parcial-ayso:v1.0
