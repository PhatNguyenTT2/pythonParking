.PHONY: install dev build deploy clean

# Install dependencies
install:
	pip install -r requirements.txt
	cd frontend && npm install

# Run development server
dev:
	python main.py

# Run frontend dev server
dev-frontend:
	cd frontend && npm run dev

# Build frontend
build:
	cd frontend && npm run build

# Deploy to Render
deploy:
	cd frontend && npm run build
	git add .
	git commit -m "Deploy to Render"
	git push

# Clean cache files
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
