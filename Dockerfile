FROM node:alpine

WORKDIR '/app'

COPY package.json ./

RUN npm install

#production 환경에서는 코드 변경하지 않으므로 바로 copy
COPY ./ ./ 

RUN npm run build

# /app/build <-- container의 해당 dir 에 소스코드 담긴다.

#second from statement => block 나뉜다.
FROM nginx
EXPOSE 80 
# aws elastic beanstalk의 경우 EXPOSE를 보고 port mapping 한다.

# --from=0은 위의 block의미한다.

COPY --from=0 /app/build /usr/share/nginx/html

# start nginx
# nginx 이미지가 start는 자동으로한다.


