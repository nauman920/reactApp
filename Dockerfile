# Stage 1: Build the React app
FROM node:20-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# Stage 2: Create the production image
FROM node:20-alpine
WORKDIR /frontend
COPY --from=builder /app/build /frontend/build
RUN npm install serve -g
EXPOSE 3000
CMD ["serve", "-s", "build"]  