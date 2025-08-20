# Build the frontend
FROM node:18-alpine AS frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# Build the backend
FROM node:18-alpine AS backend
WORKDIR /app
COPY backend/package*.json ./
RUN npm install --production
COPY backend/ ./

# Copy frontend build to backend static files
COPY --from=frontend-build /app/frontend/dist ./public

EXPOSE 7102

CMD ["npm", "start"]
