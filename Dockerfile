# Build the frontend
FROM node:20-alpine AS frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# Build the backend
FROM node:20-alpine AS backend
WORKDIR /app
COPY backend/package*.json ./
RUN npm install --production
COPY backend/ ./

# Copy frontend build to backend static files
COPY --from=frontend-build /app/frontend/dist ./public

# Set environment to production
ENV NODE_ENV=production

EXPOSE 7102

CMD ["npm", "start"]
